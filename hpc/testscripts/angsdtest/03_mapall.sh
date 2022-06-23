#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mapangsdtest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2

GENOME=haliotis_genome.fa

align_reads(){
  fasta=$1
  index=$2
  input=$3
  output=$4

  bowtie2-build $fasta $index
  bowtie2 -x $index -U $input -S $output
}

for f in *_trim.fastq.gz; do
  fasta=$GENOME
  index=${fasta%ome.fa}
  input=$f
  output=${output%_C*.fastq.gz}

  if [ ! -f ${output}.sam  ]; then
    align_reads $fasta $index $input ${output}.sam
  fi
done
