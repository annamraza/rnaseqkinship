#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_sas_tp1
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

zcat gl_sas_tp1.mafs.gz | cut -f5 |sed 1d >freqsastp1

ngsrelate -g gl_sas_tp1.glf.gz -n 14 -f freqsastp1 -O newressastp1 -p 6 -z bam_sas_tp1.filelist

ngsrelate  -h snpcallsfilt_sas_tp1.vcf -O vcfsastp1.res -n 14 -z bam_sas_tp1.filelist
