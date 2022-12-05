#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_bcf
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

#ngsrelate -g gl_sam1.glf.gz -n 31 -f freqsam1 -O newressam1 -p 6 -z bam1.filelist

ngsrelate  -h callsfilt.vcf -O vcf.res
