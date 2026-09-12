---
feature: <feature-slug>          # e.g. password-reset
title: <Feature Title> — Design
version: 1
owner: <engineer>
satisfies: []                    # requirement IDs this design covers, e.g. [FR-014, FR-015]
depends-on: []                   # architecture docs relied on, e.g. [architecture/auth.md]
---

<!--
  Technical design for a single feature, at specs/design/features/<feature>.md.
  See references/writing-design.md for how to write this. Use the sections that
  carry weight — a small feature may be a few paragraphs. Describe contracts
  (signatures, schemas, API shapes), not implementation code. Fill in and delete
  this comment.
-->

# <Feature Title> — Design

## Overview

_The approach in a few sentences: how this feature will be built._

## Requirements covered

_Account for every requirement in the feature — each FR ID and how this design
addresses it (or a note that it needs no design and why)._

- FR-001 — _how the design satisfies it_

## Architecture & charter dependencies

_The architecture docs and charter conventions this design relies on._

- `architecture/<topic>.md` — _what it provides / how this uses it_

## Component / module changes

_What is added or changed, and where it fits._

## Data model

_The data structure or schema deltas this feature introduces._

## Interfaces / API surface

_Endpoints, signatures, and contracts. Contracts, not implementation code._

## Flow / sequence

_The step-by-step behavior. A Mermaid diagram is welcome here._

## Validation & business rules

_Rules the feature enforces._

## Edge cases & error handling

_Failure and boundary conditions, and how they behave._

## Out of scope / non-goals

_What this design deliberately does not cover._

## Open questions

- _Anything unresolved — capture it instead of guessing._

## Change log

- <date> (v1): initial draft.
