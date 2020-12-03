# reports = [1721, 979, 366, 299, 675, 1456]


def split_list(array):
  half = len(array) // 2
  return array[:half], array[half:]

def search_array(number, remainder, array):
  if len(array) <= 1:
    return array[0]

  b, c = split_list(array)

  if b[-1] >= remainder:
    return search_array(number, remainder, b)
  elif c[0] <= remainder:
    return search_array(number, remainder, c)

def find_sum_of_three_in_array(array, value):
  for number in array:
    for number2 in array:

      remainder = value - (number + number2)

      found_value = search_array(number, remainder, array)

      if found_value and found_value == remainder:
        return number, number2, found_value

  return 'No matching sum for value found'
