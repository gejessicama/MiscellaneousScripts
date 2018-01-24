#using awk to filter instead of writing scripts in python like a fuckin scrub
$ awk '$n=="something" {print $m}' source_file > target_file
$ awk '$1=="sp|P85188|CYO25_VIOOD" {print $2}' uniprot-ncbi-filtered-10Jan18-wPos.blastp > tempo1.txt
$ awk '$1=="sp|P85188|CYO25_VIOOD" && $NF >= 90{print $2}' uniprot-ncbi-filtered-10Jan18-wPos.blastp > tempo2.txt

#using seqtk subseq to create fasta files from those text files
$ seqtk subseq source_fasta_file file_with_names > output_file
$ seqtk subseq ../sequences/uniprot-ncbi-filtered-10Jan18.fa tempo1 > tempo1.fa  

#using muscle to do a msa
$ /gsc/btl/linuxbrew/bin/muscle -in id_list.fa -out output_file.clw -clw
$ /gsc/btl/linuxbrew/bin/muscle -in tempo1.fa -out tempo1.clw -clw

#using clustalo to do a msa
$ /gsc/btl/linuxbrew/bin/clustalo -i id_list.fa -o output_file.clustalo.clw --wrap==n
$ /gsc/btl/linuxbrew/bin/clustalo -i tempo1.fa -o tempo1.clustalo.clw --wrap=1000 

#using grep to get stuff instead of parsing
$ grep -someoutputstuff "search_string" file_to_search_in
$ grep -A1 "sp|P84522|VHL1_VIOHE" ../sequences/uniprot-ncbi-filtered-10Jan18.fa

#creating a database for proteins
$ makeblastdb -in source_fasta_file -dbtype 'prot'

#doing a comparison with blastp
$ blastp -num_threads 4 -outfmt '6 std qcovs ppos' -evalue 1e-5 -query query_file.fa -subject source_file.fa > output_file.blastp
$ blastp -num_threads 4 -evalue 1e-5 -query /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa -subject /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa > uniprot-ncbi-filtered-10Jan18-self.blastp

blastp -evalue 1e-5 -outfmt '6 qaccver saccver evalue length nident mismatch positive ppos' -query /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa -subject /projects/spruceup/scratch/psitchensis/Q903/annotation/amp/sequences/uniprot-ncbi-filtered-10Jan18.fa > selfblastJan23.blastp


