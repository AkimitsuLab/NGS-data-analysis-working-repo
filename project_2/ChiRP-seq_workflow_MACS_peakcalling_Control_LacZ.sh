#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

#controlBam="./1_Control_input/1_Control_input_160531_Hiseq3A_l2_002_Dr_Akimitsu_Dr_Mizutani_CGATGT_L002_R1_all_3_blacklist_removed.bam"
#treatBam="./2_Control_LacZ/2_Control_LacZ_160531_Hiseq3A_l2_007_Dr_Akimitsu_Dr_Mizutani_CAGATC_L002_R1_all_3_blacklist_removed.bam"
#macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=Control_LacZ -g hs --bw=200 -m 10,50
#macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=Control_LacZ_m5_50 -g hs --bw=200 -m 5,50

controlBam="./1_Control_input/1_Control_input_160531_Hiseq3A_l2_002_Dr_Akimitsu_Dr_Mizutani_CGATGT_L002_R1_all_3_blacklist_removed_mapped.bam"
treatBam="./2_Control_LacZ/2_Control_LacZ_160531_Hiseq3A_l2_007_Dr_Akimitsu_Dr_Mizutani_CAGATC_L002_R1_all_3_blacklist_removed_mapped.bam"

macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=Control_LacZ_mapped -g hs --bw=200 -m 10,50
