#!/usr/bin/env bash
# determinism.sh [project-dir] — renders twice at draft quality and compares frame hashes
set -euo pipefail
cd "${1:-.}"; mkdir -p critique
npx hyperframes render --quality draft --output critique/det_a.mp4 >/dev/null
npx hyperframes render --quality draft --output critique/det_b.mp4 >/dev/null
A=$(ffmpeg -v error -i critique/det_a.mp4 -map 0:v -f framemd5 - | grep -v '^#' | md5sum | cut -c1-12)
B=$(ffmpeg -v error -i critique/det_b.mp4 -map 0:v -f framemd5 - | grep -v '^#' | md5sum | cut -c1-12)
if [ "$A" = "$B" ]; then echo "deterministic: yes ($A)"; else echo "deterministic: NO ($A vs $B) — hunt Math.random/Date.now/unseeded noise"; exit 1; fi
