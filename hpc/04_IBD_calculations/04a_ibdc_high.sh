#look into how to use R and install SNPrelate, gdsfmt, SeqArray

#first load your vfs file into R
vcf.fn <- "*/your_vcf_file.vcf"

#convert your file into SNPrelate format
snpgdsVCF2GDS(vcf.fn, "test.gds", method="biallelic.only")
#also has other methods you could use

#look at the summary
snpgdsSummary("test.gds")

#alternate option is to use SeqArray, recommended for whole-genome sequencing variant data

seqVCF2GDS(vcf.fn, "test2.gds")
genofile2 <- seqOpen("test2.gds")

#reshape the data as per bioconductor page
genofile <- snpgdsOpen("test.gds")

#prune SNPs to be in LD TBD

sample.id <-read.gdsn(index.gdsn(genofile, "sample.id"))
YRI.id<-sample.id[pop_code==YRI] #unsure what this is look up
#or
sample.id2 <-read.gdsn(index.gdsn(genofile2, "sample.id"))
YRI.id2<-sample.id2[pop_code==YRI] #unsure what this is look up

#PLINK method of moments
ibd_mom<-snpgdsIBDMoM(genofile, sample.id=YRI.id, snp.id=snpset.id, maf=0.05, missing.rate=0.05, num.thread=2)
#or
ibd_mom2<-snpgdsIBDMoM(genofile2, sample.id=YRI.id2, snp.id=snpset.id2, maf=0.05, missing.rate=0.05, num.thread=2)

#snpset is the LD pruned SNPs

#make a dataframe
ibd.mom.coeff<-snpgdsIBDselection(ibd_mom)
#or
ibd.mom2.coeff<-snpgdsIBDselection(ibd_mom2)

#MLE
#first estimate IBD coeff
set.seed(100)
snp.id <-sample(snpset.id, 1500) #random 1500 snpgdsSummary
ibd_ml<-snpgdsIBDMLE(genofile, sample.id=YRI.id, snp.id=snp.id, maf=0.05, missing.rate=#0.05, num.thread=2)
#or
set.seed(100)
snp.id2 <-sample(snpset.id2, 1500) #random 1500 snpgdsSummary
ibd_ml2<-snpgdsIBDMLE(genofile2, sample.id=YRI.id2, snp.id=snp.id2, maf=0.05, missing.rate=#0.05, num.thread=2)

#make a dataframe
ibd.ml.coeff<-snpgdsIBDselection(ibd_ml)
#or
ibd.ml2.coeff<-snpgdsIBDselection(ibd_ml2)

#KING MoM reeds pedigree info incorporated
