
"""
The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"                                   
by described by Sun Wu, Udi Manber and Gene Myers 
"""

class onp(object):
    
    def __init__(self, a, b):
        self.a = a
        self.b = b
        self.m = len(a)
        self.n = len(b)
        path = []
        self.editdis = 0
        reverse = False
        if self.m >= self.n:
            self.a, self.b = self.b, self.a
            self.m, self.n = self.n, self.m
            self.reverse = True

    def getEditDistance(self):
        return self.editdis

    def snake(self, k, p, pp):
        y = max(p, pp)
        x = y - k
        while x < self.m and y < self.n and self.a[x] == self.b[y]:
            x = x + 1
            y = y + 1
        return y
        
    def compose(self):
        offset = self.m
        delta  = self.n - self.m
        size   = self.m + self.n + 3
        fp = []
        for i in range(size):
            fp.append(-1)
        p = -1
        while (True):
            p = p + 1
            for k in range(-p, delta, 1):
                fp[k+offset] = self.snake(k, fp[k-1+offset]+1, fp[k+1+offset])
                
            for k in range(delta+p, delta, -1):
                fp[k+offset] = self.snake(k, fp[k-1+offset]+1, fp[k+1+offset])

            fp[delta+offset] = self.snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset])
            if fp[delta+offset] >= self.n:
                break
        self.editdis = delta + 2 * p

