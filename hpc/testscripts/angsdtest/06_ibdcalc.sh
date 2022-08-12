#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ibdcalcfilt
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load ngsrelate/2.0

zcat gl_gatk_filt.mafs.gz | cut -f5 |sed 1d >freqfilt2

ngsrelate -g gl_gatk_filt.glf.gz -n 37 -f freqfilt2 -O newresfilt
