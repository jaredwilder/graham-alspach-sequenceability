# Graham–Alspach sequenceability in `Z_29` and `Z_31`

Verified finite ranges for the Graham–Alspach sequenceability problem in `Z_29` and `Z_31`, with explicit witnesses, independent checking, and reproducible regeneration.

Author: Jared Wilder. First public timestamp: 2026-09-10.

## Verified ranges

- **`Z_29`: subset cardinalities 21 through 28.** One representative witness per cardinality range/orbit structure, checked independently and regenerated reproducibly.
- **`Z_31`: subset cardinalities 21 through 30.** Verified with an independent byte-identical regeneration.

Larger-group extensions are published separately in `jaredwilder/graham-alspach-extended`.

## Lean verification boundary

The Lean witness checks depend on Mathlib's standard classical axioms `{propext, Classical.choice, Quot.sound}` plus one `native_decide` evaluation per witness.

`native_decide` asks the compiled decision procedure to evaluate the finite witness. It is therefore a compiler-backed finite check rather than a proof reduced entirely by the Lean kernel. `GrahamZ29Verify.lean` records that dependency explicitly.

The mathematical claim is still concrete: the listed finite witnesses satisfy the sequenceability predicate. The verification boundary tells the reader how that fact was checked.

## Generalized checker

`proofs/graham-general/` contains a checker and soundness theorem parameterized by the prime `p`. It is specialized back to `p=29` and rerun on the original eight witnesses, reproducing the same accepted witnesses and conclusions.

That back-check verifies that the generalized implementation preserves the original `Z_29` calculation rather than merely type-checking in isolation.

## Reproducibility material

- `proofs/.oracle-lean-verify/` — historical directory containing independent rechecks and negative controls;
- `erdosfire/` — historical build and run records from the research process that produced the certificates.

The directory names are retained for provenance; neither is needed to understand the theorem statement itself.

## License

Apache-2.0.