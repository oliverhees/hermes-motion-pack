# Critique rubric (1–10 each, ship at ≥ 8 everywhere)

| # | Criterion | 10 looks like | Typical 5 |
|---|---|---|---|
| 1 | Hook (0–2 s) | motion from frame 1, message readable by 0.5 s, you want to keep watching | empty stage, logo first, slow fade |
| 2 | Readability @360 px | every text legible on the phone sheet, ≤ 6 words at once (reels) | small body text, text on busy bg |
| 3 | Motion quality | springs, anticipation, settle; exits designed; no dead frames | linear slides, everything fades, elements pop |
| 4 | Variety | new idea every 2–4 s, 3 scale levels, no repeated transition | same layout, same move, same size |
| 5 | Composition | one hero per moment, clean hierarchy, depth, safe areas respected | centred-on-gradient, corner labels, clutter |
| 6 | Brand & accuracy | original logo, real UI, every claim sourced | redrawn logo, invented features |
| 7 | Sound sync | hits on moves, text on spoken word, music ducks, clean tail | random SFX, voice buried, hard cut |
| 8 | Seam & determinism | loop invisible, two renders identical, no flicker | stutter at seam, random differs |

## Round report template (`critique/round-N.md`)
```md
# Critique round N — out/draft.mp4
Scores: hook 7 · read 9 · motion 6 · variety 8 · comp 8 · brand 9 · sound 7 · seam 10
Top 3 problems:
1. 4.2 s — headline swaps while old word still 30 % visible (overlap, 6 frames)
2. 11.0–12.4 s — dead beat, nothing moves
3. 18.6 s — feature panel slides in linearly
Fix plan: s03 exit earlier by 0.2 s · add idle parallax to s05 · s07 panel ease expo.out
Re-render: s03, s05, s07 → full
```
