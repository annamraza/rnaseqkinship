#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N fastqcstats
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=10gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

dt=$(date)

set -e

echo $dt

for f in *.zip; do
  input=$f
  name=${input%_C*_fastqc.zip}
  nums=$(unzip -c $f *data.txt|awk 'NR==9||NR==11 {print$3}'|tr '\n' \ '')

  echo $name $nums
done>fastqfilestrimmed.tsv

echo $dt
