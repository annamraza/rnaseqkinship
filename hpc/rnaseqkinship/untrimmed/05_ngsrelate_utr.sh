#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelateutrraw
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=10:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

#zcat gl_sam_utr.mafs.gz | cut -f5 |sed 1d >freqsamutr

#ngsrelate -g gl_sam_utr.glf.gz -n 37 -f freqsamutr -O newressamutr -p 6 -z bam.filelist

zcat gl_sam_utr_raw.mafs.gz | cut -f5 |sed 1d >frequfraw

ngsrelate -g gl_sam_utr_raw.glf.gz -n 37 -f frequfraw -O newresufraw -p 10 -z bam_unfilt.filelist
