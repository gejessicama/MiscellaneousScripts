#!/bin/bash

TESTDB=/projects/seqdev/WS77111/annotation/maker1.0/ws77111.noIUPAC.allCaps.renamed.all.maker.proteins.fasta
ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/alignment/hmmsearch

while read line
    do
    file=$(echo $line | sed "s/'//g")
    name=$(echo `basename $file` | sed 's/-hmm.hmm//g')
    hmmsearch -E 1e-5 --noali --notextw --tblout $ROOT/$name $file $TESTDB &
    sleep 1
    done < /projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/hmmsearch/part1.txt


