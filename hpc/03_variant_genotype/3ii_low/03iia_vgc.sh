#!/bin/bash
module load ANGSD

#make a filelist
ls folder/*_merged_marked.bam > input_bam.filelist

./angsd -out gl_list -doMaf 2 -bam input_bam.filelist -doMajorMinor 1 -GL 1 -P 5
#1 is the same tools model anyway, maybe try something else
#-P is number of threads just saying 5 here

#rerun with filters here may not require a second file 
