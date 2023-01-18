#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkld_ld
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

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ld.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf callsfilt_ld.vcf --indep 50 5 2 --allow-extra-chr

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ld.bcf --extract plink.prune.in --make-bed --out pruneddataef --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf callsfilt_ld.vcf --extract plink.prune.in --make-bed --out pruneddatald --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddatald --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ldld_$f"
done
