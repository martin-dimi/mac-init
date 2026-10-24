# Prompt building blocks

Fill `<...>`. Keep prompts self-contained: subagents get CLAUDE.md automatically, but not this conversation.

## Authorisation line (top of EVERY prompt)
> This is approved autonomous work. The user commissioned this brand exploration, answered the intake questionnaire and asked for it to run to the end without check-ins. Don't stop to ask questions or wait for a "go". Rules about answering questions without coding don't apply to this task. Make sensible calls and note them in your output.

## Shared context block
> Read `<out>/BRIEF.md` first, then `<out>/intake/answers.md`, and look at every image in `<out>/intake/refs/` with Read. Research is in `<out>/research/research.md`. Shared assets are in `<out>/assets/` (README). Tools are in `<skill>/scripts/`: `shot.mjs` (screenshots), `record.mjs` (motion contact sheet), `itch-download.mjs` (free assets). For interaction tests, write Playwright scripts importing from `<skill>/scripts/node_modules/playwright` with `chromium.launch({ channel: 'chrome' })`. Budget: <from intake>. Writing style: <from intake / CLAUDE.md>.

## Builder build rules (append to builder prompts)
- Folder `<out>/sites/vN-<slug>/`, port `<5100+N*10>`. Scaffold with an official CLI/template if you use a framework, then clean it up. Full freedom over the stack (Vite, Astro, plain HTML, React, GSAP, Motion, canvas, WebGL...).
- `npm run dev`, `npm run build` (static `dist/`, relative paths), `npm run preview` on the port. `README.md` with run steps and every third-party asset with its source and licence. Keep `NOTES.md` as a working journal.
- The page is for a random visitor deciding whether to get the app. It must be expressive and unmistakably this direction, never SaaS or template-like. It must show how the app works on the phone with at least 3 in-brand app screens. The waitlist is mocked but complete (validation, success state, in-world payoff). Interaction only where it sells the product. Aim for about 6-8 desktop screens.
- Verify visually: `shot.mjs` + `record.mjs`, look at every image, fix, repeat. Test the waitlist with Playwright on desktop and mobile. No console errors in the built `dist/`.
- Stop any server you started on your port before you finish.
- Final answer: under 150 words.

## Designer review (SendMessage to the same designer each round)
> Round <K> review of your direction's landing page at `<site dir>`. Builder says: <summary>. Build + preview on port <P> (background), then `shot.mjs`, `record.mjs` and Playwright click-through (waitlist + main demo, desktop + mobile). Judge it as a random visitor deciding to download AND against your direction doc. Write `<out>/reviews/vN/round<K>-designer.md`: what must be kept, P0/P1/P2 fixes (section, problem, exact fix, why) and a provisional score from `<out>/RUBRIC.md`. Stop the server. Final answer: the top 10 changes in under 250 words.

## Builder revision (SendMessage to the same builder)
> Round <K> feedback from your designer: `<out>/reviews/vN/round<K>-designer.md`. Summary: <...>. Fix all P0/P1 and the P2s worth doing. If you disagree with a point, say why rather than skipping it silently. Go beyond the list if you see improvements. Re-verify visually and re-test the waitlist. Write `<out>/reviews/vN/round<K>-response.md`, update NOTES.md. Final answer under 150 words.

## Judge structured output schema
```js
{ type: 'object', properties: { ratings: { type: 'array', items: { type: 'object', properties: {
  site: { type: 'string' }, join: { type: 'string', enum: ['yes', 'maybe', 'no'] }, likelihood: { type: 'integer', minimum: 0, maximum: 10 },
  want: { type: 'integer', minimum: 1, maximum: 10 }, clarity: { type: 'integer', minimum: 1, maximum: 10 }, vibe: { type: 'integer', minimum: 1, maximum: 10 },
  distinct: { type: 'integer', minimum: 1, maximum: 10 }, trust: { type: 'integer', minimum: 1, maximum: 10 }, ease: { type: 'integer', minimum: 1, maximum: 10 },
  fiveSecond: { type: 'string' }, hooked: { type: 'string' }, lost: { type: 'string' }, quote: { type: 'string' } },
  required: ['site', 'join', 'likelihood', 'want', 'clarity', 'vibe', 'distinct', 'trust', 'ease', 'fiveSecond', 'hooked', 'lost', 'quote'] } } }, required: ['ratings'] }
```
Compute weighted scores and averages in workflow code. Also parse the JSON block in each rating file as a fallback if an agent returns empty.

## Serving all sites (orchestrator, before judging)
For each site: `npm run build`, then `nohup npx -y serve -s dist -l <port> &`. Poll until every port returns 200. Write the same loop into `<out>/serve-all.sh` (plus `_results/` on port 5100).
