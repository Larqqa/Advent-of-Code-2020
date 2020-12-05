puts File.readlines("input.txt").map{|n| n.tr('BFRL', '1010').to_i(2)}.max

a = File.readlines("input.txt").map{|n| n.tr('BFRL', '1010').to_i(2)}.sort
puts a.select.with_index{|s,i| s + 2 == a[i + 1]}[0] + 1