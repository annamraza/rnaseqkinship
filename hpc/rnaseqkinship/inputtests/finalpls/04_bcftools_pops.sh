#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N bcftools_pops
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bcftools

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_p1.filelist | bcftools call -mv -Ob -o snpcalls_p1.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcalls_p1.bcf -Oz -o snpcallsfilt_p1.vcf

bcftools query -f '%CHROM %POS\n' snpcallsfilt_p1.vcf >bcf_p1.txt


bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_p2.filelist | bcftools call -mv -Ob -o snpcalls_p2.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcalls_p2.bcf -Oz -o snpcallsfilt_p2.vcf

bcftools query -f '%CHROM %POS\n' snpcallsfilt_p2.vcf >bcf_p2.txt


bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam_p3.filelist | bcftools call -mv -Ob -o snpcalls_p3.bcf

bcftools filter -e 'QUAL<20 & DP<10' snpcalls_p3.bcf -Oz -o snpcallsfilt_p3.vcf

bcftools query -f '%CHROM %POS\n' snpcallsfilt_p3.vcf >bcf_p3.txt
