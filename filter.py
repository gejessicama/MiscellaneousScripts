from Bio import SeqIO, SearchIO

fname = 'selfcompare19Jan18.blastp' 
custom_fields = 'qseqid sseqid evalue bitscore' 

#for record in SeqIO.parse(handle, "fasta"):

qresult = next(SearchIO.parse(fname, 'blast-tab', fields=custom_fields)) 
print qresult

'''
command for running blastp:

-num_threads 4 -evalue 1e-10 -outfmt '6 qseqid sseqid evalue bitscore' -query /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa -subject /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa > selfcompare19Jan18.blastp

note: may want to look more into evalue
      num_threads isn't even used
      10 is for csv output
'''
