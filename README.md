# Transcriptomics Casus Reuma Artritius

## Inleiding
Reumatoïde artritis (RA) is een chronische auto-immuunziekte die vooral veel voorkomt bij vrouwen op oudere leeftijd. De ziekte veroorzaakt ontstekingen in de gewrichten, die ontstaan doordat het lichaam het slijmvlies in de gewrichten aanvalt. Dit zorgt voor pijn in de gewrichten, gepaard met stijfheid en vermoeidheid. RA is ongeneesbaar, maar wel te behandelen met reumaremmers en pijnstillers (Majithia & Geraci, 2007).

5 op de 1000 mensen hebben RA (Aletaha & Smolen, 2018). Desondanks zijn de precieze oorzaken van de ziekte nog onbekend, al lijken onderzoeken aan te duiden dat er verbindingen zijn met genetische- en omgevingsfactoren (Tobón et al., 2010). Daarom is het belangrijk om te onderzoeken welke genen meer of minder tot expressie komen bij mensen met RA. In dit onderzoek wordt met transcriptomics bekeken welke genen in het gewrichtslijmvlies van mensen met RA meer of minder tot expressie komen.  

## Methode
Om te kijken naar een verschil in genexpressie, zijn monsters uit het gewrichtslijmvlies bij 4 mensen met RA en 4 gezonde mensen (controle) vergeleken. Deze mensen hebben een leeftijd tussen de 15 en 66 jaar en zijn van het vrouwelijk geslacht. Voor dit onderzoek is R (4.6.0) (Download R-4.6.0 For Windows.  The R-project For Statistical Computing., z.d.) gebruikt en voor het downloaden van packages is Biocmanager (1.30.27) (Bioconductor - Install, z.d.) gebruikt, daarnaast zijn de volgende packages gebruikt: Rsubread (2.26.0) (Rsubread, z.d.-b), Rsamtools (2.28.0) (RSAmTools, z.d.), dplyr (1.2.1) (A Grammar Of Data Manipulation, z.d.), readr (2.2.0) (Readr Package - RDocumentation, z.d.), DESeq2 (1.52.0) (Thelovelab, z.d.), KEGGREST (1.52.2) (KEGGREST, z.d.) pathview (1.52.0) (Datapplab, z.d.), goseq (1.64.0) (Federicomarini, z.d.) en GO.db (3.23.1) (GO.DB, z.d.).

Voor de eerste stappen van de analyse, zijn de reads eerst gemapt. Voor het mappen is als referentiegenoom het humane genoom (GRCh38.P14) gebruikt van NCBI (Homo Sapiens Genome Assembly GRCh38.p14, z.d.). Hierna wordt het genoom geïndexeerd en aligned ([Script 1](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_1.R)) . Vervolgens is er een countmatrix gemaakt, het gtf bestand hiervoor is ook van NCBI gedownload (Homo Sapiens Genome Assembly GRCh38.p14, z.d.) ([Script 2](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_2.R)). Waarna een volcano plot is gemaakt om de statistisch significante genen die differentieel tot expressie komen te visualiseren na het analyseren ([Script 3](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_3.R)). 

Daarna is een gene-ontologie (GO) -analyse uitgevoerd om te bepalen welke biologische processen betrokken zijn bij de verandering in genexpressie. Na het observeren van de GO-analyse is gekozen om te kijken naar de algemene RA pathway (hsa05323), aangezien veel van de GO-termen uit de GO-analyse hier een connectie mee hebben. Ook is er meer verdiept in de T-Cell receptor signaling pathway (hsa04660).

<p align="center">
  <img src="Assets/Workflow.png" alt="Workflow.png" width="600"/>
</p>
Figuur 1: De visuele weergave van de workflow van de toegepaste methodes. Waar data is verkregen dat is bemonsterd van 8 vrouwen (4 gezond, 4 met RA) tussen de leeftijd van 15 tot 67 jaar. Eerst worden deze reads gemapped, waarna een count matrix wordt gemaakt voor de statistische analyse. Vervolgens wordt van de significante resultaten uit de statistische analyse (p < 0.05 en een fold change van < -1 en > 1) een volcano plot gemaakt. Hierna wordt ook een GO-analyse gedaan met visualisatie en worden 2 pathways gevisualiseerd (hsa05232 & hsa04660)

## Resultaten
Om te meten wat voor verschil in genexpressie er is tussen mensen met RA en gezonde mensen, zijn er monsters uit het gewrichtslijmvlies bij 4 vrouwen met RA en 4 gezonde vrouwen (controle) vergeleken. Na de analyse zijn de reads gevisualiseerd met een volcano plot. Hierna is ook een GO-analyse uitgevoerd en gevisualiseerd en 2 pathways weergegeven. 

### Volcano Plot

Het volcano plot geeft 4572 statistisch significante genen weer die meer/minder tot expressie komen bij RA-patiënten ten opzichte van gezonde personen (p < 0.05 en een fold change van < -1 en > 1) (figuur 2). Het gen met de hoogste fold change en de laagste p-waarde is ANKRD30bl, dat wordt gevolgd door de genen: MT-ND6, SLC9A3R2 en ZNF598. Dit betekent dat deze genen (p < 0.05) minder worden afgeschreven bij de vrouwen met RA.

<p align="center">
  <img src="Assets/Volcanoplot.png" alt="Volcanoplot.png" width="600"/>
