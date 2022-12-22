#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelateuf
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

zcat gl_sam_30.mafs.gz | cut -f5 |sed 1d >freqsam30

ngsrelate -g gl_sam_30.glf.gz -n 31 -f freqsam30 -O newressam30 -p 6 -z bam_uf.filelist

#for MQ20 if you do it

#zcat gl_sam_20.mafs.gz | cut -f5 |sed 1d >freqsam20

#ngsrelate -g gl_sam_20.glf.gz -n 31 -f freqsam20 -O newressam20 -p 6 -z bam_uf.filelist
