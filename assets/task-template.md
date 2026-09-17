---
feature: <feature-slug>          # e.g. password-reset — which feature this task serves
task: <task-name>                # e.g. build-backend-api; human-readable name
delivers: []                     # IDs this task delivers: FR-xxx for a feature task,
                                 # TC-xxx for a QA task, e.g. [FR-014, FR-015]
---

<!--
  One task, at specs/tasks/<datetime>_<task_name>.md — flat, no per-feature folder;
  the prefix (YYYYMMDDTHHMM) is the creation time, e.g.
  20260916T1319_build_backend_api.md. A feature is split into a handful of these —
  each a coherent, engineer-sized slice (default: a vertical slice through the
  stack). See references/writing-tasks.md for how to write and split these. LOCAL
  and disposable — this folder is git-ignored; do not keep a change log.

  This is the engineer's high-level control surface: name the DECISIONS and the
  PARTS, one line each, close to the code but without the noise. No file-by-file
  steps, no finished code — those come from the detailed implementation plan
  (below), which the agent expands here in planning mode during implementation.
  Write proportionally; delete sections and this comment as needed.
-->

# <Feature Title> — <Task Title>

## Delivers

_Requirement IDs this task implements (`FR-xxx`). Together with the feature's
other tasks these should cover the feature; the RTM holds the authoritative
coverage record._

- FR-001, FR-002

## Decisions

_One line each. Add a short "why" only when non-obvious. Reference a sibling task
or an architecture doc for a **shared** decision rather than restating it._

- **Data model:** _e.g. `reset_tokens` (user_id, token_hash, expires_at) —
  stateful + hashed so links can be revoked on password change._
- **API:** _e.g. `POST /auth/reset-request {email}` → 200 identical response in
  all cases (FR-015)._
- **Structure:** _e.g. extend `AuthService`; email sent async via existing job
  queue._

## Parts

_The parts to build, named — not how each is built._

- **Backend:** _…_
- **Frontend:** _…_

## High-level steps

_Coherent, ordered chunks of work — not file-by-file. Check off as done._

- [ ] S1 — _<a unit of work>_ (FR-xxx)
- [ ] S2 — _<next>_

## Open questions

- _Anything unresolved — capture it instead of guessing._

---

<!--
  Filled during implementation (planning mode), one task at a time. Delete if
  unused.
-->

## Detailed implementation plan

_Expanded from the steps above during implementation: the concrete, file-level
plan the agent executes for this task. Grounded in the requirements and this
task._
