#!/usr/bin/env python3

# Usage: python3 C_tss_distance.py gencode.v19.annotation_mRNA_TSS_gene_level_with_PROMPT.txt gencode.v19.annotation_mRNA_vs_PROMPT_list.txt

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

def_dict = {}
def_data = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    prompt_name = data[3]
    trx_id = data[9]
    gene_name = data[10]
    if data[6] == '.':
        def_dict[prompt_name] = 'NA'
        continue
    tss_list = data[11].split(',')
    st_tss_list = [abs(int(x) - int(data[1])) for x in tss_list]
    # print(st_tss_list)
    ed_tss_list = [abs(int(x) - int(data[2])) for x in tss_list]
    # print(ed_tss_list)
    tss_list = st_tss_list + ed_tss_list
    tss_list.sort()
    least_tss_length = tss_list[0]
    if not prompt_name in def_dict:
        def_dict[prompt_name] = [trx_id, gene_name]
        def_data[prompt_name] = least_tss_length
    else:
        if least_tss_length < def_data[prompt_name]:
            def_dict[prompt_name] = [trx_id, gene_name]
            def_data[prompt_name] = least_tss_length

for x in def_dict.keys():
    infor_list = def_dict[x]
    trx_id = infor_list[0]
    gene_name = infor_list[1]
    print(x, trx_id, gene_name, sep="\t", end="\n", file=output_file)
