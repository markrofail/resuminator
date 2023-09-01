import ejs from "ejs"
import fs from "fs"
import path from "path"
import { parse } from "yaml"

const YAML_DATA_PATH = path.join(__dirname, "data.yml")
const LATEX_DIR = path.join(__dirname, "..", "template")
const LATEX_TEMPLATE_PATH = path.join(LATEX_DIR, "template.tex")
const LATEX_OUTPUT_PATH = path.join(LATEX_DIR, "output.tex")

// load data from YAML file
const dataFile = fs.readFileSync(YAML_DATA_PATH, "utf8")
const resumeData = parse(dataFile)

// render Latex file with data CV data
const templateFile = fs.readFileSync(LATEX_TEMPLATE_PATH, "utf-8")
const output = ejs.render(templateFile, resumeData)

// write rendered Latex file
fs.writeFileSync(LATEX_OUTPUT_PATH, output, "utf-8")
