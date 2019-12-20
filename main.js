const puppeteer = require('puppeteer-core')

async function main() {
    const browser = await puppeteer.launch({
        headless: false,
        args: [
            '--use-fake-device-for-media-stream',
            '--use-fake-ui-for-media-stream',
            '--allow-hidden-media-playback',
            '--no-sandbox',
        ],
        executablePath: '/usr/bin/google-chrome'
    })
    const page = await browser.newPage()
    console.log('open web page')
    await page.goto('https://github.com/')
    loadLogger(page)
    // TODO: logic

    setInterval(() => { // keep node alive
        console.log(`${new Date()}: alive`)
    }, 10*60*1000)
}

main()

function loadLogger(page) {
    page.on('console', async msg => {
        const args = await msg.args()
        args.forEach(async (arg) => {
            const val = await arg.jsonValue()
            // value is serializable
            if (JSON.stringify(val) !== JSON.stringify({})) console.log(val)
            // value is unserializable (or an empty oject)
            else {
                const { type, subtype, description } = arg._remoteObject
                console.log(`type: ${type}, subtype: ${subtype}, description:\n ${description}`)
            }
        })
    });
}