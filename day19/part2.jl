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

function countMatches(tree, messages)
  tree["8"] = "42 | 42 8"
  tree["11"] = "42 31 | 42 11 31"
  rx42 = buildRegex(tree["42"], tree)
  rx31 = buildRegex(tree["31"], tree)

  builder(i) = "(($rx42){$i}($rx31){$i})";
  rule = Regex("^(($rx42)+($(builder(1))|$(builder(2))|$(builder(3))|$(builder(4))))\$", "x");

  return count(!isnothing, match.(rule, messages));
end

(tree, messages) = getInput("resources/input");
println(countMatches(tree, messages));
