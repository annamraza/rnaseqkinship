#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N glcalctest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=6:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load angsd

angsd -bam bam.filelist -GL 2 -out gl_gatk -doMaf 2 -doMajorMinor 1 -P 6
