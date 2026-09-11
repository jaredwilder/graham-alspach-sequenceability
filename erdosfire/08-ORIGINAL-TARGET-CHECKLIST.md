# Binding original ERDŐSFIRE target checklist

> Copied verbatim from the uploaded packet. Do not bulk-check. Each checked item requires evidence or one valid explicit supersession.

# ERDŐSFIRE — FRONTIER MATH HUNTER

## 0. TERMINAL OBJECTIVE

* [ ] Input: arbitrary open mathematical problem
* [ ] Output: `PROVED | DISPROVED | NEW_PARTIAL | REDUCED | MISSTATED | REDISCOVERED | NOT_CLOSED`
* [ ] Produce:

  * [ ] Kernel-verified proof/disproof
  * [ ] Exact computational certificate
  * [ ] Natural-language proof
  * [ ] Novelty/prior-art report
  * [ ] Reproduction bundle
  * [ ] Complete attempt ledger
  * [ ] Unresolved theorem DAG
  * [ ] Highest-value next attack
* [ ] Close universal statements with universal arguments
* [ ] Reject finite-rung progress as conjecture closure
* [ ] Preserve `omega-ladder` as one strategy plugin
* [ ] Replace parameter-tuning RSI with cross-problem mathematical learning
* [ ] No mathematical claim without replayable evidence
* [ ] No LLM judgment accepted as verification
* [ ] No `sorry`
* [ ] No added axioms
* [ ] No theorem-statement mutation
* [ ] No literature claim without exact source mapping

---

# 1. SOTA FLOOR

* [ ] Reproduce AlphaProof Nexus:

  * [ ] Independent compiler-feedback proof loops
  * [ ] Evolutionary proof-sketch population
  * [ ] P-UCB exploration
  * [ ] Global formal-goal cache
  * [ ] SafeVerify terminal validation
  * [ ] Baseline: 9/353 formally stated Erdős problems solved
  * [ ] Hardest targets receive evolutionary/tool-augmented escalation ([arXiv][1])
* [ ] Reproduce Aletheia:

  * [ ] Long-horizon generate → verify → revise
  * [ ] Literature navigation
  * [ ] Intensive tool use
  * [ ] Natural-language research proof lane
  * [ ] Baseline: 700 Erdős problems explored; four autonomous open-question solutions reported ([arXiv][2])
* [ ] Reproduce AI Co-Mathematician:

  * [ ] Persistent research workspace
  * [ ] Parallel workstreams
  * [ ] Working-paper state
  * [ ] Failed-hypothesis tracking
  * [ ] Literature + computation + proof orchestration
  * [ ] Enforced adversarial review
  * [ ] Baseline: 48% on FrontierMath Tier 4 ([arXiv][3])
* [ ] Reproduce AlphaEvolve:

  * [ ] Population-based construction search
  * [ ] Code mutation
  * [ ] Deterministic evaluators
  * [ ] Pareto preservation
  * [ ] Generalization from finite discoveries ([arXiv][4])
* [ ] Integrate research-level retrieval:

  * [ ] LeanSearch v2 standard mode
  * [ ] LeanSearch v2 sketch → retrieve → reflect mode
  * [ ] Mathlib declaration graph
  * [ ] Local semantic index
  * [ ] Global premise-set retrieval ([arXiv][5])
* [ ] Integrate current formal target corpus:

  * [ ] Formal Conjectures
  * [ ] Erdős Problems
  * [ ] OEIS open conjectures
  * [ ] Green’s open problems
  * [ ] MathOverflow
  * [ ] ArXivLean
  * [ ] SorryDB
  * [ ] Current Formal Conjectures status synchronized before every campaign ([google-deepmind.github.io][6])
* [ ] Support general-purpose creative discovery:

  * [ ] Cross-domain technique synthesis
  * [ ] Construction discovery
  * [ ] Representation changes
  * [ ] Human-proof-quality deformalization
  * [ ] Independent external validation for major claims ([OpenAI][7])

---

# 2. REPOSITORY

```text
erdosfire/
├── apps/
│   ├── control-plane/
│   ├── campaign-runner/
│   ├── research-dashboard/
│   └── artifact-server/
├── core/
│   ├── contracts/
│   ├── target_registry/
│   ├── campaign_scheduler/
│   ├── research_state/
│   ├── theorem_graph/
│   ├── strategy_registry/
│   ├── search_policy/
│   ├── evidence_ledger/
│   ├── novelty_engine/
│   └── closure_engine/
├── agents/
│   ├── coordinator/
│   ├── problem_analyst/
│   ├── formalizer/
│   ├── literature_hunter/
│   ├── strategy_synthesizer/
│   ├── lemma_architect/
│   ├── informal_prover/
│   ├── lean_prover/
│   ├── construction_hunter/
│   ├── counterexample_hunter/
│   ├── universalizer/
│   ├── adversarial_reviewer/
│   └── deformalizer/
├── strategies/
│   ├── formal_proof_search/
│   ├── construction_evolution/
│   ├── counterexample_search/
│   ├── reduction_discovery/
│   ├── universalization/
│   ├── computational_certificate/
│   ├── literature_bridge/
│   ├── theorem_strengthening/
│   ├── theorem_weakening/
│   └── exhaustive_case_search/
├── domain_packs/
│   ├── additive_combinatorics/
│   ├── extremal_combinatorics/
│   ├── graph_theory/
│   ├── elementary_number_theory/
│   ├── analytic_number_theory/
│   ├── diophantine_equations/
│   ├── density_problems/
│   ├── Ramsey_theory/
│   └── discrete_geometry/
├── formal/
│   ├── lean/
│   ├── mathlib_index/
│   ├── safe_verify/
│   ├── pantograph/
│   └── certificate_checkers/
├── compute/
│   ├── exact_arithmetic/
│   ├── enumeration/
│   ├── sat_smt/
│   ├── milp_cp/
│   ├── graph_search/
│   ├── symbolic_algebra/
│   ├── invariant_mining/
│   └── construction_evolution/
├── acquisition/
│   ├── erdosproblems/
│   ├── formal_conjectures/
│   ├── oeis/
│   ├── arxiv/
│   ├── mathoverflow/
│   └── literature/
├── evaluation/
│   ├── contamination/
│   ├── benchmark_snapshots/
│   ├── regression/
│   ├── ablations/
│   └── red_team/
├── artifacts/
├── tests/
└── scripts/
```

