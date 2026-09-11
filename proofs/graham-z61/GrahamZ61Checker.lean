/-
GrahamZ61Checker.lean

Packed certificate-checker pipeline for the Graham/Alspach rearrangement conjecture in `Z_61`,
per `erdosfire/evidence/round4-discovery/graham-z61/witnesses.tsv` and the ERDŐSFIRE-FERRARI
architecture doc's packed-witness / one-checker / one-soundness-theorem pattern. This is a
Z_61-specific mirror of `public/proofs/graham-z47/GrahamZ47Checker.lean` (`47 -> 61`,
`46 -> 60` throughout for the modulus/domain size) -- no other change (Z_59 never reached Lean
formalization, per `oracle/RUNBOOK.md`'s Z_59 write-up, so Z_47's is the most recent precedent to
mirror). `subsetMask` is `UInt64` for the same reason it was in the Z_47 checker (not a new
consideration here): `Z_61 \ {0}` has 60 elements, which EXCEEDS a `UInt32`'s 32-bit capacity
(unlike `Z_29`'s 28 and `Z_31`'s 30), so `UInt64` (safe up to 63 bits) is required, exactly as it
already was for `Z_37`'s 36, `Z_41`'s 40, `Z_43`'s 42, and `Z_47`'s 46.

This certificate covers sizes 56 through 60 ONLY (NOT the full 21-60 range: sizes 21-55 of Z_61
remain unclassified, judged combinatorially infeasible for one overnight run -- see this
directory's evidence trail, `erdosfire/evidence/round4-discovery/graham-z61/generator-summary.json`,
`minimumSize: 56, maximumSize: 60`). The certificate/checker/soundness-theorem machinery below
does not know or care about that scoping -- it proves sequenceability for whatever subsets the
corpus's packed witnesses actually decode to, honestly scoped by whichever masks are fed in.

