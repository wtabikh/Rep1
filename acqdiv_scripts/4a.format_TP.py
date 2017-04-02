#!/usr/bin/env python

import sys

corpus_phono_tags=open(sys.argv[1],'r')
(syllableboundaries_marked)=open("/Users/bootphonproject/Documents/segmentation/results/chintang/syllableboundaries_marked.txt", 'w')


for line in corpus_phono_tags:
	new_str=line.replace(" ","")
	new_str1=new_str.replace(";eword;esyll","-")
	new_str2=new_str1.replace(";esyll","-")
	new_str3=new_str2.replace(";eword"," UB")
	new_str4=new_str3.replace("\n","-")
	new_str5=new_str4.replace("UB-","UB ")
	syllableboundaries_marked.write(new_str5)

syllableboundaries_marked.close()
corpus_phono_tags.close()
