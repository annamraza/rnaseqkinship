#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftoolsngsrelate
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam.filelist | bcftools call -mv -Oz -o snpcallsfilt.vcf

#bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam1.filelist | bcftools call -mv -Oz -o snpcallsfilt1.vcf

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilt.vcf -Oz -o callsfilt.vcf

#bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilt1.bcf -Ob -o callsfilt1.bcf
