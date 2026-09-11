/-
GrahamZ29Verify.lean

Acceptance test: specializes the GENERALIZED checker/soundness pair (`GrahamChecker.lean`,
`GrahamSound.lean`, both parametric in `p : ℕ` with `[Fact p.Prime]`) to `p = 29`, and re-runs
the exact same 8 real witnesses transcribed in `public/proofs/graham-z29/GrahamZ29Sample.lean`
(one per subset cardinality, 21 through 28) against it. Every `subsetMask`/`ordering` literal
below is copied verbatim from `GrahamZ29Sample.lean` -- this file changes NOTHING about the data,
only routes it through `GrahamGeneral.checkWitness 29` / `GrahamGeneral.checkWitness_sound 29`
instead of the hardcoded `GrahamZ29.checkWitness` / `GrahamZ29.checkWitness_sound`.

Purpose: confirm the generalization is not merely well-typed in isolation, but reproduces the
ORIGINAL `Z_29` result exactly -- same witnesses accepted, same `Sequenceable` conclusion, and
(checked via the `#print axioms` lines at the end) the same trust footprint: the 3 standard
axioms (`propext`, `Classical.choice`, `Quot.sound`) plus exactly one `native_decide` axiom per
witness, with routing through the soundness theorem adding nothing beyond that.
-/
import GrahamChecker
import GrahamSound

namespace GrahamGeneral.Z29Verify

set_option linter.style.nativeDecide false

/-- `29` is prime -- the single fact needed to instantiate the general checker/soundness pair
at `p = 29`. Proved by `norm_num`'s primality certificate, not `native_decide` or `decide`: this
must not itself inflate the axiom footprint measured below. -/
instance factPrime29 : Fact (Nat.Prime 29) := ⟨by norm_num⟩

/-! ## The 8 real witnesses (one per size 21-28), copied verbatim from
`public/proofs/graham-z29/GrahamZ29Sample.lean` -/

/-- size 21, mask `0x01fffff`, subset `{1,...,21}`, tsv `total = 28`. -/
def w21 : PackedWitness where
  subsetMask := 0x01fffff
  ordering := #[5, 2, 7, 17, 4, 6, 18, 15, 21, 1, 14, 19, 11, 3, 13, 9, 12, 16, 20, 8, 10]

/-- size 22, mask `0x03fffff`, subset `{1,...,22}`, tsv `total = 21`. -/
def w22 : PackedWitness where
  subsetMask := 0x03fffff
  ordering := #[5, 2, 4, 1, 12, 11, 7, 20, 6, 18, 3, 21, 15, 17, 19, 9, 22, 14, 16, 8, 10, 13]

/-- size 23, mask `0x07fffff`, subset `{1,...,23}`, tsv `total = 15`. -/
def w23 : PackedWitness where
  subsetMask := 0x07fffff
  ordering := #[4, 2, 1, 11, 14, 18, 13, 17, 15, 12, 19, 6, 22, 10, 7, 20, 8, 5, 23, 16, 3, 9, 21]

/-- size 24, mask `0x0ffffff`, subset `{1,...,24}`, tsv `total = 10`. -/
def w24 : PackedWitness where
  subsetMask := 0x0ffffff
  ordering :=
    #[3, 2, 12, 14, 4, 1, 21, 9, 22, 8, 24, 16, 20, 11, 23, 10, 15, 13, 17, 5, 6, 19, 7, 18]

/-- size 25, mask `0x1ffffff`, subset `{1,...,25}`, tsv `total = 6`. -/
def w25 : PackedWitness where
  subsetMask := 0x1ffffff
  ordering :=
    #[2, 3, 13, 8, 1, 18, 21, 20, 14, 11, 16, 4, 24, 9, 17, 15, 10, 22, 5, 19, 23, 7, 25, 6, 12]

/-- size 26, mask `0x3ffffff`, subset `{1,...,26}`, tsv `total = 3`. -/
def w26 : PackedWitness where
  subsetMask := 0x3ffffff
  ordering := #[21, 4, 26, 15, 23, 8, 20, 13, 3, 10, 6, 2, 17, 25, 7, 18, 5, 22, 11, 16, 1, 24, 9,
    12, 19, 14]

