#!/bin/bash

MAKER=/projects/seqdev/WS77111/annotation/maker1.0/ws77111.noIUPAC.allCaps.renamed.all.maker.proteins.fasta
TESTDB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/sequences/AMP_test_set-8Mar18.fa
FULLDB=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/alignment/hmmsearch/maker-and-test.fa
ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/alignment/hmmsearch

FILENAME=$1
PROT=${FILENAME%???????}
PARAM=${FILENAME: (-6)}
EVAL=$2

grep '^[^#;]' $FILENAME | awk -v EVAL="$EVAL" '$5<EVAL {print $1}' | cat - /projects/spruceup_scratch/psitchensis/Q903/annotation/amp/hmm-construction/temp_files/tmp_files-$PARAM/$FILENAME | seqtk subseq $FULLDB "-" | muscle -out ../testing/$PROT-$EVAL.fa
