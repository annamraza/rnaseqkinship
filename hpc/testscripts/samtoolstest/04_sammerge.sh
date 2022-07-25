#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mergeall
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=100gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load samtools

samples=$(ls *.bam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do
  samtools merge -o ${sample}_merged.bam ${sample}_*.bam
done

#ls *.bam > bam.filelist
