#!/bin/bash

# Checks for identical files
# Author: Jessica Ma
# Date: Feb 20, 2018

FOLDER=/projects/spruceup_scratch/psitchensis/Q903/annotation/amp/alignment/MSAs/muscle/*

for f in $FOLDER
do
for g in $FOLDER
do
fname=`basename $f`
gname=`basename $g`
cmp -s "$f" "$g" && echo "Files $fname and $gname are identical"; 
done
done
exit 


