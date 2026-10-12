# Workflow in one picture

```
you: /motion-pack <request>
 │
 ├─ mp-brief      3 tap-questions → BRIEF.md ─────────────── gate: OK?
 ├─ mp-style      preset/reference → STYLE.md ─────────────── gate: OK?
 ├─ mp-storyboard beats + state lists → STORYBOARD.md ─────── gate: OK?
 ├─ graphics track:  mp-build      scenes/*.html + GSAP → lint → draft.mp4
 ├─ highlight track: mp-footage (your clips) / mp-genclip (AI clips) → SHOTLIST.json
 │                   mp-highlight  beats.json → EDIT.json → base.mp4 → overlays in HyperFrames
 ├─ mp-audio      voice (env key) + music + SFX → mix.wav ─── you listen
 ├─ mp-critique   sheets → scores → fix list ─┐
 │                 ▲ all ≥ 8? no → mp-build ──┘
 └─ mp-ship       final renders + DELIVERY.md + optional "save as skill"
```

## Commands the agent runs
`npx hyperframes init <p> --non-interactive` · `npx hyperframes capture <url>` · `npx hyperframes lint` · `npx hyperframes preview` · `npx hyperframes render --quality draft|high --output <f>` · `npx hyperframes doctor`
Pack scripts: `mp-footage/scripts/{inventory.sh,scan.py,peek.sh}` · `mp-highlight/scripts/{beats.py,assemble_edit.py}` · `mp-build/scripts/init_project.sh` · `mp-audio/scripts/{tts_elevenlabs.py,mix.sh,loudness.sh,sfx.sh}` · `mp-critique/scripts/{sheets.sh,determinism.sh}` · `mp-ship/scripts/{export_formats.sh,save_as_skill.sh}`

## FAQ
- **"Wo waren wir?"** → the agent reads `STATE.json`.
- **Only a storyboard?** → say so; the chain stops after mp-storyboard.
- **No ElevenLabs key?** → music + SFX only, voice line is kept in STORYBOARD.md for later.
- **Render stutters** → `--workers 1`, then `npx hyperframes doctor`.
- **Other agents** → `bash install.sh --target <their skills dir>`; the prompts in `prompts/` work anywhere.