Real operational note specific to this prime (disclosed here, not hidden): the real generation run
against sizes 56-60 initially left exactly 2 of 8738 orbit representatives unresolved -- the
size-59 canonical representative and the size-60 full set `Z_61 \ {0}` itself (a `native_decide`-
irrelevant detail of the SEARCH heuristic used to find witnesses, not of what a witness IS or how
it is checked/proved sound below; see `erdosfire/oracle/tools/frontier-math/round4/graham-z61/
generate_witnesses.cpp`'s "SALVAGE PASS" comment and `erdosfire/evidence/round4-discovery/
graham-z61/hard-case-retry-results.json` for that diagnosis and fix). The certificate this file's
witnesses are drawn from is the complete, re-verified, salvaged one (`witnesses.tsv`, sha256
`747bb14572f168dfda6d107b126826787316d9f405193c2d60ba0388018d6a9b`) -- both the size-59 and
size-60 rows are present and pass every check below exactly like every other row.

Rather than formalizing each of the certificate's canonical-orbit witnesses (sizes 56-60)
individually as its own theorem, we formalize ONE generic certificate checker as a pure Lean
function, prove ONE soundness theorem about it (`GrahamZ61Sound.lean`), and then every concrete
witness becomes a `native_decide`-checkable Boolean evaluation of that same function. The theorem
count stays constant no matter how many witnesses the corpus has.

Statement (same "Statement" as `Z_29`'s, `Z_31`'s, `Z_37`'s, `Z_41`'s, `Z_43`'s, and `Z_47`'s,
instantiated at `Z_61`): for a finite subset `A` of an abelian group, call an ordering
`a_1,...,a_m` a SEQUENCING when the partial sums `s_i = sum_{j=1}^i a_j` are pairwise distinct and
`s_i ≠ 0` for `1 ≤ i < m`. Note the final sum `s_m` is explicitly NOT required to be nonzero (it
is forced to be `0` exactly when `A` is the full nonzero group, since
`sum_{x in Z_61 \ {0}} x = 1830 ≡ 0 (mod 61)`, independently confirmed via `sum(range(1,61)) = 1830
= 61 * 30`) -- pairwise distinctness is still required of the full list of `m` sums, including
`s_m`.

Every function below is pure, total, and touches no filesystem/IO -- a bounded Boolean evaluator
meant to be invoked once per witness via `native_decide`, never re-proved per witness.
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

set_option linter.style.nativeDecide false

namespace GrahamZ61

/-! ## 1. Packed witness type (ERDŐSFIRE-FERRARI §3.1)

Both fields are machine-word-sized: no `List (Fin 61)`, no `Finset` literal, no `List Prop`
anywhere in the ENCODING of a witness (decoding into those richer types happens once, in the
checker pipeline below, not in the packed representation itself). -/

/-- A packed certificate-witness record, mirroring one row of
`erdosfire/evidence/round4-discovery/graham-z61/witnesses.tsv`:
* `subsetMask` -- a 60-bit mask over `{1,...,60}` (bit `i`, `0 ≤ i < 60`, set means residue
  `i + 1` is a member of the subset). Needs `UInt64` (NOT `UInt32` -- 60 > 32, same width
  boundary the Z_37 checker already crossed).
* `ordering` -- the claimed sequencing, packed as raw residues `1..60`, each fitting in a
  byte, in the exact order the certificate claims sequences the subset. -/
structure PackedWitness where
  subsetMask : UInt64
  ordering   : Array UInt8
deriving Repr

/-! ## 2. Checker pipeline (ERDŐSFIRE-FERRARI §3.2)

Pure, total, no exceptions, no filesystem IO -- every function here is a plain computable
function on packed/primitive data, composing up to a single `Bool`. -/

/-- Decode a packed 60-bit mask into the `Finset (ZMod 61)` it represents: bit `i`
(`0 ≤ i < 60`) set means residue `i + 1` is a member. -/
def decodeSubset (mask : UInt64) : Finset (ZMod 61) :=
  ((Finset.range 60).filter (fun i => mask.toNat.testBit i = true)).image
    (fun i => ((i + 1 : ℕ) : ZMod 61))

/-- Decode a packed ordering (raw bytes, each in `1..60`) into a `List (ZMod 61)`. -/
def decodeOrdering (packed : Array UInt8) : List (ZMod 61) :=
  packed.toList.map (fun b => (b.toNat : ZMod 61))

/-- `true` iff `ordering` enumerates exactly the elements of `subset`, each exactly once
(no repeats, no omissions, no extras). -/
def orderingMatchesSubset (subset : Finset (ZMod 61)) (ordering : List (ZMod 61)) : Bool :=
  decide (ordering.toFinset = subset) && decide ordering.Nodup

/-- The partial sums `[s_1, ..., s_m]` of `ordering`, per the "Statement" section above:
built on Batteries' `List.partialSums` (`l.partialSums = [0, s_1, ..., s_m]`, seeded with the
empty sum), dropping the leading seed `0`. Using the library primitive (rather than a
hand-rolled accumulator) means the index lemmas needed for the soundness proof
(`List.getElem_partialSums`, `List.length_partialSums`) already exist and are already proven. -/
def partialSums (ordering : List (ZMod 61)) : List (ZMod 61) :=
  ordering.partialSums.drop 1

/-- `true` iff every partial sum EXCEPT POSSIBLY THE LAST is nonzero -- i.e. `s_i ≠ 0` for
`1 ≤ i < m`. The last sum `s_m` is deliberately excluded (see the module docstring: it is
forced to be `0` for the full-set witness). -/
def properPartialSumsNonzero (sums : List (ZMod 61)) : Bool :=
  sums.dropLast.all (fun s => decide (s ≠ 0))

/-- `true` iff ALL partial sums (including the last, `s_m`) are pairwise distinct. -/
def partialSumsDistinct (sums : List (ZMod 61)) : Bool :=
  decide sums.Nodup

/-- The full certificate checker for one packed witness: decode, confirm the ordering is
exactly a permutation of the claimed subset, then validate both partial-sum conditions from
the "Statement" section. Composes the pipeline above into a single Boolean -- this is the ONE
function every witness in the corpus (sizes 56-60) is checked against via `native_decide`,
never re-proved per witness. -/
def checkWitness (w : PackedWitness) : Bool :=
  let subset := decodeSubset w.subsetMask
  let ordering := decodeOrdering w.ordering
  let sums := partialSums ordering
  orderingMatchesSubset subset ordering && properPartialSumsNonzero sums && partialSumsDistinct sums

end GrahamZ61
