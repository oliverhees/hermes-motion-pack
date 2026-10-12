# Overlay recipes (HyperFrames scenes above the base cut)

Base video: `<video class="clip" data-start="0" data-duration="30" data-track-index="0" src="out/base.mp4" muted>` (exact attributes per the HyperFrames skill; use the catalog block for video if present).

## Kinetic title on downbeat
```js
tl.from('#t1 .w', { yPercent: 120, duration: .45, ease: 'back.out(1.5)', stagger: .05 }, 3.87)
  .to('#t1', { opacity: 0, scale: 1.08, duration: .25, ease: 'power2.in' }, 5.3);
```
## Glitch (CSS, deterministic)
Three stacked copies of the title with `clip-path: inset(y1 0 y2 0)` and `transform: translateX(±6px)`, colour-shifted (`mix-blend-mode: screen`, red/cyan), toggled by a keyframed `gsap.set` sequence over 6 frames. Never random per render — use a seeded pattern.
## Light leak
`<div class="leak">` with `radial-gradient(circle at 20% 30%, rgba(255,180,90,.6), transparent 60%)`, `mix-blend-mode: screen`, tweened `xPercent -30→40`, `opacity 0→.8→0` over 0.9 s on the flash beat.
## Letterbox
Two bars `height: 12%` top/bottom, present from frame 0 (never animate them in unless it's the cold open reveal).
## Grain
Pre-rendered 2 s grain loop (`ffmpeg -f lavfi -i "nullsrc=s=1920x1080:d=2,geq=random(1)*255:128:128"`), `mix-blend-mode: overlay`, opacity 0.06–0.1, loop by seek, not by `repeat: -1`.
## Data overlay (recap)
Counter from `mp-build/references/gsap-cookbook.md`, label in mono, pinned to a safe-area corner, enters during the build, exits before the drop.
## Lower-third / location tag
Mono label + thin line drawing on (`scaleX 0→1, transformOrigin left`), 0.4 s, exits with the cut.
## Progress bar (trailer "date reveal")
Thin line grows across the bottom during the finale, lands exactly on the date card.
