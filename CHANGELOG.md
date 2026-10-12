# Changelog
## 0.1.0 — 2026-10-11
- Initial release: 8 chained skills, 8 style presets, 9 prompts, scripts (init, assemble, tts, mix, loudness, sfx, sheets, determinism, export, save-as-skill), installer, EN/DE README.
- Verified in a clean Linux container: `init_project.sh` → `npx hyperframes lint` → `npx hyperframes render` → MP4 → critique sheets; audio mix hits -14 LUFS.
- Not yet verified: a full agent session end-to-end inside Hermes, ElevenLabs script against the live API (needs a key).

## 0.2.0 — 2026-10-11
- New highlight track: `mp-footage` (inventory, proxies, scene cuts, motion/loudness/speech scoring, candidate strips), `mp-genclip` (AI clips via kie.ai, look-lock, shot prompting), `mp-highlight` (beat grid, EDIT.json, ffmpeg base cut with speed ramps/reframe/grade/grain/letterbox/flash, overlay recipes, edit grammar).
- Router and brief know two tracks (graphics / highlight) and three bases (own footage / AI clips / code).
- 3 new prompts (09 highlight reel, 10 AI trailer, 11 event recap); master prompt gets a TRACK field and the highlight method.
- Verified: inventory → scan (finds the loud peak) → peek strips; beats.py (~117 bpm on a 120 bpm click) → assemble_edit.py produces a graded 1080×1920 base cut with flash and speed changes.

## 0.2.1 — 2026-10-12
- Repo brought in line with the AIIANER repo schema: dual licence (AGPL-3.0 + commercial), LICENSING / SECURITY / NOTICE, EN+DE README with release posters, beginner guides, CI.
- Hermes-native skill frontmatter: version, author, tags, category, `required_environment_variables` (ELEVENLABS_API_KEY, KIE_API_KEY), explicit file lists so URL/GitHub installs fetch every script and reference.
- Repo is a valid Hermes **skill tap** (`skills/<name>/SKILL.md`); `skills.sh.json` groupings; `motion.bundle.yaml` for a `/motion` shortcut.
- `tests/smoke.sh` runs every script on synthetic media; CI also scaffolds + lints a HyperFrames project.

## 0.2.2 — unreleased
- Fix: `ELEVENLABS_API_KEY` (mp-audio) and `KIE_API_KEY` (mp-genclip) are now declared with `optional: true`. Before, Hermes treated them as required, flagged the skills "setup needed" and asked for the keys on load, although voice-over and AI clips are optional.
- Docs and skills: ElevenLabs key is entered in Hermes (built-in support; `tts_elevenlabs.py` also reads `~/.hermes/.env`). AI clips now require the [kie.ai MCP server](https://github.com/oliverhees/kie-ai-mcp-server); `KIE_API_KEY` and the REST fallback are removed from `mp-genclip`. New README section "Level up with ElevenLabs and kie.ai".
- Fix: `mp-footage/scripts/inventory.sh` no longer pipes `echo` into `python3` and no longer uses `eval` for the frame rate (parsed with `fractions.Fraction`). The Hermes skill security scan flagged the old form (`echo_pipe_exec`) and blocked `hermes skills install` for mp-footage.
- New cinematic release posters (EN/DE) in the style of the AIIANER repo posters, shown in both READMEs.
- Fix: mp-audio no longer names the Hermes env-file path in its text/error message (security scan `hermes_env_access` flagged both lines as CRITICAL and blocked the install).
- Docs: install prompt and START-HERE now cover scan-blocked skills (manual copy fallback), `hyperframes` "already installed" false positive, small install batches and `/reload-skills` being a chat command.
