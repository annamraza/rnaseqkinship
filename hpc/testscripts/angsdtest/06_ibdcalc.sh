#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N glcalctest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load angsd
module load ngsrelate

#needs to be installed

zcat gl_gatk.mafs.gz | cut -f5 |sed 1d >freq

ngsrelate -g gl_gatk.mafs.gz -n 100 -f freq -O newres
