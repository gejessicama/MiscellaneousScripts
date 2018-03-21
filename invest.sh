#!/bin/bash

ROOT=/projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction

while read line 
do
for f in $(find $ROOT -name '*-search')
    do
    if grep -Fq $line $f
       then echo `basename $f` >> ./knowndefensins-HMMs
    fi
    done
sed 's/..............$//' knowndefensins-HMMs| sort | uniq > knowndefensins-HMMs 
done < knowndefensins.txt

while read line
do echo `basename $line` >> file; 
done < /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/hmm-construction/selected-hmms-0.9f1.txt 

while read line
do echo $line | sed "s/'//g" | sed 's/...............$//' | sort | uniq >> reults
done < file


prot=AAR84643.1; for f in $(find $ROOT -name '*-search'); do if grep -Fq $prot $f; then echo `basename $f` >> ./check-HMMs; fi; done; sed 's/..............$//' check-HMMs| sort | uniq > checksss-HMMs 
