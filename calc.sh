#for each hmm: 
#    do an hmmsearch with full database
#    calculate f1 score:
#        have to see how many proteins total
#        have to find that constructing FASTA
#        report results to a single file 
        
TESTDB=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/AMP_test_set-3Mar18.fa
DB=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/db.fa
#ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction
ROOT=/home/jma/Documents/test
for f in $(find $ROOT -name '*.hmm')
    do
    fname=`basename $f -hmm.hmm`
    rootname=${fname%???????}
    parameters=${fname: -7}
    
    hmmsearch -E 1e-5 --noali --notextw --tblout $fname-search $f $TESTDB
    declare -i totamp="$(grep -o ';AMP' $fname-search | wc -l)"
    declare -i nonamp="$(grep -o ';non_AMP' $fname-search | wc -l)"
    declare -i constr="$(wc -l < $ROOT/tmp_files$parameters/$fname)"
    declare -i incl="$(grep '^[^#;]' $fname-search | awk '{print $1}' | sed -e 's/;AMP//g' | sed -e 's/;non_AMP//g' | comm -12 <(sort "-") <( sort $ROOT/tmp_files$parameters/$fname) | wc -l)"
    
    python f1.py $rootname $parameters $totamp $nonamp $constr $incl 
    done
