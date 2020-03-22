#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"

#define ANSI_COLOR_BOLD_RED "\033[1m\033[31m"
#define ANSI_COLOR_RED      "\x1b[31m"
#define ANSI_COLOR_YELLOW   "\x1b[33m"
#define ANSI_COLOR_RESET    "\x1b[0m"

volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
  if(cpuid() == 0){
    consoleinit();
    printfinit();
    printf("\n");
    printf("xv6 kernel is booting\n");

    /* Project 1 starts */
    printf(ANSI_COLOR_RED);

    printf("\n");
    printf("\n");

    printf("경애하는 ");
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    printf(ANSI_COLOR_RED" 교원 동지의 지도를 받아 제작된 -\n\n");

    printf("\
        __\n\
       / \\--..____\n\
       \\ \\       \\-----,,,..\n\
        \\ \\       \\         \\--,,..\n\
         \\ \\       \\         \\  ,'\n\
          \\ \\       \\         \\ ``..\n\
           \\ \\       \\         \\-''\n\
            \\ \\       \\__,,--'''\n\
             \\ \\       \\.\n\
              \\ \\      ,/\n\
               \\ \\__..-\n\
                \\ \\\n\
                 \\ \\\n\
                  \\ \\\n\
                   \\ \\\n\
    ");
    printf("\n\n");

    printf(ANSI_COLOR_BOLD_RED);
    printf("\
                  붉은 기\n\
    ");
    printf(ANSI_COLOR_RESET);
    printf(ANSI_COLOR_RED);
    printf("\n\
           개발용 조작체계 1.0판\n");
    printf("\n");

    printf("본 조작체계는 운영체제 수업의 교원이신 ");
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    printf(ANSI_COLOR_RED" 교원 동지의 개교 104년(2020년) 3월 19일 학생들에게 하달하신 교시에 의하여 제작되었다.\n\n");

    printf("만든 학생: 송화평\n");
    printf("학     번: 2014-15703\n");

    printf(ANSI_COLOR_RESET);
    printf("\n");
    /* Project 1 ends */

    kinit();         // physical page allocator
    kvminit();       // create kernel page table
    kvminithart();   // turn on paging
    procinit();      // process table
    trapinit();      // trap vectors
    trapinithart();  // install kernel trap vector
    plicinit();      // set up interrupt controller
    plicinithart();  // ask PLIC for device interrupts
    binit();         // buffer cache
    iinit();         // inode cache
    fileinit();      // file table
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
      ;
    __sync_synchronize();
    printf("hart %d starting\n", cpuid());
    kvminithart();    // turn on paging
    trapinithart();   // install kernel trap vector
    plicinithart();   // ask PLIC for device interrupts
  }

  scheduler();        
}
