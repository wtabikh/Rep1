#!/bin/sh
# Wrapper to take a single cleaned up transcript and phonologize it
# Alex Cristia alecristia@gmail.com 2015-10-26
# Modified by Laia Fibla laia.fibla.reixachs@gmail.com 2016-09-28 adapted to arg spanish
# Modified by Georgia Loukatou georgialoukatou@gmail.com 2017-04-02 adapted to chintang, japanese 

#########VARIABLES
#Variables to modify
LANGUAGE="chintang" #language options:  cspanish (castillan spanish), catalan  -- NOTICE, IN SMALL CAPS


PATH_TO_SCRIPTS="/Users/bootphonproject/Documents/segmentation/scripts/"
#path to the phonologization folder - E.g. PATH_TO_SCRIPTS="/home/xcao/cao/projects/ANR_Alex/CDSwordSeg/phonologization/"

RES_FOLDER="/Users/bootphonproject/Documents/segmentation/results/chintang"
#this is where we will put the processed versions of the transcripts E.g. RES_FOLDER="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/"
# NOTICE THE / AT THE END OF THE NAME

LC_ALL=C


#########VARIABLES
#Variables to modify
LANGUAGE="japanese" #language options:  cspanish (castillan spanish), catalan  -- NOTICE, IN SMALL CAPS


PATH_TO_SCRIPTS="/Users/bootphonproject/Documents/segmentation/scripts/"
#path to the phonologization folder - E.g. PATH_TO_SCRIPTS="/home/xcao/cao/projects/ANR_Alex/CDSwordSeg/phonologization/"

RES_FOLDER="/Users/bootphonproject/Documents/segmentation/results/chintang"
#this is where we will put the processed versions of the transcripts E.g. RES_FOLDER="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/"
# NOTICE THE / AT THE END OF THE NAME

LC_ALL=C

for ORTHO in ${RES_FOLDER}/*-ortholines.txt; do
	KEYNAME=$(basename "$ORTHO" -ortholines.txt)

	#########
	if [ "$LANGUAGE" = "japanese" ]
	   then
	  echo "recognized $LANGUAGE"
tr '[:upper:]' '[:lower:]'  < "$ORTHO"  | #Spanish files have different encoding
	  sed 's/ch/C/g' | #
	  sed 's/sh/Σ/g' |
	  sed 's/tt/T/g' |
		sed 's/kk/K/g' |
		sed 's/gg/G/g' |
	  sed 's/ss/S/g' |
	  sed 's/pp/P/g' > intoperl.tmp

	  echo "syllabify-corpus.pl"
	  perl $PATH_TO_SCRIPTS/syllabify-corpus.pl japanese intoperl.tmp outofperl.tmp $PATH_TO_SCRIPTS


	elif [ "$LANGUAGE" = "chintang" ]
		 then
		echo "recognized $LANGUAGE"
	tr '[:upper:]' '[:lower:]'  < "$ORTHO"  | #Spanish files have different encoding
		sed 's/kk/K/g' |
		sed 's/tt/T/g' | # substitute all ch by tS	
		sed 's/cc/C/g' |
		sed 's/bb/B/g' |
		sed 's/ss/S/g' |
		sed 's/nn/N/g' |
		sed 's/mm/M/g' |
		sed 's/jj/J/g' |
		sed 's/lh/L/g' | # substitute the spanish rr by 5
		sed 's/gh/G/g' | # substitue the initial r for R
		sed 's/pp/P/g' | # substitue the initial r for R
		sed 's/dh/D/g' |
		sed 's/ch/Σ/g' |
		sed 's/jh/Ζ/g' |
		sed 's/bh/V/g' | # removing h
		sed 's/kh/X/g' |
		sed 's/th/Θ/g' |
		sed 's/ph/Φ/g' > intoperl.tmp

		echo "syllabify-corpus.pl"
		perl $PATH_TO_SCRIPTS/syllabify-corpus.pl chintang intoperl.tmp outofperl.tmp $PATH_TO_SCRIPTS

	fi

		echo "removing blank lines"
		LANG=C LC_CTYPE=C LC_ALL=C
		sed '/^$/d' outofperl.tmp |
		sed '/^ $/d'  |
		sed '/^[ ]*$/d'  |
		sed 's/^ //'  |
		sed 's/^\///'  | #there aren't really any of these, this is just a cautionary measure
	sed 's/ / ;eword /g' |
		sed -e 's/\(.\)/\1 /g'  |
	sed 's/ ; e w o r d/ ;eword /g' |
	sed 's/\// ;esyll /g'|
	tr -s ' ' > tmp.tmp

		mv tmp.tmp ${RES_FOLDER}/${KEYNAME}-tags.txt

	echo "creating gold versions"

	sed 's/;esyll//g'  < ${RES_FOLDER}/${KEYNAME}-tags.txt |
		tr -d ' ' |
		sed 's/;eword/ /g' > ${RES_FOLDER}/${KEYNAME}-gold.txt

done


echo "end"

