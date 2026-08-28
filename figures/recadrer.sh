#!/usr/bin/env bash
# Derive de figures/*.png les vues utilisees par le rapport et les diapositives.
#
# Une capture de fenetre entiere fait 3840 px de large. Projetee sur une
# diapositive de 16 cm, son texte d'interface mesure environ 1 mm : il n'est pas
# lisible. Les vues ci-dessous cadrent la zone qui porte le propos, ce qui
# multiplie l'echelle par deux a six. Les originaux ne sont jamais modifies.
#
# Usage : ./figures/recadrer.sh   (idempotent, regenere figures/vues/)
#
# recadre <sortie> <source> <x0> <y0> <x1> <y1>, coins en fraction de l'image.
# Les offsets d'une geometrie ImageMagick sont en pixels meme quand la taille
# est en pourcentage : les fractions sont donc converties ici.
set -euo pipefail
cd "$(dirname "$0")"
out=vues
mkdir -p "$out"

recadre() {
  local nom=$1 src=$2 x0=$3 y0=$4 x1=$5 y1=$6
  read -r W H < <(identify -format '%w %h\n' "$src.png")
  local gx gy gw gh
  read -r gx gy gw gh < <(awk -v w="$W" -v h="$H" -v a="$x0" -v b="$y0" -v c="$x1" -v d="$y1" \
    'BEGIN{printf "%d %d %d %d\n", w*a, h*b, w*(c-a), h*(d-b)}')
  magick "$src.png" -crop "${gw}x${gh}+${gx}+${gy}" +repage \
         -resize '2400x2400>' -strip -define png:compression-level=9 "$out/$nom.png"
  printf '  %-24s %-9s <- %s\n' "$nom" "$(identify -format '%wx%h' "$out/$nom.png")" "$src"
}

echo "Observatoire"
recadre carte-nationale    observatoire-carte-nappes-rivieres-animation      0     0     0.73  1
recadre carte-regionale    observatoire-carte-piezo-epieds-beauce            0     0     0.838 1
recadre chronique-niveau   observatoire-chronique-niveau-contexte-climatique 0.205 0     0.795 0.40
recadre contexte-spi       observatoire-chronique-niveau-contexte-climatique 0.205 0.41  0.795 1
recadre comparaison-annees observatoire-comparaison-interannuelle-spli       0.205 0     0.795 0.47
recadre spli-station       observatoire-comparaison-interannuelle-spli       0.205 0.48  0.795 0.88
recadre fiche-technique    fiche-station-piezometrie-mur-de-sologne          0.205 0     0.795 0.37

echo "Laboratoire de modeles metier"
recadre pastas-metriques        pastas-lab-resultats-calibration-validation-tfn 0.01 0.20 0.99 0.42
recadre pastas-ajustement       pastas-lab-resultats-calibration-validation-tfn 0.01 0.59 0.99 1
recadre pastas-diagnostics      diagnostics-residus-pastas                      0    0    1     0.40
recadre pastas-parametres       diagnostics-residus-pastas                      0    0.715 0.78 0.974
recadre pastas-radar            pastas-lab-signatures-hydrologiques-radar       0.30 0.18 0.72 0.60
recadre pastas-galerie          pastas-lab-galerie-modeles-tfn-nse-evp          0    0.34 1     0.98
recadre pastas-calibration-auto pastas-lab-calibration-automatique-resultats    0.17 0.10 1     0.47
recadre pastas-configuration    pastas-lab-calibrer-configuration               0    0.09 0.175 1

echo "Laboratoire d'apprentissage"
recadre ia-configuration    lab-ia-entrainement-tft-configuration    0.20 0.17 0.50 1
recadre ia-modele           lab-ia-prevision-nhits-fenetre-glissante 0.20 0.16 0.80 0.46
recadre ia-jeu-de-test      lab-ia-prevision-nhits-fenetre-glissante 0.20 0.66 0.80 1
recadre prevision-fenetre   prevision-piezometrie-evaluation-30j     0    0.02 0.66 0.84
recadre prevision-metriques prevision-piezometrie-evaluation-30j     0.66 0.02 1    0.84

echo "Scenarios"
recadre scenario-preselections scenario-pompage-industriel-impulsion 0 0.19 1 0.325
recadre scenario-stress        scenario-pompage-industriel-impulsion 0 0.325 1 0.87

echo "$(ls "$out" | wc -l) vues dans figures/$out/"
