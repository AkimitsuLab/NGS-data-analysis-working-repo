#!/bin/bash

#import files
gtfFile="gencode.v19.annotation.gtf"
baseFile=`basename ${gtfFile} .gtf`
gtfFileNew="gencode.v19.annotation_filtered+PROMPT_v2+eRNA_v2+FANTOM_eRNA"

python3 extract_gene_symbol_type_from_gtf.py ${gtfFile} ${baseFile}_gene_symbol_id.txt
python3 filter_gtf.py ${baseFile}_gene_symbol_id.txt ${gtfFile} ${baseFile}_filtered.gtf
cat ${baseFile}_filtered.gtf PROMPT_list_ver2_for_featureCounts.gtf eRNA_list_ver2_for_featureCounts.gtf FAMTOM5_eRNA_ver1_rm_Akimitsu_eRNA_PROMPT_for_featureCounts.gtf > ${gtfFileNew}.gtf
python3 extract_gene_symbol_type_from_gtf.py ${gtfFileNew}.gtf ${gtfFileNew}_symbol_type_list.txt
