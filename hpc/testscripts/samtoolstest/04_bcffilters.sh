#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snpfiltersfin
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bcftools

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfin.bcf -Ob -o callsfiltfin.bcf
