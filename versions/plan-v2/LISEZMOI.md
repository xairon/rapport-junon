# Plan v2, figé le 26 août 2026

Copie complète et compilable du rapport tel qu'il était avant la refonte du plan.
Sources et PDF. Rien n'a été supprimé de cette version.

- État git correspondant : commit `50fe90f`, tag `plan-v2`.
- PDF : `rapport-plan-v2.pdf` (59 pages).

Ordre des chapitres de cette version :

1. Contexte et positionnement
2. Le verrou : une donnée ouverte mais inexploitable
3. Sourcing et entrepôt de données
4. Des mesures aux indicateurs
5. L'Observatoire
6. Modéliser : le laboratoire de modèles métier
7. Apprendre : le laboratoire d'apprentissage automatique
8. Expliquer
9. Collaborations et réponses aux besoins
10. Un socle pour l'IA en hydrologie
11. Bilan, limites et passation

Pour recompiler cette version telle quelle :

    cd versions/plan-v2 && latexmk -pdf main.tex
