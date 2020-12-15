from lib import intToBin, binToInt, find_between, getCombinations

def part2(reports):
  mask = ""
  address = 0
  value = 0
  memory = {}

  for line in reports:
    if (line[:4] == "mask"):
      mask = line[7:]

    else:
      address = intToBin(int(find_between(line, "[", "]")), 36)
      value = int(line.split("= ", 1)[1])

      masked = ""
      float = []
      for i in range(0, len(mask)):
        if (mask[i:i + 1] == '0'):
          masked = masked + address[i:i + 1]
        elif (mask[i:i + 1] == '1'):
          masked = masked + mask[i:i + 1]
        else:
          masked = masked + 'X'
          float.append("0")
          float.append("1")

      combs = getCombinations(float)
      for comb in combs:
        counter = 0
        newNum = ""
        for i in range(0, len(masked)):
          if (masked[i:i + 1] == 'X'):
            newNum = newNum + comb[counter]
            counter = counter + 1
          else:
            newNum = newNum + masked[i:i + 1]
        memory[binToInt(newNum)] = value

  sum = 0
  for key, value in memory.items():
    sum = sum + value
  print(sum)