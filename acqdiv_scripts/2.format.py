#!/usr/bin/env python
import rpy2.robjects as ro
import pandas as pd
import re
import sys


language_data_noCHI_list=open(sys.argv[1], "r")
format_corpus=open("/Users/bootphonproject/Documents/segmentation/results/chintang/corpus-ortholines.txt", 'w')


for line in language_data_noCHI_list:
	new_str=''.join(line.split(';')[1:])
	new_str2=new_str.replace("\"", "")
	format_corpus.write(new_str2)
	

format_corpus.close()
language_data_noCHI_list.close()	
	
 
