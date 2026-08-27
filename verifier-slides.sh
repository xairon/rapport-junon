#!/usr/bin/env bash
# Verification des deux jeux de diapositives. Sortie non nulle si un controle echoue.
cd "$(dirname "$0")/slides"
ok=0
for f in court long; do
  latexmk -pdf -interaction=nonstopmode $f.tex >/dev/null 2>&1 || { echo "ECHEC compilation $f"; ok=1; }
  e=$(grep -c '^!' $f.log);                   [ "$e" -eq 0 ] || { echo "ECHEC $f : $e erreur(s)"; ok=1; }
  o=$(grep -c 'Overfull \\vbox' $f.log);      [ "$o" -eq 0 ] || { echo "ECHEC $f : $o diapo(s) qui debordent"; ok=1; }
  u=$(grep -i 'undefined' $f.log | grep -vc 'Font shape'); [ "$u" -eq 0 ] || { echo "ECHEC $f : $u reference(s) non resolue(s)"; ok=1; }
done
# nombre de diapositives attendu : 1 page de titre + 5, et + 15
nc=$(pdfinfo court.pdf | awk '/Pages/{print $2}')
nl=$(pdfinfo long.pdf  | awk '/Pages/{print $2}')
[ "$nc" -eq 6 ]  || { echo "ECHEC court : $nc pages au lieu de 6"; ok=1; }
[ "$nl" -eq 16 ] || { echo "ECHEC long : $nl pages au lieu de 16"; ok=1; }
# toute capture attendue est-elle presente ?
manque=$(grep -ho '\\capture\[[^]]*\]{[^}]*}' court.tex long.tex | sed 's/.*{//;s/}//' | sort -u \
         | while read -r c; do [ -f "captures/$c" ] || echo "$c"; done | wc -l)
[ "$ok" -eq 0 ] && echo "OK  court $nc diapos, long $nl diapos, $manque capture(s) encore a prendre"
exit $ok
