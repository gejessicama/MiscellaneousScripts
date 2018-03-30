#/bin/bash

prot=$1 #get filename, e.g. sp|Q43413.1|DEF1_CAPAN-p40q40
parameters=${prot: (-7)} #get parameter suffix, e.g. p40q40
NAMES=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction/temp_files/tmp_files$parameters/$prot 

TESTDB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/sequences/AMP_test_set-8Mar18.fa
DB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa

declare -i num=$(wc -l < $NAMES) # number of peptides in original constructing set

for (( c=1; c<=$num; c++ ))
do
sed "${c}d" $NAMES | sed "${c}d" | sed "${c}d" | sed "${c}d" | sed "${c}d" | seqtk subseq $DB "-" | muscle -out thing.msa
hmmbuild thing.hmm thing.msa
hmmsearch -E 1e-10 --noali --notextw --tblout thingsearch thing.hmm $TESTDB

declare -i totamp="$(grep -o ';AMP' thingsearch | wc -l)"
declare -i nonamp="$(grep -o ';non_AMP' thingsearch | wc -l)"
declare -i constr=$num
declare -i incl="$(grep '^[^#;]' thingsearch | awk '{print $1}' | sed -e 's/;AMP//g' | sed -e 's/;non_AMP//g' | comm -12 <(sort "-") <( sort $NAMES) | wc -l)"

python f1.py $prot $parameters $totamp $nonamp $constr $incl 
done 

