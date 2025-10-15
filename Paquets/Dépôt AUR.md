
## C’est quoi AUR ?

L’**AUR** (Arch User Repository) est un dépôt communautaire pour Arch Linux et ses dérivés (comme CachyOS). Il contient des PKGBUILD (scripts de compilation) permettant d’installer des logiciels qui ne sont pas dans les dépôts officiels. 

⚠️ Comme ce sont des contributions de la communauté, il faut toujours vérifier le contenu d’un PKGBUILD avant de l’utiliser.

## C’est quoi yay ?

yay (Yet Another Yogurt) est un helper AUR. Il simplifie l’installation et la mise à jour des paquets depuis l’AUR, en automatisant :

- la récupération du PKGBUILD,
- la compilation,
- l’installation,
- la mise à jour.

Remarque : Yaourt (Yet AnOther User Repository Tool) était un ancien helper AUR, aujourd’hui obsolète et non maintenu.

## Installer yay

Sur CachyOS ou Manjaro on gagne un peu de temps par rapport à Arch car l'essentiel est déjà là, il suffit de taper :

```
sudo pacman -S yay
```

Sur Manjaro, il a fallu que j'installe Fakeroot pour pouvoir utiliser yay :
```
sudo pacman -S fakeroot
```

## Installer un paquet avec yay :

Prenons les exemples de [teamviewer](https://aur.archlinux.org/packages/teamviewer) et [goofcord](https://aur.archlinux.org/packages/goofcord-bin) :

Sur la page de teamviewer, à côté de "Package Base" on lit "teamviewer" et sur celle de GoofCord, on lit "goofcord-bin"

Donc pour installer ces logiciels, on va taper :

```
yay -S teamviewer
```
et
```
yay -S goofcord-bin
```

Notez l'absence de `sudo` au début : pas besoin pour la compilation.
Toutefois, une fois cette compilation terminée, **yay** demandera les droits admin pour procéder à l'installation.

yay va vous demander s'il faut garder les sources (packages to cleanbuild) : je choisis "Tous"
Il demande ensuite si on veut voir les différences. Je choisis généralement "Aucun"
La compilation se lance, puis l'installation.

## Mettre à jour avec yay :

Je préfère n'utiliser yay que pour mes paquets AUR. Donc la commande sera :
```
yay -Sua
```

Et c'est tout.

Remarque : il n'y a généralement pas de vérfication automatique des mises à jour disponibles sous yay. En tout cas, pas par défaut.
Il faut donc prévoir un petit script. (Ou une intégration à systemd)

Par exemple, dans mon home, j'ai un fichier "yay-check.sh" qui contient :
```
#!/bin/bash
updates=$(yay -Qua)
if [ -n "$updates" ]; then
    notify-send "🔔 Mises à jour AUR disponibles" "$updates"
fi
```

`yay -Qua` ne cherche que les mises à jour du dépôt AUR. Je fais les mises à jour des paquets officiels de la distribution avec `pacman`.


Et je le lance au démarrage avec un fichier *desktop* dans *autostart* :
~/.config/autostart/yay-check-autostart.desktop

qui contient :
```
[Desktop Entry]
Comment[fr_FR]=
Comment=
Exec=/home/leloinadrass/scripts/yay-check.sh
GenericName[fr_FR]=
GenericName=
Hidden=false
Icon=system-software-update
MimeType=
Name[fr_FR]=Test des mises à jour AUR
Name=Test des mises à jour AUR
NoDisplay=false
Path=
StartupNotify=true
Terminal=false
TerminalOptions=
Type=Application
X-GNOME-Autostart-enabled=true
X-KDE-SubstituteUID=false
X-KDE-Username=

```



