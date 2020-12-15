#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* readFile(char* fileName) {
  FILE * fp = fopen(fileName, "r");
  fseek(fp, 0, SEEK_END);
  int length = ftell(fp);
  rewind(fp);

  char* content = malloc(length);
  char fragment = '0';
  int i = 0;

  while (fragment != EOF) {
    fragment = getc(fp);
    content[i++] = fragment;
  }

  content[i - 1] = '\0';
  fclose(fp);

  return content;
}

long unsignedToInt(char* str) {
  long data = 0;
  long i = 0;

  char* pos;
  pos = &str[strlen(str)-1];

  while(*pos == '0' || *pos == '1') {
    (*pos) -= '0';
    data += (*pos) << i;

    i++;
    pos--;
  }

  return data;
}

char* intToUnsigned(int num, int index, char* uint) {
  if (index > 0) {
    intToUnsigned(num / 2, index - 1, uint);
  }

  sprintf(uint, "%s%d", uint, num %2);
  return uint;
}

char* extract_between(const char *str, const char *p1, const char *p2) {
  const char *i1 = strstr(str, p1);

  if(i1 != NULL){
    const size_t pl1 = strlen(p1);
    const char *i2 = strstr(i1 + pl1, p2);
    if(p2 != NULL)
    {
     /* Found both markers, extract text. */
     const size_t mlen = i2 - (i1 + pl1);
     char *ret = malloc(mlen + 1);
     if(ret != NULL)
     {
       memcpy(ret, i1 + pl1, mlen);
       ret[mlen] = '\0';
       return ret;
     }
    }
  }
}

long poww(int x, int n) {
  int i;
  long number = 1;

  for (i = 0; i < n; ++i) {
    number *= x;
  }

  return(number);
}

long binToDec(char* str) {
  char character;
  long num = 0;
  for (int i = 0; strlen(str) > i; i++) {
    if (str[i] == '1') {
      num += poww (2, (strlen(str) - 1) - i);
    }
  }

  return num;
}

struct Map {
  long address;
  long value;
};

int main(int argc, char *argv[]) {
  char* file = readFile(argv[1]);
  char* input = strtok(file, "\n");
  int length = strlen(input);
  int iteration = 0;

  struct Map *mem = malloc(19000);

  while (input != NULL) {
    char mask[37];
    char masked[37];
    char value[37];
    char command[5];
    char* unsigned_int;
    char* tmp_u_int = malloc(37);
    tmp_u_int[0] = 0;
    char *target = NULL;
    char *start, *end;

    strncpy(command, input, 4);
    command[4] = 0;

    if (strcmp(command, "mask") == 0) {
      strncpy(mask, input + 7, length - 1);
      mask[strlen(mask)] = 0;
    } else {
      strncpy(value, strstr(input, "= ") + 2, length - 1);
      value[strlen(value)] = 0;

      unsigned_int = intToUnsigned(atoi(value), 35, tmp_u_int);

      for (int i = 0; i < strlen(mask); i++) {
        if (mask[i] != 'X') {
          strncpy(&masked[i], &mask[i], 1);
        } else {
          strncpy(&masked[i], &unsigned_int[i], 1);
        }
      }

      // printf("mask : %s\n", mask);
      // printf("uint : %s\n", unsigned_int);
      // // printf("wmask: %s\n", masked);
      // printf("value: %s masked: %d\n", value, unsignedToInt(masked));

      // // printf("%lu\n", binToDec(masked));

      // mem[iteration].address = atoi(extract_between(input, "[", "]"));
      mem[atoi(extract_between(input, "[", "]"))].value = binToDec(masked);
    }

    iteration++;
    input = strtok (NULL, "\n");
  }

  long sum = 0;
  for (int i = 0; i < sizeof(mem); i++) {
    printf("%lu ", mem[i].value);
  }

  return 0;
}