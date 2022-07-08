#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snptestmerged
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bcftools

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list mergedbam.filelist | bcftools call -mv -Ob -o snpcallsmerged.bcf
