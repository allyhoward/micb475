### Aim 2: What species indicators do we see arise in A vs O horizons? ###

# Install the indicspecies package
install.packages("indicspecies")

### Step 1:Load in the 'tidyverse', 'dplyr', 'phyloseq', 'ape', 'vegan' and 'indicspecies' package

library(tidyverse)
library(dplyr)
library(phyloseq)
library(ape)
library(vegan)
library(indicspecies)
library(microbiome)

### Step 2: Load in the soil metadata, OTU table, taxonomy file, and phylogenetic tree

# soil metadata
metaFP <- "soil_metadata.tsv"
meta <- read.delim(file=metaFP, sep = "\t")

# OTU table
otuFP <- "mpt_export/filtered_table_export/filtered-feature-table.txt"
otu <- read.delim(file=otuFP, sep ="\t", skip=1)

# taxonomy file
taxFP <- "mpt_export/taxonomy_export/taxonomy.tsv"
tax <- read.delim(file=taxFP, sep = "\t")

# phylogenetic tree
phyloFP <- "mpt_export/rooted_tree_export/tree.nwk"
phylo <- read.tree(file=phyloFP)

### Step 3: Adjust files to be read into a phyloseq object. Make the phyloseq object.

## A: Format OTU table as a matrix with rownames and colnames as OTUs and sampleIDs, respectively
# Save everything except first column (X.OTU.ID) into a matrix
otu_mat <- as.matrix(otu[,-1])
# Make first column (X.OTU.ID) the rownames of the new matrix
rownames(otu_mat) <- otu$`X.OTU.ID`
# Use the "otu_table" function to make an OTU table
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 
class(OTU)

## B: Format sample metadata
# Save everything except X.SampleID as new data frame
samp_df <- as.data.frame(meta[,-1])
# Make X.SampleID the rownames
rownames(samp_df)<- meta$'X.SampleID'
# Make phyloseq sample data with sample_data() function
SAMP <- sample_data(samp_df)
class(SAMP)

## C: Formatting taxonomy
# Convert taxon strings to a table with separate taxa rank columns
tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix() # Saving as a matrix
# Save everything except feature IDs 
tax_mat <- tax_mat[,-1]
# Make sampleids the rownames
rownames(tax_mat) <- tax$`Feature.ID`
# Make taxa table
TAX <- tax_table(tax_mat)
class(TAX)

## D: Create phyloseq object with adjusted files. (The phylogenetic tree doesn't need to be adjusted.)
# Merge all into a phyloseq object
mpt <- phyloseq(OTU, SAMP, TAX, phylo)

## E: Looking at phyloseq object
# View components of phyloseq object with the following commands
otu_table(mpt)
sample_data(mpt)
tax_table(mpt)
phy_tree(mpt)

## F: Covert reads to relative abundance data

mpt_relative <- microbiome::transform(mpt, "compositional")
class(mpt_relative)

## G: Set a prevalence threshold and abundance threshold
# Abundance = 0.001; I want check whether the ASV is present or not
abundance_threshold <- 0.001 
# Prevalence = 0.1; I want the ASV present in 10% of the samples
prevalence_threshold <- 0.1 

# List of taxa that pass the abundance threshold 
abundant_taxa_names = prune_taxa((taxa_sums(mpt_relative)/nsamples(mpt_relative))>abundance_threshold, mpt_relative) %>% taxa_names
# List of taxa that pass the prevalence threshold 
prevalent_taxa_rows = apply(mpt_relative@otu_table@.Data, 1, function(x) (sum(x != 0, na.rm = TRUE)/length(x[!is.na(x)]))>prevalence_threshold)
# Select phyloseq rows where value==TRUE
prevalent_taxa_names = rownames(mpt_relative@tax_table@.Data)[prevalent_taxa_rows]
#filter phyloseq object
mpt_relative_filt = prune_taxa(intersect(abundant_taxa_names,prevalent_taxa_names),mpt_relative)


## H: Convert phyloseq table to relative abundance 
# Group based on genus level
mpt_genus <- tax_glom(mpt_relative_filt, "Genus", NArm = FALSE)
# Convert OTU counts to relative abundance
mpt_genus_RA <- transform_sample_counts(mpt_genus, fun=function(x) x/sum(x))

### Step 4: Perform Indicator Taxa Analysis

# Flip OTU row and column names & calculate indicator values for all ASV's 999 times as per the permutation hypothesis test
isa_mpt <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$`Horizon`, control = how(nperm = 999)) 
summary(isa_mpt)
taxtable <- tax_table(mpt) %>% as.data.frame() %>% rownames_to_column(var="ASV")

# Summary table of ISA data 
isa_sum <- isa_mpt$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value==0.001) 

### Step 5: Visualize Data

## : ISA Visualization 
# Create scatter plot with dot size to visualize ISA ?

