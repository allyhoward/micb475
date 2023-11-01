# W9-TM: Week 9 Team Meeting: November 1

## Agenda
* Notebooks: we have 2 right now, one on Docs and the readme (the Docs one is more updated!) Should we keep going with the doc or push to the GitHub?
* Installing PICRUSt2 difficulties (error: The current user does not have write permissions to the target environment.
  environment location: /opt/conda/envs/qiime2-2023.7)
  2b13b2888ca5c51f1df3aafbf6c44a8ac30c152b

* Walk thru comments for clarification:
1. Dataset Overview
- Q: What did the distribution of lengths generally look like? 
  - A: Does this mean long/short? How should we describe this?
- Q: This is definitely desirable, but this won’t affect sample filtering. Sample filtering = metadata filtering. 
  - A: Do we delete this sentence?
2. Proposed Approach Table
- Q: This is a little off – your reads will be inputted into PICRUSt2, which will then produce outputs in the form of functional datasets (KEGG as you note, and also MetaCyc pathways and enzyme data (EC), just fyi). The OTU table is the table of taxonomic counts, which isn’t a consideration for PICRUSt2 – PICRUSt2 outputs and OTU tables are basically different ways of annotating the same data. 
  - A: Plz help with walk thru :( 
- Q: Permutation test
  - A: Is using the p value preferred over this permutation test for significance? What should we change in this table?
  
* Questions about coding with R
1. Aim 2: What species indicators do we see arise in A vs O horizons?
  - Is the workflow: assignment 5 (create phyloseq object; rarefy samples; ordinaton figure) > assignment 6 (indicator species analysis)
  - Do we use the filtered metadata table in R or the original table.qza?

## Meeting Minutes

* Notebook
  * stick with Docs for notebook
  * include notes for R as well
  * discussions just for important things
    * don't spend too much time on this, just show that you're thinking through things
  * more emphasis on methods so projects are recreatable
  * make an effort to make it readable and backed up by rationale
  * Docs doesn't record history, but for purposes of this class thats ok
    * don't delete portions!

* Downloading PICRUSt2
  * should be able to just download to directory
  * Avril will check it out
 
* resubmitting proposal
  *  Distribution of lengths (dataset overview)
    * logic is a bit circular (sounds like "shorter because its shorter")
    * Do most of the samples have maximum read length? Are they outliers?
  * We can delete sentence about chloroplast filtering
  * We get half-mark for flowchart (formatted properly in the PDF!)
* SUBMIT BOTH WORD AND PDF FILES
  * PICRUSt2 generated in QIIME2 but analyzed in R
  * Resources for PICRUSt2:
    * look up "PICRUSt2 code example"
    * stack exchange / stack overflow

qiime picrust2 full-pipeline \
   --i-table ld67-table-dada2.qza \
   --i-seq ld67-rep-seqs-dada2.qza \

* Permutation test
  * stat test
  * permutation tests robustness of p-value
  * repeats indicator test 999 times (calculates p-values each time)
  * in resubmission "we'll use 999 mutations and use a p-value cut off of ____"
  * indicator taxa gives table of p-value and stat value regardless of number of permutations
