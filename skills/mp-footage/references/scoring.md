# Scoring footage

| Score | How (scan.py) | Good for |
|---|---|---|
| motion | mean abs frame difference per second (ffmpeg `tblend=difference` + `signalstats`) | action, gameplay, sports |
| loudness | momentary loudness per second (ebur128), relative | reactions, crowd, hits |
| speech | 300–3000 Hz band energy vs full band per second (rough voice detector) | talking moments, quotes |
| cuts | scene-change probability (`select=gt(scene,T)`) → shot boundaries | respecting existing edits |

Total = weighted sum; weights by intent:
- action: motion .5 · loudness .4 · speech .1
- emotion: motion .2 · loudness .3 · speech .5
- recap: motion .35 · loudness .35 · speech .3, then pick top moments spread across the whole timeline

Thresholds: scene T = 0.3 default; 0.15 for slow vlogs, 0.45 for fast gameplay. Top moments = local maxima of total, min 4 s apart.
