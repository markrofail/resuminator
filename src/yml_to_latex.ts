import ejs from "ejs"
import fs from "fs"
import path from "path"
import { parse } from "yaml"

const ROOT_DIR = path.join(__dirname, "..")

// function to escape LaTeX special characters
function escapeLatex(str: string): string {
    return str
        .replace(/\\/g, "\\textbackslash{}")
        .replace(/'/g, "’")
        .replace(/#/g, "\\#")
        .replace(/\$/g, "\\$")
        .replace(/%/g, "\\%")
        .replace(/\^/g, "\\^{}")
        .replace(/&/g, "\\&")
        .replace(/_/g, "\\_")
        .replace(/{/g, "\\{")
        .replace(/}/g, "\\}")
        .replace(/~/g, "\\~{}")
        .replace(/`/g, "\\`{}")
}

// function to recursively escape all strings in an object
function escapeObject(obj: any): any {
    if (typeof obj === "string") {
        return escapeLatex(obj)
    } else if (Array.isArray(obj)) {
        return obj.map(escapeObject)
    } else if (obj !== null && typeof obj === "object") {
        const newObj: any = {}
        for (const key in obj) {
            // keys are escaped too: skill group names are rendered as text
            newObj[escapeLatex(key)] = escapeObject(obj[key])
        }
        return newObj
    }
    return obj
}

// load data from YAML file
const dataFile = fs.readFileSync(path.join(ROOT_DIR, "src/data.yml"), "utf8")
let resumeData = parse(dataFile)

// apply LaTeX escaping to all strings in the data
resumeData = escapeObject(resumeData)

// render Latex file with data CV data
const templateFile = fs.readFileSync(path.join(ROOT_DIR, "template/template.tex"), "utf-8")
const output = ejs.render(templateFile, resumeData)

// write rendered Latex file
fs.writeFileSync(path.join(ROOT_DIR, "template/output.tex"), output, "utf-8")
