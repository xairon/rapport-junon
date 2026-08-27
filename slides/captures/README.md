# Captures à prendre

Les diapositives compilent sans ces fichiers : à leur place s'affiche un cadre en pointillés qui
rappelle ce qu'il faut montrer. Dès qu'un fichier est déposé ici sous le nom exact, il remplace
le cadre sans aucune retouche du `.tex`.

Format : PNG, largeur ≥ 1600 px, sans barre d'adresse ni onglets du navigateur. Une capture de
la zone utile vaut mieux qu'une capture d'écran entière.

| Fichier | Ce qu'il faut montrer | Utilisé par |
|---|---|---|
| `observatoire-carte.png` | Carte des stations piézométriques portant leur indicateur de situation, entités aquifères BDLISA en fond, découpage en secteurs visible | court, long |
| `pastas-calibration.png` | Calibration d'un modèle à fonction de transfert sur une station : ajustement, réponse impulsionnelle, diagnostics de résidus | long |
| `ia-entrainement.png` | Suivi d'entraînement en temps réel : pertes en apprentissage et en validation, arrêt anticipé | long |
| `ia-explicabilite.png` | Panneau d'explicabilité d'une prévision, attribution projetée sur le plan variable-temps | long |

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
