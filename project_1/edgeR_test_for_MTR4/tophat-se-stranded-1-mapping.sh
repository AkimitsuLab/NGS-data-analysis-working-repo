#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

file=`basename ${1} .fastq`
gtfFile="/home/akimitsu/database/gencode.v19.annotation.gtf"
indexFile="/home/akimitsu/database/bowtie1_index/hg19"

tophat --bowtie1 --library-type fr-firststrand -p 8 -o tophat_out_${file} -G ${gtfFile} ${indexFile} ${file}.fastq
