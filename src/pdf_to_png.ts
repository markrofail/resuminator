import path from "path"
import { pdfToPng } from "pdf-to-png-converter"

const ROOT_DIR = path.join(__dirname, "..")

pdfToPng(path.join(ROOT_DIR, "output/markrofail-cv.pdf"), {
    viewportScale: 2.0,
    outputFolder: path.join(ROOT_DIR, "output"),
})
