#!/usr/bin/env bash
# Verification du rapport. Sortie non nulle si un controle echoue.
cd "$(dirname "$0")"
ok=0
latexmk -pdf -interaction=nonstopmode main.tex >/dev/null 2>&1 || { echo "ECHEC compilation"; ok=1; }
e=$(grep -c '^!' main.log);            [ "$e" -eq 0 ] || { echo "ECHEC $e erreur(s) LaTeX"; ok=1; }
u=$(grep -i 'undefined' main.log | grep -vc 'Font shape');    [ "$u" -eq 0 ] || { echo "ECHEC $u reference(s) non resolue(s)"; ok=1; }
q=$(pdftotext main.pdf - 2>/dev/null | grep -c '??'); [ "$q" -eq 0 ] || { echo "ECHEC $q renvoi(s) ?? dans le PDF"; ok=1; }
d=$(grep -o '—' chapitres/*.tex | wc -l); [ "$d" -eq 0 ] || { echo "ECHEC $d tiret(s) cadratin"; ok=1; }
t=$(grep -h '^\\paragraph' chapitres/*.tex | wc -l); [ "$t" -eq 0 ] || { echo "ECHEC $t titre(s) courant(s)"; ok=1; }
b=$(grep -ci 'WARN' main.blg);         [ "$b" -eq 0 ] || { echo "ECHEC $b avertissement(s) biber"; ok=1; }
o=$(grep -c 'Overfull\|Underfull' main.log); [ "$o" -eq 0 ] || { echo "ECHEC $o boite(s) mal remplie(s)"; ok=1; }
# tout tableau est un flottant legende : autant de table[H] que de tabular
nt=$(grep -o 'begin{tabular' chapitres/*.tex | wc -l)
nf=$(grep -o 'begin{table}' chapitres/*.tex | wc -l)
[ "$nt" -eq "$nf" ] || { echo "ECHEC $nt tableau(x) pour $nf flottant(s) : un tableau sans legende"; ok=1; }
# toute entree bibliographique est citee, et reciproquement
nd=$(grep -c '^@' bibliographie.bib)
nc=$(grep -o 'Found [0-9]* citekeys' main.blg | grep -o '[0-9]*')
[ "$nd" = "$nc" ] || { echo "ECHEC $nd entree(s) bib pour $nc citee(s)"; ok=1; }
[ "$ok" -eq 0 ] && echo "OK  $(pdfinfo main.pdf | awk '/Pages/{print $2}') pages, $(wc -w chapitres/*.tex | tail -1 | awk '{print $1}') mots, $nf tableaux, $nd references"
exit $ok
