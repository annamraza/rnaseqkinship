#!/bin/#!/usr/bin/env bash

module load picard
module load bwa
module load java

GENOME=

set -e

align_reads(){
  input=$1
  fasta=$2
  ubam=$3
  output=$4

  java -jar picard.jar SamtoFastq \
  I=$input.bam \
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

for f in ; do

  if [ ! -f ]; then
    align_reads

  fi

  if [ ! -f ]; then
    mark_dups
  fi

done
