/-
GrahamChecker.lean

Packed certificate-checker pipeline for the Graham/Alspach rearrangement conjecture,
GENERALIZED over an arbitrary prime `p`. `public/proofs/graham-z29/GrahamZ29Checker.lean` and
`public/proofs/graham-z31/GrahamZ31Checker.lean` are structurally IDENTICAL mirrors of one
another, differing only in the hardcoded modulus (`29` vs `31`) and the associated bit-width
(`28` vs `30`, i.e. `p - 1` in both cases). This file merges them into ONE checker, parametric
in `p : ℕ` with `[Fact p.Prime]` carried as an explicit hypothesis on every definition -- so a
single checker (plus one soundness theorem in `GrahamSound.lean`) serves `Z_29`, `Z_31`, and any
future prime, instead of a hand-copied file per prime.

`[Fact p.Prime]` is threaded through even though (as `GrahamZ31Checker.lean`'s own module
docstring already observed of its mirrored lemmas) none of the individual definitions below
actually consume primality in their bodies -- `ZMod p` has decidable equality and the needed
`Finset`/`List` operations for every `p : ℕ`, prime or not. It is carried anyway because it is
part of the paper's actual theorem scope ("Every subset A ⊆ Z_p \ {0} is sequenceable" is a
statement about prime moduli), and because `p - 1` (the bit-width below) is only the correct size
of `Z_p \ {0}` when `p ≥ 1`, which `Fact p.Prime` guarantees.

Statement (identical to both `Z_29`'s and `Z_31`'s "Statement" section, now stated once for
general `p`): for a finite subset `A` of `ZMod p`, call an ordering `a_1,...,a_m` a SEQUENCING
when the partial sums `s_i = sum_{j=1}^i a_j` are pairwise distinct and `s_i ≠ 0` for
`1 ≤ i < m`. The final sum `s_m` is explicitly NOT required to be nonzero (it is forced to be `0`
exactly when `A` is the full nonzero group `ZMod p \ {0}`, since `sum_{x in Z_p \ {0}} x` is
always `0` mod `p` for odd primes `p`) -- pairwise distinctness is still required of the full
list of `m` sums, including `s_m`.

`PackedWitness` carries NO dependence on `p` at all: a 32-bit mask plus a byte-array ordering is
a prime-independent ENCODING (only its DECODING, via `decodeSubset`/`decodeOrdering` below, is
parametrized by which `ZMod p` it targets) -- one witness type now serves every prime, not one
struct per file. The mask is only guaranteed to fit a `UInt32` while `p - 1 ≤ 32`, i.e. `p ≤ 33`
-- true of both `29` and `31`.

Every function below is pure, total, and touches no filesystem/IO -- a bounded Boolean evaluator
meant to be invoked once per witness via `native_decide`, never re-proved per witness.
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

set_option linter.style.nativeDecide false

namespace GrahamGeneral

/-! ## 1. Packed witness type (prime-independent) -/

/-- A packed certificate-witness record, mirroring one row of a `witnesses.tsv` corpus for
whichever prime `p` it is later decoded against:
* `subsetMask` -- a `(p-1)`-bit mask over `{1,...,p-1}` (bit `i`, `0 ≤ i < p - 1`, set means
  residue `i + 1` is a member of the subset). Fits in a `UInt32` (single machine word) for any
  `p ≤ 33`.
* `ordering` -- the claimed sequencing, packed as raw residues `1..p-1`, each fitting in a byte,
  in the exact order the certificate claims sequences the subset.

This struct does not mention `p` -- it is the SAME encoding for every prime; only the decode
functions below are prime-parametric. -/
structure PackedWitness where
  subsetMask : UInt32
  ordering   : Array UInt8
deriving Repr

/-! ## 2. Checker pipeline, parametric in `p` (ERDŐSFIRE-FERRARI §3.2, generalized) -/

/-- Decode a packed `(p-1)`-bit mask into the `Finset (ZMod p)` it represents: bit `i`
(`0 ≤ i < p - 1`) set means residue `i + 1` is a member. -/
def decodeSubset (p : ℕ) [Fact p.Prime] (mask : UInt32) : Finset (ZMod p) :=
  ((Finset.range (p - 1)).filter (fun i => mask.toNat.testBit i = true)).image
    (fun i => ((i + 1 : ℕ) : ZMod p))

/-- Decode a packed ordering (raw bytes, each in `1..p-1`) into a `List (ZMod p)`. -/
def decodeOrdering (p : ℕ) [Fact p.Prime] (packed : Array UInt8) : List (ZMod p) :=
  packed.toList.map (fun b => (b.toNat : ZMod p))

/-- `true` iff `ordering` enumerates exactly the elements of `subset`, each exactly once
(no repeats, no omissions, no extras). -/
def orderingMatchesSubset (p : ℕ) [Fact p.Prime] (subset : Finset (ZMod p))
    (ordering : List (ZMod p)) : Bool :=
  decide (ordering.toFinset = subset) && decide ordering.Nodup

/-- The partial sums `[s_1, ..., s_m]` of `ordering`, per the "Statement" section above: built
on Batteries' `List.partialSums` (`l.partialSums = [0, s_1, ..., s_m]`, seeded with the empty
sum), dropping the leading seed `0`. Using the library primitive (rather than a hand-rolled
accumulator) means the index lemmas needed for the soundness proof
(`List.getElem_partialSums`, `List.length_partialSums`) already exist and are already proven. -/
def partialSums (p : ℕ) [Fact p.Prime] (ordering : List (ZMod p)) : List (ZMod p) :=
  ordering.partialSums.drop 1

/-- `true` iff every partial sum EXCEPT POSSIBLY THE LAST is nonzero -- i.e. `s_i ≠ 0` for
`1 ≤ i < m`. The last sum `s_m` is deliberately excluded (see the module docstring: it is
forced to be `0` for the full-set witness). -/
def properPartialSumsNonzero (p : ℕ) [Fact p.Prime] (sums : List (ZMod p)) : Bool :=
  sums.dropLast.all (fun s => decide (s ≠ 0))

/-- `true` iff ALL partial sums (including the last, `s_m`) are pairwise distinct. -/
def partialSumsDistinct (p : ℕ) [Fact p.Prime] (sums : List (ZMod p)) : Bool :=
  decide sums.Nodup

/-- The full certificate checker for one packed witness at modulus `p`: decode, confirm the
ordering is exactly a permutation of the claimed subset, then validate both partial-sum
conditions from the "Statement" section. Composes the pipeline above into a single Boolean --
this is the ONE function every witness for every prime's corpus is checked against via
`native_decide`, never re-proved per witness, and never re-defined per prime. -/
def checkWitness (p : ℕ) [Fact p.Prime] (w : PackedWitness) : Bool :=
  let subset := decodeSubset p w.subsetMask
  let ordering := decodeOrdering p w.ordering
  let sums := partialSums p ordering
  orderingMatchesSubset p subset ordering && properPartialSumsNonzero p sums &&
    partialSumsDistinct p sums

end GrahamGeneral
