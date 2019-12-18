#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <time.h>

void list(const char *pathname){
  struct stat s;

  if(stat(pathname, &s) < 0){
    printf("error in stat()\n");
    exit(1);
  }

  if(S_ISDIR(s.st_mode)) print_dir(pathname);
  else if(S_ISREG(s.st_mode)) print_reg(pathname);
  else printf("Cannot interpret pathname [%s].\n");
}

int main(int argc, char *argv[])
{
  if (argc == 1) list(".");
  else {
    for (int i=1; i<argc; i++) {
      list(argv[i]);
    }
  }

  return EXIT_SUCCESS;
}
