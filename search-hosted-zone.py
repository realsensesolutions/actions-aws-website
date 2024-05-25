import sys
input_domain = sys.argv[1]
for line in sys.stdin:
    domain = line.strip()[:-1]  
    if input_domain.find(domain) >= 0:
        print(domain)