# Round 3 Adversarial Recovery Status

Status: RECOVERED_WIP_NOT_COMPLETE

Preserved:
- Round 2 codebase and artifacts
- Original Round 3 F_29 search engine source and executable
- Adversarial probe progress log
- Z3 single-mask solver prototype
- Simulated-annealing search prototype and compiled executable

Verified observations:
- Orbit reduction enumerated 60,118 representatives for subset sizes 21 through 25.
- The interrupted probe reached all 60,118 representatives.
- It reported `no ordering found for 0x5fffffb`.
- This is NOT a certified counterexample because the recovered DFS uses a hard node limit and returns `false` on exhaustion without distinguishing UNKNOWN from UNSAT.
- The recovered certificate path is empty; no theorem, disproof, or coverage certificate is claimed.

Required next repair:
1. Replace Boolean DFS with tri-state SAT / UNSAT / UNKNOWN.
2. Never memoize or promote a node-limit exhaustion as a dead state.
3. Add resumable deterministic shards and per-shard coverage receipts.
4. Add an independent certificate verifier.
5. Re-run the candidate mask with an exact solver before any mathematical claim.
