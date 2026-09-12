# Specs

This folder is the home of this project's **specifications**. The project is
built using **spec-driven development (SDD)**, which means these documents — not
chat logs or tribal knowledge — are the source of truth for what the software
does and how it is built.

## What is spec-driven development?

Instead of jumping straight from an idea to code, we write the intent down and
refine it in stages: first *what* we want, then *how* we'll build it, then the
concrete steps, then the code, then the tests that prove it works. Each stage is
captured as a durable, version-controlled document that lives here alongside the
code.

The point is simple: catching a misunderstanding in a paragraph is far cheaper
than catching it in a thousand lines of code. The specs give everyone — people
and AI agents alike — a shared, current picture of the system to build against.

These documents are **living**: when something changes, we update the spec, not
just the code. If the code and the spec disagree, one of them is wrong, and we
reconcile them rather than let them drift apart.

## The five stages

1. **Requirements** — what the system must do, in plain non-technical language
   anyone can understand. No implementation detail.
2. **Design** — how we'll build it: system architecture and the technical detail
   for each feature.
3. **Tasks** — the requirements and design broken into concrete, ordered work
   items that translate directly into code (including unit and integration
   tests).
4. **Implementation** — the actual code and tests.
5. **QA** — end-to-end tests that verify the finished feature against its
   requirements, treating the system as a black box.

## Folder structure

```
specs/
  charter/           Project constitution: tech stack, standards, principles.
                     Read this first — everything else must respect it.
  requirements/      One file per feature, in plain business language.
  design/
    architecture/    Cross-cutting design docs (auth, data storage, ...),
                     organized by topic.
    features/        Technical design for individual features.
  implementation/    Task breakdowns — the ordered steps to build each feature.
  qa/
    test-cases/      End-to-end test scenarios per feature.
    tasks/           Steps to implement those scenarios as automated tests.
    rtm.md           Requirement traceability matrix: which requirement is
                     covered by which test.
```

## The project charter

The `charter/` folder holds the project's **constitution**: the durable,
project-wide norms and constraints that apply across every feature — the
technology stack, coding standards and conventions, and architectural
principles. Unlike requirements and design,
the charter is not tied to a single feature; it is the fixed context that every
stage is expected to respect.

Why bother writing it down? Without it, an AI agent re-derives the project's
conventions from scratch each time it works — guessing the stack, the structure,
how tests are written — and guesses differently on different days, so the code
slowly drifts out of consistency. The charter states that context once, so it is
applied the same way every time. It is what lets separate sessions and different
agents produce code that reads as though one hand wrote it.

Developing and maintaining the charter is the **responsibility of the
development team**. It is not generated as part of a feature's workflow — the
team decides what belongs in it, keeps it current as the project's standards
evolve, and treats it as authoritative. When in doubt about a convention or a
technology choice, the charter is where the answer should live.

## How to read a feature

To understand a feature end to end, follow its trail across the folders: start
with its **requirements** (what and why), then its **design** (how), then its
**implementation** tasks (the steps), and finally its **QA** test cases (how we
know it works). Requirements carry stable IDs (e.g. `FR-014`) that the later
documents reference, so you can always trace a design decision or a test back to
the requirement it serves.
