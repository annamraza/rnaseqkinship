#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcfplinklf
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

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_lf.filelist | bcftools call -mv -Ob -o snpcallsfilt_lf.bcf

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilt_lf.bcf -Ob -o callsfilt_lf.bcf

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_lf.bcf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "filt_$f"
done

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_lf.bcf --indep 50 5 2 --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bcf callsfilt_lf.bcf --extract plink.prune.in --make-bed --out pruneddatalf --allow-extra-chr

singularity run /sw/containers/plink-1.90b6.21.sif plink1.9 --bfile pruneddatalf --genome --allow-extra-chr --double-id

for f in plink.*;do
mv -- "$f" "ldfilt_$f"
done
