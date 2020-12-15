require "lib"

input = {1,2,16,19,18,0}
-- input = {0,3,6}
last = 0
hash = {}

--# initial input
for k, v in ipairs(input) do
  if k == #input then
    last = v
  else
    hash[v] = k
  end
end

for i = #input, 30000000 - 1, 1 do
  if (hash[last] ~= nil) then
    next = i - hash[last]
    hash[last] = i
    last = next
  else
    hash[last] = i
    last = 0
  end
end

-- print_r(hash)

print(last)