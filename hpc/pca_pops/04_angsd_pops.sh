#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsd_pops
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

#Population A

angsd -bam bam_p1.filelist -GL 1 -out gl_p1 -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

zcat gl_p1.mafs.gz | cut -f 1,2 | sed 1d >angsd_p1.txt

#Population B

angsd -bam bam_p2.filelist -GL 1 -out gl_p2 -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

zcat gl_p2.mafs.gz | cut -f 1,2 | sed 1d >angsd_p2.txt

#Population C

angsd -bam bam_p3.filelist -GL 1 -out gl_p3 -doMaf 2 -doMajorMinor 1 -P 15 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6

zcat gl_p3.mafs.gz | cut -f 1,2 | sed 1d >angsd_p3.txt


mv *_p[123].* ~/rnaseqkinship/pca_pops
