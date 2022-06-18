#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snptest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load samtools

samtools view -bS 77_1_maptest.sam>77_1_maptest.bam
samtools view -bS 88_1_maptest.sam>88_1_maptest.bam

samtools sort 77_1_maptest.bam -o 77_sorted.bam
samtools sort 88_1_maptest.bam -o 88_sorted.bam

bcftools mpileup -f haliotis_genome.fa 77_sorted.bam | bcftools view -Ov - > 77_raw.bcf
bcftools mpileup -f haliotis_genome.fa 88_sorted.bam | bcftools view -Ov - > 88_raw.bcf 
