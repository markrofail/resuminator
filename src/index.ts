import ejs from "ejs"
import fs from "fs"
import path from "path"
import { parse } from "yaml"

const ROOT_DIR = path.join(__dirname, "..")

// load data from YAML file
const dataFile = fs.readFileSync(path.join(ROOT_DIR, "src/data.yml"), "utf8")
const resumeData = parse(dataFile)

// render Latex file with data CV data
const templateFile = fs.readFileSync(path.join(ROOT_DIR, "template/template.tex"), "utf-8")
const output = ejs.render(templateFile, resumeData)

// write rendered Latex file
fs.writeFileSync(path.join(ROOT_DIR, "template/output.tex"), output, "utf-8")
