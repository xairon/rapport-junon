# Rapport de clôture JUNON — compilation
#
#   make          compile le PDF (latexmk gère les passes et la bibliographie)
#   make clean    supprime les fichiers intermédiaires
#   make cleanall supprime aussi le PDF

MAIN = main

.PHONY: all clean cleanall

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex preambule.tex bibliographie.bib $(wildcard chapitres/*.tex)
	latexmk -pdf -interaction=nonstopmode -halt-on-error $(MAIN).tex

clean:
	latexmk -c $(MAIN).tex
	rm -f $(MAIN).bbl $(MAIN).run.xml

cleanall: clean
	rm -f $(MAIN).pdf
