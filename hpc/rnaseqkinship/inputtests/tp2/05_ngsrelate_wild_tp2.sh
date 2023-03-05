#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_wild_tp2
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

zcat gl_wild_tp2.mafs.gz | cut -f5 |sed 1d >freqwildtp2

ngsrelate -g gl_wild_tp2.glf.gz -n 22 -f freqwildtp2 -O newreswildtp2 -p 6 -z bam_wild_tp2.filelist

ngsrelate  -h snpcallsfilt_wild_tp2.vcf -O vcfwildtp2.res -n 22 -z bam_wild_tp2.filelist
