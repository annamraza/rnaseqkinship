#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftools_mq20
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_20.filelist | bcftools call -mv -Oz -o snpcalls20.bcf

#bcftools filter -e 'QUAL<20 & DP<10' snpcalls20.bcf -Oz -o calls20.vcf

#for snps

bcftools query -f '%CHROM %POS\n' calls20.vcf >bcf_20.txt
