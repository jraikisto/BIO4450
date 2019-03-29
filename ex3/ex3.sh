PATH=$PATH:/opt/binf/apps/samtools-1.9/bin:/opt/binf/apps/bedtools-2.27.1/bin

for i in $(ls /student_data/BIO4450/data/ex3/BAM_files/*.bam); do name=$(echo $i| cut -d'/' -f 7); echo "bedtools multicov -bams $i  -bed ..\/ex2\/gencode.v29.annotation.gtf.gz > ${name:0:(-4)}.bed &" >> bedtools_parallel.sh; done
sh bedtools_parallel.sh
