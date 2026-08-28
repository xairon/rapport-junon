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
# nombre de diapositives attendu : 1 page de titre + 7, et + 24
nc=$(pdfinfo court.pdf | awk '/Pages/{print $2}')
nl=$(pdfinfo long.pdf  | awk '/Pages/{print $2}')
[ "$nc" -eq 8 ]  || { echo "ECHEC court : $nc pages au lieu de 8"; ok=1; }
[ "$nl" -eq 26 ] || { echo "ECHEC long : $nl pages au lieu de 26"; ok=1; }

# Les images reellement incluses sont lues dans les .fls, non devinees dans le
# .tex : une vue passee en second argument de \cadre echappe a toute regex
# ligne a ligne, et un controle qui ne voit rien passe sans rien verifier.
images=$(cat court.fls long.fls | awk '/^INPUT .*\.png$/{print $2}' | sed 's|^\./||' | sort -u)

# 1. Aucune capture d'origine n'est incluse telle quelle : une fenetre de
#    3840 px projetee en entier a un texte d'interface d'environ 1 mm. Seuls
#    les deux logos echappent a la regle.
brut=$(echo "$images" | grep -c '\.\./figures/[a-z0-9-]*\.png$')
logos=$(echo "$images" | grep -c '\.\./figures/logo-')
[ "$brut" -eq "$logos" ] || {
  echo "ECHEC capture d'origine incluse hors figures/vues/ :"
  echo "$images" | grep '\.\./figures/[a-z0-9-]*\.png$' | grep -v 'logo-' | sed 's/^/       /'
  ok=1; }

# 2. Toute vue employee est derivable : figures/recadrer.sh doit la produire.
#    Sans ce controle, un PNG depose a la main dans figures/vues/ survivrait a
#    une regeneration et le recadrage ne serait plus reproductible.
nv=0
for v in $(echo "$images" | grep '/vues/' | sed 's|.*/vues/||;s|\.png$||'); do
  nv=$((nv + 1))
  grep -q "^recadre $v " ../figures/recadrer.sh || {
    echo "ECHEC vue $v absente de figures/recadrer.sh"; ok=1; }
done

[ "$ok" -eq 0 ] && echo "OK  court $nc diapos, long $nl diapos, $nv vues toutes derivables"
exit $ok
