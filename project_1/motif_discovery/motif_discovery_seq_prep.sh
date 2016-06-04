#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#Input files - required
gtfFile="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA.gtf"
cuffnormIsoformResult="/sshare4/home_mig/akimitsu/data/RNAseq_150129_Dr_Yamamoto/cuffnorm_out_RNA-seq_test/isoforms.fpkm_table"
genomeFasta="/home/akimitsu/database/bowtie1_index/hg19.fa"

gtfBasename=`basename ${gtfFile} .gtf`

# Prepare BED file
gtf2bed.pl ${gtfBasename}.gtf > ${gtfBasename}.bed
~/custom_command/extract_3UTR_bed12/D_make_3UTR_bed_format_data.pl ${gtfBasename}.bed ${gtfBasename}_3UTR.bed ${gtfBasename}_non-3UTR.bed

# Prepare FASTA file
bedtools getfasta -name -s -split -fi ${genomeFasta} -bed ${gtfBasename}.bed -fo ${gtfBasename}.fa
bedtools getfasta -s -split -name -fi ${genomeFasta} -bed ${gtfBasename}_3UTR.bed -fo ${gtfBasename}_3UTR.fa

# Prepare gene_id - trx_id pairs
python3 gene_id_vs_trx_id_from_gtf.py ${gtfBasename}.gtf ${gtfBasename}_gene_trx_id.txt

# Define representative isoforms
python3 define_representative_isoforms.py ${cuffnormIsoformResult} ${gtfBasename}_gene_trx_id.txt ${gtfBasename}_rep_isoforms.txt 

# Get sequences
python3 prep_seq_data_for_rep_isforms.py ${gtfBasename}.fa ${gtfBasename}_rep_isoforms.txt ${gtfBasename}_rep_isoforms_seq_plus.txt
python3 prep_seq_data_for_rep_isforms.py ${gtfBasename}_3UTR.fa ${gtfBasename}_rep_isoforms.txt ${gtfBasename}_rep_isoforms_seq_plus_3UTR.txt

# Merge detail information
anotherInfor="/home/akimitsu/database/gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA_symbol_type_list.txt"
python3 merge_infor.py ${anotherInfor} ${gtfBasename}_rep_isoforms_seq_plus.txt ${gtfBasename}_rep_isoforms_seq_sharp.txt
python3 merge_infor.py ${anotherInfor} ${gtfBasename}_rep_isoforms_seq_plus_3UTR.txt ${gtfBasename}_rep_isoforms_seq_sharp_3UTR.txt
