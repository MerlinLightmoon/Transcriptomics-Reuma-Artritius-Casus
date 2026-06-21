### Inladen & Packages ----
install.packages('BiocManager')
BiocManager::install('Rsubread')
BiocManager::install('Rsamtools')

setwd("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus")
load("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus/Script/Casus 1 enviroment.RData")
getwd()
library(Rsubread)
library(Rsamtools)

### 1_Indexeren ----
buildindex(
  basename = 'ref_human', #naam index
  reference = 'Raw/GCF_000001405.40_GRCh38.p14_genomic.fna', #bestandnaam/locatie referentiegenoom van NCBI
  memory = 24000, #Hoeveel geheugen wordt gebruikt 
  indexSplit = TRUE) #Splitst de output in meerdere kleine bestanden

### 2_Mapping ----
#align.control1 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785819_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785819_2_subset40k.fastq", output_file = "control1.BAM")
#index = hier specifeer je de basename van je index
#readfile1 & readfile2 = de bestanden met de reads voor dit monster
#output_file = de naam van het eind bestand (is een BAM bestand: Binary Alignment/Map)

#Control
align.control1 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785819_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785819_2_subset40k.fastq", output_file = "control1.BAM")
align.control2 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785820_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785820_2_subset40k.fastq", output_file = "control2.BAM")
align.control3 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785828_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785828_2_subset40k.fastq", output_file = "control3.BAM")
align.control4 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785831_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785831_2_subset40k.fastq", output_file = "control4.BAM")

#Rheumatoid arthritis 
align.RA1 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785979_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785979_2_subset40k.fastq", output_file = "RA1.BAM")
align.RA2 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785980_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785980_2_subset40k.fastq", output_file = "RA2.BAM")
align.RA3 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785986_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785986_2_subset40k.fastq", output_file = "RA3.BAM")
align.RA4 <- align(index = "1_Index/ref_human", readfile1 = "Raw/Data_RA_Raw/SRR4785988_1_subset40k.fastq", readfile2 = "Raw/Data_RA_Raw/SRR4785988_2_subset40k.fastq", output_file = "RA4.BAM")

### 3_Gemapte reads visualiseren ----
##Dit is een controle stap van de BAM files, of alles gelukt is, dit niet niet nodig
#We visualiseren met een genomics viewer, dit geval IGV(Integrative Genomics Viewer)

samples <- c('control1', 'control2', 'control3', 'control4', 'RA1', 'RA2', 'RA3', 'RA4')
#Note, voor de volgende 2 lines of code, moeten de bestanden in de main folder van de wd zitten
#Daarna kunnen ze weer onderverdeelt wordingen in 2_Mapping en 3_Sort_map_for_IGV
##Sorteren BAM
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})

##Indexeren BAM
lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))})

#Visualiseren
#https://igv.org/app/ #Dit is de app die we gebruiken
#Referentie inladen door: Genome -> local file
#BAM files inladen door: Tracks -> local file (alles in een keer of monster per keer)
##Wat je kunt zien:
#1. Positie op het genoom: Je kijkt hier naar een regio tussen 4.000.000 en 4.010.000 op het Escherichia coli chromosoom (NC_000913.3).
#2. Coverage plot (grijze grafiek bovenaan): Toont het aantal reads dat op elke positie is gemapt.Hoe hoger de piek, hoe meer reads op die plek in het genoom.
#3. Individuele reads (grijze blokjes eronder): Elke horizontale balk is een read. Hoe meer regels onder elkaar, hoe meer reads in die regio. Ze worden uitgelijnd op het referentiegenoom.
#4. Kleuren binnen de reads Kleuren in de reads geven aan dat er een mismatch of variatie is ten opzichte van het referentiegenoom. 🟥 Rood, 🟦 Blauw, 🟩 Groen, 🟪 Paars ➜ Staan respectievelijk voor
#basen: A, T, C, G. Een hoge coverage én herhaalde kleurmutaties over meerdere reads is vaak een betrouwbaar signaal voor een echte variatie. Voor diploïden geldt dat 50% van de reads = heterozygoot en 100% van de reads = homozygoot.

