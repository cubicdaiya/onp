/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
 */

package main

import (
	"fmt"
	"math"
	"os"
)

type diffInfo struct {
        a, b string
        m, n int
}

func max(x, y int) int {
	return int(math.Max(float64(x), float64(y)))
}

func (diff diffInfo) snake(k, p, pp int) int {

	y := max(p, pp)
	x := y - k

	for x < diff.m && y < diff.n && diff.a[x] == diff.b[y] {
		x += 1
		y += 1
	}

	return y
}

func editdis(a, b string) int {

	diff := &diffInfo{a, b, len(a), len(b)}

	if diff.m > diff.n {
		diff.a, diff.b = diff.b, diff.a
		diff.m, diff.n = diff.n, diff.m
	}

	offset := diff.m + 1
	delta := diff.n - diff.m
	size := diff.m + diff.n + 3
	fp := make([]int, size)
	for i := range fp {
		fp[i] = -1
	}

	for p := 0; ; p++ {

		for k := -p; k <= delta-1; k++ {
			fp[k+offset] = diff.snake(k, fp[k-1+offset]+1, fp[k+1+offset])
		}

		for k := delta + p; k >= delta+1; k-- {
			fp[k+offset] = diff.snake(k, fp[k-1+offset]+1, fp[k+1+offset])
		}
		fp[delta+offset] = diff.snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset])
		if fp[delta+offset] >= diff.n {
			return delta + 2*p
		}
	}

    return -1
}

func main() {
	if len(os.Args) < 3 {
		fmt.Printf("set two args\n")
	} else {
		fmt.Printf("editdistance:%d\n", editdis(os.Args[1], os.Args[2]))
	}
}
