/-
GrahamZ31Verify.lean

Acceptance test: specializes the GENERALIZED checker/soundness pair (`GrahamChecker.lean`,
`GrahamSound.lean`, both parametric in `p : ℕ` with `[Fact p.Prime]`) to `p = 31`, and re-runs
the exact same 10 real witnesses transcribed in `public/proofs/graham-z31/GrahamZ31Sample.lean`
(one per subset cardinality, 21 through 30) against it. Every `subsetMask`/`ordering` literal
below is copied verbatim from `GrahamZ31Sample.lean` -- this file changes NOTHING about the data,
only routes it through `GrahamGeneral.checkWitness 31` / `GrahamGeneral.checkWitness_sound 31`
instead of the hardcoded `GrahamZ31.checkWitness` / `GrahamZ31.checkWitness_sound`.

Purpose: confirm the generalization is not merely well-typed in isolation, but reproduces the
ORIGINAL `Z_31` result exactly -- same witnesses accepted, same `Sequenceable` conclusion, and
(checked via the `#print axioms` lines at the end) the same trust footprint: the 3 standard
axioms (`propext`, `Classical.choice`, `Quot.sound`) plus exactly one `native_decide` axiom per
witness, with routing through the soundness theorem adding nothing beyond that.
-/
import GrahamChecker
import GrahamSound

namespace GrahamGeneral.Z31Verify

set_option linter.style.nativeDecide false

/-- `31` is prime -- the single fact needed to instantiate the general checker/soundness pair
at `p = 31`. Proved by `norm_num`'s primality certificate, not `native_decide` or `decide`: this
must not itself inflate the axiom footprint measured below. -/
instance factPrime31 : Fact (Nat.Prime 31) := ⟨by norm_num⟩

/-! ## The 10 real witnesses (one per size 21-30), copied verbatim from
`public/proofs/graham-z31/GrahamZ31Sample.lean` -/

/-- size 21, mask `0x001fffff`, subset `{1,...,21}`, tsv `total = 14`. -/
def w21 : PackedWitness where
  subsetMask := 0x001fffff
  ordering := #[3, 5, 2, 7, 15, 11, 1, 16, 17, 13, 8, 19, 9, 4, 20, 14, 21, 12, 10, 6, 18]

/-- size 22, mask `0x003fffff`, subset `{1,...,22}`, tsv `total = 5`. -/
def w22 : PackedWitness where
  subsetMask := 0x003fffff
  ordering :=
    #[6, 2, 8, 7, 1, 5, 13, 22, 20, 18, 4, 12, 21, 11, 9, 3, 10, 17, 15, 14, 19, 16]

/-- size 23, mask `0x007fffff`, subset `{1,...,23}`, tsv `total = 28`. -/
def w23 : PackedWitness where
  subsetMask := 0x007fffff
  ordering :=
    #[6, 1, 3, 4, 20, 5, 11, 21, 2, 10, 14, 13, 7, 8, 12, 23, 22, 19, 15, 17, 9, 18, 16]

/-- size 24, mask `0x00ffffff`, subset `{1,...,24}`, tsv `total = 21`. -/
def w24 : PackedWitness where
  subsetMask := 0x00ffffff
  ordering :=
    #[1, 6, 12, 18, 3, 2, 4, 19, 9, 16, 8, 5, 14, 11, 23, 22, 15, 21, 24, 10, 13, 17, 20, 7]

/-- size 25, mask `0x01ffffff`, subset `{1,...,25}`, tsv `total = 15`. -/
def w25 : PackedWitness where
  subsetMask := 0x01ffffff
  ordering := #[4, 5, 17, 19, 24, 14, 22, 6, 1, 25, 3, 11, 15, 9, 10, 18, 16, 8, 12, 2, 13, 23, 7,
    20, 21]

/-- size 26, mask `0x03ffffff`, subset `{1,...,26}`, tsv `total = 10`. -/
def w26 : PackedWitness where
  subsetMask := 0x03ffffff
  ordering := #[12, 3, 1, 4, 25, 5, 16, 14, 24, 6, 20, 15, 17, 18, 19, 13, 2, 11, 22, 10, 23, 26, 7,
    21, 9, 8]

/-- size 27, mask `0x07ffffff`, subset `{1,...,27}`, tsv `total = 6`. -/
def w27 : PackedWitness where
  subsetMask := 0x07ffffff
  ordering := #[18, 22, 1, 2, 15, 7, 23, 16, 8, 6, 10, 9, 20, 3, 11, 12, 4, 19, 25, 24, 14, 27, 5,
    17, 21, 26, 13]

/-- size 28, mask `0x0fffffff`, subset `{1,...,28}`, tsv `total = 3`. -/
def w28 : PackedWitness where
  subsetMask := 0x0fffffff
  ordering := #[9, 2, 11, 22, 20, 18, 15, 14, 6, 5, 28, 12, 1, 17, 25, 26, 13, 21, 19, 23, 24, 16,
    10, 27, 3, 8, 7, 4]

