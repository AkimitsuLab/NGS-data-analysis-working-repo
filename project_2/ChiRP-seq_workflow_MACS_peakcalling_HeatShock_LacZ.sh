#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=16G
#$ -l mem_req=16G

set -e

#controlBam="./4_HeatShock_input/4_HeatShock_input_160531_Hiseq3A_l2_001_Dr_Akimitsu_Dr_Mizutani_ATCACG_L002_R1_all_3_blacklist_removed.bam"
#treatBam="./5_HeatShock_LacZ/5_HeatShock_LacZ_160531_Hiseq3A_l2_010_Dr_Akimitsu_Dr_Mizutani_TAGCTT_L002_R1_all_3_blacklist_removed.bam"
#macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=HeatShock_LacZ -g hs --bw=200 -m 10,50
#macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=HeatShock_LacZ_m5_50 -g hs --bw=200 -m 5,50

controlBam="./4_HeatShock_input/4_HeatShock_input_160531_Hiseq3A_l2_001_Dr_Akimitsu_Dr_Mizutani_ATCACG_L002_R1_all_3_blacklist_removed_mapped.bam"
treatBam="./5_HeatShock_LacZ/5_HeatShock_LacZ_160531_Hiseq3A_l2_010_Dr_Akimitsu_Dr_Mizutani_TAGCTT_L002_R1_all_3_blacklist_removed_mapped.bam"

macs14 -t ${treatBam} -c ${controlBam} -f BAM --name=HeatShock_LacZ_mapped -g hs --bw=200 -m 10,50
