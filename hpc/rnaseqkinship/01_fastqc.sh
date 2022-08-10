#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N fastqctimed
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=20gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load fastqc

dt=$(date)

echo $dt

for f in *[!_trim].fastq.gz; do

fastqc $f -o ~/rnaseqkinship/fastqc

done

echo $dt

for f in *[_trim].fastq.gz; do

fastqc $f -o ~/rnaseqkinship/fastqc/trimmed

done

echo $dt
