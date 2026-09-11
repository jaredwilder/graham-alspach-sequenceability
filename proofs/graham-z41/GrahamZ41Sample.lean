/-
GrahamZ41Sample.lean

End-to-end demonstration on REAL certificate data: 7 rows extracted directly from
`erdosfire/evidence/round4-discovery/graham-z41/witnesses.tsv` (one per subset cardinality,
34 through 40 -- the full range this corpus covers per its own header comment
`theorem_scope=subsets_of_Z41_nonzero_of_sizes_34_through_40` and `generator-summary.json`'s
`minimumSize: 34, maximumSize: 40` -- a DELIBERATELY PARTIAL range: sizes 21-33 of Z_41 are NOT
covered by this corpus and are not claimed sequenceable by anything in this file. This includes
the unique size-39 and size-40 rows, and the full-set size-40 case whose final partial sum is
forced to `0`), encoded as `PackedWitness` literals, checked via `native_decide`, and fed through
the ONE soundness theorem (`checkWitness_sound`, `GrahamZ41Sound.lean`) to get a genuine
`Sequenceable` proof for each -- confirming the whole pipeline (encode real data -> run the
checker -> invoke the soundness theorem -> get `Sequenceable`) genuinely works end to end on
real, not synthetic, witnesses.

Every row below was extracted and independently cross-checked BEFORE being transcribed here, via
a standalone script that recomputed, independent of the TSV's own columns: element count,
permutation-of-the-decoded-mask's-members, mask recomputed FROM SCRATCH as the bitwise-OR of
`1 << (e-1)` over the elements of `ordering` (an order-independent check of the TSV's own `mask`
column, not merely an assumed closed form), `sum mod 41` against the TSV's own `total` column,
all-proper-partial-sums-nonzero, and pairwise-distinct-partial-sums -- against a copy of the
real, certified TSV (sha256 `e60a77fea3f42b70e9e90286cda71b77b75878ab8cba078517f378e426ba465d`,
matching `witnesses.tsv`, `go-verification.json`, and `python-orbit-verification.json`'s
`certificateSha256` fields, and independently reproduced twice more by regenerating from source --
see `deterministic-regeneration.json` in that evidence directory). All 7 rows passed every check.
So a transcription slip would show up as `native_decide` failing to prove `checkWitness _ = true`
below, not as a silently-accepted wrong witness.

Incidentally (an artifact of the generator sorting canonical representatives by numeric mask
value, not a hand-picked coincidence): the smallest-valued mask of popcount `k` is always
`2^k - 1`, which decodes to exactly `{1, 2, ..., k}` -- so all 7 masks below happen to be
consecutive-integer sets, and each `total` is independently checkable by hand via the closed
form `k(k+1)/2 mod 41` (e.g. size 40: `40*41/2 = 820 = 41*20 ≡ 0`).
-/
import GrahamZ41Checker
import GrahamZ41Sound

namespace GrahamZ41.Sample

set_option linter.style.nativeDecide false

/-! ## The 7 real witnesses (one per size 34-40), verbatim from witnesses.tsv -/

/-- size 34, mask `0x03ffffffff`, tsv `total = 21`. -/
def w34 : PackedWitness where
  subsetMask := 0x03ffffffff
  ordering := #[4, 6, 32, 5, 30, 16, 26, 11, 24, 23, 33, 10, 1, 34, 3, 2, 29, 17, 21, 9, 12, 18,
    20, 22, 28, 8, 25, 15, 31, 7, 14, 19, 13, 27]

/-- size 35, mask `0x07ffffffff`, tsv `total = 15`. -/
def w35 : PackedWitness where
  subsetMask := 0x07ffffffff
  ordering := #[23, 9, 20, 15, 10, 29, 16, 26, 8, 2, 11, 1, 31, 6, 7, 18, 33, 19, 17, 35, 21, 25,
    4, 34, 32, 30, 14, 3, 27, 5, 24, 22, 13, 12, 28]

/-- size 36, mask `0x0fffffffff`, tsv `total = 10`. -/
def w36 : PackedWitness where
  subsetMask := 0x0fffffffff
  ordering := #[34, 16, 18, 27, 29, 10, 26, 25, 5, 23, 11, 3, 21, 22, 14, 31, 30, 6, 32, 1, 15,
    36, 4, 24, 8, 12, 13, 35, 7, 2, 33, 17, 19, 9, 28, 20]

/-- size 37, mask `0x1fffffffff`, tsv `total = 6`. -/
def w37 : PackedWitness where
  subsetMask := 0x1fffffffff
  ordering := #[18, 1, 3, 30, 10, 2, 26, 12, 22, 8, 7, 24, 11, 29, 33, 23, 15, 37, 19, 31, 25, 13,
    16, 27, 4, 32, 17, 35, 28, 9, 36, 6, 20, 34, 5, 14, 21]

