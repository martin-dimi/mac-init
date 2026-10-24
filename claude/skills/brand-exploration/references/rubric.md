# Default rubric (adjust weights from intake, then freeze in `<out>/RUBRIC.md`)

Judges answer as their persona, not as designers.

## Headline numbers
- **Would join/download** (yes / maybe / no) plus **likelihood 0-10**. This is the main ranking signal.
- **5-second test** (from the first screenshot only, before scrolling): what do you think this is? Was it right? Does it make you want to scroll?

## Scored criteria (1-10 integers; 5 = forgettable, 8 = I'd tell a friend, 10 = best I've seen)
| Key | Criterion | Default weight | Question the judge answers |
|---|---|---|---|
| `want` | Desire | 3 | Do I want this in my life after browsing? |
| `clarity` | Understanding | 2 | Do I understand what the app is and how it works on my phone (from the screens shown)? |
| `vibe` | Fit to source/genre | 1.5 | Does it feel like the thing I love (or the genre it promises)? |
| `distinct` | Memorable | 1.5 | Would I recognise it again? Is it unlike other apps? |
| `trust` | Trust & craft | 1.5 | Does it feel made by people who care, not a cheap or AI-made cash grab? |
| `ease` | Page experience | 1 | Is it easy on my device, fast, readable, not annoying? Does signing up feel good? |

Weighted score = sum(score x weight) / sum(weights), computed in code.

## Rating file format (`judging/roundK/<judge>__<letter>.md`)
```
# <judge> on <letter>
## 5-second test
## Scores
{"judge":"J1","site":"C","join":"maybe","likelihood":6,"want":7,"clarity":8,"vibe":6,"distinct":7,"trust":8,"ease":7}
## What hooked me
## What lost me
## What would make me join
## In my own words (2-3 sentences, as I'd tell a friend)
```
