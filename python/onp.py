"""
The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"                                   
by described by Sun Wu, Udi Manber and Gene Myers 
"""

import sys

def editdistance(a, b):
    m = len(a)
    n = len(b)
    if m >= n:
        a, b = b, a
        m, n = n, m
    offset = m + 1
    delta  = n - m
    size   = m + n + 3
    fp = [ -1 for idx in range(size) ]
    p = -1
    while (True):
        p = p + 1
        for k in range(-p, delta, 1):
            fp[k+offset] = snake(a, b, m, n, k, fp[k-1+offset]+1, fp[k+1+offset])
        for k in range(delta+p, delta, -1):
            fp[k+offset] = snake(a, b, m, n, k, fp[k-1+offset]+1, fp[k+1+offset])
        fp[delta+offset] = snake(a, b, m, n, delta, fp[delta-1+offset]+1, fp[delta+1+offset])
        if fp[delta+offset] >= n: break
    return delta + 2 * p
    
def snake(a, b, m, n, k, p, pp):
    y = max(p, pp)
    x = y - k
    while x < m and y < n and a[x] == b[y]:
        x = x + 1
        y = y + 1
    return y

if __name__ == "__main__":
    print editdistance(sys.argv[1], sys.argv[2])
