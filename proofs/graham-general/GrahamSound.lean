/-
GrahamSound.lean

The ONE soundness theorem for the packed certificate checker in `GrahamChecker.lean`
(ERDŐSFIRE-FERRARI §3.3, generalized over an arbitrary prime `p`). This is a merge of
`public/proofs/graham-z29/GrahamZ29Sound.lean` and `public/proofs/graham-z31/GrahamZ31Sound.lean`
-- which are themselves already-identical mirrors of each other (`29 -> 31` throughout, no other
change; per `GrahamZ31Sound.lean`'s own module docstring, "none of the lemmas below depend on
the modulus being prime or on its concrete value, they are generic `List`/`ZMod` reasoning").
That observation is exactly what makes this generalization sound: every proof term below is the
SAME tactic script as the `Z_29`/`Z_31` originals, with the hardcoded modulus replaced by a bound
variable `p` and `[Fact p.Prime]` threaded through as an explicit hypothesis (carried to match
the paper's actual theorem scope, not because any individual step below case-splits on it).

This connects the efficient, `native_decide`-friendly Boolean pipeline to a faithful, independent
Lean transcription of the Graham/Alspach rearrangement conjecture's "Statement" (stated once,
for general `p`, instead of once per prime), so that ANY witness satisfying `checkWitness p w =
true` yields a genuine proof that `decodeSubset p w.subsetMask` is sequenceable -- proved ONCE,
here, regardless of how many primes or how many witnesses per prime the corpus has.
-/
import GrahamChecker
import Batteries.Data.List.Scan

namespace GrahamGeneral

/-! ## 1. Faithful (Prop-level) formalization of the paper's "Statement" section

This definition is deliberately independent of the checker's internals: `(l.take (i+1)).sum`
is the literal `s_i = sum_{j=1}^i a_j` from the paper (`i` here is the 0-indexed position, so
the paper's `s_{i+1}` is `(l.take (i+1)).sum`), and distinctness / non-vanishing are stated
directly over those sums, not over any intermediate computed list. The soundness theorem below
is what proves the efficient pipeline actually computes this. -/

/-- `l` sequences the finite set `A` in `ZMod p`: `l` enumerates `A` exactly once each (no
repeats, no omissions), its partial sums are pairwise distinct, and every partial sum except
possibly the very last is nonzero. Literal transcription of the paper's "Statement" section,
generalized to an arbitrary prime `p` instead of fixed at `29` or `31`. -/
def Sequences (p : ℕ) [Fact p.Prime] (l : List (ZMod p)) (A : Finset (ZMod p)) : Prop :=
  l.Nodup ∧ l.toFinset = A ∧
    (∀ i j, i < l.length → j < l.length → i ≠ j →
      (l.take (i + 1)).sum ≠ (l.take (j + 1)).sum) ∧
    (∀ i, i + 1 < l.length → (l.take (i + 1)).sum ≠ 0)

/-- `A` is sequenceable when some ordering sequences it -- the Theorem, generalized: "Every
subset `A ⊆ Z_p \ {0}` is sequenceable," for whichever prime `p` is fixed by the caller. -/
def Sequenceable (p : ℕ) [Fact p.Prime] (A : Finset (ZMod p)) : Prop := ∃ l, Sequences p l A

/-! ## 2. Connecting the efficient checker's `partialSums` to real sums

`partialSums` is built on Batteries' `List.partialSums`, which already carries a proven index
lemma (`List.getElem_partialSums`) -- so the connection to `List.take _ |>.sum` below is a
composition of already-proven library facts, not a from-scratch induction. Nothing here inspects
`p` beyond passing it through to `partialSums`/`ZMod p`. -/

theorem partialSums_length (p : ℕ) [Fact p.Prime] (l : List (ZMod p)) :
    (partialSums p l).length = l.length := by
  simp [partialSums, List.length_partialSums]

/-- The position-`j` entry of the checker's `partialSums p l` really is the mathematical partial
sum `(l.take (j+1)).sum`. This is the load-bearing bridge lemma: everything below reduces to it
plus standard `List` index-reasoning. -/
theorem partialSums_getElem (p : ℕ) [Fact p.Prime] (l : List (ZMod p)) (j : ℕ)
    (hj : j < l.length) :
    (partialSums p l)[j]'(by rw [partialSums_length]; exact hj) = (l.take (j + 1)).sum := by
  have hb : 1 + j < l.partialSums.length := by rw [List.length_partialSums]; omega
  have step : (partialSums p l)[j]'(by rw [partialSums_length]; exact hj)
      = l.partialSums[1 + j]'hb := by
    simp only [partialSums]
    exact List.getElem_drop
  rw [step, List.getElem_partialSums hb]
  have e : (1 : ℕ) + j = j + 1 := by omega
  rw [e]

/-! ## 3. `partialSumsDistinct = true` really means pairwise-distinct partial sums -/

theorem partialSumsDistinct_sound (p : ℕ) [Fact p.Prime] (l : List (ZMod p))
    (h : partialSumsDistinct p (partialSums p l) = true) :
    ∀ i j, i < l.length → j < l.length → i ≠ j →
      (l.take (i + 1)).sum ≠ (l.take (j + 1)).sum := by
  have h' : decide (partialSums p l).Nodup = true := h
  have hnd : (partialSums p l).Nodup := of_decide_eq_true h'
  have hinj := List.nodup_iff_injective_getElem.mp hnd
  intro i j hi hj hij heq
  have hi' : i < (partialSums p l).length := by rw [partialSums_length]; exact hi
  have hj' : j < (partialSums p l).length := by rw [partialSums_length]; exact hj
  have e1 : (partialSums p l)[i]'hi' = (l.take (i + 1)).sum := partialSums_getElem p l i hi
  have e2 : (partialSums p l)[j]'hj' = (l.take (j + 1)).sum := partialSums_getElem p l j hj
  have hFinEq : (⟨i, hi'⟩ : Fin (partialSums p l).length) = ⟨j, hj'⟩ :=
    hinj (show (partialSums p l)[i]'hi' = (partialSums p l)[j]'hj' by rw [e1, e2, heq])
  exact hij (congrArg Fin.val hFinEq)

/-! ## 4. `properPartialSumsNonzero = true` really means all-but-last are nonzero -/

theorem properPartialSumsNonzero_sound (p : ℕ) [Fact p.Prime] (l : List (ZMod p))
    (h : properPartialSumsNonzero p (partialSums p l) = true) :
    ∀ i, i + 1 < l.length → (l.take (i + 1)).sum ≠ 0 := by
  have h' : (partialSums p l).dropLast.all (fun s => decide (s ≠ 0)) = true := h
  have hall : ∀ s ∈ (partialSums p l).dropLast, s ≠ 0 := by
    intro s hs
    exact of_decide_eq_true (List.all_eq_true.mp h' s hs)
  intro i hi
  have hib' : i < (partialSums p l).dropLast.length := by
    rw [List.length_dropLast, partialSums_length]; omega
  have hib : i < (partialSums p l).length := by rw [partialSums_length]; omega
  have hget : (partialSums p l).dropLast[i]'hib' = (partialSums p l)[i]'hib :=
    List.getElem_dropLast hib'
  have hmem : (partialSums p l).dropLast[i]'hib' ∈ (partialSums p l).dropLast :=
    List.mem_iff_getElem.mpr ⟨i, hib', rfl⟩
  have hne : (partialSums p l).dropLast[i]'hib' ≠ 0 := hall _ hmem
  rw [hget] at hne
  rwa [partialSums_getElem p l i (by omega)] at hne

/-! ## 5. The ONE soundness theorem (ERDŐSFIRE-FERRARI §3.3, generalized)

Any packed witness the Boolean checker accepts, at any prime `p`, really does certify
sequenceability of the subset it decodes to. This is proved ONCE, for a general `p`; every
witness for every prime's corpus becomes a `native_decide`-checkable instantiation of it, never
a separate theorem, and never a separate copy of this proof per prime. -/

theorem checkWitness_sound (p : ℕ) [Fact p.Prime] (w : PackedWitness)
    (h : checkWitness p w = true) :
    Sequenceable p (decodeSubset p w.subsetMask) := by
  have h' : (orderingMatchesSubset p (decodeSubset p w.subsetMask) (decodeOrdering p w.ordering) &&
      properPartialSumsNonzero p (partialSums p (decodeOrdering p w.ordering)) &&
      partialSumsDistinct p (partialSums p (decodeOrdering p w.ordering))) = true := h
  simp only [Bool.and_eq_true] at h'
  obtain ⟨⟨hmatch, hproper⟩, hdistinct⟩ := h'
  set ordering := decodeOrdering p w.ordering with hordering
  have hmatch' : decide (ordering.toFinset = decodeSubset p w.subsetMask) = true ∧
      decide ordering.Nodup = true := by
    have := hmatch
    unfold orderingMatchesSubset at this
    simpa only [Bool.and_eq_true] using this
  have hmatchFinset : ordering.toFinset = decodeSubset p w.subsetMask := of_decide_eq_true hmatch'.1
  have hnodup : ordering.Nodup := of_decide_eq_true hmatch'.2
  exact ⟨ordering, hnodup, hmatchFinset,
    partialSumsDistinct_sound p ordering hdistinct,
    properPartialSumsNonzero_sound p ordering hproper⟩

#print axioms partialSums_length
#print axioms partialSums_getElem
#print axioms partialSumsDistinct_sound
#print axioms properPartialSumsNonzero_sound
#print axioms checkWitness_sound

end GrahamGeneral
