#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#python3 A_gene_id_vs_trx_id_from_gtf_for_TSS.py gencode.v19.annotation.gtf gencode.v19.annotation_gene_symbol_id_for_TSS.txt
#python3 A_extract_TSS_500.py gencode.v19.annotation.bed gencode.v19.annotation_mRNA_TSS_3000_plus.txt
#python3 B_make_gene_TSS.py gencode.v19.annotation_mRNA_TSS_3000_plus.txt gencode.v19.annotation_gene_symbol_id_for_TSS.txt gencode.v19.annotation_mRNA_TSS_gene_level.txt
#bedtools intersect -a PROMPT_list_ver2_for_UCSC.bed -b gencode.v19.annotation_mRNA_TSS_gene_level.txt -loj > gencode.v19.annotation_mRNA_TSS_gene_level_with_PROMPT.txt
python3 C_tss_distance.py gencode.v19.annotation_mRNA_TSS_gene_level_with_PROMPT.txt gencode.v19.annotation_mRNA_vs_PROMPT_list.txt