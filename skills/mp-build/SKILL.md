---
name: mp-build
description: Step 4 of motion-pack. Builds the HyperFrames project from STORYBOARD.md and STYLE.md — one HTML scene per beat with GSAP choreography, deterministic timing, real assets, then lint → draft render. Use after mp-storyboard, or when the user says "bau das", "build", "render", "Szene ändern", "HyperFrames", "GSAP", "animiere".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [motion-graphics, hyperframes, gsap]
    category: motion
---

# mp-build — write scenes as code

Prerequisite: the official HyperFrames skill knows the composition format (`data-composition-id`, timelines, tracks). Install it once: `hermes skills install official/creative/hyperframes`, or run `npx hyperframes init` (it installs its skills into the project). **Read that skill for the file format; read this skill for how to make it look premium.** When unsure about an API detail, run `npx hyperframes docs` or read `https://hyperframes.heygen.com/llms.txt` — never invent attributes.

## Steps
1. `bash <skill-dir>/scripts/init_project.sh <project-dir> <w> <h> <fps> <duration>` → scaffolds via `npx hyperframes init --non-interactive`, adds `/scenes`, `/assets`, `/fonts`, `/audio`, `/out`.
2. Assets first: logo SVG, fonts (self-host; Google Fonts via `fonts/` folder), screenshots or `npx hyperframes capture <url>`. No external URLs at render time.
3. Build the shared design system: `scenes/_ds.css` from `STYLE.md` (CSS variables for colours, type scale, easings, safe area). Every scene imports it.
4. For each storyboard beat write **one scene** (HTML + a GSAP timeline). Use the state list literally: set start state → tween to end state → exit. See `references/motion-rules.md` and `references/gsap-cookbook.md`.
5. Compose scenes on the master timeline with the storyboard timestamps. Transitions from `references/transitions.md`.
6. `npx hyperframes lint` → fix every error. Then `npx hyperframes render --quality draft --output out/draft.mp4`.
7. Hand off to `mp-audio` (or straight to `mp-critique` if silent).

## Non-negotiables while writing scenes
- Time is a function: everything derives from the composition clock, nothing from `setTimeout`, `Date.now()` or unseeded `Math.random()`. Seed randomness with a fixed number.
- GSAP timelines are built once, paused, and seeked by the player. Never play on load.
- Text is real text (fonts loaded), never rasterised. `font-display: block`.
- One hero per scene. Supporting elements enter after the hero, smaller, dimmer.
- No default eases. Use the easings in `_ds.css` (`--ease-enter: back.out(1.6)` etc.).
- Exits are designed. Every element leaves before the next scene's hero enters, or the transition covers it.
- Safe areas from STYLE.md. 9:16: nothing important in the bottom 20 % (platform UI) or top 10 %.
- Idle motion in holds: breathing scale ±1 %, slow parallax, blinking cursor — never a frozen frame > 0.8 s.
- Keep each scene file < 250 lines. Shared components go to `scenes/_components.js`.

## Composition format (verified against `npx hyperframes init` scaffold)
- Root: `<div id="root" data-composition-id="main" data-start="0" data-duration="30" data-width="1920" data-height="1080">`. Set `html, body { width: 1920px; height: 1080px }` and the viewport meta to the same size.
- Clips (anything that appears for a time span): `class="clip" data-start="<s>" data-duration="<s>" data-track-index="<n>"`. Tracks on the same index must not overlap (lint catches it).
- Timelines: `const tl = gsap.timeline({ paused: true }); ... window.__timelines["main"] = tl; tl.seek(0);` — the renderer seeks, never plays.
- GSAP is loaded by the scaffold (`gsap@3.14.2` from jsDelivr); fonts, images, audio must be local files under `assets/` / `fonts/` / `audio/`.
- Scenes = one `.clip` wrapper per beat on track 0 (`data-start` = beat start, `data-duration` = beat length) with its own elements inside; animate them on the master timeline at absolute times. Keep each beat's markup in a clearly commented section (or in `scenes/sNN-*.html` fragments that `scripts/assemble.sh` concatenates into `index.html`). Nested `data-composition-id` blocks and catalog blocks: follow the installed HyperFrames skill.

## Scene section skeleton
```html
<!-- ===== s02 · 2.5–6.0 s · canvas appears, first stroke draws ===== -->
<div class="clip scene" id="s02" data-start="2.5" data-duration="3.5" data-track-index="0">
  <div class="canvas" id="cv"></div>
  <svg class="stroke" viewBox="0 0 800 400"><path id="p1" d="M..." /></svg>
</div>
```
```js
// in the master timeline, absolute times = beat start + offset
const len = document.getElementById('p1').getTotalLength();
gsap.set('#p1', { strokeDasharray: len, strokeDashoffset: len });
tl.fromTo('#cv', { scale: .9, opacity: 0 }, { scale: 1, opacity: 1, duration: .6, ease: 'expo.out' }, 2.5)
  .to('#p1', { strokeDashoffset: 0, duration: 1.1, ease: 'power2.inOut' }, 2.85)
  .to('#s02', { opacity: 0, y: -40, duration: .3, ease: 'power2.in' }, 5.7); // designed exit
```

## Render tips
- Draft: `--quality draft`. Critique: standard. Final: `--quality high --fps 30|60`.
- Stutter or crash → `--workers 1`. Fonts missing in render → self-host and preload.
- Re-render only the affected seconds while iterating (render a single scene composition), full render at the end.

## Files in this skill
- `references/gsap-cookbook.md`
- `references/motion-rules.md`
- `references/transitions.md`
- `scripts/assemble.sh`
- `scripts/init_project.sh`
