# pipelineraw

Shell scripts to accompany the software pipeline(s) using RNA-seq data for kinship analysis of non-model organisms

#add pipeline image here?

Data Pre-processing

1) Quality Control
          a) Using FASTqc

2) Trimming
          a) Using Trimmomatic #maybe cutadapt later?

3) Alignment
          a) Aligning and merging reads
          b) Generating mapping summary statistics
          c) Optional: assembly if no ref genome

Biological Analysis:

4) Variant & Genotype
    a) ANGSD
          i) Calling
    b) Samtools
          i) Calling
          ii) Filtering

4) IBD Calculations
          a) NGSrelate
          b) SNPrelate/PLINK


5) Pedigree Reconstruction
          a) PRIMUS

Pipeline Evaluation (speed vs accuracy?)

6) TBD
