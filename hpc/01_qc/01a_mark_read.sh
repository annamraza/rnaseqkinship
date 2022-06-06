#!/bin/#!/usr/bin/env bash

module load picard
module load java

set -e


fastq2ubam(){
  input=$1
  output=$2
  sample=$3
  flowcell=$4
  lane=$5

  java -jar $PICARD_HOME/picard.jar FastqToSam \
  F1=$input \
  O=$output \
  SM=$sample \ #sample_number
  RG=$flowcell.$lane.$sample #read_group
}

markadapt(){
  input=$1
  output=$2

  java -jar $PICARD_HOME/picard.jar MarkIlluminaAdapters \
  I=$input.bam
  M=${input}_txt
  O=$output.bam
}

for f in *.fast.gz; do

  input=$f

  output=${input%_R1.fastq.gz}

  splitf=(${f//_/ })

  sample=${splitf[0]}
  #Is this correct or is the sample name 88_4? ask Ira)
  #run=$(splitf[1])?
  flowcell=${splitf[2]}
  index=${splitf[3]}
  lane=${splitf[4]}

  if [ ! -f $output.bam ]; then
    fastq2ubam $input $output $sample $flowcell $lane
  fi

  if [ ! -f ${output}_mark.bam ]; then
    markadapt $output ${output}_mark
  fi

done
