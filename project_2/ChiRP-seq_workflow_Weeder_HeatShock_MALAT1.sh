#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

input_file="/home/akimitsu/data/ChiRP-seq_Mizutani_MALAT1_heatshock/4_HeatShock_input/4_HeatShock_input_160531_Hiseq3A_l2_001_Dr_Akimitsu_Dr_Mizutani_ATCACG_L002_R1_all_3_blacklist_removed.bg"
malat1_file="/home/akimitsu/data/ChiRP-seq_Mizutani_MALAT1_heatshock/6_HeatShock_MALAT1/6_HeatShock_MALAT1_160531_Hiseq3A_l2_020_Dr_Akimitsu_Dr_Mizutani_GTGGCC_L002_R1_all_3_blacklist_removed.bg"
bedtools merge -i ${input_file} > HeatShock_input_reads.bed
bedtools merge -i ${malat1_file} > HeatShock_MALAT1_reads.bed

genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed HeatShock_input_reads.bed -fo HeatShock_input_reads.fa
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed HeatShock_MALAT1_reads.bed -fo HeatShock_MALAT1_reads.fa

#bedtools getfasta -name -s -split -fi ${genomeFasta} -bed HeatShock_LacZ_peaks.bed -fo HeatShock_LacZ_peaks.fa
