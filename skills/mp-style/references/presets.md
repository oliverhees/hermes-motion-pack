# Style presets (pick one, adapt to brand)

| id | Feels like | Use for |
|---|---|---|
| clean-product | Apple/Linear/Vercel launch films | SaaS spots, feature tours |
| editorial-brutal | big type, raw grid, black/white + one colour | opinionated reels, manifestos |
| neo-glass | frosted panels, soft glow, depth | fintech, AI tools, dashboards |
| kinetic-type | words as the only actor, rhythm-driven | hooks, quotes, lyrics, reels |
| hand-drawn | rough.js strokes, paper, wobble | whiteboard tools, friendly brands |
| cinematic-dark | fog, light leaks, slow camera, serif | teasers, "coming soon", premium |
| data-minimal | numbers as heroes, thin lines, one accent | reports, metrics, data stories |
| retro-print | risograph grain, offset colours, bold shapes | playful brands, events |

## clean-product
- bg #FFFFFF or #0A0A0A · surface rgba(255,255,255,.06) · text #111 / #F5F5F5 · accent = brand colour
- Type: Inter / Geist / SF-style grotesk; hero 700, -0.03em; body 500
- Motion: 0.5 s entrances with back.out(1.4); UI elements scale from 0.96→1 with expo.out; slow 4 % push-in on hero shots; one whip-pan per video
- Signature: real UI, rebuilt pixel-accurate; cursor with spring easing; soft 40 px blur shadow under floating panels
- Sound: minimal keys + sub, ticks on UI actions

## editorial-brutal
- bg #F2F0EA · text #0B0B0B · accent #FF3B1F (one only)
- Type: Space Grotesk 800 or Druk-like condensed, huge (hero 180–260 px at 1080p), uppercase; mono for small labels
- Motion: hard cuts on beat, words slam in with power4.out + 2 px overshoot shake, masks revealing lines, no fades; occasional 1-frame flash inverse
- Signature: text breaks the safe area on purpose (bleed), horizontal rules sliding, numbered sections as giant numerals
- Sound: drums, clicks, vinyl crackle

## neo-glass
- bg deep navy #070B1A with radial glow · panels rgba(255,255,255,.08) border 1 px rgba(255,255,255,.18), backdrop blur 24 px
- Type: Inter 600, soft tracking; numbers in tabular figures
- Motion: panels float (y ±6 px, 4 s sine idle), glow pulses with music; entrances scale 0.9→1 with expo.out 0.8 s
- Signature: light sweeps across glass (gradient mask moving), particles very subtle
- Sound: pads, airy whooshes

## kinetic-type
- bg #000 or #FFF · text opposite · accent one colour for the key word
- Type: two sizes only (hero + small); Space Grotesk / Bricolage / Instrument Serif italic for contrast words
- Motion: each word has its own entrance timed to the voice word or the beat: slide-up-mask, scale-pop, rotate-in, letter stagger 0.02 s; exits are as designed as entrances; camera zooms into the last word of a phrase
- Signature: scale contrast (one word at 300 px next to a line at 48 px), word count on screen ≤ 6
- Sound: voice forward, kicks on key words

## hand-drawn
- bg paper #FBF8F1 · ink #1E1E1E · accent marker #FFC857, #5B8DEF
- Type: Virgil / Excalifont / Kalam-like hand font for headlines, clean sans for small UI
- Motion: strokes draw on (stroke-dashoffset), wobble 2 frames (rough.js re-roll), elements "pop" with slight rotation; paper texture overlay 6 %
- Signature: arrows that draw themselves, sticky notes, hand-drawn frames around real UI
- Sound: pencil scratches, paper, soft marimba

## cinematic-dark
- bg #050507 · haze gradients · accent warm #E8B86D or cold #7FB3FF
- Type: Instrument Serif / Playfair italic for mood lines, grotesk caps with +0.2em tracking for labels
- Motion: slow 8 % push-ins over 4 s, parallax layers, light leaks (additive gradients moving), text fades up from 20 px with blur 8→0 px, 1.2 s; very few cuts
- Signature: one reveal moment with a flash-through-white or light sweep; grain 8 %
- Sound: drones, risers, one big hit

## data-minimal
- bg #FFFFFF · ink #111 · lines #DDD · accent one brand colour
- Type: Inter/IBM Plex Sans, tabular numbers, labels in mono 24 px
- Motion: counters tween with expo.out over 1.2 s; bars grow with back.out(1.1); lines draw with stroke-dashoffset; only one chart on screen; the takeaway sentence appears after the number lands
- Signature: the number is the hero (200 px+), the chart supports it; comparison via two bars morphing
- Sound: ticks on count, soft pads

## retro-print
- bg #F6E8D3 · ink #1A2A4A · risograph colours #FF5F5F, #3B7DD8, #FFC94A; grain and misregistration 2 px
- Type: Cooper-like rounded serif + bold grotesk; outlines and halftone fills
- Motion: squash & stretch, bouncy (elastic.out(1,0.5)), shapes rotate in, stickers slap on with a 3-frame overshoot
- Signature: halftone dot transitions, offset colour shadows, hand-cut shapes
- Sound: funky bass, pops, tape stop

## The product's own world (always available)
Use the product's real UI, font, colours and drawing style (e.g. Excalidraw → rough.js hand strokes). Logo and screens original. Everything else drawn in the product's style.
