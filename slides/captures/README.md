# Captures à prendre

Les diapositives compilent sans ces fichiers : à leur place s'affiche un cadre en pointillés qui
rappelle ce qu'il faut montrer. Dès qu'un fichier est déposé ici sous le nom exact, il remplace
le cadre sans aucune retouche du `.tex`.

Format : PNG, largeur ≥ 1600 px, sans barre d'adresse ni onglets du navigateur. Une capture de
la zone utile vaut mieux qu'une capture d'écran entière.

| Fichier | Ce qu'il faut montrer | Utilisé par | État |
|---|---|---|---|
| `observatoire-carte.png` | Carte des stations piézométriques portant leur indicateur de situation, entités aquifères BDLISA en fond, découpage en secteurs visible | court, long | ✅ remplie (depuis `observatoire-carte-piezo-epieds-beauce.png`) |
| `pastas-calibration.png` | Calibration d'un modèle à fonction de transfert sur une station : ajustement, réponse impulsionnelle, diagnostics de résidus | long | ✅ remplie (depuis `pastas-lab-resultats-calibration-validation-tfn.png`) |
| `ia-entrainement.png` | Suivi d'entraînement en temps réel : pertes en apprentissage et en validation, arrêt anticipé | long | ✅ remplie (depuis `lab-ia-entrainement-tft-configuration.png`) |
| `ia-explicabilite.png` | Panneau d'explicabilité d'une prévision, attribution projetée sur le plan variable-temps | long | ⏳ **toujours manquante** — aucune des 16 images reçues ne montre ce panneau (l'onglet « Analyse avancée » n'apparaît sur aucune capture) |

## Captures complémentaires ajoutées (28/08/2026)

| Fichier | Contenu | Utilisé par |
|---|---|---|
| `observatoire-carte-nappes-rivieres-animation.png` | Vue nationale des nappes et rivières, animation temporelle 2000–2026 | long |
| `observatoire-chronique-niveau-contexte-climatique.png` | Chronique piézométrique croisée avec SPI et cumuls vs normale 1991–2020 | court, long |
| `pastas-lab-galerie-modeles-tfn-nse-evp.png` | Galerie des modèles calés par piézomètre (NSE, EVP, AIC) | long |
| `pastas-lab-calibration-automatique-resultats.png` | Calibration automatique, 8 configurations classées sur critères STOWA | long |
| `lab-ia-prevision-nhits-fenetre-glissante.png` | Prévision NHITS multivarié à 30 j sur le jeu de test | long |
| `prevision-piezometrie-evaluation-30j.png` | Fenêtre de prévision vs observations, métriques MAE/RMSE/biais | long |
| `scenario-pompage-industriel-impulsion.png` | Configuration d'un scénario contrefactuel (pompage industriel en impulsion) | long |
| `fiche-station-piezometrie-mur-de-sologne.png` | Fiche détaillée d'une station (métadonnées BSS/BDLISA, jauge IPS) | disponible |
| `observatoire-comparaison-interannuelle-spli.png` | Comparaison interannuelle et SPLI/IPS d'une station | disponible |
| `calibration-automatique-configuration.png` | Écran de configuration d'une calibration automatique (STOWA 70/30) | disponible |
| `pastas-lab-calibrer-configuration.png` | Écran de configuration d'un calibrage (recharge Linear, réponse Gamma) | disponible |
| `pastas-lab-signatures-hydrologiques-radar.png` | Validation par signatures hydrologiques (radar observé/simulé) | disponible |
| `diagnostics-residus-pastas.png` | Diagnostics des résidus (tests, QQ-plot, PACF, paramètres calés) | disponible |
| `lab-ia-entrainement-tft-configuration.png` | Configuration d'un entraînement TFT (covariables ERA5, split) | disponible |

Les fichiers « disponibles » sont dans `captures/` mais pas encore référencés dans les prez — utilisables
sur demande.

## Ce qui ne mérite pas une capture

Dagster et Adminer ne montrent rien qu'un texte ne dise mieux : un graphe d'assets ou une liste
de tables ne se lit pas en projection et n'apprend rien sur le fond. Une exception possible, si
le temps le permet : le graphe d'assets Dagster en une image rend visible d'un coup
l'enchaînement ingestion → transformation → indicateurs, qui reste abstrait à l'oral.

## Choix de la station

Prendre la même station pour la calibration et pour la prévision, de préférence sur une nappe à
cycle annuel marqué : la lecture est immédiate, et l'auditoire suit le même cas d'un bout à
l'autre de la présentation.

## Attention

Ces captures partent dans une présentation. Vérifier qu'aucune ne laisse voir un identifiant de
session, un nom de compte ou une adresse d'instance interne.
