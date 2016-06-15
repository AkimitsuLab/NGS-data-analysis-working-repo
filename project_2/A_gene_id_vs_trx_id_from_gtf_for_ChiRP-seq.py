#!/usr/bin/env python3

#Usage: python3 A_gene_id_vs_trx_id_from_gtf_for_ChiRP-seq.py /home/akimitsu/database/Refseq_gene_hg19_June_02_2014.gtf Refseq_gene_hg19_June_02_2014_gene_symbol_trxid.txt

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

ref_dict = {}

for line in input_file:
    flg = 0
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    gene_infor = data[8].split('; ')
    if not data[2] == 'exon':
        pass

    gene_id = ''
    trx_id = ''
    for x in gene_infor:
        if x.startswith('gene_id'):
            x = x.replace('gene_id "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            gene_id = x
            if gene_id == '':
                flg = 1
                continue
        if x.startswith('transcript_id'):
            x = x.replace('transcript_id "', '')
            x = x.replace('"', '')
            x = x.replace(';', '')
            trx_id = x
            if trx_id == '':
                flg = 1
                continue
    if flg == 1:
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

for gene_id in ref_dict.keys():
    if gene_id in ref_dict:
        trx_list = ref_dict[gene_id]
        print(gene_id, ','.join(trx_list), sep="\t", end="\n", file=output_file)
    else:
        gene_name = ref_data[gene_id]
        print(gene_id, 'NA', sep="\t", end="\n", file=output_file)
