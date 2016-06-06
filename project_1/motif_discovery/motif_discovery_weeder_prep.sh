#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#Input files - required
AllFastaFile="/home/akimitsu/database/List_1_mRNA_signifFC2.txt_infection_3UTR.fa"

wfrequency_maker List_1_mRNA_signifFC2.txt_all_3UTR.fa KI
mv KI.6.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles
mv KI.8.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles

wfrequency_maker List_2_lncRNA_signifFC2.txt_all_lncRNA.fa LN
mv LN.6.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles
mv LN.8.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles

wfrequency_maker List_mix_PROMPT_eRNA_SLiT_lncRNA.txt_all_lncRNA_eRNA_PROMPT.fa SL
mv SL.6.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles
mv SL.8.freq /home/akimitsu/software/Weeder1.4.2/FreqFiles
