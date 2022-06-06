#!/bin/#!/usr/bin/env bash

module load picard
module load bwa
module load java
module load samtools

GENOME=

set -e

align_trim_reads(){
  input=$1
  fasta=$2
  ubam=$3
  output=$4

  java -jar picard.jar SamtoFastq \
  I=$input \
  FASTQ=/dev/stdout \
  #CLIPPING_ATTRIBUTE=XT
  | \
  bwa mem -M -t 16 -p $fasta /dev/stdin \
  | \
  java -jar picard.jar MergeBamAlignment \
  ALIGNED=/dev/stdin \
  UNMAPPED=$ubam \
  OUTPUT=$output.bam \
  R=$fasta CREATE_INDEX=true ADD_MATE_CIGAR=true \
  CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true
  #more options
}

align_mark_reads(){
  input=$1
  fasta=$2
  ubam=$3
  output=$4

  bwa mem -M -t 16 -p $fasta $input \
  | \
  java -jar picard.jar MergeBamAlignment \
  ALIGNED=/dev/stdin \
  UNMAPPED=$ubam \
  OUTPUT=$output.bam \
  R=$fasta CREATE_INDEX=true ADD_MATE_CIGAR=true \
  CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true
}

mark_dups(){
  input=$1
  output=$1

  java -jar picard.jar MarkDuplicates \
  I=$input.bam \
  O=$output.bam \
  M=${input}_markdups_txt \
  CREATE_INDEX=true
  #more options
}


#index genome first
bwa index $GENOME

#make dictionary
java -jar picard.jar CreateSequenceDictionary REFERENCE=$GENOME OUTPUT=${GENOME%.fasta}.dict

samples=${ls *.fastq.gz | awk -F '_[1234]' '{print $1}' | sort -u | tr '\n' \ ''}

for sample in $samples; do

  input=${sample}_*_mark.bam

  ubam=${sample}_*.bam

  output=$(${sample}_*.fastq.gz | tr '_R1.fastq.gz' \ '') #try this

  if [ ! -f ${output}_mapped.bam ]; then
    align_mark_reads $input $GENOME $input ${output}_mapped
  fi

  #your unmapped bam will have adapters marked. check if merging after trimming retains original reads or not. otherwise, change the names around.

  if [ ! -f ${output}_mapped_marked.bam ]; then
    mark_dups ${output}_mapped ${output}_mapped_marked
  fi

  if [ -! -f ${sample}_merged_marked.bam ]; then
    echo "Merging $sample"
    samtools merge ${sample}_merged.bam ${sample}_*mapped_marked.bam
    echo "Marking duplicates for $sample"
    mark_dups ${sample}_merged ${sample}_merged_marked
  fi

done
