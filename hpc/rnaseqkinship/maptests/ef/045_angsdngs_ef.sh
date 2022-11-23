#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsdngsef
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=60:00:00
#PBS -l select=1:ncpus=15:mem=450gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load angsd

module load ngsrelate/2.0

angsd -bam bam_ef.filelist -GL 1 -out gl_sam_ef -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

zcat gl_sam_ef.mafs.gz | cut -f5 |sed 1d >freqsamef

ngsrelate -g gl_sam_ef.glf.gz -n 37 -f freqsamef -O newressamef -p 15 -z bam_ef.filelist
