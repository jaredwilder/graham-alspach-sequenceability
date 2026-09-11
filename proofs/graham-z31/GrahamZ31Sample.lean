/-
GrahamZ31Sample.lean

End-to-end demonstration on REAL certificate data: 10 rows hand-transcribed directly from
`erdosfire/evidence/round4-discovery/graham-z31/witnesses.tsv` (one per subset cardinality,
21 through 30 -- the full exhaustive range this corpus covers per its own header comment
`theorem_scope=subsets_of_Z31_nonzero_of_sizes_21_through_30` and `generator-summary.json`'s
`minimumSize: 21, maximumSize: 30` -- NOT the same 21-28 range as `Z_29`'s sample, since
`Z_31 \ {0}` has 30 elements, two more than `Z_29`'s 28; this includes the unique size-29 and
size-30 rows, and the full-set size-30 case whose final partial sum is forced to `0`), encoded
as `PackedWitness` literals, checked via `native_decide`, and fed through the ONE soundness
theorem (`checkWitness_sound`, `GrahamZ31Sound.lean`) to get a genuine `Sequenceable` proof for
each -- confirming the whole pipeline (encode real data -> run the checker -> invoke the
soundness theorem -> get `Sequenceable`) genuinely works end to end on real, not synthetic,
witnesses.

Every row below was independently cross-checked BEFORE being transcribed here -- element count,
permutation-of-`{1,...,size}`, mask recomputed from scratch as the bitwise-OR of `1 << (e-1)`
over the elements of `ordering` (an order-independent check of the TSV's own `mask` column, not
merely an assumed `mask = 2^size - 1` closed form), `sum mod 31` against the TSV's own `total`
column, all-proper-partial-sums-nonzero, and pairwise-distinct-partial-sums -- via a standalone
script run against a freshly `awk`-pulled copy of the first row per size from the real TSV
(sha256 `0b18d921b86b946e973279c6cc96fec52434718d64feedc9937467ec8571d7c3`, matching both
`witnesses.tsv.sha256` and the `go-verification.json` / `python-orbit-verification.json`
`certificateSha256` fields). All 10 rows passed every check. So a transcription slip would show
up as `native_decide` failing to prove `checkWitness _ = true` below, not as a silently-accepted
wrong witness.
-/
import GrahamZ31Checker
import GrahamZ31Sound

namespace GrahamZ31.Sample

set_option linter.style.nativeDecide false

/-! ## The 10 real witnesses (one per size 21-30), verbatim from witnesses.tsv -/

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

/-- size 29 (the UNIQUE canonical representative for this size -- `representativesBySize.29 = 1`
in `generator-summary.json`), mask `0x1fffffff`, subset `{1,...,29}`, tsv `total = 1`. -/
def w29 : PackedWitness where
  subsetMask := 0x1fffffff
  ordering := #[26, 15, 6, 23, 1, 16, 21, 8, 27, 29, 3, 13, 2, 14, 18, 7, 12, 20, 24, 22, 17, 28,
    10, 9, 4, 19, 5, 11, 25]

/-- size 30 (the UNIQUE canonical representative -- the FULL nonzero group `Z_31 \ {0}`;
`representativesBySize.30 = 1`), mask `0x3fffffff`, tsv `total = 0`: this is the forced
full-set zero-final-sum case the "Statement" section's "`s_i ≠ 0` for `1 ≤ i < m`" clause
deliberately excludes `s_m` for. -/
def w30 : PackedWitness where
  subsetMask := 0x3fffffff
  ordering := #[18, 11, 9, 13, 20, 2, 25, 22, 21, 30, 6, 23, 1, 15, 26, 12, 17, 27, 5, 4, 16, 28,
    29, 24, 3, 8, 14, 7, 19, 10]

/-! ## Step 1: the checker accepts every one of them (native_decide) -/

theorem w21_checks : checkWitness w21 = true := by native_decide
theorem w22_checks : checkWitness w22 = true := by native_decide
theorem w23_checks : checkWitness w23 = true := by native_decide
theorem w24_checks : checkWitness w24 = true := by native_decide
theorem w25_checks : checkWitness w25 = true := by native_decide
theorem w26_checks : checkWitness w26 = true := by native_decide
theorem w27_checks : checkWitness w27 = true := by native_decide
theorem w28_checks : checkWitness w28 = true := by native_decide
theorem w29_checks : checkWitness w29 = true := by native_decide
theorem w30_checks : checkWitness w30 = true := by native_decide

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
theorem w29_sequenceable : Sequenceable (decodeSubset w29.subsetMask) :=
  checkWitness_sound w29 w29_checks
theorem w30_sequenceable : Sequenceable (decodeSubset w30.subsetMask) :=
  checkWitness_sound w30 w30_checks

/-! ## Step 3 (sanity): the size-30 witness really decodes to the FULL nonzero group

Ties the sample directly back to the Theorem ("Every subset `A ⊆ Z_31 \ {0}` is sequenceable"):
confirms `decodeSubset` on the size-30 mask really does produce all of `Z_31 \ {0}`, not merely
*some* 30-element set. -/

theorem w30_is_full_nonzero_group :
    decodeSubset w30.subsetMask = (Finset.univ : Finset (ZMod 31)) \ {0} := by
  native_decide

/-- Bundled headline result: all 10 real, independently-transcribed sample witnesses -- one per
subset size 21 through 30, including the forced full-set zero-final-sum case -- are certified
sequenceable by the SAME single soundness theorem, `checkWitness_sound`. -/
theorem sample_all_sequenceable :
    Sequenceable (decodeSubset w21.subsetMask) ∧ Sequenceable (decodeSubset w22.subsetMask) ∧
    Sequenceable (decodeSubset w23.subsetMask) ∧ Sequenceable (decodeSubset w24.subsetMask) ∧
    Sequenceable (decodeSubset w25.subsetMask) ∧ Sequenceable (decodeSubset w26.subsetMask) ∧
    Sequenceable (decodeSubset w27.subsetMask) ∧ Sequenceable (decodeSubset w28.subsetMask) ∧
    Sequenceable (decodeSubset w29.subsetMask) ∧ Sequenceable (decodeSubset w30.subsetMask) :=
  ⟨w21_sequenceable, w22_sequenceable, w23_sequenceable, w24_sequenceable, w25_sequenceable,
    w26_sequenceable, w27_sequenceable, w28_sequenceable, w29_sequenceable, w30_sequenceable⟩

#print axioms w21_checks
#print axioms w21_sequenceable
#print axioms sample_all_sequenceable

end GrahamZ31.Sample
