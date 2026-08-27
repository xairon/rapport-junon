# Dépôt JUNON — compilation des deux documents
#
#   make          compile les deux PDF
#   make main     rapport de clôture (main.pdf)
#   make st32     livrable ST3.2 (st32/st32.pdf)
#   make clean    supprime les fichiers intermédiaires
#   make cleanall supprime aussi les PDF
#
# latexmk enchaîne les passes et appelle biber. L'option -cd le fait travailler
# dans le répertoire du document, ce dont st32 a besoin pour résoudre
# ../bibliographie.bib.

MAIN = main
ST32 = st32/st32

.PHONY: all main st32 clean cleanall

all: main st32

main: $(MAIN).pdf
st32: $(ST32).pdf

$(MAIN).pdf: $(MAIN).tex preambule.tex bibliographie.bib $(wildcard chapitres/*.tex)
	latexmk -pdf -interaction=nonstopmode -halt-on-error $(MAIN).tex

$(ST32).pdf: $(ST32).tex st32/preambule.tex st32/references.bib bibliographie.bib $(wildcard st32/sections/*.tex)
	latexmk -cd -pdf -interaction=nonstopmode -halt-on-error $(ST32).tex

clean:
	latexmk -c $(MAIN).tex
	latexmk -cd -c $(ST32).tex
	rm -f $(MAIN).bbl $(MAIN).run.xml $(ST32).bbl $(ST32).run.xml

cleanall: clean
	rm -f $(MAIN).pdf $(ST32).pdf
