#!/bin/#!/usr/bin/env bash

module load trimmomatic
module load picard
module load java

set -e

trim_reads(){
  input=$1
  output=$2

  java -jar trimmomatic-0.39.jar SE \ #add trimmomatic path
  $input \
  $output \
  ILLUMINACLIP:#which adaptor sequences to use? \
  LEADING:3 \
  TRAILING:3 \
  MINLEN: #tbd
}

#define actual path
#add threads
#do you want a trimlog


fastq2ubam(){
  input=$1
  output=$2
  sample=$3
  flowcell=$4
  lane=$5

  java -jar picard.jar FastqToSam \
  F1=$input1 \
  O=$output \
  SM=$sample \
  RG=$flowcell.$lane.$sample
}

for f in *.fast.gz; do

  input=$f

  output=${input%R1.fastq.gz}

  splitf=(${f//_/ })

  sample=${splitf[0]}
  #Is this correct or is the sample name 88_4? ask Ira)
  #run=$(splitf[1])?
  flowcell=${splitf[2]}
  index=${splitf[3]}
  lane=${splitf[4]}

  if [ ! -f ${output}_trim.fastq.gz ]; then
    trim_reads $input $output
  fi

  if [ ! -f ${output}_qc.bam ]; then
    fastq2ubam ${input}_trim ${output}_qc $sample $flowcell $lane
  fi

done

#you need to add visualization
