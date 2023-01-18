#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mapmergeandsummaryutr
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

summarise_mapping(){
  input=$1
  fs=$(samtools flagstat $input)
  fname=${input%_merged.bam}
  echo $fname $fs
}

for f in *.sam; do

  name=$(basename $f .sam)

if [ ! -f ${name}.bam ]; then
  samtools view -bS -q 30 ${name}.sam | samtools sort -o ${name}.bam
fi

done

samples=$(ls *.sam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_merged.bam ${sample}_*.bam

done

for f in *_merged.bam;do

  input=$f

  summarise_mapping $input

done>03_summary.log

cat 03_summary.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates.tsv

ls *_merged.bam > bam.filelist

for f in *_merged.bam; do
  file=$f
  read=$(samtools view -c $file)
  prim=$(samtools view -c -F 260 $file)

  echo "$file $read total mapped reads $prim primary mapped reads"

done>mq30_reads.txt
