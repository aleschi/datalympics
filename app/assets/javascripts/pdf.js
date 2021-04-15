var createPdf = async() => {
 // module.paths.push(process.argv[4]);
 // var puppeteer = require('puppeteer');
  let browser;
  try {
    browser = await puppeteer.launch({headless: false, args: ['--no-sandbox', '--disable-setuid-sandbox']});
    var page = await browser.newPage();
    await page.goto('http://localhost:3000/reporting', {
      timeout: 10000, 
      waitUntil: 'networkidle2'
    });
    await page.waitFor(250);
    await page.waitForNavigation({waitUntil: 'load'});
    await page.addStyleTag({path: 'application.scss'})
    await page.addStyleTag({url: 'https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css'})
    //await page.setViewport({width: 1000, height: 2950, deviceScaleFactor: 2});
    await page.pdf({
      path: 'http://localhost:3000/reporting',
      format: 'A4',
      padding: { top: 0, right: 0, bottom: 0, left: 0 },
      margin: { top: 0, right: 0, bottom: 0, left: 0 },
      printBackground: true
    });
  } catch (err) {
      console.log(err.message);
  } finally {
    if (browser) {
      browser.close();
    }
    //process.exit();
  }
};
createPdf();