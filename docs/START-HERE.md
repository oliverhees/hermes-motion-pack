# Start here — beginner guide (English)

[🇩🇪 Deutsch](START-HERE.de.md)

Every step ends with **Done when** so you know you can move on. About 15 minutes.

## 1. Check the basics
```bash
node -v        # need v22 or newer → https://nodejs.org
ffmpeg -version | head -1   # need any recent ffmpeg → apt install ffmpeg / brew install ffmpeg
python3 -c "import numpy; print('numpy ok')"   # else: pip install numpy
hermes --version
```
**Done when:** all four print a version / "numpy ok".

## 2. Install the pack into Hermes
```bash
hermes skills tap add oliverhees/hermes-motion-pack && for s in motion-pack mp-brief mp-style mp-storyboard mp-build mp-audio mp-critique mp-ship mp-footage mp-genclip mp-highlight; do hermes skills install oliverhees/hermes-motion-pack/$s; done && hermes skills install official/creative/hyperframes
```
Hermes scans each skill and asks you to confirm (community source). Say yes.

**Done when:** `hermes skills list | grep -c "mp-"` prints `10` and `motion-pack` is in the list.

*No `hermes` CLI (Desktop App only)?* Clone the repo and run `bash install.sh`; it copies the skills into `~/.hermes/skills/motion/`.

## 3. Optional keys
- Voice-over: put `ELEVENLABS_API_KEY=...` in `~/.hermes/.env` (Hermes asks for it the first time `mp-audio` loads).
- AI clips: connect the kie.ai MCP in Hermes, or put `KIE_API_KEY=...` in `~/.hermes/.env`.

**Done when:** the keys are in `.env` — or you decided to go without voice / AI clips (everything else works).

## 4. First video
Start a new Hermes session and type:
```
/motion-pack Mach mir einen 15-Sekunden-Reel für <dein Tool>, 9:16
```
Hermes asks up to 3 questions, then shows the brief. Answer with `OK` or corrections.

**Done when:** you have `~/motion-studio/<project>/out/final_1080x1920.mp4` and a `DELIVERY.md`.

## 5. First highlight video from your footage
```
/motion-pack Schneid mir aus ~/footage/<folder> ein 30-Sekunden-Highlight-Reel, auf den Beat, epic
```
Hermes makes proxies, scans the clips, shows you strips of the best moments, you pick.

**Done when:** `out/final_*.mp4` exists and the cuts sit on the beat (check `critique/` sheets).

## 6. If something goes wrong
| Symptom | Fix |
|---|---|
| render stutters / crashes | Hermes runs `npx hyperframes render --workers 1`, then `npx hyperframes doctor` |
| "lint error" | the agent must fix it before rendering — ask it to show the lint output |
| no voice | key missing → `~/.hermes/.env`, then new session |
| beats look wrong | tell Hermes the bpm (`"die Musik hat 128 bpm"`) — it passes `--bpm` |
| the agent says it cannot see images | your model has no vision; open `critique/contact.png` yourself and describe what's off |
| "Wo waren wir?" | Hermes reads `STATE.json` and continues |

Questions → [AIIANER Community](https://aiianer.de) · bugs → GitHub issues · security → SECURITY.md
