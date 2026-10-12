#!/usr/bin/env bash
# sfx.sh <whoosh|tick|thud|riser> <out.wav> — simple synthesised SFX via ffmpeg (placeholders; replace with real libraries when available)
set -euo pipefail
T="${1:?type}"; O="${2:?out}"
case "$T" in
  whoosh) ffmpeg -v error -y -f lavfi -i "anoisesrc=d=0.6:c=pink:a=0.6" -af "afade=t=in:d=0.15,afade=t=out:st=0.25:d=0.35,lowpass=f=3000,highpass=f=200" "$O";;
  tick)   ffmpeg -v error -y -f lavfi -i "sine=f=1800:d=0.05" -af "afade=t=out:st=0.01:d=0.04,volume=0.5" "$O";;
  thud)   ffmpeg -v error -y -f lavfi -i "sine=f=55:d=0.5" -af "afade=t=out:st=0.05:d=0.45,volume=0.9" "$O";;
  riser)  ffmpeg -v error -y -f lavfi -i "anoisesrc=d=2:c=white:a=0.4" -af "afade=t=in:d=1.8,lowpass=f=800:m=f,highpass=f=100" "$O";;
  *) echo "unknown type"; exit 1;;
esac; echo "sfx: $O"
