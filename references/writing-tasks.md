# Breaking work into tasks

This guide covers **how to break work into tasks** — stage 3 of spec-driven
development, where requirements and design become a concrete, ordered plan to
implement. For the overall approach, folder structure, and artifact lifecycle,
see the main `SKILL.md`; this guide does not restate them.

Implementation plans live at
`specs/implementation/YYYYMMDDTHHMM-<slug>.md` (see [Naming](#naming)). Start
from
[../assets/implementation-plan-template.md](../assets/implementation-plan-template.md).

## Language and style

Write so the plan has exactly one possible reading:

- Be **precise, explicit, and unambiguous.** If a step could be read two ways,
  rewrite it until it cannot.
- Use **plain, direct language** — the simplest phrasing that is still accurate.
  Do not use words fancier or phrases more complicated than the meaning needs.
- **No idioms, metaphors, or figures of speech.**
- Avoid vague quantifiers. State the exact file, change, or condition.

## What this stage produces

An **implementation plan**: a researched, concrete plan for building the work.
Producing it is an **analysis step** — you investigate the actual codebase and
write down what exists, what to change, where, and in what order. It is the same
kind of plan a coding agent produces before implementing, except here it is
**persisted** as the stage-3 artifact instead of thrown away.

The **document is the plan; the steps within it are the tasks.** A plan is
usually scoped to one feature, but not always — it can also be **setup work**
(bootstrap, tooling, test harness) or a **cross-cutting concern** (logging,
shared error handling, config). Non-feature plans are normal and expected.

## The shape of an implementation plan

Frontmatter (`feature`, `satisfies`, `depends-on`, `status`) followed by these
sections: **Approach & analysis**, **Steps**, **Tests**, and **Open questions**.
The full layout is in
[../assets/implementation-plan-template.md](../assets/implementation-plan-template.md);
each section is covered below.

The `status` field tracks the plan's lifecycle: it starts at `draft` when you
create the plan, becomes `ready` once the plan is finalized and approved for
implementation, and is set to `completed` when all steps are done during
implementation (see [implementing.md](implementing.md)).

## Naming

Name the file `YYYYMMDDTHHMM-<slug>.md`, e.g. `20260912T1524-user-auth.md`. The
timestamp is the **creation time, set once and never changed** — it is a
creation marker, not a modified marker. Because implementation plans are event
artifacts, this sorts them by the order they were created. (QA task files under
`qa/tasks/` use the same convention.)

## Do the analysis first

The value of this stage is the analysis, not the formatting. Before writing
steps, **read the real code**: what already exists, which seams to use, what is
missing. Ground the plan in findings — "`AuthService` already issues tokens, so
extend it rather than add a service"; "no e2e harness exists, so step 0 sets one
up." A reviewer checks the plan by checking the approach against the actual
codebase, so the approach must be visible.

## Writing a step

Steps are **free-form — there are no fixed fields to fill.** What matters is that
the steps, taken together, make the change concrete and executable by an agent
whose only context is the specs. Every step should make clear:

- **Which files are relevant** — what to create or change.
- **What needs to change** in them.
- **Where it sits in the sequence** — steps are listed in implementation order.

Beyond that:

- **Detailed, but still a plan — not the code.** Include a signature or small
  snippet only where it removes ambiguity. A step should be reviewable as an
  approach ("yes, that is the right change in the right place") without being the
  diff itself. Writing the working code is the implementation stage.
- **Reference, don't restate.** Point at the design section, requirement ID, or
  architecture doc for the *why* and the *contract*; do not copy that prose. The
  new detail a step adds is the mapping onto *this repository* — which design
  deliberately left out.
- **One coherent change per step**, reviewable in a single sitting. Too big:
  "build the feature." Too small: "add an import."

## Specify the tests

Specifying the tests is part of the plan, not an afterthought. Collect them in
the plan's **Tests** section, split into **Unit tests** and **Integration
tests** subsections: name the tests to write and what each asserts — so they are
decided and reviewed before implementation, not backfilled. These are the tests
written during implementation; the end-to-end tests are a separate stage (QA).

## Traceability and non-feature work

**Every step must trace to something** — a requirement, an architecture doc or
charter concern, or an explicit setup/infrastructure rationale. Nothing
arbitrary. But the upstream is not always a requirement:

- Feature steps reference the requirement (`FR-xxx`) and design they deliver.
- Setup and cross-cutting steps reference the charter/architecture they serve, or
  state their infrastructure rationale; `satisfies` is then empty.

If a step **is** feature work yet maps to no design or requirement, that is a
**design gap** — stop and surface it to a person; do not paper over it in the
plan.

## Progress and change

Implementation plans are **event artifacts**:

- Track progress with checkboxes (`[ ]` → `[x]`).
- Append new steps for extra work you discover **while executing this plan**. Do
  not rewrite a completed step — it records work that was actually done.
- When a change comes from **modifying existing requirements or design**, create
  a **new plan** for it rather than editing this one (see
  [maintenance.md](maintenance.md)).

## Working with the engineer

This stage is more mechanical than design: you can propose the full plan, and
the engineer reviews it. Still, surface decisions and gaps rather than deciding
silently, and capture unresolved items in "Open questions."

**Do one stage, then stop.** Once the plan is drafted, surface it for review and
approval before implementing. Do not start writing code.

## Common pitfalls

- Listing steps without the analysis they should rest on.
- Steps that are vague, unverifiable, or not grounded in the real code.
- Restating design instead of referencing it.
- Steps too large to review, or too small to matter.
- Arbitrary steps that trace to nothing upstream.
- Writing the finished code instead of a reviewable plan.
