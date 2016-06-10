#!/usr/bin/env python3

#Usage: python3 A_extract_TSS_500.py gencode.v19.annotation.bed gencode.v19.annotation_mRNA_TSS_3000_plus.txt

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    chrom = data[0]
    st = data[1]
    ed = data[2]
    strand = data[5]
    gene_id = data[3]
    if strand == '+':
        st_tss = st
        ed_tss = str(int(st) - 3000)
        print(chrom, ed_tss, st_tss, gene_id, strand, sep="\t", end="\n", file=output_file)
        continue
    elif strand == '-':
        st_tss = str(int(ed) - 1)
        ed_tss = int(st_tss) + 3000
        print(chrom, st_tss, ed_tss, gene_id, strand, sep="\t", end="\n", file=output_file)
