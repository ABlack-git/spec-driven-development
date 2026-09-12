# Maintaining specs

Specs are living documents. When a feature or a design changes, update the specs
so they stay the source of truth — do not just change the code. This guide is
deliberately short; for the overall approach, see the main `SKILL.md`.

## Analyze the impact first

Before changing anything, work out what the change touches. Follow the IDs and
references — a requirement's `FR-xxx`, and the `satisfies`, `depends-on`, and
`related` frontmatter links — to find every artifact that depends on what you are
changing: other requirements, design docs, plans, QA, and code. Produce this
**impact set** before editing. This is exactly what the traceability links exist
for.

The frontmatter fields carry the same meaning in every artifact, so impact
analysis is mechanical:

| Field | Meaning | Points from → to |
| --- | --- | --- |
| `satisfies` | upstream IDs this artifact fulfills | design & implementation plans → `FR-xxx`; QA plans → `TC-xxx` |
| `depends-on` | existing artifacts this one relies on and reads | requirements → features; design → architecture docs; plans → design + architecture docs |
| `related` | soft "see also" links, no hard coupling | requirements → features |

To find what a change affects, look for artifacts whose `satisfies` or
`depends-on` names the thing you are changing.

## Start high, then flow down

Make the change at the **highest stage it affects**, then flow it downward
through the same stages: requirement → design → plan → code → QA. Do not patch a
lower artifact to match reality while leaving a higher one stale.

## Flow back up when needed

If, while designing or implementing, you discover that the requirement (or the
design) is itself wrong, do not fix it downstream. **Surface it, correct it
upstream first, then flow the change back down.**

## How each artifact changes

- **State artifacts** (requirements, design, architecture docs): edit in place,
  bump the version, and record the change and its *why* in the change log. Bump
  the version when the change affects the system — a concrete requirement changes,
  or a design change implies code changes. Editorial changes that do not change
  what gets built (fixing a `related` link, rewording a description, a typo) do
  not need a version bump.
- **Implementation plans**: do not modify an existing plan to absorb the change
  — **always create a new plan** for the work the change requires. Existing plans
  stay as the record of what was already planned and done.
- **QA**: update the affected test cases and the `rtm`.

## Cross-cutting changes

A change to an architecture doc or a global requirement can affect many
features. Surface the **full blast radius** — which features depend on it — and
treat it as a decision for a person, not a silent sweep across the codebase.

## The spec is the source of truth

When code and a spec disagree, or two specs disagree, **surface it to a person
and let them decide** what to reconcile. Do not silently pick one, and do not let
them drift apart.
