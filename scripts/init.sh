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
CHARTER_TEMPLATE="$SKILL_DIR/assets/charter-template.md"
SPECS_README="$SKILL_DIR/assets/specs-readme.md"
RTM_TEMPLATE="$SKILL_DIR/assets/qa-rtm-template.md"

TARGET="${1:-$PWD}"
SPECS="$TARGET/specs"

echo "Scaffolding specs/ under: $TARGET"

# Folders that make up the spec structure. Empty ones get a .gitkeep so they
# survive in version control.
DIRS=(
  "charter"
  "requirements"
  "design/architecture"
  "design/features"
  "implementation"
  "qa/test-cases"
  "qa/tasks"
)

for dir in "${DIRS[@]}"; do
  mkdir -p "$SPECS/$dir"
  # Keep the (otherwise empty) directory tracked by git.
  if [ -z "$(ls -A "$SPECS/$dir")" ]; then
    touch "$SPECS/$dir/.gitkeep"
  fi
done

# Seed the charter from the template, without clobbering an existing one.
CHARTER_DEST="$SPECS/charter/charter.md"
if [ -e "$CHARTER_DEST" ]; then
  echo "  charter already exists, leaving it as-is: $CHARTER_DEST"
else
  cp "$CHARTER_TEMPLATE" "$CHARTER_DEST"
  # The seeded charter file replaces the placeholder keep-file.
  rm -f "$SPECS/charter/.gitkeep"
  echo "  seeded charter: $CHARTER_DEST"
fi

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
echo "  Record the methodology in AGENTS.md so future sessions pick it up. Add a"
echo "  short section stating the project follows spec-driven development, that"
echo "  specs/ is the source of truth, and that agents should consult the skill"
echo "  before writing requirements, design, or code. APPEND to the existing"
echo "  AGENTS.md if there is one — do not overwrite its content; create it only"
echo "  if it does not exist."
