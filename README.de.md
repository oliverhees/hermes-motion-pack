<div align="center">

**🚧 STATUS: BETA v0.2**

![Hermes Motion Pack — Motion Graphics & cinematische Highlight-Videos auf Studio-Niveau](docs/assets/hermes-motion-pack-release.de.png)

# 🎬 Hermes Motion Pack

**Motion Graphics und cinematische Highlight-Videos auf Studio-Niveau — als Code gebaut, vom Agenten selbst kritisiert.**

<p align="center">
  <a href="#-lizenz"><img src="https://img.shields.io/badge/Lizenz-AGPL--3.0%20%2B%20Kommerziell-red" alt="Lizenz" /></a>
  <img src="https://img.shields.io/badge/F%C3%BCr-Hermes%20Agent-red" alt="Für Hermes Agent" />
  <img src="https://img.shields.io/badge/Skills-11-red" alt="11 Skills" />
  <a href="https://github.com/oliverhees/hermes-motion-pack/actions/workflows/tests.yml"><img src="https://github.com/oliverhees/hermes-motion-pack/actions/workflows/tests.yml/badge.svg" alt="Tests" /></a>
  <a href="https://aiianer.de"><img src="https://img.shields.io/badge/Community-AIIANER-black" alt="AIIANER Community" /></a>
</p>

[🇬🇧 English](README.md) · **🇩🇪 Deutsch**

