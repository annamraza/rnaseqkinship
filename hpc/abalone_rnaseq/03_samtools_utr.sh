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

dt=$(date)

summarise_mapping(){
  input=$1
  fs=$(samtools flagstat $input)
  fname=${input%_merged.bam}
  echo $fname $fs
}

echo $dt

#for f in *.sam; do

#  name=$(basename $f .sam)

#if [ ! -f ${name}.bam ]; then
#  samtools view -bS -q 30 ${name}.sam | samtools sort -o ${name}.bam
#fi

#done

#samples=$(ls *.sam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

#for sample in $samples; do

#  samtools merge -o ${sample}_merged.bam ${sample}_*.bam

#done

#echo $dt

#for f in *_merged.bam;do

#  input=$f

#  summarise_mapping $input

#done>03_summary.log

#cat 03_summary.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates.tsv

#ls *_merged.bam > bam.filelist

#echo $dt

for f in *.sam; do

  name=$(basename $f .sam)

if [ ! -f ${name}_unfilt.bam ]; then
  samtools view -bS ${name}.sam | samtools sort -o ${name}_unfilt.bam
fi

done

samples=$(ls *.fastq.gz | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_merged_unfilt.bam ${sample}_*_unfilt.bam

done

echo $dt

for f in *_merged_unfilt.bam;do

  input=$f

  summarise_mapping $input

done>03_summary_unfilt.log

cat 03_summary_unfilt.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates_unfilt.tsv

ls *_merged_unfilt.bam > bam_unfilt.filelist

echo $dt
#unfiltered reads
