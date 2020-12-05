def read_file(file_name)
  file = File.open(file_name)
  file_data = file.read
  file.close
  return file_data
end

content = read_file("input.txt").split
puts content[0]
