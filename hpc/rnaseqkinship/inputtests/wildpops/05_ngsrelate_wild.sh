#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_wild
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

zcat gl_wild.mafs.gz | cut -f5 |sed 1d >freqwild

ngsrelate -g gl_wild.glf.gz -n 22 -f freqwild -O newreswild -p 6 -z bam_wild.filelist

ngsrelate  -h snpcallsfilt_wild.vcf -O vcfwild.res -n 22 -z bam_wild.filelist
