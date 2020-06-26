#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char *argv[]){
  int fd = open("./hp_1.txt", O_RDONLY);

  char *p = (char *)mmap(0, 4096, PROT_READ, MAP_SHARED, fd, 0);

  for(int idx = 0; idx < 4096; idx++)
    printf("%c", *(p+idx)); 

  close(fd);

  return 0;
}
