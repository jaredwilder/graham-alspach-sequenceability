# Graham–Alspach sequenceability in `Z_29` and `Z_31`

A subset `S⊂Z_p\setminus\{0\}` is sequenceable if its elements can be ordered so that all partial sums are distinct and no proper partial sum is zero.

This repository verifies the following finite ranges:

\[
\boxed{Z_{29}:\ |S|=21,22,\ldots,28}
\]

and

\[
\boxed{Z_{31}:\ |S|=21,22,\ldots,30}.
\]

These ranges extend beyond the published general theorem for subsets of size at most 20.

## Certificates

The repository contains explicit orderings for the verified subsets together with independent finite checks and reproducible regeneration.

A generalized checker under `proofs/graham-general/` is parameterized by the prime `p`; specializing it back to `p=29` reproduces the original eight witness families.

## Lean checks

The Lean witness files use Mathlib's standard classical axioms

```text
{propext, Classical.choice, Quot.sound}
```

and `native_decide` for the finite witness evaluations. The resulting checks are therefore compiler-evaluated finite certificates rather than fully kernel-reduced computations.

The theorem being checked is concrete in each case: the supplied ordering satisfies the sequenceability predicate.

## Larger groups

Further verified ranges and much larger finite computations are published in:

- [`graham-alspach-extended`](https://github.com/jaredwilder/graham-alspach-extended)
- [`graham-alspach-z53-z71`](https://github.com/jaredwilder/graham-alspach-z53-z71)

## Reproducibility

Historical build/recheck material remains under `proofs/.oracle-lean-verify/` and `erdosfire/`. Those directories preserve the original computations; the mathematical entry point is the verified range above.

Author: Jared Wilder. License: Apache-2.0.
