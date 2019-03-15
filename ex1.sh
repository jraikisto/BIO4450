alias fastqc='/opt/binf/apps/FastQC-0.11.8/fastqc'
alias annovar = '/opt/binf/apps/annovar-2018.04.16/annotate_variation.pl'
PATH=$PATH:/opt/binf/apps/bowtie2-2.3.4.3:/opt/binf/apps/samblaster-0.1.24:/opt/binf/apps/samtools/bin

cd
mkdir ex1
fastqc /student_data/BIO4450/data/ex1/tumor -o ./

mkdir bowtie
cd bowtie
bowtie2-build /data/references/hg38_chr17.fa ./chr17
mkdir index
mv *.bt2 index
bowtie2 -x index/chr17 -1 /student_data/BIO4450/data/ex1/tumor_1.fa.gz -2 /student_data/BIO4450/data/ex1/tumor_2.fa.gz -S tumor.sam -X 1000 -f

samtools sort -o sorted_tumor.sam tumor.sam
samblaster -i sorted_tumor.sam -o samblaster_tumor.sam -e


samtools view  -O BAM samblaster_tumor.sam > tumor.bam
samtools sort -o sorted_tumor.bam tumor.bam
samtools index ./sorted_tumor.bam sorted_tumor.bam.bai

#Possible SNP in chr17:38_914_936

samtools mpileup -B -f /data/references/hg38_chr17.fa ./bowtie/sorted_tumor.bam > tumor.pileup
java -jar /opt/binf/apps/VarScan-2.3.9/VarScan.jar pileup2snp tumor.pileup -output-vcf 1 > tumor_snps.vcf

mkdir annovar
cd annovar
annovar ../tumor_snps.vcf /student_data/BIO4450/data/references/annovar_hg38_databases/humandb/ --outfile tumor_annotation --buildver hg38 --remove --vcfinput --protocol refGene,cosmic70,1000g2014oct_all --operation g,f,f --otherinfo
