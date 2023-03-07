#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftools_us
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bcftools

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_us.filelist | bcftools call -mv -Ob -o snpcallsfilt_us.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcallsfilt_us.bcf -Ob -o callsfilt_us.vcf

#for snps

bcftools query -f '%CHROM %POS\n' callsfilt_us.vcf >bcfsnps_us.txt
