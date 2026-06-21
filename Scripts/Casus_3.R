### Inladen & Packages ----
setwd("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus")
load("C:/Users/Thijs/OneDrive - NHL Stenden/Leerjaar 3/Transcriptonics Githubpage/Casus/Script/Casus 3 enviroment.RData")
counts <- read.csv("Data/4_Count_Matrix/countmatrix_RA.csv", row.names = 1)

library(DESeq2)
library(KEGGREST)
library(EnhancedVolcano)
library(pathview)
library(goseq)
library(tidyverse)
library(GO.db)

### 1_Meta_data ----
#Tabel voor de differentiële expressieanalyse.
treatment <- c("control", "control", "control", "control", "RA" ,"RA" ,"RA" ,"RA")
treatment_table <- data.frame(treatment)
rownames(treatment_table) <- c("control1", "control2", "control3", "control4",  
                               "RA1", "RA2", "RA3", "RA4")

### 2_Statistiek ----
# Maak DESeqDataSet aan
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = treatment_table,
                              design = ~ treatment)
dds <- DESeq(dds)
resultaten <- results(dds)
#Opslaan
write.table(resultaten, file = 'Resultaten.csv', row.names = TRUE, col.names = TRUE)

#Hoeveel is significant
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

#Sorteren op opvallende genen
hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

### 3_Volcano_plot ----
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')


#Opslaan van de plot
dev.copy(png, 'Volcanoplot.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()

### 4_Go_analyse ----
#Bestand van resultaten weer inladen en in dataframe veranderen
Resultaten_GO <- read.csv("Data/5_DESeq_voor_resultaten/Resultaten.csv", sep = " ")
Resultaten_GO <- as.data.frame(Resultaten_GO)
head(Resultaten_GO)

#sigdata maken met foldchange <-2 en > 2 & P value < 0.05
sigData <- as.integer(!is.na(Resultaten_GO$padj) & Resultaten_GO$padj < 0.05 & (Resultaten_GO$log2FoldChange < -2 | Resultaten_GO$log2FoldChange > 2))
names(sigData) <- rownames(Resultaten_GO)

#PWF met genoom hg19 maken
PWF <- nullp(sigData, "hg19", "geneSymbol")

#GO-analyse zelf
GOResultaten <- goseq(PWF, "hg19", "geneSymbol", test.cats=c("GO:BP"))

GOResultaten %>% 
  top_n(10, wt=-over_represented_pvalue) %>% 
  mutate(hitsPerc=numDEInCat*100/numInCat) %>% 
  ggplot(aes(x=hitsPerc, 
             y=term, 
             colour=over_represented_pvalue, 
             size=numDEInCat)) +
  geom_point() +
  expand_limits(x=0) +
  labs(x="Hits (%)", y="GO term", colour="p value", size="Count") + theme_classic()

#Aantal genen met P value < 0.01
GOResultaten %>%
  filter(over_represented_pvalue < 0.01) %>%
  nrow()

### 5_Pathway_analyse ----
resultaten[1] <- NULL
resultaten[2:5] <- NULL

#De eerst bekeken pathway: hsa05323. RA algemeen
pathview(
  gene.data = resultaten,
  pathway.id = "hsa05323",
  species = "hsa",        
  gene.idtype = "SYMBOL",   
  limit = list(gene = 5)    
)

#De tweede bekeken pathway: hsa04660. T-Cell
pathview(
  gene.data = resultaten,
  pathway.id = "hsa04660", 
  species = "hsa",       
  gene.idtype = "SYMBOL",  
  limit = list(gene = 5)  
)
