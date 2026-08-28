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
# toute figure est legendee et etiquetee : autant de \caption et de \label que
# de \begin{figure}, sans quoi une figure n'est ni numerotable ni citable
ng=$(grep -o 'begin{figure}' chapitres/*.tex | wc -l)
ncap=$(grep -o '\\caption{' chapitres/*.tex | wc -l)
[ "$ncap" -ge "$ng" ] || { echo "ECHEC $ng figure(s) pour $ncap legende(s)"; ok=1; }
# Les images incluses sont lues dans le .fls, non devinees dans les .tex.
# Aucune capture d'origine n'est reproduite telle quelle : une fenetre de
# 3840 px sur la largeur d'une page a un texte d'interface d'environ 1 mm.
images=$(awk '/^INPUT .*\.png$/{print $2}' main.fls | sed 's|^\./||' | sort -u)
brut=$(echo "$images" | grep -c '^figures/[a-z0-9-]*\.png$')
logos=$(echo "$images" | grep -c '^figures/logo-')
[ "$brut" -eq "$logos" ] || {
  echo "ECHEC capture d'origine incluse hors figures/vues/ :"
  echo "$images" | grep '^figures/[a-z0-9-]*\.png$' | grep -v 'logo-' | sed 's/^/       /'
  ok=1; }
# toute vue employee est derivable des originaux par figures/recadrer.sh
nv=0
for v in $(echo "$images" | grep '/vues/' | sed 's|.*/vues/||;s|\.png$||'); do
  nv=$((nv + 1))
  grep -q "^recadre $v " figures/recadrer.sh || {
    echo "ECHEC vue $v absente de figures/recadrer.sh"; ok=1; }
done
# aucune vue derivee ne doit rester sans emploi : figures/recadrer.sh ferait un
# travail que personne ne consomme, et l'orphelin survivrait a la relecture.
# Le controle demande les .fls des trois documents, donc une compilation des
# diapositives ; il est saute sinon plutot que de rendre un faux verdict.
if [ -f slides/court.fls ] && [ -f slides/long.fls ]; then
  orphelines=$(comm -23 \
    <(ls figures/vues/*.png | sed 's|.*/||;s|\.png$||' | sort) \
    <(awk '/^INPUT .*vues.*\.png$/{print $2}' main.fls slides/court.fls slides/long.fls \
      | sed 's|.*/vues/||;s|\.png$||' | sort -u))
  [ -z "$orphelines" ] || {
    echo "ECHEC vue(s) derivee(s) et jamais employee(s) :"
    echo "$orphelines" | sed 's/^/       /'; ok=1; }
fi
[ "$ok" -eq 0 ] && echo "OK  $(pdfinfo main.pdf | awk '/Pages/{print $2}') pages, $(wc -w chapitres/*.tex | tail -1 | awk '{print $1}') mots, $nf tableaux, $ng figures, $nv vues, $nd references"
exit $ok
