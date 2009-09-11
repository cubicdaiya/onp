
#include <stdio.h>
#include "onp.h"

int main (int argc, char *argv[]) {
  
  if (argc < 3) {
    printf("set two arguments\n");
    return -1;
  }

  onp_diff_t *diff = onp_alloc_diff(argv[1], argv[2]);
  onp_compose(diff);
  printf("editdistance:%d\n", diff->editdis);
  onp_free_diff(diff);
  
  return 0;
}
