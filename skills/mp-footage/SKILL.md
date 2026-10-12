---
name: mp-footage
description: Ingests the user's own footage (clips, gameplay, events, vlogs, screen recordings) for a highlight video — makes proxies, detects scene cuts, scores every second by motion, loudness and speech, transcribes, and writes SHOTLIST.json with the best candidate moments. Use when the user hands over video files/folders, says "aus meinem Material", "Footage", "beste Momente", "Highlights rausziehen", "schneid mir das zusammen", or before mp-highlight when real footage is the basis.
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [video, footage, ffmpeg, highlight]
    category: motion
---

# mp-footage — find the moments

Goal: turn hours of material into a ranked `SHOTLIST.json` the editor (`mp-highlight`) can cut from. Never watch everything frame by frame; let the scripts rank, then look only at the candidates.

## Steps
1. Inventory: `bash <skill-dir>/scripts/inventory.sh <folder>` → `footage/INVENTORY.json` (duration, fps, resolution, audio) and 720p proxies in `footage/proxy/` (edit on proxies, render from originals).
2. Scan: `python3 <skill-dir>/scripts/scan.py footage/proxy/<file>.mp4 --out footage/scan_<name>.json --intent action|emotion|recap` → scene cuts + per-second scores (motion, loudness, speech-likelihood) + top moments.
3. Transcribe if speech matters: `npx hyperframes transcribe <file>` (or whisper if installed) → `footage/<name>.words.json`. Quotes with timestamps become title candidates.
4. Candidates: merge scans into `SHOTLIST.json` (template below). Rank by the brief's intent (action → motion+loudness; emotion → speech+faces; recap → variety across time). Target 3× the material the final cut needs.
5. Look at candidates: `bash <skill-dir>/scripts/peek.sh <file> <t1> <t2> ...` → one 12-frame strip per candidate. Keep the ones that read instantly, drop the rest. Ask the user only when two candidates are equal.
6. Hand off to `mp-highlight` with `SHOTLIST.json`.

## `SHOTLIST.json`
```json
{ "source": "footage/", "intent": "action", "target_duration_s": 30,
  "shots": [
    { "id": "A01", "file": "gameplay_01.mp4", "in": 83.4, "out": 86.1, "score": 0.91,
      "why": "peak motion + crowd loudness", "tags": ["action","wide"], "quote": null, "crop_x": 0.5 },
    { "id": "A02", "file": "vlog_03.mp4", "in": 412.0, "out": 414.6, "score": 0.84,
      "why": "laugh + close-up", "tags": ["emotion","close"], "quote": "das war verrückt", "crop_x": 0.62 }
  ] }
```

## Rules
- Shots are 0.6–3.0 s for action, 2–5 s for emotion, never longer than 6 s in a highlight.
- Keep a 0.3 s handle on both sides for the editor.
- Variety: alternate wide/close, loud/quiet, fast/slow. Flag it in `tags`.
- Vertical delivery from horizontal footage → note the subject position per shot (`crop_x` 0–1) so the editor reframes instead of centre-cropping.
- Never upload the user's footage anywhere; everything stays local.

`references/scoring.md` explains the scores and how to tune thresholds per material type.

## Files in this skill
- `references/scoring.md`
- `scripts/inventory.sh`
- `scripts/peek.sh`
- `scripts/scan.py`
