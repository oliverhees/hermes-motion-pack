#!/usr/bin/env bash
# loudness.sh <file> [out.json] — integrated LUFS, LRA, true peak
set -euo pipefail
F="${1:?file}"; OUT="${2:-}"
R=$(ffmpeg -nostats -i "$F" -af ebur128=peak=true -f null - 2>&1 | tail -12)
I=$(echo "$R" | grep -m1 'I:' | awk '{print $2}'); LRA=$(echo "$R" | grep -m1 'LRA:' | awk '{print $2}'); TP=$(echo "$R" | grep -m1 'Peak:' | awk '{print $2}')
echo "integrated: $I LUFS · LRA: $LRA LU · true peak: $TP dBTP"
[ -n "$OUT" ] && printf '{"file":"%s","integrated_lufs":%s,"lra":%s,"true_peak_dbtp":%s}\n' "$F" "$I" "$LRA" "$TP" > "$OUT" || true
