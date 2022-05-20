Preprocessing of Raw Reads

Raw sequence data obtained from ? Complete list of raw fastq files should be in this folder.

According to GATK best practices, raw seq data is aligned to a reference genome, and adaptors and duplicates are marked (check if necessary for Samtools or other)

If further QC is required, see indepthqc

Script for mapping (02_map_read.sh) using BWA mem, duplicate marking (??) and indexing. In this, first fastq converted to bam files, mapped and marked.

Merging?

Mapping summary?
