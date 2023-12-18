#### This is the script used to visualize PICRUSt2 data for this project ####
# finalized Nov 24 2023 by Ally Howard

# Load libraries
library(ggpicrust2)
library(readr)
library(tibble)
library(tidyverse)
library(ggprism)
library(patchwork)
library(dplyr)
library(KEGGREST)
library(ggh4x)
library(data.table)

metadata <- read_delim("filtered_soil_metadata.txt", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
abundance_file <- "filtered_picrust/pred_metagenome_unstrat.tsv"

#### KEGG Orthology Pathway ####
ko_abundance <- read_delim(abundance_file, delim = "\t", escape_double = FALSE, trim_ws = TRUE)
kegg_abundance <- ko2kegg_abundance(data = ko_abundance)

daa_results_df <- pathway_daa(abundance = kegg_abundance, metadata = metadata, group = "Horizon", daa_method = "DESeq2", select = NULL, reference = NULL)

subset_features_ko <- head(daa_results_df$feature)
daa_results_subset_ko <- daa_results_df[daa_results_df$feature %in% subset_features_ko, ]
daa_annotated_results_df <- pathway_annotation(pathway = "KO", daa_results_df = daa_results_subset_ko, ko_to_kegg = TRUE) #annotating

#### Enzyme Commission Pathway ####
EC_abundance <- read_delim("filtered_picrust/EC_pred_metagenome_unstrat.tsv",delim = "\t", escape_double = FALSE, trim_ws = TRUE)  #fix this
EC_daa_results <- pathway_daa(abundance = EC_abundance %>% column_to_rownames("function"), metadata = metadata, group = "Horizon", daa_method = "DESeq2")
EC_daa_annotated_results_df <- pathway_annotation(pathway = "EC", daa_results_df = EC_daa_results, ko_to_kegg = FALSE)

# filter for significant results
signif_EC_daa_annotated_results_df <- EC_daa_annotated_results_df %>% filter(p_adjust < 0.05)

# subset 30 because dataset too large
subset_EC <- head(signif_EC_daa_annotated_results_df, 30)

# error bar plot
pathway_errorbar(abundance = EC_abundance %>% column_to_rownames("function"), daa_results_df = subset_EC, Group = metadata$Horizon, ko_to_kegg = FALSE, p_values_threshold = 0.05, order = "group", select = NULL, p_value_bar = TRUE, colors = NULL, x_lab = "description")

# PCA plot
pathway_pca(abundance = EC_abundance %>% column_to_rownames("function"), metadata = metadata, group = "Horizon")

# heat map
pathway_heatmap(abundance = EC_abundance %>% column_to_rownames("function"), metadata = metadata, group = "Horizon")

#### MetaCyc pathway ####
MetaCyc_abundance <- read_delim("filtered_picrust/path_abun_unstrat.tsv",delim = "\t", escape_double = FALSE, trim_ws = TRUE)
MetaCyc_daa_results <- pathway_daa(abundance = MetaCyc_abundance %>% column_to_rownames("pathway"), metadata = metadata, group = "Horizon", daa_method = "DESeq2")
MetaCyc_daa_annotated_results_df <- pathway_annotation(pathway = "MetaCyc", daa_results_df = MetaCyc_daa_results, ko_to_kegg = FALSE)

# filter for significant results
signif_MetaCyc_daa_annotated_results_df <- MetaCyc_daa_annotated_results_df %>% filter(p_adjust < 0.00000001)
sorted_MetaCyc <- signif_MetaCyc_daa_annotated_results_df[order(signif_MetaCyc_daa_annotated_results_df$p_adjust), ]

# subset 30 because dataset too large
subset_MetaCyc <- head(sorted_MetaCyc, 70)

# Implement fancy error bar plot from Avril
source("ggpicrust2_errorbar_function_fixed.R")

# error bar plot
pathway_errorbar_onesigresult(abundance = MetaCyc_abundance %>% column_to_rownames("pathway"), 
                 daa_results_df = subset_MetaCyc, 
                 Group = metadata$Horizon, 
                 ko_to_kegg = FALSE, 
                 p_values_threshold = 0.05, 
                 order = "group", 
                 select = NULL, 
                 p_value_bar = TRUE, #FALSE gets rid of log2foldchanges
                 colors = c("#FFC20A", "#0C7BDC"), 
                 x_lab = "description",
                 fc_cutoff = 0.58,
                 order_by_log = T) #log2foldchange cutoff

# PCA plot
pathway_pca(abundance = MetaCyc_abundance %>% column_to_rownames("pathway"), metadata = metadata, group = "Horizon")

# heat map
pathway_heatmap(abundance = MetaCyc_abundance %>% column_to_rownames("pathway"), metadata = metadata, group = "Horizon")

####
