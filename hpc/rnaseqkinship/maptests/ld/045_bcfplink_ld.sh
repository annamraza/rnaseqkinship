#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcfplinkld
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bcftools

module load singularity

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_ld.filelist | bcftools call -mv -Ob -o snpcallsfilt_ld.bcf

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilt_ld.bcf -Ob -o callsfilt_ld.bcf

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ld.bcf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "filt_$f"
done

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ld.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_ld.bcf --extract plink.prune.in --make-bed --out pruneddatald --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddatald --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ldfilt_$f"
done
