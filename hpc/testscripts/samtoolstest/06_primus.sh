#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N pedigreetest2
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load primus/1.9.0

run_PRIMUS.pl -p plink.genome
