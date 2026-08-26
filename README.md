# Rapport de clôture, programme JUNON

Rapport de clôture des travaux postdoctoraux menés au LIFAT (Université de Tours) du
15 septembre 2025 au 30 juin 2026, dans le cadre du programme ARD JUNON de la Région
Centre-Val de Loire.

## Compiler

```bash
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
| `preambule.tex` | Paquets, palette, environnement `encadre` (seul encore employé, une fois) |
| `bibliographie.bib` | 42 références, toutes citées |
| `chapitres/` | Un fichier par chapitre, numérotés dans l'ordre du document |
| `figures/` | Ressources externes éventuelles (les schémas actuels sont en TikZ, dans les chapitres) |
| `versions/plan-v2/` | Version figée du 26 août 2026, avant refonte du plan : sources et PDF |

## Plan

1. Contexte et positionnement
2. Le verrou : une donnée ouverte mais inexploitable
3. Sourcing et entrepôt de données
4. Des mesures aux indicateurs : construction et validation
5. L'Observatoire : donner à voir
6. Modéliser : le laboratoire de modèles métier
7. Apprendre : le laboratoire d'apprentissage automatique
8. Expliquer : le sujet initial, enfin abordable
9. Ce que la collaboration a produit
10. Un socle pour l'IA en hydrologie
11. Bilan, limites et passation
    - Annexe A : annexes (réalisations, sources, ETP, volumétrie, glossaire)
    - Annexe B : revue des outils retenus

Le plan précédent, qui plaçait la conduite du projet en chapitre 9 et la revue d'outils
dans le chapitre entrepôt, est conservé dans `versions/plan-v2/` et sous le tag git `plan-v2`.

## Conventions de rédaction

Elles ont toutes été posées en réaction à une relecture. Les enfreindre a déjà coûté une reprise.

- **Prose suivie.** Pas de `\paragraph{Titre.}` en tête de paragraphe : l'idée s'annonce par la
  phrase, jamais par une étiquette en gras. Il y en avait 48 le 26 août 2026, il n'en reste aucun.
  Contrôle : `grep -h '^\\paragraph{' chapitres/*.tex | wc -l` doit rendre 0.
- **Aucun tiret cadratin.** Contrôle : `grep -o '—' chapitres/*.tex | wc -l` doit rendre 0.
- **La synthèse se lit d'un trait**, sans sous-titre ni tableau.
- **Trois catégories, trois statuts.** Les défauts des sources et les limites non corrigées
  figurent au rapport, un repreneur en a besoin. Les bugs trouvés et corrigés pendant le
  développement n'y figurent pas : seul l'invariant livré est décrit, leur récit vit dans le
  manuel d'exploitation du dépôt.
- **Pas de récit à la première personne de sa propre initiative**, ni de tableau qui note ses
  propres mérites. Les faits suffisent.
- **Chaque chapitre s'ouvre** sur la question à laquelle il répond (`\questionchapitre`).
- **Tous les chiffres avancés** proviennent de mesures consignées dans les dépôts
  `hubeau_data_integration` et `time-serie-explo`. Aucune valeur n'est estimée ou reconstituée.

## Sources des chiffres

| Affirmation | Origine |
|---|---|
| Comparaison ETP Hargreaves / PEV ERA5 | `hubeau_data_integration/docs/ERA5.md` |
| Couverture log-logistique → GLO | `hubeau_data_integration/docs/ERA5.md` |
| Validation des indices standardisés | `time-serie-explo/docs/climate-indices.md` |
| Volumétrie, nombre de modèles, orchestration | `hubeau_data_integration/docs/ARCHITECTURE.md` |
| Presets par famille d'aquifère | `time-serie-explo/dashboard/utils/pastas/config.py` |
| Paramètres et bornes de PhysCF | `time-serie-explo/dashboard/utils/counterfactual/perturbation.py` |
| Critères STOWA | `time-serie-explo/dashboard/utils/pastas/stowa.py` |
