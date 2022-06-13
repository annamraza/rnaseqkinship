these reads can be used for mapping, which would map to a ref genome and mark duplicates. Script for mapping and merging and remarking duplicates (necessary for input to variant callers) (01_map_read.sh) using BWA mem, PICARD, samtools, and indexing.

if ref genome is not available, mapping would occur after assembly (see refgenome)

Mapping summary (02_map_summary.sh): necessary
#determines which programs to use after??
