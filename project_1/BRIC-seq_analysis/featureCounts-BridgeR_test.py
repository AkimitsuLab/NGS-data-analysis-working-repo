#!/usr/bin/env python3
"""
featureCounts-BridgeR workflow.

Usage:
  featureCounts-BridgeR_test.py <file_table> [options]
"""

import sys
import subprocess

gtf_path = ''
anno_path = ''

# Check filepath
for line in open(sys.argv[1], 'r'):
    line = line.rstrip()
    data = line.split(',')
    if data[0] == 'gtf':
        gtf_path = data[1]
    elif data[0] == 'anno':
        anno_path = data[1]

if gtf_path == '':
    print("Error: gtf file does not exist...")
    sys.exit(1)
elif anno_path == '':
    print("Error: annotation file does not exist...")
    sys.exit(1)

gene_list = []

# Count reads
for line in open(sys.argv[1], 'r'):
    line = line.rstrip()
    data = line.split(',')
    file_name = data[0]
    file_path = data[1]
    if file_name == 'gtf' or file_name == 'anno':
        continue
    cmd_1 = "featureCounts -T 8 -t exon -g gene_id -a " + gtf_path + " -o featureCounts_result_" + file_name + ".txt " + file_path
    #subprocess.call(cmd_1, shell = True)
    cmd_2 = 'sed -e "1,2d" featureCounts_result_' + file_name + '.txt > featureCounts_result_' + file_name + '_pre.txt'
    #subprocess.call(cmd_2, shell = True)
    cmd_3 = 'python3 featureCounts_filecheck.py featureCounts_result_' + file_name + '_pre.txt featureCounts_result_' + file_name + '_for_R.txt'
    #subprocess.call(cmd_3, shell = True)
    cmd_4 = 'rm featureCounts_result_' + file_name + '_pre.txt'
    #subprocess.call(cmd_4, shell = True)
    result_file = 'featureCounts_result_' + file_name + '_for_R.txt'
    gene_list.append(result_file)

# Merge each sample file
cmd_5 = "Rscript calc_rpkm.R " + " ".join(gene_list)
#subprocess.call(cmd_5, shell = True)

# Gene name,type infor
ref_dict = {}
for line in open(anno_path, 'r'):
    line = line.rstrip()
    data = line.split("\t")
    if line.startswith('#'):
        continue
    gene_name = data[0]
    ref_dict[gene_name] = line

# Annotate gene infor
output_file = open("BridgeR_input_file.txt", 'w')
for line in open("BridgeR_input_file.tmp", 'r'):
    line = line.rstrip()
    data = line.split("\t")
    gene_name = data[0]
    gene_infor = ref_dict[gene_name]
    rpkm_list = []
    for x in range(len(gene_list)):
        rpkm = data[2+x*2]
        rpkm_list.append(rpkm)
    print(gene_infor, "\t".join(rpkm_list), sep="\t", end="\n", file=output_file)
