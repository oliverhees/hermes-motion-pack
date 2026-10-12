#!/usr/bin/env bash
# inventory.sh <folder> [proxy_height=720] — INVENTORY.json + proxies
set -euo pipefail
F="${1:?folder}"; PH="${2:-720}"; mkdir -p "$F/proxy"; OUT="$F/INVENTORY.json"; echo "[" > "$OUT"; first=1
shopt -s nullglob nocaseglob
for v in "$F"/*.{mp4,mov,mkv,webm,m4v,avi}; do
  n=$(basename "$v"); b="${n%.*}"
  J=$(ffprobe -v error -show_entries format=duration:stream=codec_type,width,height,r_frame_rate -of json "$v")
  read dur w h fps aud < <(python3 -c "
import sys,json;from fractions import Fraction;d=json.loads(sys.argv[1]);s=[x for x in d['streams'] if x['codec_type']=='video'][0]
print(float(d['format']['duration']),s['width'],s['height'],round(float(Fraction(s['r_frame_rate'])),2),str(any(x['codec_type']=='audio' for x in d['streams'])).lower())" "$J")
  [ -f "$F/proxy/$b.mp4" ] || ffmpeg -v error -y -i "$v" -vf "scale=-2:$PH" -c:v libx264 -preset veryfast -crf 23 -c:a aac -ac 2 "$F/proxy/$b.mp4"
  [ $first -eq 1 ] || echo "," >> "$OUT"; first=0
  printf '{"file":"%s","proxy":"proxy/%s.mp4","duration":%s,"width":%s,"height":%s,"fps":%s,"audio":%s}' "$n" "$b" "$dur" "$w" "$h" "$fps" "$aud" >> "$OUT"
done; echo "]" >> "$OUT"; echo "inventory: $OUT ($(grep -c '"file"' "$OUT") files), proxies in $F/proxy/"
