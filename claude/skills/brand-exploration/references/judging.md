# Judging protocol (one audience-judge agent rates every site)

Setup (orchestrator): all sites already served, letters shuffled, the order rotated per judge. Judges get only letters + URLs, never direction names, docs, reviews or round numbers. Screenshot/recording output goes to `judging/roundK/_media/<judge>/<letter>/`.

Per site, in this order:
1. **Cold open:** `shot.mjs` on the judge's primary device size. Open ONLY the first slice. Write the 5-second test before looking further.
2. **Browse like the persona would:** run `record.mjs` on the primary device and open the contact sheet, then the remaining slices. Skimmers judge mostly from the contact sheet and first 3 slices, readers go through everything.
3. **Try it:** run the waitlist flow with a Playwright script (fill, submit, success state), plus the one main interactive thing if there is one. Note anything broken, slow or annoying.
4. **Check the other device** briefly (one shot of the hero + the app screens section).
5. Write the rating file (format in `rubric.md`) and move on. Don't revisit earlier sites after seeing later ones, except to fix calibration at the very end (note it if you do).

Rules: stay in persona, stay calibrated across sites (use the full range), don't start/stop/rebuild servers, close every browser you open. Return structured scores for all sites.
