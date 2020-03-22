
user/initcode.o:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <start>:
#include "syscall.h"

# exec(init, argv)
.globl start
start:
        la a0, init
   0:	00000517          	auipc	a0,0x0
   4:	00050513          	mv	a0,a0

0000000000000008 <.L0 >:
        la a1, argv
   8:	00000597          	auipc	a1,0x0
   c:	00058593          	mv	a1,a1

0000000000000010 <.L0 >:
        li a7, SYS_exec
  10:	489d                	li	a7,7

0000000000000012 <.L0 >:
        ecall
  12:	00000073          	ecall

0000000000000016 <exit>:

# for(;;) exit();
exit:
        li a7, SYS_exit
  16:	4889                	li	a7,2

0000000000000018 <.L0 >:
        ecall
  18:	00000073          	ecall

000000000000001c <.L0 >:
        jal exit
  1c:	ffbff0ef          	jal	ra,16 <exit>

0000000000000020 <init>:
  20:	696e692f          	0x696e692f
  24:	0074                	addi	a3,sp,12
  26:	0100                	addi	s0,sp,128
	...

0000000000000029 <argv>:
	...

0000000000000031 <.L0 >:
  31:	0000                	unimp
	...
