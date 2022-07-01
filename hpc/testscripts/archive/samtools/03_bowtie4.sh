#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N maptest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2

bowtie2-build haliotis_genome.fa haliotis_gen

bowtie2 -x haliotis_gen -U 77_1_C5H1BACXX_GATCAG_L001_R1_trim.fastq.gz -S 77_1_maptest.sam
bowtie2 -x haliotis_gen -U 88_1_C5H1BACXX_AGTCAA_L001_R1_trim.fastq.gz -S 88_1_maptest.sam
