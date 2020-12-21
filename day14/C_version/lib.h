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

long poww(long x, long n) {
  int i;
  int iter = 0;
  long number = 1;

  for (i = 0; i < n; ++i) {
    number *= x;
    iter++;
  }

  return number;
}

char* decToBin(long num, int bits, char* uint) {
  if (bits > 0) {
    decToBin(num / 2, bits - 1, uint);
  }

  sprintf(uint, "%s%d", uint, num % 2);
  return uint;
}

long binToDec(char* str) {
  long num = 0;

  for (int i = 0; strlen(str) > i; i++) {
    if (str[i] == '1') {
      num += poww(2, (strlen(str) - 1) - i);
    }
  }

  return num;
}

char* applyMask(char* uInt, char mask[37]) {
  char* masked = malloc(37);
  int len = strlen(mask);

  for (int i = 0; i < len; i++) {
    if (mask[i] != 'X') {
      strncpy(&masked[i], &mask[i], 1);
    } else {
      strncpy(&masked[i], &uInt[i], 1);
    }
  }

  return masked;
}


    // if (mask[i] != 'X') {
    //   // strncpy(tmp, mask + i, i + 1);
    //   // strncpy(&masked[i], &mask[i], 1);
    // } else {
    //   // strncpy(tmp2, uInt + i, i + 1);
    //   // printf("%s\n", tmp);
    //   // strncpy(&masked[i], &uInt[i], 1);
    // }