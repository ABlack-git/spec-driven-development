# Writing design

This guide covers **how to write design** — stage 2 of spec-driven development,
where requirements (the *what*) become a technical plan (the *how*). For the
overall approach, folder structure, and artifact lifecycle, see the main
`SKILL.md`; this guide does not restate them.

Design must **conform to the charter** (tech stack, standards, conventions).

Design has **two kinds of document**, because architecture does not decompose
along feature lines:

- **Architecture docs** — cross-cutting, living descriptions of the system,
  organized by topic, in `specs/design/architecture/` (e.g. `auth.md`,
  `data-storage.md`).
- **Feature design docs** — the concrete *how* for one feature, in
  `specs/design/features/<feature>.md`.

## Language and style

Write so the design has exactly one possible reading:

- Be **precise, explicit, and unambiguous.** If a sentence could be read two
  ways, rewrite it until it cannot.
- Use **plain, direct language** — the simplest phrasing that is still accurate.
  Do not use words fancier or phrases more complicated than the meaning needs.
- **No idioms, metaphors, or figures of speech.**
- Avoid vague quantifiers ("fast", "some", "as appropriate"). State the exact
  value or condition instead.

## Who decides

**The engineer drives architecture and makes the decisions; you assist.** Do not
invent or unilaterally settle architectural direction. Propose options, lay out
trade-offs, and surface the decision to the engineer — then record what they
decide. The same holds for significant feature-level design choices: your role
is to draft, sharpen, and flag, not to decide on the engineer's behalf.

## Architecture docs

There is **no template** for architecture docs — the engineer owns their
content and structure. What matters is a single bar:

> The architecture must be described in **enough detail that an agent can
> understand it fully and build on it correctly**, without guessing.

In practice that means covering, for each topic: what the concern is responsible
for, its key components and how they interact, the decisions and constraints
that apply, and the conventions a feature must follow. Include a short
*rationale* where a decision is non-obvious; capture rejected alternatives only
when the choice was genuinely contested.

Architecture docs are **state artifacts**: describe the current architecture,
edit in place as it evolves, and record significant changes and their *why* in a
change log (they are living docs, not a dated decision log).

### Feature-local vs cross-cutting: the promotion rule

While designing a feature, watch for decisions that reach beyond it. **If a
decision would be reused or contradicted by another feature, it is not
feature-local — it belongs in an architecture doc.** When you hit one, surface it
to the engineer and, once decided, record it in (or as) the relevant
architecture doc; the feature design then just references it.

## Feature design docs

Use [../assets/feature-design-template.md](../assets/feature-design-template.md).
Write it **proportionally** — use the sections that carry weight; a small feature
may be a few paragraphs, a complex one may use every section.

Key disciplines:

- **Cover every requirement.** List the feature's requirement IDs under
  "Requirements covered" and how the design satisfies each — or note explicitly
  that one needs no design and why. This is what makes traceability real: anyone
  can check that no requirement was dropped.
- **Reference, don't restate.** Point to requirement IDs and architecture docs
  rather than copying their content. The design says how; the requirement still
  owns the what, the architecture still owns the cross-cutting how.
- **Contracts, not code.** Design may specify interface signatures, API shapes,
  and data schemas — those are decisions. It stops before implementation code;
  writing the code is the implementation stage, and sequencing the work is the
  tasks stage.
- **Diagrams welcome.** Prefer Mermaid for sequence and component diagrams so
  they live in the markdown and diff in git.

## Working with the engineer

- Design is produced *with* the engineer. Draft and propose; let them decide.
- Capture unresolved items in "Open questions" rather than guessing.
- Design is a **state artifact**: edit in place, and record significant changes
  and their *why* in the change log (see `SKILL.md` and
  `references/maintenance.md`).
- **Do one stage, then stop.** Once the design is drafted, surface it for review
  and approval before moving to tasks. Do not race ahead into implementation.

## Common pitfalls

- Making architectural decisions yourself instead of surfacing them.
- Smuggling scope in — designing behavior no requirement asked for.
- Restating requirements or architecture instead of referencing them.
- Dropping to implementation code when a contract would do.
- Burying a cross-cutting decision inside one feature's design.
