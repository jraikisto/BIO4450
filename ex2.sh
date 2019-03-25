PATH=$PATH:/opt/binf/apps/hisat2-2.1.0:/opt/binf/apps/samtools-1.9/bin:/opt/binf/apps/bedtools-2.27.1/bin


mkdir hisat2
mkdir hisat2/index

hisat2-build /data/references/hg38.fa hisat2/index/hg38

hisat2 -x ./hisat2/index/hg38 -1 /student_data/BIO4450/data/ex2/patient_1.fq.gz -2 /student_data/BIO4450/data/ex2/patient_2.fq.gz | samtools view -bS -> ./bam/tumor.bam
cd bam
samtools sort tumor.bam -o ./sorted_tumor.bam
bedtools multicov -bams bam/sorted_tumor.bam -bed gencode.v29.annotation.gtf.gz > bedtools_out.bed

julia reading_bedtools.jl