---

# 3. CORE CONTRACTS

## `ProblemRecord`

```yaml
problem_id:
source:
source_problem_id:
snapshot_date:
status_at_snapshot:
statement_natural:
statement_latex:
domain_tags: []
object_tags: []
quantifier_shape:
claim_type:
known_partial_results: []
known_equivalences: []
known_counterexamples: []
references: []
formalizations: []
ambiguities: []
prize:
significance_score:
novelty_value:
```

## `FormalizationCandidate`

```yaml
formalization_id:
problem_id:
lean_version:
mathlib_commit:
imports: []
statement_lean:
semantic_assumptions: []
interpretation_choices: []
example_tests: []
boundary_tests: []
negation_tests: []
roundtrip_translation:
conformance_score:
adversarial_review:
status:
```

## `ResearchState`

```yaml
state_id:
problem_id:
formalization_id:
parent_state_ids: []
strategy_id:
informal_blueprint:
formal_sketch_path:
theorem_dag:
open_goals: []
proved_lemmas: []
disproved_lemmas: []
constructions: []
counterexamples: []
computational_results: []
retrieved_premises: []
literature_evidence: []
failed_approaches: []
novelty_hypotheses: []
objective_metrics:
resource_usage:
```

## `StrategyAttempt`

```yaml
attempt_id:
problem_id:
state_id:
strategy_family:
strategy_variant:
technique_tags: []
parameter_vector:
model:
tools_used: []
start_receipt:
end_receipt:
formal_goals_before:
formal_goals_after:
core_difficulty_delta:
new_lemma_count:
new_counterexample_count:
new_reduction_count:
outcome:
failure_class:
transferable_learning: []
```

## `LemmaNode`

```yaml
lemma_id:
statement_natural:
statement_lean:
role:
dependency_ids: []
status:
proof_receipt:
difficulty_estimate:
target_overlap_score:
generality_score:
reuse_tags: []
source_mapping:
```

## `ClosurePacket`

```yaml
problem_id:
claim_status:
formal_statement:
formal_proof:
kernel_receipt:
safe_verify_receipt:
axiom_report:
computational_certificates: []
natural_language_proof:
statement_conformance_report:
novelty_report:
prior_art_report:
independent_reproduction:
independent_proof_route:
limitations:
artifact_hashes:
```

---

# 4. IMMEDIATE CONVERSION OF CURRENT SYSTEM

* [ ] Rename current rung engine:

  * [ ] `OmegaLadderEngine` → `ExhaustiveCaseStrategy`
* [ ] Move:

  * [ ] `technique_history_for_omega`
  * [ ] `suggest_chunk_threshold`
  * [ ] `chunkThreshold`
  * [ ] timeout adaptation
  * [ ] move tagging
    into:
  * [ ] generic `StrategyPolicy`
  * [ ] generic `ParameterBandit`
  * [ ] generic `AttemptLedger`
* [ ] Replace `omega{w}-ct{threshold}` with:

```text
{problemId}:{formalizationId}:{strategyFamily}:{techniqueId}:{parameterHash}
```

* [ ] Add:

```text
claim_scope:
  FINITE_INSTANCE
  FINITE_RANGE
  ASYMPTOTIC
  UNIVERSAL
  CONDITIONAL
  EXISTENTIAL
  CONSTRUCTIVE
```

* [ ] Add closure guard:

```text
if target.scope == UNIVERSAL
and evidence.scope in {FINITE_INSTANCE, FINITE_RANGE}
then closure_status = NOT_CLOSED
```

* [ ] Add escalation guard:

```text
if repeated_attempts(strategyFamily) >= N
and core_difficulty_delta == 0
then prohibit_parameter_only_retry
and require_strategy_family_change
```

* [ ] Add universalization trigger:

```text
if finite_rung_growth_exceeds_budget
or projected_terminal_count_exceeds_limit
or finite_progress_cannot_entail_target
then spawn UniversalizerAgent
```

* [ ] Preserve existing timeout semantics:

  * [ ] timeout = `INCONCLUSIVE`
  * [ ] kernel contradiction = `REFUTED`
  * [ ] counterexample = `DISPROVED`
  * [ ] compile failure = `INVALID_ATTEMPT`
* [ ] Stop treating lower chunk size as mathematical learning
* [ ] Record parameter adaptation as operational learning only
* [ ] Require mathematical learning to contain at least one:

  * [ ] new lemma
  * [ ] new reduction
  * [ ] new invariant
  * [ ] new construction
  * [ ] new counterexample
  * [ ] eliminated strategy family
  * [ ] strengthened bound
  * [ ] generalized proof step

