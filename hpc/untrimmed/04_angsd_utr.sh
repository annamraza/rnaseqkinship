#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsdutr
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=15:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load angsd

angsd -bam bam.filelist -GL 1 -out gl_sam_utr -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

#for snps

zcat gl_sam_utr.mafs.gz | cut -f 1,2 | sed 1d >angsd_utr.txt
