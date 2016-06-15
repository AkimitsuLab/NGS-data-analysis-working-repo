#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

#python3 A_gene_id_vs_trx_id_from_gtf_for_ChiRP-seq.py /home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf Refseq_gene_hg19_June_02_2014_gene_symbol_trxid.txt
#python3 B_define_genebody_regions.py /home/akimitsu/database/Refseq_gene_hg19_June_02_2014.bed Refseq_gene_hg19_June_02_2014_gene_symbol_trxid.txt Refseq_gene_hg19_June_02_2014_genebody.bed Refseq_gene_hg19_June_02_2014_promoter.bed

genebody="Refseq_gene_hg19_June_02_2014_genebody.bed"
promoter="Refseq_gene_hg19_June_02_2014_promoter.bed"
control="Control_MALAT1_peaks_LacZ_MALAT1_minus"
heatshock="HeatShock_MALAT1_peaks_LacZ_MALAT1_minus"

#bedtools intersect -a ${control}.bed -b ${genebody} -wa -wb -loj > ${control}_vs_GeneBody.bed
#bedtools intersect -a ${control}.bed -b ${promoter} -wa -wb -loj > ${control}_vs_promoter.bed
#bedtools intersect -a ${heatshock}.bed -b ${genebody} -wa -wb -loj > ${heatshock}_vs_GeneBody.bed
#bedtools intersect -a ${heatshock}.bed -b ${promoter} -wa -wb -loj > ${heatshock}_vs_promoter.bed

#python3 C_define_peak_annotation.py Control_MALAT1_peaks.xls Control_MALAT1_peaks_LacZ_MALAT1_minus_vs_GeneBody.bed Control_MALAT1_peaks_LacZ_MALAT1_minus_vs_promoter.bed Control_MALAT1_peaks_LacZ_MALAT1_minus.bed Control_MALAT1_peaks_LacZ_MALAT1_minus_anno.bed
#python3 C_define_peak_annotation.py HeatShock_MALAT1_peaks.xls HeatShock_MALAT1_peaks_LacZ_MALAT1_minus_vs_GeneBody.bed HeatShock_MALAT1_peaks_LacZ_MALAT1_minus_vs_promoter.bed HeatShock_MALAT1_peaks_LacZ_MALAT1_minus.bed HeatShock_MALAT1_peaks_LacZ_MALAT1_minus_anno.bed
