#!/usr/bin/env python3

import sys

ref_file = open(sys.argv[1], 'r')

black_list = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    gene_id = data[0]
    gene_type = data[2]
    if gene_type == 'black':
        black_list[gene_id] = 1

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

for line in input_file:
    flg = 0
    line = line.rstrip()
    if line.startswith('#'):
        continue
    data = line.split("\t")
    gene_infor = data[8].split("; ")
    for x in gene_infor:
        if x.startswith('gene_id'):
            x = x.replace('gene_id "', '')
            x = x.replace('"', '')
            if x in black_list:
                flg = 1
                break
        if x.startswith('transcript_type'):
            x = x.replace('transcript_type "', '')
            x = x.replace('"', '')
            if x == 'rRNA' or x == 'Mt_rRNA' or x == 'Mt_tRNA':
                # print(line)
                flg = 1
                break
    if flg == 0:
        print(line, end="\n", file=output_file)