[Installation](#-installation) · [Benutzen](#-benutzen) · [Was drin ist](#-was-drin-ist) · [So funktioniert es](#-so-funktioniert-es) · [Prompts](prompts/README.md) · [Einsteiger-Anleitung](docs/START-HERE.de.md) · [Lizenz](#-lizenz)

</div>

---

## Was ist das?

Hermes Motion Pack sind **11 verkettete Skills** für den
[Hermes Agent](https://github.com/NousResearch/hermes-agent), die aus einem Satz ein
fertiges Video machen: Produkt-Spots, 9:16-Reels, Launch-Teaser, Logo-Stings,
Daten-Stories, UI-Showcases — und **cinematische Highlight-Videos, Trailer und Recaps**
aus deinem eigenen Footage, aus KI-Clips oder rein aus Code.

Videos sind hier **Programme, keine Generierungen**: HTML + GSAP, gerendert mit
[HyperFrames](https://github.com/heygen-com/hyperframes), Schnitte mit ffmpeg, jede
Zahl und jedes Easing deterministisch. Der Agent interviewt dich zuerst, schreibt ein
Briefing, klaut sich eine Referenz für den Look, macht ein Storyboard, baut, mischt den
Ton, **schaut sich seine eigenen Frames an**, bewertet sie, bessert nach — und liefert
erst, wenn jeder Score ≥ 8/10 ist.

**Teil des AIIANER-Ökosystems:** Bei [AIIANER](https://aiianer.de) bauen wir ein
KI-Betriebssystem auf Basis von [Hermes](https://github.com/NousResearch/hermes-agent).
Hermes selbst ist ein Open-Source-Projekt von **Nous Research** — dies ist eine
unabhängige Community-Erweiterung ohne offizielle Verbindung zu Nous Research.

## Warum?

> Der Prompt ist 10 % des Videos. Der Harness ist die anderen 90 %.

Bitte einen Agenten um „ein cooles Video", und du bekommst zentrierten Text, der über
einen Farbverlauf einblendet. Nicht, weil das Modell es nicht besser könnte — sondern
weil ihm niemand eine Referenz, eine Zustandsliste pro Beat, einen Blick auf das eigene
Ergebnis und die Erlaubnis zur Selbstkritik gegeben hat. Dieser Pack ist dieser Harness.
Bewusst ohne Talking Heads und Avatar-Erklärvideos.

## ✨ Was drin ist

| Skill | Macht |
|---|---|
| `motion-pack` | **Hier starten.** Fragt zuerst, führt die Kette mit Freigabe-Toren, merkt sich den Stand |
| `mp-brief` | Antippbares Interview (max 2 × 3 Fragen) → `BRIEF.md` |
| `mp-style` | Referenz-getriebenes Design-Dokument, 8 Presets (clean-product, editorial-brutal, neo-glass, kinetic-type, hand-drawn, cinematic-dark, data-minimal, retro-print) → `STYLE.md` |
| `mp-storyboard` | Beats, Zustandslisten, Sprechtext, SFX-Hits → `STORYBOARD.md` |
| `mp-build` | Eine HTML/GSAP-Szene pro Beat auf gemeinsamem Design-System → `npx hyperframes lint` → Entwurf |
| `mp-audio` | ElevenLabs-Stimme (Key nur aus Env), Musik-Ducking, SFX, Zwei-Pass-Lautheit (-14 LUFS) |
| `mp-critique` | Contact-/Phone-/Strip-/Loop-Sheets, 8 Kriterien mit Score 1–10, Fix-Liste, Schleife bis ≥ 8 |
| `mp-ship` | Final-Render in allen Formaten, `DELIVERY.md`, „diese Pipeline als Skill speichern" |
| `mp-footage` | Dein eigenes Material: Proxies, Szenenschnitte, Bewegungs-/Lautheits-/Sprach-Scores → beste Momente |
| `mp-genclip` | KI-Clips (Seedance, Veo, Kling via kie.ai) Shot für Shot, Look-gelockt, Kosten vorher |
| `mp-highlight` | Beat-synchroner Cinematic-Schnitt: Speed-Ramps, Grade, Grain, Letterbox, Flash; Titel, Glitch, Light-Leaks, Zähler als Overlays |

Dazu **12 fertige Prompts** in [`prompts/`](prompts/README.md) — inklusive Master-Prompt,
der mit jedem Coding-Agenten funktioniert, auch ohne den Pack — und getestete Scripts für
Lautheit, Contact Sheets, Footage-Scan, Beat-Grid und Export.

## 🧩 So funktioniert es

```
du: /motion-pack Mach mir einen 15-Sekunden-Reel für mein Tool
 │
 ├─ mp-brief      3 Fragen → BRIEF.md ────────────────────── OK?
 ├─ mp-style      Preset oder Referenz → STYLE.md ─────────── OK?
 ├─ mp-storyboard Beats + Zustandslisten → STORYBOARD.md ──── OK?
 │
 ├─ GRAFIK-Spur:    mp-build     scenes/*.html + GSAP → lint → draft.mp4
 ├─ HIGHLIGHT-Spur: mp-footage / mp-genclip → SHOTLIST.json
 │                  mp-highlight beats.json → EDIT.json → Base-Cut → Overlays
 │
 ├─ mp-audio      Stimme + Musik + SFX → -14-LUFS-Mix ─────── du hörst rein
 ├─ mp-critique   Sheets → Scores → Fix-Liste ─┐
 │                 alles ≥ 8? nein → zurück ────┘
 └─ mp-ship       Final-Renders + DELIVERY.md
```

1. Du beschreibst das Video in einem Satz. Hermes stellt die 3 Fragen, die zählen, nicht mehr.
2. Hermes schreibt das Briefing, schlägt einen Look vor, storyboardet jeden Beat als Zustandsliste.
3. Es baut Szenen als Code (oder schneidet dein Footage auf den Beat) und rendert einen Entwurf.
4. Es erzeugt Contact Sheets vom eigenen Render, bewertet sie wie ein strenger Motion Director, bessert nach, wiederholt.
5. Du bekommst die Dateien, ein `DELIVERY.md` mit jeder Quelle und jeder ungeprüften Behauptung — und optional einen neuen Skill, mit dem das nächste Video in diesem Stil ein Einzeiler ist.

## 🚀 Installation

**Voraussetzungen:** Hermes Agent · Node ≥ 22 · ffmpeg · Python 3 (+ `numpy` für die Beat-Erkennung).
Optional: `ELEVENLABS_API_KEY` für Sprecherstimme, `KIE_API_KEY` oder das kie.ai-MCP für KI-Clips.

**Faul-Modus — Hermes installiert selbst:** den Prompt aus [docs/HERMES-INSTALL-PROMPT.md](docs/HERMES-INSTALL-PROMPT.md) in irgendeinen Hermes-Chat einfügen. Hermes prüft Abhängigkeiten, installiert Skills und Keys und endet mit einem Test-Render.

**Ein Befehl in Hermes:**

```bash
hermes skills tap add oliverhees/hermes-motion-pack && for s in motion-pack mp-brief mp-style mp-storyboard mp-build mp-audio mp-critique mp-ship mp-footage mp-genclip mp-highlight; do hermes skills install oliverhees/hermes-motion-pack/$s; done && hermes skills install official/creative/hyperframes
```

Das fügt das Repo als Skill-Tap hinzu, installiert die 11 Skills mit dem Hermes-Sicherheitsscan
und den offiziellen HyperFrames-Skill (das Kompositions-Format). Danach eine neue Session starten.

**Alternative — git clone:**

```bash
git clone https://github.com/oliverhees/hermes-motion-pack.git && cd hermes-motion-pack
bash install.sh                                      # prüft Abhängigkeiten, kopiert die Skills nach ~/.hermes/skills/motion/
hermes skills install official/creative/hyperframes
```

**Optionale `/motion`-Abkürzung:** `motion.bundle.yaml` nach `~/.hermes/skill-bundles/motion.yaml` kopieren — dann lädt `/motion <Wunsch>` den ganzen Pack auf einmal.

**Andere Agenten:** `bash install.sh --target .claude/skills` (Claude Code) oder jeder Ordner, der `SKILL.md`-Skills lädt. Die Prompts in `prompts/` funktionieren überall.

➡️ **Einsteiger-Anleitung, jeder Schritt mit „Fertig, wenn":** [docs/START-HERE.de.md](docs/START-HERE.de.md)

## 🎬 Benutzen

```
/motion-pack Mach mir einen 15-Sekunden-Reel für mein Tool, 9:16, deutsch
/motion-pack Schneid mir aus dem Ordner ~/footage/launch ein 30-Sekunden-Highlight-Reel, episch, auf den Beat
/motion-pack 8-Sekunden-Launch-Teaser für Acme, cinematic dark, Datum enthüllen
/mp-critique                                      ← „warum sieht das billig aus?" auf jeden Render
```

Hermes stellt ≤ 3 Fragen, dann läuft die Kette. Du sagst an jedem Tor OK. „Wo waren wir?" setzt jedes Projekt fort.

## 🧪 Tests

`bash tests/smoke.sh` lässt jedes Script auf synthetischem Material laufen (kein Netz, keine Keys):
Frontmatter, Audio-Mix trifft -14 LUFS, Kritik-Sheets, Footage-Scan findet den lauten Moment,
Beat-Grid, gegradeter Base-Cut, Export. Die CI legt zusätzlich ein HyperFrames-Projekt an und lintet es.

## 🔧 Status

**Beta v0.2** — ehrliche Checkliste:

- [x] 11 Skills mit Hermes-Frontmatter (Tags, Env-Var-Deklarationen, Dateilisten)
- [x] Alle Scripts auf synthetischem Material im sauberen Linux-Container getestet
- [x] `init_project.sh` → `npx hyperframes lint` → `npx hyperframes render` → MP4 verifiziert
- [x] Audio-Mix bei -14 LUFS / -1 dBTP verifiziert
- [x] Footage-Scan, Beat-Grid, gegradeter Base-Cut verifiziert
- [ ] Komplette Agenten-Session Ende-zu-Ende in Hermes (bitte melden, was klemmt)
- [ ] ElevenLabs-TTS-Script gegen die Live-API (braucht Key)
- [ ] kie.ai-Toolnamen zur Laufzeit geprüft (der Skill lässt den Agenten die Tools erst entdecken)
- [ ] Video-Clip-Attribute für den Base-Cut in einer HyperFrames-Komposition (Skill verweist auf den offiziellen HyperFrames-Skill)

---

## 🌍 Das AIIANER-Universum

| | |
| --- | --- |
| 🏠 **Community** | [aiianer.de](https://aiianer.de) — Kurse, Labs, Tutorials, KI-Coaches |
| 📺 **YouTube** | [youtube.com/@aiianer](https://www.youtube.com/@aiianer) — Tools, Tests, Deep Dives |
| 🔒 **Datenschleuse** | [github.com/oliverhees/datenschleuse](https://github.com/oliverhees/datenschleuse) — DSGVO-Filter für deine KI |
| 🛡️ **coolify-shield** | [github.com/oliverhees/coolify-shield](https://github.com/oliverhees/coolify-shield) — Server dichtmachen |
| 📬 **Gmail Guard** | [github.com/oliverhees/hermes-gmail-guard](https://github.com/oliverhees/hermes-gmail-guard) — Hermes liest, du sendest |

## 📜 Lizenz

Dual lizenziert: **AGPL-3.0** (private Nutzung, Creator, Agenturen, Forschung) oder
**kommerzielle Lizenz** (geschlossene Produkte/Dienste, keine Quellcode-Offenlegung).
Die Videos, die du damit machst, gehören dir. Details: [LICENSING.md](LICENSING.md).
Anfragen über die [AIIANER Community](https://aiianer.de) oder **hi@aiianer.de**.

## Sicherheit

Bitte **keine** öffentlichen Issues für Sicherheitslücken. Siehe [SECURITY.md](SECURITY.md).

## Marken

„AIIANER" ist eine Marke von Oliver Hees aka Aiianer. Die Code-Lizenz gewährt
**keine** Rechte an diesem Namen oder Logo. Forks müssen einen eigenen Namen verwenden.

„Hermes" ist ein Open-Source-Projekt von **Nous Research**
([github.com/NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent)).
„HyperFrames" ist ein Open-Source-Projekt von HeyGen. „GSAP" ist eine Marke von Webflow, Inc.
„ElevenLabs" und „kie.ai" sind Marken ihrer Inhaber. Dieses Projekt ist unabhängig
und mit keinem davon verbunden.

---

<p align="center">
  © 2026 <strong>Oliver Hees aka Aiianer</strong> ·
  <a href="https://aiianer.de">aiianer.de</a> ·
  Made with 🖤 in the AIIANER universe
</p>
