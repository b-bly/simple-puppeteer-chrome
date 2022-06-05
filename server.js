const puppeteer = require("puppeteer");

async function run() {
  const browser = await puppeteer.launch({
    headless: true,
    args: [
      "--disable-gpu",
      "--disable-dev-shm-usage",
      "--disable-setuid-sandbox",
      "--no-sandbox",
    ],
  });

  const page = await browser.newPage();
  await page.goto("https://example.com");
  const h1 = await page.waitForSelector('h1')
  const val = await page.evaluate((el) => el.textContent, h1)
  console.log('text:')
  console.log(val)
  // const ss = await page.screenshot({ path: "/screenshot.png" });

  await page.close();
  await browser.close();
}

run()
