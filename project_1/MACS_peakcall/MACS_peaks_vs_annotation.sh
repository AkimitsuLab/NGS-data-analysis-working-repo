#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

# Import files - Required
gtf_file="/home/akimitsu/database/gencode.v19.annotation_filtered.gtf"
bed_file="/home/akimitsu/database/gencode.v19.annotation_filtered.bed"

macs_peaks_xls_control="Control_MALAT1_peaks.xls"
macs_peaks_xls_treated="HeatShock_MALAT1_peaks.xls"

macs_peaks_bed_control="Control_MALAT1_peaks.bed"
macs_peaks_bed_treated="HeatShock_MALAT1_peaks.bed"

# Output filenames
macs_peaks_bed_control_basename=`basename ${macs_peaks_bed_control} .bed`
macs_peaks_bed_treated_basename=`basename ${macs_peaks_bed_treated} .bed`
gtf_file_basename=`basename ${gtf_file} .gtf`


python3 A_gene_id_vs_trx_id_from_gtf_for_ChiRP-seq.py ${gtf_file} ${gtf_file_basename}_gene_symbol_trxid.txt
python3 B_define_genebody_regions.py ${bed_file} ${gtf_file_basename}_gene_symbol_trxid.txt ${gtf_file_basename}_genebody.bed ${gtf_file_basename}_promoter.bed

bedtools intersect -a ${macs_peaks_bed_control} -b ${gtf_file_basename}_genebody.bed -wa -wb -loj > ${macs_peaks_bed_control_basename}_vs_GeneBody.bed
bedtools intersect -a ${macs_peaks_bed_control} -b ${gtf_file_basename}_promoter.bed -wa -wb -loj > ${macs_peaks_bed_control_basename}_vs_promoter.bed
bedtools intersect -a ${macs_peaks_bed_treated} -b ${gtf_file_basename}_genebody.bed -wa -wb -loj > ${macs_peaks_bed_treated_basename}_vs_GeneBody.bed
bedtools intersect -a ${macs_peaks_bed_treated} -b ${gtf_file_basename}_promoter.bed -wa -wb -loj > ${macs_peaks_bed_treated_basename}_vs_promoter.bed

python3 C_define_peak_annotation.py ${macs_peaks_xls_control} \
${macs_peaks_bed_control_basename}_vs_GeneBody.bed ${macs_peaks_bed_control_basename}_vs_promoter.bed \
${macs_peaks_bed_control} ${macs_peaks_bed_control_basename}_anno.bed
python3 C_define_peak_annotation.py ${macs_peaks_xls_treated} \
${macs_peaks_bed_treated_basename}_vs_GeneBody.bed ${macs_peaks_bed_treated_basename}_vs_promoter.bed \
${macs_peaks_bed_treated} ${macs_peaks_bed_treated_basename}_anno.bed
