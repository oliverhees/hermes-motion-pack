# Let Hermes install the pack itself

Paste one of these into a Hermes chat (CLI, Desktop, Telegram — anywhere). Hermes checks dependencies, installs the skills, asks for optional keys and finishes with a test render.

## 🇩🇪 Deutsch

```
Installier mir bitte den hermes-motion-pack (github.com/oliverhees/hermes-motion-pack) komplett und eigenständig. Mach es in dieser Reihenfolge und melde nach jedem Schritt kurz OK oder was fehlt:

1. Voraussetzungen prüfen: node >= 22, ffmpeg, python3, numpy. Was fehlt, installier über den Paketmanager dieses Systems (bei node: nodejs.org / nvm; numpy: pip install numpy). Nichts stillschweigend überspringen.
2. Das Repo als Skill-Tap hinzufügen: hermes skills tap add oliverhees/hermes-motion-pack
3. Diese 11 Skills installieren (Sicherheitsscan bestätigen, falls gefragt): motion-pack, mp-brief, mp-style, mp-storyboard, mp-build, mp-audio, mp-critique, mp-ship, mp-footage, mp-genclip, mp-highlight – jeweils mit: hermes skills install oliverhees/hermes-motion-pack/<skill>
   Falls der Tap-Weg nicht klappt: Repo nach ~/motion-studio/hermes-motion-pack klonen und dort bash install.sh ausführen.
4. Den offiziellen HyperFrames-Skill installieren: hermes skills install official/creative/hyperframes
5. Prüfen, dass npx hyperframes --version läuft (beim ersten Mal wird es heruntergeladen).
6. Den /motion-Shortcut anlegen: motion.bundle.yaml aus dem Repo nach ~/.hermes/skill-bundles/motion.yaml kopieren (Repo dafür notfalls klonen).
7. Mich fragen, ob ich einen ELEVENLABS_API_KEY (Sprecherstimme) und einen KIE_API_KEY (KI-Clips) eintragen will – wenn ja, in ~/.hermes/.env speichern, niemals im Chat wiederholen. Ohne Keys läuft alles außer Stimme und KI-Clips.
8. Testlauf: bash ~/.hermes/skills/motion/mp-build/scripts/init_project.sh ~/motion-studio/_smoketest 1080 1920 30 2 (Pfad notfalls anpassen), dann dort npx hyperframes lint und npx hyperframes render --quality draft --output out/test.mp4. Wenn ein MP4 entsteht, bist du fertig.
9. Am Ende: hermes skills list zeigen, /reload-skills ausführen und mir in drei Zeilen sagen: ✅ installiert, ⚠️ was fehlt, 👉 mein erster Befehl (z. B. /motion-pack Mach mir einen 15-Sekunden-Reel für …).
```

## 🇬🇧 English

```
Please install hermes-motion-pack (github.com/oliverhees/hermes-motion-pack) completely and on your own. Do it in this order and report a short OK or what's missing after each step:

1. Check prerequisites: node >= 22, ffmpeg, python3, numpy. Install whatever is missing with this system's package manager (node: nodejs.org / nvm; numpy: pip install numpy). Skip nothing silently.
2. Add the repo as a skill tap: hermes skills tap add oliverhees/hermes-motion-pack
3. Install these 11 skills (confirm the security scan if asked): motion-pack, mp-brief, mp-style, mp-storyboard, mp-build, mp-audio, mp-critique, mp-ship, mp-footage, mp-genclip, mp-highlight — each with: hermes skills install oliverhees/hermes-motion-pack/<skill>
   If the tap route fails: clone the repo to ~/motion-studio/hermes-motion-pack and run bash install.sh there.
4. Install the official HyperFrames skill: hermes skills install official/creative/hyperframes
5. Verify that npx hyperframes --version works (first call downloads it).
6. Create the /motion shortcut: copy motion.bundle.yaml from the repo to ~/.hermes/skill-bundles/motion.yaml (clone the repo if needed).
7. Ask me whether I want to add an ELEVENLABS_API_KEY (voice-over) and a KIE_API_KEY (AI clips) — if yes, store them in ~/.hermes/.env and never echo them in chat. Without keys everything works except voice and AI clips.
8. Test run: bash ~/.hermes/skills/motion/mp-build/scripts/init_project.sh ~/motion-studio/_smoketest 1080 1920 30 2 (adjust the path if needed), then run npx hyperframes lint and npx hyperframes render --quality draft --output out/test.mp4 there. If an MP4 appears, you're done.
9. Finally: show hermes skills list, run /reload-skills and tell me in three lines: ✅ installed, ⚠️ what's missing, 👉 my first command (e.g. /motion-pack Make me a 15-second reel for …).
```
