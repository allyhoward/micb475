# W7 - TM: Week 7 Team Meeting: Oct 18

## Agenda

1. Fatima + Jastina's questions for Avril
    * When analyzing our data, do we run test looking at moisture then soil types and THEN both?
    * Look through how we ran our QIIME2 code
    * What types of alpha/beta diversity tests should we run?

2. Is our project too similar to this other UJEMI paper (please say no) and if so how can we adapt ours to be different?:

Annual precipitation and soil moisture level strongly associate
with the bacterial community structure in Interior Douglas-fir
and Sub-Boreal Spruce ecozones in British Columbia

3. Can we use the above paper as a reference
4. ok new project idea: look at pH and A and O horizons instead
5. feasibility / training
6. gitignore?

## Meeting Minutes

   * Addressed change to research question
      * UJEMI+ paper we found was very close to our inital research question - will now be used as background
      * pivoting to analyse microbiome of Douglas Fir in BC based on their pH and horizon type 
      * not elevation because only two elevations for different sites
      * not soil type becase all Douglas Fir have same 
      * Focus on Horizon more than pH 
        * Because there is a previous UJEMI paper which discusses pH (as well as other variables for all trees in the dataset) must explicitly state the novelty 
        * Could simply control for pH 
        * Because not all Doulgas Fir have pH (some are listed as 0) we could chose to subset and compare pH for the Douglas Fir which DO have pH values 
    * Shared proposal with Avril 
    * Final project requires all graphs and plots to be done in R 
      * Use QIIME2 for initial visualization
    * No longer need to include Feasibility and Training section in proposal 
    * Aim to cover all rubric 
      * Intro - talk about papers that take about the data, overview of what's been done, prior UJEMI papers, original authors, background on metadata talked about
        * Give background regarding pH and horizon
        * Do not draw any conclusions in intro
    * Spell check! 
    * .gitignore = file that will remain on your computer which cannot be pushed or pulled
    * Hidden files like .DS_score can be ignored, do not have to remove them from repository 
    
    * Primary focus of project will be regarding Horizon types
      * determine if we want to also control for pH
    * Group meetings to finish up proposal
      * provide Avril with updates up until early Saturday morning to get feedback prior to submission 
