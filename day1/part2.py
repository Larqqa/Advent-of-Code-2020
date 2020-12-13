from lib import binary_search_array, get_input_list

def find_sum_of_three_in_array(array, value):
  for number in array:
    for number2 in array:
      remainder = value - (number + number2)

      found_value = binary_search_array(remainder, array)

      if found_value and found_value == remainder:
        return number, number2, found_value

  return 'No matching sum for value found'

# PART 2
reports = get_input_list('input')
reports.sort()

found2 = find_sum_of_three_in_array(reports, 2020)
print(found2[0] * found2[1] *found2[2])
