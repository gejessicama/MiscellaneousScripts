# trying to match stuff according to regex
# turns out it's not useful lol
# too ambitious

import re

def_reg = '[^C]{3}C[^C]{10}C[^C]{5}C[^C]{3}C[^C]{9}C[^C]{8}C[^C]{1}C[^C]{3}C'
thio_reg = '[^C]{2}CC[^C]{7}C[^C]{3}C[^C]{8}C[^C]{3}C[^C]{1}C[^C]{8}C[^C]{6}'
ltp_reg = '[^C]{3}C[^C]{9}C[^C]{12}CC[^C]{18}C[^C]{1}C[^C]{23}C[^C]{15}C[^C]{4}'
heve_reg = '[^C]{3}C[^C]{4}C[^C]{4}C[^C]{5}C[^C]{6}C[^C]{2}'
knot_reg = '[^C]{1}C[^C]{6}C[^C]{8}CC[^C]{3}C[^C]{10}C[^C]{3}'
macad_reg = '[^C]{10}C[^C]{9}C[^C]{1}C[^C]{25}C[^C]{14}C[^C]{11}C'
impat_reg = '[^C]{5}CC[^C]{8}C[^C]{3}C'
cyclo_reg = '[^C]{1}C[^C]{3}C[^C]{4}C[^C]{4}C[^C]{1}C[^C]{4}C[^C]{6}'

defensin = open("defensin.txt", "w+")
thionin = open("thionin.txt", "w+")
LTP = open("LTP.txt", "w+")
hevein = open("hevein.txt", "w+")
knottin = open("knottin", "w+")
macademia = open("macademia.txt", "w+")
impatiens = open("impatiens.txt", "w+")
cyclotide = open("cyclotide.txt", "w+")

types = {
def_reg : defensin,
thio_reg : thionin,
ltp_reg : LTP,
heve_reg : hevein,
knot_reg : knottin,
macad_reg : macademia,
impat_reg : impatiens,
cyclo_reg : cyclotide
}

src = open("alldata.txt", "r")

while True:
    info = src.readline()
    seq = src.readline()
    
    for thing in types.keys():
        if re.search(thing, seq) is not None:
            types.get(thing).write(info)
            types.get(thing).write(seq + '\n')
    
    if not seq: break #EOF 
    
    
    
    
    
    
