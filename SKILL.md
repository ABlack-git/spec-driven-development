---
name: spec-driven-development
description: >-
  Spec-driven development (SDD): Spec-driven development is a workflow where you first write a clear, structured specification of what to build (requirements, design, tasks) and then implement code against that spec as the source of truth, rather than coding first and documenting later. Use it to write requirements for a feature; break a feature into high-level implementation tasks, or expand a
  task into implementation; implement against tasks or a spec; write end-to-end test cases or
  verify a feature against its requirements; scaffold a `specs/` folder; or
  reconcile specs and code after a change. Also triggers on "spec-driven
  development" or "SDD", and on single-stage requests ("write requirements for…",
  "plan how we'll build this"). Skip it for trivial one-off changes.
---

# Spec-Driven Development

## Overview

Spec-driven development (SDD) is an approach to building software in which the
**specification is the primary artifact and the source of truth**, and code is
treated as something you derive from it. Rather than holding intent in a chat
thread and generating code from it directly, you write intent down and refine it
in stages — requirements (*what* and *why*), then a plan the engineer can read
and control (*how*), then implementation — with the durable stages recorded as
version-controlled documents in the project. Those documents, not the
conversation, are what you build against and keep current as things change.

Operate accordingly: do not jump from a request straight to implementation.
Establish or read the relevant spec first, work down through the stages, and
build only once the stage above it is settled. Work this way because you are
fast and literal — left to guess, you will build the wrong thing efficiently. A
written spec lets a wrong assumption surface in a paragraph instead of in a
thousand lines of code, and it re-grounds you (and the next session) on durable
context instead of a long, lossy chat history. Apply the structure as a means to
that end, not as a process to satisfy.

## When to use this

Use SDD when the work is **feature-shaped**: it has real requirements, more than
one sensible way to build it, or enough surface area that "just start coding"
tends to drift. It shines when multiple people (or multiple sessions) touch the
same work over time.

Don't reach for it for trivial changes — a one-line fix, an obvious rename, a
throwaway script. The structure is a tool you *choose* because it pays off, not
a mandate. If writing the spec would take longer than the change and teach you
nothing, just make the change.

## The workflow

SDD has two parts that work together.

**Standing context** is the durable, cross-cutting knowledge every feature is
built against. It is not a stage you pass through — it is always available and
read by every stage:

- **Architecture** — the evolving technical design of *this* system, organized by
  topic and living in the project's ordinary documentation (e.g. `docs/`), **not**
  under `specs/`. It is a **source of truth**: consult it before planning tasks
  and before implementing, and keep it honest against the code. The engineer owns
  it, and it can be seeded or extended ahead of or alongside a feature's
  requirements. Designing and writing these docs is its own activity — use the
  separate **design-and-doc** skill for that; SDD only *consumes* architecture as
  context, it does not produce it.

**The per-feature flow** is the linear pipeline you run for each feature. Each
stage narrows *what* into *how*:

| Stage | Question it answers | Artifact | Committed? |
| --- | --- | --- | --- |
| **1. Requirements** | *What* should this do, and why? | `specs/requirements/<feature>.md` | yes — source of truth |
| **2. Tasks** | *How* — the build split into engineer-sized slices | `specs/tasks/*.md` | no — local, disposable |
| **3. Implementation** | The actual change | code + tests | yes |
| **4. QA** | Does the built feature satisfy its requirements, end to end? | `specs/qa/…` | test cases + RTM: yes |

- **Requirements** — describe what the system must do in plain, non-technical
  language. Requirements avoid implementation detail; anyone, technical or not,
  should be able to read and understand them.
