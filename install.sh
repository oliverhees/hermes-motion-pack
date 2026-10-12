#!/usr/bin/env bash
# hermes-motion-pack installer — fallback for setups without the hermes CLI.
# Preferred: hermes skills tap add oliverhees/hermes-motion-pack && hermes skills install oliverhees/hermes-motion-pack/<skill>
# usage: bash install.sh            → copies all skills to ~/.hermes/skills/motion/
#        bash install.sh --check    → only check dependencies
#        bash install.sh --target <dir>  → copy skills to another agent's skill folder (Claude Code: .claude/skills, etc.)
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
TARGET="${HOME}/.hermes/skills/motion"
CHECK=0
while [ $# -gt 0 ]; do case "$1" in --check) CHECK=1;; --target) TARGET="$2"; shift;; esac; shift; done

ok(){ printf '  \033[32mOK\033[0m   %s\n' "$1"; }; warn(){ printf '  \033[33mWARN\033[0m %s\n' "$1"; }; fail(){ printf '  \033[31mFAIL\033[0m %s\n' "$1"; }
echo "Dependencies"
if command -v node >/dev/null; then v=$(node -v | sed 's/v//' | cut -d. -f1); [ "$v" -ge 22 ] && ok "node $(node -v)" || warn "node $(node -v) — HyperFrames needs >= 22"; else fail "node missing (>= 22): https://nodejs.org"; fi
command -v ffmpeg >/dev/null && ok "ffmpeg $(ffmpeg -version | head -1 | awk '{print $3}')" || fail "ffmpeg missing: apt install ffmpeg / brew install ffmpeg"
command -v python3 >/dev/null && ok "python3" || warn "python3 missing (needed for TTS, footage scan, beat grid)"
python3 -c "import numpy" 2>/dev/null && ok "numpy (beat detection)" || warn "numpy missing: pip install numpy (needed by mp-highlight/beats.py)"
command -v hermes >/dev/null && ok "hermes CLI" || warn "hermes CLI not on PATH (fine if you only use the Desktop App)"
[ -n "${ELEVENLABS_API_KEY:-}" ] && ok "ELEVENLABS_API_KEY set" || warn "ELEVENLABS_API_KEY not set (voice-over optional; enter it in Hermes: hermes setup)"
if npx --yes hyperframes --version >/dev/null 2>&1; then ok "hyperframes CLI reachable via npx"; else warn "hyperframes not yet cached — first 'npx hyperframes' call downloads it"; fi
[ $CHECK -eq 1 ] && exit 0

echo "Installing skills → $TARGET"
mkdir -p "$TARGET"
for s in "$HERE"/skills/*/; do n=$(basename "$s"); rm -rf "$TARGET/$n"; cp -r "$s" "$TARGET/$n"; ok "$n"; done
chmod +x "$TARGET"/*/scripts/* 2>/dev/null || true
mkdir -p "$HOME/motion-studio"; [ -f "$HOME/motion-studio/STUDIO.json" ] || echo '{ "root": "~/motion-studio", "language": "de", "default_format": "1920x1080@30", "last_preset": null }' > "$HOME/motion-studio/STUDIO.json"
echo
echo "Optional /motion shortcut: cp motion.bundle.yaml ~/.hermes/skill-bundles/motion.yaml"
echo
OPT="$HOME/.hermes/hermes-agent/optional-skills/creative/hyperframes"
HF="$HOME/.hermes/skills/creative/hyperframes"
if [ "$TARGET" = "${HOME}/.hermes/skills/motion" ] && [ -d "$OPT" ] && [ ! -d "$HF" ]; then
  # 'hermes skills install official/creative/hyperframes' reports "already installed" when only this optional copy exists
  mkdir -p "$(dirname "$HF")" && cp -r "$OPT" "$HF" && ok "official HyperFrames skill copied from Hermes optional-skills"
else
  echo "Also install the official HyperFrames skill (composition format):"
  echo "  hermes skills install official/creative/hyperframes"
  echo "  (says \"already installed\" but not in 'hermes skills list'? cp -r $OPT $HF)"
fi
echo
echo "Then start a new Hermes session (or /reset) and type:"
echo "  /motion-pack Mach mir einen 15-Sekunden-Reel für <Thema>"
