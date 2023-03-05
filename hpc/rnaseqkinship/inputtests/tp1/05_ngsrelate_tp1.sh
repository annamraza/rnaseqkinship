#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_tp1
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

zcat gl_tp1.mafs.gz | cut -f5 |sed 1d >freqsamtp1

ngsrelate -g gl_tp1.glf.gz -n 35 -f freqsamtp1 -O newressamtp1 -p 6 -z bam_tp1.filelist

ngsrelate  -h callsfilt_tp1.vcf -O vcftp1.res -n 35 -p 6 -z bam_tp1.filelist
