from itertools import combinations

def get_input_list(file_name):
  try:
    with open(file_name) as f:
      input_list = []
      for line in f:
        input_list.append(line.rstrip())

      return input_list
  except:
    print('No file')
    quit()

def find_between(s, start, end):
  return (s.split(start))[1].split(end)[0]

def binToInt(bin):
  return int(bin, 2)

def intToBin(num, bit):
  return bin(num)[2:].zfill(bit)

def getCombinations(floats):
  floatSet = set()
  for a in combinations(floats, int((len(floats) / 2))):
    floatSet.add("".join(a))
  return floatSet