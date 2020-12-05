def read_file(file_name)
  file = File.open(file_name)
  file_data = file.read.split
  file.close
  return file_data
end

def binary_search(array, orders, run = 0)
  if (run > orders.length - 1) then
    return array[0]
  end

  array = array.each_slice((array.size/2.0).round ).to_a
  character = orders[run]

  if (character == "F" || character == "L") then
    binary_search(array[0], orders, run + 1)
  elsif (character == "B" || character == "R") then
    binary_search(array[1], orders, run + 1)
  end
end

def init_plane(row_num, col_num)
  rows = [];
  (0..row_num).step(1) do |n|
    rows[n] = n
  end

  columns = [];
  (0..col_num).step(1) do |n|
    columns[n] = n
  end

  return [rows, columns]
end

def part1()
  content = read_file("input.txt")
  rows, columns = init_plane(127, 7)
  highest = 0

  for seat in content do
    seat_num = binary_search(rows, seat[0..seat.length - 4]) * 8 + binary_search(columns, seat[seat.length - 3..seat.length])

    if highest < seat_num then
      highest = seat_num
    end
  end

  puts highest
end

def part2()
  all_seats = read_file("input.txt")
  rows, columns = init_plane(127, 7)
  seats = []

  all_seats.each_with_index do |seat, i|
    all_seats[i] = binary_search(rows, seat[0..seat.length - 4]) * 8 + binary_search(columns, seat[seat.length - 3..seat.length])
  end

  all_seats = all_seats.sort

  all_seats.each_with_index do |seat, i|
    if (seat + 2 == all_seats[i + 1]) then
      puts [seat, all_seats[i + 1]].inspect
      puts seat + 1
    end
  end
end

# part1()
part2()
