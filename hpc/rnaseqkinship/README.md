Shell scripts used in the final iteration of the pipeline using RNA-seq data for kinship analysis of greenlip abalone (Haliotis laevigata)

#add pipeline image here?

Data Pre-Processing

1) Quality Control

To summarise total reads, average reads, minimum and maximum reads, for both single and paired-end sequencing (although only forward sequences were used in the dataset)

          a) FASTqc (01_fastqc.sh)
            i) raw reads
            ii) filtered reads


2) Trimming

Removing adaptors in case of contamination using included list from Illumina

          a) Trimmomatic (02_trimmmatic.sh)

3) Alignment
Aligning reads to reference genome of Haliotis rubra across two programs
          a) Bowtie2 (03_bowtie2.sh)
          Used to align reads
          b) Samtools (03_samtools.sh)
          Used to convert sam files to bam files:
          bam files either unfiltered or filtered by mapq=30
          bam files merged and used to generate mapping summary statistics
          two sets of outputs: unfiltered bam files and filtered bam files

Biological Analysis:

4) Variant & Genotype Calling
Either genotype likelihoods are calculated (with angsd) or SNPs and Genotypes are called (bcftools); both use the same statistial approach (the Samtools approach)
Tried to keep filters constant although genotype being called is unique to bcftools.
    a) ANGSD (04_angsd.sh)
          i) Calling:
          Ran for both unfiltered and filtered bam files, with no filters on unfiltered.
          Filters included while GL is calculated; SNP Q of 20, min depth of 10, MQ of 30.
          ii) Difference b/w mapq filters:
          Testing to see if MapQ can be skipped in ANGSD code, if samtools filtration is equivalent #will probably remove this from final scripts
    b) BCFtools (04_bcftools.sh)
          i) Calling
          Ran for both unfiltered and filtered bam files
          ii) Filtering
          Filters include genotype called, min depth of 10, SNP Q of 20
          Only run with filtered bam files, to include mapq of 30 to match angsd outputs 

4) IBD Calculations
          a) NGSrelate
          b) PLINK
            i) Raw Data
            ii) LD Pruned


#5) Pedigree Reconstruction
          a) PRIMUS

#Pipeline Evaluation (speed vs accuracy?)

#6) TBD
