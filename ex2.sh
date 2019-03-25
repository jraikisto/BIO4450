PATH=$PATH:/opt/binf/apps/hisat2-2.1.0:/opt/binf/apps/samtools-1.9/bin:/opt/binf/apps/bedtools-2.27.1/bin:/opt/binf/apps/kallisto-0.45.0


mkdir hisat2
mkdir hisat2/index

hisat2-build /data/references/hg38.fa hisat2/index/hg38

hisat2 -x ./hisat2/index/hg38 -1 /student_data/BIO4450/data/ex2/patient_1.fq.gz -2 /student_data/BIO4450/data/ex2/patient_2.fq.gz | samtools view -bS -> ./bam/tumor.bam
cd bam
samtools sort tumor.bam -o ./sorted_tumor.bam
cd ..
bedtools multicov -bams bam/sorted_tumor.bam -bed gencode.v29.annotation.gtf.gz > bedtools_out.bed

julia reading_bedtools.jl

mkdir kallisto
cd kallisto
kallisto index -i kallisto_index /student_data/BIO4450/data/references/GRCh38_latest_rna.fa
kallisto quant -i kallisto_index -o output -t 3 /student_data/BIO4450/data/ex2/patient_1.fq.gz /student_data/BIO4450/data/ex2/patient_2.fq.gz 
