Juste un mot rapide pour expliquer que parfois on ne peut pas modifier les fichiers d'un disque préalablement formaté en NTFS.

Le principal responsable est Windows et son "Fast Startup" qui va empêcher le disque d'être démonté correctement.

Il faut repérer quel est le disque en NTFS dans l'arborescence des disques. Souvent quelque chose de la forme "/dev/sdXi" avec X une lettre et i un entier. Par exemple `/dev/sdb1` ou `/dev/sda3`.

On va réparer ça, mais il faut d'abord démonter le disque en question. 

`SUdo umount /mnt/DISQUE` 
en remplaçant /mnt/DISQUE par le vrai point de montage qui peut être différent. 

Ensuite on va lancer **ntfsfix** :
`sudo ntfsfix /dev/sdX1`

Ce que fait ntfsfix :
- Répare les erreurs basiques du système de fichiers
- Réinitialise le journal NTFS
- Supprime l’état "hibernation" si présent


On va ensuite remonter le disque avec les bonnes options :
```
sudo mount -t ntfs-3g -o permissions,nls=iso8859-1,users,auto,exec /dev/sdX1 /mnt/Data
```

Evidemment, si on veut monter régulièrement ce disque avec les bonnes options, il va falloir éditer le fichier **fstab** qui contient ces informations. De plus j'ai remarqué que les options de montage disponible dans le gestionnaire de partitions de KDE ou Gparted ne me permettaient pas toujours de les saisir convenablement. Donc l'édition du fstab est la meilleure idée.

1) Obtenir l'UUID de la partition : `sudo blkid /dev/sdXi`
2) Repérer l'UUDI : le terminal a renvoyé "/dev/sdXi: UUID="1234-ABCD" TYPE="ntfs"" , l'UUID est 1234-ABCD
3) Editer FSTAB : `sudo nano /etc/fstab`
4) Ajouter à la fin OU modifier la ligne :
   ```UUID=Z123Z12X12Z1234F                       /mnt/donnees   ntfs-3g permissions,nls=iso8859-1,users,auto,exec                        0 0```

**Remarque :** L'UUID peut avoir plusieurs formes. Par exemple :  1d5026db-68cg-2b0a-ab2f-7e07dc047650

Normalement le disque devrait être monté automatiquement au démarrage avec les bonnes options et on aura un accès complet.
