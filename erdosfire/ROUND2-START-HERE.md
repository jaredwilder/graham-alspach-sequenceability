# ERDŐSFIRE Round 2 — Start Here

Round 2 removes the Round 1 requirement that an operator supply Lean formalizations, theorem graphs, and open goals. The minimum input is a natural-language mathematical statement, a local source corpus, or an allowlisted HTTP source registry.

## Prove the shipped build

Run from the package root:

```bash
tsc -p oracle/tsconfig.frontier-math.json --noEmit

ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' oracle/server/scripts/frontier-math-selftest.ts

ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' oracle/server/scripts/frontier-math-systemtest.ts

ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' oracle/server/scripts/frontier-math-round2-systemtest.ts

ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' oracle/server/scripts/benchmark-frontier-math-round2.ts
```

Expected evidence:

- strict TypeScript: pass;
- Round 1 trust self-test: 27/27;
- Round 1 system test: 66/66;
- Round 2 system test: 36/36;
- commissioned Round 2 offline benchmark: 6/6;
- candidate proofs: 3;
- candidate disproofs: 3;
- false closures: 0.

## Run from natural language

```bash
ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' \
  oracle/server/scripts/frontier-math-round2.ts run \
  oracle/config/frontier-math/round2-offline-example.json
```

No formalization, theorem DAG, or open-goal fields are required.

## Acquire problems autonomously

Round 2 accepts:

- `problems`: inline typed statements;
- `sourcePaths`: JSON, JSONL, Markdown, or plain-text corpora;
- `httpSources`: allowlisted HTTPS registries with format, timeout, and byte limits.

Every HTTP pull is stored as an immutable raw snapshot plus a receipt containing the final URL, ETag, Last-Modified value, byte count, fetch time, problem count, and SHA-256 digest. Cross-host redirects are rejected. Plain HTTP is rejected except for localhost test fixtures.

See `oracle/config/frontier-math/round2-http-source-example.json`.

## Connect a frontier model

Use `oracle/config/frontier-math/round2-model-example.json`, or configure:

```text
ERDOSFIRE_MATH_MODEL_ENDPOINT
ERDOSFIRE_MATH_MODEL_NAME
ERDOSFIRE_MATH_MODEL_API_KEY_ENV
ERDOSFIRE_MATH_MODEL_ID
ERDOSFIRE_MATH_MODEL_VERSION
```

A command-line worker is supported through `ERDOSFIRE_MATH_MODEL_COMMAND`, `ERDOSFIRE_MATH_MODEL_ARGS`, and `ERDOSFIRE_MATH_MODEL_CWD`.

## Run continuously with crash-safe resume

```bash
ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' \
  oracle/server/scripts/frontier-math-round2-autopilot.ts run \
  oracle/config/frontier-math/round2-autopilot-example.json
```

Use `once` instead of `run` for one cycle. The autopilot persists a content-hashed state ledger, records every cycle in JSONL, refreshes configured sources, excludes already processed deterministic problem IDs, resumes after restart, and can stop when no unseen work remains.

## API

`POST /oracle/frontier-math/round2`

Required header: `Idempotency-Key`.

The endpoint ingests sources, creates two independent formalizations, performs two conformance reviews, constructs the theorem DAG, runs the adaptive certificate-first portfolio, records immutable events, and returns candidate proof/disproof campaigns. It emits no terminal truth claim.

## Exact verification

Set `ERDOSFIRE_SYMPY_STRICT_REPLAY=1` to force certificate regeneration in a second Python process. Default local mode validates the certificate hash and requires independent exact votes before emitting a candidate.

## Local machine profile

```bash
ts-node --transpile-only --compiler-options '{"module":"CommonJS","moduleResolution":"node","target":"ES2022","esModuleInterop":true}' \
  oracle/server/scripts/frontier-math-cli.ts doctor SYMPY,PYTHON \
  --profile rtx4080-16gb
```