- **Tasks** — the place in the pipeline where the engineer gathers a high-level
  picture of the implementation and **controls what the agent will build**, before
  any code exists. A feature is **split into a handful of tasks** — coherent,
  engineer-sized slices (default: vertical slices through the stack), one file
  each — so a person can actually review the work instead of rubber-stamping one
  giant plan. Each task names the decisions (data model, API shape, structure) and
  the parts to build, *close to the code but without the noise* — no file-by-file
  detail, no finished code. Tasks are a working surface, not an archival record:
  local, git-ignored, and disposable once the work is done. They are
  **co-authored, with the engineer steering** — the engineer brings the structural
  decisions and how to split the work, and you refine the draft together in a
  loop, not "the agent proposes, the engineer approves." A plan the engineer only
  reacts to is vibe-coding with an extra click, so this stage pays off only when
  they actually engage; if they will rubber-stamp whatever is drafted, it is
  better skipped than run half-heartedly.
- **Implementation** — done **one task at a time**. For each task the agent uses
  **planning mode** to expand it into a detailed, executable plan — grounded in the
  requirements and the task — writes that detailed plan into the local task file,
  and then writes the code and the tests. The committed output is the code and
  tests; the task stays local.
- **QA** — a multi-step stage focused on end-to-end tests. First define test
  cases from the requirements; then plan how to automate them; update the RTM to
  record coverage; finally implement the automated tests. End-to-end tests treat
  the system as a **black box** — verify observable behavior against the
  requirements, without consulting the feature's code.

**Do not race to complete every stage in one pass.** The value of SDD comes from
keeping the stages separate — treat each as a stopping point, not a hurdle to
clear on the way to code. Being eager to reach implementation defeats the
purpose: it collapses the checkpoints where a wrong assumption is cheap to fix.
Default to doing one stage, then stopping.

**Confirm each stage before building on it.** This is not a mandated sign-off —
it is where the leverage is: a wrong requirement caught before the plan costs a
sentence, but caught after implementation it costs a rewrite. After producing an
artifact, surface it for review and get confirmation before moving to the next
stage, so you always have a checked foundation under you.

## Core principles

- **The committed spec is the source of truth.** The durable specs —
  requirements, architecture, and QA — are what the code must agree with. When
  code and a committed spec disagree, one of them is wrong. Stop and surface the
  discrepancy to a person, and let them decide which to reconcile — do not
  silently pick one or let them drift. This is the whole ballgame; everything
  else supports it.
- **Separate *what* from *how*.** Requirements describe observable behavior and
  intent, never mechanism. The plan and architecture decide mechanism. Keeping
  them apart lets you change the plan without re-litigating the goal.
- **Tasks are a control surface, not a spec.** A feature's tasks are *derived
  from* the committed specs and exist so the engineer can comprehend and steer
  the implementation before code exists. They are local and disposable — edit them
  freely, throw them away when done. They carry no maintenance obligation, because
  they are not a shared record of truth.
- **Traceability by reference.** Every requirement gets a stable ID (e.g.
  `FR-014`). The plan, architecture, and QA *reference* those IDs rather than
  restating them, so you can always answer "is every requirement covered?" and
  "why does this work exist?"
- **Decisions vs. mechanics.** A human reviews *decisions* — a data model, an API
  contract, a sync-vs-async choice — including detailed ones. A human does not
  need to review *mechanics* — which file, what order, boilerplate. Tasks hold
  decisions and stay high-level; mechanics belong to the detailed implementation
  plan and the code.

## Folder structure

Committed specs live under `specs/` in the project, version-controlled alongside
the code. The local task folders are created under `specs/` too but are added to
`.gitignore`, so they are never committed.

Architecture docs are **not** here — they live in the project's ordinary
documentation (e.g. `docs/`) and are consumed as standing context.

```
specs/
  requirements/            # one file per feature, plain business language
    user-auth.md
  tasks/                   # LOCAL, git-ignored: flat, one file per task, datetime-prefixed (disposable)
    20260916T1319_reset-request.md   # each task: high-level slice + its detailed impl plan
    20260916T1402_reset-confirm.md
  qa/                      # end-to-end verification against requirements
    test-cases/            # committed: E2E scenarios per feature; each case references the requirement(s) it verifies
      user-auth.md
    tasks/                 # LOCAL, git-ignored: QA tasks (disposable) — flat, one file per task, datetime-prefixed
    rtm.md                 # committed: requirement -> test-case coverage matrix (project-wide)
```

