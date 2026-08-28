# Conventions de rédaction

Notes de travail, pas de la documentation. Chaque règle a été posée en réaction à une
relecture, et `./verifier.sh` en contrôle la moitié à la compilation.

- **Prose suivie.** Pas de `\paragraph{Titre.}` ni de `\paragraph*{}` en tête de paragraphe :
  l'idée s'annonce par la phrase, jamais par une étiquette en gras.
- **Aucun tiret cadratin.**
- **La synthèse se lit d'un trait**, sans sous-titre ni tableau.
- **Une seule fin.** Un fait qui vaut comme limite et comme chantier s'énonce une fois, au
  chapitre 9. Les chapitres techniques le signalent, ils ne le réexposent pas.
- **Tout tableau est un flottant légendé** (`table[H]` + `\caption` + `\label`, légende au
  dessus). Un tableau nu dans un `center` n'est ni numérotable, ni citable, et LaTeX peut le
  séparer de sa légende.
- **Trois catégories, trois statuts.** Les défauts des sources et les limites non corrigées
  figurent au rapport, un repreneur en a besoin. Les bugs trouvés et corrigés pendant le
  développement n'y figurent pas : seul l'invariant livré est décrit.
- **Ne rien affirmer sur ce qu'un fournisseur documente ou non** sans l'avoir lu.
- **Ne pas affirmer plus que la mesure.** Le dépôt dit « realistic warehouse, 4,5 Go » : le
  rapport écrit « entrepôt représentatif », pas « à l'échelle réelle ».
- **Pas de récit à la première personne de sa propre initiative.** Le « je » est réservé à la
  synthèse.
- **Chaque chapitre s'ouvre** sur la question à laquelle il répond (`\questionchapitre`).

## Provenance des chiffres

Aucune valeur du rapport n'est estimée ni reconstituée de mémoire.

| Affirmation | Origine |
|---|---|
| Comparaison ETP Hargreaves / PEV ERA5, couverture GLO, biais 00 UTC | `hubeau_data_integration/docs/ERA5.md` |
| Validation des indices standardisés | `time-serie-explo/docs/climate-indices.md` |
| Volumétrie des tables | `hubeau_data_integration/docs/DATABASE_SCHEMA.md` |
| Nombre de modèles, orchestration | `hubeau_data_integration/docs/ARCHITECTURE.md` |
| Sauvegarde et restauration | `hubeau_data_integration/docs/OPERATIONS.md` |
| Presets par famille d'aquifère | `time-serie-explo/dashboard/utils/pastas/config.py` |
| Paramètres et bornes de PhysCF | `time-serie-explo/dashboard/utils/counterfactual/perturbation.py` |
| Critères STOWA | `time-serie-explo/dashboard/utils/pastas/stowa.py` |
| Nombre de tests et échecs documentés | `time-serie-explo/docs/README.md` |
| Chiffres cités en légende de figure (métriques de calibration, écarts de prévision, fiches de station, assiette du classement) | La capture elle-même, reproduite dans la figure : la source est sous les yeux du lecteur |

## Statut des captures

Une capture montre un **cas d'usage de l'instrument**, jamais un résultat. Le rapport n'établit
aucun classement d'architectures ni aucune évaluation d'explication (chapitre 7), et une figure ne
doit pas laisser croire le contraire : toute légende dont la capture porte une métrique de modèle
ou un indicateur calculé sur un ouvrage se termine par la mention `\lecas`, qui le dit. Un chiffre
de couverture, comme le nombre de stations classées, n'en relève pas.

Une capture n'entre dans un document que si l'image porte mieux qu'une phrase, c'est-à-dire pour
une carte ou un graphique. Un tableau de chiffres se recompose en LaTeX : dans le pixel, il n'est
lisible ni en projection ni à l'impression.

Une légende décrit ce que la capture montre réellement. Elle ne décrit pas la fonctionnalité que
l'écran aurait pu montrer : sur la carte régionale, ce sont les départements qui sont affichés en
fond, pas les entités BDLISA, même si la couche existe.
