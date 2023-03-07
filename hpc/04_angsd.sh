#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsd_beagle
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=15:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load angsd

angsd -bam bam.filelist -GL 1 -out gl_sam -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

#to extract snps

zcat gl_sam.mafs.gz | cut -f 1,2 | sed 1d >angsdsnps.txt
