function getInput(filename)
  file = open(filename, "r");
  input = replace(read(file, String), "\"" => "");
  (rules, messages) = map((x) -> split(x, "\n"), split(input, "\n\n"));
  close(file);

  tree = Dict();
  for rule in rules
    (name, rest) = split(rule, ": ");
    tree[name] = rest;
  end

  return tree, messages;
end

function buildRegex(leaf, tree)
  regExp = "";

  for char in split(leaf)
    if occursin(char, "|ab")
      regExp = regExp * char;
      continue;
    else
      subrule = buildRegex(tree[char], tree)
      if occursin("|", subrule)
        subrule = "($subrule)";
      end

      regExp = regExp * subrule;
    end
  end

  return regExp;
end

function countMatches(messages, tree)
  rule = Regex("^$(buildRegex(tree["0"], tree))\$", "x");
  return count(!isnothing, match.(rule, messages));
end

(tree, messages) = getInput("resources/input");
println(countMatches(messages, tree));