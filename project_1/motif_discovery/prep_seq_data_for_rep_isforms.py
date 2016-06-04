#!/usr/bin/env python3

import sys

def load_fasta(fasta_path):
    fasta_file = open(fasta_path,'r')
    fasta_dict = {}
    checker = []
    name = ''
    for line in fasta_file:
        line = line.rstrip()
        if line.startswith('#'):
            continue
        if line.startswith('>'):
            name = line[1:].strip()
            if not name in checker:
                checker.append(name)
            else:
                print ('ERROR: The same name exists =>' + name)
                sys.exit(1)
                continue
            fasta_dict[name] = ''
        else:
            trans_table = str.maketrans("ATGCatgcUu","ATGCATGCTT")
            line_changed = line.translate(trans_table) #Translate DNA into RNA
            fasta_dict[name] += line_changed.upper()
    fasta_file.close()
    return fasta_dict

ref_dict = load_fasta(sys.argv[1])

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    gene_id = data[0]
    trx_id = data[1]
    if trx_id in ref_dict:
        seq = ref_dict[trx_id]
        print(gene_id, trx_id, seq, sep="\t", end="\n", file=output_file)
