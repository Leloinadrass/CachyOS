L'objectif est la création d'un accès via téléphone au PC sous CachyOS par une interface SSH qui me permet, éventuellement, de lancer des commandes lorsque le PC ne répond plus.

## Installation de OpenSSH sur le PC
Sur CachyOS, `openssh` était déjà installé.

Au cas-où :
`sudo pacman -S openssh`


## Installation de JuiceSSH sur le téléphone Android

Simplement par l'appstore : [https://play.google.com/store/apps/details?id=com.sonelli.juicessh&hl=fr&pli=1](https://play.google.com/store/apps/details?id=com.sonelli.juicessh&hl=fr&pli=1)


## Activer et démarrer le service SSH
```
sudo systemctl enable sshd
sudo systemctl start sshd
```

On peut vérifier que le service tourne avec : `sudo systemctl status sshd`
On devrait voir : `Active: active (running).`

## Pare-feu

CachyOS active **ufw** par défaut.

Il faut donc ouvrir l'utilisation ssh :

```
sudo pacman -S ufw
sudo ufw enable
sudo ufw allow ssh
```

## Récupérer l'IP du PC

La commande `ip a` suffit.
Une interface ethernet sera probablement `eno1` et une interface wifi sera certainement `wlan0`. LIP est juste après "inet 192.168.x.YYY"


## dans le téléphone

1) On lance JuiceSSH
2) On crée une nouvelle identité qui dans "utilisateur" aura le nom d'utilisateur sur le PC (par exemple "leloinadrass") etle mot de passe associé.
3) On crée une connexion dans laquelle on renseigne l'IP du PC et on choisit la bonne identité.

Normalement, ça se connecte et on a accès au terminal du PC.

Pour une utilisation à distance, il faudra prévoir d'autres étapes, comme l'édition des règles NAT et une connexion par clé SSH pour ne pas transformer le réseau local en gruyère.
