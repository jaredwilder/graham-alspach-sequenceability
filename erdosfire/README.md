# ERDŐSFIRE Frontier Math Autopilot — Round 4

**Current result:** a dual-verified computational proof certificate for the Graham/Alspach conjecture in $\mathbb Z_{29}$. Read [`ROUND4-START-HERE.md`](ROUND4-START-HERE.md).

Round 2 and all later recovery artifacts remain preserved below.

---

# ERDŐSFIRE Frontier Math Autopilot — Round 2

This package is the Round 2 implementation built directly on the Round 1 fail-closed research and closure kernel.

Round 2 supplies the missing autonomous front half: problem acquisition, raw-statement intake, independent dual formalization, conformance review, theorem-DAG generation, adaptive strategy search, exact proof/counterexample certificates, model-worker routing, and a model-to-Lean compiler-feedback lane.

## Begin

Read `ROUND2-START-HERE.md`.

## Main entrypoints

- One-shot CLI: `oracle/server/scripts/frontier-math-round2.ts`
- Persistent autopilot: `oracle/server/scripts/frontier-math-round2-autopilot.ts`
- API: `POST /oracle/frontier-math/round2`
- Offline benchmark: `oracle/server/scripts/benchmark-frontier-math-round2.ts`
- System test: `oracle/server/scripts/frontier-math-round2-systemtest.ts`
- Exact worker: `oracle/tools/frontier-math/sympy_worker.py`
- Release evidence: `evidence/round2-final/`

## Non-negotiable claim policy

The search layer may create candidate proofs and disproofs. It cannot emit a terminal truth claim. Final `PROVED` or `DISPROVED` promotion remains controlled by the signed, fail-closed Round 1 closure predicate.

## Honest release statement

The package contains a commissioned offline exact lane and executable adapters for frontier-model and Lean workers. It does not claim that a new open theorem was discovered during packaging, and it does not manufacture external credentials, a Lean installation, or independent mathematical adjudication.
