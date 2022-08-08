#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N maplocalverysensitive
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2
module load samtools

dt=$(date)

GENOME=haliotis_genome.fa

align_reads(){
  index=$1
  input=$2
  output=$3

    bowtie2 --local --very-sensitive-local -x $index -U $input -S $output
}

summarise_mapping(){
  input=$1
  fs=$(samtools flagstat $input)
  fname=${input%_merged.bam}
  echo $fname $fs
}

echo $dt

for f in *.fastq.gz; do
  fasta=$GENOME
  index=${fasta%ome.fa}
  input=$f
  output=${input%_C*.fastq.gz}_lvs

if [ ! -f ${output}.sam ]; then
  align_reads $index $input ${output}.sam
fi

if [ ! -f ${output}.bam ]; then
  samtools view -bS ${output}.sam | samtools sort -o ${output}.bam
fi
done

#merge

samples=$(ls *.fastq.gz | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do
  samtools merge -o ${sample}_lvs_merged.bam ${sample}_*_lvs.bam
done

#mapping summary
for f in *_lvs_merged.bam;do
  input=$f
  summarise_mapping $input
done > 03_summary_lvs.log

cat 03_summary_lvs.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates_lvs.tsv

echo $dt
