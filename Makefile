# Dépôt JUNON — compilation des deux documents
#
#   make          compile tous les PDF
#   make main     rapport de clôture (main.pdf)
#   make st32     livrable ST3.2 (st32/st32.pdf)
#   make slides   les deux jeux de diapositives
#   make vues     régénère figures/vues/ depuis les captures d'origine
#   make clean    supprime les fichiers intermédiaires
#   make cleanall supprime aussi les PDF
#
# latexmk enchaîne les passes et appelle biber. L'option -cd le fait travailler
# dans le répertoire du document, ce dont st32 a besoin pour résoudre
# ../bibliographie.bib.

MAIN  = main
ST32  = st32/st32
COURT = slides/court
LONG  = slides/long
VUES  = $(wildcard figures/vues/*.png)

.PHONY: all main st32 slides vues clean cleanall

all: main st32 slides

main: $(MAIN).pdf
st32: $(ST32).pdf
slides: $(COURT).pdf $(LONG).pdf

$(MAIN).pdf: $(MAIN).tex preambule.tex bibliographie.bib $(wildcard chapitres/*.tex) $(VUES)
	latexmk -pdf -interaction=nonstopmode -halt-on-error $(MAIN).tex

$(ST32).pdf: $(ST32).tex st32/preambule.tex st32/references.bib bibliographie.bib $(wildcard st32/sections/*.tex)
	latexmk -cd -pdf -interaction=nonstopmode -halt-on-error $(ST32).tex

# Les diapositives partagent leur préambule, les vues et les logos ; pas de
# bibliographie.
$(COURT).pdf: $(COURT).tex slides/preambule.tex $(VUES)
	latexmk -cd -pdf -interaction=nonstopmode -halt-on-error $(COURT).tex

$(LONG).pdf: $(LONG).tex slides/preambule.tex $(VUES)
	latexmk -cd -pdf -interaction=nonstopmode -halt-on-error $(LONG).tex

# Les vues sont dérivées des captures d'origine, qui ne sont jamais modifiées.
# Une fenêtre de 3840 px reproduite en entier a un texte d'interface d'environ
# 1 mm : figures/recadrer.sh cadre la zone qui porte le propos.
vues:
	./figures/recadrer.sh

clean:
	latexmk -c $(MAIN).tex
	latexmk -cd -c $(ST32).tex
	latexmk -cd -c $(COURT).tex
	latexmk -cd -c $(LONG).tex
	rm -f $(MAIN).bbl $(MAIN).run.xml $(ST32).bbl $(ST32).run.xml

cleanall: clean
	rm -f $(MAIN).pdf $(ST32).pdf $(COURT).pdf $(LONG).pdf
