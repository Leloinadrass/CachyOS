✅ Procédure complète et propre pour DAI + Frosty sous Lutris

1) Installer EA App via Lutris

Utiliser le script Lutris ou l’installateur manuel.

Vérifier que le prefix Wine est propre et en mode Windows 10.

2) Installer Dragon Age Inquisition dans EA App

Lancer EA App depuis Lutris.

Installer DAI dans le même prefix.

3) Lancer DAI une fois depuis EA App

Permet à EA App de valider le DRM.

Crée les dossiers nécessaires dans Documents/BioWare/Dragon Age Inquisition.

4) Lancer Frosty Mod Manager dans le même prefix

Important : Frosty doit être installé dans le même prefix Wine que EA App. Ou en tout cas, avoir le même préfixe que EA App.

Frosty scanne automatiquement les jeux installés.

5) Ajouter les mods dans Frosty

Les fichiers .fbmod vont dans :

FrostyModManager/Mods/

Pas dans le dossier BioWare.

6) Sélectionner les mods et cliquer sur “Apply Mods” / “Install Mods”

Frosty génère le dossier ModData dans le répertoire du jeu.

Ne jamais copier ce dossier à la main.

7) Frosty affiche un message avec :

un argument de lancement

un DLL override (pour Wine)



✅ Où mettre chaque élément dans Lutris

8) Argument de lancement

Il faut créer un nouveau lanceur dans Lutris qui pointe directement vers /mnt/nvme4to/Lutris/ea-app/drive_c/Program Files/EA Games/Dragon Age Inquisition/DragonAgeInquisition.exe

Dans Lutris → DAI → Configurer → Options du jeu → Arguments :

-dataPath "ModData/Default"

cela peut dépendre de ton profil Frosty.

9) DLL override

Dans Lutris → DAI → Configurer → Runner options/options de l'exécuteur → DLL overrides :

Ajouter :

Key : winmm

Value : n,b

Cela force Wine à utiliser la version native de winmm.dll, indispensable pour Frosty.

10) Lancer DAI via Lutris

Si tu lances depuis Lutris → Frosty a déjà patché le jeu, donc ça fonctionne aussi.
