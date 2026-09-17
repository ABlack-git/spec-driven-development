# Writing tasks

This guide covers **how to break a feature into tasks** — stage 2 of the
per-feature flow, where requirements (the *what*) become a set of high-level,
engineer-sized plans for *how* to build it. For the overall approach and folder
structure, see the main `SKILL.md`; this guide does not restate them.

Tasks live flat in `specs/tasks/`, **one file per task**, named
`<datetime>_<task_name>.md` — e.g. `20260916T1319_build_backend_api.md`, where the
`YYYYMMDDTHHMM` prefix is the task's creation time (it keeps tasks ordered and
unique without a per-feature folder). The feature a task belongs to is recorded in
its frontmatter (`feature:` and the `FR-xxx` IDs it delivers), not in the path.
Start each from [../assets/task-template.md](../assets/task-template.md).

This guide also governs **QA test-implementation tasks** (same flat layout, under
`specs/qa/tasks/`): written identically, but they deliver `TC-xxx` test cases
instead of `FR-xxx` requirements. See [writing-qa.md](writing-qa.md) for the
QA-specific deltas.

## What tasks are for

A feature can carry many requirements and span the stack. One giant plan for all
of it is exactly what a person cannot review in one sitting — so it gets
rubber-stamped, false confidence at full cost. Instead, **split the feature's
implementation into a handful of tasks, each small enough that the engineer can
hold it in their head and say "yes, build that."** Comprehension and control are
the whole point: a task is a unit of work a person can actually reason about
before any code exists.

Tasks are a **working surface, not a spec**. They are *derived from* the
requirements and architecture — not themselves a source of truth. So they are
**local, git-ignored, and disposable**: edit them freely, and throw them away
once the work is done. They carry no versioning, no change log, and no
maintenance obligation.

## How to split a feature into tasks

