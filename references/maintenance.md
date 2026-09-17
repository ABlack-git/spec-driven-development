# Maintaining specs

The committed specs — requirements and QA — are living documents. When a feature
changes, update them so they stay the source of truth; do not just change the
code. This guide is deliberately short; for the overall approach, see the main
`SKILL.md`. (Architecture docs are standing context, not an SDD-maintained
artifact — see the note at the end.)

Tasks and QA task plans are **local and disposable** — they are not
maintained. When the work changes, regenerate the task; do not treat it as a
record to keep in sync.

## Analyze the impact first

Before changing anything, work out what the change touches. Follow the IDs and
references to find every committed artifact that depends on what you are
changing: other requirements, QA test cases, the RTM, and code. Produce this
**impact set** before editing. This is what the traceability links exist for.

The links to follow:

| From | Points to | Use it to find |
| --- | --- | --- |
| Requirement `FR-xxx` | referenced by QA test cases and the RTM | which tests cover a changed requirement |
| Requirement `depends-on` / `related` | other features | features coupled to the one you are changing |
| RTM row | requirement → test case(s) | stale test cases when a requirement changes |

## Start high, then flow down

Make the change at the **highest stage it affects**, then flow it downward:
requirement → code → QA. Do not patch a lower artifact to match reality while
leaving a higher one stale.

## Flow back up when needed

If, while planning or implementing, you discover that the requirement itself is
wrong, do not fix it downstream. **Surface it, correct it upstream first, then
flow the change back down.**

## How each artifact changes

- **Requirements** (committed): edit in place, and record the
  change and its *why* in the change log. Bump a requirement's version when the
  change affects what gets built. Editorial changes (a reworded description, a
  typo, a fixed link) need no version bump.
- **QA**: update the affected test cases and the `rtm` (both committed).
- **Tasks and QA task plans** (local, disposable): do not maintain them —
  regenerate them for the new work.

## Architecture docs are outside this flow

Architecture docs are standing context, not an SDD-maintained artifact, so they
are **not** part of the impact set above, and SDD does not track which docs a
requirement touches. Still, a **substantial** requirement change — one that
alters how the system works, not just what it does — can leave an architecture
doc stale. Flag that as a **soft** prompt to the engineer to revisit the docs
(and use the design-and-doc skill to update them). It is a reminder, not a
traceable link.

## The spec is the source of truth

When code and a committed spec disagree, or two committed specs disagree,
**surface it to a person and let them decide** what to reconcile. Do not silently
pick one, and do not let them drift apart.
