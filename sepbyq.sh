#!/bin/bash

# take in thresholds for ppos and qcovs
# creates MSAs for all 

# Author: Jessica Ma
# Date: March 6, 2018

ppos=$1
qcovs=$2

BLAST=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/selfblast.blastp
DB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa
ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction

BYQ=$ROOT/blast
TEMP=$ROOT/temp_files
MUSC=$CORE/muscle
mkdir -p $CORE $TEMP $MUSC

#cd blast
#awk '{print>$1}' /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/selfblast.blastp 
#cd ../
#for f in ./blast/*
#    do mkdir -p `basename $f`
#    mv $f ./`basename $f`
#done
#rm -r files

# make CSV to see variation wrt ppos/qcovs parameters
for f in $BYQ/*
do 
    fname=`basename $f`
    awk -v q="$qcovs" -v p="$ppos" '$NF>q && $(NF-1)>p {print $2}' $f | sort | uniq > $TEMP/$fname-ppos"$ppos"-qcovs"$qcovs"
    #num=`wc -l $TEMP/$fname | cut -f1 -d' '` 
    #echo $num", " $fname", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-results.csv
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
    #    echo `basename $f`", "`basename ${filecksums[$cksum]}`", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-duplicates.csv
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
    #   echo `basename $f`", $ppos, $qcovs" >> $CORE/ppos"$ppos"-qcovs"$qcovs"-singletons.csv
       rm -f "$f"
    fi
done

# make FASTA files from unique groupings and run muscle on them
for f in $TEMP/*
do
    fname=`basename $f`
    seqtk subseq $DB $TEMP/$fname-ppos"$ppos"-qcovs"$qcovs" | muscle -out $MUSC/$fname-ppos"$ppos"-qcovs"$qcovs"-msa.fa | cons 
done
exit
