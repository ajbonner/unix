sudo netstat -plntu --inet | sort -t: -k2,2n | sort --stable -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | sort -s -t" " -k1,1
