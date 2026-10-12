#!/usr/bin/env bash
# init_project.sh <project-dir> [width] [height] [fps] [duration_s]
# Scaffolds a HyperFrames project and the motion-pack folder layout.
set -euo pipefail
DIR="${1:?project dir}"; W="${2:-1920}"; H="${3:-1080}"; FPS="${4:-30}"; DUR="${5:-30}"
command -v node >/dev/null || { echo "node missing (need >= 22)"; exit 1; }
command -v ffmpeg >/dev/null || { echo "ffmpeg missing"; exit 1; }
if [ ! -d "$DIR" ]; then
  npx --yes hyperframes init "$DIR" --non-interactive || { echo "hyperframes init failed"; exit 1; }
fi
cd "$DIR"
mkdir -p scenes assets fonts audio out critique
# set format + duration in the scaffolded index.html
if [ -f index.html ]; then
  sed -i.bak -E "s/width=1920, height=1080/width=$W, height=$H/; s/width: 1920px;/width: ${W}px;/; s/height: 1080px;/height: ${H}px;/; s/data-width=\"1920\"/data-width=\"$W\"/; s/data-height=\"1080\"/data-height=\"$H\"/; s/data-duration=\"10\"/data-duration=\"$DUR\"/g" index.html && rm -f index.html.bak
fi
[ -f STATE.json ] || cat > STATE.json <<JSON
{ "project": "$(basename "$DIR")", "phase": "build",
  "gates": {"brief": true, "style": true, "storyboard": true, "build": false, "audio": false, "critique": false, "ship": false},
  "format": {"w": $W, "h": $H, "fps": $FPS, "duration_s": $DUR},
  "open_issues": [], "last_render": null, "scores": null }
JSON
[ -f scenes/_ds.css ] || cat > scenes/_ds.css <<'CSS'
/* design system — fill from STYLE.md */
:root{
  --bg:#0A0A0A; --surface:rgba(255,255,255,.06); --text:#F5F5F7; --muted:rgba(245,245,247,.6);
  --accent:#FF6B2C; --accent-2:#6C8CFF;
  --font-hero:'Space Grotesk', system-ui, sans-serif; --font-body:'Inter', system-ui, sans-serif; --font-mono:'JetBrains Mono', monospace;
  --hero:160px; --h2:72px; --body:48px; --label:28px;
  --safe:5%;
}
html,body{margin:0;background:var(--bg);color:var(--text);font-family:var(--font-body)}
.stage{position:relative;width:100%;height:100%;overflow:hidden;padding:var(--safe);box-sizing:border-box}
.hero{font:700 var(--hero)/1 var(--font-hero);letter-spacing:-.03em}
.h2{font:600 var(--h2)/1.1 var(--font-hero);letter-spacing:-.02em}
.body{font:500 var(--body)/1.3 var(--font-body)}
.label{font:500 var(--label)/1 var(--font-mono);text-transform:uppercase;letter-spacing:.12em;color:var(--muted)}
.panel{background:var(--surface);border:1px solid rgba(255,255,255,.12);border-radius:24px;backdrop-filter:blur(24px)}
CSS
echo "project ready: $DIR ($W x $H @ $FPS fps, $DUR s)"
echo "next: add assets/, write scenes/*.html, then: npx hyperframes lint"
