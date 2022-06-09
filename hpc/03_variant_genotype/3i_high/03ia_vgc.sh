#!/bin/#!/usr/bin/env bash
module load samtools
module load parallel

#at simplest : bcftools mpileup -Ou -f <reference.fa> <alignments.bam> | bcftools call -m -v -Ob -o calls.bcf
#change output format?

GENOME =
#index genome

#split genome into 100kb files
#split -C 100K --numeric-suffixes $GENOME alaevi_
#don't think this will work its not a text file

names=($(awk '{print $1}' $fai )) #array of names from indexed genome

lengths=($(awk {'print $2'} $fai)) #array of lentghs from indexed genome

#region_start=($(seq 0 $size $chrom_length)) #list of start positions

awk '$1 !~ /^>/' $fasta >v.txt

readarray -t sequences <v.txt #second file matched index- clean and redo these all

for i in ${!sequences[@]};
do
  sequence=${variables[$i]}
  name=${names[$i]}
  length=${lengths[$i]}
  start=$(seq 0 100 "length") #this must be numerals also multiple outputs here another array
  size=$(${sequence:start:100} | awk '{print length}') #substring needs fine-tuning and syntax
  end=$(start + size) #for each one

printf or echo "name:start-end" #figure this out once everything else works
  done

genome_split{}(
fasta=$1
size=$2

awk '$1 !~ /^>/' $fasta > sqs.txt
readarray -t sqs <sqs.txt

fai= samtools faidx $fasta

names=($(awk '{print $1}' $fai ))
lengths=($(awk {'print $2'} $fai))

for i in ${!sqs[@]}
do
  for i in ${!names[@]}
  do
    for i in ${!lengths[@]}
    do
      name=${names[$i]}
      length=${lengths[$i]}
      sqs=${sqs[$i]}

      starts=$($(seq 0 $size $length))
      regions=$("${seq:$start:$size}") #gives results but command not found? works upto this point

)

or

starts=$(seq 0 $size $length) #does this need to start at one?
start_string=($starts)
starts3=${start_string[@]::${#start_string[@]}-1}
start_fin=${start_string[-1]}

ends=starts3+size
end=start_fin+length
#something like that

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
