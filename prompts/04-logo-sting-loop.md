# Logo sting, 4 s, loopable

```
/motion-pack Build a 4-second loopable logo sting for [BRAND] from the SVG at [path]. Preset: [clean-product | retro-print]. Background [#HEX].
0–0.3 anticipation (tiny scale-down) · 0.3–1.2 the logo's parts fly in with springs (back.out(1.6), stagger 0.06) · 1.2–2.0 settle + light sweep · 2.0–3.5 hold with breathing idle ±1 % · 3.5–4.0 return to the exact first state so it loops.
Deterministic: seeded random only; render twice and compare hashes. Loop test: last frame == first frame.
Sound: whoosh on the fly-in, soft hit at 1.2 s, nothing in the loop return. -18 LUFS.
Deliver mp4 (black bg) + transparent WebM. Critique with strips around 0.3–1.2 s.
```
