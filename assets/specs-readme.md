# Specs

This folder is the home of this project's **specifications**. The project is
built using **spec-driven development (SDD)**, which means these documents — not
chat logs or tribal knowledge — are the source of truth for what the software
does and how it is built.

## What is spec-driven development?

Instead of jumping straight from an idea to code, we write the intent down and
refine it in stages: first *what* we want, then a high-level plan for *how* we'll
build it, then the code, then the tests that prove it works. The durable stages
are captured as version-controlled documents that live here alongside the code.

The point is simple: catching a misunderstanding in a paragraph is far cheaper
than catching it in a thousand lines of code. The specs give everyone — people
and AI agents alike — a shared, current picture of the system to build against.

The committed documents are **living**: when something changes, we update the
spec, not just the code. If the code and a committed spec disagree, one of them
is wrong, and we reconcile them rather than let them drift apart.

## Standing context

Two things sit outside the per-feature flow and are read by every stage:

- **`AGENTS.md`** (in the project root) — the project's conventions and rules:
  tech stack, coding standards, repository layout, testing approach. Read it
  first; everything here must respect it.
- **Architecture docs** — the evolving technical design of the system, organized
  by topic (auth, data storage, …). These live in the project's ordinary
  documentation (e.g. `docs/`), **not** under `specs/`. They are committed and
  kept current, and can be developed ahead of or alongside a feature's
  requirements.

## The per-feature flow

1. **Requirements** — what the system must do, in plain non-technical language
   anyone can understand. No implementation detail. *(committed)*
2. **Tasks** — the feature's implementation split into a handful of high-level,
   engineer-sized slices: the decisions (data model, API, structure) and the
   parts to build, at a level a person can read and control. One file per task.
   *(local and disposable — see below)*
3. **Implementation** — the actual code and tests, built **one task at a time**.
   The detailed, file-level plan is expanded from each task during
   implementation. *(code committed)*
4. **QA** — end-to-end tests that verify the finished feature against its
   requirements, treating the system as a black box. *(test cases + RTM
   committed)*

## Folder structure

```
specs/
  requirements/      One file per feature, in plain business language.
  tasks/             LOCAL, git-ignored, disposable. Flat; one file per task named
                     <datetime>_<name>.md: the engineer's high-level slices and,
                     expanded into each during implementation, its detailed plan.
  qa/
    test-cases/      End-to-end test scenarios per feature.
    tasks/           LOCAL, git-ignored. QA tasks (flat, one file per task) — steps
                     to automate the test cases, written like implementation tasks.
    rtm.md           Requirement traceability matrix: which requirement is
                     covered by which test.
```

`tasks/` and `qa/tasks/` are **local scratch**, not committed specs: they are the
engineer's working surface for steering an implementation, and are discarded when
the work is done.

## How to read a feature

To understand a feature, start with its **requirements** (what and why), read the
relevant **architecture** for the *how* of the system it lives in, and finally
its **QA** test cases (how we know it works). Requirements carry stable IDs (e.g.
`FR-014`) that the later documents reference, so you can always trace a test back
to the requirement it serves.
