import time

def split_array(array):
  half = len(array) // 2
  return array[:half], array[half:]

def binary_search_array(number, remainder, array):
  if len(array) <= 1:
    return array[0]

  b, c = split_array(array)

  if b[-1] >= remainder:
    return binary_search_array(number, remainder, b)
  elif c[0] <= remainder:
    return binary_search_array(number, remainder, c)


def find_sum_of_two_in_array(array, value):
  for number in array:
    remainder = value - number

    found_value = binary_search_array(number, remainder, array)

    if found_value and found_value == remainder:
      return number, found_value

  return 'No matching sum for value found'

def find_sum_of_three_in_array(array, value):
  for number in array:
    for number2 in array:

      remainder = value - (number + number2)

      found_value = binary_search_array(number, remainder, array)

      if found_value and found_value == remainder:
        return number, number2, found_value

  return 'No matching sum for value found'

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

# PART 1
start = time.perf_counter()

reports = get_input_list('input.txt')
reports.sort()

found1 = find_sum_of_two_in_array(reports, 2020)
print(found1[0] * found1[1])

stop = time.perf_counter()
print((stop - start) * 1000)

# PART 2
start = time.perf_counter()

reports = get_input_list('input.txt')
reports.sort()

found2 = find_sum_of_three_in_array(reports, 2020)
print(found2[0] * found2[1] *found2[2])

stop = time.perf_counter()
print((stop - start) * 1000)