/-- size 29 (the unique canonical representative for this size), mask `0x1fffffff`, subset
`{1,...,29}`, tsv `total = 1`. -/
def w29 : PackedWitness where
  subsetMask := 0x1fffffff
  ordering := #[26, 15, 6, 23, 1, 16, 21, 8, 27, 29, 3, 13, 2, 14, 18, 7, 12, 20, 24, 22, 17, 28,
    10, 9, 4, 19, 5, 11, 25]

/-- size 30 (the unique canonical representative -- the full nonzero group `Z_31 \ {0}`), mask
`0x3fffffff`, tsv `total = 0`: the forced full-set zero-final-sum case. -/
def w30 : PackedWitness where
  subsetMask := 0x3fffffff
  ordering := #[18, 11, 9, 13, 20, 2, 25, 22, 21, 30, 6, 23, 1, 15, 26, 12, 17, 27, 5, 4, 16, 28,
    29, 24, 3, 8, 14, 7, 19, 10]

/-! ## Step 1: the GENERALIZED checker, specialized at `p = 31`, accepts every one of them -/

theorem w21_checks : checkWitness 31 w21 = true := by native_decide
theorem w22_checks : checkWitness 31 w22 = true := by native_decide
theorem w23_checks : checkWitness 31 w23 = true := by native_decide
theorem w24_checks : checkWitness 31 w24 = true := by native_decide
theorem w25_checks : checkWitness 31 w25 = true := by native_decide
theorem w26_checks : checkWitness 31 w26 = true := by native_decide
theorem w27_checks : checkWitness 31 w27 = true := by native_decide
theorem w28_checks : checkWitness 31 w28 = true := by native_decide
theorem w29_checks : checkWitness 31 w29 = true := by native_decide
theorem w30_checks : checkWitness 31 w30 = true := by native_decide

/-! ## Step 2: the ONE generalized soundness theorem, specialized at `p = 31`, turns each into a
genuine `Sequenceable` proof -/

theorem w21_sequenceable : Sequenceable 31 (decodeSubset 31 w21.subsetMask) :=
  checkWitness_sound 31 w21 w21_checks
theorem w22_sequenceable : Sequenceable 31 (decodeSubset 31 w22.subsetMask) :=
  checkWitness_sound 31 w22 w22_checks
theorem w23_sequenceable : Sequenceable 31 (decodeSubset 31 w23.subsetMask) :=
  checkWitness_sound 31 w23 w23_checks
theorem w24_sequenceable : Sequenceable 31 (decodeSubset 31 w24.subsetMask) :=
  checkWitness_sound 31 w24 w24_checks
theorem w25_sequenceable : Sequenceable 31 (decodeSubset 31 w25.subsetMask) :=
  checkWitness_sound 31 w25 w25_checks
theorem w26_sequenceable : Sequenceable 31 (decodeSubset 31 w26.subsetMask) :=
  checkWitness_sound 31 w26 w26_checks
theorem w27_sequenceable : Sequenceable 31 (decodeSubset 31 w27.subsetMask) :=
  checkWitness_sound 31 w27 w27_checks
theorem w28_sequenceable : Sequenceable 31 (decodeSubset 31 w28.subsetMask) :=
  checkWitness_sound 31 w28 w28_checks
theorem w29_sequenceable : Sequenceable 31 (decodeSubset 31 w29.subsetMask) :=
  checkWitness_sound 31 w29 w29_checks
theorem w30_sequenceable : Sequenceable 31 (decodeSubset 31 w30.subsetMask) :=
  checkWitness_sound 31 w30 w30_checks

/-! ## Step 3 (sanity): the size-30 witness, decoded at `p = 31`, really is the FULL nonzero
group -- same claim as `GrahamZ31Sample.lean`'s `w30_is_full_nonzero_group`. -/

theorem w30_is_full_nonzero_group :
    decodeSubset 31 w30.subsetMask = (Finset.univ : Finset (ZMod 31)) \ {0} := by
  native_decide

/-- Bundled headline result: all 10 real witnesses, routed through the GENERALIZED checker and
soundness theorem specialized at `p = 31`, are certified sequenceable by the same single
soundness theorem `checkWitness_sound`. Structurally identical to `GrahamZ31.Sample.
sample_all_sequenceable`, just built from `GrahamGeneral` instantiated at `31` instead of from
`GrahamZ31` directly. -/
theorem sample_all_sequenceable :
    Sequenceable 31 (decodeSubset 31 w21.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w22.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w23.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w24.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w25.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w26.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w27.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w28.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w29.subsetMask) ∧
    Sequenceable 31 (decodeSubset 31 w30.subsetMask) :=
  ⟨w21_sequenceable, w22_sequenceable, w23_sequenceable, w24_sequenceable, w25_sequenceable,
    w26_sequenceable, w27_sequenceable, w28_sequenceable, w29_sequenceable, w30_sequenceable⟩

#print axioms w21_checks
#print axioms w21_sequenceable
#print axioms sample_all_sequenceable

end GrahamGeneral.Z31Verify
