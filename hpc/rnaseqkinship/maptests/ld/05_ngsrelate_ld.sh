#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelateld
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

zcat gl_sam_ld.mafs.gz | cut -f5 |sed 1d >freqsamld

ngsrelate -g gl_sam_ld.glf.gz -n 37 -f freqsamld -O newressamld -p 6 -z bam_ld.filelist
