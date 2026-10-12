---
name: mp-ship
description: Step 7 of motion-pack. Final render in every requested format (16:9, 9:16, 1:1, 4:5, GIF/WebM), writes DELIVERY.md (files, specs, loudness, sources, unverified claims, next steps), optionally packages the finished pipeline as a reusable skill so the next video is one sentence. Use when critique is green, or the user says "export", "final", "liefern", "alle Formate", "fertig machen".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, export, ffmpeg]
    category: motion
---

# mp-ship — export, document, package

## Steps
1. Final render: `npx hyperframes render --quality high --fps <fps> --output out/final_<w>x<h>.mp4`. For more formats, derive compositions per format (reposition, don't just crop — hero element must stay hero) and render each. `scripts/export_formats.sh` makes the derived files (WebM transparent, GIF preview, poster frame, 5 s teaser cut).
2. Verify: duration == storyboard, audio present, loudness in spec (`mp-audio/scripts/loudness.sh`), file sizes OK for the platform.
3. Write `DELIVERY.md` (template below). Include every `[unverified]` claim and the assumptions from BRIEF.md.
4. Offer to save the pipeline as a project skill: `scripts/save_as_skill.sh <project> <skill-name>` copies STYLE.md, the design system, components and a filled master prompt into `~/.hermes/skills/<skill-name>/` so "mach noch so eins für Produkt Y" becomes a one-liner.
5. Update `STATE.json` (phase: done). Close with three lines: ✅ done & checked · ⚠️ unverified · 👉 your next step.

## `DELIVERY.md` template
```md
# DELIVERY — <project>
Files: out/final_1920x1080.mp4 (30.0 s, 30 fps, 14.2 MB) · out/final_1080x1920.mp4 · out/poster.png · out/teaser_5s.mp4
Audio: mix -14.0 LUFS, TP -1.0 dBTP · voice <model/voice name> · music <file/licence> · SFX synthesised
Scores (last critique round): hook 9 · read 9 · motion 8 · variety 8 · comp 9 · brand 9 · sound 8 · seam 10
Sources used: <urls>
Unverified claims: none / - "..."
Assumptions: ...
How to change things: edit scenes/sXX-*.html → npx hyperframes lint → render
Next: ...
```

## Files in this skill
- `scripts/export_formats.sh`
- `scripts/save_as_skill.sh`
