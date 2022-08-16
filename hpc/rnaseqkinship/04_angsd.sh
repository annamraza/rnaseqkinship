#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsdtimed
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=6:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load angsd

dt=$(date)

echo $dt

angsd -bam bam.filelist -GL 1 -out gl_sam_fin -doMaf 2 -doMajorMinor 1 -P 6 -minQ 20 -minMapQ 30 -doCounts 1 -setMinDepth 10 -doGlf 3

echo $dt

#no filters at all

angsd -bam bam_unfilt.filelist -GL 1 -out gl_sam_uf -doMaf 2 -doMajorMinor 1 -P 6 -doGlf 3

echo $dt

#comparison of angsd map1 filter to samtools mapq filter

angsd -bam bam_unfilt.filelist -GL 1 -out gl_sam_mquf -doMaf 2 -doMajorMinor 1 -P 6 -minMapQ 30 -doGlf 3

echo $dt

angsd -bam bam.filelist -GL 1 -out gl_sam_mqf -doMaf 2 -doMajorMinor 1 -P 6 -doGlf 3

echo $dt
