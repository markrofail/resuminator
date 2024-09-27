import fs from "fs"
import path from "path"
import { pdfToPng } from "pdf-to-png-converter"

const ROOT_DIR = path.join(__dirname, "..")

fs.readdirSync(path.join(ROOT_DIR, "output")).forEach(async (file) => {
    if (!file.endsWith(".pdf")) return

    const [pngFile] = await pdfToPng(path.join(ROOT_DIR, "output", file), { viewportScale: 2.0 })
    fs.writeFileSync(path.join(ROOT_DIR, "output/preview.png"), pngFile.content)
})
