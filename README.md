<div align="center">

**🚧 STATUS: BETA v0.2**

![Hermes Motion Pack — studio-grade motion graphics & cinematic highlight videos](docs/assets/hermes-motion-pack-release.en.png)

# 🎬 Hermes Motion Pack

**Studio-grade motion graphics and cinematic highlight videos — built as code, critiqued by the agent itself.**

<p align="center">
  <a href="#-license"><img src="https://img.shields.io/badge/License-AGPL--3.0%20%2B%20Commercial-red" alt="License" /></a>
  <img src="https://img.shields.io/badge/For-Hermes%20Agent-red" alt="For Hermes Agent" />
  <img src="https://img.shields.io/badge/Skills-11-red" alt="11 skills" />
  <a href="https://github.com/oliverhees/hermes-motion-pack/actions/workflows/tests.yml"><img src="https://github.com/oliverhees/hermes-motion-pack/actions/workflows/tests.yml/badge.svg" alt="Tests" /></a>
  <a href="https://aiianer.de"><img src="https://img.shields.io/badge/Community-AIIANER-black" alt="AIIANER Community" /></a>
</p>

**🇬🇧 English** · [🇩🇪 Deutsch](README.de.md)

[Install](#-install) · [Use](#-use) · [When to use what](#-when-to-use-what) · [What's inside](#-whats-inside) · [How it works](#-how-it-works) · [Prompts](prompts/README.md) · [Beginner guide](docs/START-HERE.md) · [License](#-license)

</div>

---

## What is this?

Hermes Motion Pack is a set of **11 chained skills** for the
[Hermes Agent](https://github.com/NousResearch/hermes-agent) that turn a one-line
request into a finished video: product spots, 9:16 reels, launch teasers, logo
stings, data stories, UI showcases — and **cinematic highlight videos, trailers and
recaps** cut from your own footage, from AI-generated clips, or from pure code.

Videos are **programs, not generations**: HTML + GSAP rendered with
[HyperFrames](https://github.com/heygen-com/hyperframes), edits assembled with ffmpeg,
every number and easing deterministic. The agent interviews you first, writes a brief,
steals a reference for the look, storyboards, builds, mixes audio, **looks at its own
frames**, scores them, fixes, and only ships when every score is ≥ 8/10.

**Part of the AIIANER ecosystem:** At [AIIANER](https://aiianer.de) we build an
AI operating system on top of [Hermes](https://github.com/NousResearch/hermes-agent).
Hermes itself is an open-source project by **Nous Research** — this is an
independent community extension and has no official affiliation with Nous Research.

## Why?

> The prompt is 10 % of the video. The harness is the other 90 %.

Ask an agent for "a cool video" and you get centred text fading over a gradient.
Not because the model can't do better — because nobody gave it a reference, a state
list per beat, a way to see its own output, and permission to be harsh with itself.
This pack is that harness. No talking heads, no avatar explainers, on purpose.

## ✨ What's inside

| Skill | Does |
|---|---|
| `motion-pack` | **Start here.** Interviews first, runs the chain with approval gates, remembers where you are |
| `mp-brief` | Tap-friendly interview (max 2 × 3 questions) → `BRIEF.md` |
| `mp-style` | Reference-driven design doc, 8 presets (clean-product, editorial-brutal, neo-glass, kinetic-type, hand-drawn, cinematic-dark, data-minimal, retro-print) → `STYLE.md` |
| `mp-storyboard` | Beats, state lists, voice lines, SFX hits → `STORYBOARD.md` |
| `mp-build` | One HTML/GSAP scene per beat on a shared design system → `npx hyperframes lint` → draft render |
| `mp-audio` | ElevenLabs voice (key from env only), music ducking, SFX, two-pass loudness (-14 LUFS) |
| `mp-critique` | Contact / phone / strip / loop sheets, 8 criteria scored 1–10, fix list, loop until ≥ 8 |
| `mp-ship` | Final renders in all formats, `DELIVERY.md`, "save this pipeline as a skill" |
| `mp-footage` | Your own clips: proxies, scene cuts, motion / loudness / speech scores → best moments |
| `mp-genclip` | AI clips (Seedance, Veo, Kling via kie.ai) shot by shot, look-locked, cost shown first |
| `mp-highlight` | Beat-synced cinematic cut: speed ramps, grade, grain, letterbox, flash; titles, glitch, light leaks, counters as overlays |

Plus **12 ready prompts** in [`prompts/`](prompts/README.md) — including a master prompt that
works with any coding agent, even without the pack — and tested scripts for loudness,
contact sheets, footage scanning, beat grids and exports.

## 🧩 How it works

```
you: /motion-pack Mach mir einen 15-Sekunden-Reel für mein Tool
 │
 ├─ mp-brief      3 questions → BRIEF.md ──────────────────── OK?
 ├─ mp-style      preset or reference → STYLE.md ───────────── OK?
 ├─ mp-storyboard beats + state lists → STORYBOARD.md ──────── OK?
 │
 ├─ GRAPHICS track:  mp-build     scenes/*.html + GSAP → lint → draft.mp4
 ├─ HIGHLIGHT track: mp-footage / mp-genclip → SHOTLIST.json
 │                   mp-highlight beats.json → EDIT.json → base cut → overlays
 │
 ├─ mp-audio      voice + music + SFX → -14 LUFS mix ───────── you listen
 ├─ mp-critique   sheets → scores → fix list ─┐
 │                 all ≥ 8? no → back to build ┘
 └─ mp-ship       final renders + DELIVERY.md
```

1. You describe the video in one sentence. Hermes asks the 3 questions that matter, nothing more.
2. Hermes writes the brief, proposes a look, storyboards every beat as a state list.
3. It builds scenes as code (or cuts your footage on the beat), renders a draft.
4. It generates contact sheets of its own render, scores them like a harsh motion director, fixes, repeats.
5. You get the files, a `DELIVERY.md` with every source and every unverified claim — and optionally a new skill that makes the next video in this style a one-liner.

## 🚀 Install

**Requirements:** Hermes Agent · Node ≥ 22 · ffmpeg · Python 3 (+ `numpy` for beat detection).
Optional: `ELEVENLABS_API_KEY` for voice-over, `KIE_API_KEY` or the kie.ai MCP for AI clips.

**Let Hermes install it:** paste this prompt into any Hermes chat (CLI, Desktop, Telegram). It checks dependencies, installs the skills, asks for optional keys and ends with a test render. A German version is in [docs/HERMES-INSTALL-PROMPT.md](docs/HERMES-INSTALL-PROMPT.md).

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

**Other agents:** `bash install.sh --target .claude/skills` (Claude Code) or any folder that loads `SKILL.md` skills. The prompts in `prompts/` work anywhere.

➡️ **Beginner guide, every step with "Done when":** [docs/START-HERE.md](docs/START-HERE.md)

## 🎬 Use

```
/motion-pack Mach mir einen 15-Sekunden-Reel für mein Tool, 9:16, deutsch
/motion-pack Schneid mir aus dem Ordner ~/footage/launch ein 30-Sekunden-Highlight-Reel, epic, auf den Beat
/motion-pack 8-second launch teaser for Acme, cinematic dark, reveal the date
/mp-critique                                      ← "why does this look cheap?" on any render
```

Hermes asks ≤ 3 questions, then runs the chain. You say OK at each gate. "Wo waren wir?" resumes any project.

## 🧭 When to use what

**Rule of thumb:** start with `/motion-pack`. It runs the whole chain and calls the right sub-skill itself. Use a single `mp-*` skill only to redo one step. Use a prompt from [`prompts/`](prompts/README.md) when you already know what kind of video you want.

### Pick by situation

| Your situation | Do this | Prompt template |
| --- | --- | --- |
| Product or tool, no footage, need a spot | `/motion-pack` + one sentence | [01 product spot](prompts/01-product-spot-30s.md), [06 UI showcase](prompts/06-ui-showcase-30s.md) |
| Social hook, words and numbers only | `/motion-pack` | [02 kinetic typography](prompts/02-reel-kinetic-typography.md), [08 quote](prompts/08-quote-manifesto-reel.md), [05 data story](prompts/05-data-story-20s.md) |
| Launch or date reveal | `/motion-pack` | [03 launch teaser](prompts/03-launch-teaser-8s.md) |
| Logo animation, loopable | `/motion-pack` | [04 logo sting](prompts/04-logo-sting-loop.md) |
| Before/after, comparison | `/motion-pack` | [07 before/after](prompts/07-before-after-reel.md) |
| **You have footage** (gameplay, event, vlog) | `/motion-pack` + folder path. It runs `mp-footage`, then `mp-highlight` | [09 highlight reel](prompts/09-highlight-reel-footage.md), [11 event recap](prompts/11-event-recap.md) |
| **No footage, want cinematic shots** | `/motion-pack` + "generate the clips". It runs `mp-genclip` (needs `KIE_API_KEY`) | [10 trailer with AI clips](prompts/10-trailer-ai-clips.md) |
| A render exists and looks cheap or off | `/mp-critique` | none |
| Different look, same story | `/mp-style`, then `/mp-build` | none |
| Voice-over, music or loudness is wrong | `/mp-audio` (voice needs `ELEVENLABS_API_KEY`) | none |
| Approved, need every format | `/mp-ship` | none |
| Coming back after a break | "Wo waren wir?" | none |

### Pick by step

| Step | Skill | Run it alone when | You get |
| --- | --- | --- | --- |
| 1 | `mp-brief` | You are unsure what the video should do | `BRIEF.md` |
| 2 | `mp-style` | You want a new look | `STYLE.md` (8 presets) |
| 3 | `mp-storyboard` | The pacing or order of beats is wrong | `STORYBOARD.md` |
| 4 | `mp-build` | One scene needs a change, or a re-render | HyperFrames project, draft MP4 |
| 5 | `mp-audio` | Sound is the problem | mixed audio at -14 LUFS |
| 6 | `mp-critique` | Anything looks "not quite right" | scores 1-10, top 3 problems |
| 7 | `mp-ship` | Critique is green | final renders, `DELIVERY.md` |
| side | `mp-footage` / `mp-genclip` / `mp-highlight` | You work with real or AI footage | `SHOTLIST.json`, beat-synced cut |

### A typical session

1. `/motion-pack Make me a 15-second reel for <your tool>, 9:16, German`
2. Answer the 3 questions, then approve the brief, the look and the storyboard (the gates).
3. Watch the draft render. If it feels off, run `/mp-critique` or say what bothers you in plain words.
4. Repeat until every score is 8 or higher, then say "ship it" to get all formats plus `DELIVERY.md`.
5. Say yes to the offer to save the pipeline as a skill. The next video in this style is then one sentence.

### Pitfalls

- **Skipping the questions** produces generic videos. The brief is the cheapest place to fix things.
- **Rendering finals too early** wastes time. Iterate on drafts and ship only after critique is green.
- **No keys is fine**: everything works except voice-over (ElevenLabs) and AI clips (kie.ai).
- **Footage videos** need a folder path, not a description. Give Hermes the real files.

## 🧪 Tests

`bash tests/smoke.sh` runs every script on synthetic media (no network, no keys): frontmatter,
audio mix hits -14 LUFS, critique sheets, footage scan finds the loud peak, beat grid, graded
base cut, exports. CI also scaffolds a HyperFrames project and lints it.

## 🔧 Status

**Beta v0.2** — honest checklist:

- [x] 11 skills with Hermes frontmatter (tags, env-var declarations, file lists)
- [x] All scripts tested on synthetic media in a clean Linux container
- [x] `init_project.sh` → `npx hyperframes lint` → `npx hyperframes render` → MP4 verified
- [x] Audio mix verified at -14 LUFS / -1 dBTP
- [x] Footage scan, beat grid, graded base cut verified
- [ ] Full agent session end-to-end inside Hermes (please report what breaks)
- [ ] ElevenLabs TTS script against the live API (needs a key)
- [ ] kie.ai tool names re-checked at runtime (skill tells the agent to discover them)
- [ ] Video-clip attributes for the base cut inside a HyperFrames composition (skill defers to the official HyperFrames skill)

---

## 🌍 The AIIANER universe

| | |
| --- | --- |
| 🏠 **Community** | [aiianer.de](https://aiianer.de) — courses, labs, tutorials, AI coaches |
| 📺 **YouTube** | [youtube.com/@aiianer](https://www.youtube.com/@aiianer) — tools, tests, deep dives |
| 🔒 **Datenschleuse** | [github.com/oliverhees/datenschleuse](https://github.com/oliverhees/datenschleuse) — GDPR filter for your AI |
| 🛡️ **coolify-shield** | [github.com/oliverhees/coolify-shield](https://github.com/oliverhees/coolify-shield) — lock down your server |
| 📬 **Gmail Guard** | [github.com/oliverhees/hermes-gmail-guard](https://github.com/oliverhees/hermes-gmail-guard) — Hermes reads, you send |

## 📜 License

Dual licensed: **AGPL-3.0** (private use, creators, agencies, research) or a
**commercial license** (closed products/services, no source disclosure).
The videos you make with it are yours. Details: [LICENSING.md](LICENSING.md).
Requests via the [AIIANER Community](https://aiianer.de) or **hi@aiianer.de**.

## Security

Please do **not** report vulnerabilities as public issues. See [SECURITY.md](SECURITY.md).

## Trademarks

"AIIANER" is a trademark of Oliver Hees aka Aiianer. The code license grants
**no** rights to this name or logo. Forks must use their own name.

"Hermes" is an open-source project by **Nous Research**
([github.com/NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent)).
"HyperFrames" is an open-source project by HeyGen. "GSAP" is a trademark of Webflow, Inc.
"ElevenLabs" and "kie.ai" are trademarks of their owners. This project is independent
and not affiliated with any of them.

---

<p align="center">
  © 2026 <strong>Oliver Hees aka Aiianer</strong> ·
  <a href="https://aiianer.de">aiianer.de</a> ·
  Made with 🖤 in the AIIANER universe
</p>
