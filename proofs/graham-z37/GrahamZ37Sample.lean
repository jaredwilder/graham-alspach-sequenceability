/-
GrahamZ37Sample.lean

End-to-end demonstration on REAL certificate data: 8 rows extracted directly from
`erdosfire/evidence/round4-discovery/graham-z37/witnesses.tsv` (one per subset cardinality,
29 through 36 -- the full range this corpus covers per its own header comment
`theorem_scope=subsets_of_Z37_nonzero_of_sizes_29_through_36` and `generator-summary.json`'s
`minimumSize: 29, maximumSize: 36` -- a DELIBERATELY PARTIAL range: sizes 21-28 of Z_37 are NOT
covered by this corpus and are not claimed sequenceable by anything in this file. This includes
the unique size-35 and size-36 rows, and the full-set size-36 case whose final partial sum is
forced to `0`), encoded as `PackedWitness` literals, checked via `native_decide`, and fed through
the ONE soundness theorem (`checkWitness_sound`, `GrahamZ37Sound.lean`) to get a genuine
`Sequenceable` proof for each -- confirming the whole pipeline (encode real data -> run the
checker -> invoke the soundness theorem -> get `Sequenceable`) genuinely works end to end on
real, not synthetic, witnesses.

Every row below was extracted and independently cross-checked BEFORE being transcribed here, via
a standalone script (`erdosfire/oracle/tools/frontier-math/round4/graham-z37/independent_spot_check.py`
covers 3 of these 8 rows including w29/w33/w36 directly; all 8 were additionally checked by a
second, purpose-built extraction script) that recomputed, independent of the TSV's own columns:
element count, permutation-of-the-decoded-mask's-members, mask recomputed FROM SCRATCH as the
bitwise-OR of `1 << (e-1)` over the elements of `ordering` (an order-independent check of the
TSV's own `mask` column, not merely an assumed closed form), `sum mod 37` against the TSV's own
`total` column, all-proper-partial-sums-nonzero, and pairwise-distinct-partial-sums -- against a
copy of the real, certified TSV (sha256 `edb41b88b399d5aba27bd9cf77ee4fb920786f6bd077013806beb5c2d69d3a97`,
matching `witnesses.tsv`, `go-verification.json`, and `python-orbit-verification.json`'s
`certificateSha256` fields, and independently reproduced twice more by regenerating from source --
see `deterministic-regeneration.json` in that evidence directory). All 8 rows passed every check.
So a transcription slip would show up as `native_decide` failing to prove `checkWitness _ = true`
below, not as a silently-accepted wrong witness.
-/
import GrahamZ37Checker
import GrahamZ37Sound

namespace GrahamZ37.Sample

set_option linter.style.nativeDecide false

/-! ## The 8 real witnesses (one per size 29-36), verbatim from witnesses.tsv -/

/-- size 29, mask `0x01fffffff`, tsv `total = 28`. -/
def w29 : PackedWitness where
  subsetMask := 0x01fffffff
  ordering := #[6, 2, 7, 15, 16, 5, 24, 18, 25, 14, 28, 1, 3, 20, 19, 13, 11, 12, 8, 23, 9, 4, 10,
    29, 21, 22, 27, 17, 26]

/-- size 30, mask `0x03fffffff`, tsv `total = 21`. -/
def w30 : PackedWitness where
  subsetMask := 0x03fffffff
  ordering := #[4, 3, 17, 25, 30, 6, 7, 27, 1, 29, 13, 5, 24, 11, 22, 18, 12, 15, 16, 14, 10, 20,
    26, 9, 21, 8, 2, 28, 19, 23]

/-- size 31, mask `0x07fffffff`, tsv `total = 15`. -/
def w31 : PackedWitness where
  subsetMask := 0x07fffffff
  ordering := #[30, 2, 7, 14, 19, 20, 1, 4, 5, 6, 23, 13, 25, 17, 16, 9, 24, 11, 27, 8, 3, 21, 22,
    18, 28, 26, 15, 29, 12, 31, 10]

/-- size 32, mask `0x0ffffffff`, tsv `total = 10`. -/
def w32 : PackedWitness where
  subsetMask := 0x0ffffffff
  ordering := #[28, 10, 1, 2, 25, 11, 3, 21, 17, 19, 4, 12, 13, 6, 7, 31, 8, 26, 14, 22, 32, 29, 9,
    15, 24, 30, 23, 16, 20, 18, 5, 27]

/-- size 33, mask `0x1ffffffff`, tsv `total = 6`. -/
def w33 : PackedWitness where
  subsetMask := 0x1ffffffff
  ordering := #[18, 12, 26, 19, 13, 8, 31, 32, 9, 6, 21, 30, 24, 27, 29, 20, 15, 1, 25, 3, 16, 10,
    17, 23, 33, 7, 4, 14, 22, 5, 2, 28, 11]

/-- size 34, mask `0x3ffffffff`, tsv `total = 3`. -/
def w34 : PackedWitness where
  subsetMask := 0x3ffffffff
  ordering := #[12, 23, 25, 30, 31, 34, 15, 32, 9, 4, 16, 19, 6, 2, 26, 8, 28, 14, 18, 22, 11, 3,
    13, 17, 21, 10, 1, 33, 27, 29, 24, 5, 7, 20]

