file = open("resources/training", "r");
input = replace(read(file, String), "\"" => "");
close(file);

(rules, messages) = map((x) -> split(x, "\n"), split(input, "\n\n"));

hash = Dict();
for l in rules
  (name, rest) = split(l, ": ");

  if occursin('|', rest)
    rest = split(rest, " | ");
    rest = map(x -> split(x, " "), rest);
  elseif length(rest) > 1
    rest = split(rest, " ");
  else
    # rest = [rest];
  end

  hash[name] = rest;
end

# println(hash);

function makeList(list)
  str = "";

  if isa(list[1], Array)
    left = makeList(list[1]);
    right = makeList(list[2]);

    if left != nothing && right != nothing
      return "(" * right * "|" * left * ")";
    end
  else
    for i in list
      next = hash[string(i)];

      if next == "a" || next == "b"
        str = str * next;
      else
        return makeList(next);
      end

    end
  end

  if str != ""
    return str;
  end
end

# makeList(hash["0"]);

reg = "";
for i in hash["0"]
  yeet = makeList(i);
  println(yeet);
end
# a(((aa|bb)(ab|ba))|((ab|ba)(aa|bb)))b



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
