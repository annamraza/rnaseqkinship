#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_us
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

#ANGSD output

zcat gl_us.mafs.gz | cut -f5 |sed 1d >freqsamus

ngsrelate -g gl_us.glf.gz -n 37 -f freqsamus -O newressamus -p 6 -z bam_us.filelist

#BCFtools output

ngsrelate  -h callsfilt_us.vcf -O vcfus.res -n 37 -p 6 -z bam_us.filelist
