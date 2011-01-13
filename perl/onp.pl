#!/usr/bin/env perl
use strict;

=comment
The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"
by described by Sun Wu, Udi Manber and Gene Myers
=cut

sub snake {
  my $a  = $_[0];
  my $b  = $_[1];
  my $m  = $_[2];
  my $n  = $_[3];
  my $k  = $_[4];
  my $p  = $_[5];
  my $pp = $_[6];
  my $y = $p < $pp ? $pp : $p;
  my $x = $y - $k;
  while ($x < $m and $y < $n and substr($a, $x, 1) eq substr($b, $y, 1)) {
    ++$x;
    ++$y;
  }
  return $y;
}

sub editdistance {
  my $a = $_[0];
  my $b = $_[1];
  my $m = length($a);
  my $n = length($b);
  if ($m >= $n) {
    ($a, $b) = ($b, $a);
    ($m, $n) = ($n, $m);
  }
  my $offset = $m + 1;
  my $delta  = $n - $m;
  my $size   = $m + $n + 3;
  my @fp;
  for (my $i=0;$i<$size;++$i) {
    $fp[$i] = -1;
  }
  my $p = -1;
  do {
    ++$p;
    for (my $k=-$p;$k<=$delta-1;++$k) {
      $fp[$k+$offset] = snake($a, $b, $m, $n, $k, $fp[$k-1+$offset]+1, $fp[$k+1+$offset]);
    }
    for (my $k=$delta+$p;$k>=$delta+1;--$k) {
      $fp[$k+$offset] = snake($a, $b, $m, $n, $k, $fp[$k-1+$offset]+1, $fp[$k+1+$offset]);
    }
    $fp[$delta+$offset] = snake($a, $b, $m, $n, $delta, $fp[$delta-1+$offset]+1, $fp[$delta+1+$offset]);
  } while ($fp[$delta + $offset] != $n);
  return $delta + 2 * $p;
}

if ($#ARGV + 1 == 2) {
  print "editdistance:", editdistance($ARGV[0], $ARGV[1]), "\n";
} else {
  print "few arguments\n"
}
