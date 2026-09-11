/-
GrahamZ37Sound.lean

The ONE soundness theorem for the packed certificate checker in `GrahamZ37Checker.lean`
(ERDŐSFIRE-FERRARI §3.3). Z_37-specific mirror of
`public/proofs/graham-z31/GrahamZ31Sound.lean` (`31 -> 37` throughout; no other change -- none
of the lemmas below depend on the modulus being prime, on its concrete value, or on the packed
mask's machine-word width (that width concern is entirely inside `GrahamZ37Checker.lean`'s
`decodeSubset`/`PackedWitness`, which this file imports and treats opaquely) -- they are generic
`List`/`ZMod` reasoning instantiated at `ZMod 37` instead of `ZMod 31`. This is the real
mathematical content: it connects the efficient, `native_decide`-friendly Boolean pipeline to a
faithful, independent Lean transcription of the Graham/Alspach rearrangement conjecture's
"Statement" (same statement as `Z_29`'s and `Z_31`'s, instantiated at `Z_37`), so that ANY
witness satisfying `checkWitness w = true` yields a genuine proof that
`decodeSubset w.subsetMask` is sequenceable -- proved ONCE, here, regardless of how many
witnesses the corpus has (298,344 for `Z_37` sizes 29-36).
-/
import GrahamZ37Checker
import Batteries.Data.List.Scan

namespace GrahamZ37

/-! ## 1. Faithful (Prop-level) formalization of the paper's "Statement" section

