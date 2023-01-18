#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkld_sas
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

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf snpcallsfilt_sas.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf snpcallsfilt_sas.vcf --indep 50 5 2 --allow-extra-chr

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf snpcallsfilt_sas.bcf --extract plink.prune.in --make-bed --out pruneddatafilt --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf snpcallsfilt_sas.vcf --extract plink.prune.in --make-bed --out pruneddatasas --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddatasas --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ldsas_$f"
done
