#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

input_file="/home/akimitsu/data/ChiRP-seq_Mizutani_MALAT1_heatshock/1_Control_input/1_Control_input_160531_Hiseq3A_l2_002_Dr_Akimitsu_Dr_Mizutani_CGATGT_L002_R1_all_3_blacklist_removed.bg"
malat1_file="/home/akimitsu/data/ChiRP-seq_Mizutani_MALAT1_heatshock/3_Control_MALAT1/3_Control_MALAT1_160531_Hiseq3A_l2_019_Dr_Akimitsu_Dr_Mizutani_GTGAAA_L002_R1_all_3_blacklist_removed.bg"
#bedtools merge -i ${input_file} > Control_input_reads.bed
bedtools merge -i ${malat1_file} > Control_MALAT1_reads.bed

genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed Control_input_reads.bed -fo Control_input_reads.fa
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed Control_MALAT1_reads.bed -fo Control_MALAT1_reads.fa
#bedtools getfasta -name -s -split -fi ${genomeFasta} -bed Control_LacZ_peaks.bed -fo Control_LacZ_peaks.fa
