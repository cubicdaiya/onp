
#ifndef ONP_H
#define ONP_H

#include <stdlib.h>
#include <string.h>

typedef unsigned int uint;
typedef char onp_sequence_t;
#define onp_swap(type, val, a, b) type val=a;a=b;b=val;
#define onp_max(a, b) ((a) > (b) ? (a) : (b))
#define onp_seq_len(seq) strlen(seq)

typedef struct {
  onp_sequence_t *a;
  onp_sequence_t *b;
  uint m;
  uint n;
  int *path;
  uint editdis;
} onp_diff_t;

onp_diff_t *onp_alloc_diff (onp_sequence_t *a, onp_sequence_t *b);
void onp_free_diff (onp_diff_t *diff);
void onp_compose (onp_diff_t *diff);

#endif
