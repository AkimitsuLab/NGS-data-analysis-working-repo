#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#Input files - required
InputFile1="/home/akimitsu/database/List_1_mRNA_signifFC2.txt_infection_3UTR.fa"
InputFile2="/home/akimitsu/database/List_2_lncRNA_signifFC2.txt_infection_lncRNA.fa"
InputFile3="/home/akimitsu/database/List_mix_PROMPT_eRNA_SLiT_lncRNA.txt_infection_SLiT_eRNA_PROMPT.fa"

./weederlauncher.out ${InputFile1} KI small
./weederlauncher.out ${InputFile2} LN small
./weederlauncher.out ${InputFile3} SL small
