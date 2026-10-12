# Shot prompting for video models

## Shot card → prompt
```
[camera move] [framing] of [subject] [doing one action], [setting], [light], [lens/look], [mood]. [style anchor]. No text, no logos.
```
Example: "Slow push-in medium shot of a runner's shoes hitting wet asphalt at dawn, city street, low golden backlight with long shadows, 35 mm anamorphic look with soft flares, determined mood. Muted teal-and-amber grade, filmic grain. No text, no logos."

## Camera vocabulary that works
push-in · pull-back · slow orbit · handheld follow · static locked-off · whip-pan (short) · top-down · low angle hero · rack focus · macro slide

## Light vocabulary
golden backlight · overcast soft · neon practicals · single hard key · window light · blue hour · volumetric haze

## Style anchors (match the preset from STYLE.md)
- cinematic-dark → "filmic grain, anamorphic flares, teal-amber, haze"
- clean-product → "studio softbox, seamless background, product macro, no grain"
- retro-print → "16 mm film, halation, warm cast, slight gate weave"
- neo-glass → "glass and chrome, reflections, cool rim light, shallow depth"

## Continuity
- Same reference frame for every clip of a world; same seed; same lens words.
- Change only ONE variable between consecutive shots (framing OR subject OR light).
- Shoot "coverage": for every key beat generate wide + close so the editor can cut on action.

## Known failure modes → fix
- Morphing hands/faces → remove hands/faces from framing
- Text/gibberish signs → add "no text, no signage"
- Jittery camera → "slow", "smooth", "steady"
- Style drift → re-attach the reference frame, shorten prompt
