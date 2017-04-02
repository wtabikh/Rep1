acq<-load("/Users/bootphonproject/Documents/segmentation/acqdiv_corpus_2016-09-22_ctn_jap.rda")
utterance_data<-data.frame(utterances)
clean_corpus<-utterance_data[ , c('language', 'utterance', 'speaker_label')]
language_data<-clean_corpus[clean_corpus$language=="Chintang" & clean_corpus$speaker_label!="CHI", ]
language_data_noCHI<-language_data[ ,2]
write.table(language_data_noCHI, file="/Users/bootphonproject/Documents/segmentation/results/chintang/clean_corpus.txt", sep=";")