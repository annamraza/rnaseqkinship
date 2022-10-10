#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkef
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

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ef.bcf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "filt_$f"
done

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ef.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ef.bcf --extract plink.prune.in --make-bed --out pruneddataef --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddataef --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ldfilt_$f"
done
