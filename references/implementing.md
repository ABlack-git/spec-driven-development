# Implementing against a spec

Stage 4: write the code and tests that fulfil an implementation plan that has
been reviewed and marked **ready**. The specs carry the detail — this guide is
deliberately short. For the overall approach and artifact lifecycle, see the
main `SKILL.md`.

## Before you start

- Read related implementation plan, plus the requirements and
  design docs it references (`satisfies` / `depends-on`) and the **charter**. Your
  work must adhere to all of them.
- **Clarify any dependency, ambiguity, or missing decision with a developer
  before coding.** Do not guess.

## While implementing

- **Follow the plan's steps in order.** Write the code, and write the **unit and
  integration tests** the plan's Tests section specifies — not just the code.
- **Adhere to the charter** — stack, standards, conventions.
- **Stay in scope.** Build what the requirements and plan ask for, nothing extra.
- **Track progress** — check off each step (`[ ]` → `[x]`) as you complete it.

## When the spec is wrong

The spec is the source of truth. If reality contradicts it — the approach will
not work, or a requirement or design turns out to be wrong — **stop and surface
it to a person** so it is fixed upstream (requirement → design → plan). Do not
silently code around a mismatch, and do not let code and spec drift apart. (See
[maintenance.md](maintenance.md).)

## Finishing

- **Verify.** Run the specified tests and confirm the behavior matches the
  requirements' EARS statements.
- **Mark the plan `completed`** — set its `status` to `completed` once all steps
  are done.
- **Do one stage, then stop.** End-to-end verification is the QA stage.
