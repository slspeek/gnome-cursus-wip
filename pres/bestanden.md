---
marp: true
theme: gaia
title: Bestanden
---
### Bestanden ![width=50px](img/bestanden-icon.png)

- Bestanden op Linux

- Wat kunt u met de bestandsbeheerder?

- Openen en sluiten van de bestandsbeheerder

- Verschillende views

- Navigeren

- Mappen maken

- Bestanden of mappen verplaatsen

---
### Bestanden ![width=50px](img/bestanden-icon.png) vervolg

- Eigenschappen van bestanden en mappen 

- Zoeken van mappen of bestanden
    
- Bladwijzer maken van map of lokatie

- Bestanden inpakken en uitpakken

---
#### Bestanden op Linux

- bovenste map in de bestandsstructuur is ```/``` ('root' genoemd)

- fysieke volumes (indien er meerdere disks zijn)

    - geen drive-letters ```C:```, ```D:``` etc.

    - aankoppelpunten zijn (lege) mappen (bijvoorbeeld ```/mnt```, ```/media/<XXXX>```)

-  geen backslashes (```\```), maar forward-slashes (```/```) als map scheidingsteken

---
### Bestands of map locaties als paden
Een pad is een aanduiding van bestands of map locatie in termen van bovenliggende mappen. Absolute paden beginnen met een ```/``` en relatieve paden niet.

Voorbeelden:
- ```Documenten/Geschiedenis``` is de map waar je komt door vanuit de huidige map de map ```Documenten``` in te gaan en dan de map ```Geschiedenis``` in te gaan. Merk op dat dit een relatief pad is omdat het niet met ```/``` begint.

---
### Meer pad voorbeelden
- ```/usr/bin``` is een absoluut pad waar je komt door vanuit ```/``` de map ```usr``` in te gaan en dan de map ```bin``` in te gaan.
- ```/home/tux/Documenten``` is het absolute pad van de ```Documenten``` map in de thuismap van gebruiker ```tux```.

---
#### [Filesystem Hierarchy Standard](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/index.html)
De standaard die de paden van belangrijke mappen definieert voor Linux.

-  ```/home``` hieronder staan alle thuismappen

- ```/usr/bin``` hieronder staan de toepassingen

- ```/media``` hieronder leven alle aankoppelbare media zoals USB-sticks

-  [*thuismap*](https://nl.wikipedia.org/wiki/Homedirectory) van gebruiker ```tux``` is ```/home/tux```. Deze map heet "Persoonlijke map" in de bestandsbeheerder.

---
##### Voorbeeld USB-stick onder ```/media/tux```

![width:1000px](img/bestanden-usb-stick-pad.gif)

---
#### Wat kunt u met de bestandsbeheerder?

- inhoud van een map bekijken

- bestanden openen

- bestanden of mappen verplaatsen of kopiëren

- zoeken in bestanden

- archieven aanmaken, inzien en uitpakken

---
#### Openen en sluiten van de bestandsbeheerder

- Openen

    - ```SUPER+E```, ```SUPER+4``` of ```SUPER best ENTER```

    - klikken op ![width:50px](img/bestanden-icon.png) op de dash

    - extra venster ```CTRL+N```    

- Sluiten

    - ```CTRL+W``` of ```ALT+F4``` om een venster te sluiten

    - ```CTRL+Q``` af te sluiten (alle vensters sluiten)

---
##### Voorbeeld een afbeelding openen
![width:1000px](img/bestanden-open-afbeelding.gif)

---
##### Voorbeeld de begrippenlijst openen
![width:1000px](img/bestanden-open-begrippen-pdf.gif)

---
#### Verschillende views

- rasterweergave ![width:50px](img/knop-icon-weergave.png) ```CTRL+2```

- lijstweergave ![width:50px](img/knop-lijst-weergave.png) ```CTRL+1```

- wel of geen verborgen bestanden tonen ```CTRL+H```

---
##### Voorbeeld wisselen tussen raster- en lijstweergave

![width:1000px](img/bestanden-wisselen-raster-lijst.gif)

---
##### Voorbeeld wel of geen verborgen bestanden tonen

![width:1000px](img/bestanden-wel-niet-verborgen.gif)

---
#### Omlaag en omhoog navigeren

- omlaag navigeren door op een map te dubbelklikken

- omhoog te navigeren door in de adresbalk op bovenliggende map te klikken

    - ```ALT+↑```
---
##### Voorbeeld navigeren in Afbeeldingen map

![width:1000px](img/bestanden-omlaag-omhoog-navigeren.gif)

---
#### Mappen maken

- via de drie puntjes boven elkaar ![](img/persoonlijke-map-menu.png)

    - dit is het actiemenu (bereikbaar via ```F10```)

- ```CTRL+SHIFT+N```

---
#### Bestanden of mappen verplaatsen of kopiëren

- Drag and drop 
    
    - sleep ze naar gewenste map voor verplaatsen

    - sleep ze met ```CTRL``` ingedrukt om te kopiëren

- Knippen, kopiëren en plakken

    - knippen ```CTRL+X```, kopiëren ```CTRL+C``` en plakken ```CTRL+V```

    - via het context menu van het bestand

---
##### Voorbeeld bloemen organiseren

![width:1000px](img/bestanden-mappen-maken-en-slepen.gif)

---
##### Voorbeeld kopie maken van map

![width:1000px](img/bestand-kopieren-via-context-menu.gif)

---
##### Voorbeeld schermopname verplaatsen

![width:1000px](img/bestanden-schermopname-verplaatsen.gif)

---
#### In de prullenbak gooien en herstellen uit de prullenbak

- Onnodige bestanden en of mappen kunt u in de prullenbak gooien

    - Ze staan dan niet meer tussen uw belangrijke bestanden

    - Rechtsklikken op bestand om het context menu te openen en "In Prullenbak gooien" kiezen

    - ```DELETE```

- Indien u zich bedenkt kunt u ze terughalen uit de prullenbak

    - Ga naar "Prullenbak"

    - Open het context menu van het bestand en kies "Terughalen uit Prullenbak"
---
##### Voorbeeld Video's in de prullenbak gooien

![width:1000px](img/bestanden-in-en-uit-prullenbak.gif)

---
#### Prullenbak legen

- Indien u de schijfruimte terug wilt hebben die de bestanden in "Prullenbak" innemen kunt u de prullenbak legen

- Ga naar de "Prullenbak" in de bestandsbeheerder en kies "Prullenbak legen" uit het actiemenu
    
    ![height:300px](img/bestanden-prullenbak-legen.png)

---
#### Eigenschappen van bestanden en mappen 

- Kies "Eigenschappen" uit het context menu

- ```ALT+ENTER```

---
##### Voorbeeld eigenschappen van een map

![width:1000px](img/bestanden-mapeigenschappen.gif)

---
##### Voorbeeld afbeeldingseigenschappen

![width:1000px](img/bestanden-afbeeldingseigenschappen.gif)

---
#### Zoeken van mappen of bestanden

- klik op ![width:50px](img/bestanden-vergrootglas.png)

- ```CTRL+F```

---
##### Voorbeeld zoeken in document

- opzoeken Trechterbekercultuur op Wikipedia

- pagina als pdf opslaan in "Documenten"

- bestandsbeheerder openen

- zoeken naar "neolithische"
---
##### Voorbeeld zoeken in document

![width:1000px](img/bestanden-zoek-in-inhoud.gif)

---
#### Bladwijzer maken van map of lokatie

- Navigeer naar map

    - actiemenu: "Toevoegen aan bladwijzers"

    - ```CTRL+D```

- Sleep map naar linkerpaneel boven "Nieuwe bladwijzer"

- Verwijderen door rechts te klikken op de bladwijzer in het linkerpaneel
en "Verwijderen uit bladwijzers" in het popup menu te kiezen

---
##### Voorbeeld bladwijzer maken met menuoptie

![width:1000px](img/bestanden-bladwijzer-via-menu.gif)

---
##### Voorbeeld bladwijzer maken door te slepen

![width:1000px](img/bestanden-bladwijzer-slepen.gif)

---
#### Bestanden inpakken en uitpakken

- Bestanden inpakken

    - Meerdere bestanden en of mappen in één archief bestand opslaan

    - Open het context menu van de map, het bestand of de bestandsselectie en kies "Inpakken ..."
        
        - Geef een archief naam op

        - Klik op "Maken"

---
##### Voorbeeld archief aanmaken

![width:1000px](img/bestanden-inpakken.gif)

---
- Archief bestand uitpakken

    1. Kies "Uitpakken naar ..." uit context menu van het zip archief

        - Kies een map waarheen het archief moet worden uitgepakt

        - Bevestig dit door op "Selecteren" te klikken


    1. Kies "Uitpakken" uit het context menu. Dit pakt het archief uit in de map waar het archief staat.

---
##### Voorbeeld archief uitpakken naar ...

![width:1000px](img/bestanden-uitpakken-naar.gif)

---
##### Voorbeeld archief uitpakken

![width:1000px](img/bestanden-uitpakken.gif)

---
#### Archief bestand inzien

- dubbelklik zip bestand
---
##### Voorbeeld inzien archief

![width:1000px](img/bestanden-inzien-archief.gif)

---
#### Hulp opvragen over de bestandsbeheerder

- Hulp opvragen

    - via het hamburgermenu ![height:40px](img/firefox-hamburgermenu.png) en dan "Hulp"

    - sneltoets ```F1```

    - ```CTRL+W``` om te sluiten

- Sneltoetsen tonen

    - via het hamburgermenu ![height:40px](img/firefox-hamburgermenu.png) en dan "Sneltoetsen"

    - sneltoets ```SHIFT+CTRL+?```

        - ```PAGEUP``` en ```PAGEDOWN``` om te navigeren, ```ESC``` om te sluiten 
---
##### Voorbeeld hulp over sorteren opvragen

![width:1000px](img/bestanden-hulp-sorteren.gif)

---
##### Voorbeeld sneltoetsen voor de bestandsbeheerder tonen

![width:1000px](img/bestanden-sneltoetsen-tonen.gif)

