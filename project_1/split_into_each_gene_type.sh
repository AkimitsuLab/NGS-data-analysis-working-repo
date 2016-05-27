#!/bin/bash
for file in $@
do
    filename=`basename ${file} .txt`
    head -n 1 ${filename}.txt > header.tmp
    sed -e '1d' ${filename}.txt | sort -k2,2 -k1,1 - | cat header.tmp - > ${filename}_sorted.txt
    python3 split_into_each_gene_type.py ${filename}_sorted.txt
done
