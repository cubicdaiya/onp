
#import <Foundation/Foundation.h>

@interface Diff : NSObject
{
  NSString *A;
  NSString *B;
  NSInteger       M;
  NSInteger       N;
  NSInteger       editdis;
}
- (void) swap:(id *)a:(id *)b;
- (void) init:(NSString *)a:(NSString *)b;
- (void) compose;
- (NSInteger) snake:(NSInteger)k:(NSInteger)p:(NSInteger)pp;
@property(readonly) NSInteger editdis;
@end
