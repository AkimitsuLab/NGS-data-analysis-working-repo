#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

#File information - required
BamFile="/home/akimitsu/data/BRIC-seq_HeLa_v2/tophat_out_DRR029126_BRIC_PolyAminus_Hela_0h/accepted_hits.bam"
BamFileName="BRIC-seq_HeLa_0h"

#Annotation
#GTFFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf"
#GTFFile="/home/akimitsu/database/Refseq_gene_hg19_June_02_2014+PROMPT+eRNA+FANTOM_eRNA.gtf"
GTFFile="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA.gtf"
annoList="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA_symbol_type_list.txt"

#featureCounts - read counts
#featureCounts -T 8 -t exon -g gene_id -a ${GTFFile} -o featureCounts_result_${BamFileName}.txt ${BamFile}
sed -e "1,2d" featureCounts_result_${BamFileName}.txt > featureCounts_result_${BamFileName}_pre.txt
python3 featureCounts_filecheck.py featureCounts_result_${BamFileName}_pre.txt featureCounts_result_${BamFileName}_for_R.txt
rm featureCounts_result_${BamFileName}_pre.txt
