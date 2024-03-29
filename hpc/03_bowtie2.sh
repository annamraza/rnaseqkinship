#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mapping
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load bowtie2

GENOME=haliotis_genome.fa

align_reads(){
  index=$1
  input=$2
  output=$3

    bowtie2 -x $index -U $input -S $output
}


bowtie2-build -f $GENOME haliotis_gen

for f in *_trim.fastq.gz; do
  fasta=$GENOME
  index=${fasta%ome.fa}
  input=$f
  output=${input%_C*.fastq.gz}

if [ ! -f ${output}.sam ]; then
  align_reads $index $input ${output}.sam
fi

done
