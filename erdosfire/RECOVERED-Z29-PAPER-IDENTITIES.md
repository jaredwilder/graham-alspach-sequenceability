# Recovered ErdősFire Z29 Paper Identities

**Public release:** 2026-09-10  
**Recovered source:** `round4-paper-graham-z29/main.tex`

The estate atlas contains two pure-mathematics identities from the recovered Round-4 Z29 paper that were not surfaced in this repository's top-level README.

## Full Z29 theorem as stated in the recovered paper

> **Theorem.** Every subset
> \[
> A\subseteq \mathbb Z_{29}\setminus\{0\}
> \]
> is sequenceable.

**Recovered atlas status:** `THEOREM`.

This file preserves the statement exactly as recovered from the paper source. It does **not** claim that the full theorem was independently re-proved during the 2026-09-10 release pass. The current repository's directly advertised formal/computational contribution is the closure of subset cardinalities 21 through 28 with disclosed `native_decide` trust; the recovered paper theorem may additionally use prior known lower-cardinality results. Those ingredients should be checked in the paper before citing the full statement as a new independent closure.

## Multiplicative-orbit lemma

If

\[
(a_1,\dots,a_m)
\]

sequences a subset `A`, then for every unit `u` of the cyclic group,

\[
(ua_1,\dots,ua_m)
\]

sequences `uA`.

This is the multiplicative-orbit reduction used to quotient equivalent subset instances.

**Recovered atlas status:** `LEMMA`.

## Why this note exists

The public repo already carries the actual Z29/Z31 witness machinery. This note closes a release-index gap: the paper-level theorem and its orbit lemma were present in the estate but absent from GitHub code search. They are now attached to the proper subject repository instead of being left in a generic frontier archive.
