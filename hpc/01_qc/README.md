Preprocessing of Raw Reads

Raw sequence data obtained from ? Complete list of raw fastq files should be in this folder.

According to GATK best practices, raw sequence data first has adaptors marked (which would use picard) this is 02a_adapters.sh

Most pipelines do not do this but if necessary, more indepth qc would trim instead of mark the adaptors, along with any other bases, along with visualization to confirm trimming was sufficient, and then conversion to ubam.
trimmomatic, fastqc, picard here. 02b_trim_reads.sh
