#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N angsdlf
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=150:00:00
#PBS -l select=1:ncpus=20:mem=350gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load angsd

angsd -bam bam_lf.filelist -GL 1 -out gl_sam_lf -doMaf 2 -doMajorMinor 1 -P 20 -minQ 20 -doCounts 1 -setMinDepth 10 -doGlf 3 -SNP_pval 1e-6
