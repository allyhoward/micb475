# W11-TM: Week 11 Team Meeting: November 14

## Agenda
* AIM 3: picrust2
  - help with picrust2 visualization (how do we incorporate indicator taxa?)
  - is the metadata file just the original from the paper? or a filtered one?
* AIM 2: ISA
  - we found some example papers of what we want our data to look like (https://www.nature.com/articles/ismej201379)
  - what are on the x and y axis?
  - we want to make a bubble plot where the size of the dot represents relative abundance
      - can't access link you sent Anu

## Meeting minute
* AIM 3
  * use filtered metadata
  * heat map, all are significant results; may have to state that "everything is very different"
    * suggestion: check the core microbiome and see which specific species present prevalently
  * PCA looks great
  * alternative methods: enrichment analysis to see which pathway is overarching, run indicator species to see which group is more distinctive over another (make a phyloseq object, create a "fake" taxonomy table with one column with all pathway names)
* AIM 2
  * focus on the 3*** ones
  * in microbiome pkg - "**microbiome::transform('compositional')**" - transforming phyloseq objects - then do "**clr**" & "**psmelt()**"
  * create a minimum threshold to remove barely-present species
    * phyloseq_filter_prevalence(physeq, prev.trh = 0.1, abund.trh = 0.01, threshold_condition = “AND”, abund.type = "total")
    * check if abundance is in percentage or add to 1
    * https://rdrr.io/github/vmikk/metagMisc/man/phyloseq_filter_prevalence.html
  * stick with one visualization
  * color indicating what group of species is in the indicator for; determine association b/w condition and species
  * 
