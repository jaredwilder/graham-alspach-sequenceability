# Round 4 Result — Graham/Alspach for \(\mathbb Z_{29}\)

## Theorem established by the shipped certificate

Every subset \(A\subseteq\mathbb Z_{29}\setminus\{0\}\) admits an ordering \(a_1,\ldots,a_m\) whose partial sums are pairwise distinct and whose proper partial sums are nonzero.

## New computational range

Published general results cover every subset of size at most 20. Round 4 exhaustively certifies all remaining sizes 21 through 28.

## Certificate proof structure

1. Multiplication by a nonzero residue preserves sequencing: a witness for \(A\) scales to a witness for \(uA\).
2. The generator emits one canonical representative for every multiplicative orbit in every target cardinality.
3. Each representative row contains the exact set, its total, and an explicit ordering.
4. The Go verifier independently:
   - validates every representative witness;
   - validates every scaled witness for every unit;
   - reconstructs every covered subset in a \(2^{28}\)-bit universe;
   - rejects duplicate coverage and checks exact binomial totals.
5. The Python verifier independently:
   - recomputes canonical representatives and stabilizers;
   - validates every representative witness;
   - proves disjoint orbit coverage by exact orbit-size accounting.
6. Four corrupted-certificate classes are rejected by both verifiers.
7. Regeneration with 48 and 16 threads produces the identical certificate hash.

## Verified numbers

- Certificate rows: **60,134**
- Covered subsets: **1,683,218**
- Scaled witnesses checked: **1,683,752**
- Missing subsets: **0**
- Invalid witnesses: **0**
- Certificate SHA-256: `4dd6b2b21f75ffdd1ff472d1bf9a70757ccea0b31f147d49c6b1ff675c5ef961`
- Deterministic regeneration: **PASS**
- Adversarial mutation suite: **8/8 verifier rejections**

## Status

- Computational theorem: **VERIFIED**
- Reproducible release: **PASS**
- Search-result integrity: **PASS**
- External peer review: **NOT CLAIMED**
- Novelty/priority: **PROSPECTIVE; no explicit prior \(\mathbb Z_{29}\) result found in the recorded search**
