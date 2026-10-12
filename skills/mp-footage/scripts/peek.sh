#!/usr/bin/env bash
# peek.sh <video> <t1> [t2 ...] — 12-frame strip per candidate moment → <dir>/peek/peek_<t>.png
set -euo pipefail
V="${1:?video}"; shift; D=$(dirname "$V")/peek; mkdir -p "$D"
for t in "$@"; do s=$(python3 -c "print(max(0,$t-1))"); ffmpeg -v error -y -ss "$s" -t 3 -i "$V" -vf "fps=4,scale=240:-1,tile=12x1" -frames:v 1 "$D/peek_${t}.png"; done
echo "strips in $D"
