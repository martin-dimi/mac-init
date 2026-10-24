---
name: brand-exploration
description: Autonomous multi-agent brand + landing page exploration for a product. One questionnaire up front, then research, judge casting, N distinct brand directions, a landing page per direction (built, reviewed and revised by a designer/builder pair), blind judging by 5 target-audience personas, a learned new direction, a fair final judging round and a results page. Use when the user wants to explore branding/style directions, "create a few landing pages I can judge", or rerun this exercise.
---

# Brand exploration

Produce several genuinely different brand directions for a product, each expressed as a landing page a random visitor could judge ("would I download this?"), then let neutral target-audience judges decide. The user answers one questionnaire and is NOT in the loop after that. Work runs autonomously to the end.

Read `references/lessons.md` before starting - it's what went wrong last time.

## Deliverable

For each direction:
- A direction doc (brand system: name, voice, type, colour, art style, motion, sound, app UX, landing concept).
- A landing page that is expressive and bespoke (not SaaS, not a template), with a mocked but delightful waitlist flow, and that **shows how the app works on the phone with real in-brand app screens** (at least 3: home/main, the core interaction, a reward or result moment). A visitor must understand the product from the page alone.
- Judge ratings and feedback.

Plus `RESULTS.md`, a local results index page and a `serve-all.sh`.

## Agents

User-level agent definitions in `~/.claude/agents/` (model + effort set in frontmatter):

| Agent type | Effort | Role |
|---|---|---|
| `brand-researcher` | xhigh | Step 1 research |
| `brand-director` | xhigh | Judge casting, directions, learnings + new direction |
| `brand-designer` | xhigh | Owns one direction; reviews its landing page each round |
| `landing-builder` | high | Builds and revises one landing page |
| `audience-judge` | xhigh | Plays one target-audience persona; judges blind |

Agent definitions only load at session start. If an agent type is missing, use a Workflow `agent()` with `effort` set and paste the persona from the agent file into the prompt.

## Orchestration rules

