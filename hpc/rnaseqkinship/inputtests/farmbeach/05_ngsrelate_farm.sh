#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_farm
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=6:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

zcat gl_farm.mafs.gz | cut -f5 |sed 1d >freqfarm

ngsrelate -g gl_farm.glf.gz -n 11 -f freqfarm -O newressfarm -p 6 -z bam_farm.filelist

ngsrelate  -h snpcallsfilt_farm.vcf -O vcfarm.res -n 11 -z bam_farm.filelist
