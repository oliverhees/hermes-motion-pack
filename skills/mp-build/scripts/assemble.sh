#!/usr/bin/env bash
# assemble.sh [project-dir] — concatenates scenes/sNN-*.html fragments into index.html between <!-- SCENES --> markers
# Each fragment holds one .clip scene wrapper (markup only); timeline code lives in scenes/timeline.js, inlined between <!-- TIMELINE --> markers.
set -euo pipefail
cd "${1:-.}"
grep -q '<!-- SCENES -->' index.html || { echo "index.html needs <!-- SCENES --> ... <!-- /SCENES --> and <!-- TIMELINE --> ... <!-- /TIMELINE --> markers"; exit 1; }
python3 - <<'PY'
import re,glob
idx=open('index.html').read()
scenes='\n'.join(open(f).read() for f in sorted(glob.glob('scenes/s[0-9]*.html')))
tl=open('scenes/timeline.js').read() if glob.glob('scenes/timeline.js') else ''
idx=re.sub(r'<!-- SCENES -->.*?<!-- /SCENES -->', '<!-- SCENES -->\n'+scenes+'\n<!-- /SCENES -->', idx, flags=re.S)
if tl: idx=re.sub(r'<!-- TIMELINE -->.*?<!-- /TIMELINE -->', '<!-- TIMELINE -->\n'+tl+'\n<!-- /TIMELINE -->', idx, flags=re.S)
open('index.html','w').write(idx); print('assembled', len(glob.glob('scenes/s[0-9]*.html')), 'scenes')
PY
