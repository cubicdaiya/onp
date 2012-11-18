#import <Foundation/Foundation.h>

#import "diff.h"

// gcc -framework Foundation editdis.m diff.m
int main(int argc, char **argv)
{
  if (argc < 3) {
    NSLog(@"few arguments.\n");
    return -1;
  }
  Diff *diff = [Diff alloc];
  NSString *a = [NSString stringWithUTF8String:argv[1]];
  NSString *b = [NSString stringWithUTF8String:argv[2]];
  [diff init:a:b];
  [diff compose];
  NSLog(@"edit distance:%d\n", diff.editdis);
  [diff release];
  return 0;
}
