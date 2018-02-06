#!/bin/bash

read -p 'Source FASTA file: ' source_fasta
read -p 'Enter name for all the files: ' file_name
read -p 'Enter conditions for awk: ' awk_conditions

awk awk_conditions > file_name
seqtk subseq source_fasta > $(file_name).fa

muscle -in $(file_name).fa -out $(file_name)_muscle.fa
clustalo -i $(file_name).fa -o $(file_name)_clo.clw --wrap=1000
