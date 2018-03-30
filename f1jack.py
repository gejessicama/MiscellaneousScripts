# Author: Jessica Ma
# Date: March 28, 2018

# Takes in values from shell script and creates text summary document and csv
# F1 is calculated from formula on Wikipedia
# totamp is total AMPs (constructing and otherwise) found by the HMM
# nonamp is number of non-AMPs found by HMM
# constr is the number of AMPs in the set used to make the HMM
# incl is the number of constructing AMPs that were found by hmmsearch

# in this case, true positives are the incl AMPs
# false positives are non-AMPs 
# false negatives are constr AMPs that are NOT incl

from __future__ import division
import sys

def print_csv(name, param, ta, na, cs, inc):
    file = open('results.csv', 'a+')
    precision = inc/(inc + na)
    recall = inc/cs
    f1 = (2*precision*recall)/(precision + recall)
    ppos = param[2:4]
    qcovs = param[5:7]
    file.write(",".join([name, ppos, qcovs, str(ta), str(na), str(cs), str(inc), str(f1)]) + '\n')
    

if __name__ == "__main__":
    name = sys.argv[1]
    parameters = sys.argv[2]
    totamp = int(sys.argv[3])
    nonamp = int(sys.argv[4])
    constr = int(sys.argv[5])
    incl = int(sys.argv[6])
    
    print_csv(name, parameters, totamp, nonamp, constr, incl)
