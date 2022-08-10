#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snptest4
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bcftools

bcftools mpileup -Ou -f haliotis_genome.fa alignments2.bam | bcftools call -mv -Ob -o snpcallsii.bcf
