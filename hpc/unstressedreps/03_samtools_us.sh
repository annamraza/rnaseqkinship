#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N samtools_us
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

#set -e

module load samtools

samples=$(ls *.bam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_us.bam ${sample}_[12].bam

done

ls *_us.bam > bam_us.filelist

for f in *_us.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>reads_us.txt

mv *_us.bam ~/rnaseqkinship/unstressedreps
