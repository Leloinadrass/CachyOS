Attention, sous CachyOS, Samba vient en version minimaliste. Il va falloir faire quelques petites choses en plus.

Honnêtement, vive Manajaro ! :(

Déjà, il faut installer samba, sous CachyOS ou sous Manjaro :
```
sudo pacman -S samba
```
Toutefois, il n'y aura pas les services dessus...

Les deux services principaux sont smb (serveur de fichiers) et nmb (NetBIOS). Si on n’utilise pas NetBIOS, nmb est optionnel.

Sur mon installation, je galérais à faire fonctionner Samba, donc j'ai recréé les services à la main. Je reviendrai dessus à la fin.

Remarque : [la DOC officielle de Manjaro est très bien](forum.manjaro.org/t/root-tip-how-to-basic-samba-setup-and-troubleshooting/100420) 

Il faut créer manuellement les dossier/fichiers :
```
sudo mkdir -p /etc/samba
sudo touch /etc/samba/smb.conf
```

Ensuite on prépare le dossier partagé :
```
sudo mkdir -p /srv/samba/public
sudo chmod -R 0777 /srv/samba/public
```
Ici, le dossier sera dans /srv/samba de façon à ne pas avoir de conflit d'accès entre le dossier utilisateur, normalement hermétique, et le dossier public qu'on veut partager. On peut aussi "ouvrir" le dossier utilisateur pour permettre à un utilisateur distant de se rendre dans un sous-dossier partagé, mais c'est moins sécuritaire et plus compliqué. Si vraiment c'est l'idée choisie, il faudra changer les droits du dossier /home/UTILISATEUR pour rendre cet accès possible avec un `chmod 711 /home/UTILISATEUR`.


Editer le fichier smb.conf :

```
sudo nano /etc/samba/smb.conf
```

exemple de contenu :
```
  GNU nano 8.6                                                                        /etc/samba/smb.conf                                                                                 
[global]
workgroup = WORKGROUP
server string = CachyOS Samba Server
server role = standalone server
map to guest = Bad User
dns proxy = no
min protocol = SMB2
max protocol = SMB3

[public]
path = /srv/samba/public
public = yes
writable = yes
printable = no
guest ok = yes
guest only = yes
create mask = 0777
directory mask = 0777
browseable = yes

```
Remarque : ce fichier a des petits soucis (`public = yes` est obsolète apparemment, et les permissions en 0777 sont un peu dégueulasses (tout le monde est root) ) donc il vaudrait mieux 0775.)



Il faut aussi activer les services.
Sous Manjaro ils sont fournis : 
```
sudo systemctl enable --now smb nmb
```
Ensuite on va utiliser avahi pour que le dossier soit visible sur le réseau :
```
sudo systemctl enable --now avahi-daemon.service avahi-daemon.socket
```
il faut aussi que le fichier `/etc/nsswitch.conf` contient :
```
hosts: files mdns4_minimal [NOTFOUND=return] dns myhostname
```
Attention: ne pas remplacer "myhostname" par le nom du PC. C’est un mot‑clé qui permet la résolution du hostname local.

Et redémarrer le service : 
```
sudo systemctl restart avahi-daemon
```

Sous CachyOS il faut aussi penser au pare-feu et laisser passer samba :
```
sudo ufw allow 137/udpforce user = nobody
sudo ufw allow 138/udp
sudo ufw allow 139/tcp
sudo ufw allow 445/tcp
```

Sur d’autres distributions, la commande `sudo ufw allow samba` suffit, mais sous CachyOS il a été nécessaire d’ouvrir explicitement les ports 137–138 (UDP) et 139/445 (TCP).


### Bonus : les services

Personnellement, j'ai recréé les services à un moment parce que sinon le terminal me disait qu'ils n'existaient pas.

Si jamais ça se re-présente, voici ce que j'ai fait :

#### Créer le service smbd.service
```
sudo nano /etc/systemd/system/smbd.service
```
et y mettre :
```
[Unit]
Description=Samba SMB Daemon
After=network.target

[Service]
ExecStart=/usr/bin/smbd --foreground --no-process-group
ExecReload=/bin/kill -HUP $MAINPID
PIDFile=/run/smbd.pid
LimitNOFILE=16384

[Install]
WantedBy=multi-user.target

```

#### #### Créer le service nmbd.service
```
sudo nano /etc/systemd/system/nmbd.service
```
et y mettre :
```
[Unit]
Description=Samba NetBIOS name server
After=network.target

[Service]
ExecStart=/usr/bin/nmbd --foreground --no-process-group
ExecReload=/bin/kill -HUP $MAINPID
PIDFile=/run/nmbd.pid
LimitNOFILE=16384

[Install]
WantedBy=multi-user.target
```

#### Recharger systemd et activer les services : 
```
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now smbd.service nmbd.service
```
