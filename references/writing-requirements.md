# Writing requirements

This guide covers **how to write good requirements** — stage 1 of spec-driven
development. For the overall approach, the `specs/` folder structure, and the
artifact lifecycle, see the main `SKILL.md`; this guide does not restate them.

Requirements live at `specs/requirements/<feature>.md` — **one file per
feature**, holding one or more numbered requirements. Start from
[../assets/requirements-template.md](../assets/requirements-template.md).

## What a requirement is for

A requirement captures **what the system must do and why**, in language any
person can understand. It is the source of truth the plan is built on. Write
requirements before planning, and get them right before moving on — a wrong
requirement caught here costs a sentence.

## The shape of a requirements file

Each feature is a single file at `specs/requirements/<feature>.md`, and that one
file holds **multiple requirements** — every distinct capability of the feature
is its own numbered requirement (`FR-001`, `FR-002`, …) within it. Keep all of a
feature's requirements together; do not split one feature across files, and do
not put unrelated features in the same file.

The file follows this outline:

```
---
frontmatter: feature, title, version, owner, depends-on, related
---
# <Feature Title>
## Overview                      – what the feature is, in a paragraph
## Context & rationale           – why it exists (business background)
## Scope                         – in scope / out of scope
## Requirements                  – the numbered requirements, one per capability
   ### FR-001 — <capability>     – intent + EARS statements
   ### FR-002 — <capability>
## Non-functional requirements   – feature-specific NFRs, as EARS
## Open questions                – unresolved items
## Change log                    – significant changes and why
```

The full fillable version is
[../assets/requirements-template.md](../assets/requirements-template.md).

## Principles

- **What, not how.** Describe observable behavior and intent. Never name
  databases, frameworks, endpoints, or algorithms — that is design. If you find
  yourself describing mechanism, stop.
- **Understandable by anyone.** A non-technical stakeholder should be able to
  read a requirement and confirm it is correct. Avoid jargon.
- **Testable.** Every requirement must be checkable against the running system —
  pass or fail. If you cannot imagine how you would verify it, it is too vague.
- **Traceable.** Each requirement gets a stable ID that later stages reference.

## Language and style

Write so there is exactly one possible reading:

- Be **precise, explicit, and unambiguous.** If a sentence could be read two
  ways, rewrite it until it cannot.
- Use **plain, direct language** — the simplest phrasing that is still accurate.
  Do not use words fancier or phrases more complicated than the meaning needs.
- **No idioms, metaphors, or figures of speech.** They invite misreading and do
  not translate.
- Avoid vague quantifiers ("fast", "some", "several", "as appropriate"). State
  the exact value or condition instead.

## Writing a single requirement: intent + EARS

Each requirement is a free-form **intent** line plus a set of **EARS**
statements. There is no separate "acceptance criteria" section — the EARS
statements *are* the acceptance criteria.

### Intent

A plain sentence stating the capability and its purpose — the human-readable
*why*. Free-form: a user-story phrasing ("As a … I want … so that …") is fine
but not required. Keep it business-facing.

### EARS statements

EARS (Easy Approach to Requirements Syntax) is a small set of sentence patterns
that keep requirements precise and testable. Pick the pattern that fits:

- **Ubiquitous** (always true): *The system shall `<response>`.*
- **Event-driven**: *When `<trigger>`, the system shall `<response>`.*
- **State-driven**: *While `<state>`, the system shall `<response>`.*
- **Unwanted behavior**: *If `<condition>`, then the system shall `<response>`.*
- **Optional feature**: *Where `<feature is included>`, the system shall `<response>`.*

Rules for writing them:

- Each statement describes **observable behavior**, never mechanism.
- Each statement is **pass/fail** — one verifiable fact.
- Put **one behavior per statement**; split compound statements.
- Cover the **happy path, the unwanted/error paths, and any timing or state
  rules**. One capability usually needs several EARS statements.

### Example

```
### FR-014 — Request a reset link
*Intent:* A user who forgot their password can request a reset link by email.

- When a user requests a reset for a registered email, the system shall send an
  email containing a reset link.
- When a user requests a reset for an unregistered email, the system shall
  return a response identical to the registered case.
- The system shall expire reset links after 15 minutes.
- If a user submits an expired reset link, then the system shall reject it and
  offer to resend.

*Rationale (optional):* Identical responses prevent attackers from discovering
which emails are registered.
```

Contrast — this leaks the *how* and does **not** belong in a requirement:

> When a user requests a reset, the system shall insert a row into the
> `reset_tokens` table. ← mechanism; this is a design decision.

## IDs

Give each requirement a stable ID — `FR-001`, `FR-002`, … for functional
requirements (`NFR-001`, … for non-functional ones). The plan, architecture, and
QA reference these IDs, so:

- Never renumber or reuse an ID.
- When a requirement is removed, **retire** its ID — do not recycle it for
  something else.

## Scope

State what is **in scope** and, just as importantly, what is **out of scope**.
The out-of-scope list is the single best defense against later stages inventing
work that was never asked for.

## Non-functional requirements

- **Feature-specific NFRs** (a performance, security, or accessibility rule that
  applies to *this* feature) go in the feature file, written as EARS statements
  under a "Non-functional requirements" heading.
- **Global NFRs** that apply project-wide live in a dedicated cross-cutting
  requirements file (e.g. `specs/requirements/non-functional.md`), not
  duplicated into every feature.

## Dependencies and relationships

Track these at the **feature level**, in the file's frontmatter:

- **`depends-on`** — features this one assumes or requires. A hard link; it
  matters for ordering and for impact analysis when something changes.
- **`related`** — see-also links with no hard coupling.

## Working with a person

Requirements are gathered *with* a person (often a product owner or business
analyst). Your job is to structure and sharpen their intent, not to invent it.

- **Interview, don't assume.** When intent, scope, or an edge case is unclear,
  ask. Do not fill gaps with guesses.
- **Capture unknowns** in an "Open questions" section rather than resolving them
  silently.
- Requirements are **committed and edited in place**: record significant changes
  and their *why* in the change log (see `SKILL.md` and
  `references/maintenance.md`).
- **Do one stage, then stop.** Once requirements are drafted, surface them for
  review and approval before moving to the plan. Do not race ahead.

## Common pitfalls

- Implementation detail leaking in — the most common failure.
- Vague, untestable statements ("should be fast" → "within 2 seconds under
  normal load").
- Bundling several behaviors into one EARS statement — split them.
- Writing a design decision and calling it a requirement.
- Omitting the out-of-scope list.
