import sys

def print_report(name, param, na, cs, inc):
    results = open(name +'.txt', 'a+')
    precision = inc/(inc + na)
    recall = inc/cs
    f1 = (2*precision*recall)/(precision + recall)
    
    results.write(name + parameters + ": " + str(f1))

if __name__ == "__main__":
    name = sys.argv[1]
    parameters = sys.argv[2]
    totamp = int(sys.argv[3])
    nonamp = int(sys.argv[4])
    constr = int(sys.argv[5])
    incl = int(sys.argv[6])
    
    print_report(name, parameters, nonamp, constr, incl)
    
    

    
