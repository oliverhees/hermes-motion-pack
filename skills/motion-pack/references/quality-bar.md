# Quality bar — what "studio grade" means here

Score every finished video 1–10 on each line. Ship only when every line is ≥ 8.

## 1. Hook (first 2 s)
- Something moves within the first 10 frames. No empty stage, no slow fade-up.
- The first text or image states the problem or the promise. No logo first (logo belongs at the end, or as a 0.3 s sting).
- Reels: the hook text is on screen at 0.2 s and readable at phone size.

## 2. Readability at phone size
- Test at 360 px wide (`mp-critique` phone sheet). Min. 48 px font at 1080p for body copy, 96 px+ for hero words.
- Max 6 words on screen in 9:16. Max 12 words in 16:9.
- High contrast: text never sits on busy video or mid-tone gradients without a plate/backdrop.

## 3. Motion quality
- Springs with overshoot for entrances (`elastic`, `back.out(1.7)`, custom spring curves), `power3.inOut` or `expo.out` for moves. Never `linear`, never default `ease`.
- Enter and exit are choreographed: nothing pops in without a cause, nothing lingers after its job is done.
- Stagger lists (0.04–0.08 s), never animate ten items at once with the same timing.
- No dead frames: at no point for > 0.8 s is nothing changing (except a deliberate hold with a subtle idle: breathing scale, parallax drift, cursor blink).
- Timing anchored to the beat: cuts land on voice words or music beats.

## 4. Variety
- A new visual idea every 2–4 s: new layout, new scale, new camera distance, new element type (type → UI → shape → number).
- At least 3 scale levels per video (macro detail, normal, wide).
- Never the same transition twice in a row.

## 5. Composition
- One hero element per moment. Supporting elements are smaller, dimmer, later.
- Grid and margins: safe area 5 % (16:9) / 8 % top & bottom (9:16, because of UI overlays on TikTok/Reels).
- Depth: background, mid, foreground — use scale, blur, opacity, parallax.
- No centred-text-on-gradient unless the style doc explicitly asks for a typographic poster look — and then it needs typographic tension (size contrast, weight contrast, offset).

## 6. Brand & product accuracy
- Logo is the original asset (SVG/PNG from official sources), never redrawn.
- UI is rebuilt from real screenshots or captured with `npx hyperframes capture <url>`.
- Every feature, number, quote comes from a listed source. Unknown → `[unverified]`.

## 7. Sound
- Voice at the target loudness, music 10–14 LU below voice, SFX on hits (whoosh on big moves, tick on list items, low thud on reveals).
- Music ducks under voice automatically (sidechain or keyframed gain).
- First frame has sound; last frame fades out cleanly (no cut-off tails).

## 8. Loop & seam (for loops/stings only)
- Frame N must flow into frame 0. Check with the loop test in `mp-critique`.

## 9. Determinism
- Two renders of the same project are frame-identical. Random seeds are fixed. No `Date.now()`, no `Math.random()` without seed.

## Forbidden list (instant fail)
- Bullet-point slideshow look · centred headline fades · stock-photo mood · corner labels ("Step 1") · frame borders · blurry up-scaled text · overlapping text during swaps · elements sliding in linearly · a logo that just appears · gradient-only backgrounds with nothing else · Comic Sans energy (default system fonts without intent).
