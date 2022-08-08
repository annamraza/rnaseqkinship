#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N indextime
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2

dt=$(date)

GENOME=haliotis_genome.fa

echo $dt

bowtie2-build -f $GENOME haliotis_gen

echo $dt