This definition is deliberately independent of the checker's internals: `(l.take (i+1)).sum`
is the literal `s_i = sum_{j=1}^i a_j` from the paper (`i` here is the 0-indexed position, so
the paper's `s_{i+1}` is `(l.take (i+1)).sum`), and distinctness / non-vanishing are stated
directly over those sums, not over any intermediate computed list. The soundness theorem below
is what proves the efficient pipeline actually computes this. -/

/-- `l` sequences the finite set `A`: `l` enumerates `A` exactly once each (no repeats, no
omissions), its partial sums are pairwise distinct, and every partial sum except possibly the
very last is nonzero. Literal transcription of the paper's "Statement" section, instantiated
at `Z_37`. -/
def Sequences (l : List (ZMod 37)) (A : Finset (ZMod 37)) : Prop :=
  l.Nodup ∧ l.toFinset = A ∧
    (∀ i j, i < l.length → j < l.length → i ≠ j →
      (l.take (i + 1)).sum ≠ (l.take (j + 1)).sum) ∧
    (∀ i, i + 1 < l.length → (l.take (i + 1)).sum ≠ 0)

/-- `A` is sequenceable when some ordering sequences it -- the Theorem: "Every subset
`A ⊆ Z_37 \ {0}` [of the sizes actually certified -- see `GrahamZ37Checker.lean`'s module
docstring: this corpus covers sizes 29-36 only] is sequenceable." -/
def Sequenceable (A : Finset (ZMod 37)) : Prop := ∃ l, Sequences l A

/-! ## 2. Connecting the efficient checker's `partialSums` to real sums

`partialSums` is built on Batteries' `List.partialSums`, which already carries a proven index
lemma (`List.getElem_partialSums`) -- so the connection to `List.take _ |>.sum` below is a
composition of already-proven library facts, not a from-scratch induction. -/

theorem partialSums_length (l : List (ZMod 37)) : (partialSums l).length = l.length := by
  simp [partialSums, List.length_partialSums]

/-- The position-`j` entry of the checker's `partialSums l` really is the mathematical partial
sum `(l.take (j+1)).sum`. This is the load-bearing bridge lemma: everything below reduces to it
plus standard `List` index-reasoning. -/
theorem partialSums_getElem (l : List (ZMod 37)) (j : ℕ) (hj : j < l.length) :
    (partialSums l)[j]'(by rw [partialSums_length]; exact hj) = (l.take (j + 1)).sum := by
  have hb : 1 + j < l.partialSums.length := by rw [List.length_partialSums]; omega
  have step : (partialSums l)[j]'(by rw [partialSums_length]; exact hj)
      = l.partialSums[1 + j]'hb := by
    simp only [partialSums]
    exact List.getElem_drop
  rw [step, List.getElem_partialSums hb]
  have e : (1 : ℕ) + j = j + 1 := by omega
  rw [e]

/-! ## 3. `partialSumsDistinct = true` really means pairwise-distinct partial sums -/

theorem partialSumsDistinct_sound (l : List (ZMod 37))
    (h : partialSumsDistinct (partialSums l) = true) :
    ∀ i j, i < l.length → j < l.length → i ≠ j →
      (l.take (i + 1)).sum ≠ (l.take (j + 1)).sum := by
  have h' : decide (partialSums l).Nodup = true := h
  have hnd : (partialSums l).Nodup := of_decide_eq_true h'
  have hinj := List.nodup_iff_injective_getElem.mp hnd
  intro i j hi hj hij heq
  have hi' : i < (partialSums l).length := by rw [partialSums_length]; exact hi
  have hj' : j < (partialSums l).length := by rw [partialSums_length]; exact hj
  have e1 : (partialSums l)[i]'hi' = (l.take (i + 1)).sum := partialSums_getElem l i hi
  have e2 : (partialSums l)[j]'hj' = (l.take (j + 1)).sum := partialSums_getElem l j hj
  have hFinEq : (⟨i, hi'⟩ : Fin (partialSums l).length) = ⟨j, hj'⟩ :=
    hinj (show (partialSums l)[i]'hi' = (partialSums l)[j]'hj' by rw [e1, e2, heq])
  exact hij (congrArg Fin.val hFinEq)

/-! ## 4. `properPartialSumsNonzero = true` really means all-but-last are nonzero -/

theorem properPartialSumsNonzero_sound (l : List (ZMod 37))
    (h : properPartialSumsNonzero (partialSums l) = true) :
    ∀ i, i + 1 < l.length → (l.take (i + 1)).sum ≠ 0 := by
  have h' : (partialSums l).dropLast.all (fun s => decide (s ≠ 0)) = true := h
  have hall : ∀ s ∈ (partialSums l).dropLast, s ≠ 0 := by
    intro s hs
    exact of_decide_eq_true (List.all_eq_true.mp h' s hs)
  intro i hi
  have hib' : i < (partialSums l).dropLast.length := by
    rw [List.length_dropLast, partialSums_length]; omega
  have hib : i < (partialSums l).length := by rw [partialSums_length]; omega
  have hget : (partialSums l).dropLast[i]'hib' = (partialSums l)[i]'hib :=
    List.getElem_dropLast hib'
  have hmem : (partialSums l).dropLast[i]'hib' ∈ (partialSums l).dropLast :=
    List.mem_iff_getElem.mpr ⟨i, hib', rfl⟩
  have hne : (partialSums l).dropLast[i]'hib' ≠ 0 := hall _ hmem
  rw [hget] at hne
  rwa [partialSums_getElem l i (by omega)] at hne

/-! ## 5. The ONE soundness theorem (ERDŐSFIRE-FERRARI §3.3)

Any packed witness the Boolean checker accepts really does certify sequenceability of the
subset it decodes to. This is proved ONCE; every one of the corpus's 298,344 canonical-orbit
witnesses (sizes 29-36) becomes a `native_decide`-checkable instantiation of it, never a
separate theorem. -/

theorem checkWitness_sound (w : PackedWitness) (h : checkWitness w = true) :
    Sequenceable (decodeSubset w.subsetMask) := by
  have h' : (orderingMatchesSubset (decodeSubset w.subsetMask) (decodeOrdering w.ordering) &&
      properPartialSumsNonzero (partialSums (decodeOrdering w.ordering)) &&
      partialSumsDistinct (partialSums (decodeOrdering w.ordering))) = true := h
  simp only [Bool.and_eq_true] at h'
  obtain ⟨⟨hmatch, hproper⟩, hdistinct⟩ := h'
  set ordering := decodeOrdering w.ordering with hordering
  have hmatch' : decide (ordering.toFinset = decodeSubset w.subsetMask) = true ∧
      decide ordering.Nodup = true := by
    have := hmatch
    unfold orderingMatchesSubset at this
    simpa only [Bool.and_eq_true] using this
  have hmatchFinset : ordering.toFinset = decodeSubset w.subsetMask := of_decide_eq_true hmatch'.1
  have hnodup : ordering.Nodup := of_decide_eq_true hmatch'.2
  exact ⟨ordering, hnodup, hmatchFinset,
    partialSumsDistinct_sound ordering hdistinct,
    properPartialSumsNonzero_sound ordering hproper⟩

#print axioms partialSums_length
#print axioms partialSums_getElem
#print axioms partialSumsDistinct_sound
#print axioms properPartialSumsNonzero_sound
#print axioms checkWitness_sound

end GrahamZ37
