
-- checked with Lua5.1.4

dofile("onp.lua")

if #arg < 2 then
   error("few argument")
end
a = arg[1]
b = arg[2]
d = ONP.new(a, b)
d:compose()
print("editDistance:" .. d:geteditdistance())
print("LCS:" .. d:getlcs())
print("SES")
ses = d:getses()
for i=1, #ses do
   if ses[i].type == SES_COMMON then
      print("  " .. ses[i].elem)
   elseif ses[i].type == SES_DELETE then
      print("- " .. ses[i].elem)
   elseif ses[i].type == SES_ADD then
      print("+ " .. ses[i].elem)
   end
end
