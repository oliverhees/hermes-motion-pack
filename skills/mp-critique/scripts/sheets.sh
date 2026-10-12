#!/usr/bin/env bash
# sheets.sh <video.mp4> <out-dir> [strip_time_s ...]
# contact sheet · phone sheet · hook sheet · optional strips · loop check
set -euo pipefail
V="${1:?video}"; D="${2:-critique}"; shift 2 || true; mkdir -p "$D"
ffmpeg -v error -y -i "$V" -vf "fps=2,scale=270:-1,tile=6x5" -frames:v 1 "$D/contact.png"
ffmpeg -v error -y -i "$V" -vf "fps=1,scale=360:-1,tile=5x3" -frames:v 1 "$D/phone.png"
ffmpeg -v error -y -t 2 -i "$V" -vf "fps=10,scale=320:-1,tile=10x2" -frames:v 1 "$D/hook.png"
for t in "$@"; do
  s=$(python3 -c "print(max(0,$t-0.1))")
  ffmpeg -v error -y -ss "$s" -i "$V" -vf "scale=320:-1,tile=12x1" -frames:v 1 "$D/strip_${t}.png"
done
ffmpeg -v error -y -stream_loop 1 -i "$V" -c copy "$D/loop_check.mp4"
# last frame vs first frame diff (for loops)
ffmpeg -v error -y -i "$V" -vf "select=eq(n\,0)" -frames:v 1 "$D/first.png"
ffmpeg -v error -y -sseof -0.05 -i "$V" -frames:v 1 "$D/last.png"
echo "sheets in $D: contact.png phone.png hook.png $(ls "$D" | grep -c strip_) strips, loop_check.mp4, first/last.png"
