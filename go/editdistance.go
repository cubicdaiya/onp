/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
 */

package main

import (
    "os";
    "fmt";
)

type diff_info struct {
  a string;
  b string;
  m int;
  n int;
}

func max (a int, b int) int {
  if a > b {
    return a
  }
  return b;
}

func snake(k int, p int, pp int, diff *diff_info) int {
  var y int = max(p, pp);
  var x int = y - k;
  for x < diff.m && y < diff.n && diff.a[x] == diff.b[y] {
    x++;
    y++;
  }
  return y;  
}

func editdis(a string, b string) int {
  var diff diff_info;
  diff.a = a;
  diff.b = b;
  diff.m = len(a);
  diff.n = len(b);
  if diff.m > diff.n {
    diff.a, diff.b = diff.b, diff.a;
    diff.m, diff.n = diff.n, diff.m;
  }
  var offset int = diff.m + 1;
  var delta  int = diff.n - diff.m;
  var size   int = diff.m + diff.n + 3;
  var fp     []int = make([]int, size);
  for i:=0;i<size;i++ {
    fp[i] = -1;
  }
  var p int = -1;
  for {
    p++;
    for k:=-p;k<=delta-1;k++ {
      fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset], &diff);
    }
    for k:=delta+p;k>=delta+1;k-- {
      fp[k+offset] = snake(k, fp[k-1+offset]+1, fp[k+1+offset], &diff);
    }
    fp[delta+offset] = snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset], &diff);
    if fp[delta+offset] >= diff.n {
      break
    }
  }
  return delta + 2 * p;
}

func main(){
  if len(os.Args) < 3 {
    fmt.Printf("set two args\n");
  } else {
    fmt.Printf("editdistance:%d\n", editdis(os.Args[1], os.Args[2]))
  }
}