---

# 5. TARGET ACQUISITION

* [ ] Build immutable daily target snapshot
* [ ] Ingest:

  * [ ] Problem statement
  * [ ] Current status
  * [ ] Variants
  * [ ] Comments
  * [ ] Known references
  * [ ] Known partial results
  * [ ] Formalizations
  * [ ] AI-contribution history
* [ ] Store raw source hash
* [ ] Store normalized statement hash
* [ ] Detect status drift
* [ ] Detect duplicate conjectures
* [ ] Detect equivalent formulations
* [ ] Detect stronger/weaker relationships
* [ ] Detect problem already implicit in literature
* [ ] Detect mistranscribed or ambiguous statements
* [ ] Block campaigns against stale “open” labels
* [ ] Reopen target only after novelty/status audit
* [ ] Preserve exact snapshot used for every discovery claim

---

# 6. TARGET TRIAGE

## Features

* [ ] Mathlib definition coverage
* [ ] Mathlib theorem coverage
* [ ] Required missing-library depth
* [ ] Quantifier complexity
* [ ] Statement length
* [ ] Dependency depth
* [ ] Constructive witness potential
* [ ] Counterexample searchability
* [ ] Finite evaluator availability
* [ ] Exact certificate availability
* [ ] SAT/SMT encodability
* [ ] MILP/CP encodability
* [ ] Graph-search encodability
* [ ] Symbolic-algebra encodability
* [ ] Known partial-result proximity
* [ ] Number of plausible reductions
* [ ] Number of analogous solved problems
* [ ] Literature saturation
* [ ] Likelihood of rediscovery
* [ ] Expected proof length
* [ ] Expected formalization burden
* [ ] Universalization burden
* [ ] Scientific significance
* [ ] External-verification burden
* [ ] Expected value per compute

## Target scores

```text
attackability_score
formalizability_score
counterexample_score
construction_score
reduction_score
proof_search_score
novelty_score
significance_score
closure_probability
expected_value_per_dollar
expected_value_per_hour
```

## Routing

* [ ] `FORMAL_PROOF_FIRST`
* [ ] `INFORMAL_DISCOVERY_FIRST`
* [ ] `COUNTEREXAMPLE_FIRST`
* [ ] `CONSTRUCTION_EVOLUTION_FIRST`
* [ ] `COMPUTATIONAL_EXPERIMENT_FIRST`
* [ ] `LITERATURE_CLOSURE_FIRST`
* [ ] `REDUCTION_FIRST`
* [ ] `LIBRARY_BUILD_FIRST`
* [ ] `DO_NOT_ATTACK_YET`

## Selection policy

```text
priority =
  closure_probability
  × novelty_score
  × significance_score
  × verification_feasibility
  ÷ expected_compute
```

* [ ] Reserve 20% compute for high-risk/high-significance targets
* [ ] Reserve 20% compute for counterexample attacks
* [ ] Reserve 20% compute for construction problems
* [ ] Reserve 20% compute for formal proof search
* [ ] Reserve 20% compute for reductions/universal arguments
* [ ] Update allocation by Thompson sampling
* [ ] Never select exclusively by apparent ease

---

# 7. FORMALIZATION ENGINE

* [ ] Generate multiple candidate interpretations
* [ ] Enumerate every ambiguous term
* [ ] Separate:

  * [ ] natural density
  * [ ] upper density
  * [ ] lower density
  * [ ] logarithmic density
  * [ ] asymptotic density
* [ ] Separate:

  * [ ] set
  * [ ] multiset
  * [ ] sequence
  * [ ] ordered tuple
* [ ] Separate:

  * [ ] strict
  * [ ] non-strict
  * [ ] finite
  * [ ] infinite
  * [ ] eventually
  * [ ] infinitely often
* [ ] Generate test lemmas
* [ ] Verify small examples
* [ ] Verify boundary examples
* [ ] Verify known constructions
* [ ] Verify known counterexamples
* [ ] Verify known partial theorems
* [ ] Translate Lean statement back to natural language
* [ ] Compare source → Lean → natural-language round trip
* [ ] Run independent formalizer
* [ ] Run adversarial interpretation critic
* [ ] Require interpretation consensus or preserve variants
* [ ] Never discard ambiguity silently
* [ ] Attack all plausible variants when cheap
* [ ] Label every result with exact formalization ID
* [ ] Prevent proof agents from modifying protected statement AST
* [ ] Pin Lean and Mathlib commits

---

# 8. RESEARCH-STATE SEARCH

## Search object

* [ ] Evolve complete `ResearchState`
* [ ] Never evolve Lean text alone
* [ ] Preserve:

  * [ ] informal strategy
  * [ ] formal sketch
  * [ ] theorem DAG
  * [ ] computational evidence
  * [ ] literature links
  * [ ] failed hypotheses
  * [ ] unresolved core
  * [ ] novelty status

## Population

* [ ] Root population:

  * [ ] direct proof
  * [ ] contradiction
  * [ ] contrapositive
  * [ ] induction
  * [ ] minimal counterexample
  * [ ] extremal object
  * [ ] probabilistic construction
  * [ ] algebraic encoding
  * [ ] analytic bound
  * [ ] graph encoding
  * [ ] modular obstruction
  * [ ] compactness
  * [ ] density increment
  * [ ] energy argument
  * [ ] generating function
  * [ ] Fourier transform
  * [ ] polynomial method
  * [ ] entropy method
  * [ ] computational certificate
