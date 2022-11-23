#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snpextraction_tp1
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=5:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bcftools

bcftools query -f '%CHROM %POS\n' callsfilt1.bcf >bcf_tp1.txt

zcat gl_sam1.mafs.gz | cut -f 1,2 | sed 1d >angsd_tp1.txt
