#!/usr/bin/env python3

# Usage: python3 B_make_gene_TSS.py gencode.v19.annotation_mRNA_TSS_3000_plus.txt gencode.v19.annotation_gene_symbol_id.txt gencode.v19.annotation_mRNA_TSS_gene_level.txt

import sys
import re

ref_file = open(sys.argv[1], 'r')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    chrom = data[0]
    st = int(data[1])
    ed = int(data[2])
    trx_id = data[3]
    strand = data[4]
    ref_dict[trx_id] = [chrom, st, ed, strand]

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if not re.match('^ENSG',data[0]):
        continue
    if data[1] == 'NA':
        continue
    trx_list = data[1].split(",")
    st_list = []
    ed_list = []
    tss_list = []
    for x in trx_list:
        ref_list = ref_dict[x]
        chrom = ref_list[0]
        st = ref_list[1]
        ed = ref_list[2]
        strand = ref_list[3]
        st_list.append(st)
        ed_list.append(ed)
        if strand == '+':
            tss_list .append(str(st))
        elif strand == '-':
            tss_list.append(str(ed))
    st_list.sort()
    ed_list.sort()
    print(chrom, str(st_list[0]), str(ed_list[-1]), data[0], data[2], ','.join(tss_list), sep="\t", end="\n", file=output_file)
