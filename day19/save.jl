function makeRuleTree(line)
  strn = [];
  arr = [];

  if occursin('|', line)
    arr = split(line, " | ");
    return [makeRuleTree(arr[1]), makeRuleTree(arr[2])];
  else
    arr = split(line, " ");
  end

  for i in arr
    next = hash[i];

    if next != "a" && next != "b"
      append!(strn, [makeRuleTree(next)]);
    else
      append!(strn, next);
    end
  end

  return strn;
end

tree = makeRuleTree(hash["0"]);
println(tree);

function findInTree(msg, tree)
  println(msg);

  if length(msg) == 0
    return true;
  end

  if tree[1] == 'a' || tree[1] == 'b'
    if tree[1] == msg[1]
      findInTree(chop(msg, head = 1, tail = 0), popfirst!(tree));
    end
  else
    return findInTree(msg, tree);
  end

  return false;
end

findInTree(messages[1], tree);

function parse(str)
  if occursin('|', str)
    return map(x -> split(x, " "), split(str, " | "))
  elseif occursin(' ', str)
    return split(str, " ");
  else
    return str;
  end
end

hash = Dict();
map(x -> hash[x[1]] = parse(x[2]), map(x -> split(x, ": "), rules));


# YEEEET
# function makeList(list)
#   str = "";

#   if isa(list[1], Array)
#     left = makeList(list[1]);
#     right = makeList(list[2]);

#     if left != nothing && right != nothing
#       return [right, left ];
#     end
#   else
#     for i in list
#       next = hash[string(i)];

#       if next == "a" || next == "b"
#         str = str * next;
#       else
#         return makeList(next);
#       end

#     end
#   end

#   if str != ""
#     return str;
#   end
# end


# for i in hash["0"]
#   yeet = makeList(i);
#   println(yeet);
# end



# function traverse(msg, tree)
#   if length(msg) == 0
#     return true
#   end

#   for leaf in tree
#     if leaf == 'a' || leaf == 'b'
#       if SubString(msg, 1, 2) == leaf
#         traverse(chop(msg, head = 1), hash[leaf[2]]);
#       end
#     elseif isa(leaf, Array)
#       return [traverse(msg, hash[leaf[1]]), traverse(msg, hash[leaf[2]])];
#     else
#       return traverse(msg, hash[leaf]);
#     end
#   end
# end

# println(traverse(messages[1], hash["0"]));


###SAVE
file = open("resources/training", "r");
input = replace(read(file, String), "\"" => "");
close(file);

(rules, messages) = map((x) -> split(x, "\n"), split(input, "\n\n"));

hash = Dict();
for l in rules
  (name, rest) = split(l, ": ");

  if occursin('|', rest)
    rest = split(rest, " | ");
    rest = map(x -> tuple(split(x, " ")...), rest);
  elseif length(rest) > 1
    rest = tuple(split(rest, " ")...);
  else
    rest = [rest];
  end

  hash[name] = rest;
end

# println(hash)

dict = Dict();
function makeList(tree)
  new_calc= Dict();

  for leaf in tree
    new_rule = [];

    for sub_rule in leaf
      if isa(sub_rule, Tuple)
        println(sub_rule);
        res = makeList(sub_rule);
        # println(res)

        if isnothing(res)
          append!(new_rule, sub_rule)
        else
          append!(new_rule, res)
        end
      else
        append!(new_rule, sub_rule)
      end
    end

    # println(leaf);
    new_calc[leaf[1]] = new_rule
  end

  # dict = new_calc;
end

makeList(hash);
# println(dict)


# function traverse(msg, tree)
#   if length(msg) == 0
#     return true
#   end

#   for leaf in tree
#     if leaf == 'a' || leaf == 'b'
#       if SubString(msg, 1, 2) == leaf
#         traverse(chop(msg, head = 1), hash[leaf[2]]);
#       end
#     elseif isa(leaf, Array)
#       return [traverse(msg, hash[leaf[1]]), traverse(msg, hash[leaf[2]])];
#     else
#       return traverse(msg, hash[leaf]);
#     end
#   end
# end

# println(traverse(messages[1], hash["0"]));
