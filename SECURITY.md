# Security Policy / Sicherheitsrichtlinie

**🇬🇧 English** · [🇩🇪 Deutsch](#-deutsch)

## Supported versions

| Version | Supported |
| --- | --- |
| Latest release on `main` | ✅ |
| Older versions | ❌ |

## Reporting a vulnerability

Please do **not** report vulnerabilities through public GitHub issues.

1. Email **hi@aiianer.de** with the subject `[SECURITY] hermes-motion-pack`.
2. Describe the issue as precisely as possible: affected skill/script, steps to reproduce, possible impact.
3. You'll get a first response within **72 hours**.

**Especially relevant for this project:** anything that makes a script **leak an API key**
(ElevenLabs, kie.ai) into files, logs or chat, anything that **uploads a user's footage**
anywhere (everything is designed to stay local), command injection through file names or
prompt text passed to ffmpeg, and prompt-injection paths through `SKILL.md`/reference files.

**We commit to:** confirming receipt and keeping you updated, fixing confirmed issues with
priority, crediting you in the release notes if you wish, and no legal action against
good-faith security research (responsible disclosure).

**Please don't:** publish the issue before a fix is released, access third-party data, or
test systems beyond what's necessary.

---

## 🇩🇪 Deutsch

### Unterstützte Versionen

| Version | Unterstützt |
| --- | --- |
| Letztes Release auf `main` | ✅ |
| Ältere Versionen | ❌ |

### Sicherheitslücke melden

Bitte **keine** öffentlichen GitHub-Issues für Sicherheitslücken.

1. Mail an **hi@aiianer.de** mit Betreff `[SECURITY] hermes-motion-pack`.
2. Beschreibe das Problem so genau wie möglich: betroffener Skill/Script, Schritte zum Nachstellen, mögliche Auswirkung.
3. Erste Antwort innerhalb von **72 Stunden**.

**Besonders relevant:** alles, was einen **API-Key** (ElevenLabs, kie.ai) in Dateien, Logs oder
Chat bringt, alles, was **Footage eines Nutzers hochlädt** (alles bleibt per Design lokal),
Command-Injection über Dateinamen oder Prompt-Text an ffmpeg, Prompt-Injection über
`SKILL.md`/Referenzdateien.
