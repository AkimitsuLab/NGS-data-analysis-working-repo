#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

file=`basename ${1} .fastq`
repeat_index="/home/akimitsu/database/repeatitive_elements/Repeatitive_elements_rRNA_snRNA_YRNA_Chang_Lab"

#bowtie2 -p 8 -x ${repeat_index} ${file}.fastq --un ${file}_1_filtered.fastq > ${file}_1_repeats.fastq
#rm ${file}_1_repeats.fastq
#bwa mem -t 8 /home/akimitsu/database/genome/hg19/hg19.fa ${file}_1_filtered.fastq > ${file}_1_filtered.sam
#samtools view -Sb ${file}_1_filtered.sam | samtools sort - ${file}_1_filtered

repeat_index2="/home/akimitsu/database/repeatitive_elements/Repeatitive_elements_rRNA_snRNA_YRNA_rmsk"

#bowtie2 -p 8 -x ${repeat_index2} ${file}.fastq --un ${file}_all_1_filtered.fastq > ${file}_all_1_repeats.fastq
#rm ${file}_all_1_repeats.fastq
#bwa mem -t 8 /home/akimitsu/database/genome/hg19/hg19.fa ${file}_all_1_filtered.fastq > ${file}_all_1_filtered.sam
#samtools view -Sb ${file}_all_1_filtered.sam | samtools sort - ${file}_all_1_filtered

#java -Xmx10000m -jar /home/akimitsu/software/picard-tools-1.119/MarkDuplicates.jar I="${file}_all_1_filtered.bam" O="${file}_all_2_rm_duplicates.bam" \
#M="${file}_all.marked.txt" TMP_DIR="./" AS=true REMOVE_DUPLICATES=true VALIDATION_STRINGENCY=SILENT

#blacklist="/home/akimitsu/database/genome/hg19_blacklist/hg19_blacklist.bed"
#intersectBed -abam ${file}_all_2_rm_duplicates.bam -b ${blacklist} -v > ${file}_all_3_blacklist_removed.bam
samtools flagstat ${file}_all_3_blacklist_removed.bam > ${file}_all_3_blacklist_removed_stats.txt
bedtools genomecov -ibam ${file}_all_3_blacklist_removed.bam -bg > ${file}_all_3_blacklist_removed.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > tmp_${file}.txt
cat tmp_${file}.txt ${file}_all_3_blacklist_removed.bg > ${file}_all_3_blacklist_removed_for_UCSC.bg
bzip2 -c ${file}_all_3_blacklist_removed_for_UCSC.bg > ${file}_all_3_blacklist_removed_for_UCSC.bg.bz2









