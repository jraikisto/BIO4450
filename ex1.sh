alias fastqc='/opt/binf/apps/FastQC-0.11.8/fastqc'
PATH=$PATH:/opt/binf/apps/bowtie2-2.3.4.3

cd
mkdir ex1
fastqc /student_data/BIO4450/data/ex1/tumor -o ./
mkdir bowtie
cd bowtie
bowtie2-build /data/references/hg38_chr17.fa ./chr17
mkdir index
mv *.bt2 index
bowtie2 -x index/chr17 -1 /student_data/BIO4450/data/ex1/tumor_1.fa.gz -2 /student_data/BIO4450/data/ex1/tumor_2.fa.gz -S tumor.sam -X 1000 -f
