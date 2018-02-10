#!/bin/bash

BLAST=/home/jma/Documents/AMP/MSAs/selfblast.blastp
DATAB=/home/jma/Documents/AMP/MSAs/db.fa
FILES=/home/jma/Documents/AMP/MSAs/byQuery/*
MSA=/home/jma/Documents/AMP/MSAs/

cd /home/jma/Documents/AMP/MSAs/byQuery
awk '{print>$1}' $BLAST
echo $FILES

for f in $FILES
do 
fname=`basename $f`
awk '$NF>50 && $(NF-1)>70 {print $2}' $f > $MSA/$fname-filtered
seqtk subseq $DATAB $MSA/$fname-filtered > $MSA/$fname-filtered.fa
muscle -in $MSA/$fname-filtered.fa -out $MSA/$fname-msa.fa
done 

exit
