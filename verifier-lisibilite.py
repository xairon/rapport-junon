#!/usr/bin/env python3
"""Controle de lisibilite des vues projetees.

Une vue reste lisible depuis une salle si l'echelle a laquelle elle est
reproduite laisse au texte d'interface une hauteur suffisante. On mesure
l'echelle reellement appliquee, en centimetres par pixel source, plutot que la
largeur : une vue etroite dans une colonne peut etre lisible, une vue large
d'un panneau dense ne l'est pas.

Seuil : 0,0050 cm/px, soit environ 1,1 mm pour une ligne d'interface de 22 px.
Deux vues en sont exemptees, ou le texte n'est pas le propos : la carte
nationale (ce sont les formes et les couleurs qui parlent) et la fenetre de
prevision (ce sont les courbes).
"""
import subprocess, sys, os, glob

SEUIL = 0.0050
EXEMPTES = {'carte-nationale', 'prevision-fenetre'}

taille2nom = {}
RACINE = os.path.dirname(os.path.abspath(__file__))
vues = glob.glob(os.path.join(RACINE, 'figures/vues/*.png'))
if not vues:
    sys.exit("ECHEC figures/vues/ introuvable : le controle ne verifierait rien")
for f in vues:
    out = subprocess.run(['identify', '-format', '%w %h', f], capture_output=True, text=True).stdout
    taille2nom.setdefault(out.strip(), []).append(os.path.basename(f)[:-4])

ok = 0
controlees = exemptees = 0
for pdf in sys.argv[1:]:
    for l in subprocess.run(['pdfimages', '-list', pdf], capture_output=True, text=True).stdout.splitlines():
        c = l.split()
        if len(c) < 15 or c[2] != 'image':
            continue
        try:
            w, h, xppi, yppi, page = int(c[3]), int(c[4]), float(c[12]), float(c[13]), c[0]
        except ValueError:
            continue
        if xppi <= 0 or page == '1':          # page 1 = logos de la page de titre
            continue
        noms = taille2nom.get(f'{w} {h}')
        if not noms:                          # image qui n'est pas une vue
            continue
        if set(noms) & EXEMPTES:
            exemptees += 1
            continue
        controlees += 1
        echelle = (h / yppi * 2.54) / h       # cm par pixel source
        if echelle < SEUIL:
            print(f"ECHEC {os.path.basename(pdf)} p.{page} : {'/'.join(noms)} reproduite a "
                  f"{echelle:.4f} cm/px (seuil {SEUIL}), texte illisible en projection")
            ok = 1

if controlees == 0:
    sys.exit("ECHEC aucune vue reconnue dans les PDF : le controle n'a rien verifie")
if ok == 0:
    print(f"OK  {controlees} vue(s) lisible(s) en projection, {exemptees} exemptee(s)")
sys.exit(ok)
