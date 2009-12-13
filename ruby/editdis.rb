#!/usr/bin/env ruby

require "onp.rb"

a = ARGV[0]
b = ARGV[1]

diff = Onp.new(a, b);
diff.compose()
print "editdistance:#{diff.editdis.to_s()}\n"