/-- size 35 (the UNIQUE canonical representative for this size --
`representativesBySize.35 = 1` in `generator-summary.json`), mask `0x7ffffffff`,
tsv `total = 1`. -/
def w35 : PackedWitness where
  subsetMask := 0x7ffffffff
  ordering := #[14, 6, 9, 32, 19, 26, 13, 20, 16, 12, 34, 7, 35, 10, 2, 8, 21, 30, 28, 1, 3, 29, 25,
    33, 22, 11, 27, 24, 4, 31, 5, 15, 18, 17, 23]

/-- size 36 (the UNIQUE canonical representative -- the FULL nonzero group `Z_37 \ {0}`;
`representativesBySize.36 = 1`), mask `0xfffffffff`, tsv `total = 0`: this is the forced
full-set zero-final-sum case the "Statement" section's "`s_i ≠ 0` for `1 ≤ i < m`" clause
deliberately excludes `s_m` for. -/
def w36 : PackedWitness where
  subsetMask := 0xfffffffff
  ordering := #[22, 16, 30, 32, 27, 28, 5, 6, 33, 26, 29, 35, 24, 12, 19, 4, 13, 15, 7, 8, 18, 34,
    36, 25, 2, 17, 3, 1, 11, 21, 20, 23, 9, 14, 31, 10]

/-! ## Step 1: the checker accepts every one of them (native_decide) -/

theorem w29_checks : checkWitness w29 = true := by native_decide
theorem w30_checks : checkWitness w30 = true := by native_decide
theorem w31_checks : checkWitness w31 = true := by native_decide
theorem w32_checks : checkWitness w32 = true := by native_decide
theorem w33_checks : checkWitness w33 = true := by native_decide
theorem w34_checks : checkWitness w34 = true := by native_decide
theorem w35_checks : checkWitness w35 = true := by native_decide
theorem w36_checks : checkWitness w36 = true := by native_decide

/-! ## Step 2: the ONE soundness theorem turns each into a genuine `Sequenceable` proof -/

theorem w29_sequenceable : Sequenceable (decodeSubset w29.subsetMask) :=
  checkWitness_sound w29 w29_checks
theorem w30_sequenceable : Sequenceable (decodeSubset w30.subsetMask) :=
  checkWitness_sound w30 w30_checks
theorem w31_sequenceable : Sequenceable (decodeSubset w31.subsetMask) :=
  checkWitness_sound w31 w31_checks
theorem w32_sequenceable : Sequenceable (decodeSubset w32.subsetMask) :=
  checkWitness_sound w32 w32_checks
theorem w33_sequenceable : Sequenceable (decodeSubset w33.subsetMask) :=
  checkWitness_sound w33 w33_checks
theorem w34_sequenceable : Sequenceable (decodeSubset w34.subsetMask) :=
  checkWitness_sound w34 w34_checks
theorem w35_sequenceable : Sequenceable (decodeSubset w35.subsetMask) :=
  checkWitness_sound w35 w35_checks
theorem w36_sequenceable : Sequenceable (decodeSubset w36.subsetMask) :=
  checkWitness_sound w36 w36_checks

/-! ## Step 3 (sanity): the size-36 witness really decodes to the FULL nonzero group

Ties the sample directly back to what this PARTIAL corpus actually certifies: confirms
`decodeSubset` on the size-36 mask really does produce all of `Z_37 \ {0}`, not merely *some*
36-element set. -/

theorem w36_is_full_nonzero_group :
    decodeSubset w36.subsetMask = (Finset.univ : Finset (ZMod 37)) \ {0} := by
  native_decide

/-- Bundled headline result: all 8 real, independently-transcribed sample witnesses -- one per
subset size 29 through 36, including the forced full-set zero-final-sum case -- are certified
sequenceable by the SAME single soundness theorem, `checkWitness_sound`. This is a sample of the
298,344-witness corpus, not the corpus itself; the corpus's exhaustiveness claim rests on the
Go/Python verifiers' independent orbit-accounting (see the evidence directory), not on this
Lean file re-checking all 298,344 rows. -/
theorem sample_all_sequenceable :
    Sequenceable (decodeSubset w29.subsetMask) ∧ Sequenceable (decodeSubset w30.subsetMask) ∧
    Sequenceable (decodeSubset w31.subsetMask) ∧ Sequenceable (decodeSubset w32.subsetMask) ∧
    Sequenceable (decodeSubset w33.subsetMask) ∧ Sequenceable (decodeSubset w34.subsetMask) ∧
    Sequenceable (decodeSubset w35.subsetMask) ∧ Sequenceable (decodeSubset w36.subsetMask) :=
  ⟨w29_sequenceable, w30_sequenceable, w31_sequenceable, w32_sequenceable, w33_sequenceable,
    w34_sequenceable, w35_sequenceable, w36_sequenceable⟩

#print axioms w29_checks
#print axioms w29_sequenceable
#print axioms sample_all_sequenceable

end GrahamZ37.Sample
