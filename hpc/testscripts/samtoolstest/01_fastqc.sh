
module load fastqc

fastqc 77_*.fastq.gz 88_*.fastq.gz
#ran in commandline

#for trimmed files:
fastqc *_trim.fastq.gz