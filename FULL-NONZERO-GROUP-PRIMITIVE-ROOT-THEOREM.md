# Full nonzero `Z_p` is sequenceable by primitive-root order

**Author:** Jared Wilder  
**Status:** elementary theorem  
**Program:** Graham–Alspach sequenceability

Let `p` be an odd prime and let `g` be a primitive root modulo `p`.

Consider the ordering of every nonzero residue

\[
\boxed{g,g^2,g^3,\ldots,g^{p-1}}\pmod p.
\]

This ordering sequences the full set

\[
\mathbb Z_p\setminus\{0\}.
\]

In particular, every proper partial sum is nonzero and the partial sums are pairwise distinct.

## Proof

For `1<=k<=p-1`, the `k`-th partial sum is

\[
s_k=g+g^2+\cdots+g^k
=\frac{g(g^k-1)}{g-1}\pmod p.
\]

Because `g` is primitive, its multiplicative order is `p-1`.

For every proper partial sum `1<=k<p-1`,

\[
g^k\ne1\pmod p,
\]

so

\[
s_k\ne0\pmod p.
\]

At the final step `k=p-1`, `g^{p-1}=1`, so the total sum is zero, as it must be for the sum of all nonzero residues modulo an odd prime.

Now suppose

\[
s_j=s_k
\]

for `1<=j,k<=p-1`. Since `g` and `g-1` are nonzero modulo `p`, the displayed formula gives

\[
g^j=g^k.
\]

Primitivity then forces

\[
j\equiv k\pmod{p-1}.
\]

Within `1,...,p-1`, this means `j=k`. Hence all partial sums are distinct.

Therefore the primitive-root ordering is a valid sequenceability certificate for the full nonzero group.

## Consequence for the certificate estate

Any computational certificate whose subset is exactly

\[
\mathbb Z_p\setminus\{0\}
\]

is mathematically redundant once a primitive root is known: the explicit ordering above gives a deterministic certificate immediately.

This does **not** trivialize the difficult proper-subset cases in the surrounding Graham–Alspach program. It removes only the size-`p-1` endpoint rows.

## Why this was worth promoting

One recovered `Z_73` full-group witness was produced by simulated annealing after roughly 61,532 restarts and 1.845 billion annealing steps. The resulting ordering is valid, but the existence statement needs no search at all.

For `p=73`, one primitive root is `5`, giving the deterministic ordering

`5,25,52,41,59,3,15,2,10,50,...` modulo 73.

## Verification

The companion script `verify_primitive_root_sequenceability.py` checks the theorem computationally for every odd prime below 300, finding zero failures. The proof above is general and does not depend on that finite check.

## Provenance

Recovered from the divergent-mirror audit. The mirror contained expensive full-group witness bytes while another part of the estate already knew the primitive-root idea; this file makes the theorem explicit in the canonical sequenceability repository.

Historical novelty is not claimed.
