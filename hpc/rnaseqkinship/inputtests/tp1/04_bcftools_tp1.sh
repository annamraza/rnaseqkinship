#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftools_tp1
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_tp1.filelist | bcftools call -mv -Ob -o snpcallsfilt_tp1.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcallsfilt_tp1.bcf -Ob -o callsfilt_tp1.vcf

#for snps

bcftools query -f '%CHROM %POS\n' callsfilt_tp1.vcf >bcfsnps_tp1.txt
