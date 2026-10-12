#!/usr/bin/env python3
"""ElevenLabs TTS with word timestamps. Key from ELEVENLABS_API_KEY only.
usage: tts_elevenlabs.py --text-file voice.txt --voice-id ID [--model eleven_multilingual_v2] [--lang de] --out voice.mp3 [--timestamps words.json]
"""
import argparse, base64, json, os, sys, urllib.request

ap = argparse.ArgumentParser()
ap.add_argument('--text-file', required=True); ap.add_argument('--voice-id', required=True)
ap.add_argument('--model', default='eleven_multilingual_v2'); ap.add_argument('--lang', default=None)
ap.add_argument('--out', required=True); ap.add_argument('--timestamps', default=None)
ap.add_argument('--stability', type=float, default=0.45); ap.add_argument('--similarity', type=float, default=0.8)
a = ap.parse_args()

key = os.environ.get('ELEVENLABS_API_KEY')
if not key:
    for env in (os.path.join(os.environ.get('HERMES_HOME', '~/.hermes'), '.env'), '~/motion-studio/.env'):
        env = os.path.expanduser(env)
        if key or not os.path.exists(env):
            continue
        for line in open(env):
            if line.startswith('ELEVENLABS_API_KEY='):
                key = line.split('=', 1)[1].strip().strip('"')
if not key:
    sys.exit('ELEVENLABS_API_KEY not set (env, ~/.hermes/.env or ~/motion-studio/.env)')

text = open(a.text_file, encoding='utf-8').read().strip()
body = {'text': text, 'model_id': a.model,
        'voice_settings': {'stability': a.stability, 'similarity_boost': a.similarity}}
if a.lang: body['language_code'] = a.lang
endpoint = 'with-timestamps' if a.timestamps else ''
url = f'https://api.elevenlabs.io/v1/text-to-speech/{a.voice_id}/{endpoint}'.rstrip('/')
req = urllib.request.Request(url, data=json.dumps(body).encode(), method='POST',
      headers={'xi-api-key': key, 'Content-Type': 'application/json', 'Accept': 'audio/mpeg'})
with urllib.request.urlopen(req, timeout=120) as r:
    data = r.read()
if a.timestamps:
    j = json.loads(data)
    open(a.out, 'wb').write(base64.b64decode(j['audio_base64']))
    al = j.get('alignment') or {}
    chars, starts, ends = al.get('characters', []), al.get('character_start_times_seconds', []), al.get('character_end_times_seconds', [])
    words, cur, s0 = [], '', None
    for c, s, e in zip(chars, starts, ends):
        if c.isspace():
            if cur: words.append({'w': cur, 's': s0, 'e': e_prev}); cur, s0 = '', None
        else:
            if s0 is None: s0 = s
            cur += c; e_prev = e
    if cur: words.append({'w': cur, 's': s0, 'e': e_prev})
    json.dump(words, open(a.timestamps, 'w'), ensure_ascii=False, indent=1)
    print(f'wrote {a.out} and {a.timestamps} ({len(words)} words)')
else:
    open(a.out, 'wb').write(data); print(f'wrote {a.out}')
