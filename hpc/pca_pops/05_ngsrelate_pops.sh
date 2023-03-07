#!/bin/bash
#PBS -j oe
#PBS -m ae
#PBS -N ngsrelate_pops
#PBS -M FIRSTNAME.LASTNAME@jcu.edu.au
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=6:mem=200gb

cd $PBS_O_WORKDIR
shopt -s expand_aliases
source /etc/profile.d/modules.sh
echo "Job identifier is $PBS_JOBID"
echo "Working directory is $PBS_O_WORKDIR"

set -e

module load ngsrelate/2.0

#Population A

#ANGSD output

zcat gl_p1.mafs.gz | cut -f5 |sed 1d >freqp1

ngsrelate -g gl_p1.glf.gz -n 9 -f freqp1 -O newresp1 -p 6 -z bam_p1.filelist

#BCFtools output

ngsrelate  -h snpcallsfilt_p1.vcf -O vcfp1.res -n 9 -z bam_p1.filelist

#Population B

#ANGSD output

zcat gl_p2.mafs.gz | cut -f5 |sed 1d >freqp2

ngsrelate -g gl_p2.glf.gz -n 15 -f freqp2 -O newresp2 -p 6 -z bam_p2.filelist

#BCFtools output

ngsrelate  -h snpcallsfilt_p2.vcf -O vcfp2.res -n 15 -z bam_p2.filelist

#Population B

#ANGSD output

zcat gl_p3.mafs.gz | cut -f5 |sed 1d >freqp3

ngsrelate -g gl_p3.glf.gz -n 13 -f freqp3 -O newresp3 -p 6 -z bam_p3.filelist

#BCFtools output

ngsrelate  -h snpcallsfilt_p3.vcf -O vcfp3.res -n 13 -z bam_p3.filelist
