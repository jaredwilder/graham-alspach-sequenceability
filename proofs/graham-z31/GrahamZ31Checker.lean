/-
GrahamZ31Checker.lean

Packed certificate-checker pipeline for the Graham/Alspach rearrangement conjecture in `Z_31`,
per `erdosfire/evidence/round4-discovery/graham-z31/witnesses.tsv` and the ERDŐSFIRE-FERRARI
architecture doc's packed-witness / one-checker / one-soundness-theorem pattern. This is a
Z_31-specific mirror of `public/proofs/graham-z29/GrahamZ29Checker.lean` (`29 -> 31`,
`28 -> 30` throughout -- `Z_31 \ {0}` has 30 elements, one more bit than `Z_29 \ {0}`'s 28, but
still well within a single `UInt32` machine word): rather than formalizing each of the
certificate's 765,548 canonical-orbit witnesses (sizes 21-30) as its own theorem, we formalize
ONE generic certificate checker as a pure Lean function, prove ONE soundness theorem about it
(`GrahamZ31Sound.lean`), and then every concrete witness becomes a `native_decide`-checkable
Boolean evaluation of that same function. The theorem count stays constant no matter how many
witnesses the corpus has.

Statement (same "Statement" as `Z_29`'s, instantiated at `Z_31`): for a finite subset `A` of an
abelian group, call an ordering `a_1,...,a_m` a SEQUENCING when the partial sums
`s_i = sum_{j=1}^i a_j` are pairwise distinct and `s_i ≠ 0` for `1 ≤ i < m`. Note the final sum
`s_m` is explicitly NOT required to be nonzero (it is forced to be `0` exactly when `A` is the
full nonzero group, since `sum_{x in Z_31 \ {0}} x = 465 ≡ 0 (mod 31)`) -- pairwise distinctness
is still required of the full list of `m` sums, including `s_m`.

Every function below is pure, total, and touches no filesystem/IO -- a bounded Boolean evaluator
meant to be invoked once per witness via `native_decide`, never re-proved per witness.
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

set_option linter.style.nativeDecide false

namespace GrahamZ31

/-! ## 1. Packed witness type (ERDŐSFIRE-FERRARI §3.1)

Both fields are machine-word-sized: no `List (Fin 31)`, no `Finset` literal, no `List Prop`
anywhere in the ENCODING of a witness (decoding into those richer types happens once, in the
checker pipeline below, not in the packed representation itself). -/

/-- A packed certificate-witness record, mirroring one row of
`erdosfire/evidence/round4-discovery/graham-z31/witnesses.tsv`:
* `subsetMask` -- a 30-bit mask over `{1,...,30}` (bit `i`, `0 ≤ i < 30`, set means residue
  `i + 1` is a member of the subset). Fits in a `UInt32` (single machine word; 30 ≤ 32).
* `ordering` -- the claimed sequencing, packed as raw residues `1..30`, each fitting in a
  byte, in the exact order the certificate claims sequences the subset. -/
structure PackedWitness where
  subsetMask : UInt32
  ordering   : Array UInt8
deriving Repr

/-! ## 2. Checker pipeline (ERDŐSFIRE-FERRARI §3.2)

Pure, total, no exceptions, no filesystem IO -- every function here is a plain computable
function on packed/primitive data, composing up to a single `Bool`. -/

/-- Decode a packed 30-bit mask into the `Finset (ZMod 31)` it represents: bit `i`
(`0 ≤ i < 30`) set means residue `i + 1` is a member. -/
def decodeSubset (mask : UInt32) : Finset (ZMod 31) :=
  ((Finset.range 30).filter (fun i => mask.toNat.testBit i = true)).image
    (fun i => ((i + 1 : ℕ) : ZMod 31))

/-- Decode a packed ordering (raw bytes, each in `1..30`) into a `List (ZMod 31)`. -/
def decodeOrdering (packed : Array UInt8) : List (ZMod 31) :=
  packed.toList.map (fun b => (b.toNat : ZMod 31))

/-- `true` iff `ordering` enumerates exactly the elements of `subset`, each exactly once
(no repeats, no omissions, no extras). -/
def orderingMatchesSubset (subset : Finset (ZMod 31)) (ordering : List (ZMod 31)) : Bool :=
  decide (ordering.toFinset = subset) && decide ordering.Nodup

/-- The partial sums `[s_1, ..., s_m]` of `ordering`, per the "Statement" section above:
built on Batteries' `List.partialSums` (`l.partialSums = [0, s_1, ..., s_m]`, seeded with the
empty sum), dropping the leading seed `0`. Using the library primitive (rather than a
hand-rolled accumulator) means the index lemmas needed for the soundness proof
(`List.getElem_partialSums`, `List.length_partialSums`) already exist and are already proven. -/
def partialSums (ordering : List (ZMod 31)) : List (ZMod 31) :=
  ordering.partialSums.drop 1

/-- `true` iff every partial sum EXCEPT POSSIBLY THE LAST is nonzero -- i.e. `s_i ≠ 0` for
`1 ≤ i < m`. The last sum `s_m` is deliberately excluded (see the module docstring: it is
forced to be `0` for the full-set witness). -/
def properPartialSumsNonzero (sums : List (ZMod 31)) : Bool :=
  sums.dropLast.all (fun s => decide (s ≠ 0))

/-- `true` iff ALL partial sums (including the last, `s_m`) are pairwise distinct. -/
def partialSumsDistinct (sums : List (ZMod 31)) : Bool :=
  decide sums.Nodup

/-- The full certificate checker for one packed witness: decode, confirm the ordering is
exactly a permutation of the claimed subset, then validate both partial-sum conditions from
the "Statement" section. Composes the pipeline above into a single Boolean -- this is the ONE
function every witness in the corpus (60,134 for `Z_29`, 765,548 for `Z_31`) is checked
against via `native_decide`, never re-proved per witness. -/
def checkWitness (w : PackedWitness) : Bool :=
  let subset := decodeSubset w.subsetMask
  let ordering := decodeOrdering w.ordering
  let sums := partialSums ordering
  orderingMatchesSubset subset ordering && properPartialSumsNonzero sums && partialSumsDistinct sums

end GrahamZ31
