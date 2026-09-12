# Writing QA (end-to-end tests)

Stage 5: verify that the built feature satisfies its requirements, end to end.
For the overall approach, folder structure, and artifact lifecycle, see the main
`SKILL.md`; this guide does not restate them.

QA covers **end-to-end** tests only. Unit and integration tests belong to the
tasks and implementation stages — do not write them here.

## Language and style

Write so each test case has exactly one possible reading:

- Be **precise, explicit, and unambiguous.**
- Use **plain, direct language** — no words fancier or phrases more complicated
  than the meaning needs.
- **No idioms, metaphors, or figures of speech.**
- Avoid vague quantifiers. State the exact input, action, or expected outcome.

## The QA sequence

Work these in order:

1. **Write test cases** from the requirements — `specs/qa/test-cases/<feature>.md`.
2. **Write a test-implementation plan** — the tasks to automate them, in
   `specs/qa/tasks/`.
3. **Update the RTM** — `specs/qa/rtm.md`.
4. **Implement** the automated tests and run them.

## Black-box discipline

Treat the system as a black box **for deciding what is correct**: the expected
behavior — what each test asserts — comes from the **requirements**, not from the
implementation. Deriving assertions by reading the code makes the test
tautological ("the code does what the code does") and blind to bugs the code
already has.

You **may** read the code to learn *how to drive* the system — selectors,
element IDs, routes, API shapes — since that is often faster than probing a live
system. That is interaction mechanics, not correctness.

The tell: if you are reading code to know **what to assert**, stop and go to the
requirement; reading code to know **how to reach** what you are asserting is
fine.

## Test cases

Use [../assets/qa-test-cases-template.md](../assets/qa-test-cases-template.md).
One file per feature (`specs/qa/test-cases/<feature>.md`); it is a state artifact.

Because test cases derive from the **requirements**, not the code, you can write
them as soon as the requirements are settled — you do not need to wait for
implementation to finish. (Automating them, later in this sequence, does need the
running system.)

- Each case has a stable `TC-xxx` ID and states which requirement(s) it verifies
  (`FR-xxx`).
- Describe a concrete scenario from **outside** the system: given a starting
  state and inputs, when an action happens, then an observable outcome — the
  outcome taken from the requirement.
- Cover the requirement's happy path, its error/unwanted paths, and any timing
  or state rules.

## The RTM

Use [../assets/qa-rtm-template.md](../assets/qa-rtm-template.md). The RTM
(`specs/qa/rtm.md`) is **project-wide** and maps each requirement to the test
case(s) that cover it. It does two jobs:

- **Coverage guarantee** — every requirement should map to at least one test
  case, or carry an explicit note on why it needs none.
- **Drift detector** — when a requirement changes, the RTM shows which test
  cases are now stale.

Update it whenever test cases or requirements change.

## Test-implementation plan

Reuse the implementation-plan template
([../assets/implementation-plan-template.md](../assets/implementation-plan-template.md))
for `specs/qa/tasks/YYYYMMDDTHHMM-<slug>.md` — same shape and naming (an event
artifact). Its steps **reference the `TC-xxx` IDs** and add the *how* (harness,
fixtures, where the tests live, sequence). Reference the test cases; do not
restate the scenarios. Set the plan's `satisfies` frontmatter to the `TC-xxx` IDs
it automates (a QA plan satisfies test cases, where a feature plan satisfies
`FR-xxx`).

## Finishing

- **Implement and run** the automated tests; confirm they pass against the
  requirements.
- **Do one stage, then stop.** When requirements or test cases change later, see
  [maintenance.md](maintenance.md) — update the affected test cases and the RTM,
  and create a new test-implementation plan rather than editing an old one.

## Common pitfalls

- Asserting on implementation detail instead of observable, requirement-defined
  behavior.
- Reading the code to decide *what* is correct (white-box leakage).
- Writing unit or integration tests here — those belong to earlier stages.
- Requirements with no covering test case and no note explaining why.
- Restating scenarios in the task plan instead of referencing `TC-xxx` IDs.
