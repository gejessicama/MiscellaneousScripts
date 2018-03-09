from __future__ import division
import sys

def print_report(name, param, ta, na, cs, inc):
    results = open(name +'.txt', 'a+')
    precision = inc/(inc + na)
    recall = inc/cs
    f1 = (2*precision*recall)/(precision + recall)
    
    results.write(
        name + parameters + ": " + str(f1) + '\n' + 
        "total amps: " + str(ta) + '\n' +
        "non-amps:" + str(na) + '\n' +
        str(inc) + "/" + str(cs) + " of constructing set included \n\n"
    )
    
def print_csv(name, param, ta, na, cs, inc):
    file = open('results.csv', 'a+')
    file.write(",".join([name, param, ta, na, cs, inc]))
    

if __name__ == "__main__":
    name = sys.argv[1]
    parameters = sys.argv[2]
    totamp = int(sys.argv[3])
    nonamp = int(sys.argv[4])
    constr = int(sys.argv[5])
    incl = int(sys.argv[6])
    
    print_report(name, parameters, totamp, nonamp, constr, incl)
    
    

    
