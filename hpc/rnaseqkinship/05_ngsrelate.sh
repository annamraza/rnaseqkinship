#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelatefin
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

dt=$(date)

echo $dt

zcat gl_sam_fin.mafs.gz | cut -f5 |sed 1d >freqfin

ngsrelate -g gl_sam_fin.glf.gz -n 37 -f freqfin -O newresfin -p 6

echo $dt

zcat gl_sam_uf.mafs.gz | cut -f5 |sed 1d >frequf

ngsrelate -g gl_sam_uf.glf.gz -n 37 -f frequf -O newresuf -p 6

echo $dt
