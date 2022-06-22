module load ANGSD

zcat gl_list.mafs.gz | cut -f5 |sed 1d >freq
#extract frequency column from allele freq file and remove header, as per angsd github

./ngsrelate -g gl_list.mafs.gz -n 100 -f freq -O newres

#run NGSrelate; newres should contain output for all pairs between individuals
#output needs to be manipulated for PLINK
