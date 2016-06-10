#!/usr/bin/env python3

import sys
import re

input_file = open(sys.argv[1], 'r')
output_file = ''

name = ''
flg = 0

for line in input_file:
	line = line.rstrip().strip()
	data = line.split()
#	if re.search("^>",line):
		#print(line,end="\n", file=output_file)
#		name = line
#		flg = 1
#		continue
	line_length = len(line)
	test = line
	result = re.match('[ATGC]+', test)
	if result:
		test_length = result.span()[1]
		filename = ''
		if line_length == test_length:
			filename = line
			output_file = open(sys.argv[1].replace('.wee','') + '_' + filename + '.txt', 'w')
		continue
	if re.match('^==', line):
		output_file.close()
		continue
	if len(data) < 2:
		continue
	if re.match('^\+',data[1]):
#		if flg == 1:
#			flg = 0
			#print(name, end="\n",file=output_file)
		seq = data[2]
		seq = seq.replace('[','')
		seq = seq.replace(']','')
		trans_table = str.maketrans("ATGCatgc","AUGCAUGC")
		seq = seq.translate(trans_table)
		# if re.search('TATATATA',seq):
		# 	continue

		print(seq,end="\n",file=output_file)
		continue
