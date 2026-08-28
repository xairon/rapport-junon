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
# tout tableau du corps est un flottant legende. La page de garde en est
# exclue : le tableau des auteurs impose par le gabarit du programme n'a pas a
# etre numerote ni legende.
corps=$(ls sections/*.tex | grep -v '00-couverture.tex')
nt=$(grep -o 'begin{tabular' $corps | wc -l)
nf=$(grep -o 'begin{table}' $corps | wc -l)
[ "$nt" -eq "$nf" ] || { echo "ECHEC $nt tableau(x) pour $nf flottant(s) : un tableau sans legende"; ok=1; }
# aucune cle en double entre les deux fichiers .bib, et toute entree propre est citee
d=$(comm -12 <(grep -o '^@[a-zA-Z]*{[^,]*' references.bib | sed 's/.*{//' | sort) \
             <(grep -o '^@[a-zA-Z]*{[^,]*' ../bibliographie.bib | sed 's/.*{//' | sort) | wc -l)
[ "$d" -eq 0 ] || { echo "ECHEC $d cle(s) bib en double entre references.bib et bibliographie.bib"; ok=1; }
nd=$(grep -c '^@' references.bib)
nu=$(for k in $(grep -o '^@[a-zA-Z]*{[^,]*' references.bib | sed 's/.*{//'); do
       grep -qF "$k" sections/*.tex || echo "$k"; done | wc -l)
[ "$nu" -eq 0 ] || { echo "ECHEC $nu entree(s) de references.bib non citee(s)"; ok=1; }

# Les images reellement incluses sont lues dans le .fls, non devinees dans le
# .tex : une vue passee en argument d'une macro echappe a toute regex ligne a
# ligne, et un controle qui ne voit rien passe sans rien verifier.
images=$(awk '/^INPUT .*\.png$/{print $2}' st32.fls | sed 's|^\./||' | sort -u)

# 1. Aucune capture d'origine n'est incluse telle quelle : une fenetre de
#    3840 px reproduite en entier a un texte d'interface d'environ 1 mm. Seuls
#    les deux logos de couverture echappent a la regle.
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

[ "$ok" -eq 0 ] && echo "OK  $(pdfinfo st32.pdf | awk '/Pages/{print $2}') pages, $(wc -w $corps | tail -1 | awk '{print $1}') mots, $nf tableaux, $nv vues, $nd references propres"
exit $ok
