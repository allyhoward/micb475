# W9-TM: Week 9 Team Meeting: November 1

## Agenda
* Notebooks: we have 2 right now, one on Docs and the readme (the Docs one is more updated!) Should we keep going with the doc or push to the GitHub?
* Installing PICRUSt2 difficulties
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
1. Notebooks: we have 2 right now, one on Docs and the readme (the Docs one is more updated!) Should we keep going with the doc or push to the GitHub?
2. Code for installing PICRUSt2 on QIIME 2
2b13b2888ca5c51f1df3aafbf6c44a8ac30c152b
