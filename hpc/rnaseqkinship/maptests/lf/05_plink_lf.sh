#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinklf 
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load singularity

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf callsfilt_lf.vcf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "lf_$f"
done
