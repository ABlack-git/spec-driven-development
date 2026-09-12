---
feature: feature-slug          # e.g. password-reset
title: Feature Title
version: 1
owner: product / BA
depends-on: []                   # feature slugs this one requires (hard link)
related: []                      # see-also feature slugs (soft link)
---

<!--
  Requirements for a single feature. One file per feature, at
  specs/requirements/<feature>.md. See references/writing-requirements.md for
  how to write these well. Fill in the sections and delete this comment.
-->
# Feature Title

## Overview

_One short paragraph, plain language: what this feature is._

## Context & rationale

_The business problem and background — why this feature exists, who needs it,
and the cost of not building it. Non-technical._

## Scope

**In scope:** _…_

**Out of scope:** _… (explicitly list what this feature does NOT cover)_

## Requirements

### FR-001 — <capability name>
*Intent:* _A plain-language sentence stating the capability and its purpose._

- When _`<trigger>`_, the system shall _`<observable response>`_.
- If _`<unwanted condition>`_, then the system shall _`<response>`_.
- The system shall _`<always-true rule, e.g. a limit or timing constraint>`_.

*Rationale (optional):* _Why a non-obvious requirement is the way it is._

### FR-002 — <capability name>
*Intent:* _…_

- When _`<trigger>`_, the system shall _`<response>`_.

## Non-functional requirements

_Feature-specific NFRs only, as EARS statements. Global NFRs live in the
cross-cutting requirements file, not here._

- NFR-001: The system shall _`<measurable quality, e.g. respond within 2s>`_.

## Open questions

- _Anything unresolved — capture it here instead of guessing._

## Change log

- <date> (v1): initial draft.
