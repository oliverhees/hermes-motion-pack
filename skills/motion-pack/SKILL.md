---
name: motion-pack
description: Studio-grade motion graphics and cinematic highlight videos built as code with HyperFrames (HTML + GSAP → MP4) plus ffmpeg edits of real or AI footage. ALWAYS use for any video, spot, reel, teaser, trailer, intro, logo sting, kinetic typography, product film, social clip, highlight/recap/aftermovie/montage, "mach mir ein Video", "Motion Graphics", "Werbespot", "Reel", "Cinematic", "Animation" — even if the user does not say HyperFrames. Interviews the user first, then chains mp-brief → mp-style → mp-storyboard → (mp-footage | mp-genclip) → mp-build / mp-highlight → mp-audio → mp-critique → mp-ship with approval gates.
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, video, hyperframes, router]
    category: motion
---

# motion-pack — the router

**Rule zero:** the prompt is 10 % of the video, the harness is the other 90 %.
Never jump from a one-line request straight to code. Interview → brief → style → storyboard → build → audio → critique loop → ship. Every phase has a gate where the user says OK.

**Language:** talk to the user in the language they write (most of them write German). Write every file, comment and commit in English.

**Scope:** product spots, social reels (9:16), launch teasers, logo stings and loops, kinetic typography, data stories, UI showcases — and cinematic highlight videos, trailers and recaps from the user's footage, from AI-generated clips, or from pure code. No talking-head / avatar / explainer formats.

## Two tracks, one chain
| Track | When | Chain |
|---|---|---|
| **graphics** | everything is drawn (spots, reels, stings, data, UI) | brief → style → storyboard → **mp-build** → audio → critique → ship |
| **highlight** | shots exist or get generated (highlight reel, trailer, aftermovie, recap) | brief → style → storyboard → **mp-footage** (user clips) and/or **mp-genclip** (AI clips) → **mp-highlight** (beat-synced edit + overlays) → audio → critique → ship |
| highlight / code mode | cinematic look but no clips at all | treat as graphics track with the cinematic-dark preset |
Decide the track in `mp-brief` (question 1). Mixed is allowed: real footage + AI inserts + code titles.

## The chain (each step is its own skill = its own slash command)

| # | Skill | Produces | Gate |
|---|---|---|---|
| 1 | `mp-brief` | `BRIEF.md` after a short interview (max 2 rounds, 3 questions each) | user confirms brief |
| 2 | `mp-style` | `STYLE.md` — reference, palette, type, motion language, forbidden list | user picks preset or reference |
| 3 | `mp-storyboard` | `STORYBOARD.md` — beats, state list, timing, voice lines | user approves beats |
| 4a | `mp-footage` | (highlight track) proxies, scans, `SHOTLIST.json` of best moments | user confirms candidates |
| 4b | `mp-genclip` | (highlight track) AI clips per shot card, look-locked, registered in `SHOTLIST.json` | style frame OK, cost shown |
| 4c | `mp-build` | (graphics track) HyperFrames project: scenes as HTML + GSAP, `npx hyperframes lint` green | draft render |
| 4d | `mp-highlight` | (highlight track) `beats.json`, `EDIT.json`, base cut, overlays in HyperFrames | edit plan OK, draft render |
| 5 | `mp-audio` | voice (ElevenLabs via env key), music bed, SFX, loudness-normalised mix | listen check (user) |
| 6 | `mp-critique` | contact sheet, phone sheet, strip, loop seam; scores 1–10; fix list | all scores ≥ 8 |
| 7 | `mp-ship` | final renders in every format, `DELIVERY.md`, optional "save as skill" | done |

Run them in order. Skip only when the user explicitly says so ("no audio", "I already have a brief"). After each gate, say in one line which skill comes next and load it.

## How to start

1. Create the project folder: `<studio>/<slug>/` (default studio root `~/motion-studio`; ask once, remember in `~/motion-studio/STUDIO.json`).
2. Check dependencies: Node ≥ 22, ffmpeg, `npx hyperframes --version`. If the HyperFrames skill is not installed, tell the user: `hermes skills install official/creative/hyperframes` (or `npx hyperframes init` inside the project, which installs its skills automatically).
3. Load `mp-brief` and run the interview.

## Quality bar (binding for every phase — read `references/quality-bar.md` before building)

- One hero element per moment. Something new every 2–4 s.
- Springs and overshoot, never linear slides. No "fade everything in".
- No centred-text-on-gradient. No corner labels, no frame borders, no stock look.
- Text readable at 360 px wide. Max 6 words on screen at once in reels.
- Every claim about a product comes from a source; nothing invented.
- The agent looks at its own frames before it says "done".

## Memory

- `~/motion-studio/STUDIO.json` — studio root, default language, default format, last used preset.
- `<project>/STATE.json` — phase, gates passed, open issues. Update after every phase so "wo waren wir?" works.

## When things go wrong

- Render fails or stutters → `npx hyperframes render --workers 1`, then `npx hyperframes doctor`.
- Lint complains → fix before preview; never render around a lint error.
- No vision available → say so plainly; use `mp-critique` scripts and ask the user to look at the sheets.
- No web access → mark every product claim `[unverified]` and list them in `DELIVERY.md`.

See `references/chain.md` for the hand-off cards between skills and `references/quality-bar.md` for the full rubric.

## Files in this skill
- `references/chain.md`
- `references/quality-bar.md`
