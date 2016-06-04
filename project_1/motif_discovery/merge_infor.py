#!/usr/bin/env python3

import sys

ref_file = open(sys.argv[1], 'r')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    gene_id = data[0]
    gene_symbol = data[1]
    gene_type_akimitsu = data[2]
    gene_type_gencode = data[3]
    chrom_site = data[4]
    ref_dict[gene_id] = line

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    gene_id = data[0]
    trx_id = data[1]
    seq = data[2]
    infor = ref_dict[gene_id].split("\t")
    gene_symbol = infor[1]
    gene_type_gencode = infor[3]
    gene_type_akimitsu = infor[2]
    chrom_site = infor[4]
    print(gene_id, trx_id, gene_symbol, gene_type_akimitsu, gene_type_gencode, seq, sep="\t", end="\n", file=output_file)