</p>
Figuur 2: Een volcano plot die de genen met een p-waarde van < 0.05 en een fold change van < -1 en > 1 weergeeft. Hier zijn de -log2p-value genen in het rood weergegeven, de log2FC genen in het groen en de niet statistisch significante genen in het grijs grijs.

### GO-analyse

De plot van de GO-analyse geeft de top 10 enriched Gene Ontology-termen weer van de significante genen uit figuur 2 (p < 0,05 en een fold change van < -2 en > 2) (figuur 3). Door de top 10 GO-termen is te zien dat de meeste biologische processen te maken hebben met het immuunsysteem. Dat het een logische connectie maakt met RA, aangezien het een auto-immuunziekte is.

<p align="center">
  <img src="Assets/GO analyse.png" alt="GO analyse.png" width="600"/>
</p>
Figuur 3: Plot van de GO-analyse, waar de top 10 enriched Gene Ontology-termen zijn weergegeven van de significante genen uit figuur 2 (p < 0,05 en een fold change van < -2 en > 2).

### KEGG Pathway RA

In figuur 4 is de algemene RA KEGG-pathway te zien. Hier zijn de genen die minder tot expressie komen in het groen aangegeven en de genen die niet meer tot expressie komen in het rood. Hier is vooral te zien dat de genen in verband met de T-cell receptor signaling pathway en B-Cell receptor signaling pathway meer tot expressie komen dan bij gezonde mensen. 

<p align="center">
  <img src="Assets/hsa05323.pathview.png" alt="hsa05323.pathview.png" width="600"/>
</p>
Figuur 4: De algemene KEGG-pathway van RA, waarin met rood de genen worden weergegeven die meer tot expressie komen en in groen de genen die minder tot expressie komen. (KEGG PATHWAY: Rheumatoid Arthritis - Homo Sapiens (Human), z.d.).

### KEGG Pathway T-Cell receptor signaling

In figuur 5 is de KEGG-pathway van T-Cell receptor signaling te zien. Wat hier vooral wordt weergegeven, is dat de T-cellereceptorroute wel wordt geactiveerd, maar vervolgens later wordt afgeremd. 

<p align="center">
  <img src="Assets/hsa04660.pathview.png" alt="hsa04660.pathview.png" width="600"/>
</p>
Figuur 5: De KEGG-pathway van T-Cell receptor signaling, waarin met rood de genen worden weergegeven, die meer tot expressie komen en in groen de genen die minder tot expressie komen. (KEGG PATHWAY: T Cell Receptor Signaling Pathway - Homo Sapiens (Human), z.d.).


## Conclusie

Om te meten wat voor verschil in genexpressie er is tussen mensen met RA en gezonden mensen, zijn er monsters uit het gewrichtslijmvlies bij 4 vrouwen met RA en 4 gezonde vrouwen (controle) vergeleken. Uit de resultaten is gekomen dat veel genen die significant meer/minder tot expressie komen met het imuunsysteem te maken hebben. Door de verhoogde expressie van genen voor de synthese van B- & T-Cellen, worden er meer B- & T-Cellen aangemaakt, wat voor meer klachten zou kunnen zorgen (Hamza, 2012).

## Bronnen
* A Grammar of Data Manipulation. (z.d.). https://dplyr.tidyverse.org/

* Hamza, N. (2012). Analysis of B cell selection in autoimmune diseases. The University Of Groningen Research Portal. https://research.rug.nl/en/publications/analysis-of-b-cell-selection-in-autoimmune-diseases/

* Aletaha, D., & Smolen, J. S. (2018). Diagnosis and Management of Rheumatoid Arthritis. JAMA, 320(13), 1360. https://doi.org/10.1001/jama.2018.13103

* Bioconductor - Install. (z.d.). https://bioconductor.org/install/

* Datapplab. (z.d.). GitHub - datapplab/pathview: pathway based data integration and visualization. GitHub. https://github.com/datapplab/pathview

* Download R-4.6.0 for Windows.  The R-project for statistical computing. (z.d.). https://cran.r-project.org/bin/windows/base/

* Federicomarini. (z.d.). GitHub - federicomarini/goseq. GitHub. https://github.com/federicomarini/goseq

* GO.DB. (z.d.). Bioconductor. https://bioconductor.org/packages/release/data/annotation/html/GO.db.html

* Homo sapiens genome assembly GRCh38.p14. (z.d.). NCBI. https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/

* KEGG PATHWAY: Rheumatoid arthritis - Homo sapiens (human). (z.d.). https://www.kegg.jp/kegg-bin/show_pathway?hsa05323 

* KEGG PATHWAY: T cell receptor signaling pathway - Homo sapiens (human). (z.d.). https://www.kegg.jp/pathway/hsa04660

* KEGGREST. (z.d.). Bioconductor. https://bioconductor.org/packages/release/bioc/html/KEGGREST.html

* Majithia, V., & Geraci, S. A. (2007). Rheumatoid Arthritis: Diagnosis and Management. The American Journal Of Medicine, 120(11), 936–939. https://doi.org/10.1016/j.amjmed.2007.04.005

* readr package - RDocumentation. (z.d.). https://www.rdocumentation.org/packages/readr/versions/2.1.5

* RSAmTools. (z.d.). Bioconductor. https://www.bioconductor.org/packages/release/bioc/html/Rsamtools.html

* Rsubread. (z.d.). Bioconductor. https://bioconductor.org/packages/release/bioc/html/Rsubread.html
