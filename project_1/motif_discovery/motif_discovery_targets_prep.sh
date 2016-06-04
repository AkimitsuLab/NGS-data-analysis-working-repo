#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#Input files - required
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA.gtf"
DEGList1="/home/akimitsu/database/List_1_mRNA_signifFC2.txt"
DEGList2="/home/akimitsu/database/List_2_lncRNA_signifFC2.txt"

gtfBasename=`basename ${gtfFile} .gtf`
python3 create_fasta_from_DEG_file.py ${gtfBasename}_rep_isoforms_seq_sharp_3UTR.txt ${DEGList1} ${DEGList1}_all_3UTR.fa  ${DEGList1}_infection_3UTR.fa
python3 create_fasta_from_DEG_file_for_lncRNA.py ${gtfBasename}_rep_isoforms_seq_sharp.txt ${DEGList2} ${DEGList2}_all_lncRNA.fa  ${DEGList2}_infection_lncRNA.fa
