import { chromium } from "playwright";
import { fileURLToPath, pathToFileURL } from "node:url";
import path from "node:path";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const appRoot = path.resolve(__dirname, "..");
const evidenceHtml = path.join(appRoot, "evidence", "evidence-board.html");
const evidenceUrl = pathToFileURL(evidenceHtml).href;

const captures = [
  ["figma1", "figma-evidence1.png", { width: 2040, height: 850 }],
  ["figma2", "figma-evidence2.png", { width: 1660, height: 850 }],
  ["signup", "signup_screen_evidence.png", { width: 432, height: 820 }],
  ["signupError", "signup_error.png", { width: 432, height: 820 }],
  ["login", "login_screen_evidence.png", { width: 432, height: 820 }],
  ["loginError", "login_error.png", { width: 432, height: 820 }],
  ["home", "home-screen-evidence.png", { width: 432, height: 820 }],
  ["detailNav", "evidence-detail-navigation.png", { width: 432, height: 820 }],
  ["detail", "evidence-detail-screen.png", { width: 432, height: 820 }],
  ["persistence", "evidence-persistence.png", { width: 432, height: 820 }],
  ["integratedPersistence", "evidence-integrateScreen-persistence.png", { width: 432, height: 820 }],
  ["api", "evidence-api-ux.png", { width: 432, height: 820 }],
  ["menuIcon", "evidence-menu-icon.png", { width: 432, height: 820 }],
  ["menuItems", "evidence-menu-items.png", { width: 432, height: 820 }],
  ["settings", "evidence-settings-screen.png", { width: 432, height: 820 }],
  ["notificationConfigure", "evidence-notification-configure.png", { width: 432, height: 820 }],
  ["notificationAlert", "evidence-notification-alert.png", { width: 432, height: 820 }]
];

const browser = await chromium.launch();
const page = await browser.newPage();

for (const [view, filename, viewport] of captures) {
  await page.setViewportSize(viewport);
  await page.goto(`${evidenceUrl}?view=${view}`);
  await page.screenshot({
    path: path.join(appRoot, "evidence", filename),
    fullPage: true
  });
}

await browser.close();
console.log(`Captured ${captures.length} evidence screenshots.`);
