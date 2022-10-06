#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftoolsef
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_ef.filelist | bcftools call -mv -Ob -o snpcallsfilt_ef.bcf

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilt_ef.bcf -Ob -o callsfilt_ef.bcf
