Sous CachyOS, j'ai rencontré un problème que je n'avais pas eu sous Manjaro : avec deux écrans qui ont une densité de pixels différentes, 
j'ai demandé au système d'augmenter l'échelle de mon grand écran à 125%, et la suite LibreOffice avait des menus microscopiques.

La solution est venue de CubicleNate :
https://cubiclenate.com/2025/05/03/fix-libreoffice-scaling-issues-on-linux/

Il faut lancer la commande avec `QT_QPA_PLATFORM=xcb libreoffice –draw`.


## Le problème :
Sous Linux, LibreOffice peut mal gérer le fractional scaling (par ex. 125 %, 150 %) sur les écrans HiDPI.

Résultat : des barres d’outils et icônes énormes ou au contraire du texte minuscule, selon l’écran et le facteur de zoom.

En ajoutant la variable d’environnement :
`QT_QPA_PLATFORM=xcb libreoffice`
LibreOffice se lance avec un rendu correct, sans problème de mise à l’échelle.

On va donc modifier nos fichiers .desktop pour que toutes les applis LibreOffice utilisent cette variable automatiquement. (Attention, le "+" présent dans le bloc doit être supprimé, il me sert à surligner en vert la ligne importante)

Par exemple :
```diff
[Desktop Entry]
Version=1.0
Terminal=false
Icon=libreoffice-writer
Type=Application
Categories=Office;WordProcessor;X-Red-Hat-Base;
+ Exec=QT_QPA_PLATFORM=xcb libreoffice --writer %U
MimeType=application/clarisworks;application/docbook+xml;application/macwriteii;application/msword;application/prs.plucker;application/rtf;application/vnd.apple.pages;application/vnd.lotus-wordpro;application/vnd.ms-word;application/vnd.ms-word.document.macroEnabled.12;application/vnd.ms-word.template.macroEnabled.12;application/vnd.ms-works;application/vnd.oasis.opendocument.text;application/vnd.oasis.opendocument.text-flat-xml;application/vnd.oasis.opendocument.text-master;application/vnd.oasis.opendocument.text-master-template;application/vnd.oasis.opendocument.text-template;application/vnd.oasis.opendocument.text-web;application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/vnd.openxmlformats-officedocument.wordprocessingml.template;application/vnd.palm;application/vnd.stardivision.writer-global;application/vnd.sun.xml.writer;application/vnd.sun.xml.writer.global;application/vnd.sun.xml.writer.template;application/vnd.wordperfect;application/wordperfect;application/x-abiword;application/x-aportisdoc;application/x-doc;application/x-extension-txt;application/x-fictionbook+xml;application/x-hwp;application/x-iwork-pages-sffpages;application/x-mswrite;application/x-pocket-word;application/x-sony-bbeb;application/x-starwriter;application/x-starwriter-global;application/x-t602;text/plain;text/rtf;
Name=LibreOffice Writer
GenericName=Word Processor
GenericName[en]=Word Processor
Comment=Create and edit text and graphics in letters, reports, documents and Web pages.
Comment[en]=Create and edit text and graphics in letters, reports, documents and Web pages.
StartupNotify=true
X-GIO-NoFuse=true
Keywords=Text;Letter;Fax;Document;OpenDocument Text;Microsoft Word;Microsoft Works;Lotus WordPro;OpenOffice Writer;CV;odt;doc;docx;rtf;
InitialPreference=5
StartupWMClass=libreoffice-writer
X-KDE-Protocols=file,http,webdav,webdavs

```

## Pourquoi ça marche ?

Qt (la bibliothèque graphique utilisée par LibreOffice avec le plugin KDE/Qt) choisit un “QPA backend” (Qt Platform Abstraction) pour dialoguer avec le serveur d’affichage.

Par défaut, sous KDE Plasma 6.x en session Wayland, LibreOffice utilise le backend Wayland.

Or, le backend Wayland de Qt gère encore mal le fractional scaling → d’où les incohérences (UI trop grosse ou trop petite).

En forçant QT_QPA_PLATFORM=xcb :

- On oblige LibreOffice à utiliser le backend X11/XCB.
- Sous Wayland, ça passe par XWayland, une couche de compatibilité qui fait tourner les applis X11 dans Wayland.
- XWayland applique le facteur de scaling de manière plus uniforme et prévisible → l’interface retrouve une taille correcte.

Bonus : l’auteur note aussi que le scrolling devient plus fluide, car Wayland introduisait parfois du lag avec LibreOffice.
