# Verhoogde T- en B-celreceptorsignalering in synoviaal weefsel van vrouwen met reumatoïde artritis: een transcriptomische analyse

## Inleiding
Reumatoïde artritis (RA) is een chronische auto-immuunziekte die ontstekingen veroorzaakt in het synovium (gewrichtsslijmvlies) . De ziekte komt vooral voor bij oudere vrouwen en zorgt voor pijn in de gewrichten, gepaard met stijfheid en vermoeidheid. De oorzaken van de ziekte zijn nog onbekend, al lijken er verbindingen te zijn met genetische- en omgevingsfactoren (Tobón et al., 2010).

Onderzoek waarbij synoviaal weefsel van RA-patiënten is vergeleken met dat van osteoartrose-patiënten laat zien dat T-cellen, B-cellen en monocyten in dit weefsel actief bijdragen aan een ontstekingsreactie, door verhoogde expressie van chemokine-genen (Zhang et al., 2022). Dit laat zien dat de ziekteactiviteit van RA niet alleen het resultaat is van gewrichtslijtage, maar wordt gedreven door een celtype-specifiek ontstekingsprogramma. Transcriptomics-analyse maakt het mogelijk om deze celtype-specifieke ontstekingsprocessen op genniveau in kaart te brengen, doordat verschillen in genexpressie tussen ziek en gezond weefsel zichtbaar worden. 

Welke specifieke genen en pathways hierbij betrokken zijn, is echter nog niet volledig in kaart gebracht. Om te onderzoeken welke genen meer/minder tot expressie komen en wat dit voor invloed kan hebben op de ziekteactiviteit van RA is de volgende hoofdvraag met deelvragen opgesteld: Welke genen komen meer/minder tot expressie bij mensen met RA en welke invloed heeft dit op het immuunsysteem/ziekteproces van RA?;
* Welke genen komen significant meer/minder tot expressie bij mensen met RA?
* Welke gen-ontologie termen zijn het sterkst verrijkt onder de genen die significant meer/minder tot expressie komen bij mensen met RA? 
* Welke genen binnen de RA- en T-celreceptor-signaleringspathway komen meer/minder tot expressie, en welke rol spelen deze in het ziekteproces?

## Methode
### Dataset en studiepopulatie
Om te kijken naar een verschil in genexpressie zijn monsters uit het gewrichtsslijmvlies van 4 mensen met RA en 4 gezonde mensen (controle) vergeleken. Deze dataset is afkomstig uit het onderzoek van Platzer (2019). Alle deelnemers waren van het vrouwelijk geslacht; de controlegroep was 15-42 jaar oud, de RA-groep 54-66 jaar (tabel 1).

Tabel 1: Dataset van 2 groepen, Controle en RA. Waarvan elke groep bestaat uit 4 samples; de controlegroep was 15-42 jaar oud, de RA-groep 54-66 jaar. 
| SampleName | Leeftijd | Groep   |
|------------|----------|---------|
| SRR4785819 | 31       | Control |
| SRR4785820 | 15       | Control |
| SRR4785828 | 31       | Control |
| SRR4785831 | 42       | Control |
| SRR4785979 | 54       | RA      |
| SRR4785980 | 66       | RA      |
| SRR4785986 | 60       | RA      |
| SRR4785988 | 59       | RA      |

### Software en packages
Voor dit onderzoek is R (4.6.0) gebruikt (Download R-4.6.0 For Windows. The R-project For Statistical Computing., z.d.), en voor het installeren van packages BiocManager (1.30.27) (Bioconductor - Install, z.d.). De volgende packages zijn gebruikt: Rsubread (2.26.0) (Rsubread, z.d.-b) voor mapping en het maken van de countmatrix, Rsamtools (2.28.0) (RSAmTools, z.d.) voor het verwerken van de alignment-bestanden, DESeq2 (1.52.0) (Thelovelab, z.d.) en EnhancedVolcano (Kevinblighe, z.d.) voor de differentiële genexpressie-analyse, goseq (1.64.0) (Federicomarini, z.d.) en GO.db (3.23.1) (GO.DB, z.d.) voor de GO-analyse, en KEGGREST (1.52.2) (KEGGREST, z.d.) en pathview (1.52.0) (Datapplab, z.d.) voor de pathway-visualisatie. dplyr (1.2.1) (A Grammar Of Data Manipulation, z.d.) en readr (2.2.0) (Readr Package - RDocumentation, z.d.) zijn gebruikt voor algemene datamanipulatie.

### Mapping en countmatrix
De reads zijn gemapt met Rsubread, met het humane genoom (GRCh38.p14, NCBI) als referentiegenoom. Het genoom is geïndexeerd en de reads zijn aligned met Rsubread en Rsamtools ([Script 1](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_1.R)). Vervolgens is een countmatrix gemaakt met Rsubread, aan de hand van een GTF-bestand van hetzelfde NCBI-genoom (Homo Sapiens Genome Assembly GRCh38.p14, z.d.) ([Script 2](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_2.R)).

### Differentiële genexpressie-analyse
Met DESeq2 is een differentiële genexpressie-analyse uitgevoerd. Genen werden als significant differentieel tot expressie beschouwd bij p < 0,05 en een log2 fold change van < -1 of > 1. De resultaten zijn gevisualiseerd in een volcano plot met EnhancedVolcano ([Script 3](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_3.R)).

