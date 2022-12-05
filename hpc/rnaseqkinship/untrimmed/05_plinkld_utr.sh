#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N plinkld_utr
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

dt=$(date)

echo $dt

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt.bcf --extract plink.prune.in --make-bed --out pruneddatafilt --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddatafilt --genome --allow-extra-chr --double-id

echo $dt

for f in plink.*;do
mv -- "$f" "ldfilt_$f"
done

echo $dt

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsunfilt.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsunfilt.bcf --extract plink.prune.in --make-bed --out pruneddataunfilt --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddataunfilt --genome --allow-extra-chr --double-id

echo $dt

for f in plink.*;do
mv -- "$f" "ldunfilt_$f"
done

echo $dt
