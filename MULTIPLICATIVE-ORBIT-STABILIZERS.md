# Multiplicative-orbit stabilizers in the finite certificate families

**Author:** Jared Wilder  
**Recovered from:** the September 2026 divergent-mirror audit  
**Scope:** exact structure of the `Z_p^×` orbit reduction used by the finite sequenceability certificates; this note does not alter the underlying sequenceability theorem/certificate claims.

Let `G = Z_p^×` act on subsets `A ⊆ G` by multiplication:

\[
u\cdot A=\{ua:a\in A\}.
\]

The finite certificate pipeline stores one representative per multiplicative orbit. The divergent mirror contained an exact stabilizer census that was not visible in the main subject repository.

## Exact orbit-size histograms recovered

For the audited certificate families:

```text
p = 29   orbit sizes {28: 60098, 14: 33, 7: 1, 4: 1, 1: 1}
p = 47   orbit sizes {46: 237282, 23: 89, 1: 1}
p = 61   orbit sizes {60: 8720, 30: 15, 20: 1, 15: 1, 1: 1}
```

Since `|G|=p-1`, an orbit of size `m` has stabilizer order `(p-1)/m` by orbit–stabilizer.

Thus, for example, the exceptional `p=61` orbit sizes correspond to stabilizer orders

```text
60 -> 1
30 -> 2
20 -> 3
15 -> 4
1  -> 60.
```

## Structural lemma

Let `H ≤ G` be a subgroup and `A ⊆ G`.

Then

\[
H\le \operatorname{Stab}(A)
\]

if and only if `A` is a union of multiplicative `H`-cosets. Equivalently, because `G\A` is invariant exactly when `A` is invariant,

\[
H\le \operatorname{Stab}(A)
\]

if and only if the complement `G\A` is a union of `H`-cosets.

### Proof

If `H≤Stab(A)`, then for every `a∈A` the full orbit `Ha` lies in `A`, so `A` is a union of `H`-cosets. Conversely, if `A` is a union of `H`-cosets, multiplication by any `h∈H` permutes those cosets and therefore fixes `A` setwise. The complement formulation is identical. ∎

### Equality warning

The statement

> `Stab(A)=H` iff the complement is a union of `H`-cosets

is too strong without an additional condition excluding invariance under a larger subgroup. Union-of-`H`-cosets proves `H≤Stab(A)`. Exact equality follows when no proper supergroup of `H` also preserves the set.

## Explicit `p=61` examples

The mirror identifies two exceptional representatives by their complements.

### Stabilizer of order 4

For a `|A|=56` representative, the complement is

\[
\{1,11,50,60\}.
\]

This four-element set is the order-4 subgroup of `Z_61^×`. Hence the corresponding `A` is invariant under that subgroup, yielding an orbit of size

\[
60/4=15.
\]

This matches the unique orbit-size-15 entry in the recovered histogram.

### Stabilizer of order 3

For a `|A|=57` representative, the complement is

\[
\{14,48,60\}=14\cdot\{1,13,47\},
\]

where `{1,13,47}` is the order-3 subgroup of `Z_61^×`. Hence the corresponding `A` is invariant under an order-3 subgroup, giving orbit size

\[
60/3=20,
\]

matching the unique orbit-size-20 entry.

## Why this belongs in the subject repository

The orbit compression is not merely an implementation detail. These stabilizers explain exactly why certain certificate families have smaller-than-generic multiplicative orbits and provide a direct algebraic check on the orbit-count ledger.

The generic orbit has size `p-1`; smaller orbits occur precisely when the subset carries nontrivial multiplicative symmetry.

## Provenance / authority

The histogram and explicit exceptional complements are recovered from the divergent-mirror audit. This note promotes that mathematics into the canonical sequenceability home and supplies the elementary group-action proof that explains the observed orbit sizes.

It does **not** claim a new global sequenceability theorem, and it does not substitute for the independent certificate/verifier layers already present in this repository.
