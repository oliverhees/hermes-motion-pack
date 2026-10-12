#!/usr/bin/env bash
# Smoke tests for the pack's scripts on synthetic media. Needs ffmpeg, python3, numpy. No network, no API keys.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; S="$ROOT/skills"; T=$(mktemp -d); cd "$T"
echo "1/6 frontmatter"; for f in "$S"/*/SKILL.md; do python3 - "$f" <<'PY'
import sys,re; s=open(sys.argv[1]).read(); fm=s.split('---\n',2)[1]
assert re.search(r'^name: [a-z][a-z0-9-]*$',fm,re.M), sys.argv[1]; assert 'description:' in fm, sys.argv[1]
PY
done; echo "   ok: $(ls -d "$S"/*/ | wc -l) skills"
echo "2/6 audio mix + loudness"; ffmpeg -v error -y -f lavfi -i "sine=f=440:d=3" v.wav; ffmpeg -v error -y -f lavfi -i "sine=f=220:d=3" m.wav
bash "$S/mp-audio/scripts/sfx.sh" thud t.wav >/dev/null; bash "$S/mp-audio/scripts/mix.sh" v.wav m.wav t.wav mix.wav | grep -q "integrated: -1[34]" && echo "   ok: mix at target"
echo "3/6 critique sheets"; ffmpeg -v error -y -f lavfi -i "testsrc=duration=4:size=320x180:rate=25" -c:v libx264 -pix_fmt yuv420p t.mp4; bash "$S/mp-critique/scripts/sheets.sh" t.mp4 crit 1.5 >/dev/null; [ -f crit/contact.png ] && [ -f crit/phone.png ] && [ -f crit/strip_1.5.png ] && echo "   ok: sheets"
echo "4/6 footage scan"; mkdir ft; ffmpeg -v error -y -f lavfi -i "testsrc2=duration=12:size=320x180:rate=25" -f lavfi -i "sine=f=300:d=12" -af "volume='if(between(t,6,8),3,0.3)':eval=frame" -c:v libx264 -pix_fmt yuv420p -c:a aac ft/a.mp4
bash "$S/mp-footage/scripts/inventory.sh" ft >/dev/null; python3 "$S/mp-footage/scripts/scan.py" ft/proxy/a.mp4 --out scan.json --intent action >/dev/null
python3 -c "import json;d=json.load(open('scan.json'));t=max(d['top'],key=lambda x:x['total'])['t'];assert 5<=t<=8,t;print('   ok: loud peak found at',t,'s')"
echo "5/6 beats + edit"; ffmpeg -v error -y -f lavfi -i "sine=f=60:d=8" -af "volume='if(lt(mod(t,0.5),0.08),4,0.1)':eval=frame" music.mp3
python3 "$S/mp-highlight/scripts/beats.py" music.mp3 --out beats.json | grep -q "bpm" && echo "   ok: beat grid"
cat > edit.json <<JSON
{"music":"music.mp3","bpm":120,"format":{"w":180,"h":320,"fps":25},"grade":"teal-amber","grain":0.05,"letterbox":0.1,
 "shots":[{"src":"ft/a.mp4","in":1,"out":2,"at":0,"speed":0.5},{"src":"ft/a.mp4","in":6,"out":7,"at":2,"flash":true,"crop_x":0.8}]}
JSON
python3 "$S/mp-highlight/scripts/assemble_edit.py" edit.json --out base.mp4 --preview | grep -q "2 shots" && echo "   ok: base cut"
echo "6/6 export"; bash "$S/mp-ship/scripts/export_formats.sh" base.mp4 exp >/dev/null 2>&1; [ -f exp/poster.png ] && echo "   ok: export"
rm -rf "$T"; echo "ALL GREEN"
