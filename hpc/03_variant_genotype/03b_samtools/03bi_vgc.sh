#!/bin/#!/usr/bin/env bash
module load samtools
module load parallel

#at simplest : bcftools mpileup -Ou -f <reference.fa> <alignments.bam> | bcftools call -m -v -Ob -o calls.bcf
#change output format?

GENOME =
#index genome

#list of alignments
ls folder/*_merged_marked.bam > input_bam.txt
#or .filelist
#do they need to be indexed first?

#index files- should this be parallel too?
for f in *_merged_marked.bam; do

input=$f

if [ ! -f ${input}.bai ]; then
  samtools index $input
fi

done

#each genome file needs to be input for mpileup in parallel. can genome split be piped to this?
parallel -j n 'bcftools mpileup -Ou -f alaevi_$(printf "%02d" {}).fa -b <list of bam aligment files>' ::: {1...(last)}

#where n is the number of cores and last is the final number in files
#only mpileup is parallel,  concat first before call

#make a list of the bcf files
ls folder/*.bcf > bcf_list.txt

#combine them into one
bcftools concat --file-list bcf_list.txt -Ob --output output.bcf

#use for calling
bcftools call -m -v -Ob -o calls.bcf output.bcf

#or maybe?
bcftools concat --file-list bcf_list.txt -Ob --output output.bcf | bcftools call -m -v -Ob -o calls.bcf
