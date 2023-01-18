#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N samtoolsmerge_angsd
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load samtools

for f in *.sam; do

  name=$(basename $f .sam)

if [ ! -f ${name}_puf.bam ]; then
  samtools view -bS -F 260 ${name}.sam | samtools sort -o ${name}_puf.bam
fi

done

samples=$(ls *.bam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_merged.bam ${sample}_*.bam

done


ls *_merged.bam > bam_puf.filelist

for f in *_merged.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>puf_reads.txt
