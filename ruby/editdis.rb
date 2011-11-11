#!/usr/bin/env ruby

require_relative 'Diff'

a = ARGV[0]
b = ARGV[1]

diff = Diff.new(a, b);
diff.compose()
print "editdistance:#{diff.editdis.to_s()}\n"
