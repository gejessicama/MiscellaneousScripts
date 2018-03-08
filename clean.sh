#!/bin/bash

# Author: Jessica Ma
# Date: March 6, 2018

ppos=$1
qcovs=$2

BLAST=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/selfblast.blastp
DB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa
ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction
BYQ=$ROOT/blasttest

TEMP=$ROOT/tmp_files-"p""$ppos"q"$qcovs"
mkdir -p $TEMP 

for f in $BYQ/*
do 
    fname=`basename $f`
    awk -v q="$qcovs" -v p="$ppos" '$NF>q && $(NF-1)>p {print $2}' $f | sort | uniq > $TEMP/$fname-"p""$ppos"q"$qcovs"
done 

#finding duplicates
declare -A filecksums
for f in $TEMP/*
do
    [[ -f "$f" ]] && [[ ! -h "$f" ]] || continue
    cksum=$(cksum <"$f" | tr ' ' _)
    if [[ -n "${filecksums[$cksum]}" ]] && [[ "${filecksums[$cksum]}" != "$f" ]]
    then
        rm -f "$f"
    else
        filecksums[$cksum]="$f"
    fi
done

#finding singletons
for f in $TEMP/*
do 
    a=`cat "$f" | wc -l`   
    if [ "$a" -eq 1 ]
    then
       rm -f "$f"
    fi
done

# make FASTA files from unique groupings and run muscle on them
for f in $TEMP/*
do
    fname=`basename $f`
    seqtk subseq $DB $TEMP/$fname | muscle -out $ROOT/${fname%???????}/$fname-msa.fa
done
exit
