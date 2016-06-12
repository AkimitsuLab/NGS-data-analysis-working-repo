#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

inputDir=${1}
inputFile=`basename accepted_hits.bam .bam`

cd ${inputDir}
bedtools genomecov -ibam ${inputFile}.bam -bg -split -strand - > ${inputFile}_forward.bg
bedtools genomecov -ibam ${inputFile}.bam -bg -split -strand + > ${inputFile}_reverse.bg
echo "track type=bedGraph name=${inputFile} description=${inputFile} visibility=2 maxHeightPixels=40:40:20 color=255,0,0" > tmp_${inputFile}_forward.txt
echo "track type=bedGraph name=${inputFile} description=${inputFile} visibility=2 maxHeightPixels=40:40:20 color=0,0,255" > tmp_${inputFile}_reverse.txt
cat tmp_${inputFile}_forward.txt ${inputFile}_forward.bg > ${inputFile}_forward_for_UCSC.bg
cat tmp_${inputFile}_reverse.txt ${inputFile}_reverse.bg > ${inputFile}_reverse_for_UCSC.bg
bzip2 -c ${inputFile}_forward_for_UCSC.bg > ${inputFile}_forward_for_UCSC.bg.bz2
bzip2 -c ${inputFile}_reverse_for_UCSC.bg > ${inputFile}_reverse_for_UCSC.bg.bz2
