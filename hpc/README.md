Shell scripts used in the final iteration of the pipeline using RNA-seq data for kinship analysis of greenlip abalone (Haliotis laevigata)


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
          bam files filtered by mapq=30
          bam files merged and used to generate mapping summary statistics

Biological Analysis:

4) Variant & Genotype Calling

Either genotype likelihoods are calculated (with angsd) or SNPs and Genotypes are called (bcftools); both use the same statistial approach (the Samtools approach) and filter SNPs for a quality of 20 and a minimum depth of 10.

          a) ANGSD (04_angsd.sh)

          b) BCFtools (04_bcftools.sh)

5) IBD Calculations

          a) NGSrelate (05_ngsrelate.sh)

          Uses genotype likelihoods by ANGSD and BCFtools respectively to calculcate k-coefficients

          b) PLINK (05_plinkld.sh)

          Uses genotypes called by BCFtools, after SNPs trimmed for LD as recommended by PLINK manual

Pipeline Optimisation

1) Unstressed replicates

All scripts in unstressedreps folder. Only first two replicates merged after alignment (03_samtools_us.sh) and used for variant calling (04_angsd_us.sh ; 04_bcftools_us.sh) and IBD calculations (05_ngsrelate_us.sh) as described above.

2) Subpopulations

All scripts in pca_pops folder. Groups determined using PCA done with PLINK and filtered BCFtools snps (05_plink.sh). bam files partitioned into respective lists according to groupings, with each used separately for variant calling (04_angsd_pops.sh ; 04_bcftools_pops.sh) and IBD calculations (05_ngsrelate_pops.sh) as described above.
