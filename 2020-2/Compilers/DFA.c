#include <stdio.h>

int move_table[4][2] = {{1, 0}, {1, 2}, {1, 3}, {1, 0}};

int DFA(char *input, int s0, int (*move)(int, char));
int move(int s, char c);

int main() {
  int f = DFA("aababb", 0, move);

  if (f == 3) printf("accept\n");
  else printf("nope\n");

  return 0;
}

int DFA(char *input, int s0, int (*move)(int, char)) {
  int s = s0;
  char c = *input++;
  while (c != '\0') {
    s = move(s, c);
    c = *input++;
  }
  return s;
}

int move(int s, char c) {
  return move_table[s][(int)(c - 'a')];
}
