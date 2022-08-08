#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N viewtest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=3:00:00
#PBS -l select=1:ncpus=1:mem=1gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load samtools

for f in *.fastq.gz; do
  input=$f
  output=${input%_C*.fastq.gz}

  samtools view -bS ${output}.sam | samtools sort -o ${output}.bam

  done
