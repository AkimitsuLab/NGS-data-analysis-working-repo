#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

bedtools subtract -a Control_MALAT1_peaks.bed -b Control_LacZ_peaks.bed -A > Control_MALAT1_peaks_LacZ_minus.bed
bedtools subtract -a Control_MALAT1_peaks_LacZ_minus.bed -b MALAT1.bed -A > Control_MALAT1_peaks_LacZ_MALAT1_minus.bed
genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed Control_MALAT1_peaks_LacZ_MALAT1_minus.bed -fo Control_MALAT1_peaks_LacZ_MALAT1_minus.fa