* [ ] Maintain independent lineages
* [ ] Deduplicate semantically equivalent states
* [ ] Cluster states by strategy family
* [ ] Preserve failed but informative branches
* [ ] Preserve branches with reusable lemmas
* [ ] Preserve branches exposing statement defects

## Fitness vector

```text
kernel_progress
core_goal_reduction
lemma_generality
proof_depth_reduction
counterexample_strength
construction_quality
bound_improvement
novelty
literature_consistency
formalization_confidence
transfer_value
compute_efficiency
adversarial_survival
```

* [ ] Use Pareto selection
* [ ] Use objective metrics before LLM ranking
* [ ] Use LLM ranking only for non-verifiable dimensions
* [ ] Track critic disagreement
* [ ] Penalize reviewer-pleasing convergence
* [ ] Penalize repeated target restatements
* [ ] Penalize hidden unresolved core lemmas
* [ ] Penalize unverifiable literature invocations

## Mutation operators

* [ ] Decompose goal
* [ ] Merge compatible branches
* [ ] Generalize statement
* [ ] Specialize statement
* [ ] Strengthen induction hypothesis
* [ ] Weaken intermediate claim
* [ ] Change representation
* [ ] Introduce invariant
* [ ] Search for conserved quantity
* [ ] Dualize
* [ ] Complement
* [ ] Apply symmetry quotient
* [ ] Pass to minimal counterexample
* [ ] Pass to extremal configuration
* [ ] Randomize
* [ ] Derandomize
* [ ] Encode as graph
* [ ] Encode as hypergraph
* [ ] Encode as SAT
* [ ] Encode as SMT
* [ ] Encode as MILP
* [ ] Encode as polynomial system
* [ ] Introduce generating function
* [ ] Introduce Fourier basis
* [ ] Introduce modular decomposition
* [ ] Introduce compactness argument
* [ ] Infer recurrence
* [ ] Infer asymptotic
* [ ] Search analogous theorem
* [ ] Transfer proof skeleton
* [ ] Prove stronger theorem
* [ ] Find minimal false strengthening
* [ ] Find maximal provable weakening
* [ ] Negate and search witness
* [ ] Replace brute force with structural lemma
* [ ] Replace finite ladder with uniform bound

---

# 9. AGENT ROSTER

## `CoordinatorAgent`

* [ ] Maintain project state
* [ ] Spawn parallel workstreams
* [ ] Allocate compute
* [ ] Enforce route changes
* [ ] Merge evidence
* [ ] Stop invalid lineages
* [ ] Trigger closure audit

## `ProblemAnalystAgent`

* [ ] Normalize statement
* [ ] Build object/quantifier graph
* [ ] Identify core obstruction
* [ ] Generate attack taxonomy
* [ ] Identify stronger/weaker variants
* [ ] Produce tractability profile

## `LiteratureHunterAgent`

* [ ] Retrieve exact papers
* [ ] Retrieve exact theorem statements
* [ ] Map assumptions
* [ ] Map notation
* [ ] Search equivalent formulations
* [ ] Search solved variants
* [ ] Search implicit prior results
* [ ] Generate novelty graph
* [ ] Reject vague “known theorem” claims

## `FormalizerAgent`

* [ ] Create candidate Lean statements
* [ ] Build semantic tests
* [ ] Build source correspondence report
* [ ] Add required definitions
* [ ] Minimize imports
* [ ] Preserve ambiguity variants

## `StrategySynthesizerAgent`

* [ ] Generate diverse high-level attacks
* [ ] Map attacks to executable tools
* [ ] Estimate falsifiability
* [ ] Define success/failure signals
* [ ] Define intermediate milestones

## `LemmaArchitectAgent`

* [ ] Build theorem DAG
* [ ] Identify bottleneck lemmas
* [ ] Generate alternative decompositions
* [ ] Measure target overlap
* [ ] Reject target restatements
* [ ] Promote reusable lemmas to global library

## `InformalProverAgent`

* [ ] Produce long-horizon natural-language arguments
* [ ] Mark every unsupported step
* [ ] Emit formalization-ready lemma boundaries
* [ ] Revise using counterexamples and formal failures

## `LeanProverAgent`

* [ ] Edit protected Lean workspace
* [ ] Compile after every mutation
* [ ] Query premise retrieval
* [ ] Query global goal cache
* [ ] Spawn subgoal proof searches
* [ ] Return only verified proof fragments

## `ConstructionHunterAgent`

* [ ] Represent candidates as executable generators
* [ ] Evolve constructions
* [ ] Optimize exact objective
* [ ] Mine patterns
* [ ] Infer parameterized families
* [ ] Request proof of general construction

## `CounterexampleHunterAgent`

* [ ] Negate theorem
* [ ] Search smallest witness
* [ ] Search pathological limits
* [ ] Search boundary conditions
* [ ] Mutate assumptions
* [ ] Search stronger statement failures
* [ ] Export exact witness certificate

## `UniversalizerAgent`

* [ ] Detect finite-instance trap
* [ ] Infer recurrence across rungs
* [ ] Search monotonicity
* [ ] Search induction invariant
* [ ] Search uniform analytic bound
* [ ] Search compactness reduction
* [ ] Search minimal-counterexample descent
* [ ] Search structural classification
* [ ] Convert computational pattern into universal lemma

