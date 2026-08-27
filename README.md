# De la donnée hydrologique dispersée à la prévision explicable

Rapport de clôture des travaux postdoctoraux menés au LIFAT (Université de Tours) du
15 septembre 2025 au 30 juin 2026, dans le cadre du programme ARD JUNON de la Région
Centre-Val de Loire.

Le dépôt porte deux documents, qui se lisent séparément.

| Document | Lequel lire |
|---|---|
| **[Livrable ST3.2 (PDF, 46 p.)](st32/st32.pdf)** — *Explicabilité et interprétabilité dans les modèles prédictifs profonds de séries temporelles*, co-signé N. Labroche, N. Ringuet, E. Doumard, M. Gol Pour | Pour les **questions de recherche** : ce que sont les explications contrefactuelles en prévision, où en est la littérature, et selon quel protocole comparer les méthodes sur le cas hydrogéologique. Il décrit le socle en une section. |
| **[Rapport de clôture (PDF, 54 p.)](main.pdf)** — *De la donnée hydrologique dispersée à la prévision explicable*, N. Ringuet | Pour la **construction** : la chaîne source par source, les arbitrages qui engagent la validité des résultats, les procédures d'exploitation, l'inventaire des limites et ce qu'il faut reprendre. C'est le rapport technique du socle que le ST3.2 décrit. |

## De quoi il s'agit

Le sujet assigné portait sur l'explicabilité des modèles de prévision appliqués aux nappes
d'eau souterraine. Il s'est heurté d'emblée à un obstacle : la donnée hydrologique française
est publique, mais elle est éparpillée entre des services qui s'ignorent, sans jointure au
forçage climatique et sans indicateurs comparables d'une station à l'autre. On ne peut pas
expliquer un modèle qu'on n'a pas pu entraîner.

Construire ce socle est donc devenu le premier travail. Le rapport décrit la chaîne complète
qui en résulte, de quatre sources publiques jusqu'à des scénarios contrefactuels énonçables
dans le langage des hydrogéologues, et dit aussi ce qu'elle n'établit pas.

## Les développements décrits

| Dépôt | Objet |
|---|---|
| [hubeau_data_integration](https://github.com/xairon/hubeau_data_integration) | Entrepôt de données hydro-climatiques : ingestion, transformation et exposition des données piézométriques, hydrométriques, climatiques et hydrogéologiques |
| [time-serie-explo](https://github.com/xairon/time-serie-explo) | Plateforme d'exploration, de modélisation et de prévision : observatoire spatial, laboratoire de modèles métier, laboratoire d'apprentissage et explicabilité |

Les deux sont publics, sous licence MIT.

## Compiler

```bash
make                  # produit les deux PDF
make main             # rapport de clôture seul
make st32             # livrable ST3.2 seul
./verifier.sh         # compile le rapport et contrôle le rendu
./verifier-st32.sh    # idem pour le ST3.2
```

`latexmk` enchaîne les passes et appelle `biber`. Sans `latexmk` :

```bash
pdflatex main && biber main && pdflatex main && pdflatex main
```

## Contenu du dépôt

`main.tex` est le document maître du rapport de clôture, `preambule.tex` porte sa mise en forme,
`chapitres/` contient un fichier par chapitre et `bibliographie.bib` les 46 références
partagées par les deux documents. Une
version antérieure du plan est figée dans `versions/plan-v2/`, sous le tag `plan-v2`.

`st32/` porte le livrable ST3.2 : `st32.tex` (document maître), `preambule.tex` (gabarit
Labroche, adapté à biblatex), `sections/` et `references.bib` (33 références propres, dont le
rapport de clôture lui-même, que le ST3.2 cite comme document technique de référence). Ce
fichier est chargé **en plus** de `bibliographie.bib`, jamais à sa place : les deux documents
partagent le fonds commun sans qu'aucune clé ne soit dupliquée, ce que `verifier-st32.sh`
contrôle. Le rapport de clôture est inchangé par l'ajout du ST3.2.

Le tag `rapport-v1` marque la version remise.
