
## C’est quoi AUR ?

L’**AUR** (Arch User Repository) est un dépôt communautaire pour Arch Linux et ses dérivés (comme CachyOS). Il contient des PKGBUILD (scripts de compilation) permettant d’installer des logiciels qui ne sont pas dans les dépôts officiels. 

⚠️ Comme ce sont des contributions de la communauté, il faut toujours vérifier le contenu d’un PKGBUILD avant de l’utiliser.

## C’est quoi yay ?

yay (Yet Another Yaourt) est un helper AUR. Il simplifie l’installation et la mise à jour des paquets depuis l’AUR, en automatisant :

- la récupération du PKGBUILD,
- la compilation,
- l’installation,
- la mise à jour.

Remarque : Yaourt était "Yet AnOther User Repositoiry Tool"

## Installer yay

Sur CachyOS ou Manjaro on gagne un peu de temps par rapport à Arch car l'essentiel est déjà là, il suffit de taper :

```
sudo pacman -S yay
```

## Installer un paquet avec Yay :

Prenons les exemples de [teamviewer](https://aur.archlinux.org/packages/teamviewer) et [goofcord](https://aur.archlinux.org/packages/goofcord-bin) :



