#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_bcf
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=15:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

ngsrelate  -h calls20.vcf -O vcf.res -n 37 -p 15 -z bam_20.filelist
