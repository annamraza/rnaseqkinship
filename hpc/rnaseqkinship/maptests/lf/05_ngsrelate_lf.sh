#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelatelf
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
module load singularity

ngsrelate  -h callsfilt_lf.vcf -O vcf_lf.res -n 37 -z bam_lf.filelist

#zcat gl_sam_lf.mafs.gz | cut -f5 |sed 1d >freqsamlf

#ngsrelate -g gl_sam_lf.glf.gz -n 37 -f freqsamlf -O newressamlf -p 6 -z bam_lf.filelist
