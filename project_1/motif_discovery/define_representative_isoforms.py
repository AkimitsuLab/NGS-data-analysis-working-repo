#!/usr/bin/env python3

import sys

ref_file = open(sys.argv[1], 'r')

ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == 'tracking_id':
        continue
    trx_id = data[0]
    exp_data = data[2]
    if trx_id.startswith('ENSG'):
        continue
    ref_dict[trx_id] = exp_data


input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

count = 0

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    gene_id = data[0]
    trx_list = [[x, ref_dict[x]] for x in data[1].split(',') if x in ref_dict]
    if len(trx_list) == 0:
        count += 1
        continue
    trx_list.sort(key=lambda x:x[1] )
    print(gene_id, trx_list[-1][0], sep="\t", end="\n", file=output_file)

print(count)
