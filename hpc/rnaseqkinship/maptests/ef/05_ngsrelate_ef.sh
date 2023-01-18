#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelateef
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

#zcat gl_sam_ef.mafs.gz | cut -f5 |sed 1d >freqsamef

#ngsrelate -g gl_sam_ef.glf.gz -n 37 -f freqsamef -O newressamef -p 6 -z bam_ef.filelist

ngsrelate  -h callsfilt_ef.vcf -O vcf_ef.res -n 37 -p 6 -z bam_ef.filelist
