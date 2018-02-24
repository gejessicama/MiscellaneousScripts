#!/bin/bash

# take in thresholds for ppos and qcovs
# creates folder called pposX-qcovsY and subfolders byQuery, temp_files, muscle
# does selfblastp -> separate by query -> filter by parameters 
# creates csv file in root for visualization of variation of parameters
# goes into muscle and compares all the files, deleting duplicates along the way
# create a log of duplicates
# create a log of singletons and deletes them
# do muscle on remaining files i.e. non-duplicates and non-singletons

# Author: Jessica Ma
# Date: February 21st, 2018

ppos=$1
qcovs=$2
BLAST=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/selfblast.blastp
#BLAST=/home/jma/Documents/selfblast.blastp
DB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa

#ROOT=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs
ROOT=/home/jma/Documents
CORE=$ROOT/ppos"$ppos"-qcovs"$qcovs"
BYQ=$ROOT/byQuery
TEMP=$CORE/temp_files
MUSC=$CORE/muscle
mkdir -p $CORE $TEMP $MUSC

# separate blast file by query protein 
# cd $BYQ
# awk '{print>$1}' $BLAST

# make CSV to see variation wrt ppos/qcovs parameters
for f in $BYQ/*
do 
    fname=`basename $f`
    awk -v q="$qcovs" -v p="$ppos" '$NF>q && $(NF-1)>p {print $2}' $f | sort | uniq > $TEMP/$fname
    num=`wc -l $TEMP/$fname | cut -f1 -d' '` 
    echo $num", " $fname", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-results.csv
    
done 

# checking for duplicates, deleting duplicates, creating log file
# found this script on unix.stackexchange #367749 and made little adjustments
declare -A filecksums

for f in $TEMP/*
do
    # Files only (also no symlinks)
    [[ -f "$f" ]] && [[ ! -h "$f" ]] || continue

    # Generate the checksum
    cksum=$(cksum <"$f" | tr ' ' _)

    # Have we already got this one?
    if [[ -n "${filecksums[$cksum]}" ]] && [[ "${filecksums[$cksum]}" != "$f" ]]
    then
        echo `basename $f`", "`basename ${filecksums[$cksum]}`", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-duplicates.csv
        rm -f "$f"
    else
        filecksums[$cksum]="$f"
    fi

done

# identify and delete singletons
for f in $TEMP/*
do 
    a=`cat "$f" | wc -l`   
    if [ "$a" -eq 1 ]
    then
       echo `basename $f`", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-singletons.csv
       rm -f "$f"
    fi
done

# make FASTA files from unique groupings and run muscle on them
#for f in $TEMP/*
#do
#    fname=`basename $f`
#    seqtk subseq $DB $TEMP/$fname | muscle -out $MUSC/$fname-msa.fa
#done
exit
