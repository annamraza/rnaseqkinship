#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ibdtest4
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load singularity

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf snpcallsii.bcf --genome --allow-extra-chr