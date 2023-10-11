# W6-TM: Week 6 Team Meeting: October 11

## Agenda

1. Discuss finalized project question (Do microbiomes of logged Douglas fir stands in BC differ based on soil type and moisture content?)
2. Discuss denoising step (and whose credentials to use for QIIME2 work)
3. Come up with 3 objectives for our proposal
4. Decide tasks for proposal

## Meeting minutes
* Confirmed finalized project question (double check UJEMI papers to see if duplicates)
    * checked if moisture content was a continuous variable (1-100, percentage)
* Objectives for proposal
    * look at alpha a beta diversity (check if one soil type is more diverse than another)
    * differential abundance (looking for any stats difference between two values)
      * not doing this one for our proposal
    * indicator taxa (looking for one really abundant / prevalent group, smaller number of species
      * might miss out on some differences that would be seen with differential abundance
      * used more in ecology
      * wouldn't typically use Picrust (DSeq instead) for this (but this might be a cool route to go down)
      * use this one for objective 2 of our proposal
    * Picrust (gives Kegg data, pathway data, enzyme data all based on taxonomy data)
* Proposal
    * Approach chart (specify when using QIIME vs R) --> colour code with key
      * be specific about what kind of diversity metrics you are evaluating
      * be specific over all (mention indicator species package, stats)
        * alpha diversity (boxplots)
          * soil types --> use wilcoxin test (t-test)
          * moisture --> spearman correlation (linear model, pearsons correlation coefficient)
          * look over module 14 for this^^
        * beta diversity --> permanova (module 15)
        * indicator species and picrust automatically generate stats (write "use internal stats")
    * write up picrust for indicator species (Avril will talk to Evelyn about this)
    * background stuff doesn't talk about OUR project, just past work and gap
    * research objective
      * slightly more specific ("these variables are known to be related")
    * experimental aims
      * specific papers that are relevant to our project
      * touches on how we'll do our project
      * most narrow (aside from our approaches table)

## Action Items
* share QIIME credentials
* decide tasks for proposal
* start on proposal
