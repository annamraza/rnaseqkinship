Preprocessing of Raw Reads

Raw sequence data obtained from ? Complete list of raw fastq files is under rawfastq.txt

According to GATK best practices, raw sequence data in FASTQ format is converted to bam files first then has adaptors marked (which would use Picard) this is 02a_adapters.sh

If necessary, more indepth qc would trim instead of mark the adaptors, along with any other bases, along with visualization to confirm trimming was sufficient, and then conversion to ubam. Most pipelines do not do this.
trimmomatic, fastqc, picard here. 02b_trim_reads.sh

#your unmapped bam will have adapters marked. check if merging after trimming retains original reads or not. otherwise, change the names around.
