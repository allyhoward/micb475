# W12-TM: Week 12 Team Meeting: November 22

## Agenda

* Go through the data summary
* Alpha and Beta Diversity Plots - technically complete but alpha significance tests are slightly concerning...
  *  trying it with different metrics? But then the t-test code doesn't run???
  *  put all the stuff into slides - would appreciate everyone's opinion!
* Downstream errors and issues after ISA filtering
  * could it be due to NA and 0?
  * should we remove the x/sum(x) code? 
* Core microbiome and heat map

## Meeting Minutes
* overview of project for Evelyn

* Alpha diversity:
  * not significant
  * only seems to be including one horizon??
  * send code to Avril!!
  * If medians fall within box of the other, not significant
  * good to show Shannon ones that diversity doesn't differ between then
* Beta diversity:
  * Weighted unifrac is better
  * can get rid of unweighted unifrac
  * less clustering, richness and phylogenetic distance are more likely to be driving diversity
  * difference in evenness is a bit less
  * can present BOTH weighted and unweighted
  * only 1.4% variance
  * draw ellipses in
  * MAKE 3 PANNELS: alpha, weighted, unweighted
  * f-statistic is used to calculate p-value
 
* ISA
  * everything very significant
  * core microbiome??
  * unable to do ISA with filtered data
  * error might be a dividing by 0 problem
  * already in relative abundance, don't need to do it again
  * can fully delete that line
  * don't need the tree so that warning is fine (error tree replaced with NULL)
  * use view() to look at data
  * prevalence is too stringent
  * tax_glom before running filtering
  * SET stat > 0.8 threshold and build a table (abundance 0.001, prevalence 0.1)

* MetaCyc error bar plot
  * log2fold change cut off to filter (0.58) 1.5 fold change in log2
  * crop out p-value
  * + labs to edit titles and customize
*  MetaCyc PCA plot
   * can use to show that everything is significant
   * don't need heat map
* Core microbiome
  * use tax_glom to genus level
  * set_1 is AH_core
  * after doing genus level, can put in paper
 
* Next week:
  * practice presentation!!! 
