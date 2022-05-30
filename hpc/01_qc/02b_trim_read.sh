#!/bin/#!/usr/bin/env bash

module load trimmomatic
module load picard
module load java

set -e

trim_reads(){
  inputf=$1
  inputr=$2
  outputf=$3
  outputr=$4

  java -jar trimmomatic-0.39.jar PE \
  $inputf \
  $inputr \
  $outputf \
  $outputr \
  ILLUMINACLIP:#which adaptor sequences to use? \
  LEADING:3 \
  TRAILING:3 \
  MINLEN: #tbd
}

#define actual path
#add threads
#do you want a trimlog


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

for f in ; do

  if [ ! -f ]; then
    trim_reads

  fi

  if [ ! -f ]; then
    fastq2ubam
  fi

done
