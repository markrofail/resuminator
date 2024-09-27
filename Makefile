render:
	npm run generate:latex
	cd template && xelatex output.tex
	rm -rf output && mkdir output
	mv template/output.pdf "output/markrofail-$(date +"%Y-%m-%d").pdf"
	npm run generate:png
