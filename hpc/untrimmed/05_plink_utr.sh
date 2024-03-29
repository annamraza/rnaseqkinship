#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkutr
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load singularity

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt.bcf --genome --allow-extra-chr --double-id

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf callsfilt.vcf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "utr_$f"
done
