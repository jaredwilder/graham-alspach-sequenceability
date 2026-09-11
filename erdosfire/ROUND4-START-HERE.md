# ERDŐSFIRE Round 4 — Prospective Novel Mathematics

## Result

Round 4 produced and independently verified a computational proof certificate for the remaining unresolved cardinalities in the Graham/Alspach sequenceability problem for the cyclic group \(\mathbb Z_{29}\).

The certificate covers every subset

\[
A\subseteq \mathbb Z_{29}\setminus\{0\},\qquad 21\le |A|\le 28,
\]

through one canonical representative from each orbit under multiplication by \(\mathbb Z_{29}^{\times}\). Every representative carries an explicit sequencing witness. Independent verification reconstructs exact orbit coverage and validates all witnesses.

Combined with the published theorem that every subset of size at most 20 in an arbitrary abelian group is sequenceable, the certificate establishes the Graham/Alspach conjecture for \(\mathbb Z_{29}\).

## One-command verification

From the repository root:

```bash
cd CONTEXT
npm run oracle:frontier-math:round4:verify
```

Full deterministic regeneration plus both verifiers and adversarial mutation tests:

```bash
cd CONTEXT
npm run oracle:frontier-math:round4:full -- --threads 16
```

Direct Python entry point:

```bash
python3 oracle/tools/frontier-math/round4/graham-z29/round4_release.py full --threads 16
```

## Proof artifacts

- Certificate: `evidence/round4-discovery/graham-z29/witnesses.tsv`
- Certificate SHA-256: `4dd6b2b21f75ffdd1ff472d1bf9a70757ccea0b31f147d49c6b1ff675c5ef961`
- C++ witness generator: `oracle/tools/frontier-math/round4/graham-z29/generate_witnesses.cpp`
- Go full-expansion verifier: `oracle/tools/frontier-math/round4/graham-z29/verify_witnesses.go`
- Python orbit-accounting verifier: `oracle/tools/frontier-math/round4/graham-z29/verify_orbit_accounting.py`
- Adversarial tests: `oracle/tools/frontier-math/round4/graham-z29/adversarial_certificate_tests.py`
- Paper source: `round4-paper-graham-z29/main.tex`
- Machine-readable result: `ROUND4-RESULT.json`

## Exact verified totals

| Subset size | All subsets | Orbit representatives |
|---:|---:|---:|
| 21 | 1,184,040 | 42,288 |
| 22 | 376,740 | 13,468 |
| 23 | 98,280 | 3,510 |
| 24 | 20,475 | 735 |
| 25 | 3,276 | 117 |
| 26 | 378 | 14 |
| 27 | 28 | 1 |
| 28 | 1 | 1 |
| **Total** | **1,683,218** | **60,134** |

The Go verifier performs 1,683,752 scaled-witness checks and marks all 1,683,218 subsets in an independent bitset. The Python verifier separately proves coverage by canonical-orbit accounting.

## Claim discipline

The mathematical certificate is complete and locally reproducible. The priority claim is **prospective**: a targeted literature search found no explicit prior proof for \(\mathbb Z_{29}\), but worldwide priority requires external scholarly review. The package does not claim peer review or independent human adjudication that has not occurred.
