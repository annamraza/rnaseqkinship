#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bamcontest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load samtools


for f in *.sam; do

name=$(basename $f .sam)

samtools view -bS ${name}.sam | samtools sort -o ${name}.bam

done

ls *.bam > bam.filelist