## `AdversarialReviewerAgent`

* [ ] Attack every inference
* [ ] Search hidden assumptions
* [ ] Search circularity
* [ ] Search quantifier swaps
* [ ] Search non-uniform limits
* [ ] Search misuse of asymptotics
* [ ] Search impossible literature lemmas
* [ ] Produce concrete counterexample or formal obligation

## `DeformalizerAgent`

* [ ] Convert verified Lean proof to readable mathematics
* [ ] Preserve exact logical structure
* [ ] Remove implementation noise
* [ ] Provide dependency map
* [ ] Generate publication-grade theorem/proof draft

---

# 10. STRATEGY PLUGIN INTERFACE

```python
class MathStrategy:
    strategy_id: str
    technique_tags: list[str]

    def applicability(problem, state) -> ApplicabilityScore: ...
    def initialize(problem, formalization) -> list[ResearchState]: ...
    def propose(state, memory) -> list[Mutation]: ...
    def execute(mutation, tools) -> AttemptResult: ...
    def evaluate(before, after) -> FitnessVector: ...
    def extract_learning(result) -> list[LearningRecord]: ...
    def generate_certificate(result) -> EvidenceReceipt: ...
    def stop_conditions(state) -> list[StopCondition]: ...
    def transfer_signature(state) -> TransferSignature: ...
```

## Required P0 plugins

* [ ] `LeanRalphProofSearch`
* [ ] `GlobalPremiseRetrieval`
* [ ] `LemmaDecomposition`
* [ ] `CounterexampleEnumeration`
* [ ] `SATSMTReduction`
* [ ] `ConstructionEvolution`
* [ ] `ReductionDiscovery`
* [ ] `Universalization`
* [ ] `ComputationalCertificate`
* [ ] `LiteratureBridge`
* [ ] `ExhaustiveCaseStrategy`
* [ ] `ProofStrengthening`
* [ ] `ProofWeakening`

---

# 11. ERDŐS DOMAIN PACK

## Additive combinatorics

* [ ] Sumsets
* [ ] Difference sets
* [ ] Additive energy
* [ ] Sidon sets
* [ ] Bases
* [ ] Density increment
* [ ] Freiman-style structure
* [ ] Fourier methods
* [ ] CRT constructions
* [ ] Progression-free sets
* [ ] Block constructions

## Number theory

* [ ] Multiplicative functions
* [ ] Divisor structures
* [ ] Prime factorization constraints
* [ ] Modular obstructions
* [ ] Sieve bounds
* [ ] Diophantine approximation
* [ ] p-adic valuations
* [ ] Generating functions
* [ ] Asymptotic summation
* [ ] Explicit finite verification

## Extremal/Ramsey combinatorics

* [ ] Colorings
* [ ] Forbidden configurations
* [ ] Ramsey reductions
* [ ] Hypergraph encoding
* [ ] Probabilistic method
* [ ] Local lemma
* [ ] Entropy compression
* [ ] Flag algebra certificates
* [ ] SAT certificates
* [ ] Stability arguments

## Graph theory

* [ ] Nauty/Traces canonicalization
* [ ] Graph6 serialization
* [ ] Minor/subgraph search
* [ ] Extremal graph generation
* [ ] Spectral invariants
* [ ] Ramsey coloring search
* [ ] MILP/SAT graph constraints
* [ ] Certificate extraction

## Discrete geometry

* [ ] Coordinate constructions
* [ ] Algebraic-number coordinates
* [ ] Distance graphs
* [ ] Determinant/non-collinearity certificates
* [ ] Exact interval arithmetic
* [ ] Symmetry reduction
* [ ] Lattice and non-lattice search

---

# 12. COMPUTATIONAL MATHEMATICS TOOLCHAIN

## Formal

* [ ] Lean 4
* [ ] Mathlib
* [ ] Pantograph
* [ ] LeanDojo v2
* [ ] SafeVerify
* [ ] LeanSearch v2
* [ ] Loogle
* [ ] LeanExplore
* [ ] Local declaration embeddings
* [ ] Local theorem dependency graph

## Number theory/algebra

* [ ] SageMath
* [ ] PARI/GP
* [ ] FLINT
* [ ] Arb
* [ ] GAP
* [ ] Singular
* [ ] Macaulay2
* [ ] Normaliz
* [ ] polymake
* [ ] SymPy
* [ ] Oscar
* [ ] LMFDB adapters

## Search/optimization

* [ ] Z3
* [ ] cvc5
* [ ] PySAT
* [ ] Kissat
* [ ] CaDiCaL
* [ ] OR-Tools CP-SAT
* [ ] SCIP
* [ ] HiGHS
* [ ] exact MILP certificate extraction
* [ ] Vampire
* [ ] E prover

## Graph/combinatorics

* [ ] Nauty/Traces
* [ ] NetworkX
* [ ] igraph
* [ ] graph-tool
* [ ] custom canonical enumerators
* [ ] flag algebra interface

## Verification rule

* [ ] Every external solver returns:

  * [ ] exact witness
  * [ ] proof certificate
  * [ ] unsat certificate
  * [ ] exact arithmetic trace
  * [ ] Lean-replayable lemma
* [ ] Floating-point evidence never closes a theorem
* [ ] Numerical evidence may only:

  * [ ] rank hypotheses
  * [ ] find candidate witnesses
  * [ ] infer patterns
  * [ ] propose constants

