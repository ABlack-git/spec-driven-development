---
name: spec-driven-development
description: >-
  A structured way to build software with AI agents: capture intent as
  requirements, work it down through design and tasks, then implement — with
  the specs kept as the durable source of truth the agent builds from. Use this
  whenever the work involves capturing or writing requirements for a feature,
  creating or updating a technical design or architecture doc, breaking a design
  into implementation tasks, implementing against an existing spec, defining
  end-to-end test cases or verifying a feature against its requirements,
  scaffolding or organizing a `specs/` folder, or keeping specs and code
  consistent when
  something changes — as well as when "spec-driven development", "SDD", or
  "structured development with agents" is mentioned directly. Applies even when
  the user asks for one stage in isolation (e.g. "help me write requirements
  for…", "turn this into a design", "split this into tasks").
---

# Spec-Driven Development

## Overview

Spec-driven development (SDD) is an approach to building software in which the
**specification is the primary artifact and the source of truth**, and code is
treated as something you derive from it. Rather than holding intent in a chat
thread and generating code from it directly, you write intent down and refine it
in stages — requirements (*what* and *why*), then design (*how*), then tasks
(*in what order*), then implementation — with each stage recorded as a durable,
version-controlled document in the project. Those documents, not the
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
one sensible design, or enough surface area that "just start coding" tends to
drift. It shines when multiple people (or multiple sessions) touch the same
work over time.

Don't reach for it for trivial changes — a one-line fix, an obvious rename, a
throwaway script. The structure is a tool you *choose* because it pays off, not
a mandate. If writing the spec would take longer than the change and teach you
nothing, just make the change.

## The flow

SDD moves through five **stages**. Each one narrows *what* into *how*, and each
produces an artifact the next stage builds on:

| Stage | Question it answers | Artifact |
| --- | --- | --- |
| **1. Requirements** | *What* should this do, and why? | `specs/requirements/<feature>.md` |
| **2. Design** | *How* will we build it? | `specs/design/…` |
| **3. Tasks** | In what order, verified how? | `specs/implementation/…` |
| **4. Implementation** | The actual change | Code + tests |
| **5. QA** | Does the built feature satisfy its requirements, end to end? | `specs/qa/…` |

- **Requirements** — describe what the system must do in plain, non-technical
  language. Requirements avoid implementation detail; anyone, technical or not,
  should be able to read and understand them.
- **Design** — convert the requirements into technical documents. This may span
  wider system architecture (cross-cutting decisions) as well as the technical
  detail for a particular feature.
- **Tasks** — convert requirements and design into actionable items that
  translate directly into code. This stage also specifies the unit and
  integration tests that will accompany the implementation.
- **Implementation** — take the requirements, design, and tasks together and
  write the actual code and the tests defined for it.
- **QA** — a multi-step stage focused on end-to-end tests. First define test
  cases from the requirements; then define tasks for how to implement those
  cases as automated tests; update the RTM to record coverage; finally implement
  the automated tests. End-to-end tests treat the system as a **black box** —
  verify observable behavior against the requirements, without consulting the
  features' code implementation.

**Do not race to complete every stage in one pass.** The value of SDD comes from
keeping the stages separate — treat each as a stopping point, not a hurdle to
clear on the way to code. Being eager to reach implementation defeats the
purpose: it collapses the checkpoints where a wrong assumption is cheap to fix.
Default to doing one stage, then stopping.

**Confirm each stage before building on it.** This is not a mandated sign-off —
it is where the leverage is: a wrong requirement caught before design costs a
sentence, but caught after implementation it costs a rewrite. After producing an
artifact, surface it for review and get confirmation before moving to the next
stage, so you always have a checked foundation under you.

## Core principles

- **The spec is the source of truth.** When code and spec disagree, one of them
  is wrong. Stop and surface the discrepancy to a person, and let them decide
  which to reconcile — do not silently pick one or let them drift. This is the
  whole ballgame; everything else supports it.
- **Separate *what* from *how*.** Requirements describe observable behavior and
  intent, never mechanism. Design decides mechanism. Keeping them apart lets you
  change the plan without re-litigating the goal.
- **Traceability by reference.** Every requirement gets a stable ID (e.g.
  `FR-014`). Design and tasks *reference* those IDs rather than restating them,
  so you can always answer "is every requirement covered?" and "why does this
  task exist?"
- **State vs. event artifacts.** Artifacts that describe *what is currently
  true* (requirements, design docs) are **edited in place** — git holds their
  history. Artifacts that record *work performed* (tasks) are **appended to** —
  you never rewrite a completed task.

## Folder structure

All specs live under `specs/` in the project, version-controlled alongside the
code. This layout is the single source of truth — the reference files below
point here rather than restating it.

```
specs/
  charter/                 # project constitution: tech stack, standards, principles
  requirements/            # one file per feature, plain business language
    user-auth.md
  design/
    architecture/          # living cross-cutting design docs, organized by topic
      auth.md
      data-storage.md
    features/              # feature-level design, references requirements + architecture
      user-auth.md
  implementation/          # stage 3: implementation plans (analysis + ordered steps)
    20260912T1524-user-auth.md   # named by creation time; appended as work is done
  qa/                      # stage 5: end-to-end verification against requirements
    test-cases/            # E2E scenarios per feature; each case references the requirement(s) it verifies
      user-auth.md
    tasks/                 # test-implementation plans, named by creation time
      20260912T1600-user-auth.md
    rtm.md                 # requirement -> test-case coverage matrix (project-wide)
```

**File naming follows the artifact kind.** State artifacts — requirements,
feature design docs, and QA test cases — are named by **feature slug**
(`user-auth.md`), one file per feature. Event artifacts — implementation and QA
task plans — are named by **creation timestamp** (`20260912T1524-user-auth.md`),
so they sort in the order they were created. Cross-cutting artifacts
(architecture docs) are named by topic (`auth.md`).

### The charter

The **charter** is the project's constitution: the durable, project-wide norms
and constraints that hold across every feature. It is *not* feature-specific and
does not flow through the pipeline the way requirements and design do — it is the
fixed context that all four stages read and must respect.

**Why it exists.** Without a charter, an agent re-derives the project's
conventions from scratch every session — guessing the stack, the layering, how
tests are written — and guesses differently each time, so the code drifts out of
consistency. The charter is the durable, written answer to "how do we build
things here," so that context is stated once and applied uniformly instead of
inferred anew. It is what lets independent sessions and different agents produce
code that looks like one project wrote it.

**What might go in one.** The developer decides the contents — this is not a
fixed structure, and a charter should stay lean. As a guide, only capture what is
(a) *cross-cutting* — it applies across features, not to one; (b) *durable* — it
changes rarely; and (c) *would otherwise be guessed inconsistently*. Anything
that fails those tests belongs in a requirement, a design doc, or the code — not
the charter. Things teams commonly find worth stating:

- **Tech stack** — languages and versions, frameworks, datastore, key libraries.
- **Coding standards and conventions** — naming, formatting, linting, error handling.
- **Architectural principles** — default patterns, layering, API conventions.
- **Repository structure** — how the repo is laid out and what belongs where.
- **Testing approach** — the kinds of tests used, frameworks, and expectations.

Use the ones that earn their place and drop the rest;
[assets/charter-template.md](assets/charter-template.md) offers these as a
starting point, not a requirement.

Treat the charter as authoritative and read it first. Design must conform to it,
implementation must follow it, and when a requirement or design would violate
it, that is a conflict to surface to a person — not something to quietly work
around. It is long-lived and changes rarely; when it does change, edit it in
place (it is a state artifact, like requirements and design). If a project has
no charter yet, establishing one is a reasonable first step before feature work
begins.

## Keeping specs honest

Specs are living documents, not write-once artifacts — the value evaporates if
they rot. When something changes, **start at the highest stage the change
affects and flow the change downward**: update the requirement, then reconcile
the design, then the tasks, then the code. If while designing or implementing
you discover the requirement itself is wrong, flow *back up* — fix the
requirement first, then come back down. Don't patch a lower artifact to match
reality while leaving a higher one stale.

For the detailed change-propagation and drift-detection guidance, see
[references/maintenance.md](references/maintenance.md).

## Getting started

To set up SDD in a project, scaffold the `specs/` structure and seed the
starting files (charter, README, and the project-wide RTM):

```
scripts/init.sh
```

The script is safe to re-run — it never overwrites files that already exist.
This skill folder is meant to be **copied into a target project** so the skill
and its references travel with the code that depends on them.

Then record the methodology where future agents will see it — a step the script
deliberately leaves to you, because it requires merging into a file that may
already have content. Add a short section to the project's `AGENTS.md` stating
that this project follows spec-driven development as defined by this skill, that
`specs/` is the source of truth, and that agents should consult this skill before
writing requirements, design, or code. **If `AGENTS.md` already exists, append
this section to it — do not overwrite what is there.** Create the file only if it
does not exist. This is what makes an agent pick up the approach in later sessions
without being told.

## Writing each artifact

Once you know the stage you're working at, read the focused guide for it.
Load only the one you need — keep the rest out of context.

- **Writing requirements** → [references/writing-requirements.md](references/writing-requirements.md)
- **Writing design docs** → [references/writing-design.md](references/writing-design.md)
- **Breaking work into tasks** → [references/writing-tasks.md](references/writing-tasks.md)
- **Implementing against a spec** → [references/implementing.md](references/implementing.md)
- **Writing end-to-end tests (QA)** → [references/writing-qa.md](references/writing-qa.md)
- **Changing existing specs** → [references/maintenance.md](references/maintenance.md)

Templates for each artifact live in [assets/](assets/).
