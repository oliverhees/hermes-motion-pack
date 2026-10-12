# Transitions — pick by energy, never repeat twice in a row

| name | energy | how |
|---|---|---|
| hard cut on beat | high | nothing; align to beat |
| mask wipe (L→R, diagonal, circle) | medium | clip-path tween 0.35 s power3.inOut |
| flash-through-white | high | `npx hyperframes add flash-through-white` (catalog) or 2-frame white overlay |
| push (whole stage slides, next one follows) | medium | both stages translateX, expo.inOut 0.5 s |
| zoom-through | high | hero scales to 8× with blur, next scene scales from 0.6 |
| morph | medium | shape/colour of hero becomes next scene's bg |
| light sweep | low | gradient mask crosses, next scene fades under it |
| curtain of lines | medium | 8 vertical bars scaleY with stagger 0.03 |

Catalog: `npx hyperframes catalog` lists shader transitions and blocks (`npx hyperframes add <name>`).
