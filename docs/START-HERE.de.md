# Hier starten — Einsteiger-Anleitung (Deutsch)

[🇬🇧 English](START-HERE.md)

Jeder Schritt endet mit **Fertig, wenn**, damit du weißt, dass du weiter kannst. Etwa 15 Minuten.

## 1. Grundlagen prüfen
```bash
node -v        # brauchst v22 oder neuer → https://nodejs.org
ffmpeg -version | head -1   # irgendein aktuelles ffmpeg → apt install ffmpeg / brew install ffmpeg
python3 -c "import numpy; print('numpy ok')"   # sonst: pip install numpy
hermes --version
```
**Fertig, wenn:** alle vier eine Version / „numpy ok" ausgeben.

## 2. Pack in Hermes installieren
```bash
hermes skills tap add oliverhees/hermes-motion-pack && for s in motion-pack mp-brief mp-style mp-storyboard mp-build mp-audio mp-critique mp-ship mp-footage mp-genclip mp-highlight; do hermes skills install oliverhees/hermes-motion-pack/$s; done && hermes skills install official/creative/hyperframes
```
Hermes scannt jeden Skill und fragt nach Bestätigung (Community-Quelle). Sag ja.

**Fertig, wenn:** `hermes skills list | grep -c "mp-"` die Zahl `10` ausgibt und `motion-pack` in der Liste ist.

*Kein `hermes`-CLI (nur Desktop-App)?* Repo klonen und `bash install.sh` ausführen; es kopiert die Skills nach `~/.hermes/skills/motion/`.

## 3. Optionale Keys
- Sprecherstimme: Hermes hat ElevenLabs bereits eingebaut. Den ElevenLabs-Key direkt in Hermes eintragen (`hermes setup`).
- KI-Clips: unseren kie.ai-MCP-Server (https://github.com/oliverhees/kie-ai-mcp-server) in Hermes verbinden (`hermes mcp add`). Der kie.ai-Key liegt auf dem MCP-Server.

**Fertig, wenn:** die Keys in `.env` stehen — oder du dich gegen Stimme / KI-Clips entschieden hast (alles andere läuft).

## 4. Erstes Video
Neue Hermes-Session starten und tippen:
```
/motion-pack Mach mir einen 15-Sekunden-Reel für <dein Tool>, 9:16
```
Hermes stellt bis zu 3 Fragen und zeigt dann das Briefing. Antworte mit `OK` oder Korrekturen.

**Fertig, wenn:** `~/motion-studio/<projekt>/out/final_1080x1920.mp4` und ein `DELIVERY.md` da sind.

## 5. Erstes Highlight-Video aus deinem Footage
```
/motion-pack Schneid mir aus ~/footage/<ordner> ein 30-Sekunden-Highlight-Reel, auf den Beat, episch
```
Hermes macht Proxies, scannt die Clips, zeigt dir Strips der besten Momente, du wählst.

**Fertig, wenn:** `out/final_*.mp4` existiert und die Schnitte auf dem Beat sitzen (siehe `critique/`-Sheets).

## 6. Wenn etwas schiefgeht
| Symptom | Lösung |
|---|---|
| Render stottert / bricht ab | Hermes nimmt `npx hyperframes render --workers 1`, dann `npx hyperframes doctor` |
| „lint error" | der Agent muss das vor dem Rendern fixen — lass dir die Lint-Ausgabe zeigen |
| keine Stimme | Key fehlt → `~/.hermes/.env`, dann neue Session |
| Beats sitzen falsch | sag Hermes die bpm („die Musik hat 128 bpm") — es nutzt `--bpm` |
| der Agent sagt, er sieht keine Bilder | dein Modell hat kein Vision; öffne `critique/contact.png` selbst und beschreib, was stört |
| „Wo waren wir?" | Hermes liest `STATE.json` und macht weiter |

Fragen → [AIIANER Community](https://aiianer.de) · Bugs → GitHub-Issues · Sicherheit → SECURITY.md
