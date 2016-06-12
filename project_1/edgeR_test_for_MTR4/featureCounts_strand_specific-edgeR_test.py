#!/usr/bin/env python3
"""
featureCounts-BridgeR workflow.
Usage:
  featureCounts-BridgeR_test.py <file_table>
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
file_name_list = []
file_factor_list = []

# Count reads
for line in open(sys.argv[1], 'r'):
    line = line.rstrip()
    data = line.split(',')
    file_name = data[0]
    if file_name == 'gtf' or file_name == 'anno' or file_name == '':
        continue
    file_factor = data[1]
    file_path = data[2]
    cmd_1 = "featureCounts -T 8 -t exon -g gene_id -s 2 -a " + gtf_path + " -o featureCounts_result_" + file_name + ".txt " + file_path
    subprocess.call(cmd_1, shell = True)
    cmd_2 = 'sed -e "1,2d" featureCounts_result_' + file_name + '.txt > featureCounts_result_' + file_name + '_pre.txt'
    subprocess.call(cmd_2, shell = True)
    cmd_3 = 'python3 featureCounts_filecheck.py featureCounts_result_' + file_name + '_pre.txt featureCounts_result_' + file_name + '_for_R.txt'
    subprocess.call(cmd_3, shell = True)
    cmd_4 = 'rm featureCounts_result_' + file_name + '_pre.txt'
    subprocess.call(cmd_4, shell = True)
    result_file = 'featureCounts_result_' + file_name + '_for_R.txt'
    gene_list.append(result_file)
    file_name_list.append(file_name)
    file_factor_list.append(file_factor)

# Merge each sample file
cmd_5 = "paste " + " ".join(gene_list) + ' > tmp_for_edgeR.txt'
subprocess.call(cmd_5, shell = True)
cmd_6 = "Rscript edgeR_test.R " + "tmp_for_edgeR.txt" + ' ' + ",".join(file_name_list) + ' ' + ",".join(file_factor_list)
subprocess.call(cmd_6, shell = True)
cmd_7 = "rm tmp_for_edgeR.txt"
subprocess.call(cmd_7, shell = True)

#BridgeR calc
cmd_8 = "python3 annotate_gene_symbol_type.py " + anno_path + ' edgeR_test_' + "_".join(file_name_list) + '.txt' + ' edgeR_test_' + "_".join(file_name_list) + '_result.txt'
subprocess.call(cmd_8, shell = True)
