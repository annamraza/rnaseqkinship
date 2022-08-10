#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N filteredsnpcalling
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load samtools
module load bcftools


#convert to bamfiles with added mapq filters

for f in *_esd.sam; do

name=$(basename $f .sam)

samtools view -bS -q 30 ${name}.sam | samtools sort -o ${name}.bam

done

#merge bam files together

samples=$(ls *.bam | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ '')

for sample in $samples; do

  samtools merge -o ${sample}_merged.bam ${sample}_*_esd.bam

done

#use merged files for summary stats

summarise_mapping(){
  input=$1
  fs=$(samtools flagstat $input)
  fname=${input%_merged.bam}
  echo $fname $fs
}


for f in *_merged.bam;do

  input=$f

  summarise_mapping $input

done > 03_summary_filt.log

cat 03_summary_filt.log | awk 'OFS="\t"{print $1,$37}' | sed 's/(//' | sed 's/%//' > mapping_rates_filt.tsv

#make input filelist

ls *_merged.bam > bam.filelist

#call snps with new bam files

bcftools mpileup -Ou -f haliotis_genome.fa --bam-list bam.filelist | bcftools call -mv -Ob -o snpcallsfilttest.bcf

#filter for qual and depth and genotype

bcftools filter -e 'GT="." & QUAL<20 & DP<10' snpcallsfilttest.bcf -Ob -o callsfilttest.bcf
