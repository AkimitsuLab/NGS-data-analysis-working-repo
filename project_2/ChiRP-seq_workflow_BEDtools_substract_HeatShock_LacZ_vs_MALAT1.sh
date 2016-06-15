#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

bedtools subtract -a HeatShock_MALAT1_peaks.bed -b HeatShock_LacZ_peaks.bed -A > HeatShock_MALAT1_peaks_LacZ_minus.bed
bedtools subtract -a HeatShock_MALAT1_peaks_LacZ_minus.bed -b MALAT1.bed -A > HeatShock_MALAT1_peaks_LacZ_MALAT1_minus.bed
genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed HeatShock_MALAT1_peaks_LacZ_MALAT1_minus.bed -fo HeatShock_MALAT1_peaks_LacZ_MALAT1_minus.fa
