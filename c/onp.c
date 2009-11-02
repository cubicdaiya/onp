
/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
 */

#include "onp.h"

static uint snake (onp_diff_t *diff, int k, int p, int pp, int offset);
static uint snake (onp_diff_t *diff, int k, int p, int pp, int offset) {
  int y = onp_max(p, pp);
  int x = y - k;
  while (x < diff->m && y < diff->n && diff->a[x] == diff->b[y]) {
    ++x;
    ++y;
  }
  return y;
}

onp_diff_t *onp_alloc_diff (onp_sequence_t *a, onp_sequence_t *b) {
  onp_diff_t *diff = (onp_diff_t *)malloc(sizeof(onp_diff_t));
  diff->a = a;
  diff->b = b;
  diff->m = onp_seq_len(a);
  diff->n = onp_seq_len(b);
  if (diff->m > diff->n) {
    onp_swap(onp_sequence_t*, seq_tmp, a, b);
    onp_swap(int, int_tmp, diff->m, diff->n);
  }
  diff->editdis = 0;
  return diff;
}

void onp_free_diff (onp_diff_t *diff) {
  free(diff->path);
  free(diff);
  diff = NULL;
}

void onp_compose (onp_diff_t *diff) {
  int  p      = -1;
  int  delta  = diff->n - diff->m;
  uint offset = diff->m + 1;
  uint size   = diff->m + diff->n + 3;
  int *fp     = (int *)malloc(sizeof(int) * size);
  diff->path  = (int *)malloc(sizeof(int) * size);
  for (int i=0;i<size;++i) {
    fp[i] = diff->path[i] = -1;
  }
  do {
    ++p;
    for (int k=-p;k<=delta-1;++k) {
      fp[k+offset] = snake(diff, k, fp[k-1+offset]+1, fp[k+1+offset], offset);
    }
    for (int k=delta+p;k>=delta+1;--k) {
      fp[k+offset] = snake(diff, k, fp[k-1+offset]+1, fp[k+1+offset], offset);
    }
    fp[delta+offset] = snake(diff, delta, fp[delta-1+offset]+1,
                             fp[delta+1+offset], offset);
  } while (fp[delta+offset] != diff->n);
  diff->editdis = delta + 2 * p;
  free(fp);
}

