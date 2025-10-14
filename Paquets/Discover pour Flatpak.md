Juste un mot pour dire que j'aime installer Discover sur certaines distributions et lui confier la gestion des flatpaks.

Sur CachyOS ou Manjaro :
```
sudo pacman -S discover
```

Ensuite, moi, je n'ai pas envie que Discover gère aussi les mises à jour du reste du système, donc je vérifie qu'il n'a pas l'extension backend-packagekit :

```
sudo pacman -Rns plasma-discover-backend-packagekit
```
Cela l'empêche de voir les paquets Arch et leurs mises à jour. Normalement, sous CachyOS, il n'est pas présent.

Ensuite, on vérifie que flatpak est bien installé :
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
Pareil, normalement, sous CachyOS, c'est déjà en place.


puis que le backend Flatpak est bien installé lui aussi :
```
sudo pacman -S plasma-discover-backend-flatpak
```
