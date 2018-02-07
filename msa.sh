#!/bin/bash

read -p 'Source FASTA file: ' source_fasta
read -p 'Enter name for all the files: ' file_name
read -p 'Enter conditions for awk: ' awk_conditions

BLAST=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/selfblast.blastp
DATAB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa
FILES=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/byQuery/*
awk '{print>$1}' $BLAST

for f in $FILES
do 
awk '$NF>50 && $(NF-1)>75 {print $2}' "$f" >"$f"-filtered.txt
seqtk subseq $DATAB "$f"-filtered.txt > "$f"-filtered.fa
muscle -in "$f"-filtered.fa -out "$f"-msa.fa
done 

exit
