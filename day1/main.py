import time
from part1 import find_sum_of_two_in_array
from part2 import find_sum_of_three_in_array

# Get input
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

# reports = [1721, 979, 366, 299, 675, 1456]

# PART 1
start = time.perf_counter()

reports = get_input_list('input.txt')
reports.sort()

found1 = find_sum_of_two_in_array(reports, 2020)
print(found1[0] * found1[1])

stop = time.perf_counter()
print(stop - start)

# PART 2
start = time.perf_counter()

reports = get_input_list('input.txt')
reports.sort()

found2 = find_sum_of_three_in_array(reports, 2020)
print(found2[0] * found2[1] *found2[2])

stop = time.perf_counter()
print(stop - start)