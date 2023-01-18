#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_sas
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

zcat gl_sas.mafs.gz | cut -f5 |sed 1d >freqsas

ngsrelate -g gl_sas.glf.gz -n 15 -f freqsas -O newressas -p 6 -z bam_sas.filelist

ngsrelate  -h snpcallsfilt_sas.vcf -O vcfsas.res -n 15 -z bam_sas.filelist
