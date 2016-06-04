#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

#Input files - required
InputFile="/home/akimitsu/database/List_1_mRNA_signifFC2.txt_infection_3UTR.fa"

./weederlauncher.out ${InputFile} KI small
