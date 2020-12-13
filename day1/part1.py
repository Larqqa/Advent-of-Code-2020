from lib import get_input_list, split_array, binary_search_array

def find_sum_of_two_in_array(array, split, value):
  if len(split) <= 1:
    return split[0]

  b, c = split_array(split)

  bRem = value - b[-1]
  b_found_value = binary_search_array(bRem, array)
  if b_found_value == bRem:
    return b[-1], b_found_value
  else:
    return find_sum_of_two_in_array(array, b, value)

  cRem = value - c[0]
  c_found_value = binary_search_array(cRem, array)
  if c_found_value == cRem:
    return c[0], c_found_value
  else:
    return find_sum_of_two_in_array(array, c, value)

reports = get_input_list('training')
reports.sort()

found1 = find_sum_of_two_in_array(reports, reports, 2020)
print(found1[0] * found1[1])