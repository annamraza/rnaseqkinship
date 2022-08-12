#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N glibdsam
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=6:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load angsd
module load ngsrelate/2.0

angsd -bam bam.filelist -GL 1 -out gl_sam_fin -doMaf 2 -doMajorMinor 1 -P 6 -minQ 20 -minMapQ 30 -doCounts 1 -setMinDepth 10 -doGlf 3

zcat gl_sam_fin.mafs.gz | cut -f5 |sed 1d >freqsam

ngsrelate -g gl_sam_fin.glf.gz -n 37 -f freqsam -O newressam -p 6
