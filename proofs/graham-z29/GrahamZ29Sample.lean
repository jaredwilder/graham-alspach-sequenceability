/-
GrahamZ29Sample.lean

End-to-end demonstration on REAL certificate data: 8 rows hand-transcribed directly from
`erdosfire/evidence/round4-discovery/graham-z29/witnesses.tsv` (one per subset cardinality,
21 through 28 -- including the unique size-27 and size-28 rows, and the full-set size-28 case
whose final partial sum is forced to `0`), encoded as `PackedWitness` literals, checked via
`native_decide`, and fed through the ONE soundness theorem (`checkWitness_sound`,
`GrahamZ29Sound.lean`) to get a genuine `Sequenceable` proof for each -- confirming the whole
pipeline (encode real data -> run the checker -> invoke the soundness theorem -> get
`Sequenceable`) genuinely works end to end on real, not synthetic, witnesses.

Every row below was independently cross-checked (element count, permutation-of-`{1,...,size}`,
mask `= 2^size - 1`, and `sum mod 29` against the TSV's own `total` column) BEFORE being
transcribed here, so a transcription slip would show up as `native_decide` failing to prove
`checkWitness _ = true` below, not as a silently-accepted wrong witness.
-/
import GrahamZ29Checker
import GrahamZ29Sound

namespace GrahamZ29.Sample

set_option linter.style.nativeDecide false

/-! ## The 8 real witnesses (one per size 21-28), verbatim from witnesses.tsv -/

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

/-- size 27 (the UNIQUE canonical representative for this size), mask `0x7ffffff`, subset
`{1,...,27}`, tsv `total = 1`. -/
def w27 : PackedWitness where
  subsetMask := 0x7ffffff
  ordering := #[23, 11, 22, 16, 14, 19, 17, 13, 25, 9, 7, 10, 24, 26, 6, 3, 8, 4, 20, 1, 5, 15, 18,
    12, 2, 21, 27]

/-- size 28 (the UNIQUE canonical representative -- the FULL nonzero group `Z_29 \ {0}`),
mask `0xfffffff`, tsv `total = 0`: this is the forced full-set zero-final-sum case the
"Statement" section's "`s_i ≠ 0` for `1 ≤ i < m`" clause deliberately excludes `s_m` for. -/
def w28 : PackedWitness where
  subsetMask := 0xfffffff
  ordering := #[23, 3, 13, 21, 6, 10, 24, 19, 17, 16, 9, 5, 20, 2, 14, 12, 27, 25, 28, 18, 22, 15,
    26, 8, 11, 7, 1, 4]

/-! ## Step 1: the checker accepts every one of them (native_decide) -/

theorem w21_checks : checkWitness w21 = true := by native_decide
theorem w22_checks : checkWitness w22 = true := by native_decide
theorem w23_checks : checkWitness w23 = true := by native_decide
theorem w24_checks : checkWitness w24 = true := by native_decide
theorem w25_checks : checkWitness w25 = true := by native_decide
theorem w26_checks : checkWitness w26 = true := by native_decide
theorem w27_checks : checkWitness w27 = true := by native_decide
theorem w28_checks : checkWitness w28 = true := by native_decide

/-! ## Step 2: the ONE soundness theorem turns each into a genuine `Sequenceable` proof -/

theorem w21_sequenceable : Sequenceable (decodeSubset w21.subsetMask) :=
  checkWitness_sound w21 w21_checks
theorem w22_sequenceable : Sequenceable (decodeSubset w22.subsetMask) :=
  checkWitness_sound w22 w22_checks
theorem w23_sequenceable : Sequenceable (decodeSubset w23.subsetMask) :=
  checkWitness_sound w23 w23_checks
theorem w24_sequenceable : Sequenceable (decodeSubset w24.subsetMask) :=
  checkWitness_sound w24 w24_checks
theorem w25_sequenceable : Sequenceable (decodeSubset w25.subsetMask) :=
  checkWitness_sound w25 w25_checks
theorem w26_sequenceable : Sequenceable (decodeSubset w26.subsetMask) :=
  checkWitness_sound w26 w26_checks
theorem w27_sequenceable : Sequenceable (decodeSubset w27.subsetMask) :=
  checkWitness_sound w27 w27_checks
theorem w28_sequenceable : Sequenceable (decodeSubset w28.subsetMask) :=
  checkWitness_sound w28 w28_checks

/-! ## Step 3 (sanity): the size-28 witness really decodes to the FULL nonzero group

Ties the sample directly back to main.tex's Theorem ("Every subset `A ⊆ Z_29 \ {0}` is
sequenceable"): confirms `decodeSubset` on the size-28 mask really does produce all of
`Z_29 \ {0}`, not merely *some* 28-element set. -/

theorem w28_is_full_nonzero_group :
    decodeSubset w28.subsetMask = (Finset.univ : Finset (ZMod 29)) \ {0} := by
  native_decide

/-- Bundled headline result: all 8 real, independently-transcribed sample witnesses -- one per
subset size 21 through 28, including the forced full-set zero-final-sum case -- are certified
sequenceable by the SAME single soundness theorem, `checkWitness_sound`. -/
theorem sample_all_sequenceable :
    Sequenceable (decodeSubset w21.subsetMask) ∧ Sequenceable (decodeSubset w22.subsetMask) ∧
    Sequenceable (decodeSubset w23.subsetMask) ∧ Sequenceable (decodeSubset w24.subsetMask) ∧
    Sequenceable (decodeSubset w25.subsetMask) ∧ Sequenceable (decodeSubset w26.subsetMask) ∧
    Sequenceable (decodeSubset w27.subsetMask) ∧ Sequenceable (decodeSubset w28.subsetMask) :=
  ⟨w21_sequenceable, w22_sequenceable, w23_sequenceable, w24_sequenceable, w25_sequenceable,
    w26_sequenceable, w27_sequenceable, w28_sequenceable⟩

#print axioms w21_checks
#print axioms w21_sequenceable
#print axioms sample_all_sequenceable

end GrahamZ29.Sample
