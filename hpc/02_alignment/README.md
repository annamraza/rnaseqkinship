these reads can be used for mapping, which would map to a ref genome and mark duplicates. Script for mapping (01_map_read.sh) using BWA mem, duplicate marking and indexing.

if ref genome is not available, mapping would occur after assembly (see refgenome)

Merging and remarking of duplicates (02_merge_reads.sh): necessary for input to variant calling

Mapping summary (03_map_summary.sh): necessary, determines which programs to use after
