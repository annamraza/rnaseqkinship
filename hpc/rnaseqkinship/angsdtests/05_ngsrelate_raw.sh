#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_raw
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

#for MQ30

#zcat gl_angsd_30.mafs.gz | cut -f5 |sed 1d >freq30

#ngsrelate -g gl_angsd_30.glf.gz -n 37 -f freq30 -O newres30 -p 6 -z bam_puf.filelist

zcat gl_angsd_raw.mafs.gz | cut -f5 |sed 1d >freq_raw

ngsrelate -g gl_angsd_raw.glf.gz -n 37 -f freq_raw -O newres_raw -p 6 -z bam_puf.filelist
