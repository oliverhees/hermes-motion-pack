---
name: mp-brief
description: Step 1 of motion-pack. Runs a short, tap-friendly interview (max 2 rounds × 3 questions) and writes BRIEF.md for a motion graphics video — goal, audience, hook, format, length, must-show, sources, audio wishes. Use whenever a video is requested and no BRIEF.md exists yet, or the user says "Briefing", "interview me", "was brauchst du von mir".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, interview, brief]
    category: motion
---

# mp-brief — interview, then brief

Goal: reach 98 % certainty with as few questions as possible, then write `BRIEF.md`.

## Rules
- Infer first, ask second. Read the request, the project folder, `~/motion-studio/STUDIO.json` and any pasted material before asking anything.
- Max 2 rounds. Round 1 = 3 questions. Round 2 only if something important is still open (max 3 more).
- Offer options (A/B/C) so the user can answer with one word. Always add "du entscheidest" as an option.
- Never ask what you can look up (website, docs, GitHub, screenshots).
- Speak the user's language.

## Round 1 (pick the 3 that matter most for this request)
1. **Type / track** — graphics: product spot · social reel · launch teaser · logo sting/loop · kinetic typography · data story · UI showcase — highlight: highlight reel from my footage · trailer/teaser · event recap/aftermovie; basis: my clips · AI clips · pure code · mix
2. **Format + length** — 16:9 1920×1080 · 9:16 1080×1920 · 1:1 1080×1080 · 4:5 1080×1350 · multi-format; 6 s / 15 s / 30 s / 60 s
3. **Core message** — one sentence the viewer should remember (ask for it, or propose 2 and let them pick)
4. **Audience + platform** — who sees it, where (YouTube, Reels/TikTok, LinkedIn, website hero, ads)
5. **Audio** — voice-over (which language, male/female/neutral) · music only · silent
6. **Sources** — website, docs, GitHub, screenshots, brand kit, existing assets (logo SVG!) — highlight track: footage folder/paths, music track (or mood + bpm), the "why" of the video (what should people feel after)

## Round 2 (only if needed)
- Hook (max 5 words) — propose 3, let them pick
- Call to action
- Hard constraints: brand colours, fonts, forbidden things, deadline
- Reference videos they like (links)

## Output: `BRIEF.md`
```md
# BRIEF — <project>
Type: ...            Format: 1080x1920 @ 30fps, 15 s
Platform: ...        Audience: ...
Core message: "..."
Hook (≤5 words): "..."     CTA: "..."
Must show (in order of importance): 1. ... 2. ... 3. ...
Proof points (with source): - "..." (url)
Audio: voice de/female · music: energetic-minimal · SFX: yes
Brand: colours #..., fonts ..., logo path ...
Forbidden: ...
References: ...
Assumptions I made: - ...
```

Then present the brief in ≤ 8 lines and ask for OK. On OK: write `STATE.json` (phase: style), hand off to `mp-style`.

See `references/interview-bank.md` for ready question sets per video type.

## Files in this skill
- `references/interview-bank.md`
