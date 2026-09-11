/-
GrahamZ43Sample.lean

End-to-end demonstration on REAL certificate data: 7 rows extracted directly from
`erdosfire/evidence/round4-discovery/graham-z43/witnesses.tsv` (one per subset cardinality,
36 through 42 -- the full range this corpus covers per its own header comment
`theorem_scope=subsets_of_Z43_nonzero_of_sizes_36_through_42` and `generator-summary.json`'s
`minimumSize: 36, maximumSize: 42` -- a DELIBERATELY PARTIAL range: sizes 21-35 of Z_43 are NOT
covered by this corpus and are not claimed sequenceable by anything in this file. This includes
the unique size-41 and size-42 rows, and the full-set size-42 case whose final partial sum is
forced to `0`), encoded as `PackedWitness` literals, checked via `native_decide`, and fed through
the ONE soundness theorem (`checkWitness_sound`, `GrahamZ43Sound.lean`) to get a genuine
`Sequenceable` proof for each -- confirming the whole pipeline (encode real data -> run the
checker -> invoke the soundness theorem -> get `Sequenceable`) genuinely works end to end on
real, not synthetic, witnesses.

Every row below was extracted and independently cross-checked BEFORE being transcribed here, via
a standalone PowerShell script (not any of this repo's Go/Python/C++ tools) that recomputed,
independent of the TSV's own columns: element count, permutation-of-the-decoded-mask's-members,
mask recomputed FROM SCRATCH as the bitwise-OR of `1 << (e-1)` over the elements of `ordering`
(an order-independent check of the TSV's own `mask` column, not merely an assumed closed form),
sum mod 43 against the TSV's own `total` column, all-proper-partial-sums-nonzero, and
pairwise-distinct-partial-sums -- against a copy of the real, certified TSV (sha256
`6599bfb86b698383e0b392973280ca2816e543345b78560829f923a89f9bf0cb`, matching `witnesses.tsv`,
`go-verification.json`, and `python-orbit-verification.json`'s `certificateSha256` fields, and
independently reproduced by regenerating from source -- see `deterministic-regeneration.json` in
that evidence directory). All 7 rows passed every check. Additionally, every row's `total` field
was cross-checked by hand against the closed form `k(k+1)/2 mod 43` (all 7 masks below are the
consecutive-integer set `{1,...,k}`, see the note below), independent of any code at all. So a
transcription slip would show up as `native_decide` failing to prove `checkWitness _ = true`
below, not as a silently-accepted wrong witness.

Incidentally (an artifact of the generator sorting canonical representatives by numeric mask
value, not a hand-picked coincidence): the smallest-valued mask of popcount `k` is always
`2^k - 1`, which decodes to exactly `{1, 2, ..., k}` -- so all 7 masks below happen to be
consecutive-integer sets, and each `total` is independently checkable by hand via the closed
form `k(k+1)/2 mod 43` (e.g. size 42: `42*43/2 = 903 = 43*21 ≡ 0`).
-/
import GrahamZ43Checker
import GrahamZ43Sound

namespace GrahamZ43.Sample

set_option linter.style.nativeDecide false

/-! ## The 7 real witnesses (one per size 36-42), verbatim from witnesses.tsv -/

/-- size 36, mask `0x00fffffffff`, tsv `total = 21` (closed form: `36*37/2 = 666 = 43*15 + 21`). -/
def w36 : PackedWitness where
  subsetMask := 0x00fffffffff
  ordering := #[8, 21, 33, 4, 10, 6, 34, 7, 17, 36, 11, 27, 2, 31, 13, 22, 1, 30, 16, 25, 3, 28,
    20, 32, 24, 5, 29, 26, 12, 9, 14, 19, 18, 23, 35, 15]

/-- size 37, mask `0x01fffffffff`, tsv `total = 15` (closed form: `37*38/2 = 703 = 43*16 + 15`). -/
def w37 : PackedWitness where
  subsetMask := 0x01fffffffff
  ordering := #[21, 31, 13, 26, 5, 25, 10, 29, 37, 22, 7, 17, 6, 15, 14, 9, 12, 1, 20, 27, 24, 11,
    23, 8, 30, 4, 34, 16, 35, 28, 36, 2, 18, 19, 33, 32, 3]

/-- size 38, mask `0x03fffffffff`, tsv `total = 10` (closed form: `38*39/2 = 741 = 43*17 + 10`). -/
def w38 : PackedWitness where
  subsetMask := 0x03fffffffff
  ordering := #[31, 1, 6, 9, 23, 36, 10, 11, 26, 35, 24, 28, 29, 4, 21, 30, 37, 33, 32, 17, 15, 16,
    25, 3, 5, 18, 12, 14, 7, 20, 38, 19, 22, 34, 2, 13, 27, 8]

/-- size 39, mask `0x07fffffffff`, tsv `total = 6` (closed form: `39*40/2 = 780 = 43*18 + 6`). -/
def w39 : PackedWitness where
  subsetMask := 0x07fffffffff
  ordering := #[15, 13, 2, 26, 4, 28, 30, 9, 21, 12, 3, 25, 31, 29, 39, 17, 19, 22, 34, 32, 37, 8,
    11, 20, 38, 18, 36, 5, 23, 35, 10, 14, 33, 27, 1, 16, 24, 6, 7]

