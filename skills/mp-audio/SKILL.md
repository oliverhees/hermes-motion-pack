---
name: mp-audio
description: Step 5 of motion-pack. Produces the audio layer — voice-over via ElevenLabs (API key only from the ELEVENLABS_API_KEY environment variable), music bed, SFX on hits, sidechain ducking and two-pass loudness normalisation (voice -16 LUFS, music 12 LU under, mix -14 LUFS, true peak -1 dBTP). Use after mp-build, or when the user mentions "Stimme", "Voice-over", "Musik", "Sound", "LUFS", "zu leise", "zu laut", "ElevenLabs".
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [audio, elevenlabs, loudness, ffmpeg]
    category: motion
required_environment_variables:
  - name: ELEVENLABS_API_KEY
    optional: true
    prompt: ElevenLabs API key
    help: Optional, only for voice-over. Hermes has built-in ElevenLabs support, so enter the key directly in Hermes (hermes setup). Get one at https://elevenlabs.io
    required_for: voice-over (music + SFX work without it)
---

# mp-audio — voice, music, SFX, loudness

## Keys
- `ELEVENLABS_API_KEY` is the key Hermes already manages for its ElevenLabs support: enter it in Hermes (`hermes setup`). The script also reads `~/.hermes/.env` and a `.env` in the studio root. Never write a key into a file, log, prompt or answer. Missing key → say so, offer "silent + music only".
- Voice ID and model come from the user (BRIEF.md). No default voice ID is shipped; ask or let the user pick from their ElevenLabs library.

## Steps
1. **Voice** — `python3 <skill-dir>/scripts/tts_elevenlabs.py --text-file voice.txt --voice-id <id> --model <model> --lang de --out audio/voice.mp3 --timestamps audio/voice.words.json`. Keep the script tight: no long pauses, no stage directions in the text. Word timestamps feed `mp-build` word sync.
2. **Music** — the user supplies a royalty-free file (or `npx hyperframes` tts/music tools if available). Pick tempo to the storyboard (reels 110–130 bpm, product 90–105, cinematic 60–80). Cut to length, edit points on bars.
3. **SFX** — on every hero hit: whoosh (big move), tick (list items/UI), thud/sub (reveal), riser (before the turn). Generate with `npx hyperframes tts`-adjacent tools, ElevenLabs sound effects, or synthesise simple ones with ffmpeg (`scripts/sfx.sh`). Place by storyboard timestamps.
4. **Mix** — `bash <skill-dir>/scripts/mix.sh audio/voice.mp3 audio/music.mp3 audio/sfx.mp3 audio/mix.wav` → ducking + two-pass loudnorm. Targets in `references/loudness.md`.
5. Attach the mix to the composition (replace scratch audio). Re-render draft. Ask the user to listen: "Stimme vorn? Musik zu laut? Hits auf den Bewegungen?" You cannot hear; say so.
6. Hand off to `mp-critique`.

## Rules
- Audio length == video length. Pad or trim; never let the renderer stretch.
- Voice first frame ≥ 0.25 s in; last word ends ≥ 1.0 s before end (CTA hold).
- Music fades out over the last 1.5 s; never hard cut.
- Keep loudness report (`audio/loudness.json`) in the project for `DELIVERY.md`.

## Files in this skill
- `references/loudness.md`
- `scripts/loudness.sh`
- `scripts/mix.sh`
- `scripts/sfx.sh`
- `scripts/tts_elevenlabs.py`
