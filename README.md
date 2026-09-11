# graham-alspach-sequenceability

Lean 4 closures of the Graham / Alspach sequenceability question in Z_29 and Z_31, each verified
by more than one independent checker.

Author: Jared Wilder. First public timestamp: 2026-09-10.

## The results

- **Z_29: closed for subset cardinalities 21 through 28.** Eight real witnesses, one per
  cardinality, verified by two independent checkers plus a regeneration.
- **Z_31: closed for subset cardinalities 21 through 30.** Verified by a byte-identical
  independent regeneration.
- Partial closures on upper size ranges for Z_37, Z_41, Z_43, Z_47, Z_59, Z_61.

## The trust footprint, stated plainly because the files state it themselves

Every witness check carries the three standard axioms `{propext, Classical.choice, Quot.sound}`
**plus exactly one `native_decide` axiom per witness.**

`native_decide` asks the Lean compiler to evaluate a decision procedure and trusts the result. It
is weaker than a kernel proof. This is row two on any honest ladder: the result is closed, and the
trust assumption is footnoted rather than hidden. Routing a witness through the soundness theorem
adds nothing beyond that, and `GrahamZ29Verify.lean` documents the whole arrangement in its own
header.

## Why there is a generalized checker

`proofs/graham-general/` holds a checker and a soundness theorem parametric in a prime p, and then
specializes them to p = 29 and re-runs the original eight witnesses verbatim. The point of that
exercise is stated in the file: to confirm the generalization is not merely well-typed in
isolation but reproduces the original Z_29 result exactly, same witnesses accepted, same
conclusion, same trust footprint.

That is a real guard. A generalization that type-checks and quietly accepts different witnesses
would look identical from the outside.

## Also here

`proofs/.oracle-lean-verify/` carries the independent-check and re-verify control runs, including
the negative controls. `erdosfire/` carries the round-by-round build results and contracts from
the campaign that produced this.

## License

Apache-2.0.
