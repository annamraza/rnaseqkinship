#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N align_ld
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=90:00:00
#PBS -l select=1:ncpus=1:mem=300gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bowtie2

module load samtools

GENOME=haliotis_genome.fa

align_reads(){
  index=$1
  input=$2
  output=$3

    bowtie2 -x $index -U $input -S $output
}

summarise_mapping(){
  input=$1
  fs=$(samtools flagstat $input)
  fname=${input%_merged.bam}
  echo $fname $fs
}


#bowtie2-build -f $GENOME haliotis_gen

#align the reads

for f in *_trim.fastq.gz; do
  fasta=$GENOME
  index=${fasta%ome.fa}
  input=$f
  output=${input%_C*.fastq.gz}

if [ ! -f ${output}.sam ]; then
  align_reads $index $input ${output}.sam
fi

done

#extract alignment summary from unfiltered bam files

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

for f in *_merged_unfilt.bam;do

  input=$f

  summarise_mapping $input

done>03_summary_unfilt.log

cat 03_summary_unfilt.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates_unfilt.tsv

#ls *_merged_unfilt.bam > bam_unfilt.filelist

#create filtered bam files for snp calling

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
