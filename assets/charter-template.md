<!--
  Project Charter — the project's constitution: the durable, project-wide norms
  and constraints that hold across every feature. It is the fixed context every
  stage must respect, and it is the development team's responsibility to author
  and keep current.

  This can live as a single file, or you can split it into separate files under
  charter/ (e.g. tech-stack.md, coding-standards.md, ...) if it grows large. If
  you split it, this charter.md must remain the entry point and reference each
  sub-file, so nothing is orphaned and there is one place that points to all of
  it. Either way, the structure below is a starting template — reuse the
  sections that are useful and delete the rest. Keep it lean: only include
  things that are cross-cutting, durable, and would otherwise be guessed.
-->

# Project Charter

## Intro

_A short description of the project: what it is, who it's for, and the goals
this charter serves._

## Tech stack

_Languages and versions, frameworks, datastore, and the key libraries that are
decided. Not an exhaustive dependency list._

## Coding standards and conventions

_How code is written: naming, formatting, linting (prefer "we use `<linter>`
with the committed config" over re-listing rules), and error-handling
conventions._

## Architectural principles

_Default patterns and architectural decisions that apply across features (e.g.
layering, API conventions, how features are structured)._

## Repository structure

_How the repository is laid out — top-level directories and what belongs where._

## Testing approach

_The kinds of tests used, the frameworks, and the expectations (unit,
integration, end-to-end)._
