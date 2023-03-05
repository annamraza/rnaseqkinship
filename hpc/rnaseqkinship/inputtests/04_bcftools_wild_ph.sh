#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftools_wild_ph
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_wild_ph.filelist | bcftools call -mv -Ob -o snpcalls_wild_ph.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcalls_wild_ph.bcf -Oz -o snpcallsfilt_wild_ph.vcf

#for snps

bcftools query -f '%CHROM %POS\n' snpcallsfilt_wild_ph.vcf >bcf_wild_ph.txt
