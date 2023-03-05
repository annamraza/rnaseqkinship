#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_wild_ph
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

zcat gl_wild_ph.mafs.gz | cut -f5 |sed 1d >freqwildph

ngsrelate -g gl_wild_ph.glf.gz -n 22 -f freqwildph -O newreswildph -p 6 -z bam_wild_ph.filelist

ngsrelate  -h snpcallsfilt_wild_ph.vcf -O vcfwildph.res -n 22 -z bam_wild_ph.filelist
