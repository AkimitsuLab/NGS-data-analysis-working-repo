#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

ref_dict = {}

for line in input_file:
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    if data[2] == 'transcript' or data[1] in ['AkimitsuLab','FAMTOM5']:
        pass
    gene_infor = data[8].split('; ')
    gene_id = ''
    trx_id = ''
    for x in gene_infor:
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
    if trx_id.startswith('ENSG'):
        continue
    if not gene_id in ref_dict:
        ref_dict[gene_id] = [trx_id]
    else:
        if not trx_id in ref_dict[gene_id]:
            ref_dict[gene_id].append(trx_id)

for gene_id in ref_dict.keys():
    trx_list = ref_dict[gene_id]
    print(gene_id, ','.join(trx_list), sep="\t", end="\n", file=output_file)
