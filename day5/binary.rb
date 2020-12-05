def read_file(file_name)
  file = File.open(file_name)
  file_data = file.read.split
  file.close
  return file_data
end

def calculate_binary(input)
  number = 0
  input.split("").reverse().each_with_index do |seat, i|
    if (seat == "B" || seat == "R")
      number += 1 << i
    end
  end
  return number
end

def part1()naive
  puts read_file("input.txt").map{|n| calculate_binary(n)}.max
end


def part2()
  a = read_file("input.txt").map{|n| calculate_binary(n)}.sort
  puts a.select.with_index{|s,i| s + 2 == a[i + 1]}[0] + 1
end

part1()
part2()
