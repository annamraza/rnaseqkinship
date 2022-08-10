#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snptest2
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bcftools

bcftools mpileup -Ou -f haliotis_genome.fa 77_sorted.bam | bcftools call -mv -Ob -o 77_raw_sorted.bcf
bcftools mpileup -Ou -f haliotis_genome.fa 88_sorted.bam | bcftools call -mv -Ob -o 88_raw_sorted.bcf

#bcftools mpileup -Ou -f haliotis_genome.fa 77_1_maptest.bam | bcftools call -mv -Ob -o 77_raw.bcf
#bcftools mpileup -Ou -f haliotis_genome.fa 88_1_maptest.bam | bcftools call -mv -Ob -o 88_raw.bcf
