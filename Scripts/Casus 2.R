### Inladen & Packages ----
setwd("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus")
load("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus/Script/Casus 2 enviroment.RData")
library(Rsubread)
library(readr)
library(dplyr)
library(Rsamtools)

### 1_GTF_preppen ----
#GTF (GTF = Gene Transfer Format). Deze is te downloaden via NCBI, waar ook de refseq te vinden was

#GTF bestand inladen en colnames maken
GTF_RA <- read_tsv("Raw/genomic.gtf", comment = "#", col_names = FALSE)
colnames(GTF_RA) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes")

#Specifiek de regel gene selecteren en naam type naar exon omzetten voor de featureCounts voor count matrix
GTF_gene_RA <- GTF_RA %>% filter(type == "gene")
GTF_gene_RA$type <- "exon"

### 2_Count_matrix_creëeren ----
#Vector voor alle BAM-file voor in de count matrix
allsamples <- c("Data/2_Mapping/control1.BAM", "Data/2_Mapping/control2.BAM", "Data/2_Mapping/control3.BAM", "Data/2_Mapping/control4.BAM", "Data/2_Mapping/RA1.BAM", "Data/2_Mapping/RA2.BAM", "Data/2_Mapping/RA3.BAM", "Data/2_Mapping/RA4.BAM")
##Bij count matrix vergelijk je de BAM-bestanden na het mappen met de GTF
count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "Raw/genomic.gtf",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE)

### 3_Count_matrix_bekijken_en_opslaan ----
str(count_matrix)

#Counts opslaan onder nieuwe naam
counts <- count_matrix$counts
head(counts)
#Dan betere colnames
colnames(counts) <- c("control1", "control2", "control3", "control4", "RA1", "RA2", "RA3", "RA4")
head(counts)
#Sla hem als .csv bestand op om hem in een nieuw script in te kunnen lezen
write.csv(counts, "human_countmatrix.csv")

##
###Deze code hierboven is niet gebruikt aangezien het te groot was, inplaats daarvan is een txt file verkregen van de count matrix die al is gespecificeerd op counts
##


### 0_Countmatrix inladen ----
count_matrix_RA <- read.table("Data/4_Count_matrix/count_matrix_RA.txt")

str(count_matrix_RA)

#betere colnames
colnames(count_matrix_RA) <- c("control1", "control2", "control3", "control4", "RA1", "RA2", "RA3", "RA4")

#count matrix met goede colnames opslaan
write.csv(count_matrix_RA, "countmatrix_RA.csv")

head(count_matrix_RA)