### GO- en pathway-analyse
Om te bepalen welke biologische processen betrokken zijn bij de gevonden expressieverschillen, is een gene-ontologie (GO)-analyse uitgevoerd met goseq en dplyr. Op basis van de GO-resultaten, waarvan een groot deel gerelateerd was aan RA, is vervolgens de algemene RA-pathway (hsa05323) bekeken, met extra verdieping op de T-celreceptor-signaleringspathway (hsa04660). Beide pathways zijn gevisualiseerd met KEGGREST en pathview ([Script 3](https://github.com/MerlinLightmoon/Transcriptomics-Reuma-Artritius-Casus/blob/main/Scripts/Casus_3.R)).

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

Uit de differentiële genexpressie-analyse kwamen 4572 genen naar voren die significant meer of minder tot expressie kwamen bij vrouwen met RA vergeleken met gezonde controles (p < 0,05, |log2FC| > 1), met de sterkste veranderingen bij ANKRD30BL, MT-ND6, SLC9A3R2 en ZNF598, die alle verlaagd tot expressie kwamen bij RA-patiënten.

De GO-analyse liet zien dat de sterkst verrijkte gen-ontologietermen onder deze genen vrijwel allemaal gerelateerd zijn aan immuunsysteemprocessen, wat aansluit bij het auto-immune karakter van RA.

Binnen de RA-pathway kwamen met name genen behorend tot de T-celreceptor- en B-celreceptor-signaleringsroutes sterker tot expressie bij RA-patiënten. Nadere analyse van de T-celreceptorpathway liet zien dat deze route weliswaar wordt geactiveerd, maar verderop in de cascade wordt afgeremd, wat duidt op een verstoorde regulatie van T-celactivatie bij RA.

Samengenomen wijzen deze bevindingen erop dat bij vrouwen met RA vooral genen betrokken bij T- en B-celgemedieerde immuunrespons afwijkend tot expressie komen. Zoals Hamza (2012) beschrijft, kan een verhoogde activiteit van T- en B-celreceptor-signalering bijdragen aan een verhoogde aanmaak van deze celtypen, wat een mogelijke verklaring biedt voor de chronische ontstekingsreactie die kenmerkend is voor RA. Hierbij moet echter worden opgemerkt dat het mediane leeftijdsverschil van 28 jaar tussen de RA- en controlegroep een deel van de gevonden immuungerelateerde expressieverschillen kan verklaren, onafhankelijk van RA-status, aangezien immuunfunctie ook met veroudering verandert. Dit maakt de gevonden associaties minder eenduidig en onderstreept het belang van een grotere, leeftijdsgematchte steekproef in vervolgonderzoek.

## Bronnen
* Aletaha, D., & Smolen, J. S. (2018). Diagnosis and Management of Rheumatoid Arthritis. JAMA, 320(13), 1360. https://doi.org/10.1001/jama.2018.13103

* A Grammar of Data Manipulation. (z.d.). https://dplyr.tidyverse.org/

* Bioconductor - Install. (z.d.). https://bioconductor.org/install/

* Datapplab. (z.d.). GitHub - datapplab/pathview: pathway based data integration and visualization. GitHub. https://github.com/datapplab/pathview

* Download R-4.6.0 for Windows.  The R-project for statistical computing. (z.d.). https://cran.r-project.org/bin/windows/base/

* Federicomarini. (z.d.). GitHub - federicomarini/goseq. GitHub. https://github.com/federicomarini/goseq

* GO.DB. (z.d.). Bioconductor. https://bioconductor.org/packages/release/data/annotation/html/GO.db.html

* Hamza, N. (2012). Analysis of B cell selection in autoimmune diseases. The University Of Groningen Research Portal. https://research.rug.nl/en/publications/analysis-of-b-cell-selection-in-autoimmune-diseases/

* Homo sapiens genome assembly GRCh38.p14. (z.d.). NCBI. https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/

* KEGG PATHWAY: Rheumatoid arthritis - Homo sapiens (human). (z.d.). https://www.kegg.jp/kegg-bin/show_pathway?hsa05323 

* KEGG PATHWAY: T cell receptor signaling pathway - Homo sapiens (human). (z.d.). https://www.kegg.jp/pathway/hsa04660

* KEGGREST. (z.d.). Bioconductor. https://bioconductor.org/packages/release/bioc/html/KEGGREST.html

* Kevinblighe. (z.d.). GitHub - kevinblighe/EnhancedVolcano: Publication-ready volcano plots with enhanced colouring and labeling. GitHub. https://github.com/kevinblighe/EnhancedVolcano

* Majithia, V., & Geraci, S. A. (2007). Rheumatoid Arthritis: Diagnosis and Management. The American Journal Of Medicine, 120(11), 936–939. https://doi.org/10.1016/j.amjmed.2007.04.005

* Platzer, A., Nussbaumer, T., Karonitsch, T., Smolen, J. S., & Aletaha, D. (2019). Analysis of gene expression in rheumatoid arthritis and related conditions offers insights into sex-bias, gene biotypes and co-expression patterns. PLoS ONE, 14(7), e0219698. https://doi.org/10.1371/journal.pone.0219698

* readr package - RDocumentation. (z.d.). https://www.rdocumentation.org/packages/readr/versions/2.1.5

* RSAmTools. (z.d.). Bioconductor. https://www.bioconductor.org/packages/release/bioc/html/Rsamtools.html

* Rsubread. (z.d.). Bioconductor. https://bioconductor.org/packages/release/bioc/html/Rsubread.html

* Zhang, R., Jin, Y., Chang, C., Xu, L., Bian, Y., Shen, Y., Sun, Y., Sun, S., Schrodi, S. J., Guo, S., & He, D. (2022). RNA-seq and Network Analysis Reveal Unique Chemokine Activity Signatures in the Synovial Tissue of Patients With Rheumatoid Arthritis. Frontiers in Medicine, 9, 799440. https://doi.org/10.3389/fmed.2022.799440
