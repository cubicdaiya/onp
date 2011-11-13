/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
 */

import std.algorithm;

class Diff(elem, sequence)
{
 private:
    sequence A;
    sequence B;
    ulong    M;
    ulong    N;
    ulong    e;
 public :
    this (sequence a, sequence b)
    {
        A = a;
        B = b;
        M = a.length;
        N = b.length;
        if (M > N) {
            swap(A, B);
            swap(M, N);
        }
        e = 0;
    }
    
    ulong getEditDistance ()
    {
        return e;
    }
    
    void compose ()
    {
        int p      = -1;
        int size   = cast(int)(M + N + 3);
        int delta  = cast(int)(N - M);
        int offset = cast(int)(M + 1);
        int fp[]   = new int[size];
        fill(fp, -1);
        do {
            ++p;
            for (int k=-p;k<=delta-1;++k) {
                fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
            }
            for (int k=delta+p;k>=delta+1;--k) {
                fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset]);
            }
            fp[delta+offset] = snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset]);
        } while(fp[delta+offset] < N);
        e = delta + 2 * p;
    }

    int snake (int k, int p, int pp) {
        int y = max(p, pp);
        int x = y - k;
        while (x < M && y < N && A[x] == B[y]) {
            ++x;
            ++y;
        }
        return y;
    }
}
