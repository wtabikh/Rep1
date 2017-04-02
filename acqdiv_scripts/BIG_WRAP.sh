# take out input from rda file

# Adapt the following variables, being careful to provide absolute paths
ROOT="/Users/bootphonproject/Documents/segmentation/scripts"	#path to the CDSwordSeg folder - E.g. PATH_TO_SCRIPTS="/home/xcao/cao/projects/ANR_Alex/CDSwordSeg/"
INPUT_FILE="/Users/bootphonproject/Documents/segmentation/acqdiv_corpus_2016-09-22_ctn_jap.rda" #E.g INPUT_FILES="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/childes_info.txt"
PROCESSED_FILE="/Users/bootphonproject/Documents/segmentation/results/chintang/clean_corpus.txt"	#this is where we will put the processed versions of the transcripts E.g. RES_FOLDER="/home/xcao/cao/projects/ANR_Alex/res_Childes_Eng-NA_cds/" - NOTICE THE / AT THE END OF THE NAME
PROCESSED_FILE2="/Users/bootphonproject/Documents/segmentation/results/chintang/corpus-tags.txt"
LANGUAGE="chintang"
RESULT_FOLDER="/Users/bootphonproject/Documents/segmentation/results/chintang/"


#module add festival
#module add python-anaconda

mkdir -p $RES_FOLDER	
#R CMD BATCH $ROOT/1.sel_clean.R   
#echo "done extracting info from corpora"

#python $ROOT/2.format.py $PROCESSED_FILE
#echo "done formatting corpora"

bash 3.phonologize.sh
echo "done phonologisation and syllabification of corpora"

python $ROOT/4a.format_TP.py $PROCESSED_FILE2
python $ROOT/4b.TPsegmentation.py $RESULT_FOLDER/syllableboundaries_marked.txt $RESULT_FOLDER/outputREL.txt
echo "done TP segmentation"

