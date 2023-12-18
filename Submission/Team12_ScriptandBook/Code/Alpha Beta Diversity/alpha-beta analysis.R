
### Set up phyloseq objects ###
install.packages("indicspecies")
install.packages("ggpubr")

#load packages
library(tidyverse)
library(dplyr)
library(phyloseq)
library(ape)
library(vegan)
library(indicspecies)
library(ggpubr)




###Getting Data Ready###

# soil metadata
metaFP <- "soil_metadata.tsv"
meta <- read.delim(file=metaFP, sep = "\t")

# OTU table
otuFP <- "filtered-feature-table.txt"
otu <- read.delim(file=otuFP, sep ="\t", skip=1)

# taxonomy file
taxFP <- "taxonomy.tsv"
tax <- read.delim(file=taxFP, sep = "\t")

# phylogenetic tree
phyloFP <- "tree.nwk"
phylo <- read.tree(file=phyloFP)

#Format OTU table 
otu_mat <- as.matrix(otu[,-1])
rownames(otu_mat) <- otu$`X.OTU.ID`
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 
class(OTU)

# Format sample metadata
samp_df <- as.data.frame(meta[,-1])
rownames(samp_df)<- meta$'X.SampleID'
SAMP <- sample_data(samp_df)
class(SAMP)

# Formatting taxonomy
tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix() 
tax_mat <- tax_mat[,-1]
rownames(tax_mat) <- tax$`Feature.ID`
TAX <- tax_table(tax_mat)
class(TAX)

# Create phyloseq object with adjusted files
soil <- phyloseq(OTU, SAMP, TAX, phylo)

#rarefy
rarecurve(t(as.data.frame(otu_table(soil))), cex=0.1)
soil_rare <- rarefy_even_depth(soil, rngseed = 1, sample.size = 4092)

save(soil_rare, file="soil_rare.RData")
save(soil, file = "soil.RData")


### Alpha diversity metrics - shannon's diversity index plots
load("soil_rare.RData")
plot_richness(soil_rare) 
plot_richness(soil_rare, measures = c("Shannon")) 

palette <- c("#DA0000","#166AD0", "#23202C")

soil_richness_shannon <- plot_richness(soil_rare, x = "Horizon", measures = c("Shannon"), col="Horizon") +
  xlab("x.SampleID") + 
  xlab(" ") +
  ylab("Alpha Richness Diversity") +
  geom_boxplot() +
  stat_compare_means(label.x.npc = 0.22, label.y.npc = 1)+
  color_palette(palette)

soil_richness_shannon

##Other alpha diversity metrics 
soil_richness_chao1 <- plot_richness(soil_rare, x = "Horizon", measures = c("Chao1")) +
  xlab("x.SampleID") +
  geom_boxplot()
soil_richness_chao1

soil_richness_simpson <- plot_richness(soil_rare, x = "Horizon", measures = c("Simpson")) +
  xlab("x.SampleID") +
  geom_boxplot()
soil_richness_simpson

soil_richness_invsimpson <- plot_richness(soil_rare, x = "Horizon", measures = c("InvSimpson")) +
  xlab("x.SampleID") +
  geom_boxplot()
soil_richness_invsimpson

##saving alpha plots
ggsave(filename = "soil_richness_shannon.png"
       , soil_richness_shannon
       , height=4, width=6)

ggsave(filename = "soil_richness_chao1.png"
       , soil_richness_chao1
       , height=4, width=6)

ggsave(filename = "soil_richness_simpson.png"
       , soil_richness_simpson
       , height=4, width=6)

ggsave(filename = "soil_richness_invsimpson.png"
       , soil_richness_invsimpson
       , height=4, width=6)

##alpha significance test
temp1 = soil_richness$data %>% filter(variable=='Shannon')
wilcox.test(value ~ Horizon, data=temp1, exact = FALSE)

temp2 = soil_richness$data %>% filter(variable=='Chao1')
wilcox.test(value ~ Horizon, data=temp2, exact = FALSE)

temp3 = soil_richness$data %>% filter(variable=='Simpson')
wilcox.test(value ~ Horizon, data=temp3, exact = FALSE)

temp4 = soil_richness$data %>% filter(variable=='InvSimpson')
wilcox.test(value ~ Horizon, data=temp4, exact = FALSE)

#### Beta diversity #####
soil_beta_weighted <- UniFrac(soil_rare, weighted = TRUE)
soil_beta_unweighted <- UniFrac(soil_rare, weighted = FALSE)
  
pcoa_soil_weighted <- ordinate(soil_rare, method="PCoA", distance=soil_beta_weighted)
pcoa_soil_unweighted <- ordinate(soil_rare, method="PCoA", distance=soil_beta_unweighted)

plot_ordination(soil_rare, pcoa_soil_weighted, color = "Horizon") 
plot_ordination(soil_rare, pcoa_soil_unweighted, color = "Horizon")

soil_pcoa_weighted <- plot_ordination(soil_rare, pcoa_soil_weighted, color = "Horizon") +
  labs(col = "Horizon") +
  stat_ellipse() +
  color_palette(palette)

soil_pcoa_unweighted <- plot_ordination(soil_rare, pcoa_soil_unweighted, color = "Horizon") +
  labs(col = "Horizon") +
  stat_ellipse()+
  color_palette(palette)

ggsave("soil_pcoa_weighted.png"
       , soil_pcoa_weighted
       , height=4, width=5)

ggsave("soil_pcoa_unweighted.png"
       , soil_pcoa_unweighted
       , height=4, width=5)

#beta significance test -PERMANOVA

temp = soil_pcoa_unweighted$data
beta_signif_unweighted <- adonis2(soil_beta_unweighted~Horizon, data = temp)
beta_signif_unweighted

temp2 = soil_pcoa_weighted$data
beta_signif_weighted <- adonis2(soil_beta_weighted~Horizon, data = temp2)
beta_signif_weighted
