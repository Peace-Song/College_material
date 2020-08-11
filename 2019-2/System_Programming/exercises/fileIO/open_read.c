#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(){
    int fd;
    int ret_val;
    char read_buffer[1000];

    fd = open("./test.c", O_RDONLY);
    if(fd < 0){
        printf("open error\n");
        return 1;
    }

    ret_val = read(fd, read_buffer, sizeof(read_buffer));
    if(ret_val < 0){
        printf("read error\n");
        return 1;
    }

    printf("open and read successfully conducted.\n");
    printf(read_buffer);
    printf("Program has read %d characters so far.\n", ret_val);

    close(fd);

    return 0;
}

