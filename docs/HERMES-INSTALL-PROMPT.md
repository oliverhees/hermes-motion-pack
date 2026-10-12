# Let Hermes install the pack itself

Paste one of these into a Hermes chat (CLI, Desktop, Telegram — anywhere). Hermes checks dependencies, installs the skills, asks for optional keys and finishes with a test render.

## 🇩🇪 Deutsch

```
Installier mir bitte den hermes-motion-pack (github.com/oliverhees/hermes-motion-pack) komplett und eigenständig. Mach es in dieser Reihenfolge und melde nach jedem Schritt kurz OK oder was fehlt:

1. Voraussetzungen prüfen: node >= 22, ffmpeg, python3, numpy. Was fehlt, installier über den Paketmanager dieses Systems (bei node: nodejs.org / nvm; numpy: pip install numpy). Nichts stillschweigend überspringen.
2. Das Repo als Skill-Tap hinzufügen: hermes skills tap add oliverhees/hermes-motion-pack
3. Diese 11 Skills installieren (Sicherheitsscan bestätigen, falls gefragt): motion-pack, mp-brief, mp-style, mp-storyboard, mp-build, mp-audio, mp-critique, mp-ship, mp-footage, mp-genclip, mp-highlight – jeweils mit: hermes skills install oliverhees/hermes-motion-pack/<skill> (2–3 pro Befehl, nicht alle auf einmal). Blockiert der Sicherheitsscan einen Skill: zeig mir die markierten Zeilen, prüf sie gegen das Repo und kopiere den Skill nur bei harmlosem Befund manuell: cp -r <repo>/skills/<skill> ~/.hermes/skills/<skill>
   Falls der Tap-Weg nicht klappt: Repo nach ~/motion-studio/hermes-motion-pack klonen und dort bash install.sh ausführen.
4. Den offiziellen HyperFrames-Skill installieren: hermes skills install official/creative/hyperframes (steht dort „already installed“, der Skill fehlt aber in hermes skills list: cp -r ~/.hermes/hermes-agent/optional-skills/creative/hyperframes ~/.hermes/skills/creative/hyperframes)
5. Prüfen, dass npx hyperframes --version läuft (beim ersten Mal wird es heruntergeladen).
6. Den /motion-Shortcut anlegen: motion.bundle.yaml aus dem Repo nach ~/.hermes/skill-bundles/motion.yaml kopieren (Repo dafür notfalls klonen).
7. Mich fragen, ob ich die optionalen Extras einrichten will: (a) Sprecherstimme: Hermes hat ElevenLabs bereits eingebaut, ich trage meinen ElevenLabs-Key direkt in Hermes ein (`hermes setup`), niemals im Chat; (b) KI-Clips: den kie.ai-MCP-Server von https://github.com/oliverhees/kie-ai-mcp-server in Hermes verbinden (`hermes mcp add`), der kie.ai-Key liegt auf diesem Server. Ohne sie läuft alles außer Stimme und KI-Clips.
8. Testlauf: bash ~/.hermes/skills/motion/mp-build/scripts/init_project.sh ~/motion-studio/_smoketest 1080 1920 30 2 (Pfad notfalls anpassen), dann dort npx hyperframes lint und npx hyperframes render --quality draft --output out/test.mp4. Wenn ein MP4 entsteht, bist du fertig.
9. Am Ende: hermes skills list zeigen, mir sagen, dass ich /reload-skills selbst im Chat tippen muss (es ist ein Chat-Befehl), und mir in drei Zeilen sagen: ✅ installiert, ⚠️ was fehlt, 👉 mein erster Befehl (z. B. /motion-pack Mach mir einen 15-Sekunden-Reel für …).
```

## 🇬🇧 English

```
Please install hermes-motion-pack (github.com/oliverhees/hermes-motion-pack) completely and on your own. Do it in this order and report a short OK or what's missing after each step:

1. Check prerequisites: node >= 22, ffmpeg, python3, numpy. Install whatever is missing with this system's package manager (node: nodejs.org / nvm; numpy: pip install numpy). Skip nothing silently.
2. Add the repo as a skill tap: hermes skills tap add oliverhees/hermes-motion-pack
3. Install these 11 skills (confirm the security scan if asked): motion-pack, mp-brief, mp-style, mp-storyboard, mp-build, mp-audio, mp-critique, mp-ship, mp-footage, mp-genclip, mp-highlight — each with: hermes skills install oliverhees/hermes-motion-pack/<skill> (2–3 per command, not all in one go). If the security scan blocks a skill: show me the flagged lines, check them against the repo, and only if they are harmless copy that skill manually: cp -r <repo>/skills/<skill> ~/.hermes/skills/<skill>
   If the tap route fails: clone the repo to ~/motion-studio/hermes-motion-pack and run bash install.sh there.
4. Install the official HyperFrames skill: hermes skills install official/creative/hyperframes (if it says "already installed" but the skill is not in hermes skills list: cp -r ~/.hermes/hermes-agent/optional-skills/creative/hyperframes ~/.hermes/skills/creative/hyperframes)
5. Verify that npx hyperframes --version works (first call downloads it).
6. Create the /motion shortcut: copy motion.bundle.yaml from the repo to ~/.hermes/skill-bundles/motion.yaml (clone the repo if needed).
7. Ask me whether I want to set up the optional extras: (a) voice-over: Hermes has built-in ElevenLabs support, so I enter my ElevenLabs key directly in Hermes (`hermes setup`), never in chat; (b) AI clips: connect the kie.ai MCP server from https://github.com/oliverhees/kie-ai-mcp-server in Hermes (`hermes mcp add`), the kie.ai key lives on that server. Without them everything works except voice and AI clips.
8. Test run: bash ~/.hermes/skills/motion/mp-build/scripts/init_project.sh ~/motion-studio/_smoketest 1080 1920 30 2 (adjust the path if needed), then run npx hyperframes lint and npx hyperframes render --quality draft --output out/test.mp4 there. If an MP4 appears, you're done.
9. Finally: show hermes skills list, tell me to type /reload-skills myself (it is a chat command) and tell me in three lines: ✅ installed, ⚠️ what's missing, 👉 my first command (e.g. /motion-pack Make me a 15-second reel for …).
```
