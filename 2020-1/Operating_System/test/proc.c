#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
  if(argc != 2){
    printf("Exactly one integer argument must be given.\n");
    return 1;
  }

  int childnum;
  int idx;
  int pid;

  if((childnum = atoi(argv[1])) == 0){
    printf("Error in parsing argument.\n");
    return 1;
  }

  for(idx = 0; idx < childnum; idx++){
    printf("Stage %d --------------------------------------\n", idx);
    if((pid = fork()) == 0)
      printf("Child process with pid %d\n", getpid());
    else
      printf("Parent process with pid %d, child's pid %d\n", getpid(), pid);
    printf("-----------------------------------------------\n");
  }

  return 0;
}
