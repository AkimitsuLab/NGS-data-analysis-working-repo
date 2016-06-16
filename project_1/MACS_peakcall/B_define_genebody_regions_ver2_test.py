#!/usr/bin/env python3

# Usage: python3 B_define_genebody_regions.py /home/akimitsu/database/Refseq_gene_hg19_June_02_2014.bed Refseq_gene_hg19_June_02_2014_gene_symbol_trxid.txt Refseq_gene_hg19_June_02_2014_genebody.bed Refseq_gene_hg19_June_02_2014_promoter.bed

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
    strand = data[5]
    ref_dict[trx_id] = [chrom, st, ed, strand]

input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')
output_file_promoter = open(sys.argv[4], 'w')

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[1] == 'NA':
        continue
    trx_list = data[1].split(",")

    st_list = []
    ed_list = []
    tss_list = []
    tss_site_st = ''
    tss_site_ed = ''
    tss_site_2 = ''
    trx_list_new = []
    if re.search('NM', data[1]):
        for x in trx_list:
            if re.match('^NM',x):
                trx_list_new.append(x)
    else:
        trx_list_new = trx_list
    for x in trx_list_new:
        ref_list = ref_dict[x]
        chrom = ref_list[0]
        st = int(ref_list[1])
        ed = int(ref_list[2])
        strand = ref_list[3]
        st_list.append(st)
        ed_list.append(ed)
        if strand == '+':
            tss_list.append(int(st))
        elif strand == '-':
            tss_list.append(int(ed))
        else:
            tss_list.append(int(st))
    st_list.sort()
    ed_list.sort()
    if strand == '+':
        tss_list.sort()
        tss_site_ed = tss_list[-1]
        tss_site_st = int(tss_list[0]) - 3000
        print(chrom, str(tss_list[0]), str(ed_list[-1]), data[0], ','.join(trx_list_new), "GeneBody",data[2], sep="\t", end="\n", file=output_file)
        print(chrom, str(tss_site_st), str(tss_site_ed), data[0], ','.join(trx_list_new), "Promoter",data[2], sep="\t", end="\n", file=output_file_promoter)
        if int(tss_site_st) > int(tss_site_ed):
            print(data[2] + ': ' + ','.join(tss_list))
    elif strand == '-':
        tss_list.sort()
        tss_site_st = tss_list[0]
        tss_site_ed = int(tss_list[-1]) + 3000
        print(chrom, str(st_list[0]), str(tss_list[-1]), data[0], ','.join(trx_list_new), "GeneBody",data[2], sep="\t", end="\n", file=output_file)
        print(chrom, str(tss_site_st), str(tss_site_ed), data[0], ','.join(trx_list_new), "Promoter",data[2], sep="\t", end="\n", file=output_file_promoter)
        if int(tss_site_st) > int(tss_site_ed):
            print(data[2] + ': ' + ','.join(tss_list))
    else:
        tss_list.sort()
        print(chrom, str(st_list[0]), str(ed_list[-1]), data[0], ','.join(trx_list_new), "GeneBody",data[2], sep="\t", end="\n", file=output_file)
