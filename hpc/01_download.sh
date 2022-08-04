#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N wget
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=1:mem=2gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

wget 'https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/918/875/GCF_003918875.1_ASM391887v1/GCF_003918875.1_ASM391887v1_rna.fna.gz'
gunzip GCF_003918875.1_ASM391887v1_rna.fna.gz


