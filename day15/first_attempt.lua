require "lib"

input = {1,2,16,19,18,0}
-- input = {0,3,6}

hash = {}
it = 1
last = 0
sep = 0

-- Init hash
for k, v in ipairs(input) do
    hash[v] = {it, 0, 1}
    last = v
    it = it + 1
end
hash[last][3] = 0

while it <= 2020 do

    if (hash[last] ~= nil and hash[last][3] == 0) then

        if (hash[0]) then
            hash[0] = {it, hash[0][1], hash[0][3] + 1}
        else
            hash[0] = {it, 0, 0}
        end

        last = 0

    elseif (hash[last][3] ~= 0) then

        last = hash[last][1] - hash[last][2]

        if (hash[last]) then
            hash[last] = {it, hash[last][1], hash[last][3] + 1}
        else
            hash[last] = {it, 0, 0}
        end

    end
    print(it)

    it = it + 1
end

-- print_r(hash)
print(last)
