#!/usr/bin/env python3

import sys

ref_file = open(sys.argv[1], 'r')
output_file_all = open(sys.argv[3], 'w')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    gene_id = data[0]
    gene_type = data[3]
    if not gene_type in ['lncRNA', 'FANTOM5_eRNA', 'Akimitsu_eRNA', 'Akimitsu_PROMPT']:
        continue
    seq = data[5]
    name = '|'.join(data[:5])
    ref_dict[gene_id] = [seq, name]
    print('>' + name, sep="", end="\n", file=output_file_all)
    print(seq, end="\n", file=output_file_all)

input_file = open(sys.argv[2], 'r')
output_file_targets = open(sys.argv[4], 'w')

count = 0
for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == 'gene_id':
        continue
    gene_id = data[0]
    if gene_id in ref_dict:
        seq = ref_dict[gene_id][0]
        name = ref_dict[gene_id][1]
        print('>', name, sep="", end="\n", file=output_file_targets)
        print(seq, end="\n", file=output_file_targets)
    else:
        count += 1

print(count)
