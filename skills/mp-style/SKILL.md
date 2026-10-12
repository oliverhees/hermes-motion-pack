---
name: mp-style
description: Step 2 of motion-pack. Turns BRIEF.md into STYLE.md — a reference-driven design doc with palette, typography, motion language, sound character and a forbidden list. Offers 8 built-in style presets (clean-product, editorial-brutal, neo-glass, kinetic-type, hand-drawn, cinematic-dark, data-minimal, retro-print). Use when a video needs a look, the user says "Style", "Look", "Design", "wie soll es aussehen", or after mp-brief.
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, design, presets]
    category: motion
---

# mp-style — steal a reference, write the design doc

Most AI motion videos look the same because nobody gave the model a reference. Fix that first.

## Steps
1. Read `BRIEF.md`. If the user gave reference links, extract: colour mood, type style, pace, transitions, what makes it feel premium.
2. If no reference: show the preset table (`references/presets.md`) in 8 lines and let the user pick one, or recommend one with a reason. The product's own world is always allowed as a preset ("lives inside the product's UI, fonts and colours").
3. If a website is in the brief: pull real colours/fonts (CSS variables, logo SVG). `npx hyperframes capture <url>` is the fastest way to get real screens.
4. Write `STYLE.md`. Keep it under 60 lines. Concrete numbers, no adjectives without a value.
5. Present the doc in ≤ 8 lines. Gate. On OK → `mp-storyboard`.

## `STYLE.md` template
```md
# STYLE — <project>  (preset: clean-product)
Reference: <link or "product world">   What we steal: <3 things>
## Colours
bg #0B0B0F · surface #15151C · text #F5F5F7 · accent #FF6B2C · accent-2 #6C8CFF (roles, not just hex)
## Type
Hero: Space Grotesk 700, tight tracking -0.03em · Body: Inter 500 · Mono labels: JetBrains Mono (sources: Google Fonts, self-hosted in /fonts)
## Layout
Safe area 5 % · grid 12 col · hero element takes 60 % of frame · depth layers: bg / mid / fg
## Motion language
Entrances: back.out(1.6), 0.5 s · Moves: expo.out 0.7 s · Exits: power2.in 0.3 s · Camera: slow 3 % push-ins, 1 fast whip per video · Stagger 0.06 s
## Sound character
Voice: warm, mid-pace · Music: minimal electronic, 100 bpm · SFX: soft whoosh, glass tick, sub thud
## Forbidden
no gradient-only frames · no centred fade-ins · no stock photos · no more than 2 fonts · no drop shadows on text
```

## Presets
Read `references/presets.md` for the 8 presets with full values. Combine at most two. Always adapt colours to the brand.

## Files in this skill
- `references/presets.md`
