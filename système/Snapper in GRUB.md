On va faire très simple : le mode d'emploi est ici : [https://discuss.cachyos.org/t/install-snapper-btrfs-from-cachyos-hello-feedback/517](https://discuss.cachyos.org/t/install-snapper-btrfs-from-cachyos-hello-feedback/517)


Installez toutes les dépendances :
```
pacman -S --needed snapper snapper-gui snap-pac snap-pac-grub grub-btrfs btrfs-assistant
```

Editez la configuration root pour permettre au groupe `wheel` de créer des snapshots :

Rappel dans VIM : "i" pour éditer, "esc" pour quitter l'édition, "x" pour supprimer un caractère, ":wq" pour sauvegarder et quitter.

```
sudo vim /etc/snapper/configs/root

```
Ajoutez la ligne suivante (il suffit d'ajouter wheel) 

```
ALLOW_GROUPS="wheel"

```
Configurez snap-pac:

```
sudo vim /etc/snap-pac.ini

```
Ajoutez ceci :

```
[root]
snapshot = True

```
Mettre à jour la configuration GRUB :
(remarque: c'est pas comme sous Ubuntu, c'est pas sudo update-grub)

```
grub-mkconfig -o /boot/grub/grub.cfg

```
Une fois ceci fait, rebootez le système et essayez de créer un backup manuel via btrfs-assistant.
