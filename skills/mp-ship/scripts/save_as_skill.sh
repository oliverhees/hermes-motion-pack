#!/usr/bin/env bash
# save_as_skill.sh <project-dir> <skill-name> — package this project's style + system as a reusable Hermes skill
set -euo pipefail
P="${1:?project}"; N="${2:?skill-name}"; S="$HOME/.hermes/skills/$N"; mkdir -p "$S/assets"
cp "$P/STYLE.md" "$S/assets/STYLE.md"; cp "$P/scenes/_ds.css" "$S/assets/_ds.css" 2>/dev/null || true
cp "$P/scenes/_components.js" "$S/assets/_components.js" 2>/dev/null || true
cat > "$S/SKILL.md" <<MD
---
name: $N
description: Reusable motion graphics pipeline derived from the project "$(basename "$P")" — same style, design system and components. Use when the user wants another video in this look ("noch eins wie $(basename "$P")", "gleicher Style", "$N").
---
# $N
1. Load \`motion-pack\`. Start at \`mp-brief\` but skip style: copy \`assets/STYLE.md\` and \`assets/_ds.css\` into the new project.
2. Reuse \`assets/_components.js\`. Keep the motion language identical; only content changes.
3. Continue with mp-storyboard → mp-build → mp-audio → mp-critique → mp-ship.
MD
echo "saved skill: $S"
