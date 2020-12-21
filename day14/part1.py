from lib import intToBin, binToInt, find_between

def part1(reports):
  mask = ""
  address = 0
  value = 0
  memory = {}

  for line in reports:
    if (line[:4] == "mask"):
      mask = line[7:]

    else:
      address = find_between(line, "[", "]")
      value = intToBin(int(line.split("= ", 1)[1]), 36)

      masked = ""
      for i in range(0, len(mask)):
        if (mask[i:i + 1] != 'X'):
          masked = masked + mask[i:i + 1]
        else:
          masked = masked + value[i:i + 1]

      memory[address] = binToInt(masked)
      print(binToInt(masked))

  sum = 0
  for key, value in memory.items():
    sum = sum + value
  print(sum)