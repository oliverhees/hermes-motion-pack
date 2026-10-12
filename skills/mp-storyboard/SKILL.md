---
name: mp-storyboard
description: Step 3 of motion-pack. Writes STORYBOARD.md — beats with timestamps, a state list per beat (what is on screen, where, what changes), voice lines, SFX hits and transitions — from BRIEF.md and STYLE.md. Use after mp-style, or when the user asks for "Storyboard", "Beats", "Ablauf", "Szenen", "timing".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, storyboard]
    category: motion
---

# mp-storyboard — story, beats, state list

A feature list is not a story. Structure: **Hook → tension → turn → payoff → proof → CTA.** For reels: **Hook → 3 beats → punch.**

## Steps
1. Read `BRIEF.md` + `STYLE.md`.
2. Write the voice/on-screen text first (if voice: ~2.4 words per second DE, ~2.6 EN; a 30 s spot ≈ 65–75 words). Read it aloud in your head: no filler, every sentence does one job.
3. Split into beats of 2–4 s. For each beat write the **state list**: which elements exist, their position/scale/opacity at beat start and beat end, and the one hero change. This is what makes the build deterministic — the builder animates between states, nothing more.
4. Mark SFX hits and the beat where music changes.
5. Reels: write the hook variants (3) and pick one.
6. Present ≤ 8 lines (beat list with durations). Gate. On OK → `mp-build`.

## `STORYBOARD.md` template
```md
# STORYBOARD — <project>   total 30.0 s @ 30 fps, 1920x1080
Voice (de): "..."  (72 words)

| # | t (s) | Beat / hero change | State: on screen (start → end) | Voice / text | SFX | Transition out |
|---|---|---|---|---|---|---|
| 1 | 0.0–2.5 | Hook word slams in | bg dark; "Unsichtbar." scale 0.6→1 overshoot; cursor idle | "Deine Idee? Unsichtbar." | sub thud @0.2 | hard cut |
| 2 | 2.5–6.0 | Canvas appears, first stroke draws | canvas 0.9→1; stroke dashoffset 100→0; hook word exits up | "Mit X wird sie..." | pencil @3.0 | mask wipe L→R |
| ... |
| 8 | 27.0–30.0 | End card | logo builds from parts; URL types on; CTA pill pops | "Jetzt testen." | hit @27.2 | fade to bg |

Hook variants: A "Deine Idee? Unsichtbar." · B "Niemand sieht deine Idee." · C "Im Kopf bleibt es Nebel."  → chosen: A
Music: minimal electronic 100 bpm, drop at beat 4, fade 28.5–30
```

## Rules
- Every beat has exactly one hero change. Secondary motion is allowed but subordinate.
- No beat longer than 4 s without a new idea. No beat shorter than 0.6 s except flashes.
- Word-sync: if voice exists, text appears on the spoken word, not before.
- Last beat ≥ 2.5 s (CTA must be readable). First beat starts moving at frame 1.
- For loops: last state == first state.

`references/story-patterns.md` has 6 narrative skeletons with timings.

## Files in this skill
- `references/story-patterns.md`
