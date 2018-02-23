#!/bin/bash

for f in /projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/ppos85qcovs40/muscle/*
do
fname=`basename $f`
wc -l $f && echo $fname
done
exit


