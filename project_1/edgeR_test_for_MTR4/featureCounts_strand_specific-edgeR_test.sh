#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

python3 featureCounts_strand_specific-edgeR_test.py sample_table_siMTR4_7.txt
python3 featureCounts_strand_specific-edgeR_test.py sample_table_siMTR4_8.txt