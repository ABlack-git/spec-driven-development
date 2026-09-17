#!/usr/bin/env bash
#
# init.sh — scaffold the spec-driven-development `specs/` structure in a project.
#
# Usage:
#   scripts/init.sh [target-dir]
#
# target-dir defaults to the current working directory. Safe to re-run: existing
# files and folders are left untouched.

set -euo pipefail

# Resolve where this script (and therefore the skill's assets) live, so it works
# regardless of the directory it is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SPECS_README="$SKILL_DIR/assets/specs-readme.md"
RTM_TEMPLATE="$SKILL_DIR/assets/qa-rtm-template.md"

TARGET="${1:-$PWD}"
SPECS="$TARGET/specs"

echo "Scaffolding specs/ under: $TARGET"

# Committed folders. Empty ones get a .gitkeep so they survive in version control.
COMMITTED_DIRS=(
  "requirements"
  "qa/test-cases"
)

# Local, disposable folders. These are git-ignored, so no .gitkeep — they just
# need to exist locally.
LOCAL_DIRS=(
  "tasks"
  "qa/tasks"
)

for dir in "${COMMITTED_DIRS[@]}"; do
  mkdir -p "$SPECS/$dir"
  # Keep the (otherwise empty) directory tracked by git.
  if [ -z "$(ls -A "$SPECS/$dir")" ]; then
    touch "$SPECS/$dir/.gitkeep"
  fi
done

for dir in "${LOCAL_DIRS[@]}"; do
  mkdir -p "$SPECS/$dir"
done

# Git-ignore the local task folders so they are never committed.
GITIGNORE="$TARGET/.gitignore"
for entry in "specs/tasks/" "specs/qa/tasks/"; do
  if [ -f "$GITIGNORE" ] && grep -qxF "$entry" "$GITIGNORE"; then
    echo "  .gitignore already lists $entry"
  else
    printf '%s\n' "$entry" >> "$GITIGNORE"
    echo "  added to .gitignore: $entry"
  fi
done

# Seed the human-facing README at the root of specs/, without clobbering.
README_DEST="$SPECS/README.md"
if [ -e "$README_DEST" ]; then
  echo "  README already exists, leaving it as-is: $README_DEST"
else
  cp "$SPECS_README" "$README_DEST"
  echo "  seeded README: $README_DEST"
fi

# Seed the project-wide requirements traceability matrix, without clobbering.
RTM_DEST="$SPECS/qa/rtm.md"
if [ -e "$RTM_DEST" ]; then
  echo "  RTM already exists, leaving it as-is: $RTM_DEST"
else
  cp "$RTM_TEMPLATE" "$RTM_DEST"
  echo "  seeded RTM: $RTM_DEST"
fi

echo "Done."
echo
echo "Next step — this is for the agent, not this script:"
echo "  Record the methodology and conventions in AGENTS.md so future sessions"
echo "  pick them up. Add a section stating the project follows spec-driven"
echo "  development, that the committed specs/ are the source of truth, and that"
echo "  agents should consult the skill before writing requirements, planning, or"
echo "  code. AGENTS.md is also where the project's conventions live (tech stack,"
echo "  coding standards, repo layout, testing approach). APPEND to the existing"
echo "  AGENTS.md if there is one — do not overwrite it; create it only if absent."
