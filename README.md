# Rapport de clôture, programme JUNON

Rapport de clôture des travaux postdoctoraux menés au LIFAT (Université de Tours) du
15 septembre 2025 au 30 juin 2026, dans le cadre du programme ARD JUNON de la Région
Centre-Val de Loire.

## Compiler

```bash
./verifier.sh   # compile et contrôle : erreurs, renvois, tirets, titres, tableaux, biblio
make            # produit main.pdf
make clean      # supprime les fichiers intermédiaires
make cleanall   # supprime aussi le PDF
```

`latexmk` enchaîne les passes nécessaires et appelle `biber` pour la bibliographie.
Sans `latexmk` :

```bash
pdflatex main && biber main && pdflatex main && pdflatex main
```

## Structure

| Fichier | Contenu |
|---|---|
| `main.tex` | Document maître : préambule, ordre des chapitres |
| `preambule.tex` | Paquets, palette, environnement `encadre` (seul défini, employé une fois) |
| `bibliographie.bib` | 42 références, toutes citées |
| `chapitres/` | Un fichier par chapitre, numérotés dans l'ordre du document |
| `figures/` | Vide : les quatre schémas actuels sont en TikZ, dans les chapitres |
| `versions/plan-v2/` | Version figée du 26 août 2026, avant refonte du plan : sources et PDF |

## Plan

1. Contexte et positionnement
2. Le verrou : une donnée ouverte mais inexploitable
3. Sourcing et entrepôt de données
4. Des mesures aux indicateurs : construction et validation
5. L'Observatoire : donner à voir
6. Modéliser : le laboratoire de modèles métier
7. Apprendre et expliquer : le laboratoire d'intelligence artificielle
8. Ce que la collaboration a produit
9. Bilan : le socle, ses limites, sa reprise
   - Annexe A : annexes (réalisations, sources, ETP, volumétrie, glossaire)
   - Annexe B : revue des outils retenus

Le plan v2, qui plaçait la conduite du projet en chapitre 9 et la revue d'outils dans le
chapitre entrepôt, est conservé dans `versions/plan-v2/` et sous le tag git `plan-v2`.

Le plan v3 comptait deux chapitres de fin, « Un socle pour l'IA en hydrologie » puis
« Bilan, limites et passation ». Ils ont été fusionnés le 26 août 2026 : ils énonçaient tous
deux les mêmes quatre chantiers restants, et le rapport se terminait trois fois.

## Conventions de rédaction

Elles ont toutes été posées en réaction à une relecture. Les enfreindre a déjà coûté une reprise.

- **Prose suivie.** Pas de `\paragraph{Titre.}` ni de `\paragraph*{}` en tête de paragraphe :
  l'idée s'annonce par la phrase, jamais par une étiquette en gras.
  Contrôle : `grep -h '^\\paragraph' chapitres/*.tex | wc -l` doit rendre 0.
- **Aucun tiret cadratin.** Contrôle : `grep -o '—' chapitres/*.tex | wc -l` doit rendre 0.
- **La synthèse se lit d'un trait**, sans sous-titre ni tableau.
- **Une seule fin.** Un fait qui vaut comme limite et comme chantier s'énonce une fois, au
  chapitre 9. Les chapitres techniques le signalent, ils ne le réexposent pas.
- **Tout tableau est un flottant légendé.** `table[H]` + `\caption` + `\label`, la légende
  au-dessus. Un tableau nu dans un `center` n'est pas numérotable, donc pas citable, et LaTeX
  peut le séparer de sa légende. Contrôle : autant de `\begin{table}` que de `\begin{tabular`.
- **Trois catégories, trois statuts.** Les défauts des sources et les limites non corrigées
  figurent au rapport, un repreneur en a besoin. Les bugs trouvés et corrigés pendant le
  développement n'y figurent pas : seul l'invariant livré est décrit, leur récit vit dans le
  manuel d'exploitation du dépôt.
- **Ne rien affirmer sur ce qu'un fournisseur documente ou non** sans l'avoir lu. Trois
  affirmations de ce type ont été retirées le 26 août 2026, dont une fausse : la convention
  cumul / instantané d'ERA5-Land est bel et bien documentée.
- **Pas de récit à la première personne de sa propre initiative**, ni de tableau qui note ses
  propres mérites. Les faits suffisent. Le « je » est réservé à la synthèse.
- **Chaque chapitre s'ouvre** sur la question à laquelle il répond (`\questionchapitre`).
- **Tous les chiffres avancés** proviennent de mesures consignées dans les dépôts
  `hubeau_data_integration` et `time-serie-explo`. Aucune valeur n'est estimée ou reconstituée.
- **Ne pas affirmer plus que la mesure.** Le dépôt dit « realistic warehouse, 4,5 Go » : le
  rapport écrit « entrepôt représentatif », pas « à l'échelle réelle ».

## Sources des chiffres

| Affirmation | Origine |
|---|---|
| Comparaison ETP Hargreaves / PEV ERA5 | `hubeau_data_integration/docs/ERA5.md` |
| Couverture log-logistique → GLO | `hubeau_data_integration/docs/ERA5.md` |
| Biais du prélèvement 00 UTC (−2,90 °C) | `hubeau_data_integration/docs/ERA5.md` |
| Validation des indices standardisés | `time-serie-explo/docs/climate-indices.md` |
| Volumétrie des tables | `hubeau_data_integration/docs/DATABASE_SCHEMA.md` |
| Nombre de modèles, orchestration | `hubeau_data_integration/docs/ARCHITECTURE.md` |
| Sauvegarde et restauration | `hubeau_data_integration/docs/OPERATIONS.md` |
| Presets par famille d'aquifère | `time-serie-explo/dashboard/utils/pastas/config.py` |
| Paramètres et bornes de PhysCF | `time-serie-explo/dashboard/utils/counterfactual/perturbation.py` |
| Critères STOWA | `time-serie-explo/dashboard/utils/pastas/stowa.py` |
| Effet du forçage ETP sur une calibration | `time-serie-explo/docs/etp-station-mesure-2026-08-25.md` |
| Nombre de tests et échecs documentés | `time-serie-explo/docs/README.md` |

## Reste ouvert

- `figures/` est vide : aucune figure de résultat, aucune capture de l'Observatoire. Les
  produire suppose de relancer la pile.
- Les deux dépôts sont sous licence MIT mais hébergés sur la forge de l'université, accessible
  sur demande. À basculer sur GitHub, puis remplacer les `url` de `bibliographie.bib`
  (clés `depot_entrepot` et `depot_plateforme`) et retirer le `note = {accès sur demande}`.
- La volumétrie ERA5 (≈ 320 M et ≈ 300 M lignes) vient de `DATABASE_SCHEMA.md`, mesurée le
  24 août 2026. À re-mesurer avant toute diffusion si la base a été rechargée depuis.
