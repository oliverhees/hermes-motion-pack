# Hand-off cards between skills

Each skill writes a file and ends with a hand-off card. The next skill starts by reading the previous file.

```
HAND-OFF → <next skill>
Done:      <one line>
File:      <path>
Open:      <max 3 bullets, or "none">
Needs OK:  <yes/no — if yes, stop and ask the user>
```

## Gate rules
- A gate is passed only when the user writes OK/weiter/passt/go or gives corrections that you then apply.
- If the user gives corrections, re-run only the affected part of the phase and re-present. Do not restart the whole chain.
- Keep gate messages short: the file summary in ≤ 8 lines, then the question.

## State file (`<project>/STATE.json`)
```json
{
  "project": "excalidraw-plus-spot",
  "phase": "build",
  "gates": {"brief": true, "style": true, "storyboard": true, "build": false, "audio": false, "critique": false, "ship": false},
  "format": {"w": 1920, "h": 1080, "fps": 30, "duration_s": 30},
  "preset": "clean-product",
  "open_issues": [],
  "last_render": null,
  "scores": null
}
```
Update after every phase. "Wo waren wir?" → read STATE.json, answer in 3 lines, offer the next step.

## Order of the chain
mp-brief → mp-style → mp-storyboard → mp-build → mp-audio → mp-critique → (loop back to mp-build while any score < 8) → mp-ship

## Shortcuts the user may ask for
- "Nur Storyboard" → brief → style → storyboard, then stop.
- "Ich hab schon ein Briefing" → read it, run a 1-question sanity check, continue with mp-style.
- "Stumm" → skip mp-audio, but still add a music bed suggestion to DELIVERY.md.
- "Schnell, Draft reicht" → build with `--quality draft`, one critique pass, ship as draft.
