#!/bin/#!/usr/bin/env bash
module load samtools
module load parallel

#at simplest : bcftools mpileup -Ou -f <reference.fa> <alignments.bam> | bcftools call -m -v -Ob -o calls.bcf
#change output format?

GENOME =
#index genome

#split genome into 100kb files
split -C 100K --numeric-suffixes $GENOME alaevi_
#don't think this will work its not a text file

names=($(awk '{print $1}' $fai )) #array of names from indexed genome

lengths=($(awk {'print $2'} $fai)) #array of lentghs from indexed genome

#region_start=($(seq 0 $size $chrom_length)) #list of start positions

awk '$1 !~ /^>/' $fasta >v.txt

readarray -t sequences <v.txt #array of sequences to be split why dont these match the index?

for i in ${!sequences[@]};
do
  sequence=${variables[$i]}
  name=${names[$i]}
  length=${lengths[$i]}
  start=$(seq 0 100 "length") #this must be numerals also multiple outputs here
  size=$(${sequence:start:100} | awk '{print length}') #substring needs fine-tuning and syntax
  end=$(start + size) #for each one

printf or echo "name:start-end" #figure this out once everything else works
  done


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
