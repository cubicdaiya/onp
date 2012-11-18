
#import <Foundation/Foundation.h>

#import "diff.h"

/**
 * The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
 * by described by Sun Wu, Udi Manber and Gene Myers
 */
@implementation Diff
@synthesize editdis;
- (void)swap:(id *)a:(id *)b
{
  id *t;
  t = a;
  a = b;
  b = t;
}

- (void)init:(NSString *)a:(NSString *)b
{
  A = a;
  B = b;
  M = A.length;
  N = B.length;
  if (M > N) {
    [self swap:(id *)A:(id *)B];
    [self swap:(id *)&M:(id *)&N];
  }
}

- (void)compose
{
  NSInteger i, k;
  NSInteger p        = -1;
  NSInteger size     = M + N + 3;
  NSInteger delta    = N - M;
  NSInteger offset   = M + 1;
  NSMutableArray *fp = [[[NSMutableArray alloc] initWithCapacity:size] autorelease];
  NSNumber *op, *opp, *oi, *ly;
  for (i=0;i<size;++i) {
    NSNumber *oi = [NSNumber numberWithInt:-1];
    [fp addObject:oi];
  }
  
  do {
    ++p;
    for (k=-p;k<=delta-1;++k) {
      op  = [fp objectAtIndex:k-1+offset];
      opp = [fp objectAtIndex:k+1+offset];
      oi  = [NSNumber numberWithInt:
                        [self snake:k:[op integerValue]+1:[opp integerValue]]];
      [fp replaceObjectAtIndex:k+offset withObject:oi];
    }
    for (k=delta+p;k>=delta+1;--k) {
      op  = [fp objectAtIndex:k-1+offset];
      opp = [fp objectAtIndex:k+1+offset];
      oi  = [NSNumber numberWithInt:
                        [self snake:k:[op integerValue]+1:[opp integerValue]]];
      [fp replaceObjectAtIndex:k+offset withObject:oi];
    }
    op  = [fp objectAtIndex:delta-1+offset];
    opp = [fp objectAtIndex:delta+1+offset];
    oi  = [NSNumber numberWithInt:
                      [self snake:delta:[op integerValue]+1:[opp integerValue]]];
    [fp replaceObjectAtIndex:delta+offset withObject:oi];
    ly = [fp objectAtIndex:delta+offset];
  } while([ly integerValue] < N);
  editdis = delta + 2 * p;
}

- (NSInteger)snake:(NSInteger)k:(NSInteger)p:(NSInteger)pp
{
  NSInteger y = MAX(p, pp);
  NSInteger x = y - k;
  
  while (x < M && 
         y < N && 
         [A substringWithRange:NSMakeRange(x, 1)] == [B substringWithRange:NSMakeRange(y, 1)])
  {
	++x;
	++y;
  }
  return y;
}
@end
