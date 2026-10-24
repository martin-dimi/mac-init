// Record a page as a real visitor would see it: load, wait, scroll slowly to the bottom.
// Outputs <outDir>/<size>.webm plus <size>-sheet.png, a contact sheet of frames (1 per second, 4 columns)
// so an agent can "watch" motion by opening one image with Read.
// usage: node record.mjs <url> <outDir> [--size=desktop|mobile|both] [--seconds=30]
import { chromium } from 'playwright';
import { mkdirSync, renameSync, readdirSync, rmSync } from 'fs';
import { execSync } from 'child_process';
const [url, outDir] = process.argv.slice(2);
const opt = k => process.argv.find(a => a.startsWith(`--${k}=`))?.split('=')[1];
const which = opt('size') ?? 'both';
const seconds = +(opt('seconds') ?? 30);
if (!url || !outDir) { console.error('usage: node record.mjs <url> <outDir> [--size=desktop|mobile|both] [--seconds=30]'); process.exit(1); }
mkdirSync(outDir, { recursive: true });
const sizes = [['desktop', 1440, 900], ['mobile', 390, 844]].filter(([n]) => which === 'both' || which === n);
const browser = await chromium.launch({ channel: 'chrome' });
for (const [name, width, height] of sizes) {
  const tmp = `${outDir}/.rec-${name}`;
  const ctx = await browser.newContext({ viewport: { width, height }, isMobile: name === 'mobile', hasTouch: name === 'mobile', deviceScaleFactor: 1, recordVideo: { dir: tmp, size: { width, height } } });
  const page = await ctx.newPage();
  await page.goto(url, { waitUntil: 'networkidle' });
  await page.waitForTimeout(4000); // first impression: what loads and animates above the fold
  const total = await page.evaluate(() => document.documentElement.scrollHeight - innerHeight);
  const steps = Math.max(1, Math.round((seconds - 4) * 2));
  for (let i = 1; i <= steps; i++) { await page.evaluate(y => window.scrollTo(0, y), Math.round(total * i / steps)); await page.waitForTimeout(500); }
  await ctx.close();
  const vid = readdirSync(tmp).find(f => f.endsWith('.webm'));
  renameSync(`${tmp}/${vid}`, `${outDir}/${name}.webm`);
  rmSync(tmp, { recursive: true, force: true });
  const cols = 4, w = name === 'desktop' ? 480 : 195;
  execSync(`ffmpeg -v error -y -i "${outDir}/${name}.webm" -vf "fps=1,scale=${w}:-1,tile=${cols}x${Math.ceil(seconds / cols)}" -frames:v 1 "${outDir}/${name}-sheet.png"`);
  console.log(`${name}: ${outDir}/${name}.webm + ${name}-sheet.png`);
}
await browser.close();
