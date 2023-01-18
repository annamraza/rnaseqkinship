#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N trimreads
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load trimmomatic

set -e

trim_reads(){
  input=$1
  output=$2

TrimmomaticSE $input $output ILLUMINACLIP:TruSeq3-SE.fa:2:30:10
}

for f in *.fastq.gz; do

  input=$f

  output=${input%_R1.fastq.gz}

  if [ ! -f ${output}_trim.fastq.gz ]; then
    trim_reads $input ${output}_trim.fastq.gz
  fi

done
