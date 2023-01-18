#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkld_mq20
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

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf calls20.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf calls20.vcf --indep 50 5 2 --allow-extra-chr

#singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf calls20.bcf --extract plink.prune.in --make-bed --out pruneddatafilt --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --vcf calls20.vcf --extract plink.prune.in --make-bed --out pruneddata20 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddata20 --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ld20_$f"
done