/-- size 27 (the unique canonical representative for this size), mask `0x7ffffff`, subset
`{1,...,27}`, tsv `total = 1`. -/
def w27 : PackedWitness where
  subsetMask := 0x7ffffff
  ordering := #[23, 11, 22, 16, 14, 19, 17, 13, 25, 9, 7, 10, 24, 26, 6, 3, 8, 4, 20, 1, 5, 15, 18,
    12, 2, 21, 27]

/-- size 28 (the unique canonical representative -- the full nonzero group `Z_29 \ {0}`), mask
`0xfffffff`, tsv `total = 0`: the forced full-set zero-final-sum case. -/
def w28 : PackedWitness where
  subsetMask := 0xfffffff
  ordering := #[23, 3, 13, 21, 6, 10, 24, 19, 17, 16, 9, 5, 20, 2, 14, 12, 27, 25, 28, 18, 22, 15,
    26, 8, 11, 7, 1, 4]

/-! ## Step 1: the GENERALIZED checker, specialized at `p = 29`, accepts every one of them -/

theorem w21_checks : checkWitness 29 w21 = true := by native_decide
theorem w22_checks : checkWitness 29 w22 = true := by native_decide
theorem w23_checks : checkWitness 29 w23 = true := by native_decide
theorem w24_checks : checkWitness 29 w24 = true := by native_decide
theorem w25_checks : checkWitness 29 w25 = true := by native_decide
theorem w26_checks : checkWitness 29 w26 = true := by native_decide
theorem w27_checks : checkWitness 29 w27 = true := by native_decide
theorem w28_checks : checkWitness 29 w28 = true := by native_decide

/-! ## Step 2: the ONE generalized soundness theorem, specialized at `p = 29`, turns each into a
genuine `Sequenceable` proof -/

theorem w21_sequenceable : Sequenceable 29 (decodeSubset 29 w21.subsetMask) :=
  checkWitness_sound 29 w21 w21_checks
theorem w22_sequenceable : Sequenceable 29 (decodeSubset 29 w22.subsetMask) :=
  checkWitness_sound 29 w22 w22_checks
theorem w23_sequenceable : Sequenceable 29 (decodeSubset 29 w23.subsetMask) :=
  checkWitness_sound 29 w23 w23_checks
theorem w24_sequenceable : Sequenceable 29 (decodeSubset 29 w24.subsetMask) :=
  checkWitness_sound 29 w24 w24_checks
theorem w25_sequenceable : Sequenceable 29 (decodeSubset 29 w25.subsetMask) :=
  checkWitness_sound 29 w25 w25_checks
theorem w26_sequenceable : Sequenceable 29 (decodeSubset 29 w26.subsetMask) :=
  checkWitness_sound 29 w26 w26_checks
theorem w27_sequenceable : Sequenceable 29 (decodeSubset 29 w27.subsetMask) :=
  checkWitness_sound 29 w27 w27_checks
theorem w28_sequenceable : Sequenceable 29 (decodeSubset 29 w28.subsetMask) :=
  checkWitness_sound 29 w28 w28_checks

/-! ## Step 3 (sanity): the size-28 witness, decoded at `p = 29`, really is the FULL nonzero
group -- same claim as `GrahamZ29Sample.lean`'s `w28_is_full_nonzero_group`. -/

theorem w28_is_full_nonzero_group :
    decodeSubset 29 w28.subsetMask = (Finset.univ : Finset (ZMod 29)) \ {0} := by
  native_decide

/-- Bundled headline result: all 8 real witnesses, routed through the GENERALIZED checker and
soundness theorem specialized at `p = 29`, are certified sequenceable by the same single
soundness theorem `checkWitness_sound`. Structurally identical to `GrahamZ29.Sample.
sample_all_sequenceable`, just built from `GrahamGeneral` instantiated at `29` instead of from
`GrahamZ29` directly. -/
theorem sample_all_sequenceable :
    Sequenceable 29 (decodeSubset 29 w21.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w22.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w23.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w24.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w25.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w26.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w27.subsetMask) ∧
    Sequenceable 29 (decodeSubset 29 w28.subsetMask) :=
  ⟨w21_sequenceable, w22_sequenceable, w23_sequenceable, w24_sequenceable, w25_sequenceable,
    w26_sequenceable, w27_sequenceable, w28_sequenceable⟩

#print axioms w21_checks
#print axioms w21_sequenceable
#print axioms sample_all_sequenceable

end GrahamGeneral.Z29Verify
