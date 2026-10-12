#!/usr/bin/env bash
# mix.sh <voice|none> <music|none> <sfx|none> <out.wav> [mix_lufs=-14] [voice_lufs=-16] [duck_db=8]
# Normalises stems per role, ducks music under voice, two-pass loudnorm on the mix.
set -euo pipefail
V="${1:-none}"; M="${2:-none}"; S="${3:-none}"; OUT="${4:?out}"; MIX="${5:--14}"; VL="${6:--16}"; DUCK="${7:-8}"
TMP=$(mktemp -d); norm() { ffmpeg -v error -y -i "$1" -af "loudnorm=I=$2:TP=-1.5:LRA=11" -ar 48000 "$3"; }
IN=(); F=""; n=0
if [ "$V" != none ]; then norm "$V" "$VL" "$TMP/v.wav"; IN+=(-i "$TMP/v.wav"); n=$((n+1)); fi
if [ "$M" != none ]; then norm "$M" "$(( ${VL%.*} - 12 ))" "$TMP/m.wav"; IN+=(-i "$TMP/m.wav"); n=$((n+1)); fi
if [ "$S" != none ]; then norm "$S" "-20" "$TMP/s.wav"; IN+=(-i "$TMP/s.wav"); n=$((n+1)); fi
[ $n -gt 0 ] || { echo "no stems"; exit 1; }
# build filter graph
idx=0; labels=""
if [ "$V" != none ]; then F+="[${idx}:a]asplit=2[v][vsc];"; vi=$idx; idx=$((idx+1)); fi
if [ "$M" != none ]; then
  if [ "$V" != none ]; then F+="[${idx}:a][vsc]sidechaincompress=threshold=0.05:ratio=8:attack=50:release=400:makeup=1[m];"
  else F+="[${idx}:a]anull[m];"; fi; idx=$((idx+1)); fi
if [ "$S" != none ]; then F+="[${idx}:a]anull[s];"; idx=$((idx+1)); fi
[ "$V" != none ] && labels+="[v]"; [ "$M" != none ] && labels+="[m]"; [ "$S" != none ] && labels+="[s]"
F+="${labels}amix=inputs=$n:normalize=0:dropout_transition=0[mix]"
ffmpeg -v error -y "${IN[@]}" -filter_complex "$F" -map "[mix]" -ar 48000 "$TMP/pre.wav"
# two-pass loudnorm
J=$(ffmpeg -v info -i "$TMP/pre.wav" -af "loudnorm=I=$MIX:TP=-1:LRA=11:print_format=json" -f null - 2>&1 | sed -n '/^{/,/^}/p')
mi=$(echo "$J" | grep input_i | sed 's/[^-0-9.]//g'); mt=$(echo "$J" | grep input_tp | sed 's/[^-0-9.]//g')
ml=$(echo "$J" | grep input_lra | sed 's/[^-0-9.]//g'); mth=$(echo "$J" | grep input_thresh | sed 's/[^-0-9.]//g'); off=$(echo "$J" | grep target_offset | sed 's/[^-0-9.]//g')
ffmpeg -v error -y -i "$TMP/pre.wav" -af "loudnorm=I=$MIX:TP=-1:LRA=11:measured_I=$mi:measured_TP=$mt:measured_LRA=$ml:measured_thresh=$mth:offset=$off:linear=true" -ar 48000 "$OUT"
rm -rf "$TMP"; echo "mix written: $OUT (target $MIX LUFS)"; bash "$(dirname "$0")/loudness.sh" "$OUT"
