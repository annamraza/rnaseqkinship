# pipelineraw

Shell scripts to accompany the software pipeline(s) using RNA-seq data for kinship analysis of non-model organisms

#add pipeline image here?

Data Pre-processing

1) Quality Control
          a) Marking adapters
          b) Optional: trimming

2) Alignment
          a) Aligning and merging reads
          b) Generating mapping summary statistics
          c) Optional: assembly if no ref genome

Biological Analysis:

3) Variant & Genotype
  i) High depth
          a) Calling
          b) Filtering
  ii) Low depth
          a) Calling
          b) Filtering

4) IBD Calculations
          a) High depth
          b) Low depth

5) Pedigree Reconstruction using PRIMUS

Pipeline Evaluation (speed vs accuracy?)

6) TBD