/-- size 40, mask `0x0ffffffffff`, tsv `total = 3` (closed form: `40*41/2 = 820 = 43*19 + 3`). -/
def w40 : PackedWitness where
  subsetMask := 0x0ffffffffff
  ordering := #[11, 1, 40, 18, 2, 38, 25, 39, 24, 13, 23, 12, 19, 34, 16, 26, 35, 15, 30, 31, 36,
    6, 17, 21, 32, 28, 20, 8, 7, 5, 14, 27, 9, 29, 33, 4, 3, 22, 37, 10]

/-- size 41 (the UNIQUE canonical representative for this size --
`representativesBySize.41 = 1` in `generator-summary.json`), mask `0x1ffffffffff`,
tsv `total = 1` (closed form: `41*42/2 = 861 = 43*20 + 1`). -/
def w41 : PackedWitness where
  subsetMask := 0x1ffffffffff
  ordering := #[35, 37, 32, 29, 13, 14, 36, 40, 38, 33, 3, 39, 8, 20, 18, 28, 5, 22, 19, 27, 2, 9,
    24, 15, 10, 25, 6, 41, 1, 11, 12, 7, 23, 17, 31, 4, 16, 26, 30, 21, 34]

/-- size 42 (the UNIQUE canonical representative -- the FULL nonzero group `Z_43 \ {0}`;
`representativesBySize.42 = 1`), mask `0x3ffffffffff`, tsv `total = 0`: this is the forced
full-set zero-final-sum case the "Statement" section's "`s_i ≠ 0` for `1 ≤ i < m`" clause
deliberately excludes `s_m` for (closed form: `42*43/2 = 903 = 43*21 ≡ 0`). -/
def w42 : PackedWitness where
  subsetMask := 0x3ffffffffff
  ordering := #[2, 33, 21, 8, 16, 39, 20, 7, 38, 10, 19, 17, 35, 31, 41, 34, 22, 36, 27, 18, 28, 5,
    6, 26, 23, 11, 40, 14, 37, 9, 3, 42, 29, 4, 32, 30, 12, 24, 15, 1, 13, 25]

/-! ## Step 1: the checker accepts every one of them (native_decide) -/

theorem w36_checks : checkWitness w36 = true := by native_decide
theorem w37_checks : checkWitness w37 = true := by native_decide
theorem w38_checks : checkWitness w38 = true := by native_decide
theorem w39_checks : checkWitness w39 = true := by native_decide
theorem w40_checks : checkWitness w40 = true := by native_decide
theorem w41_checks : checkWitness w41 = true := by native_decide
theorem w42_checks : checkWitness w42 = true := by native_decide

/-! ## Step 2: the ONE soundness theorem turns each into a genuine `Sequenceable` proof -/

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
theorem w41_sequenceable : Sequenceable (decodeSubset w41.subsetMask) :=
  checkWitness_sound w41 w41_checks
theorem w42_sequenceable : Sequenceable (decodeSubset w42.subsetMask) :=
  checkWitness_sound w42 w42_checks

/-! ## Step 3 (sanity): the size-42 witness really decodes to the FULL nonzero group

Ties the sample directly back to what this PARTIAL corpus actually certifies: confirms
`decodeSubset` on the size-42 mask really does produce all of `Z_43 \ {0}`, not merely *some*
42-element set. -/

theorem w42_is_full_nonzero_group :
    decodeSubset w42.subsetMask = (Finset.univ : Finset (ZMod 43)) \ {0} := by
  native_decide

/-- Bundled headline result: all 7 real, independently-transcribed sample witnesses -- one per
subset size 36 through 42, including the forced full-set zero-final-sum case -- are certified
sequenceable by the SAME single soundness theorem, `checkWitness_sound`. This is a sample of the
148,157-witness corpus, not the corpus itself; the corpus's exhaustiveness claim rests on the
Go/Python verifiers' independent orbit-accounting (see the evidence directory), not on this
Lean file re-checking all 148,157 rows. -/
theorem sample_all_sequenceable :
    Sequenceable (decodeSubset w36.subsetMask) ∧ Sequenceable (decodeSubset w37.subsetMask) ∧
    Sequenceable (decodeSubset w38.subsetMask) ∧ Sequenceable (decodeSubset w39.subsetMask) ∧
    Sequenceable (decodeSubset w40.subsetMask) ∧ Sequenceable (decodeSubset w41.subsetMask) ∧
    Sequenceable (decodeSubset w42.subsetMask) :=
  ⟨w36_sequenceable, w37_sequenceable, w38_sequenceable, w39_sequenceable, w40_sequenceable,
    w41_sequenceable, w42_sequenceable⟩

#print axioms w36_checks
#print axioms w36_sequenceable
#print axioms sample_all_sequenceable

end GrahamZ43.Sample
