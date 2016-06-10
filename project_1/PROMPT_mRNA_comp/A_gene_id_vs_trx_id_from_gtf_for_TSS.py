#!/usr/bin/env python3

#Usage: python3 A_gene_id_vs_trx_id_from_gtf_for_TSS.py gencode.v19.annotation.gtf gencode.v19.annotation_gene_symbol_id_for_TSS.txt

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

ref_dict = {}
ref_data = {}

for line in input_file:
    flg = 0
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    gene_infor = data[8].split('; ')
    if data[2] == 'gene':
        gene_id = ''
        gene_name = ''
        for x in gene_infor:
            if x.startswith('gene_id'):
                x = x.replace('gene_id "', '')
                x = x.replace('"', '')
                x = x.replace(';', '')
                gene_id = x
            if x.startswith('gene_name'):
                x = x.replace('gene_name "', '')
                x = x.replace('"', '')
                x = x.replace(';', '')
                gene_name = x
            if x.startswith('gene_type'):
                x = x.replace('gene_type "', '')
                x = x.replace('"', '')
                x = x.replace(';', '')
                gene_type = x
                if x != 'protein_coding':
                    flg = 1
                    continue
        if flg == 0:
            ref_data[gene_id] = gene_name
        flg = 0
    if not data[2] == 'transcript':
        pass

    gene_id = ''
    trx_id = ''
    for x in gene_infor:
        if x.startswith('transcript_type'):
            x = x.replace('transcript_type "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            if x != 'protein_coding':
                flg = 1
                continue
        if x.startswith('transcript_status'):
            x = x.replace('transcript_status "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            if x == 'PUTATIVE':
                flg = 1
                continue
        if x.startswith('gene_id'):
            x = x.replace('gene_id "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            gene_id = x
        if x.startswith('transcript_id'):
            x = x.replace('transcript_id "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            trx_id = x
    if flg == 1:
        continue
    if trx_id.startswith('ENSG'):
        continue
    if not gene_id in ref_dict:
        ref_dict[gene_id] = [trx_id]
    else:
        if not trx_id in ref_dict[gene_id]:
            ref_dict[gene_id].append(trx_id)

# for gene_id in ref_dict.keys():
#     trx_list = ref_dict[gene_id]
#     gene_name = ref_data[gene_id]
#     print(gene_id, ','.join(trx_list),gene_name, sep="\t", end="\n", file=output_file)

for gene_id in ref_data.keys():
    if gene_id in ref_dict:
        trx_list = ref_dict[gene_id]
        gene_name = ref_data[gene_id]
        print(gene_id, ','.join(trx_list),gene_name, sep="\t", end="\n", file=output_file)
    else:
        gene_name = ref_data[gene_id]
        print(gene_id, 'NA',gene_name, sep="\t", end="\n", file=output_file)
