# Poster prompts (kie.ai · Nano Banana 2 · 4:3 · 2K)

Both release posters were generated with the two reference posters of
[datenschleuse](https://github.com/oliverhees/datenschleuse) and
[coolify-shield](https://github.com/oliverhees/coolify-shield) as style references
(`image_input`), accent colour **electric violet #8B5CF6** + cyan glow.

Prompt (EN poster; the DE poster is the same with German labels):

> Release poster / infographic for an open-source project, in exactly the same visual language as the two reference posters (dark anthracite background, clean editorial layout, rounded panels, thin connector lines, generous dark negative space). Accent colour ELECTRIC VIOLET (#8B5CF6) with a secondary electric cyan glow. Title "HERMES MOTION PACK", subtitle "Studio-grade motion graphics & cinematic highlight videos — built as code, critiqued by the agent itself". Centre: pipeline of 7 rounded nodes "Interview → Brief → Style → Storyboard → Build / Edit → Audio → Critique loop ≥ 8/10" ending in a glowing "Ship", with a loop arrow from Critique back to Build / Edit. Left panel "GRAPHICS TRACK" (Product spots, 9:16 Reels, Kinetic typography, Logo stings & loops, Data stories, UI showcases) with a phone frame. Right panel "HIGHLIGHT TRACK" (Your footage, AI clips, Pure code, Beat-synced cut, Speed ramps & grade, Trailers & recaps) with a filmstrip and beat markers. Bottom badges "HyperFrames · HTML + GSAP → MP4", "ffmpeg · ElevenLabs · kie.ai", "11 skills · 8 presets · 12 prompts", tiny cat silhouette + "open source · AGPL-3.0". No real brand logos, no watermark, landscape 4:3.

## Notes from the first run
- First EN render carried a red phone/key + "WIREGUARD-TUNNEL" over from the coolify-shield reference → fixed with an edit pass ("remove … fill with background", "insert node 'Audio'").
- The DE poster was made as an edit of the final EN poster ("translate only these labels"), which keeps the layout identical. Three list labels resisted two edit passes and were patched locally (PIL, DejaVu Sans Condensed on the panel background).
