#!/bin/#!/usr/bin/env bash

module load picard
module load java

set -e


fastq2ubam(){
  input1=$1
  input2=$2
  output=$3
  sample=$4
  barcode=$5
  lane=$6

  java -jar picard.jar FastqToSam \
  FORWARD=$input1 \
  REVERSE=$input2 \
  OUTPUT=$output \
  SAMPLE_NUMBER=$sample \
  READ_GROUP=$barcode.$lane.$sample
}

markadapt(){
  input=$1
  output=$2

  java -jar picard.jar MarkIlluminaAdapters \
  I=$input.bam
  M=${input}_txt
  O=$output.bam
}

for f in ; do

  if [ ! -f ]; then
    fastq2ubam

  fi

  if [ ! -f ]; then
    markadapt
  fi

done
