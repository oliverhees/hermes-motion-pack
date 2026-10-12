# Loudness targets (EBU R128 / platform practice)

| Role | Integrated | Notes |
|---|---|---|
| voice stem | -16 LUFS | clear, light compression 3:1 |
| music under voice | -28 LUFS (≈12 LU below voice) | sidechain duck -8 dB on voice, attack 50 ms, release 400 ms |
| music without voice | -18 LUFS | reels/stings |
| SFX | peaks -6 dBTP | never louder than voice |
| final mix (web/social) | -14 LUFS, true peak -1 dBTP | YouTube/Reels normalise here |
| final mix (broadcast) | -23 LUFS, -1 dBTP | only if asked |

If the user's brief says other values (e.g. -14 voice / -12 mix), use theirs and note it in DELIVERY.md.

Measure: `ffmpeg -i mix.wav -af ebur128=peak=true -f null -` or `scripts/loudness.sh`.