**Default to vertical slices.** A task should be a coherent capability that can
be built and, ideally, verified on its own — usually a group of related
requirements, cutting through the stack (schema → API → UI) as far as that one
capability needs. A vertical task ("add edit functionality end-to-end", "add the
new fields through schema, API, and form") is independently comprehensible; a
layer-only task ("all of the backend") usually cannot be validated by itself.

- **Propose, don't impose.** Draft a proposed list of tasks and their scope, then
  let the engineer reorganize it — *they* decide the grouping they comprehend
  best. Splitting by capability, by requirement group, or (when a single slice is
  genuinely too large) by layer are all fair. The engineer's comprehension is the
  deciding test, not a rule.
- **Right-sized.** A task is *bigger* than file-by-file mechanics but *smaller*
  than a whole sprawling feature. Too big to review in one sitting → split it. A
  dozen one-line tasks → merge them.
- **Each task references the requirements it implements** (`FR-xxx`; see
  "Delivers" below). Together the tasks should cover the feature's requirements —
  that is the coverage check. The RTM holds the authoritative record.

## Shared decisions across tasks

There is no parent plan above the tasks, so watch for a decision that several
tasks depend on (a schema or an API contract they share) — it needs a single
home, not a copy in each file:

- If it is **cross-feature** — reused or contradicted by *another feature* — it
  is not feature-local: it belongs in an **architecture doc**. Surface it to the
  engineer; once it is settled and documented (see the **design-and-doc** skill),
  have every task reference it.
- If it is shared only **within this feature**, the task that introduces it
  **owns** it; sibling tasks **reference** that task rather than restating the
  decision. Never copy a shared decision into several task files — pick one owner.

## The altitude: decisions vs. mechanics

This is the discipline that keeps a task *reviewable*. The old failure mode was
plans so long and detailed that a human could not actually read them, so they got
rubber-stamped — false confidence at full cost. Keeping each task short fixes
readability, but brevity alone does not create scrutiny: a short task is *easier*
to nod through. What actually guards against false confidence is the engineer
engaging with the draft (see "Working with the engineer" below); brevity only
makes that engagement possible.

- A human reviews **decisions** — a data model, an API contract, a sync-vs-async
  choice, which components will exist. Put these in the task, including detailed
  ones, but stated as *one line each*.
- A human does **not** need to review **mechanics** — which file, what order,
  imports, boilerplate. Keep these out; they belong to the detailed
  implementation plan (produced in planning mode during implementation) and the
  code.

The test for whether a decision belongs here: *if you changed it six months from
now, would you have to redo work or change observable behavior?* If yes, it is a
decision — name it. If it is just "where the code sits / in what order", it is
mechanics — leave it out.

## What goes in a task

Write it **proportionally** — a small task is a few bullets, a larger one uses
every section. The template has:

- **Delivers** — the requirement IDs (`FR-xxx`) this task implements. This is the
  engineer's own coverage check; the authoritative record is the RTM.
- **Decisions** — the data model, API shape, and structure this task involves,
  one line each. Reference a sibling task or an architecture doc for a *shared*
  decision rather than restating it. Add a short *why* only when non-obvious.
- **Parts** — the parts to build, close to the code: modules or services on the
  backend, components on the frontend. Name them; do not describe how each is
  built.
- **High-level steps** — the work broken into coherent, ordered chunks a person
  can follow. Not file-by-file — each step is a unit of work, not a diff.
- **Open questions** — anything unresolved; capture it instead of guessing.

## What stays out

- **Finished code.** A signature or a one-line schema is fine where it removes
  ambiguity; function bodies are not.
- **File-by-file steps and edit ordering.** That is the detailed implementation
  plan's job, made during implementation.
- **Restated requirements or architecture.** Reference the `FR-xxx` ID or the
  architecture doc for the *what* and the cross-cutting *how*; do not copy their
  prose. The new thing a task adds is the mapping onto *this* slice of the build.

## Cross-cutting decisions

While planning, watch for a decision that would be reused or contradicted by
another feature. That decision is **not feature-local** — surface it to the
engineer, and once it is settled and documented in an architecture doc, the task
just references it. Do not bury a cross-cutting decision inside one feature's
tasks. Writing that doc is the **design-and-doc** skill's job, not this one's.

## Working with the engineer

- **Tasks are co-authored, and the engineer steers.** This is their control
  point. The engineer brings the intent and the structural decisions — the API
  shape, the data model, which services or components exist, and how the feature
  is split into tasks; you help draft, propose options, and surface gaps, and you
  refine it *together*, in a loop, until they are satisfied. It is **not** "the
  agent drafts, the engineer approves" — a plan the engineer only reacts to is
  vibe-coding with an extra click. Draw the decisions out of them; do not settle
  them silently and hand over a fait accompli.
- **This stage only pays off if the engineer actually engages.** The refinement
  loop above and a rubber-stamp produce the *identical files* — the skill cannot
  tell them apart, only the engineer can. If they are going to approve whatever is
  drafted without pushing on it, this stage is ceremony: better to skip it and
  just code than to run it half-heartedly, because a rubber-stamped task dresses
  an unexamined agent decision up as a human decision. Steer it for real, or don't
  run it.
- If a step **is** feature work yet maps to no requirement, that is a gap — stop
  and surface it; do not paper over it.
- **Do one stage, then stop.** Once the tasks are drafted and agreed, surface them
  for review and approval before implementing. Do not start writing code —
  expanding a task into detail and writing the code is the implementation stage,
  and it is done **one task at a time** (see [implementing.md](implementing.md)).

## Common pitfalls

- Sliding back into a bloated design doc — explaining *how* each part is built
  instead of naming the part and the decision.
- File-by-file steps, edit ordering, or finished code in a task.
- Restating requirements or architecture instead of referencing them.
- A cross-cutting decision buried in one task instead of surfaced for the
  architecture docs; or a within-feature shared decision copied into several tasks
  instead of owned by one.
- Splitting horizontally (backend task, frontend task) when a vertical slice would
  be independently comprehensible and testable.
- Treating tasks as durable records — they are disposable control surfaces.
- Rubber-stamping the agent's draft instead of steering it — a plan the engineer
  only reacts to is vibe-coding with an extra step, and defeats the stage.