**File naming.** Committed per-feature artifacts — requirements and QA test
cases — are named by **feature slug** (`user-auth.md`), one file per feature.
Tasks live flat in
`specs/tasks/`, one file per task named `<datetime>_<task_name>.md`
(`specs/tasks/20260916T1319_build-backend-api.md`) — the `YYYYMMDDTHHMM` prefix is
the creation time, so tasks stay ordered and unique without a per-feature folder.
The feature a task serves is recorded in its frontmatter, not the path.

### Cross-cutting decisions

While planning a feature, watch for decisions that reach beyond it. **If a
decision would be reused or contradicted by another feature, it is not
feature-local — it belongs in an architecture doc**, not buried in one feature's
tasks. When you hit one, surface it to the engineer; once it is settled and
documented (using the design-and-doc skill), the task simply references it.

## Keeping specs honest

The committed specs are living documents, not write-once artifacts — the value
evaporates if they rot. When something changes, **start at the highest stage the
change affects and flow the change downward**: update the requirement, then the
code and QA. If while planning or implementing you discover the requirement
itself is wrong, flow *back up* — fix the requirement first, then come back down.
Don't patch a lower artifact to match reality while leaving a higher one stale. A
substantial change may also leave an architecture doc stale — that is a **soft**
prompt to revisit those docs, not a tracked step in this flow.

Tasks are exempt: they are local and disposable, so you regenerate them
rather than maintain them. For the detailed change-propagation and
drift-detection guidance, see
[references/maintenance.md](references/maintenance.md).

## Getting started

To set up SDD in a project, run the bootstrap script:

```
scripts/init.sh [target-dir]      # target-dir defaults to the current directory
```

**When to run it:** once, when setting up SDD in a project that does not yet have
a `specs/` tree (or is missing parts of it). It bootstraps the folder layout — it
is not run per feature. If `specs/` already exists and is fully scaffolded, you
do not need it.

**What it does:** creates the committed spec folders (`requirements/`,
`qa/test-cases/`, each `.gitkeep`-tracked); creates the local,
disposable task folders (`tasks/`, `qa/tasks/`) and adds them to `.gitignore` so
they are never committed; and seeds `specs/README.md` and the project-wide
`specs/qa/rtm.md`. It is safe to re-run — it never overwrites existing files, and
only fills in what is missing.

**What it does not do:** it writes no requirements, architecture, plans, or code,
and it does not touch `AGENTS.md` — that step is below, and is left to you because
the file may already have content to merge into.

Then record the methodology and the project's conventions where future agents
will see it — a step the script deliberately leaves to you, because it requires
merging into a file that may already have content. Add a section to the project's
`AGENTS.md` stating that this project follows spec-driven development as defined
by this skill, that the committed `specs/` are the source of truth, and that
agents should consult this skill before writing requirements, planning, or code.
`AGENTS.md` is also where the project's conventions live — tech stack, coding
standards, repository layout, testing approach — so that context is stated once
and applied uniformly instead of guessed anew each session. **If `AGENTS.md`
already exists, append to it — do not overwrite what is there.** Create the file
only if it does not exist.

## Writing each artifact

Once you know the stage you're working at, read the focused guide for it.
Load only the one you need — keep the rest out of context.

- **Writing requirements** → [references/writing-requirements.md](references/writing-requirements.md)
- **Breaking a feature into tasks** → [references/writing-tasks.md](references/writing-tasks.md)
- **Implementing against a plan** → [references/implementing.md](references/implementing.md)
- **Writing end-to-end tests (QA)** → [references/writing-qa.md](references/writing-qa.md)
- **Changing existing specs** → [references/maintenance.md](references/maintenance.md)

Architecture is standing context here, not an artifact this skill produces. To
design or write an architecture doc, use the separate **design-and-doc** skill.

Templates for the committed artifacts and the plan live in [assets/](assets/).
