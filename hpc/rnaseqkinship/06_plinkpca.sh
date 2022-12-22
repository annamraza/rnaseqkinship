#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkpca
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load singularity

echo time

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt.bcf --allow-extra-chr --double-id --pca

echo time

echo walltime
