#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N samtools20
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=36:00:00
#PBS -l select=1:ncpus=1:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load samtools

#dt=$(date)

#echo $dt

for f in *.sam; do

  name=$(basename $f .sam)

if [ ! -f ${name}_20.bam ]; then
  samtools view -bS -q 20 ${name}.sam | samtools sort -o ${name}_20.bam
fi

done

mv *_20.bam ~/rnaseqkinship/mapqtest
