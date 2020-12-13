from lib import get_input_list, split_array, binary_search_array

def find_in_split(split, array, delim, value):
  rem = value - split[delim]
  found_value = binary_search_array(rem, array)

  if found_value == rem:
    return split[delim], found_value
  else:
    return find_sum_of_two_in_array(split, array, value)

def find_sum_of_two_in_array(split, array, value):
  if len(split) <= 1:
    return

  a, b = split_array(split)

  aF = find_in_split(a, array, -1, value)
  bF = find_in_split(b, array, 0, value)

  if (aF):
    return aF
  elif (bF):
    return bF

reports = get_input_list('resources/input')
reports.sort()

found1 = find_sum_of_two_in_array(reports, reports, 2020)
print(found1[0] * found1[1])