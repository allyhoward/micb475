# W10-TM: Week 10 Team Meeting: November 8

## Agenda

* still don't know how to install PICRUSt2 :((
* getting following error each time we try to load any of the files required for phyloseq:
    Error in file(file, "rt") : cannot open the connection
    In addition: Warning message:
    In file(file, "rt") :
    cannot open file '../mpt_export/filtered_table_export/filtered_feature-table.txt': No such   file or directory
  * tried creating new R project and changing working directory to R processing folder (Folder path currently: micb 475 -> code -> R processing -> mpt_export (with exported filtered table, rooted tree, table, and taxonomy folders) 


## Meeting Minutes
* to install picrust:

wget https://github.com/picrust/picrust2/archive/v2.5.2.tar.gz <br>
tar xvzf  v2.5.2.tar.gz <br>
cd picrust2-2.5.2/ <br>

conda env create -f picrust2-env.yaml <br>
conda activate picrust2 <br>
pip install --editable . <br>

* to run picrust: **picrust2_pipeline.py [-i, -o]**

* result from indicator taxa to be used in picrust
  
* last team meeting: anticipate half of the time investing on practice presentation (10 mins)


## Action Items
* try finishing all the tests by next meeting!!
* same time for next week's meeting (Wednesday 1pm)
  
  
