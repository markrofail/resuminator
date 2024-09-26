render:
	npm run generate:latex
	cd template && xelatex output.tex
	mv template/output.pdf "output/markrofail-cv.pdf"
	# rm template/output.*
