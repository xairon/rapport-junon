#!/usr/bin/env bash
# Verification du livrable ST3.2. Sortie non nulle si un controle echoue.
#
# Les controles de style propres au rapport de cloture (pas de tiret cadratin,
# pas de \paragraph en tete de paragraphe) ne s'appliquent PAS ici : le ST3.2
# suit le gabarit fourni par N. Labroche, qui emploie les deux.
cd "$(dirname "$0")/st32"
ok=0
latexmk -pdf -interaction=nonstopmode st32.tex >/dev/null 2>&1 || { echo "ECHEC compilation"; ok=1; }
e=$(grep -c '^!' st32.log);            [ "$e" -eq 0 ] || { echo "ECHEC $e erreur(s) LaTeX"; ok=1; }
u=$(grep -i 'undefined' st32.log | grep -vc 'Font shape'); [ "$u" -eq 0 ] || { echo "ECHEC $u reference(s) non resolue(s)"; ok=1; }
q=$(pdftotext st32.pdf - 2>/dev/null | grep -c '??'); [ "$q" -eq 0 ] || { echo "ECHEC $q renvoi(s) ?? dans le PDF"; ok=1; }
b=$(grep -ci 'WARN' st32.blg);         [ "$b" -eq 0 ] || { echo "ECHEC $b avertissement(s) biber"; ok=1; }
o=$(grep -c 'Overfull\|Underfull' st32.log); [ "$o" -eq 0 ] || { echo "ECHEC $o boite(s) mal remplie(s)"; ok=1; }
# tout tableau est un flottant legende
nt=$(grep -o 'begin{tabular' sections/*.tex | wc -l)
nf=$(grep -o 'begin{table}' sections/*.tex | wc -l)
[ "$nt" -eq "$nf" ] || { echo "ECHEC $nt tableau(x) pour $nf flottant(s) : un tableau sans legende"; ok=1; }
# aucune cle en double entre les deux fichiers .bib, et toute entree propre est citee
d=$(comm -12 <(grep -o '^@[a-zA-Z]*{[^,]*' references.bib | sed 's/.*{//' | sort) \
             <(grep -o '^@[a-zA-Z]*{[^,]*' ../bibliographie.bib | sed 's/.*{//' | sort) | wc -l)
[ "$d" -eq 0 ] || { echo "ECHEC $d cle(s) bib en double entre references.bib et bibliographie.bib"; ok=1; }
nd=$(grep -c '^@' references.bib)
nu=$(for k in $(grep -o '^@[a-zA-Z]*{[^,]*' references.bib | sed 's/.*{//'); do
       grep -qF "$k" sections/*.tex || echo "$k"; done | wc -l)
[ "$nu" -eq 0 ] || { echo "ECHEC $nu entree(s) de references.bib non citee(s)"; ok=1; }
[ "$ok" -eq 0 ] && echo "OK  $(pdfinfo st32.pdf | awk '/Pages/{print $2}') pages, $(wc -w sections/*.tex | tail -1 | awk '{print $1}') mots, $nf tableaux, $nd references propres"
exit $ok
