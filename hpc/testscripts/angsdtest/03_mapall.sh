#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mapangsdtest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2

bowtie2-build haliotis_genome.fa haliotis_gen

bowtie2 -x hailotis_gen -U mapinput.txt -S mapped
