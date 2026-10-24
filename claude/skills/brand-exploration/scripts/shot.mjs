// Screenshot a page at desktop + mobile, full page plus viewport slices down the page.
// usage: node shot.mjs <url> <outDir> [--wait=ms]
import { chromium } from 'playwright';
import { mkdirSync } from 'fs';
const [url, outDir] = process.argv.slice(2);
const wait = +(process.argv.find(a => a.startsWith('--wait='))?.split('=')[1] ?? 1500);
if (!url || !outDir) { console.error('usage: node shot.mjs <url> <outDir> [--wait=ms]'); process.exit(1); }
mkdirSync(outDir, { recursive: true });
const browser = await chromium.launch({ channel: 'chrome' });
const sizes = [['desktop', 1440, 900, 1], ['mobile', 390, 844, 3]];
for (const [name, width, height, dpr] of sizes) {
  const ctx = await browser.newContext({ viewport: { width, height }, deviceScaleFactor: name === 'mobile' ? 2 : 1, isMobile: name === 'mobile', hasTouch: name === 'mobile' });
  const page = await ctx.newPage();
  const errors = [];
  page.on('pageerror', e => errors.push(String(e)));
  page.on('console', m => m.type() === 'error' && errors.push(m.text()));
  await page.goto(url, { waitUntil: 'networkidle' });
  await page.waitForTimeout(wait);
  // scroll through to trigger scroll-based animations, saving a viewport slice each step
  const total = await page.evaluate(() => document.documentElement.scrollHeight);
  let i = 0;
  for (let y = 0; y < total && i < 30; y += height, i++) {
    await page.evaluate(y => window.scrollTo(0, y), y);
    await page.waitForTimeout(700);
    await page.screenshot({ path: `${outDir}/${name}-${String(i).padStart(2, '0')}.png` });
  }
  await page.evaluate(() => window.scrollTo(0, 0));
  await page.waitForTimeout(500);
  await page.screenshot({ path: `${outDir}/${name}-full.png`, fullPage: true });
  console.log(`${name}: ${i} slices, height ${total}px, errors: ${errors.length ? errors.join(' | ') : 'none'}`);
  await ctx.close();
}
await browser.close();
