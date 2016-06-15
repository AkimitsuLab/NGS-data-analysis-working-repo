#!/usr/bin/env python3

# Usage: python3 C_define_peak_annotation.py Control_MALAT1_peaks.xls Control_MALAT1_peaks_LacZ_MALAT1_minus_vs_GeneBody.bed Control_MALAT1_peaks_LacZ_MALAT1_minus_vs_promoter.bed Control_MALAT1_peaks_LacZ_MALAT1_minus.bed Control_MALAT1_peaks_LacZ_MALAT1_minus_anno.bed

import sys

macs_csv_file = open(sys.argv[1], 'r')

macs_dict = {}

for line in macs_csv_file:
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    if line == '':
        continue
    if data[0] == 'chr':
        continue
    chrom = data[0]
    st = str(int(data[1]) - 1)
    ed = data[2]
    chrom_site = '|'.join([chrom, st, ed])
    macs_dict[chrom_site] = line

genebody_file = open(sys.argv[2], 'r')

genebody_dict = {}
genebody_data = {}

for line in genebody_file:
    line = line.rstrip()
    data = line.split("\t")
    peak_id = data[3]
    if data[5] == '.':
        continue
    if not peak_id in genebody_dict:
        genebody_dict[peak_id] = [data[8]]
        genebody_data[peak_id] = [data[11]]
    else:
        genebody_dict[peak_id].append(data[8])
        genebody_data[peak_id].append(data[11])

promoter_file = open(sys.argv[3], 'r')

promoter_dict = {}
promoter_data = {}

for line in promoter_file:
    line = line.rstrip()
    data = line.split("\t")
    peak_id = data[3]
    if data[5] == '.':
        continue
    if not peak_id in promoter_dict:
        promoter_dict[peak_id] = [data[8]]
        promoter_data[peak_id] = [data[11]]
    else:
        promoter_dict[peak_id].append(data[8])
        promoter_data[peak_id].append(data[11])

input_file = open(sys.argv[4], 'r')
output_file = open(sys.argv[5], 'w')

print("chr", "start", "end", "peak_id", "length", "summit", "tags", "p-value(-10*log10(p))", "fold_enrichment", "FDR(%)", "gene_symbol", "Type", sep="\t", end="\n", file=output_file)

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    peak_id = data[3]
    chrom_site = '|'.join(data[:3])
    csv_data = macs_dict[chrom_site].split("\t")[3:]
    if peak_id in genebody_dict:
        gene_list = ','.join(genebody_dict[peak_id])
        gene_name = ','.join(genebody_data[peak_id])
        print("\t".join(data[:4]), "\t".join(csv_data), gene_list, gene_name, 'GeneBody', sep="\t", end="\n", file=output_file)
    elif peak_id in promoter_dict:
        gene_list = ','.join(promoter_dict[peak_id])
        gene_name = ','.join(promoter_data[peak_id])
        print("\t".join(data[:4]), "\t".join(csv_data), gene_list, gene_name, 'Promoter', sep="\t", end="\n", file=output_file)
    else:
        print("\t".join(data[:4]), "\t".join(csv_data), 'NA', 'NA', sep="\t", end="\n", file=output_file)
