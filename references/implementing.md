# Implementing a task

Stage 3 of the per-feature flow, done **one task at a time**: expand an approved
task into a detailed plan, then write its code and tests. The specs carry the
detail — this guide is deliberately short. For the overall approach, see the main
`SKILL.md`.

## Before you start

- Pick the task to build, and read it (`specs/tasks/<datetime>_<task_name>.md`), the
  requirements it delivers, the **architecture** docs it relies on, and
  **`AGENTS.md`**. Your work must adhere to all of them.
- **Clarify any dependency, ambiguity, or missing decision with a developer
  before coding.** Do not guess.

## Produce the detailed plan first

Use **planning mode** to expand the task's high-level steps into a **detailed,
file-level implementation plan** — what to create or change, where, and in what
order — grounded in the requirements and the task. **Write that detailed plan into
the local task file** (`specs/tasks/<datetime>_<task_name>.md`) so it is reviewable as a
document rather than living in the chat. It stays local and disposable, like the
task itself.

Surface the detailed plan for approval before writing code. This is the last
cheap checkpoint.

## While implementing

- **Follow the detailed plan in order.** Write the code, and write the **unit and
  integration tests** — not just the code. (End-to-end tests are the QA stage.)
- **Adhere to `AGENTS.md` and the architecture** — stack, standards, conventions,
  and the system's design.
- **Stay in scope.** Build what the requirements and plan ask for, nothing extra.
- **Track progress** — check off each step (`[ ]` → `[x]`) as you complete it.

## When the spec is wrong

The committed spec is the source of truth. If reality contradicts it — the
approach will not work, or a requirement or architecture doc turns out to be
wrong — **stop and surface it to a person** so it is fixed upstream (requirement
→ architecture → task). Do not silently code around a mismatch, and do not let
code and the committed specs drift apart. (See [maintenance.md](maintenance.md).)

## Finishing

- **Verify.** Run the tests and confirm the behavior matches the requirements'
  EARS statements.
- The task is local and disposable — discard it or leave it, as you prefer.
  Nothing about it needs to be committed or maintained.
- **One task at a time.** If the feature has more tasks, return to "Before you
  start" for the next one — implement and review them one by one, not all at once.
- **Do one stage, then stop.** End-to-end verification is the QA stage.