- **Designer/builder pairs keep their context within a stage, then rotate.** Spawn them with the Agent tool (background) and continue them with SendMessage across the review rounds of one stage. Track agent IDs in `<out>/STATE.md`. Their contexts grow to 500k+ tokens after a few rounds, so at each stage boundary (after build+review, after judging) retire them and spawn fresh agents. The fresh ones read the files on disk: direction/game docs, NOTES.md, reviews/*, plus a short `HANDOFF.md` per variant. Never keep one agent alive across the whole run.
- **Stateless fan-out (research, judging) runs as a Workflow** with `agentType` and a `schema` for structured scores. Each judging round uses fresh judge instances so they carry no memory between rounds.
- **Every agent prompt starts with the authorisation line** from `references/prompts.md`. Without it, subagents that see "answer questions only" style rules in CLAUDE.md may refuse.
- Keep `<out>/STATE.md` updated after every step (step, agent IDs, ports, what's next) so the run survives a context clear or crash.
- Before starting: tell the user to keep the machine plugged in (a dead battery stalled run 1 for 9 hours), and run `nohup caffeinate -dims -t 86400 &`.
- When a background task finishes, check its output files exist and are non-empty before moving on. If an agent returned empty or refused, re-run it once with the reason addressed.

## Steps

Output folder `<out>` defaults to `<repo>/branding/` (rename an existing one to `branding-run1/` etc., never overwrite).

### 0. Intake (the only user touchpoint)
Ask the questionnaire in `references/questionnaire.md` in ONE message. Save answers verbatim to `<out>/intake/answers.md`. Copy every reference image or URL the user gives into `<out>/intake/refs/` (images as files, URLs as screenshots via `shot.mjs`) - agents must see real images, not descriptions. Write `<out>/BRIEF.md` from the answers + product docs, and `<out>/RUBRIC.md` from `references/rubric.md` adjusted by the answers. From here on, no more questions.

### 1. Research (1 `brand-researcher`)
Domain/IP research (primary sources if available, e.g. books on disk converted to text), fan and audience culture (Reddit etc.), competitors and adjacent products, best-in-class sites in the space (visit them). Output `research/research.md` (TL;DR for designers first) and raw quote dumps.

### 2. Cast the judges (1 `brand-director`)
Using research + intake, write `judges/judges.md`: 5 neutral personas who together cover the real target audience. Follow `references/judges.md`. They never see who made what.

### 3. Directions (1 `brand-director`)
Write N (default 5) distinct directions, `directions/dN-<slug>.md` + `directions/README.md` comparison table. Distinct on several axes at once (core idea, mood, type, palette, art treatment, layout logic, motion, voice). Each doc includes a style tile section (wordmark, palette, type, art sample spec, one in-brand UI component) and the app screens the landing page will show. At least one direction should push the user's stated taste somewhere unexpected but defensible.

### 4. Build + review loop (per direction: 1 `brand-designer` + 1 `landing-builder`, all directions in parallel)
1. Designer reads its direction doc and writes a build brief for its builder (priorities, must-haves, what would make it cringe).
2. Builder builds `sites/vN-<slug>/` on port `5100 + N*10` (see build rules in `references/prompts.md`).
3. Designer reviews: `shot.mjs` + `record.mjs` (motion), clicks through the waitlist and demos with Playwright, writes `reviews/vN/roundK-designer.md` with P0/P1/P2.
4. Builder fixes, writes `reviews/vN/roundK-response.md`.
5. Repeat for 2 review rounds (3 if the designer's provisional score is still under 7).

### 5. Blind judging, round 1 (Workflow: 5 `audience-judge`, fresh)
Start all sites yourself first (`serve-all.sh`) - judges must not start/stop servers. Give each site a neutral letter (A, B, C... shuffled, mapping kept in `STATE.md` only). Each judge rates every site in a rotated order following `references/judging.md`, writes `judging/round1/<judge>__<letter>.md`, returns structured scores. Compute averages in code.

### 6. Learn + new direction + revise the rest
- `brand-director` (fresh) writes `directions/learnings.md` from all judge feedback and builds a new direction `d(N+1)` that aims to beat all of them (may merge ideas).
- New designer/builder pair runs the step 4 loop for it.
- In parallel, every existing designer/builder pair gets ONE more round driven by its own judge feedback (SendMessage to the same agents). This keeps the final round fair.

### 7. Final blind judging (Workflow: 5 `audience-judge`, fresh instances, new shuffled letters)
Same protocol as step 5, all sites including the new one. These are the scores that count. Round 1 scores are reported as "before".

### 8. Results
`RESULTS.md` (ranking table with final weighted score, "would join" rate, per-criterion averages, per-judge matrix, round 1 vs final, one paragraph per site with best thing / biggest problem / judge quotes, notes on the run including failures and token totals). `_results/index.html` with hero desktop + mobile shots, scores and links. `serve-all.sh`. Leave all servers running and give the user the URLs. Don't commit; offer to publish as private artifacts in one line.

## Tools (`scripts/`, deps installed; run with node from that folder or copy it to `<out>/_tools/`)
- `shot.mjs <url> <outDir>` - desktop 1440x900 + mobile 390x844, viewport slices while scrolling + full page, prints console errors.
- `record.mjs <url> <outDir> [--size=both] [--seconds=30]` - records a visitor's scroll as .webm and a 1-frame-per-second contact sheet PNG, so an agent can see motion by opening one image.
- `itch-download.mjs <itch page> <outDir> [--all]` - downloads a free itch.io asset pack and prints its info panel (check the licence).
- Interaction tests: small Playwright scripts, `chromium.launch({ channel: 'chrome' })`, importing from `scripts/node_modules/playwright`.

## Budget defaults (override from intake)
Opus for all agents. No paid voice APIs (macOS `say` + ffmpeg as stand-in). Gemini images max ~5 per site, mood only. Free assets: itch.io, Google Fonts/fontsource, user-provided packs (copy them into `<out>/assets/` with a README).
