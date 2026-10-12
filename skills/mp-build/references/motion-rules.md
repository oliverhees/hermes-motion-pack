# Motion rules (the difference between "AI video" and studio work)

## Timing
- Entrances 0.4–0.7 s, moves 0.5–0.9 s, exits 0.25–0.4 s. Exits are faster than entrances.
- Stagger 0.04–0.08 s per item; never > 8 staggered items (group them).
- Anticipation: 2–3 frames of counter-motion before a big move (scale 1→0.97→1.1→1).
- Follow-through: big elements settle with a 2–4 % overshoot. Small ones don't.
- Hold a landed hero ≥ 0.8 s before the next hero enters.

## Easing map (never use "linear" or default)
| Purpose | GSAP ease |
|---|---|
| hero entrance | `back.out(1.6)` or `elastic.out(1, .6)` (playful) |
| UI panel entrance | `expo.out` |
| move / reposition | `power3.inOut` |
| exit | `power2.in` |
| counters | `expo.out` (long) |
| camera push | `power1.inOut` (very slow) |
| slam / impact | `power4.out` + 3-frame micro-shake |

## Scale & camera
- Three scale levels per video: macro (element fills 120 % of frame), normal, wide.
- Push-ins 3–8 % over 2–4 s on holds. One whip (fast move with motion blur) per 30 s max.
- Parallax: bg 0.3×, mid 0.6×, fg 1× of camera move.

## Typography in motion
- Reveal lines by mask (overflow hidden + translateY 110 % → 0), not by opacity alone.
- Letter stagger only for ≤ 12 characters. Word stagger for lines.
- Key word in accent colour or italic serif — exactly one per phrase.
- Swap text only after the old text has fully left (no overlap frames). Check with the strip test.

## Depth & material
- Shadows: 0 40px 80px rgba(0,0,0,.35) on floating panels, none on text.
- Blur as depth cue: background elements blur 6–12 px when the hero is in focus.
- Grain/vignette 4–8 % opacity for cinematic/retro presets only.

## UI showcases
- Rebuild UI with real spacing; use the product's font. Cursor moves with `power3.inOut` 0.5 s and a 2-frame click scale.
- Highlight an area by dimming everything else to 40 % and scaling the area 1.05.
- Type-on text at 12–18 chars/s with a blinking caret.

## Loops
- Last state == first state. Use a timeline that returns, or design the exit as the entrance reversed.
