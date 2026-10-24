// Download a free itch.io asset pack (first upload, or all with --all).
// usage: node itch-download.mjs <itch page url> <outDir> [--all]
import { chromium } from 'playwright';
import { mkdirSync } from 'fs';
const [url, outDir] = process.argv.slice(2);
const all = process.argv.includes('--all');
mkdirSync(outDir, { recursive: true });
const browser = await chromium.launch({ channel: 'chrome' });
const ctx = await browser.newContext({ acceptDownloads: true });
const page = await ctx.newPage();
await page.goto(url, { waitUntil: 'networkidle' });
const license = await page.locator('.game_info_panel_widget').innerText().catch(() => '');
console.log('INFO PANEL:\n' + license.slice(0, 800));
await page.locator('a.buy_btn, a.download_btn').first().click();
const noThanks = page.locator('a.direct_download_btn');
try { await noThanks.waitFor({ state: 'visible', timeout: 8000 }); await noThanks.click(); await page.waitForLoadState('networkidle'); } catch {}
await page.waitForTimeout(1500);
const btns = page.locator('a.download_btn');
const n = await btns.count();
console.log('download buttons:', n);
for (let i = 0; i < (all ? n : Math.min(n, 1)); i++) {
  const [dl] = await Promise.all([page.waitForEvent('download', { timeout: 60000 }), btns.nth(i).click()]);
  await dl.saveAs(`${outDir}/${dl.suggestedFilename()}`);
  console.log('saved', `${outDir}/${dl.suggestedFilename()}`);
}
await browser.close();