---

# 13. THEOREM GRAPH

* [ ] Build dependency DAG per target
* [ ] Node types:

  * [ ] definition
  * [ ] known theorem
  * [ ] derived lemma
  * [ ] conjectural lemma
  * [ ] computational lemma
  * [ ] reduction
  * [ ] construction
  * [ ] asymptotic estimate
  * [ ] contradiction
* [ ] Label unresolved nodes:

  * [ ] `CORE_MATHEMATICS`
  * [ ] `FORMALIZATION_GAP`
  * [ ] `LIBRARY_GAP`
  * [ ] `COMPUTATIONAL_GAP`
  * [ ] `TECHNICAL_LEAN_GAP`
  * [ ] `LITERATURE_GAP`
  * [ ] `FALSE_LEMMA`
  * [ ] `UNKNOWN`
* [ ] Compute target-overlap score
* [ ] Reject helper lemma when:

  * [ ] logical equivalence to target
  * [ ] target obtainable by trivial rewriting
  * [ ] same core quantifiers unchanged
  * [ ] no complexity reduction
* [ ] Compute core-difficulty delta
* [ ] Reward proof states that move difficulty into reusable standard lemmas
* [ ] Penalize proof states that hide difficulty under renamed claims

---

# 14. GLOBAL MATHEMATICAL MEMORY

## Stores

* [ ] Exact formal-goal cache
* [ ] Alpha-equivalent goal cache
* [ ] Premise-set cache
* [ ] Proof-fragment cache
* [ ] Counterexample cache
* [ ] Construction cache
* [ ] Failed-lemma cache
* [ ] Strategy-outcome cache
* [ ] Literature theorem cache
* [ ] Formalization ambiguity cache
* [ ] Cross-problem analogy graph
* [ ] Technique-transfer graph

## Learning hierarchy

```text
domain
→ problem_shape
→ proof_shape
→ strategy_family
→ technique
→ operator
→ parameter_vector
```

* [ ] Never learn from unstructured string tags only
* [ ] Record operational and mathematical learning separately
* [ ] Learn:

  * [ ] strategy applicability
  * [ ] premise utility
  * [ ] lemma usefulness
  * [ ] decomposition quality
  * [ ] formalization error patterns
  * [ ] counterexample distributions
  * [ ] construction motifs
  * [ ] universalization triggers
  * [ ] compute allocation
* [ ] Train:

  * [ ] target ranker
  * [ ] strategy router
  * [ ] premise retriever
  * [ ] state value model
  * [ ] mutation selector
  * [ ] timeout predictor
  * [ ] proof-cost predictor
* [ ] Keep learned models advisory
* [ ] Keep kernel/evaluator authoritative

---

# 15. SEARCH POLICY

* [ ] Start with diversified independent branches
* [ ] Do not share early hypotheses across all branches
* [ ] Delay convergence
* [ ] Periodically merge compatible branches
* [ ] P-UCB over top Pareto states
* [ ] Thompson sampling across strategy families
* [ ] Novelty bonus for new technique families
* [ ] Reuse bonus for cross-target lemmas
* [ ] Core-progress bonus
* [ ] Counterexample bonus
* [ ] Universalization bonus
* [ ] Parameter-only mutation penalty
* [ ] Repeated-no-progress penalty
* [ ] State-collapse detector
* [ ] Critic-consensus detector
* [ ] Forced restart after homogeneous population
* [ ] Forced representation change after repeated core failure
* [ ] Forced counterexample search before expensive proof escalation
* [ ] Forced literature search before novelty claim
* [ ] Forced formalization audit after suspiciously easy proof
* [ ] Forced universalization after finite-rung success

---

# 16. VERIFICATION STACK

## Layer 1 — statement integrity

* [ ] Protected AST hash unchanged
* [ ] Imports constrained
* [ ] Namespace constrained
* [ ] Definitions audited
* [ ] No weakened assumptions
* [ ] No changed quantifiers
* [ ] No hidden classical assumptions unless declared

## Layer 2 — Lean compilation

* [ ] Fresh container
* [ ] Pinned Lean
* [ ] Pinned Mathlib
* [ ] Empty build cache validation
* [ ] Deterministic replay

## Layer 3 — SafeVerify

* [ ] No `sorryAx`
* [ ] No new axioms
* [ ] No environment manipulation
* [ ] No unsafe metaprogramming exploit
* [ ] No theorem replacement
* [ ] No imported cheat module

## Layer 4 — semantic conformance

* [ ] Source-to-formal mapping
* [ ] Boundary tests
* [ ] Known-example tests
* [ ] Independent translation
* [ ] Adversarial interpretation review

## Layer 5 — novelty

* [ ] Exact literature search
* [ ] Theorem-level prior-art matching
* [ ] Equivalent-statement search
* [ ] Stronger-result search
* [ ] Historical source search
* [ ] Erdős Problems status check
* [ ] Formal Conjectures status check
* [ ] OEIS/LMFDB search
* [ ] Public web search
* [ ] Citation audit

## Layer 6 — independent reproduction

* [ ] Fresh repository clone
* [ ] Fresh environment
* [ ] Independent agent replay
* [ ] Independent proof checker
* [ ] Independent computational reproduction
* [ ] Alternative proof route for major claims

---

# 17. CLOSURE RULES

