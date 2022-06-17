#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N trimtest
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=4gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

module load singularity

singularity run /sw/containers/trimmomatic-0.39.sif TrimmomaticSE 77_1_C5H1BACXX_GATCAG_L001_R1.fastq.gz 77_1_C5H1BACXX_GATCAG_L001_R1_trim.fastq.gz ILLUMINACLIP:TruSeq3-SE.fa:2:30:10
singularity run /sw/containers/trimmomatic-0.39.sif TrimmomaticSE 88_1_C5H1BACXX_AGTCAA_L001_R1.fastq.gz 88_1_C5H1BACXX_AGTCAA_L001_R1_trim.fastq.gz ILLUMINACLIP:TruSeq3-SE.fa:2:30:10
