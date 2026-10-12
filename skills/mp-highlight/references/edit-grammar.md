# Edit grammar for highlights, trailers, recaps

## Arc (30 s @ 120 bpm = 60 beats)
| section | beats | cut rhythm | shots | energy |
|---|---|---|---|---|
| cold open | 0–8 | 1 cut at beat 4 | 2 slow, atmospheric (0.5–0.7× speed) | low, title 1 at beat 2 |
| build | 8–24 | every 2 beats | 8 shots, rising motion, titles on downbeats 8/16 | rising, riser SFX from 20 |
| drop | 24–40 | every beat, 2× half-beats | 18 shots, the best action, 1 speed ramp, 1 flash | peak |
| breath | 40–48 | 1 cut | one long emotional shot, quote card | low |
| finale | 48–60 | every 2 beats then hold | 4 shots → logo/title/date, URL | resolve |

Trailer variant: cold open longer (12 beats), two drops, "coming <date>" card at the end.
Recap variant: build carries data overlays (numbers counting up), finale = thank-you + next date.

## Matching shots
- Cut on action: the move that starts in shot A continues in shot B (direction preserved).
- Alternate wide → close → wide. Never two static wides in a row during the drop.
- Match motion direction across a cut (left-to-right stays left-to-right) or flip it on purpose with a flash.
- Light/colour: order shots so brightness doesn't flicker; grade fixes the rest.

## Speed
- Slow-mo 0.4–0.6× for impact and emotion; needs 50/60 fps source or `minterpolate` (slow render).
- Speed ramp: slow into the hit, snap to 1.6× out of it. Place the hit on the downbeat.
- Freeze frame (0.3 s) + title = classic trailer beat; max once.

## Titles
- ≤ 4 words per card. Hero word huge, rest small. Enter on the downbeat, exit on the next beat.
- Trailer: words separated by cuts ("THIS. SUMMER. EVERYTHING. CHANGES.").
- Recap: label + number ("1,240 attendees" → counter).
