def split_array(array):
  half = len(array) // 2
  return array[:half], array[half:]

def binary_search_array(remainder, array):
  if len(array) <= 1:
    return array[0]

  b, c = split_array(array)

  if b[-1] >= remainder:
    return binary_search_array(remainder, b)
  elif c[0] <= remainder:
    return binary_search_array(remainder, c)

def get_input_list(file_name):
  try:
    with open(file_name) as f:
      input_list = []
      for line in f:
        input_list.append(int(line))

      return input_list
  except:
    print('Input should only contain numbers')
    quit()