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
| `preambule.tex` | Paquets, palette, environnements (`encadre`, `limite`, `resultat`, `acquisouvert`) |
| `bibliographie.bib` | 42 références, toutes citées |
| `chapitres/` | Un fichier par chapitre, numérotés dans l'ordre du document |
| `figures/` | Ressources externes éventuelles (les schémas actuels sont en TikZ, dans les chapitres) |
| `versions/plan-v2/` | Version figée du 26 août 2026, avant refonte du plan : sources et PDF |

## Plan

1. Contexte et positionnement
2. Le verrou : une donnée ouverte mais inexploitable
3. La conduite du projet
4. Sourcing et entrepôt de données
5. Des mesures aux indicateurs : construction et validation
6. L'Observatoire : donner à voir
7. Modéliser : le laboratoire de modèles métier
8. Apprendre : le laboratoire d'apprentissage automatique
9. Expliquer : le sujet initial, enfin abordable
10. Ce que la collaboration a produit
11. Un socle pour l'IA en hydrologie
12. Bilan, limites et passation
    - Annexe A : annexes (réalisations, sources, ETP, volumétrie, glossaire)
    - Annexe B : revue des outils retenus

Le plan précédent, qui plaçait la conduite du projet en chapitre 9 et la revue d'outils
dans le chapitre entrepôt, est conservé dans `versions/plan-v2/` et sous le tag git `plan-v2`.

## Conventions de rédaction

- **Chaque chapitre s'ouvre** sur la question à laquelle il répond (`\questionchapitre`) et
  **se ferme** sur un bilan acquis / ouvert (environnement `acquisouvert`).
- **Les environnements colorés** ont un rôle fixe : `resultat` (vert) pour un résultat établi,
  `limite` (ocre) pour une limite assumée, `encadre` (bleu) pour une mise en perspective.
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