```text
PROVED:
  exact target statement
  sorry-free kernel proof
  SafeVerify pass
  conformance pass
  novelty audit complete

DISPROVED:
  exact target negation
  exact witness or kernel proof
  witness replay
  conformance pass

NEW_PARTIAL:
  strictly stronger than known partial result
  formally verified
  comparison proof included
  novelty audit complete

REDUCED:
  formally verified equivalence or implication
  target reduced to named unresolved subgoal
  measurable core-difficulty decrease

REDISCOVERED:
  valid proof
  prior theorem found
  exact mapping provided

MISSTATED:
  source/formalization mismatch
  counterexample or contradiction demonstrated
  corrected variants emitted

NOT_CLOSED:
  all other terminal states
```

* [ ] Never use `PROVED` for:

  * [ ] finite rungs
  * [ ] numerical agreement
  * [ ] asymptotic evidence without proof
  * [ ] model consensus
  * [ ] unverified informal proof
  * [ ] theorem variant
  * [ ] stronger assumptions
  * [ ] weaker conclusion
  * [ ] literature claim without source
  * [ ] unresolved helper lemma

---

# 18. FIRST CAMPAIGN

## Corpus

* [ ] Freeze current Erdős Problems snapshot
* [ ] Freeze current Formal Conjectures snapshot
* [ ] Remove:

  * [ ] already solved
  * [ ] known literature closures
  * [ ] status mismatches
  * [ ] duplicate variants
  * [ ] malformed statements
* [ ] Preserve:

  * [ ] genuinely open
  * [ ] formally stated
  * [ ] source-conformant
  * [ ] attackable by current libraries

## Calibration set

* [ ] Import nine AlphaProof Nexus solved targets
* [ ] Hide published proofs from agents
* [ ] Run contamination-resistant reproduction
* [ ] Require:

  * [ ] ≥7/9 solved
  * [ ] zero invalid closure claims
  * [ ] proof receipts
  * [ ] cost profiles
  * [ ] strategy ablations

## Frontier set

* [ ] Select top 64 targets
* [ ] Allocate 8 initial lineages per target
* [ ] Attack lanes:

  * [ ] direct Lean proof
  * [ ] informal long-horizon proof
  * [ ] construction evolution
  * [ ] counterexample search
  * [ ] reduction search
  * [ ] literature bridge
  * [ ] universalization
  * [ ] computational experiment
* [ ] Promote top 16 targets after objective progress
* [ ] Promote top 4 targets after adversarial survival
* [ ] Require distinct strategy families before deep compute
* [ ] Generate closure packets continuously
* [ ] Submit major results to independent external verification

---

# 19. BENCHMARK LADDER

## B0 — infrastructure

* [ ] 100% deterministic receipts
* [ ] 100% protected-statement integrity
* [ ] 100% SafeVerify enforcement
* [ ] Zero false `PROVED`
* [ ] Global goal cache operational
* [ ] Semantic attempt deduplication operational

## B1 — formal proving

* [ ] MiniF2F regression
* [ ] PutnamBench regression
* [ ] Lean-IMO regression
* [ ] ArXivLean regression
* [ ] SorryDB regression
* [ ] Mathlib held-out theorem regression
* [ ] No benchmark contamination

## B2 — research reproduction

* [ ] Reproduce ≥7/9 AlphaProof Nexus Erdős results
* [ ] Reproduce at least one result using a distinct proof route
* [ ] Detect known misformalization traps
* [ ] Detect rediscoveries before public claim

## B3 — frontier partials

* [ ] One formally verified new bound
* [ ] One formally verified new reduction
* [ ] One formally verified new construction
* [ ] One formally verified counterexample to a plausible strengthening
* [ ] External novelty confirmation

## B4 — genuine closure

* [ ] One genuinely open problem closed
* [ ] Exact source statement
* [ ] Kernel proof
* [ ] Independent reproduction
* [ ] External mathematician validation
* [ ] Public artifact
* [ ] No finite-instance substitution

## B5 — Erdős closer

* [ ] Multiple independently validated open closures
* [ ] At least one structural/universal proof
* [ ] At least one result requiring a novel construction
* [ ] At least one cross-domain technique transfer
* [ ] Sustained positive closure rate on frozen unseen corpus
* [ ] Cost-adjusted performance above published 2026 baselines

---

# 20. TEST SUITE

* [ ] Statement mutation attack tests
* [ ] Axiom injection tests
* [ ] `sorry` hiding tests
* [ ] Target-restatement lemma tests
* [ ] False literature theorem tests
* [ ] Quantifier-swap tests
* [ ] Density-definition tests
* [ ] Finite-to-universal fallacy tests
* [ ] Floating-point certificate tests
* [ ] Timeout/refutation distinction tests
* [ ] Duplicate-state tests
* [ ] Cross-run learning tests
* [ ] Strategy-switch tests
* [ ] Population-collapse tests
* [ ] Reviewer-false-consensus tests
* [ ] Stale-open-status tests
* [ ] Rediscovery detection tests
* [ ] Reproduction-from-clean-container tests

---

# 21. OBSERVABILITY

## Per campaign

* [ ] Targets attempted
* [ ] Targets with formal progress
* [ ] New lemmas
* [ ] New reductions
* [ ] New constructions
* [ ] New counterexamples
* [ ] Universalization attempts
* [ ] Kernel-closed goals
* [ ] Invalid attempts
* [ ] Formalization defects
* [ ] Rediscoveries
* [ ] Novel partials
* [ ] Novel closures
* [ ] Compute by strategy
* [ ] Value per compute
* [ ] Cross-target lemma reuse
* [ ] Strategy-family diversity
* [ ] Population entropy
* [ ] Core-difficulty movement

