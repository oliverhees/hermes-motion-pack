# GSAP cookbook — copy, adapt, keep deterministic

All snippets assume a paused master timeline that the player seeks. Register as the HyperFrames skill describes.

## Masked line reveal
```js
// <div class="line"><span>Your idea.</span></div>  .line{overflow:hidden}
tl.from('.line span', { yPercent: 110, duration: .55, ease: 'back.out(1.4)', stagger: .07 }, 0);
```
## Hero slam with micro-shake
```js
tl.from('#hero', { scale: 2.2, opacity: 0, duration: .35, ease: 'power4.out' }, 0)
  .to('#hero', { x: 3, duration: .03, yoyo: true, repeat: 3 }, .35);
```
## Counter
```js
const o = { v: 0 };
tl.to(o, { v: 1280, duration: 1.2, ease: 'expo.out', onUpdate: () => el.textContent = Math.round(o.v).toLocaleString('de-DE') }, 0);
```
## Draw-on stroke
```js
const len = p.getTotalLength(); gsap.set(p, { strokeDasharray: len, strokeDashoffset: len });
tl.to(p, { strokeDashoffset: 0, duration: 1, ease: 'power2.inOut' }, 0);
```
## Panel float idle (deterministic)
```js
tl.to('.panel', { y: -6, duration: 2, ease: 'sine.inOut', yoyo: true, repeat: 1 }, 0); // bounded, no infinite repeat
```
## Camera push-in on a stage wrapper
```js
tl.to('#cam', { scale: 1.06, duration: 3.5, ease: 'power1.inOut' }, 0);
```
## Light sweep over glass
```js
tl.fromTo('.sweep', { xPercent: -120 }, { xPercent: 120, duration: .9, ease: 'power2.inOut' }, 1.2);
```
## Staggered list with exit
```js
tl.from('.item', { y: 40, opacity: 0, duration: .5, ease: 'expo.out', stagger: .06 }, 0)
  .to('.item', { y: -30, opacity: 0, duration: .3, ease: 'power2.in', stagger: .04 }, '>1.2');
```
## Seeded random (never Math.random)
```js
function rng(seed){ return () => (seed = (seed * 16807) % 2147483647) / 2147483647; }
const r = rng(42);
```
## Word sync from a transcript
Given `words = [{w:'Deine', s:0.12, e:0.40}, ...]` (from `npx hyperframes transcribe` or ElevenLabs timestamps): place each word tween at `words[i].s`.
