#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N mapangsdtest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load bowtie2

GENOME=haliotis_genome.fa

index_reads(){
  fasta=$1
  index=$2

  bowtie2-build $fasta $index
}

align_reads(){
  index=$1
  input=$2
  output=$3

    bowtie2 -x $index -U $input -S $output
}

for f in *_trim.fastq.gz; do
  fasta=$GENOME
  index=${fasta%ome.fa}
  input=$f
  output=${input%_C*.fastq.gz}

if  [ ! -f ${index}.* ]; then
  index_reads $fasta $index
fi

if [ ! -f ${output}.sam ]; then
  align_reads $index $input ${output}.sam
fi

done
