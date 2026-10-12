#!/usr/bin/env bash
# export_formats.sh <final.mp4> [out-dir] — poster, GIF preview, 5 s teaser, WebM
set -euo pipefail
V="${1:?final.mp4}"; D="${2:-out}"; mkdir -p "$D"
ffmpeg -v error -y -i "$V" -vf "select=gte(n\,15)" -frames:v 1 "$D/poster.png"
ffmpeg -v error -y -i "$V" -t 6 -vf "fps=15,scale=640:-1:flags=lanczos,split[a][b];[a]palettegen[p];[b][p]paletteuse" "$D/preview.gif"
ffmpeg -v error -y -i "$V" -t 5 -c:v libx264 -crf 20 -c:a aac "$D/teaser_5s.mp4"
ffmpeg -v error -y -i "$V" -c:v libvpx-vp9 -b:v 0 -crf 32 -c:a libopus "$D/final.webm" || echo "webm skipped (no vp9)"
ls -la "$D"
