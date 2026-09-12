---
feature: <feature-slug>          # omit for non-feature plans (setup, cross-cutting)
satisfies: []                    # upstream IDs delivered, e.g. [FR-014]; empty for non-feature work
depends-on: []                   # docs to read, e.g. [design/features/user-auth.md, architecture/auth.md]
status: draft                    # draft | ready | completed
---

<!--
  An implementation plan, at
  specs/implementation/YYYYMMDDTHHMM-<slug>.md (timestamp = creation time, set
  once). See references/writing-tasks.md for how to write this. The document is
  the plan; the steps are the tasks. Ground it in analysis of the real code.
  Steps are detailed and self-contained, but a reviewable plan — not the code.
  Fill in and delete this comment.
-->

# [Task name]

## Approach & analysis

_Findings from investigating the codebase, and the strategy that follows from
them: what already exists, which seams to use, what is missing. The steps below
rest on this — make the reasoning visible._

## Steps

_Ordered steps, in implementation order. Free-form — no fixed fields required.
Each step should make clear which files are relevant and what needs to change._

- [ ] T1 — <what to do; which files to create or change; what changes>.
      (<design §section / FR-xxx / architecture doc — the why>)
- [ ] T2 — <next step, in sequence>. (<FR-xxx>)

## Tests

_The tests to write during implementation, and what each asserts. (End-to-end
tests are a separate stage — QA.)_

### Unit tests

- <unit test — what it asserts>

### Integration tests

- <integration test — what it asserts>

## Open questions

- _Anything unresolved — capture it instead of guessing._
