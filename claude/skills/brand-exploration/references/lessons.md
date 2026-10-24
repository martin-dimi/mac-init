# Lessons from run 1 (Dungeon Crawler, Oct 2026)

Run 1 is in `dungeon-crawler/branding/` (RESULTS.md has the scores). Outcome: 6 well-crafted, creative sites (v6 "Square One" clearly best), but they didn't capture what the user was hoping for. Causes and fixes:

## What went wrong
1. **Intent came from a single paragraph.** The brief was my reading of one message. Reference screenshots were lost from temp before agents saw them, so agents only got text descriptions. -> Fix: questionnaire up front, reference images saved as files and passed to every agent.
2. **Concept drift: "branding" turned into "interactive toys".** Directions were built on metaphors (a map, paperwork, a game show, audio) and builders spent their effort on demos (street renamers, dice, encounters, long signup sequences). Pages ran 8-17k px tall. -> Fix: the landing page is judged as a random visitor deciding whether to download. Interaction only where it sells the product. App screens must show how the app works. Keep pages tight (guideline: about 6-8 desktop screens).
3. **My rubric steered the result.** Conversion weighted 3x and "game in frame one" became the formula everyone converged on. The user never approved it. -> Fix: rubric built from intake answers.
4. **Judging wasn't neutral.** Raters were the designers of competing directions (same model, same taste). The new direction's director read every critique and was then judged by the critics. -> Fix: 5 target-audience personas judge blind, fresh instances per round, and all directions get a revision round before the final judging.
5. **Stills can't judge motion or sound.** -> Fix: `record.mjs` contact sheets.
6. **"Same agent" continuity was faked** (workflows can't resume agents, so each round was a fresh agent reading notes). -> Fix: Agent tool + SendMessage for designer/builder pairs.
7. **A subagent refused** because it saw the user's latest chat question plus the "answer questions only, don't code" rule. -> Fix: authorisation line at the top of every prompt.
8. **Laptop battery died** mid-run: 9 h stall. -> Fix: tell the user to plug in; caffeinate; STATE.md for recovery.

## What worked (keep)
- Deep primary-source research (books converted to text, verbatim quotes) gave the voice real depth.
- Distinct directions across many axes at once. Each one had a "designer persona" that later reviewed its own site.
- Designer review with screenshots + Playwright click-through + P0/P1/P2 lists, builder response files.
- Builder NOTES.md journals.
- Free asset packs from itch.io (headless Playwright download works) and hand-made pixel art over generated images.
- Rotating rating order across raters; computing weighted scores in code, not by the agent.
- Starting all preview servers myself before parallel rating so agents don't fight over ports.
- Learnings doc feeding a new direction - the new one won clearly.

## Run 1 numbers
~33 agent runs, ~11M subagent tokens. Research+directions ~1 h, 5 builds with one review round ~1 h 45, cross-rating + new direction + its build ~3 h (excluding the stall), final rating ~40 min.
