from Bio import SeqIO

wantedList = open("seqs.txt").readlines()

def is_wanted(fasta):
    if fasta in wantedList: return True
    else: return False

database = SeqIO.parse(open("database.fa","r"), 'fasta')
with open("align.fa", "w+") as out_file:
    for fasta in database:
        if is_wanted(fasta):
            write_fasta(out_file) 

