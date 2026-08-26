# De la donnée hydrologique dispersée à la prévision explicable

Rapport de clôture des travaux postdoctoraux menés au LIFAT (Université de Tours) du
15 septembre 2025 au 30 juin 2026, dans le cadre du programme ARD JUNON de la Région
Centre-Val de Loire.

**[Lire le rapport (PDF, 52 pages)](main.pdf)**

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
make            # produit main.pdf
./verifier.sh   # compile et contrôle le rendu
```

`latexmk` enchaîne les passes et appelle `biber`. Sans `latexmk` :

```bash
pdflatex main && biber main && pdflatex main && pdflatex main
```

## Contenu du dépôt

`main.tex` est le document maître, `preambule.tex` porte la mise en forme, `chapitres/`
contient un fichier par chapitre et `bibliographie.bib` les 42 références. Une version
antérieure du plan est figée dans `versions/plan-v2/`, sous le tag `plan-v2`.

Le tag `rapport-v1` marque la version remise.