/-- size 38, mask `0x3fffffffff`, tsv `total = 3`. -/
def w38 : PackedWitness where
  subsetMask := 0x3fffffffff
  ordering := #[32, 15, 8, 24, 10, 2, 1, 7, 16, 28, 19, 33, 21, 13, 36, 4, 14, 6, 20, 27, 17, 31,
    12, 26, 22, 11, 38, 35, 18, 3, 30, 25, 37, 9, 5, 29, 34, 23]

/-- size 39 (the UNIQUE canonical representative for this size --
`representativesBySize.39 = 1` in `generator-summary.json`), mask `0x7fffffffff`,
tsv `total = 1`. -/
def w39 : PackedWitness where
  subsetMask := 0x7fffffffff
  ordering := #[19, 13, 1, 37, 9, 30, 28, 22, 15, 33, 7, 36, 17, 23, 21, 34, 18, 29, 5, 11, 8, 20,
    4, 26, 10, 27, 38, 32, 14, 3, 6, 31, 25, 24, 39, 16, 12, 2, 35]

/-- size 40 (the UNIQUE canonical representative -- the FULL nonzero group `Z_41 \ {0}`;
`representativesBySize.40 = 1`), mask `0xffffffffff`, tsv `total = 0`: this is the forced
full-set zero-final-sum case the "Statement" section's "`s_i ≠ 0` for `1 ≤ i < m`" clause
deliberately excludes `s_m` for. -/
def w40 : PackedWitness where
  subsetMask := 0xffffffffff
  ordering := #[15, 8, 30, 20, 18, 26, 13, 37, 28, 2, 38, 12, 36, 24, 35, 31, 7, 17, 29, 10, 1, 27,
    11, 25, 14, 3, 33, 34, 19, 9, 39, 4, 6, 16, 22, 32, 5, 21, 40, 23]

/-! ## Step 1: the checker accepts every one of them (native_decide) -/

theorem w34_checks : checkWitness w34 = true := by native_decide
theorem w35_checks : checkWitness w35 = true := by native_decide
theorem w36_checks : checkWitness w36 = true := by native_decide
theorem w37_checks : checkWitness w37 = true := by native_decide
theorem w38_checks : checkWitness w38 = true := by native_decide
theorem w39_checks : checkWitness w39 = true := by native_decide
theorem w40_checks : checkWitness w40 = true := by native_decide

/-! ## Step 2: the ONE soundness theorem turns each into a genuine `Sequenceable` proof -/

theorem w34_sequenceable : Sequenceable (decodeSubset w34.subsetMask) :=
  checkWitness_sound w34 w34_checks
theorem w35_sequenceable : Sequenceable (decodeSubset w35.subsetMask) :=
  checkWitness_sound w35 w35_checks
theorem w36_sequenceable : Sequenceable (decodeSubset w36.subsetMask) :=
  checkWitness_sound w36 w36_checks
theorem w37_sequenceable : Sequenceable (decodeSubset w37.subsetMask) :=
  checkWitness_sound w37 w37_checks
theorem w38_sequenceable : Sequenceable (decodeSubset w38.subsetMask) :=
  checkWitness_sound w38 w38_checks
theorem w39_sequenceable : Sequenceable (decodeSubset w39.subsetMask) :=
  checkWitness_sound w39 w39_checks
theorem w40_sequenceable : Sequenceable (decodeSubset w40.subsetMask) :=
  checkWitness_sound w40 w40_checks

/-! ## Step 3 (sanity): the size-40 witness really decodes to the FULL nonzero group

Ties the sample directly back to what this PARTIAL corpus actually certifies: confirms
`decodeSubset` on the size-40 mask really does produce all of `Z_41 \ {0}`, not merely *some*
40-element set. -/

theorem w40_is_full_nonzero_group :
    decodeSubset w40.subsetMask = (Finset.univ : Finset (ZMod 41)) \ {0} := by
  native_decide

/-- Bundled headline result: all 7 real, independently-transcribed sample witnesses -- one per
subset size 34 through 40, including the forced full-set zero-final-sum case -- are certified
sequenceable by the SAME single soundness theorem, `checkWitness_sound`. This is a sample of the
114,998-witness corpus, not the corpus itself; the corpus's exhaustiveness claim rests on the
Go/Python verifiers' independent orbit-accounting (see the evidence directory), not on this
Lean file re-checking all 114,998 rows. -/
theorem sample_all_sequenceable :
    Sequenceable (decodeSubset w34.subsetMask) ∧ Sequenceable (decodeSubset w35.subsetMask) ∧
    Sequenceable (decodeSubset w36.subsetMask) ∧ Sequenceable (decodeSubset w37.subsetMask) ∧
    Sequenceable (decodeSubset w38.subsetMask) ∧ Sequenceable (decodeSubset w39.subsetMask) ∧
    Sequenceable (decodeSubset w40.subsetMask) :=
  ⟨w34_sequenceable, w35_sequenceable, w36_sequenceable, w37_sequenceable, w38_sequenceable,
    w39_sequenceable, w40_sequenceable⟩

#print axioms w34_checks
#print axioms w34_sequenceable
#print axioms sample_all_sequenceable

end GrahamZ41.Sample
