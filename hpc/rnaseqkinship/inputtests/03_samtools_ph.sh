#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N samtools_ph
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

for f in *_1.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>tp1_reads.txt

for f in *_2.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>tp2_reads.txt

samples=$(ls *.bam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_ph.bam ${sample}_[12].bam

done

ls *_ph.bam > bam_ph.filelist

for f in *_ph.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>reads_ph.txt

mv *_ph.bam ~/rnaseqkinship/inputtests
