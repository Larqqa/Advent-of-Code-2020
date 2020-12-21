#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lib.h"

struct Map {
  long address;
  long value;
};

int main(int argc, char *argv[]) {
  // char* file = readFile(argv[1]);

  char* file = readFile("resources/training2");
  char* input = strtok(file, "\n");
  // char* masked = malloc(37);
  char* tmp = malloc(37);
  char* uInt = malloc(37);

  char command[5];
  int length = strlen(input);

  struct Map mem[100000] = {};

  char value[37];
  char mask[37];

  while (input != NULL) {
    char* masked;
    long address;
    tmp[0] = 0;
    uInt = 0;

    strncpy(command, input, 4);

    if (strcmp(command, "mask") == 0) {
      strncpy(mask, input + 7, length - 1);
      mask[strlen(mask)] = 0;
    } else {
      strncpy(value, strstr(input, "= ") + 2, length - 1);
      value[strlen(value)] = 0;

      address = atoi(extract_between(input, "[", "]"));

      uInt = decToBin(atol(value), 35, tmp);

      masked = applyMask(uInt, mask);

      long final = binToDec(masked);

      mem[address].value = final;
      printf("%lu\n", mem[address].value);
    }

    input = strtok (NULL, "\n");
  }

  // 17028179706934

  long sum = 0;
  for (int i = 0; i < 100000; i++) {

    if (mem[i].value > 0) {
      //sum += mem[i].value;
      // printf("%lu\n", mem[i].value);
    }
  }

  // printf("\n%lu\n", sum);

  return 0;
}