## Per target

```text
closure_probability
formalization_confidence
novelty_confidence
best_research_state
core_unresolved_lemma
best_counterexample
best_construction
best_reduction
most_effective_strategy
strategies_eliminated
next_decisive_experiment
```

---

# 22. STOP CONDITIONS

* [ ] Stop target when formally closed
* [ ] Stop variant when source mismatch confirmed
* [ ] Stop branch when core-difficulty delta remains zero
* [ ] Stop branch when equivalent failed state exists
* [ ] Stop parameter sweep when structural barrier detected
* [ ] Stop finite enumeration when it cannot imply universal target
* [ ] Stop novelty process when stronger prior theorem found
* [ ] Stop expensive formalization when natural statement remains ambiguous
* [ ] Preserve all failures as reusable assets
* [ ] Emit exact reason for every stop

---

# 23. PROHIBITED BUILDS

* [ ] No single hard-coded problem enumerator as system core
* [ ] No rung-climbing marketed as conjecture closure
* [ ] No RSI limited to chunk-size adjustment
* [ ] No LLM-only proof critic
* [ ] No model consensus as truth
* [ ] No proof sketch scored only by eloquence
* [ ] No helper lemma equivalent to target
* [ ] No hallucinated named theorem
* [ ] No untracked statement interpretation
* [ ] No floating-point terminal evidence
* [ ] No uncontrolled brute force
* [ ] No repeated identical strategy with cosmetic parameter changes
* [ ] No benchmark-only optimization
* [ ] No public claim before novelty audit
* [ ] No “open problem” assumption without live status synchronization
* [ ] No success metric based only on number of Lean files compiled

---

# 24. BUILD ORDER

## P0

* [ ] Generic contracts
* [ ] Strategy registry
* [ ] Current omega engine wrapped as plugin
* [ ] Lean worker
* [ ] Pantograph integration
* [ ] SafeVerify integration
* [ ] Protected statement hashing
* [ ] Global goal cache
* [ ] Formal Conjectures ingestion
* [ ] Erdős Problems synchronization
* [ ] Simple independent Ralph loops
* [ ] Attempt/learning ledger
* [ ] Closure packet generator

## P1

* [ ] LeanSearch v2 integration
* [ ] Mathlib theorem graph
* [ ] Target triage
* [ ] Counterexample lane
* [ ] Construction-evolution lane
* [ ] Reduction lane
* [ ] Universalizer
* [ ] Literature/novelty engine
* [ ] Theorem DAG
* [ ] Target-overlap detector
* [ ] Objective state fitness

## P2

* [ ] Evolutionary research-state population
* [ ] Pareto selection
* [ ] P-UCB lineage selection
* [ ] Cross-target lemma transfer
* [ ] Technique-transfer graph
* [ ] Exact solver certificate replay
* [ ] Independent proof-route generation
* [ ] Automated deformalization

## P3

* [ ] Learned strategy router
* [ ] Learned target selector
* [ ] Learned premise retriever
* [ ] Learned research-state value model
* [ ] Self-generated theorem variants
* [ ] Automatic conjecture strengthening
* [ ] Automatic theory exploration
* [ ] Continuous open-problem campaign runner

---

# 25. FINAL SHIP GATE

* [ ] `make bootstrap`
* [ ] `make ingest`
* [ ] `make formalize`
* [ ] `make calibrate`
* [ ] `make hunt`
* [ ] `make verify`
* [ ] `make novelty-audit`
* [ ] `make reproduce`
* [ ] `make closure-packet`
* [ ] `make benchmark`
* [ ] Clean-machine replay passes
* [ ] All artifact hashes deterministic
* [ ] All claims trace to kernel/source receipts
* [ ] Omega ladder demonstrably one plugin
* [ ] New target requires data/config only
* [ ] New strategy requires plugin only
* [ ] New domain requires domain pack only
* [ ] System selects targets autonomously
* [ ] System changes mathematical strategy autonomously
* [ ] System generates new lemmas autonomously
* [ ] System searches constructions autonomously
* [ ] System hunts counterexamples autonomously
* [ ] System converts finite evidence into universal-proof attempts
* [ ] System distinguishes progress from closure
* [ ] System emits honest `NOT_CLOSED`
* [ ] System can produce externally reproducible frontier mathematics

[1]: https://arxiv.org/html/2605.22763 "Advancing Mathematics Research with AI-Driven Formal Proof Search"
[2]: https://arxiv.org/html/2602.10177v1 "Towards Autonomous Mathematics Research"
[3]: https://arxiv.org/html/2605.06651v1 "AI Co-Mathematician: Accelerating Mathematicians with Agentic AI"
[4]: https://arxiv.org/abs/2506.13131?utm_source=chatgpt.com "AlphaEvolve: A coding agent for scientific and algorithmic discovery"
[5]: https://arxiv.org/html/2605.13137v2 "LeanSearch v2: Global Premise Retrieval for Lean 4 Theorem Proving"
[6]: https://google-deepmind.github.io/formal-conjectures/?utm_source=chatgpt.com "Formal Conjectures"
[7]: https://openai.com/index/model-disproves-discrete-geometry-conjecture/ "An OpenAI model has disproved a central conjecture in discrete geometry | OpenAI"
