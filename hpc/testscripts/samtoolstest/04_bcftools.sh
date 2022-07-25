#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N snptestall
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bcftools

ls *_merged.bam > bam.filelist

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam.filelist | bcftools call -mv -Ob -o snpcallsfin.bcf

bcftools filter -i '%QUAL>=20' snpcallsfin.bcf -Ob -o calls.bcf
