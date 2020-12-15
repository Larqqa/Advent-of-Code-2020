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

void sumOfTwo(char lines[200][BUFSIZ], int i) {
  for (int j = 0; j <= i; j++) {
    for (int k = 0; k <= i; k++) {
      if (atoi(lines[j]) + atoi(lines[k]) == 2020) {
        printf("%lu\n", atol(lines[j]) * atol(lines[k]));
        return;
      }
    }
  }
}

void sumOfThree(char lines[200][BUFSIZ], int i) {
  for (int j = 0; j < i; j++) {
    for (int k = 0; k < i; k++) {
      for (int l = 0; l < i; l++) {
        if (atoi(lines[j]) + atoi(lines[k]) + atoi(lines[l]) == 2020) {
          printf("%lu\n", atol(lines[j]) * atol(lines[k]) * atol(lines[l]));
          return;
        }
      }
    }
  }
}

int main(void) {
  int i = 0;
  char lines[200][BUFSIZ];
  FILE *fp = fopen("resources/input", "r");

  while (i < 200 && fgets(lines[i], sizeof(lines[0]), fp)) {
    lines[i][strlen(lines[i])-1] = '\0';
    i = i + 1;
  }
  fclose(fp);

  sumOfTwo(lines, i);
  sumOfThree(lines, i);

  return 0;
}