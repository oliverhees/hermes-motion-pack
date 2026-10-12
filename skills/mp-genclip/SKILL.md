---
name: mp-genclip
description: Generates AI video clips (Seedance, Veo, Kling via the kie.ai MCP server) and AI still frames (gpt-image, nano-banana) as the basis for cinematic highlight videos and trailers — shot-by-shot prompts from the storyboard, consistent look via reference frames and seeds, download, registration in SHOTLIST.json. Use when the user has no footage but wants cinematic shots, says "generier mir Clips", "KI-Video", "Seedance", "Veo", "B-Roll erzeugen", or when mp-highlight needs shots that do not exist.
version: 0.2.1
author: Oliver Hees aka Aiianer
metadata:
  hermes:
    tags: [video, ai-video, kie-ai, seedance, veo]
    category: motion
---

# mp-genclip — manufacture the shots

Needs the **kie.ai MCP server** (https://github.com/oliverhees/kie-ai-mcp-server) connected in Hermes (`hermes mcp add`). The kie.ai key lives on that server, never in this skill. Never write a key into a file, log, prompt or answer.

## Steps
1. Read `STORYBOARD.md` (or `SHOTLIST.json` gaps). For every missing shot write a **shot card**: duration (4–8 s native, you will trim), framing (wide/medium/close), camera move (push, orbit, handheld, static), subject + action, light, mood, style anchor. See `references/shot-prompting.md`.
2. **Look lock first:** generate 1 style frame per world (image model), get user OK, then use it as the image reference for every clip so all shots share colour, lens and light. Keep a fixed seed where the model supports it.
3. Discover the tools: list the kie.ai MCP tools in this session (names seen in the past: `bytedance_seedance_video`, `veo3_video`, `kling_video`, `gpt_image_2`, `nano_banana_image` — **re-check with tool discovery, names change**). No kie.ai MCP connected → stop and tell the user to connect it (https://github.com/oliverhees/kie-ai-mcp-server); do not call REST endpoints yourself.
4. Generate in batches of 3–4 shots, poll, download to `genclips/<id>_v<n>.mp4`. Register each in `SHOTLIST.json` with `prompt`, `model`, `seed`, `cost`.
5. Review: `mp-footage/scripts/peek.sh` strip per clip. Reject: morphing faces, text artefacts, wrong aspect, drifting style. Regenerate at most twice per shot, then change the shot (different framing solves most failures).
6. Hand off to `mp-highlight`.

## Rules
- Generate 9:16 natively for reels; do not crop 16:9 generations.
- Keep prompts under 80 words; one subject, one action, one camera move, one light. Lists of adjectives produce mush.
- Humans: avoid close-up faces unless the model is proven on them; prefer silhouettes, hands, backs, crowds, product macro.
- Logos/UI are never generated — they are composited in `mp-highlight` from real assets.
- Mute generated audio; sound comes from `mp-audio`.
- Track cost per clip; show the total at the gate.

## Files in this skill
- `references/shot-prompting.md`
