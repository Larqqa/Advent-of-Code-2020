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

  for i in list
    next = hash[string(i)];

    if next == "a" || next == "b"
      str = str * next;
    else
      right = makeList(next[1]);
      left = makeList(next[2]);
      str = str * "(" * right * "|" * left * ")";
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
