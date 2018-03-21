#!/bin/bash
#1) find percentage of stuff found
#2) script for running all the hmmsearches

ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction

for f in $(find $ROOT -name '*-search')
    do 
    grep '^[^#;]' $f | awk '{print $1}' | sed -e 's/;AMP//g' | sed '/;non_AMP/d' >> allAMPs
    done
    
echo $(sort allAMPs | uniq | wc -l)
