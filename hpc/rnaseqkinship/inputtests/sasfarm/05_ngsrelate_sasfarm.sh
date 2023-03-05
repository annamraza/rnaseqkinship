#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_sasfarm
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

zcat gl_sasfarm.mafs.gz | cut -f5 |sed 1d >freqsasfarm

ngsrelate -g gl_sasfarm.glf.gz -n 26 -f freqsasfarm -O newressasfarm -p 6 -z bam_sasfarm.filelist

ngsrelate  -h snpcallsfilt_sasfarm.vcf -O vcfsasfarm.res -n 26 -z bam_sasfarm.filelist
