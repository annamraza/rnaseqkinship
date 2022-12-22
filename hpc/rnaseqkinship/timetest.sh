#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N timetest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=1:00:00
#PBS -l select=1:ncpus=1:mem=1gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

#t1=$(time)

#t2=$(walltime)

time

#echo t1

echo hello i hope this works

#echo t1

#echo t2

time

walltime
