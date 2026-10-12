---
name: mp-highlight
description: Cuts cinematic highlight videos, trailers/teasers and event recaps from real footage (mp-footage), AI clips (mp-genclip) or pure code — beat-synced edit plan, speed ramps, cinematic grade (teal-amber, bleach, film grain, letterbox), kinetic titles, glitch and light-leak overlays, data overlays, all composited in HyperFrames on top of an ffmpeg base cut. Use for "Highlight-Video", "Cinematic", "Trailer", "Recap", "Aftermovie", "Best-of", "Montage", "auf den Beat schneiden", "episch".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [video, highlight, trailer, ffmpeg, beat-sync]
    category: motion
---

# mp-highlight — the cinematic edit

Three modes, same pipeline:
| Mode | Base | Comes from |
|---|---|---|
| footage | user's clips | `mp-footage` → `SHOTLIST.json` |
| genclip | AI clips | `mp-genclip` → `SHOTLIST.json` |
| code | no clips, everything drawn | `mp-build` scenes with cinematic preset (haze, particles, light leaks, parallax type) |

## Steps
1. **Music first.** Pick/receive the track (tempo decides the cut). `python3 <skill-dir>/scripts/beats.py audio/music.mp3 --out audio/beats.json` → beat grid, downbeats, energy curve, the drop. No track yet → ask for mood + bpm, generate a click grid, swap later.
2. **Edit plan** → `EDIT.json`: shots from the shotlist placed on beats (`references/edit-grammar.md`). Arc: cold open (1–2 slow shots) → build (cuts every 2 beats) → drop (cuts every beat / half beat, speed ramps) → breath (one long shot) → finale (title/logo) . Show the plan as a table at the gate.
3. **Base cut:** `python3 <skill-dir>/scripts/assemble_edit.py EDIT.json --out out/base.mp4` → trims, speed ramps, reframe for 9:16 (`crop_x`), grade preset, grain, letterbox, hard cuts on beats. Render from originals, not proxies.
4. **Overlays in HyperFrames:** base.mp4 as the bottom video clip; titles, glitch, light leaks, counters and data overlays as scenes on tracks above (`references/overlays.md`). Titles land on downbeats. Follow `mp-build` rules for motion quality.
5. `mp-audio` for the final mix (music + SFX hits on cuts + optional voice). `mp-critique` with extra checks: cuts on beat (strip around the drop), no shot > 4 s in the build/drop, readability of titles at 360 px.
6. `mp-ship`.

## `EDIT.json`
```json
{ "music": "audio/music.mp3", "bpm": 124, "format": {"w":1080,"h":1920,"fps":30},
  "grade": "teal-amber", "grain": 0.08, "letterbox": 0, "transitions": "hard",
  "shots": [
    {"src":"footage/gameplay_01.mp4","in":83.4,"out":85.3,"at":0.0,"speed":0.6,"crop_x":0.5,"note":"cold open, slow"},
    {"src":"footage/vlog_03.mp4","in":412.0,"out":412.97,"at":1.94,"speed":1.0,"crop_x":0.62,"note":"beat 2"},
    {"src":"genclips/S07_v2.mp4","in":1.0,"out":1.48,"at":2.90,"speed":1.0,"flash":true,"note":"drop, half-beat"}
  ] }
```
`at` = position on the timeline (seconds, from `beats.json`), `speed` < 1 = slow motion (needs ≥ 50 fps source or frame interpolation), `flash` = 2-frame white on the cut.

## Rules
- Every cut on a beat or half-beat. Exceptions only in the cold open and the breath.
- Speed ramp = one shot that goes 0.4 → 1.6 (or reverse) over its length, placed on a downbeat.
- Max 2 slow-motion shots per 30 s. Max 1 flash per 4 beats.
- Grade is global and subtle; it unifies mixed sources. Never grade titles.
- Title words ≤ 4 per card, on downbeats, exit before the next cut.
- Recap/data overlays: numbers count up on a build section, never during the drop.

## Files in this skill
- `references/edit-grammar.md`
- `references/overlays.md`
- `scripts/assemble_edit.py`
- `scripts/beats.py`
