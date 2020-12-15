import time

def check_password_part1(min, max, character, password):
  character_count = password.count(character)

  if character_count < min or character_count > max:
    return False
  else:
    return True

def check_password_part2(min, max, character, password):
  min_char = password[min - 1]
  max_char = password[max - 1]

  if min_char == max_char:
    return False
  elif min_char == character:
    return True
  elif max_char == character:
    return True
  else:
    return False

def count_valid_passwords(file_name, checker_function):
  with open(file_name) as f:
    valid_count = 0

    for line in f:
      arr = line.split(' ')
      arr[1] = arr[1].split(':')[0]
      arr[2] = arr[2].split('\n')[0]
      num = arr[0].split('-')
      num[0] = int(num[0])
      num[1] = int(num[1])

      if checker_function(num[0], num[1], arr[1], arr[2]):
        valid_count += 1

    return valid_count

start = time.perf_counter()
print(count_valid_passwords('input.txt', check_password_part1))
stop = time.perf_counter()
print((stop - start) * 1000)

start = time.perf_counter()
print(count_valid_passwords('input.txt', check_password_part2))
stop = time.perf_counter()
print((stop - start) * 1000)
