---
name: mp-critique
description: Step 6 of motion-pack. Makes the agent look at its own render — contact sheet, phone-size sheet, 12-frame strips around fast moments, loop-seam check, determinism check — then scores 8 criteria 1–10 as a harsh motion director, lists the 3 biggest problems with timestamps, and loops back to mp-build until every score is ≥ 8. Use after any render, or when the user says "sieht mid aus", "check das Video", "Kritik", "QC", "warum wirkt das billig".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, qa, ffmpeg]
    category: motion
---

# mp-critique — be a harsh motion director, not a proud author

Iteration is the method, not a failure. Viral AI motion pieces took dozens of critique rounds.

## Steps
1. `bash <skill-dir>/scripts/sheets.sh out/draft.mp4 critique/` → `contact.png` (2 fps, 6 across), `phone.png` (360 px wide), `hook.png` (first 2 s at 10 fps), optional `strip_<t>.png` around fast moments (`sheets.sh video dir 4.2 9.8`), `loop_check.mp4`.
2. **Look at the images** (vision). If you cannot see images, say so and ask the user to open them; still run the numeric checks.
3. Score with `references/rubric.md` (hook · readability · motion · variety · composition · brand accuracy · sound sync · seam/determinism). Write `critique/round-N.md`.
4. List the 3 biggest problems with timestamps. Hunt specifically for the forbidden list: text overlapping during swaps · linear slides · corner labels / frame borders · centred-on-gradient shots · blurry scaled text · a dead beat with nothing happening · a stutter at the loop seam · a logo that merely appears.
5. If any score < 8 → hand off to `mp-build` with the fix list. Re-render only the affected seconds (single scene), then the full file. Repeat.
6. `bash <skill-dir>/scripts/determinism.sh` once before shipping (renders twice, compares hashes).
7. When all ≥ 8 → update `STATE.json` scores, hand off to `mp-ship`.

## Rules
- Never raise a score to avoid another round. If unsure, score 7.
- Max 6 rounds, then present the best version and the remaining issues honestly.
- Keep every round's sheet (`critique/round-N/`) so the user sees progress.

## Files in this skill
- `references/rubric.md`
- `scripts/determinism.sh`
- `scripts/sheets.sh`
