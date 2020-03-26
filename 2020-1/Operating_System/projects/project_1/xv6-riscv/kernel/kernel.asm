
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	80010113          	addi	sp,sp,-2048 # 80009800 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	070000ef          	jal	ra,80000086 <start>

000000008000001a <junk>:
    8000001a:	a001                	j	8000001a <junk>

000000008000001c <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000026:	0037969b          	slliw	a3,a5,0x3
    8000002a:	02004737          	lui	a4,0x2004
    8000002e:	96ba                	add	a3,a3,a4
    80000030:	0200c737          	lui	a4,0x200c
    80000034:	ff873603          	ld	a2,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80000038:	000f4737          	lui	a4,0xf4
    8000003c:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80000040:	963a                	add	a2,a2,a4
    80000042:	e290                	sd	a2,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..3] : space for timervec to save registers.
  // scratch[4] : address of CLINT MTIMECMP register.
  // scratch[5] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &mscratch0[32 * id];
    80000044:	0057979b          	slliw	a5,a5,0x5
    80000048:	078e                	slli	a5,a5,0x3
    8000004a:	00009617          	auipc	a2,0x9
    8000004e:	fb660613          	addi	a2,a2,-74 # 80009000 <mscratch0>
    80000052:	97b2                	add	a5,a5,a2
  scratch[4] = CLINT_MTIMECMP(id);
    80000054:	f394                	sd	a3,32(a5)
  scratch[5] = interval;
    80000056:	f798                	sd	a4,40(a5)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000058:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000005c:	00006797          	auipc	a5,0x6
    80000060:	a0478793          	addi	a5,a5,-1532 # 80005a60 <timervec>
    80000064:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000068:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000006c:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000070:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80000074:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000078:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    8000007c:	30479073          	csrw	mie,a5
}
    80000080:	6422                	ld	s0,8(sp)
    80000082:	0141                	addi	sp,sp,16
    80000084:	8082                	ret

0000000080000086 <start>:
{
    80000086:	1141                	addi	sp,sp,-16
    80000088:	e406                	sd	ra,8(sp)
    8000008a:	e022                	sd	s0,0(sp)
    8000008c:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000008e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000092:	7779                	lui	a4,0xffffe
    80000094:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd87e3>
    80000098:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000009a:	6705                	lui	a4,0x1
    8000009c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a0:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a2:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000a6:	00001797          	auipc	a5,0x1
    800000aa:	c7a78793          	addi	a5,a5,-902 # 80000d20 <main>
    800000ae:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b2:	4781                	li	a5,0
    800000b4:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000b8:	67c1                	lui	a5,0x10
    800000ba:	17fd                	addi	a5,a5,-1
    800000bc:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c0:	30379073          	csrw	mideleg,a5
  timerinit();
    800000c4:	00000097          	auipc	ra,0x0
    800000c8:	f58080e7          	jalr	-168(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000cc:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000d0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000d2:	823e                	mv	tp,a5
  asm volatile("mret");
    800000d4:	30200073          	mret
}
    800000d8:	60a2                	ld	ra,8(sp)
    800000da:	6402                	ld	s0,0(sp)
    800000dc:	0141                	addi	sp,sp,16
    800000de:	8082                	ret

00000000800000e0 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    800000e0:	7119                	addi	sp,sp,-128
    800000e2:	fc86                	sd	ra,120(sp)
    800000e4:	f8a2                	sd	s0,112(sp)
    800000e6:	f4a6                	sd	s1,104(sp)
    800000e8:	f0ca                	sd	s2,96(sp)
    800000ea:	ecce                	sd	s3,88(sp)
    800000ec:	e8d2                	sd	s4,80(sp)
    800000ee:	e4d6                	sd	s5,72(sp)
    800000f0:	e0da                	sd	s6,64(sp)
    800000f2:	fc5e                	sd	s7,56(sp)
    800000f4:	f862                	sd	s8,48(sp)
    800000f6:	f466                	sd	s9,40(sp)
    800000f8:	f06a                	sd	s10,32(sp)
    800000fa:	ec6e                	sd	s11,24(sp)
    800000fc:	0100                	addi	s0,sp,128
    800000fe:	8b2a                	mv	s6,a0
    80000100:	8aae                	mv	s5,a1
    80000102:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000104:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80000108:	00011517          	auipc	a0,0x11
    8000010c:	6f850513          	addi	a0,a0,1784 # 80011800 <cons>
    80000110:	00001097          	auipc	ra,0x1
    80000114:	9c2080e7          	jalr	-1598(ra) # 80000ad2 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80000118:	00011497          	auipc	s1,0x11
    8000011c:	6e848493          	addi	s1,s1,1768 # 80011800 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80000120:	89a6                	mv	s3,s1
    80000122:	00011917          	auipc	s2,0x11
    80000126:	77690913          	addi	s2,s2,1910 # 80011898 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    8000012a:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000012c:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    8000012e:	4da9                	li	s11,10
  while(n > 0){
    80000130:	07405863          	blez	s4,800001a0 <consoleread+0xc0>
    while(cons.r == cons.w){
    80000134:	0984a783          	lw	a5,152(s1)
    80000138:	09c4a703          	lw	a4,156(s1)
    8000013c:	02f71463          	bne	a4,a5,80000164 <consoleread+0x84>
      if(myproc()->killed){
    80000140:	00002097          	auipc	ra,0x2
    80000144:	844080e7          	jalr	-1980(ra) # 80001984 <myproc>
    80000148:	591c                	lw	a5,48(a0)
    8000014a:	e7b5                	bnez	a5,800001b6 <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    8000014c:	85ce                	mv	a1,s3
    8000014e:	854a                	mv	a0,s2
    80000150:	00002097          	auipc	ra,0x2
    80000154:	fd6080e7          	jalr	-42(ra) # 80002126 <sleep>
    while(cons.r == cons.w){
    80000158:	0984a783          	lw	a5,152(s1)
    8000015c:	09c4a703          	lw	a4,156(s1)
    80000160:	fef700e3          	beq	a4,a5,80000140 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80000164:	0017871b          	addiw	a4,a5,1
    80000168:	08e4ac23          	sw	a4,152(s1)
    8000016c:	07f7f713          	andi	a4,a5,127
    80000170:	9726                	add	a4,a4,s1
    80000172:	01874703          	lbu	a4,24(a4)
    80000176:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    8000017a:	079c0663          	beq	s8,s9,800001e6 <consoleread+0x106>
    cbuf = c;
    8000017e:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000182:	4685                	li	a3,1
    80000184:	f8f40613          	addi	a2,s0,-113
    80000188:	85d6                	mv	a1,s5
    8000018a:	855a                	mv	a0,s6
    8000018c:	00002097          	auipc	ra,0x2
    80000190:	1fa080e7          	jalr	506(ra) # 80002386 <either_copyout>
    80000194:	01a50663          	beq	a0,s10,800001a0 <consoleread+0xc0>
    dst++;
    80000198:	0a85                	addi	s5,s5,1
    --n;
    8000019a:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    8000019c:	f9bc1ae3          	bne	s8,s11,80000130 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    800001a0:	00011517          	auipc	a0,0x11
    800001a4:	66050513          	addi	a0,a0,1632 # 80011800 <cons>
    800001a8:	00001097          	auipc	ra,0x1
    800001ac:	97e080e7          	jalr	-1666(ra) # 80000b26 <release>

  return target - n;
    800001b0:	414b853b          	subw	a0,s7,s4
    800001b4:	a811                	j	800001c8 <consoleread+0xe8>
        release(&cons.lock);
    800001b6:	00011517          	auipc	a0,0x11
    800001ba:	64a50513          	addi	a0,a0,1610 # 80011800 <cons>
    800001be:	00001097          	auipc	ra,0x1
    800001c2:	968080e7          	jalr	-1688(ra) # 80000b26 <release>
        return -1;
    800001c6:	557d                	li	a0,-1
}
    800001c8:	70e6                	ld	ra,120(sp)
    800001ca:	7446                	ld	s0,112(sp)
    800001cc:	74a6                	ld	s1,104(sp)
    800001ce:	7906                	ld	s2,96(sp)
    800001d0:	69e6                	ld	s3,88(sp)
    800001d2:	6a46                	ld	s4,80(sp)
    800001d4:	6aa6                	ld	s5,72(sp)
    800001d6:	6b06                	ld	s6,64(sp)
    800001d8:	7be2                	ld	s7,56(sp)
    800001da:	7c42                	ld	s8,48(sp)
    800001dc:	7ca2                	ld	s9,40(sp)
    800001de:	7d02                	ld	s10,32(sp)
    800001e0:	6de2                	ld	s11,24(sp)
    800001e2:	6109                	addi	sp,sp,128
    800001e4:	8082                	ret
      if(n < target){
    800001e6:	000a071b          	sext.w	a4,s4
    800001ea:	fb777be3          	bgeu	a4,s7,800001a0 <consoleread+0xc0>
        cons.r--;
    800001ee:	00011717          	auipc	a4,0x11
    800001f2:	6af72523          	sw	a5,1706(a4) # 80011898 <cons+0x98>
    800001f6:	b76d                	j	800001a0 <consoleread+0xc0>

00000000800001f8 <consputc>:
  if(panicked){
    800001f8:	00026797          	auipc	a5,0x26
    800001fc:	e087a783          	lw	a5,-504(a5) # 80026000 <panicked>
    80000200:	c391                	beqz	a5,80000204 <consputc+0xc>
    for(;;)
    80000202:	a001                	j	80000202 <consputc+0xa>
{
    80000204:	1141                	addi	sp,sp,-16
    80000206:	e406                	sd	ra,8(sp)
    80000208:	e022                	sd	s0,0(sp)
    8000020a:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    8000020c:	10000793          	li	a5,256
    80000210:	00f50a63          	beq	a0,a5,80000224 <consputc+0x2c>
    uartputc(c);
    80000214:	00000097          	auipc	ra,0x0
    80000218:	5d2080e7          	jalr	1490(ra) # 800007e6 <uartputc>
}
    8000021c:	60a2                	ld	ra,8(sp)
    8000021e:	6402                	ld	s0,0(sp)
    80000220:	0141                	addi	sp,sp,16
    80000222:	8082                	ret
    uartputc('\b'); uartputc(' '); uartputc('\b');
    80000224:	4521                	li	a0,8
    80000226:	00000097          	auipc	ra,0x0
    8000022a:	5c0080e7          	jalr	1472(ra) # 800007e6 <uartputc>
    8000022e:	02000513          	li	a0,32
    80000232:	00000097          	auipc	ra,0x0
    80000236:	5b4080e7          	jalr	1460(ra) # 800007e6 <uartputc>
    8000023a:	4521                	li	a0,8
    8000023c:	00000097          	auipc	ra,0x0
    80000240:	5aa080e7          	jalr	1450(ra) # 800007e6 <uartputc>
    80000244:	bfe1                	j	8000021c <consputc+0x24>

0000000080000246 <consolewrite>:
{
    80000246:	715d                	addi	sp,sp,-80
    80000248:	e486                	sd	ra,72(sp)
    8000024a:	e0a2                	sd	s0,64(sp)
    8000024c:	fc26                	sd	s1,56(sp)
    8000024e:	f84a                	sd	s2,48(sp)
    80000250:	f44e                	sd	s3,40(sp)
    80000252:	f052                	sd	s4,32(sp)
    80000254:	ec56                	sd	s5,24(sp)
    80000256:	0880                	addi	s0,sp,80
    80000258:	89aa                	mv	s3,a0
    8000025a:	84ae                	mv	s1,a1
    8000025c:	8ab2                	mv	s5,a2
  acquire(&cons.lock);
    8000025e:	00011517          	auipc	a0,0x11
    80000262:	5a250513          	addi	a0,a0,1442 # 80011800 <cons>
    80000266:	00001097          	auipc	ra,0x1
    8000026a:	86c080e7          	jalr	-1940(ra) # 80000ad2 <acquire>
  for(i = 0; i < n; i++){
    8000026e:	03505e63          	blez	s5,800002aa <consolewrite+0x64>
    80000272:	00148913          	addi	s2,s1,1
    80000276:	fffa879b          	addiw	a5,s5,-1
    8000027a:	1782                	slli	a5,a5,0x20
    8000027c:	9381                	srli	a5,a5,0x20
    8000027e:	993e                	add	s2,s2,a5
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000280:	5a7d                	li	s4,-1
    80000282:	4685                	li	a3,1
    80000284:	8626                	mv	a2,s1
    80000286:	85ce                	mv	a1,s3
    80000288:	fbf40513          	addi	a0,s0,-65
    8000028c:	00002097          	auipc	ra,0x2
    80000290:	150080e7          	jalr	336(ra) # 800023dc <either_copyin>
    80000294:	01450b63          	beq	a0,s4,800002aa <consolewrite+0x64>
    consputc(c);
    80000298:	fbf44503          	lbu	a0,-65(s0)
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	f5c080e7          	jalr	-164(ra) # 800001f8 <consputc>
  for(i = 0; i < n; i++){
    800002a4:	0485                	addi	s1,s1,1
    800002a6:	fd249ee3          	bne	s1,s2,80000282 <consolewrite+0x3c>
  release(&cons.lock);
    800002aa:	00011517          	auipc	a0,0x11
    800002ae:	55650513          	addi	a0,a0,1366 # 80011800 <cons>
    800002b2:	00001097          	auipc	ra,0x1
    800002b6:	874080e7          	jalr	-1932(ra) # 80000b26 <release>
}
    800002ba:	8556                	mv	a0,s5
    800002bc:	60a6                	ld	ra,72(sp)
    800002be:	6406                	ld	s0,64(sp)
    800002c0:	74e2                	ld	s1,56(sp)
    800002c2:	7942                	ld	s2,48(sp)
    800002c4:	79a2                	ld	s3,40(sp)
    800002c6:	7a02                	ld	s4,32(sp)
    800002c8:	6ae2                	ld	s5,24(sp)
    800002ca:	6161                	addi	sp,sp,80
    800002cc:	8082                	ret

00000000800002ce <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002ce:	1101                	addi	sp,sp,-32
    800002d0:	ec06                	sd	ra,24(sp)
    800002d2:	e822                	sd	s0,16(sp)
    800002d4:	e426                	sd	s1,8(sp)
    800002d6:	e04a                	sd	s2,0(sp)
    800002d8:	1000                	addi	s0,sp,32
    800002da:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002dc:	00011517          	auipc	a0,0x11
    800002e0:	52450513          	addi	a0,a0,1316 # 80011800 <cons>
    800002e4:	00000097          	auipc	ra,0x0
    800002e8:	7ee080e7          	jalr	2030(ra) # 80000ad2 <acquire>

  switch(c){
    800002ec:	47d5                	li	a5,21
    800002ee:	0af48663          	beq	s1,a5,8000039a <consoleintr+0xcc>
    800002f2:	0297ca63          	blt	a5,s1,80000326 <consoleintr+0x58>
    800002f6:	47a1                	li	a5,8
    800002f8:	0ef48763          	beq	s1,a5,800003e6 <consoleintr+0x118>
    800002fc:	47c1                	li	a5,16
    800002fe:	10f49a63          	bne	s1,a5,80000412 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80000302:	00002097          	auipc	ra,0x2
    80000306:	130080e7          	jalr	304(ra) # 80002432 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000030a:	00011517          	auipc	a0,0x11
    8000030e:	4f650513          	addi	a0,a0,1270 # 80011800 <cons>
    80000312:	00001097          	auipc	ra,0x1
    80000316:	814080e7          	jalr	-2028(ra) # 80000b26 <release>
}
    8000031a:	60e2                	ld	ra,24(sp)
    8000031c:	6442                	ld	s0,16(sp)
    8000031e:	64a2                	ld	s1,8(sp)
    80000320:	6902                	ld	s2,0(sp)
    80000322:	6105                	addi	sp,sp,32
    80000324:	8082                	ret
  switch(c){
    80000326:	07f00793          	li	a5,127
    8000032a:	0af48e63          	beq	s1,a5,800003e6 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000032e:	00011717          	auipc	a4,0x11
    80000332:	4d270713          	addi	a4,a4,1234 # 80011800 <cons>
    80000336:	0a072783          	lw	a5,160(a4)
    8000033a:	09872703          	lw	a4,152(a4)
    8000033e:	9f99                	subw	a5,a5,a4
    80000340:	07f00713          	li	a4,127
    80000344:	fcf763e3          	bltu	a4,a5,8000030a <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000348:	47b5                	li	a5,13
    8000034a:	0cf48763          	beq	s1,a5,80000418 <consoleintr+0x14a>
      consputc(c);
    8000034e:	8526                	mv	a0,s1
    80000350:	00000097          	auipc	ra,0x0
    80000354:	ea8080e7          	jalr	-344(ra) # 800001f8 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000358:	00011797          	auipc	a5,0x11
    8000035c:	4a878793          	addi	a5,a5,1192 # 80011800 <cons>
    80000360:	0a07a703          	lw	a4,160(a5)
    80000364:	0017069b          	addiw	a3,a4,1
    80000368:	0006861b          	sext.w	a2,a3
    8000036c:	0ad7a023          	sw	a3,160(a5)
    80000370:	07f77713          	andi	a4,a4,127
    80000374:	97ba                	add	a5,a5,a4
    80000376:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000037a:	47a9                	li	a5,10
    8000037c:	0cf48563          	beq	s1,a5,80000446 <consoleintr+0x178>
    80000380:	4791                	li	a5,4
    80000382:	0cf48263          	beq	s1,a5,80000446 <consoleintr+0x178>
    80000386:	00011797          	auipc	a5,0x11
    8000038a:	5127a783          	lw	a5,1298(a5) # 80011898 <cons+0x98>
    8000038e:	0807879b          	addiw	a5,a5,128
    80000392:	f6f61ce3          	bne	a2,a5,8000030a <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000396:	863e                	mv	a2,a5
    80000398:	a07d                	j	80000446 <consoleintr+0x178>
    while(cons.e != cons.w &&
    8000039a:	00011717          	auipc	a4,0x11
    8000039e:	46670713          	addi	a4,a4,1126 # 80011800 <cons>
    800003a2:	0a072783          	lw	a5,160(a4)
    800003a6:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003aa:	00011497          	auipc	s1,0x11
    800003ae:	45648493          	addi	s1,s1,1110 # 80011800 <cons>
    while(cons.e != cons.w &&
    800003b2:	4929                	li	s2,10
    800003b4:	f4f70be3          	beq	a4,a5,8000030a <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003b8:	37fd                	addiw	a5,a5,-1
    800003ba:	07f7f713          	andi	a4,a5,127
    800003be:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003c0:	01874703          	lbu	a4,24(a4)
    800003c4:	f52703e3          	beq	a4,s2,8000030a <consoleintr+0x3c>
      cons.e--;
    800003c8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003cc:	10000513          	li	a0,256
    800003d0:	00000097          	auipc	ra,0x0
    800003d4:	e28080e7          	jalr	-472(ra) # 800001f8 <consputc>
    while(cons.e != cons.w &&
    800003d8:	0a04a783          	lw	a5,160(s1)
    800003dc:	09c4a703          	lw	a4,156(s1)
    800003e0:	fcf71ce3          	bne	a4,a5,800003b8 <consoleintr+0xea>
    800003e4:	b71d                	j	8000030a <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003e6:	00011717          	auipc	a4,0x11
    800003ea:	41a70713          	addi	a4,a4,1050 # 80011800 <cons>
    800003ee:	0a072783          	lw	a5,160(a4)
    800003f2:	09c72703          	lw	a4,156(a4)
    800003f6:	f0f70ae3          	beq	a4,a5,8000030a <consoleintr+0x3c>
      cons.e--;
    800003fa:	37fd                	addiw	a5,a5,-1
    800003fc:	00011717          	auipc	a4,0x11
    80000400:	4af72223          	sw	a5,1188(a4) # 800118a0 <cons+0xa0>
      consputc(BACKSPACE);
    80000404:	10000513          	li	a0,256
    80000408:	00000097          	auipc	ra,0x0
    8000040c:	df0080e7          	jalr	-528(ra) # 800001f8 <consputc>
    80000410:	bded                	j	8000030a <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000412:	ee048ce3          	beqz	s1,8000030a <consoleintr+0x3c>
    80000416:	bf21                	j	8000032e <consoleintr+0x60>
      consputc(c);
    80000418:	4529                	li	a0,10
    8000041a:	00000097          	auipc	ra,0x0
    8000041e:	dde080e7          	jalr	-546(ra) # 800001f8 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000422:	00011797          	auipc	a5,0x11
    80000426:	3de78793          	addi	a5,a5,990 # 80011800 <cons>
    8000042a:	0a07a703          	lw	a4,160(a5)
    8000042e:	0017069b          	addiw	a3,a4,1
    80000432:	0006861b          	sext.w	a2,a3
    80000436:	0ad7a023          	sw	a3,160(a5)
    8000043a:	07f77713          	andi	a4,a4,127
    8000043e:	97ba                	add	a5,a5,a4
    80000440:	4729                	li	a4,10
    80000442:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000446:	00011797          	auipc	a5,0x11
    8000044a:	44c7ab23          	sw	a2,1110(a5) # 8001189c <cons+0x9c>
        wakeup(&cons.r);
    8000044e:	00011517          	auipc	a0,0x11
    80000452:	44a50513          	addi	a0,a0,1098 # 80011898 <cons+0x98>
    80000456:	00002097          	auipc	ra,0x2
    8000045a:	e56080e7          	jalr	-426(ra) # 800022ac <wakeup>
    8000045e:	b575                	j	8000030a <consoleintr+0x3c>

0000000080000460 <consoleinit>:

void
consoleinit(void)
{
    80000460:	1141                	addi	sp,sp,-16
    80000462:	e406                	sd	ra,8(sp)
    80000464:	e022                	sd	s0,0(sp)
    80000466:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000468:	00007597          	auipc	a1,0x7
    8000046c:	cb058593          	addi	a1,a1,-848 # 80007118 <userret+0x88>
    80000470:	00011517          	auipc	a0,0x11
    80000474:	39050513          	addi	a0,a0,912 # 80011800 <cons>
    80000478:	00000097          	auipc	ra,0x0
    8000047c:	548080e7          	jalr	1352(ra) # 800009c0 <initlock>

  uartinit();
    80000480:	00000097          	auipc	ra,0x0
    80000484:	330080e7          	jalr	816(ra) # 800007b0 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000488:	00021797          	auipc	a5,0x21
    8000048c:	5b878793          	addi	a5,a5,1464 # 80021a40 <devsw>
    80000490:	00000717          	auipc	a4,0x0
    80000494:	c5070713          	addi	a4,a4,-944 # 800000e0 <consoleread>
    80000498:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000049a:	00000717          	auipc	a4,0x0
    8000049e:	dac70713          	addi	a4,a4,-596 # 80000246 <consolewrite>
    800004a2:	ef98                	sd	a4,24(a5)
}
    800004a4:	60a2                	ld	ra,8(sp)
    800004a6:	6402                	ld	s0,0(sp)
    800004a8:	0141                	addi	sp,sp,16
    800004aa:	8082                	ret

00000000800004ac <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800004ac:	7179                	addi	sp,sp,-48
    800004ae:	f406                	sd	ra,40(sp)
    800004b0:	f022                	sd	s0,32(sp)
    800004b2:	ec26                	sd	s1,24(sp)
    800004b4:	e84a                	sd	s2,16(sp)
    800004b6:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004b8:	c219                	beqz	a2,800004be <printint+0x12>
    800004ba:	08054663          	bltz	a0,80000546 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800004be:	2501                	sext.w	a0,a0
    800004c0:	4881                	li	a7,0
    800004c2:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004c6:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004c8:	2581                	sext.w	a1,a1
    800004ca:	00007617          	auipc	a2,0x7
    800004ce:	6be60613          	addi	a2,a2,1726 # 80007b88 <digits>
    800004d2:	883a                	mv	a6,a4
    800004d4:	2705                	addiw	a4,a4,1
    800004d6:	02b577bb          	remuw	a5,a0,a1
    800004da:	1782                	slli	a5,a5,0x20
    800004dc:	9381                	srli	a5,a5,0x20
    800004de:	97b2                	add	a5,a5,a2
    800004e0:	0007c783          	lbu	a5,0(a5)
    800004e4:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004e8:	0005079b          	sext.w	a5,a0
    800004ec:	02b5553b          	divuw	a0,a0,a1
    800004f0:	0685                	addi	a3,a3,1
    800004f2:	feb7f0e3          	bgeu	a5,a1,800004d2 <printint+0x26>

  if(sign)
    800004f6:	00088b63          	beqz	a7,8000050c <printint+0x60>
    buf[i++] = '-';
    800004fa:	fe040793          	addi	a5,s0,-32
    800004fe:	973e                	add	a4,a4,a5
    80000500:	02d00793          	li	a5,45
    80000504:	fef70823          	sb	a5,-16(a4)
    80000508:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    8000050c:	02e05763          	blez	a4,8000053a <printint+0x8e>
    80000510:	fd040793          	addi	a5,s0,-48
    80000514:	00e784b3          	add	s1,a5,a4
    80000518:	fff78913          	addi	s2,a5,-1
    8000051c:	993a                	add	s2,s2,a4
    8000051e:	377d                	addiw	a4,a4,-1
    80000520:	1702                	slli	a4,a4,0x20
    80000522:	9301                	srli	a4,a4,0x20
    80000524:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000528:	fff4c503          	lbu	a0,-1(s1)
    8000052c:	00000097          	auipc	ra,0x0
    80000530:	ccc080e7          	jalr	-820(ra) # 800001f8 <consputc>
  while(--i >= 0)
    80000534:	14fd                	addi	s1,s1,-1
    80000536:	ff2499e3          	bne	s1,s2,80000528 <printint+0x7c>
}
    8000053a:	70a2                	ld	ra,40(sp)
    8000053c:	7402                	ld	s0,32(sp)
    8000053e:	64e2                	ld	s1,24(sp)
    80000540:	6942                	ld	s2,16(sp)
    80000542:	6145                	addi	sp,sp,48
    80000544:	8082                	ret
    x = -xx;
    80000546:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000054a:	4885                	li	a7,1
    x = -xx;
    8000054c:	bf9d                	j	800004c2 <printint+0x16>

000000008000054e <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000054e:	1101                	addi	sp,sp,-32
    80000550:	ec06                	sd	ra,24(sp)
    80000552:	e822                	sd	s0,16(sp)
    80000554:	e426                	sd	s1,8(sp)
    80000556:	1000                	addi	s0,sp,32
    80000558:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000055a:	00011797          	auipc	a5,0x11
    8000055e:	3607a323          	sw	zero,870(a5) # 800118c0 <pr+0x18>
  printf("panic: ");
    80000562:	00007517          	auipc	a0,0x7
    80000566:	bbe50513          	addi	a0,a0,-1090 # 80007120 <userret+0x90>
    8000056a:	00000097          	auipc	ra,0x0
    8000056e:	02e080e7          	jalr	46(ra) # 80000598 <printf>
  printf(s);
    80000572:	8526                	mv	a0,s1
    80000574:	00000097          	auipc	ra,0x0
    80000578:	024080e7          	jalr	36(ra) # 80000598 <printf>
  printf("\n");
    8000057c:	00007517          	auipc	a0,0x7
    80000580:	fac50513          	addi	a0,a0,-84 # 80007528 <userret+0x498>
    80000584:	00000097          	auipc	ra,0x0
    80000588:	014080e7          	jalr	20(ra) # 80000598 <printf>
  panicked = 1; // freeze other CPUs
    8000058c:	4785                	li	a5,1
    8000058e:	00026717          	auipc	a4,0x26
    80000592:	a6f72923          	sw	a5,-1422(a4) # 80026000 <panicked>
  for(;;)
    80000596:	a001                	j	80000596 <panic+0x48>

0000000080000598 <printf>:
{
    80000598:	7131                	addi	sp,sp,-192
    8000059a:	fc86                	sd	ra,120(sp)
    8000059c:	f8a2                	sd	s0,112(sp)
    8000059e:	f4a6                	sd	s1,104(sp)
    800005a0:	f0ca                	sd	s2,96(sp)
    800005a2:	ecce                	sd	s3,88(sp)
    800005a4:	e8d2                	sd	s4,80(sp)
    800005a6:	e4d6                	sd	s5,72(sp)
    800005a8:	e0da                	sd	s6,64(sp)
    800005aa:	fc5e                	sd	s7,56(sp)
    800005ac:	f862                	sd	s8,48(sp)
    800005ae:	f466                	sd	s9,40(sp)
    800005b0:	f06a                	sd	s10,32(sp)
    800005b2:	ec6e                	sd	s11,24(sp)
    800005b4:	0100                	addi	s0,sp,128
    800005b6:	8a2a                	mv	s4,a0
    800005b8:	e40c                	sd	a1,8(s0)
    800005ba:	e810                	sd	a2,16(s0)
    800005bc:	ec14                	sd	a3,24(s0)
    800005be:	f018                	sd	a4,32(s0)
    800005c0:	f41c                	sd	a5,40(s0)
    800005c2:	03043823          	sd	a6,48(s0)
    800005c6:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005ca:	00011d97          	auipc	s11,0x11
    800005ce:	2f6dad83          	lw	s11,758(s11) # 800118c0 <pr+0x18>
  if(locking)
    800005d2:	020d9b63          	bnez	s11,80000608 <printf+0x70>
  if (fmt == 0)
    800005d6:	040a0263          	beqz	s4,8000061a <printf+0x82>
  va_start(ap, fmt);
    800005da:	00840793          	addi	a5,s0,8
    800005de:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005e2:	000a4503          	lbu	a0,0(s4)
    800005e6:	16050263          	beqz	a0,8000074a <printf+0x1b2>
    800005ea:	4481                	li	s1,0
    if(c != '%'){
    800005ec:	02500a93          	li	s5,37
    switch(c){
    800005f0:	07000b13          	li	s6,112
  consputc('x');
    800005f4:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005f6:	00007b97          	auipc	s7,0x7
    800005fa:	592b8b93          	addi	s7,s7,1426 # 80007b88 <digits>
    switch(c){
    800005fe:	07300c93          	li	s9,115
    80000602:	06400c13          	li	s8,100
    80000606:	a82d                	j	80000640 <printf+0xa8>
    acquire(&pr.lock);
    80000608:	00011517          	auipc	a0,0x11
    8000060c:	2a050513          	addi	a0,a0,672 # 800118a8 <pr>
    80000610:	00000097          	auipc	ra,0x0
    80000614:	4c2080e7          	jalr	1218(ra) # 80000ad2 <acquire>
    80000618:	bf7d                	j	800005d6 <printf+0x3e>
    panic("null fmt");
    8000061a:	00007517          	auipc	a0,0x7
    8000061e:	b1650513          	addi	a0,a0,-1258 # 80007130 <userret+0xa0>
    80000622:	00000097          	auipc	ra,0x0
    80000626:	f2c080e7          	jalr	-212(ra) # 8000054e <panic>
      consputc(c);
    8000062a:	00000097          	auipc	ra,0x0
    8000062e:	bce080e7          	jalr	-1074(ra) # 800001f8 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000632:	2485                	addiw	s1,s1,1
    80000634:	009a07b3          	add	a5,s4,s1
    80000638:	0007c503          	lbu	a0,0(a5)
    8000063c:	10050763          	beqz	a0,8000074a <printf+0x1b2>
    if(c != '%'){
    80000640:	ff5515e3          	bne	a0,s5,8000062a <printf+0x92>
    c = fmt[++i] & 0xff;
    80000644:	2485                	addiw	s1,s1,1
    80000646:	009a07b3          	add	a5,s4,s1
    8000064a:	0007c783          	lbu	a5,0(a5)
    8000064e:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80000652:	cfe5                	beqz	a5,8000074a <printf+0x1b2>
    switch(c){
    80000654:	05678a63          	beq	a5,s6,800006a8 <printf+0x110>
    80000658:	02fb7663          	bgeu	s6,a5,80000684 <printf+0xec>
    8000065c:	09978963          	beq	a5,s9,800006ee <printf+0x156>
    80000660:	07800713          	li	a4,120
    80000664:	0ce79863          	bne	a5,a4,80000734 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80000668:	f8843783          	ld	a5,-120(s0)
    8000066c:	00878713          	addi	a4,a5,8
    80000670:	f8e43423          	sd	a4,-120(s0)
    80000674:	4605                	li	a2,1
    80000676:	85ea                	mv	a1,s10
    80000678:	4388                	lw	a0,0(a5)
    8000067a:	00000097          	auipc	ra,0x0
    8000067e:	e32080e7          	jalr	-462(ra) # 800004ac <printint>
      break;
    80000682:	bf45                	j	80000632 <printf+0x9a>
    switch(c){
    80000684:	0b578263          	beq	a5,s5,80000728 <printf+0x190>
    80000688:	0b879663          	bne	a5,s8,80000734 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    8000068c:	f8843783          	ld	a5,-120(s0)
    80000690:	00878713          	addi	a4,a5,8
    80000694:	f8e43423          	sd	a4,-120(s0)
    80000698:	4605                	li	a2,1
    8000069a:	45a9                	li	a1,10
    8000069c:	4388                	lw	a0,0(a5)
    8000069e:	00000097          	auipc	ra,0x0
    800006a2:	e0e080e7          	jalr	-498(ra) # 800004ac <printint>
      break;
    800006a6:	b771                	j	80000632 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    800006a8:	f8843783          	ld	a5,-120(s0)
    800006ac:	00878713          	addi	a4,a5,8
    800006b0:	f8e43423          	sd	a4,-120(s0)
    800006b4:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800006b8:	03000513          	li	a0,48
    800006bc:	00000097          	auipc	ra,0x0
    800006c0:	b3c080e7          	jalr	-1220(ra) # 800001f8 <consputc>
  consputc('x');
    800006c4:	07800513          	li	a0,120
    800006c8:	00000097          	auipc	ra,0x0
    800006cc:	b30080e7          	jalr	-1232(ra) # 800001f8 <consputc>
    800006d0:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006d2:	03c9d793          	srli	a5,s3,0x3c
    800006d6:	97de                	add	a5,a5,s7
    800006d8:	0007c503          	lbu	a0,0(a5)
    800006dc:	00000097          	auipc	ra,0x0
    800006e0:	b1c080e7          	jalr	-1252(ra) # 800001f8 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006e4:	0992                	slli	s3,s3,0x4
    800006e6:	397d                	addiw	s2,s2,-1
    800006e8:	fe0915e3          	bnez	s2,800006d2 <printf+0x13a>
    800006ec:	b799                	j	80000632 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006ee:	f8843783          	ld	a5,-120(s0)
    800006f2:	00878713          	addi	a4,a5,8
    800006f6:	f8e43423          	sd	a4,-120(s0)
    800006fa:	0007b903          	ld	s2,0(a5)
    800006fe:	00090e63          	beqz	s2,8000071a <printf+0x182>
      for(; *s; s++)
    80000702:	00094503          	lbu	a0,0(s2)
    80000706:	d515                	beqz	a0,80000632 <printf+0x9a>
        consputc(*s);
    80000708:	00000097          	auipc	ra,0x0
    8000070c:	af0080e7          	jalr	-1296(ra) # 800001f8 <consputc>
      for(; *s; s++)
    80000710:	0905                	addi	s2,s2,1
    80000712:	00094503          	lbu	a0,0(s2)
    80000716:	f96d                	bnez	a0,80000708 <printf+0x170>
    80000718:	bf29                	j	80000632 <printf+0x9a>
        s = "(null)";
    8000071a:	00007917          	auipc	s2,0x7
    8000071e:	a0e90913          	addi	s2,s2,-1522 # 80007128 <userret+0x98>
      for(; *s; s++)
    80000722:	02800513          	li	a0,40
    80000726:	b7cd                	j	80000708 <printf+0x170>
      consputc('%');
    80000728:	8556                	mv	a0,s5
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	ace080e7          	jalr	-1330(ra) # 800001f8 <consputc>
      break;
    80000732:	b701                	j	80000632 <printf+0x9a>
      consputc('%');
    80000734:	8556                	mv	a0,s5
    80000736:	00000097          	auipc	ra,0x0
    8000073a:	ac2080e7          	jalr	-1342(ra) # 800001f8 <consputc>
      consputc(c);
    8000073e:	854a                	mv	a0,s2
    80000740:	00000097          	auipc	ra,0x0
    80000744:	ab8080e7          	jalr	-1352(ra) # 800001f8 <consputc>
      break;
    80000748:	b5ed                	j	80000632 <printf+0x9a>
  if(locking)
    8000074a:	020d9163          	bnez	s11,8000076c <printf+0x1d4>
}
    8000074e:	70e6                	ld	ra,120(sp)
    80000750:	7446                	ld	s0,112(sp)
    80000752:	74a6                	ld	s1,104(sp)
    80000754:	7906                	ld	s2,96(sp)
    80000756:	69e6                	ld	s3,88(sp)
    80000758:	6a46                	ld	s4,80(sp)
    8000075a:	6aa6                	ld	s5,72(sp)
    8000075c:	6b06                	ld	s6,64(sp)
    8000075e:	7be2                	ld	s7,56(sp)
    80000760:	7c42                	ld	s8,48(sp)
    80000762:	7ca2                	ld	s9,40(sp)
    80000764:	7d02                	ld	s10,32(sp)
    80000766:	6de2                	ld	s11,24(sp)
    80000768:	6129                	addi	sp,sp,192
    8000076a:	8082                	ret
    release(&pr.lock);
    8000076c:	00011517          	auipc	a0,0x11
    80000770:	13c50513          	addi	a0,a0,316 # 800118a8 <pr>
    80000774:	00000097          	auipc	ra,0x0
    80000778:	3b2080e7          	jalr	946(ra) # 80000b26 <release>
}
    8000077c:	bfc9                	j	8000074e <printf+0x1b6>

000000008000077e <printfinit>:
    ;
}

void
printfinit(void)
{
    8000077e:	1101                	addi	sp,sp,-32
    80000780:	ec06                	sd	ra,24(sp)
    80000782:	e822                	sd	s0,16(sp)
    80000784:	e426                	sd	s1,8(sp)
    80000786:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000788:	00011497          	auipc	s1,0x11
    8000078c:	12048493          	addi	s1,s1,288 # 800118a8 <pr>
    80000790:	00007597          	auipc	a1,0x7
    80000794:	9b058593          	addi	a1,a1,-1616 # 80007140 <userret+0xb0>
    80000798:	8526                	mv	a0,s1
    8000079a:	00000097          	auipc	ra,0x0
    8000079e:	226080e7          	jalr	550(ra) # 800009c0 <initlock>
  pr.locking = 1;
    800007a2:	4785                	li	a5,1
    800007a4:	cc9c                	sw	a5,24(s1)
}
    800007a6:	60e2                	ld	ra,24(sp)
    800007a8:	6442                	ld	s0,16(sp)
    800007aa:	64a2                	ld	s1,8(sp)
    800007ac:	6105                	addi	sp,sp,32
    800007ae:	8082                	ret

00000000800007b0 <uartinit>:
#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))

void
uartinit(void)
{
    800007b0:	1141                	addi	sp,sp,-16
    800007b2:	e422                	sd	s0,8(sp)
    800007b4:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800007b6:	100007b7          	lui	a5,0x10000
    800007ba:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, 0x80);
    800007be:	f8000713          	li	a4,-128
    800007c2:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007c6:	470d                	li	a4,3
    800007c8:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007cc:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, 0x03);
    800007d0:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, 0x07);
    800007d4:	471d                	li	a4,7
    800007d6:	00e78123          	sb	a4,2(a5)

  // enable receive interrupts.
  WriteReg(IER, 0x01);
    800007da:	4705                	li	a4,1
    800007dc:	00e780a3          	sb	a4,1(a5)
}
    800007e0:	6422                	ld	s0,8(sp)
    800007e2:	0141                	addi	sp,sp,16
    800007e4:	8082                	ret

00000000800007e6 <uartputc>:

// write one output character to the UART.
void
uartputc(int c)
{
    800007e6:	1141                	addi	sp,sp,-16
    800007e8:	e422                	sd	s0,8(sp)
    800007ea:	0800                	addi	s0,sp,16
  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & (1 << 5)) == 0)
    800007ec:	10000737          	lui	a4,0x10000
    800007f0:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800007f4:	0ff7f793          	andi	a5,a5,255
    800007f8:	0207f793          	andi	a5,a5,32
    800007fc:	dbf5                	beqz	a5,800007f0 <uartputc+0xa>
    ;
  WriteReg(THR, c);
    800007fe:	0ff57513          	andi	a0,a0,255
    80000802:	100007b7          	lui	a5,0x10000
    80000806:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
}
    8000080a:	6422                	ld	s0,8(sp)
    8000080c:	0141                	addi	sp,sp,16
    8000080e:	8082                	ret

0000000080000810 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000810:	1141                	addi	sp,sp,-16
    80000812:	e422                	sd	s0,8(sp)
    80000814:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000816:	100007b7          	lui	a5,0x10000
    8000081a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000081e:	8b85                	andi	a5,a5,1
    80000820:	cb91                	beqz	a5,80000834 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000822:	100007b7          	lui	a5,0x10000
    80000826:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000082a:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    8000082e:	6422                	ld	s0,8(sp)
    80000830:	0141                	addi	sp,sp,16
    80000832:	8082                	ret
    return -1;
    80000834:	557d                	li	a0,-1
    80000836:	bfe5                	j	8000082e <uartgetc+0x1e>

0000000080000838 <uartintr>:

// trap.c calls here when the uart interrupts.
void
uartintr(void)
{
    80000838:	1101                	addi	sp,sp,-32
    8000083a:	ec06                	sd	ra,24(sp)
    8000083c:	e822                	sd	s0,16(sp)
    8000083e:	e426                	sd	s1,8(sp)
    80000840:	1000                	addi	s0,sp,32
  while(1){
    int c = uartgetc();
    if(c == -1)
    80000842:	54fd                	li	s1,-1
    int c = uartgetc();
    80000844:	00000097          	auipc	ra,0x0
    80000848:	fcc080e7          	jalr	-52(ra) # 80000810 <uartgetc>
    if(c == -1)
    8000084c:	00950763          	beq	a0,s1,8000085a <uartintr+0x22>
      break;
    consoleintr(c);
    80000850:	00000097          	auipc	ra,0x0
    80000854:	a7e080e7          	jalr	-1410(ra) # 800002ce <consoleintr>
  while(1){
    80000858:	b7f5                	j	80000844 <uartintr+0xc>
  }
}
    8000085a:	60e2                	ld	ra,24(sp)
    8000085c:	6442                	ld	s0,16(sp)
    8000085e:	64a2                	ld	s1,8(sp)
    80000860:	6105                	addi	sp,sp,32
    80000862:	8082                	ret

0000000080000864 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000864:	1101                	addi	sp,sp,-32
    80000866:	ec06                	sd	ra,24(sp)
    80000868:	e822                	sd	s0,16(sp)
    8000086a:	e426                	sd	s1,8(sp)
    8000086c:	e04a                	sd	s2,0(sp)
    8000086e:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000870:	03451793          	slli	a5,a0,0x34
    80000874:	ebb9                	bnez	a5,800008ca <kfree+0x66>
    80000876:	84aa                	mv	s1,a0
    80000878:	00025797          	auipc	a5,0x25
    8000087c:	7a478793          	addi	a5,a5,1956 # 8002601c <end>
    80000880:	04f56563          	bltu	a0,a5,800008ca <kfree+0x66>
    80000884:	47c5                	li	a5,17
    80000886:	07ee                	slli	a5,a5,0x1b
    80000888:	04f57163          	bgeu	a0,a5,800008ca <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000088c:	6605                	lui	a2,0x1
    8000088e:	4585                	li	a1,1
    80000890:	00000097          	auipc	ra,0x0
    80000894:	2de080e7          	jalr	734(ra) # 80000b6e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000898:	00011917          	auipc	s2,0x11
    8000089c:	03090913          	addi	s2,s2,48 # 800118c8 <kmem>
    800008a0:	854a                	mv	a0,s2
    800008a2:	00000097          	auipc	ra,0x0
    800008a6:	230080e7          	jalr	560(ra) # 80000ad2 <acquire>
  r->next = kmem.freelist;
    800008aa:	01893783          	ld	a5,24(s2)
    800008ae:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    800008b0:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    800008b4:	854a                	mv	a0,s2
    800008b6:	00000097          	auipc	ra,0x0
    800008ba:	270080e7          	jalr	624(ra) # 80000b26 <release>
}
    800008be:	60e2                	ld	ra,24(sp)
    800008c0:	6442                	ld	s0,16(sp)
    800008c2:	64a2                	ld	s1,8(sp)
    800008c4:	6902                	ld	s2,0(sp)
    800008c6:	6105                	addi	sp,sp,32
    800008c8:	8082                	ret
    panic("kfree");
    800008ca:	00007517          	auipc	a0,0x7
    800008ce:	87e50513          	addi	a0,a0,-1922 # 80007148 <userret+0xb8>
    800008d2:	00000097          	auipc	ra,0x0
    800008d6:	c7c080e7          	jalr	-900(ra) # 8000054e <panic>

00000000800008da <freerange>:
{
    800008da:	7179                	addi	sp,sp,-48
    800008dc:	f406                	sd	ra,40(sp)
    800008de:	f022                	sd	s0,32(sp)
    800008e0:	ec26                	sd	s1,24(sp)
    800008e2:	e84a                	sd	s2,16(sp)
    800008e4:	e44e                	sd	s3,8(sp)
    800008e6:	e052                	sd	s4,0(sp)
    800008e8:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800008ea:	6785                	lui	a5,0x1
    800008ec:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800008f0:	94aa                	add	s1,s1,a0
    800008f2:	757d                	lui	a0,0xfffff
    800008f4:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800008f6:	94be                	add	s1,s1,a5
    800008f8:	0095ee63          	bltu	a1,s1,80000914 <freerange+0x3a>
    800008fc:	892e                	mv	s2,a1
    kfree(p);
    800008fe:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000900:	6985                	lui	s3,0x1
    kfree(p);
    80000902:	01448533          	add	a0,s1,s4
    80000906:	00000097          	auipc	ra,0x0
    8000090a:	f5e080e7          	jalr	-162(ra) # 80000864 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000090e:	94ce                	add	s1,s1,s3
    80000910:	fe9979e3          	bgeu	s2,s1,80000902 <freerange+0x28>
}
    80000914:	70a2                	ld	ra,40(sp)
    80000916:	7402                	ld	s0,32(sp)
    80000918:	64e2                	ld	s1,24(sp)
    8000091a:	6942                	ld	s2,16(sp)
    8000091c:	69a2                	ld	s3,8(sp)
    8000091e:	6a02                	ld	s4,0(sp)
    80000920:	6145                	addi	sp,sp,48
    80000922:	8082                	ret

0000000080000924 <kinit>:
{
    80000924:	1141                	addi	sp,sp,-16
    80000926:	e406                	sd	ra,8(sp)
    80000928:	e022                	sd	s0,0(sp)
    8000092a:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    8000092c:	00007597          	auipc	a1,0x7
    80000930:	82458593          	addi	a1,a1,-2012 # 80007150 <userret+0xc0>
    80000934:	00011517          	auipc	a0,0x11
    80000938:	f9450513          	addi	a0,a0,-108 # 800118c8 <kmem>
    8000093c:	00000097          	auipc	ra,0x0
    80000940:	084080e7          	jalr	132(ra) # 800009c0 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000944:	45c5                	li	a1,17
    80000946:	05ee                	slli	a1,a1,0x1b
    80000948:	00025517          	auipc	a0,0x25
    8000094c:	6d450513          	addi	a0,a0,1748 # 8002601c <end>
    80000950:	00000097          	auipc	ra,0x0
    80000954:	f8a080e7          	jalr	-118(ra) # 800008da <freerange>
}
    80000958:	60a2                	ld	ra,8(sp)
    8000095a:	6402                	ld	s0,0(sp)
    8000095c:	0141                	addi	sp,sp,16
    8000095e:	8082                	ret

0000000080000960 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000960:	1101                	addi	sp,sp,-32
    80000962:	ec06                	sd	ra,24(sp)
    80000964:	e822                	sd	s0,16(sp)
    80000966:	e426                	sd	s1,8(sp)
    80000968:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000096a:	00011497          	auipc	s1,0x11
    8000096e:	f5e48493          	addi	s1,s1,-162 # 800118c8 <kmem>
    80000972:	8526                	mv	a0,s1
    80000974:	00000097          	auipc	ra,0x0
    80000978:	15e080e7          	jalr	350(ra) # 80000ad2 <acquire>
  r = kmem.freelist;
    8000097c:	6c84                	ld	s1,24(s1)
  if(r)
    8000097e:	c885                	beqz	s1,800009ae <kalloc+0x4e>
    kmem.freelist = r->next;
    80000980:	609c                	ld	a5,0(s1)
    80000982:	00011517          	auipc	a0,0x11
    80000986:	f4650513          	addi	a0,a0,-186 # 800118c8 <kmem>
    8000098a:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    8000098c:	00000097          	auipc	ra,0x0
    80000990:	19a080e7          	jalr	410(ra) # 80000b26 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000994:	6605                	lui	a2,0x1
    80000996:	4595                	li	a1,5
    80000998:	8526                	mv	a0,s1
    8000099a:	00000097          	auipc	ra,0x0
    8000099e:	1d4080e7          	jalr	468(ra) # 80000b6e <memset>
  return (void*)r;
}
    800009a2:	8526                	mv	a0,s1
    800009a4:	60e2                	ld	ra,24(sp)
    800009a6:	6442                	ld	s0,16(sp)
    800009a8:	64a2                	ld	s1,8(sp)
    800009aa:	6105                	addi	sp,sp,32
    800009ac:	8082                	ret
  release(&kmem.lock);
    800009ae:	00011517          	auipc	a0,0x11
    800009b2:	f1a50513          	addi	a0,a0,-230 # 800118c8 <kmem>
    800009b6:	00000097          	auipc	ra,0x0
    800009ba:	170080e7          	jalr	368(ra) # 80000b26 <release>
  if(r)
    800009be:	b7d5                	j	800009a2 <kalloc+0x42>

00000000800009c0 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800009c0:	1141                	addi	sp,sp,-16
    800009c2:	e422                	sd	s0,8(sp)
    800009c4:	0800                	addi	s0,sp,16
  lk->name = name;
    800009c6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800009c8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800009cc:	00053823          	sd	zero,16(a0)
}
    800009d0:	6422                	ld	s0,8(sp)
    800009d2:	0141                	addi	sp,sp,16
    800009d4:	8082                	ret

00000000800009d6 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800009d6:	1101                	addi	sp,sp,-32
    800009d8:	ec06                	sd	ra,24(sp)
    800009da:	e822                	sd	s0,16(sp)
    800009dc:	e426                	sd	s1,8(sp)
    800009de:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800009e0:	100024f3          	csrr	s1,sstatus
    800009e4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800009e8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800009ea:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800009ee:	00001097          	auipc	ra,0x1
    800009f2:	f7a080e7          	jalr	-134(ra) # 80001968 <mycpu>
    800009f6:	5d3c                	lw	a5,120(a0)
    800009f8:	cf89                	beqz	a5,80000a12 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800009fa:	00001097          	auipc	ra,0x1
    800009fe:	f6e080e7          	jalr	-146(ra) # 80001968 <mycpu>
    80000a02:	5d3c                	lw	a5,120(a0)
    80000a04:	2785                	addiw	a5,a5,1
    80000a06:	dd3c                	sw	a5,120(a0)
}
    80000a08:	60e2                	ld	ra,24(sp)
    80000a0a:	6442                	ld	s0,16(sp)
    80000a0c:	64a2                	ld	s1,8(sp)
    80000a0e:	6105                	addi	sp,sp,32
    80000a10:	8082                	ret
    mycpu()->intena = old;
    80000a12:	00001097          	auipc	ra,0x1
    80000a16:	f56080e7          	jalr	-170(ra) # 80001968 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000a1a:	8085                	srli	s1,s1,0x1
    80000a1c:	8885                	andi	s1,s1,1
    80000a1e:	dd64                	sw	s1,124(a0)
    80000a20:	bfe9                	j	800009fa <push_off+0x24>

0000000080000a22 <pop_off>:

void
pop_off(void)
{
    80000a22:	1141                	addi	sp,sp,-16
    80000a24:	e406                	sd	ra,8(sp)
    80000a26:	e022                	sd	s0,0(sp)
    80000a28:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000a2a:	00001097          	auipc	ra,0x1
    80000a2e:	f3e080e7          	jalr	-194(ra) # 80001968 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000a32:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000a36:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000a38:	ef8d                	bnez	a5,80000a72 <pop_off+0x50>
    panic("pop_off - interruptible");
  c->noff -= 1;
    80000a3a:	5d3c                	lw	a5,120(a0)
    80000a3c:	37fd                	addiw	a5,a5,-1
    80000a3e:	0007871b          	sext.w	a4,a5
    80000a42:	dd3c                	sw	a5,120(a0)
  if(c->noff < 0)
    80000a44:	02079693          	slli	a3,a5,0x20
    80000a48:	0206cd63          	bltz	a3,80000a82 <pop_off+0x60>
    panic("pop_off");
  if(c->noff == 0 && c->intena)
    80000a4c:	ef19                	bnez	a4,80000a6a <pop_off+0x48>
    80000a4e:	5d7c                	lw	a5,124(a0)
    80000a50:	cf89                	beqz	a5,80000a6a <pop_off+0x48>
  asm volatile("csrr %0, sie" : "=r" (x) );
    80000a52:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80000a56:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80000a5a:	10479073          	csrw	sie,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000a5e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000a62:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000a66:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000a6a:	60a2                	ld	ra,8(sp)
    80000a6c:	6402                	ld	s0,0(sp)
    80000a6e:	0141                	addi	sp,sp,16
    80000a70:	8082                	ret
    panic("pop_off - interruptible");
    80000a72:	00006517          	auipc	a0,0x6
    80000a76:	6e650513          	addi	a0,a0,1766 # 80007158 <userret+0xc8>
    80000a7a:	00000097          	auipc	ra,0x0
    80000a7e:	ad4080e7          	jalr	-1324(ra) # 8000054e <panic>
    panic("pop_off");
    80000a82:	00006517          	auipc	a0,0x6
    80000a86:	6ee50513          	addi	a0,a0,1774 # 80007170 <userret+0xe0>
    80000a8a:	00000097          	auipc	ra,0x0
    80000a8e:	ac4080e7          	jalr	-1340(ra) # 8000054e <panic>

0000000080000a92 <holding>:
{
    80000a92:	1101                	addi	sp,sp,-32
    80000a94:	ec06                	sd	ra,24(sp)
    80000a96:	e822                	sd	s0,16(sp)
    80000a98:	e426                	sd	s1,8(sp)
    80000a9a:	1000                	addi	s0,sp,32
    80000a9c:	84aa                	mv	s1,a0
  push_off();
    80000a9e:	00000097          	auipc	ra,0x0
    80000aa2:	f38080e7          	jalr	-200(ra) # 800009d6 <push_off>
  r = (lk->locked && lk->cpu == mycpu());
    80000aa6:	409c                	lw	a5,0(s1)
    80000aa8:	ef81                	bnez	a5,80000ac0 <holding+0x2e>
    80000aaa:	4481                	li	s1,0
  pop_off();
    80000aac:	00000097          	auipc	ra,0x0
    80000ab0:	f76080e7          	jalr	-138(ra) # 80000a22 <pop_off>
}
    80000ab4:	8526                	mv	a0,s1
    80000ab6:	60e2                	ld	ra,24(sp)
    80000ab8:	6442                	ld	s0,16(sp)
    80000aba:	64a2                	ld	s1,8(sp)
    80000abc:	6105                	addi	sp,sp,32
    80000abe:	8082                	ret
  r = (lk->locked && lk->cpu == mycpu());
    80000ac0:	6884                	ld	s1,16(s1)
    80000ac2:	00001097          	auipc	ra,0x1
    80000ac6:	ea6080e7          	jalr	-346(ra) # 80001968 <mycpu>
    80000aca:	8c89                	sub	s1,s1,a0
    80000acc:	0014b493          	seqz	s1,s1
    80000ad0:	bff1                	j	80000aac <holding+0x1a>

0000000080000ad2 <acquire>:
{
    80000ad2:	1101                	addi	sp,sp,-32
    80000ad4:	ec06                	sd	ra,24(sp)
    80000ad6:	e822                	sd	s0,16(sp)
    80000ad8:	e426                	sd	s1,8(sp)
    80000ada:	1000                	addi	s0,sp,32
    80000adc:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000ade:	00000097          	auipc	ra,0x0
    80000ae2:	ef8080e7          	jalr	-264(ra) # 800009d6 <push_off>
  if(holding(lk))
    80000ae6:	8526                	mv	a0,s1
    80000ae8:	00000097          	auipc	ra,0x0
    80000aec:	faa080e7          	jalr	-86(ra) # 80000a92 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000af0:	4705                	li	a4,1
  if(holding(lk))
    80000af2:	e115                	bnez	a0,80000b16 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000af4:	87ba                	mv	a5,a4
    80000af6:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000afa:	2781                	sext.w	a5,a5
    80000afc:	ffe5                	bnez	a5,80000af4 <acquire+0x22>
  __sync_synchronize();
    80000afe:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000b02:	00001097          	auipc	ra,0x1
    80000b06:	e66080e7          	jalr	-410(ra) # 80001968 <mycpu>
    80000b0a:	e888                	sd	a0,16(s1)
}
    80000b0c:	60e2                	ld	ra,24(sp)
    80000b0e:	6442                	ld	s0,16(sp)
    80000b10:	64a2                	ld	s1,8(sp)
    80000b12:	6105                	addi	sp,sp,32
    80000b14:	8082                	ret
    panic("acquire");
    80000b16:	00006517          	auipc	a0,0x6
    80000b1a:	66250513          	addi	a0,a0,1634 # 80007178 <userret+0xe8>
    80000b1e:	00000097          	auipc	ra,0x0
    80000b22:	a30080e7          	jalr	-1488(ra) # 8000054e <panic>

0000000080000b26 <release>:
{
    80000b26:	1101                	addi	sp,sp,-32
    80000b28:	ec06                	sd	ra,24(sp)
    80000b2a:	e822                	sd	s0,16(sp)
    80000b2c:	e426                	sd	s1,8(sp)
    80000b2e:	1000                	addi	s0,sp,32
    80000b30:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000b32:	00000097          	auipc	ra,0x0
    80000b36:	f60080e7          	jalr	-160(ra) # 80000a92 <holding>
    80000b3a:	c115                	beqz	a0,80000b5e <release+0x38>
  lk->cpu = 0;
    80000b3c:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000b40:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000b44:	0f50000f          	fence	iorw,ow
    80000b48:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000b4c:	00000097          	auipc	ra,0x0
    80000b50:	ed6080e7          	jalr	-298(ra) # 80000a22 <pop_off>
}
    80000b54:	60e2                	ld	ra,24(sp)
    80000b56:	6442                	ld	s0,16(sp)
    80000b58:	64a2                	ld	s1,8(sp)
    80000b5a:	6105                	addi	sp,sp,32
    80000b5c:	8082                	ret
    panic("release");
    80000b5e:	00006517          	auipc	a0,0x6
    80000b62:	62250513          	addi	a0,a0,1570 # 80007180 <userret+0xf0>
    80000b66:	00000097          	auipc	ra,0x0
    80000b6a:	9e8080e7          	jalr	-1560(ra) # 8000054e <panic>

0000000080000b6e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000b6e:	1141                	addi	sp,sp,-16
    80000b70:	e422                	sd	s0,8(sp)
    80000b72:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000b74:	ce09                	beqz	a2,80000b8e <memset+0x20>
    80000b76:	87aa                	mv	a5,a0
    80000b78:	fff6071b          	addiw	a4,a2,-1
    80000b7c:	1702                	slli	a4,a4,0x20
    80000b7e:	9301                	srli	a4,a4,0x20
    80000b80:	0705                	addi	a4,a4,1
    80000b82:	972a                	add	a4,a4,a0
    cdst[i] = c;
    80000b84:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000b88:	0785                	addi	a5,a5,1
    80000b8a:	fee79de3          	bne	a5,a4,80000b84 <memset+0x16>
  }
  return dst;
}
    80000b8e:	6422                	ld	s0,8(sp)
    80000b90:	0141                	addi	sp,sp,16
    80000b92:	8082                	ret

0000000080000b94 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000b94:	1141                	addi	sp,sp,-16
    80000b96:	e422                	sd	s0,8(sp)
    80000b98:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000b9a:	ca05                	beqz	a2,80000bca <memcmp+0x36>
    80000b9c:	fff6069b          	addiw	a3,a2,-1
    80000ba0:	1682                	slli	a3,a3,0x20
    80000ba2:	9281                	srli	a3,a3,0x20
    80000ba4:	0685                	addi	a3,a3,1
    80000ba6:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000ba8:	00054783          	lbu	a5,0(a0)
    80000bac:	0005c703          	lbu	a4,0(a1)
    80000bb0:	00e79863          	bne	a5,a4,80000bc0 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000bb4:	0505                	addi	a0,a0,1
    80000bb6:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000bb8:	fed518e3          	bne	a0,a3,80000ba8 <memcmp+0x14>
  }

  return 0;
    80000bbc:	4501                	li	a0,0
    80000bbe:	a019                	j	80000bc4 <memcmp+0x30>
      return *s1 - *s2;
    80000bc0:	40e7853b          	subw	a0,a5,a4
}
    80000bc4:	6422                	ld	s0,8(sp)
    80000bc6:	0141                	addi	sp,sp,16
    80000bc8:	8082                	ret
  return 0;
    80000bca:	4501                	li	a0,0
    80000bcc:	bfe5                	j	80000bc4 <memcmp+0x30>

0000000080000bce <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000bce:	1141                	addi	sp,sp,-16
    80000bd0:	e422                	sd	s0,8(sp)
    80000bd2:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000bd4:	02a5e563          	bltu	a1,a0,80000bfe <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000bd8:	fff6069b          	addiw	a3,a2,-1
    80000bdc:	ce11                	beqz	a2,80000bf8 <memmove+0x2a>
    80000bde:	1682                	slli	a3,a3,0x20
    80000be0:	9281                	srli	a3,a3,0x20
    80000be2:	0685                	addi	a3,a3,1
    80000be4:	96ae                	add	a3,a3,a1
    80000be6:	87aa                	mv	a5,a0
      *d++ = *s++;
    80000be8:	0585                	addi	a1,a1,1
    80000bea:	0785                	addi	a5,a5,1
    80000bec:	fff5c703          	lbu	a4,-1(a1)
    80000bf0:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    80000bf4:	fed59ae3          	bne	a1,a3,80000be8 <memmove+0x1a>

  return dst;
}
    80000bf8:	6422                	ld	s0,8(sp)
    80000bfa:	0141                	addi	sp,sp,16
    80000bfc:	8082                	ret
  if(s < d && s + n > d){
    80000bfe:	02061713          	slli	a4,a2,0x20
    80000c02:	9301                	srli	a4,a4,0x20
    80000c04:	00e587b3          	add	a5,a1,a4
    80000c08:	fcf578e3          	bgeu	a0,a5,80000bd8 <memmove+0xa>
    d += n;
    80000c0c:	972a                	add	a4,a4,a0
    while(n-- > 0)
    80000c0e:	fff6069b          	addiw	a3,a2,-1
    80000c12:	d27d                	beqz	a2,80000bf8 <memmove+0x2a>
    80000c14:	02069613          	slli	a2,a3,0x20
    80000c18:	9201                	srli	a2,a2,0x20
    80000c1a:	fff64613          	not	a2,a2
    80000c1e:	963e                	add	a2,a2,a5
      *--d = *--s;
    80000c20:	17fd                	addi	a5,a5,-1
    80000c22:	177d                	addi	a4,a4,-1
    80000c24:	0007c683          	lbu	a3,0(a5)
    80000c28:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80000c2c:	fec79ae3          	bne	a5,a2,80000c20 <memmove+0x52>
    80000c30:	b7e1                	j	80000bf8 <memmove+0x2a>

0000000080000c32 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000c32:	1141                	addi	sp,sp,-16
    80000c34:	e406                	sd	ra,8(sp)
    80000c36:	e022                	sd	s0,0(sp)
    80000c38:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000c3a:	00000097          	auipc	ra,0x0
    80000c3e:	f94080e7          	jalr	-108(ra) # 80000bce <memmove>
}
    80000c42:	60a2                	ld	ra,8(sp)
    80000c44:	6402                	ld	s0,0(sp)
    80000c46:	0141                	addi	sp,sp,16
    80000c48:	8082                	ret

0000000080000c4a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000c4a:	1141                	addi	sp,sp,-16
    80000c4c:	e422                	sd	s0,8(sp)
    80000c4e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000c50:	ce11                	beqz	a2,80000c6c <strncmp+0x22>
    80000c52:	00054783          	lbu	a5,0(a0)
    80000c56:	cf89                	beqz	a5,80000c70 <strncmp+0x26>
    80000c58:	0005c703          	lbu	a4,0(a1)
    80000c5c:	00f71a63          	bne	a4,a5,80000c70 <strncmp+0x26>
    n--, p++, q++;
    80000c60:	367d                	addiw	a2,a2,-1
    80000c62:	0505                	addi	a0,a0,1
    80000c64:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000c66:	f675                	bnez	a2,80000c52 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000c68:	4501                	li	a0,0
    80000c6a:	a809                	j	80000c7c <strncmp+0x32>
    80000c6c:	4501                	li	a0,0
    80000c6e:	a039                	j	80000c7c <strncmp+0x32>
  if(n == 0)
    80000c70:	ca09                	beqz	a2,80000c82 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000c72:	00054503          	lbu	a0,0(a0)
    80000c76:	0005c783          	lbu	a5,0(a1)
    80000c7a:	9d1d                	subw	a0,a0,a5
}
    80000c7c:	6422                	ld	s0,8(sp)
    80000c7e:	0141                	addi	sp,sp,16
    80000c80:	8082                	ret
    return 0;
    80000c82:	4501                	li	a0,0
    80000c84:	bfe5                	j	80000c7c <strncmp+0x32>

0000000080000c86 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000c86:	1141                	addi	sp,sp,-16
    80000c88:	e422                	sd	s0,8(sp)
    80000c8a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000c8c:	872a                	mv	a4,a0
    80000c8e:	8832                	mv	a6,a2
    80000c90:	367d                	addiw	a2,a2,-1
    80000c92:	01005963          	blez	a6,80000ca4 <strncpy+0x1e>
    80000c96:	0705                	addi	a4,a4,1
    80000c98:	0005c783          	lbu	a5,0(a1)
    80000c9c:	fef70fa3          	sb	a5,-1(a4)
    80000ca0:	0585                	addi	a1,a1,1
    80000ca2:	f7f5                	bnez	a5,80000c8e <strncpy+0x8>
    ;
  while(n-- > 0)
    80000ca4:	86ba                	mv	a3,a4
    80000ca6:	00c05c63          	blez	a2,80000cbe <strncpy+0x38>
    *s++ = 0;
    80000caa:	0685                	addi	a3,a3,1
    80000cac:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000cb0:	fff6c793          	not	a5,a3
    80000cb4:	9fb9                	addw	a5,a5,a4
    80000cb6:	010787bb          	addw	a5,a5,a6
    80000cba:	fef048e3          	bgtz	a5,80000caa <strncpy+0x24>
  return os;
}
    80000cbe:	6422                	ld	s0,8(sp)
    80000cc0:	0141                	addi	sp,sp,16
    80000cc2:	8082                	ret

0000000080000cc4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000cc4:	1141                	addi	sp,sp,-16
    80000cc6:	e422                	sd	s0,8(sp)
    80000cc8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000cca:	02c05363          	blez	a2,80000cf0 <safestrcpy+0x2c>
    80000cce:	fff6069b          	addiw	a3,a2,-1
    80000cd2:	1682                	slli	a3,a3,0x20
    80000cd4:	9281                	srli	a3,a3,0x20
    80000cd6:	96ae                	add	a3,a3,a1
    80000cd8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000cda:	00d58963          	beq	a1,a3,80000cec <safestrcpy+0x28>
    80000cde:	0585                	addi	a1,a1,1
    80000ce0:	0785                	addi	a5,a5,1
    80000ce2:	fff5c703          	lbu	a4,-1(a1)
    80000ce6:	fee78fa3          	sb	a4,-1(a5)
    80000cea:	fb65                	bnez	a4,80000cda <safestrcpy+0x16>
    ;
  *s = 0;
    80000cec:	00078023          	sb	zero,0(a5)
  return os;
}
    80000cf0:	6422                	ld	s0,8(sp)
    80000cf2:	0141                	addi	sp,sp,16
    80000cf4:	8082                	ret

0000000080000cf6 <strlen>:

int
strlen(const char *s)
{
    80000cf6:	1141                	addi	sp,sp,-16
    80000cf8:	e422                	sd	s0,8(sp)
    80000cfa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000cfc:	00054783          	lbu	a5,0(a0)
    80000d00:	cf91                	beqz	a5,80000d1c <strlen+0x26>
    80000d02:	0505                	addi	a0,a0,1
    80000d04:	87aa                	mv	a5,a0
    80000d06:	4685                	li	a3,1
    80000d08:	9e89                	subw	a3,a3,a0
    80000d0a:	00f6853b          	addw	a0,a3,a5
    80000d0e:	0785                	addi	a5,a5,1
    80000d10:	fff7c703          	lbu	a4,-1(a5)
    80000d14:	fb7d                	bnez	a4,80000d0a <strlen+0x14>
    ;
  return n;
}
    80000d16:	6422                	ld	s0,8(sp)
    80000d18:	0141                	addi	sp,sp,16
    80000d1a:	8082                	ret
  for(n = 0; s[n]; n++)
    80000d1c:	4501                	li	a0,0
    80000d1e:	bfe5                	j	80000d16 <strlen+0x20>

0000000080000d20 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000d20:	1141                	addi	sp,sp,-16
    80000d22:	e406                	sd	ra,8(sp)
    80000d24:	e022                	sd	s0,0(sp)
    80000d26:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000d28:	00001097          	auipc	ra,0x1
    80000d2c:	c30080e7          	jalr	-976(ra) # 80001958 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000d30:	00025717          	auipc	a4,0x25
    80000d34:	2d470713          	addi	a4,a4,724 # 80026004 <started>
  if(cpuid() == 0){
    80000d38:	c139                	beqz	a0,80000d7e <main+0x5e>
    while(started == 0)
    80000d3a:	431c                	lw	a5,0(a4)
    80000d3c:	2781                	sext.w	a5,a5
    80000d3e:	dff5                	beqz	a5,80000d3a <main+0x1a>
      ;
    __sync_synchronize();
    80000d40:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000d44:	00001097          	auipc	ra,0x1
    80000d48:	c14080e7          	jalr	-1004(ra) # 80001958 <cpuid>
    80000d4c:	85aa                	mv	a1,a0
    80000d4e:	00006517          	auipc	a0,0x6
    80000d52:	7ca50513          	addi	a0,a0,1994 # 80007518 <userret+0x488>
    80000d56:	00000097          	auipc	ra,0x0
    80000d5a:	842080e7          	jalr	-1982(ra) # 80000598 <printf>
    kvminithart();    // turn on paging
    80000d5e:	00000097          	auipc	ra,0x0
    80000d62:	328080e7          	jalr	808(ra) # 80001086 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000d66:	00002097          	auipc	ra,0x2
    80000d6a:	80c080e7          	jalr	-2036(ra) # 80002572 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000d6e:	00005097          	auipc	ra,0x5
    80000d72:	d32080e7          	jalr	-718(ra) # 80005aa0 <plicinithart>
  }

  scheduler();        
    80000d76:	00001097          	auipc	ra,0x1
    80000d7a:	0e8080e7          	jalr	232(ra) # 80001e5e <scheduler>
    consoleinit();
    80000d7e:	fffff097          	auipc	ra,0xfffff
    80000d82:	6e2080e7          	jalr	1762(ra) # 80000460 <consoleinit>
    printfinit();
    80000d86:	00000097          	auipc	ra,0x0
    80000d8a:	9f8080e7          	jalr	-1544(ra) # 8000077e <printfinit>
    printf("\n");
    80000d8e:	00006517          	auipc	a0,0x6
    80000d92:	79a50513          	addi	a0,a0,1946 # 80007528 <userret+0x498>
    80000d96:	00000097          	auipc	ra,0x0
    80000d9a:	802080e7          	jalr	-2046(ra) # 80000598 <printf>
    printf("xv6 kernel is booting\n");
    80000d9e:	00006517          	auipc	a0,0x6
    80000da2:	3ea50513          	addi	a0,a0,1002 # 80007188 <userret+0xf8>
    80000da6:	fffff097          	auipc	ra,0xfffff
    80000daa:	7f2080e7          	jalr	2034(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RED);
    80000dae:	00006517          	auipc	a0,0x6
    80000db2:	3f250513          	addi	a0,a0,1010 # 800071a0 <userret+0x110>
    80000db6:	fffff097          	auipc	ra,0xfffff
    80000dba:	7e2080e7          	jalr	2018(ra) # 80000598 <printf>
    printf("\n");
    80000dbe:	00006517          	auipc	a0,0x6
    80000dc2:	76a50513          	addi	a0,a0,1898 # 80007528 <userret+0x498>
    80000dc6:	fffff097          	auipc	ra,0xfffff
    80000dca:	7d2080e7          	jalr	2002(ra) # 80000598 <printf>
    printf("\n");
    80000dce:	00006517          	auipc	a0,0x6
    80000dd2:	75a50513          	addi	a0,a0,1882 # 80007528 <userret+0x498>
    80000dd6:	fffff097          	auipc	ra,0xfffff
    80000dda:	7c2080e7          	jalr	1986(ra) # 80000598 <printf>
    printf("경애하는 ");
    80000dde:	00006517          	auipc	a0,0x6
    80000de2:	3ca50513          	addi	a0,a0,970 # 800071a8 <userret+0x118>
    80000de6:	fffff097          	auipc	ra,0xfffff
    80000dea:	7b2080e7          	jalr	1970(ra) # 80000598 <printf>
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    80000dee:	00006517          	auipc	a0,0x6
    80000df2:	3ca50513          	addi	a0,a0,970 # 800071b8 <userret+0x128>
    80000df6:	fffff097          	auipc	ra,0xfffff
    80000dfa:	7a2080e7          	jalr	1954(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RED" 교원 동지의 지도를 받아 제작된 -\n\n");
    80000dfe:	00006517          	auipc	a0,0x6
    80000e02:	3d250513          	addi	a0,a0,978 # 800071d0 <userret+0x140>
    80000e06:	fffff097          	auipc	ra,0xfffff
    80000e0a:	792080e7          	jalr	1938(ra) # 80000598 <printf>
    printf("\
    80000e0e:	00006517          	auipc	a0,0x6
    80000e12:	3fa50513          	addi	a0,a0,1018 # 80007208 <userret+0x178>
    80000e16:	fffff097          	auipc	ra,0xfffff
    80000e1a:	782080e7          	jalr	1922(ra) # 80000598 <printf>
    printf("\n\n");
    80000e1e:	00006517          	auipc	a0,0x6
    80000e22:	58250513          	addi	a0,a0,1410 # 800073a0 <userret+0x310>
    80000e26:	fffff097          	auipc	ra,0xfffff
    80000e2a:	772080e7          	jalr	1906(ra) # 80000598 <printf>
    printf(ANSI_COLOR_BOLD_RED);
    80000e2e:	00006517          	auipc	a0,0x6
    80000e32:	57a50513          	addi	a0,a0,1402 # 800073a8 <userret+0x318>
    80000e36:	fffff097          	auipc	ra,0xfffff
    80000e3a:	762080e7          	jalr	1890(ra) # 80000598 <printf>
    printf("\
    80000e3e:	00006517          	auipc	a0,0x6
    80000e42:	57a50513          	addi	a0,a0,1402 # 800073b8 <userret+0x328>
    80000e46:	fffff097          	auipc	ra,0xfffff
    80000e4a:	752080e7          	jalr	1874(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RESET);
    80000e4e:	00006517          	auipc	a0,0x6
    80000e52:	59250513          	addi	a0,a0,1426 # 800073e0 <userret+0x350>
    80000e56:	fffff097          	auipc	ra,0xfffff
    80000e5a:	742080e7          	jalr	1858(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RED);
    80000e5e:	00006517          	auipc	a0,0x6
    80000e62:	34250513          	addi	a0,a0,834 # 800071a0 <userret+0x110>
    80000e66:	fffff097          	auipc	ra,0xfffff
    80000e6a:	732080e7          	jalr	1842(ra) # 80000598 <printf>
    printf("\n\
    80000e6e:	00006517          	auipc	a0,0x6
    80000e72:	57a50513          	addi	a0,a0,1402 # 800073e8 <userret+0x358>
    80000e76:	fffff097          	auipc	ra,0xfffff
    80000e7a:	722080e7          	jalr	1826(ra) # 80000598 <printf>
    printf("\n");
    80000e7e:	00006517          	auipc	a0,0x6
    80000e82:	6aa50513          	addi	a0,a0,1706 # 80007528 <userret+0x498>
    80000e86:	fffff097          	auipc	ra,0xfffff
    80000e8a:	712080e7          	jalr	1810(ra) # 80000598 <printf>
    printf("본 조작체계는 운영체제 수업의 교원이신 ");
    80000e8e:	00006517          	auipc	a0,0x6
    80000e92:	58a50513          	addi	a0,a0,1418 # 80007418 <userret+0x388>
    80000e96:	fffff097          	auipc	ra,0xfffff
    80000e9a:	702080e7          	jalr	1794(ra) # 80000598 <printf>
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    80000e9e:	00006517          	auipc	a0,0x6
    80000ea2:	31a50513          	addi	a0,a0,794 # 800071b8 <userret+0x128>
    80000ea6:	fffff097          	auipc	ra,0xfffff
    80000eaa:	6f2080e7          	jalr	1778(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RED" 교원 동지의 개교 104년(2020년) 3월 19일 학생들에게 하달하신 교시에 의하여 제작되었다.\n\n");
    80000eae:	00006517          	auipc	a0,0x6
    80000eb2:	5aa50513          	addi	a0,a0,1450 # 80007458 <userret+0x3c8>
    80000eb6:	fffff097          	auipc	ra,0xfffff
    80000eba:	6e2080e7          	jalr	1762(ra) # 80000598 <printf>
    printf("만든 학생: 송화평\n");
    80000ebe:	00006517          	auipc	a0,0x6
    80000ec2:	61a50513          	addi	a0,a0,1562 # 800074d8 <userret+0x448>
    80000ec6:	fffff097          	auipc	ra,0xfffff
    80000eca:	6d2080e7          	jalr	1746(ra) # 80000598 <printf>
    printf("학     번: 2014-15703\n");
    80000ece:	00006517          	auipc	a0,0x6
    80000ed2:	62a50513          	addi	a0,a0,1578 # 800074f8 <userret+0x468>
    80000ed6:	fffff097          	auipc	ra,0xfffff
    80000eda:	6c2080e7          	jalr	1730(ra) # 80000598 <printf>
    printf(ANSI_COLOR_RESET);
    80000ede:	00006517          	auipc	a0,0x6
    80000ee2:	50250513          	addi	a0,a0,1282 # 800073e0 <userret+0x350>
    80000ee6:	fffff097          	auipc	ra,0xfffff
    80000eea:	6b2080e7          	jalr	1714(ra) # 80000598 <printf>
    printf("\n");
    80000eee:	00006517          	auipc	a0,0x6
    80000ef2:	63a50513          	addi	a0,a0,1594 # 80007528 <userret+0x498>
    80000ef6:	fffff097          	auipc	ra,0xfffff
    80000efa:	6a2080e7          	jalr	1698(ra) # 80000598 <printf>
    kinit();         // physical page allocator
    80000efe:	00000097          	auipc	ra,0x0
    80000f02:	a26080e7          	jalr	-1498(ra) # 80000924 <kinit>
    kvminit();       // create kernel page table
    80000f06:	00000097          	auipc	ra,0x0
    80000f0a:	30a080e7          	jalr	778(ra) # 80001210 <kvminit>
    kvminithart();   // turn on paging
    80000f0e:	00000097          	auipc	ra,0x0
    80000f12:	178080e7          	jalr	376(ra) # 80001086 <kvminithart>
    procinit();      // process table
    80000f16:	00001097          	auipc	ra,0x1
    80000f1a:	972080e7          	jalr	-1678(ra) # 80001888 <procinit>
    trapinit();      // trap vectors
    80000f1e:	00001097          	auipc	ra,0x1
    80000f22:	62c080e7          	jalr	1580(ra) # 8000254a <trapinit>
    trapinithart();  // install kernel trap vector
    80000f26:	00001097          	auipc	ra,0x1
    80000f2a:	64c080e7          	jalr	1612(ra) # 80002572 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f2e:	00005097          	auipc	ra,0x5
    80000f32:	b5c080e7          	jalr	-1188(ra) # 80005a8a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f36:	00005097          	auipc	ra,0x5
    80000f3a:	b6a080e7          	jalr	-1174(ra) # 80005aa0 <plicinithart>
    binit();         // buffer cache
    80000f3e:	00002097          	auipc	ra,0x2
    80000f42:	d6c080e7          	jalr	-660(ra) # 80002caa <binit>
    iinit();         // inode cache
    80000f46:	00002097          	auipc	ra,0x2
    80000f4a:	3fc080e7          	jalr	1020(ra) # 80003342 <iinit>
    fileinit();      // file table
    80000f4e:	00003097          	auipc	ra,0x3
    80000f52:	370080e7          	jalr	880(ra) # 800042be <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f56:	00005097          	auipc	ra,0x5
    80000f5a:	c64080e7          	jalr	-924(ra) # 80005bba <virtio_disk_init>
    userinit();      // first user process
    80000f5e:	00001097          	auipc	ra,0x1
    80000f62:	c9a080e7          	jalr	-870(ra) # 80001bf8 <userinit>
    __sync_synchronize();
    80000f66:	0ff0000f          	fence
    started = 1;
    80000f6a:	4785                	li	a5,1
    80000f6c:	00025717          	auipc	a4,0x25
    80000f70:	08f72c23          	sw	a5,152(a4) # 80026004 <started>
    80000f74:	b509                	j	80000d76 <main+0x56>

0000000080000f76 <walk>:
//   21..39 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..12 -- 12 bits of byte offset within the page.
static pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000f76:	7139                	addi	sp,sp,-64
    80000f78:	fc06                	sd	ra,56(sp)
    80000f7a:	f822                	sd	s0,48(sp)
    80000f7c:	f426                	sd	s1,40(sp)
    80000f7e:	f04a                	sd	s2,32(sp)
    80000f80:	ec4e                	sd	s3,24(sp)
    80000f82:	e852                	sd	s4,16(sp)
    80000f84:	e456                	sd	s5,8(sp)
    80000f86:	e05a                	sd	s6,0(sp)
    80000f88:	0080                	addi	s0,sp,64
    80000f8a:	84aa                	mv	s1,a0
    80000f8c:	89ae                	mv	s3,a1
    80000f8e:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000f90:	57fd                	li	a5,-1
    80000f92:	83e9                	srli	a5,a5,0x1a
    80000f94:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000f96:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000f98:	04b7f263          	bgeu	a5,a1,80000fdc <walk+0x66>
    panic("walk");
    80000f9c:	00006517          	auipc	a0,0x6
    80000fa0:	59450513          	addi	a0,a0,1428 # 80007530 <userret+0x4a0>
    80000fa4:	fffff097          	auipc	ra,0xfffff
    80000fa8:	5aa080e7          	jalr	1450(ra) # 8000054e <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000fac:	060a8663          	beqz	s5,80001018 <walk+0xa2>
    80000fb0:	00000097          	auipc	ra,0x0
    80000fb4:	9b0080e7          	jalr	-1616(ra) # 80000960 <kalloc>
    80000fb8:	84aa                	mv	s1,a0
    80000fba:	c529                	beqz	a0,80001004 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000fbc:	6605                	lui	a2,0x1
    80000fbe:	4581                	li	a1,0
    80000fc0:	00000097          	auipc	ra,0x0
    80000fc4:	bae080e7          	jalr	-1106(ra) # 80000b6e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000fc8:	00c4d793          	srli	a5,s1,0xc
    80000fcc:	07aa                	slli	a5,a5,0xa
    80000fce:	0017e793          	ori	a5,a5,1
    80000fd2:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80000fd6:	3a5d                	addiw	s4,s4,-9
    80000fd8:	036a0063          	beq	s4,s6,80000ff8 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80000fdc:	0149d933          	srl	s2,s3,s4
    80000fe0:	1ff97913          	andi	s2,s2,511
    80000fe4:	090e                	slli	s2,s2,0x3
    80000fe6:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000fe8:	00093483          	ld	s1,0(s2)
    80000fec:	0014f793          	andi	a5,s1,1
    80000ff0:	dfd5                	beqz	a5,80000fac <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000ff2:	80a9                	srli	s1,s1,0xa
    80000ff4:	04b2                	slli	s1,s1,0xc
    80000ff6:	b7c5                	j	80000fd6 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80000ff8:	00c9d513          	srli	a0,s3,0xc
    80000ffc:	1ff57513          	andi	a0,a0,511
    80001000:	050e                	slli	a0,a0,0x3
    80001002:	9526                	add	a0,a0,s1
}
    80001004:	70e2                	ld	ra,56(sp)
    80001006:	7442                	ld	s0,48(sp)
    80001008:	74a2                	ld	s1,40(sp)
    8000100a:	7902                	ld	s2,32(sp)
    8000100c:	69e2                	ld	s3,24(sp)
    8000100e:	6a42                	ld	s4,16(sp)
    80001010:	6aa2                	ld	s5,8(sp)
    80001012:	6b02                	ld	s6,0(sp)
    80001014:	6121                	addi	sp,sp,64
    80001016:	8082                	ret
        return 0;
    80001018:	4501                	li	a0,0
    8000101a:	b7ed                	j	80001004 <walk+0x8e>

000000008000101c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
static void
freewalk(pagetable_t pagetable)
{
    8000101c:	7179                	addi	sp,sp,-48
    8000101e:	f406                	sd	ra,40(sp)
    80001020:	f022                	sd	s0,32(sp)
    80001022:	ec26                	sd	s1,24(sp)
    80001024:	e84a                	sd	s2,16(sp)
    80001026:	e44e                	sd	s3,8(sp)
    80001028:	e052                	sd	s4,0(sp)
    8000102a:	1800                	addi	s0,sp,48
    8000102c:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8000102e:	84aa                	mv	s1,a0
    80001030:	6905                	lui	s2,0x1
    80001032:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001034:	4985                	li	s3,1
    80001036:	a821                	j	8000104e <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80001038:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000103a:	0532                	slli	a0,a0,0xc
    8000103c:	00000097          	auipc	ra,0x0
    80001040:	fe0080e7          	jalr	-32(ra) # 8000101c <freewalk>
      pagetable[i] = 0;
    80001044:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80001048:	04a1                	addi	s1,s1,8
    8000104a:	03248163          	beq	s1,s2,8000106c <freewalk+0x50>
    pte_t pte = pagetable[i];
    8000104e:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001050:	00f57793          	andi	a5,a0,15
    80001054:	ff3782e3          	beq	a5,s3,80001038 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80001058:	8905                	andi	a0,a0,1
    8000105a:	d57d                	beqz	a0,80001048 <freewalk+0x2c>
      panic("freewalk: leaf");
    8000105c:	00006517          	auipc	a0,0x6
    80001060:	4dc50513          	addi	a0,a0,1244 # 80007538 <userret+0x4a8>
    80001064:	fffff097          	auipc	ra,0xfffff
    80001068:	4ea080e7          	jalr	1258(ra) # 8000054e <panic>
    }
  }
  kfree((void*)pagetable);
    8000106c:	8552                	mv	a0,s4
    8000106e:	fffff097          	auipc	ra,0xfffff
    80001072:	7f6080e7          	jalr	2038(ra) # 80000864 <kfree>
}
    80001076:	70a2                	ld	ra,40(sp)
    80001078:	7402                	ld	s0,32(sp)
    8000107a:	64e2                	ld	s1,24(sp)
    8000107c:	6942                	ld	s2,16(sp)
    8000107e:	69a2                	ld	s3,8(sp)
    80001080:	6a02                	ld	s4,0(sp)
    80001082:	6145                	addi	sp,sp,48
    80001084:	8082                	ret

0000000080001086 <kvminithart>:
{
    80001086:	1141                	addi	sp,sp,-16
    80001088:	e422                	sd	s0,8(sp)
    8000108a:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    8000108c:	00025797          	auipc	a5,0x25
    80001090:	f7c7b783          	ld	a5,-132(a5) # 80026008 <kernel_pagetable>
    80001094:	83b1                	srli	a5,a5,0xc
    80001096:	577d                	li	a4,-1
    80001098:	177e                	slli	a4,a4,0x3f
    8000109a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    8000109c:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800010a0:	12000073          	sfence.vma
}
    800010a4:	6422                	ld	s0,8(sp)
    800010a6:	0141                	addi	sp,sp,16
    800010a8:	8082                	ret

00000000800010aa <walkaddr>:
  if(va >= MAXVA)
    800010aa:	57fd                	li	a5,-1
    800010ac:	83e9                	srli	a5,a5,0x1a
    800010ae:	00b7f463          	bgeu	a5,a1,800010b6 <walkaddr+0xc>
    return 0;
    800010b2:	4501                	li	a0,0
}
    800010b4:	8082                	ret
{
    800010b6:	1141                	addi	sp,sp,-16
    800010b8:	e406                	sd	ra,8(sp)
    800010ba:	e022                	sd	s0,0(sp)
    800010bc:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800010be:	4601                	li	a2,0
    800010c0:	00000097          	auipc	ra,0x0
    800010c4:	eb6080e7          	jalr	-330(ra) # 80000f76 <walk>
  if(pte == 0)
    800010c8:	c105                	beqz	a0,800010e8 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    800010ca:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800010cc:	0117f693          	andi	a3,a5,17
    800010d0:	4745                	li	a4,17
    return 0;
    800010d2:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800010d4:	00e68663          	beq	a3,a4,800010e0 <walkaddr+0x36>
}
    800010d8:	60a2                	ld	ra,8(sp)
    800010da:	6402                	ld	s0,0(sp)
    800010dc:	0141                	addi	sp,sp,16
    800010de:	8082                	ret
  pa = PTE2PA(*pte);
    800010e0:	00a7d513          	srli	a0,a5,0xa
    800010e4:	0532                	slli	a0,a0,0xc
  return pa;
    800010e6:	bfcd                	j	800010d8 <walkaddr+0x2e>
    return 0;
    800010e8:	4501                	li	a0,0
    800010ea:	b7fd                	j	800010d8 <walkaddr+0x2e>

00000000800010ec <kvmpa>:
{
    800010ec:	1101                	addi	sp,sp,-32
    800010ee:	ec06                	sd	ra,24(sp)
    800010f0:	e822                	sd	s0,16(sp)
    800010f2:	e426                	sd	s1,8(sp)
    800010f4:	1000                	addi	s0,sp,32
    800010f6:	85aa                	mv	a1,a0
  uint64 off = va % PGSIZE;
    800010f8:	1552                	slli	a0,a0,0x34
    800010fa:	03455493          	srli	s1,a0,0x34
  pte = walk(kernel_pagetable, va, 0);
    800010fe:	4601                	li	a2,0
    80001100:	00025517          	auipc	a0,0x25
    80001104:	f0853503          	ld	a0,-248(a0) # 80026008 <kernel_pagetable>
    80001108:	00000097          	auipc	ra,0x0
    8000110c:	e6e080e7          	jalr	-402(ra) # 80000f76 <walk>
  if(pte == 0)
    80001110:	cd09                	beqz	a0,8000112a <kvmpa+0x3e>
  if((*pte & PTE_V) == 0)
    80001112:	6108                	ld	a0,0(a0)
    80001114:	00157793          	andi	a5,a0,1
    80001118:	c38d                	beqz	a5,8000113a <kvmpa+0x4e>
  pa = PTE2PA(*pte);
    8000111a:	8129                	srli	a0,a0,0xa
    8000111c:	0532                	slli	a0,a0,0xc
}
    8000111e:	9526                	add	a0,a0,s1
    80001120:	60e2                	ld	ra,24(sp)
    80001122:	6442                	ld	s0,16(sp)
    80001124:	64a2                	ld	s1,8(sp)
    80001126:	6105                	addi	sp,sp,32
    80001128:	8082                	ret
    panic("kvmpa");
    8000112a:	00006517          	auipc	a0,0x6
    8000112e:	41e50513          	addi	a0,a0,1054 # 80007548 <userret+0x4b8>
    80001132:	fffff097          	auipc	ra,0xfffff
    80001136:	41c080e7          	jalr	1052(ra) # 8000054e <panic>
    panic("kvmpa");
    8000113a:	00006517          	auipc	a0,0x6
    8000113e:	40e50513          	addi	a0,a0,1038 # 80007548 <userret+0x4b8>
    80001142:	fffff097          	auipc	ra,0xfffff
    80001146:	40c080e7          	jalr	1036(ra) # 8000054e <panic>

000000008000114a <mappages>:
{
    8000114a:	715d                	addi	sp,sp,-80
    8000114c:	e486                	sd	ra,72(sp)
    8000114e:	e0a2                	sd	s0,64(sp)
    80001150:	fc26                	sd	s1,56(sp)
    80001152:	f84a                	sd	s2,48(sp)
    80001154:	f44e                	sd	s3,40(sp)
    80001156:	f052                	sd	s4,32(sp)
    80001158:	ec56                	sd	s5,24(sp)
    8000115a:	e85a                	sd	s6,16(sp)
    8000115c:	e45e                	sd	s7,8(sp)
    8000115e:	0880                	addi	s0,sp,80
    80001160:	8aaa                	mv	s5,a0
    80001162:	8b3a                	mv	s6,a4
  a = PGROUNDDOWN(va);
    80001164:	777d                	lui	a4,0xfffff
    80001166:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    8000116a:	167d                	addi	a2,a2,-1
    8000116c:	00b609b3          	add	s3,a2,a1
    80001170:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    80001174:	893e                	mv	s2,a5
    80001176:	40f68a33          	sub	s4,a3,a5
    a += PGSIZE;
    8000117a:	6b85                	lui	s7,0x1
    8000117c:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80001180:	4605                	li	a2,1
    80001182:	85ca                	mv	a1,s2
    80001184:	8556                	mv	a0,s5
    80001186:	00000097          	auipc	ra,0x0
    8000118a:	df0080e7          	jalr	-528(ra) # 80000f76 <walk>
    8000118e:	c51d                	beqz	a0,800011bc <mappages+0x72>
    if(*pte & PTE_V)
    80001190:	611c                	ld	a5,0(a0)
    80001192:	8b85                	andi	a5,a5,1
    80001194:	ef81                	bnez	a5,800011ac <mappages+0x62>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001196:	80b1                	srli	s1,s1,0xc
    80001198:	04aa                	slli	s1,s1,0xa
    8000119a:	0164e4b3          	or	s1,s1,s6
    8000119e:	0014e493          	ori	s1,s1,1
    800011a2:	e104                	sd	s1,0(a0)
    if(a == last)
    800011a4:	03390863          	beq	s2,s3,800011d4 <mappages+0x8a>
    a += PGSIZE;
    800011a8:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800011aa:	bfc9                	j	8000117c <mappages+0x32>
      panic("remap");
    800011ac:	00006517          	auipc	a0,0x6
    800011b0:	3a450513          	addi	a0,a0,932 # 80007550 <userret+0x4c0>
    800011b4:	fffff097          	auipc	ra,0xfffff
    800011b8:	39a080e7          	jalr	922(ra) # 8000054e <panic>
      return -1;
    800011bc:	557d                	li	a0,-1
}
    800011be:	60a6                	ld	ra,72(sp)
    800011c0:	6406                	ld	s0,64(sp)
    800011c2:	74e2                	ld	s1,56(sp)
    800011c4:	7942                	ld	s2,48(sp)
    800011c6:	79a2                	ld	s3,40(sp)
    800011c8:	7a02                	ld	s4,32(sp)
    800011ca:	6ae2                	ld	s5,24(sp)
    800011cc:	6b42                	ld	s6,16(sp)
    800011ce:	6ba2                	ld	s7,8(sp)
    800011d0:	6161                	addi	sp,sp,80
    800011d2:	8082                	ret
  return 0;
    800011d4:	4501                	li	a0,0
    800011d6:	b7e5                	j	800011be <mappages+0x74>

00000000800011d8 <kvmmap>:
{
    800011d8:	1141                	addi	sp,sp,-16
    800011da:	e406                	sd	ra,8(sp)
    800011dc:	e022                	sd	s0,0(sp)
    800011de:	0800                	addi	s0,sp,16
    800011e0:	8736                	mv	a4,a3
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    800011e2:	86ae                	mv	a3,a1
    800011e4:	85aa                	mv	a1,a0
    800011e6:	00025517          	auipc	a0,0x25
    800011ea:	e2253503          	ld	a0,-478(a0) # 80026008 <kernel_pagetable>
    800011ee:	00000097          	auipc	ra,0x0
    800011f2:	f5c080e7          	jalr	-164(ra) # 8000114a <mappages>
    800011f6:	e509                	bnez	a0,80001200 <kvmmap+0x28>
}
    800011f8:	60a2                	ld	ra,8(sp)
    800011fa:	6402                	ld	s0,0(sp)
    800011fc:	0141                	addi	sp,sp,16
    800011fe:	8082                	ret
    panic("kvmmap");
    80001200:	00006517          	auipc	a0,0x6
    80001204:	35850513          	addi	a0,a0,856 # 80007558 <userret+0x4c8>
    80001208:	fffff097          	auipc	ra,0xfffff
    8000120c:	346080e7          	jalr	838(ra) # 8000054e <panic>

0000000080001210 <kvminit>:
{
    80001210:	1101                	addi	sp,sp,-32
    80001212:	ec06                	sd	ra,24(sp)
    80001214:	e822                	sd	s0,16(sp)
    80001216:	e426                	sd	s1,8(sp)
    80001218:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    8000121a:	fffff097          	auipc	ra,0xfffff
    8000121e:	746080e7          	jalr	1862(ra) # 80000960 <kalloc>
    80001222:	00025797          	auipc	a5,0x25
    80001226:	dea7b323          	sd	a0,-538(a5) # 80026008 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    8000122a:	6605                	lui	a2,0x1
    8000122c:	4581                	li	a1,0
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	940080e7          	jalr	-1728(ra) # 80000b6e <memset>
  kvmmap(UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001236:	4699                	li	a3,6
    80001238:	6605                	lui	a2,0x1
    8000123a:	100005b7          	lui	a1,0x10000
    8000123e:	10000537          	lui	a0,0x10000
    80001242:	00000097          	auipc	ra,0x0
    80001246:	f96080e7          	jalr	-106(ra) # 800011d8 <kvmmap>
  kvmmap(VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000124a:	4699                	li	a3,6
    8000124c:	6605                	lui	a2,0x1
    8000124e:	100015b7          	lui	a1,0x10001
    80001252:	10001537          	lui	a0,0x10001
    80001256:	00000097          	auipc	ra,0x0
    8000125a:	f82080e7          	jalr	-126(ra) # 800011d8 <kvmmap>
  kvmmap(CLINT, CLINT, 0x10000, PTE_R | PTE_W);
    8000125e:	4699                	li	a3,6
    80001260:	6641                	lui	a2,0x10
    80001262:	020005b7          	lui	a1,0x2000
    80001266:	02000537          	lui	a0,0x2000
    8000126a:	00000097          	auipc	ra,0x0
    8000126e:	f6e080e7          	jalr	-146(ra) # 800011d8 <kvmmap>
  kvmmap(PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001272:	4699                	li	a3,6
    80001274:	00400637          	lui	a2,0x400
    80001278:	0c0005b7          	lui	a1,0xc000
    8000127c:	0c000537          	lui	a0,0xc000
    80001280:	00000097          	auipc	ra,0x0
    80001284:	f58080e7          	jalr	-168(ra) # 800011d8 <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80001288:	00007497          	auipc	s1,0x7
    8000128c:	d7848493          	addi	s1,s1,-648 # 80008000 <initcode>
    80001290:	46a9                	li	a3,10
    80001292:	80007617          	auipc	a2,0x80007
    80001296:	d6e60613          	addi	a2,a2,-658 # 8000 <_entry-0x7fff8000>
    8000129a:	4585                	li	a1,1
    8000129c:	05fe                	slli	a1,a1,0x1f
    8000129e:	852e                	mv	a0,a1
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	f38080e7          	jalr	-200(ra) # 800011d8 <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800012a8:	4699                	li	a3,6
    800012aa:	4645                	li	a2,17
    800012ac:	066e                	slli	a2,a2,0x1b
    800012ae:	8e05                	sub	a2,a2,s1
    800012b0:	85a6                	mv	a1,s1
    800012b2:	8526                	mv	a0,s1
    800012b4:	00000097          	auipc	ra,0x0
    800012b8:	f24080e7          	jalr	-220(ra) # 800011d8 <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800012bc:	46a9                	li	a3,10
    800012be:	6605                	lui	a2,0x1
    800012c0:	00006597          	auipc	a1,0x6
    800012c4:	d4058593          	addi	a1,a1,-704 # 80007000 <trampoline>
    800012c8:	04000537          	lui	a0,0x4000
    800012cc:	157d                	addi	a0,a0,-1
    800012ce:	0532                	slli	a0,a0,0xc
    800012d0:	00000097          	auipc	ra,0x0
    800012d4:	f08080e7          	jalr	-248(ra) # 800011d8 <kvmmap>
}
    800012d8:	60e2                	ld	ra,24(sp)
    800012da:	6442                	ld	s0,16(sp)
    800012dc:	64a2                	ld	s1,8(sp)
    800012de:	6105                	addi	sp,sp,32
    800012e0:	8082                	ret

00000000800012e2 <uvmunmap>:
{
    800012e2:	715d                	addi	sp,sp,-80
    800012e4:	e486                	sd	ra,72(sp)
    800012e6:	e0a2                	sd	s0,64(sp)
    800012e8:	fc26                	sd	s1,56(sp)
    800012ea:	f84a                	sd	s2,48(sp)
    800012ec:	f44e                	sd	s3,40(sp)
    800012ee:	f052                	sd	s4,32(sp)
    800012f0:	ec56                	sd	s5,24(sp)
    800012f2:	e85a                	sd	s6,16(sp)
    800012f4:	e45e                	sd	s7,8(sp)
    800012f6:	0880                	addi	s0,sp,80
    800012f8:	8a2a                	mv	s4,a0
    800012fa:	8ab6                	mv	s5,a3
  a = PGROUNDDOWN(va);
    800012fc:	77fd                	lui	a5,0xfffff
    800012fe:	00f5f933          	and	s2,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    80001302:	167d                	addi	a2,a2,-1
    80001304:	00b609b3          	add	s3,a2,a1
    80001308:	00f9f9b3          	and	s3,s3,a5
    if(PTE_FLAGS(*pte) == PTE_V)
    8000130c:	4b05                	li	s6,1
    a += PGSIZE;
    8000130e:	6b85                	lui	s7,0x1
    80001310:	a8b1                	j	8000136c <uvmunmap+0x8a>
      panic("uvmunmap: walk");
    80001312:	00006517          	auipc	a0,0x6
    80001316:	24e50513          	addi	a0,a0,590 # 80007560 <userret+0x4d0>
    8000131a:	fffff097          	auipc	ra,0xfffff
    8000131e:	234080e7          	jalr	564(ra) # 8000054e <panic>
      printf("va=%p pte=%p\n", a, *pte);
    80001322:	862a                	mv	a2,a0
    80001324:	85ca                	mv	a1,s2
    80001326:	00006517          	auipc	a0,0x6
    8000132a:	24a50513          	addi	a0,a0,586 # 80007570 <userret+0x4e0>
    8000132e:	fffff097          	auipc	ra,0xfffff
    80001332:	26a080e7          	jalr	618(ra) # 80000598 <printf>
      panic("uvmunmap: not mapped");
    80001336:	00006517          	auipc	a0,0x6
    8000133a:	24a50513          	addi	a0,a0,586 # 80007580 <userret+0x4f0>
    8000133e:	fffff097          	auipc	ra,0xfffff
    80001342:	210080e7          	jalr	528(ra) # 8000054e <panic>
      panic("uvmunmap: not a leaf");
    80001346:	00006517          	auipc	a0,0x6
    8000134a:	25250513          	addi	a0,a0,594 # 80007598 <userret+0x508>
    8000134e:	fffff097          	auipc	ra,0xfffff
    80001352:	200080e7          	jalr	512(ra) # 8000054e <panic>
      pa = PTE2PA(*pte);
    80001356:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80001358:	0532                	slli	a0,a0,0xc
    8000135a:	fffff097          	auipc	ra,0xfffff
    8000135e:	50a080e7          	jalr	1290(ra) # 80000864 <kfree>
    *pte = 0;
    80001362:	0004b023          	sd	zero,0(s1)
    if(a == last)
    80001366:	03390763          	beq	s2,s3,80001394 <uvmunmap+0xb2>
    a += PGSIZE;
    8000136a:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 0)) == 0)
    8000136c:	4601                	li	a2,0
    8000136e:	85ca                	mv	a1,s2
    80001370:	8552                	mv	a0,s4
    80001372:	00000097          	auipc	ra,0x0
    80001376:	c04080e7          	jalr	-1020(ra) # 80000f76 <walk>
    8000137a:	84aa                	mv	s1,a0
    8000137c:	d959                	beqz	a0,80001312 <uvmunmap+0x30>
    if((*pte & PTE_V) == 0){
    8000137e:	6108                	ld	a0,0(a0)
    80001380:	00157793          	andi	a5,a0,1
    80001384:	dfd9                	beqz	a5,80001322 <uvmunmap+0x40>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001386:	3ff57793          	andi	a5,a0,1023
    8000138a:	fb678ee3          	beq	a5,s6,80001346 <uvmunmap+0x64>
    if(do_free){
    8000138e:	fc0a8ae3          	beqz	s5,80001362 <uvmunmap+0x80>
    80001392:	b7d1                	j	80001356 <uvmunmap+0x74>
}
    80001394:	60a6                	ld	ra,72(sp)
    80001396:	6406                	ld	s0,64(sp)
    80001398:	74e2                	ld	s1,56(sp)
    8000139a:	7942                	ld	s2,48(sp)
    8000139c:	79a2                	ld	s3,40(sp)
    8000139e:	7a02                	ld	s4,32(sp)
    800013a0:	6ae2                	ld	s5,24(sp)
    800013a2:	6b42                	ld	s6,16(sp)
    800013a4:	6ba2                	ld	s7,8(sp)
    800013a6:	6161                	addi	sp,sp,80
    800013a8:	8082                	ret

00000000800013aa <uvmcreate>:
{
    800013aa:	1101                	addi	sp,sp,-32
    800013ac:	ec06                	sd	ra,24(sp)
    800013ae:	e822                	sd	s0,16(sp)
    800013b0:	e426                	sd	s1,8(sp)
    800013b2:	1000                	addi	s0,sp,32
  pagetable = (pagetable_t) kalloc();
    800013b4:	fffff097          	auipc	ra,0xfffff
    800013b8:	5ac080e7          	jalr	1452(ra) # 80000960 <kalloc>
  if(pagetable == 0)
    800013bc:	cd11                	beqz	a0,800013d8 <uvmcreate+0x2e>
    800013be:	84aa                	mv	s1,a0
  memset(pagetable, 0, PGSIZE);
    800013c0:	6605                	lui	a2,0x1
    800013c2:	4581                	li	a1,0
    800013c4:	fffff097          	auipc	ra,0xfffff
    800013c8:	7aa080e7          	jalr	1962(ra) # 80000b6e <memset>
}
    800013cc:	8526                	mv	a0,s1
    800013ce:	60e2                	ld	ra,24(sp)
    800013d0:	6442                	ld	s0,16(sp)
    800013d2:	64a2                	ld	s1,8(sp)
    800013d4:	6105                	addi	sp,sp,32
    800013d6:	8082                	ret
    panic("uvmcreate: out of memory");
    800013d8:	00006517          	auipc	a0,0x6
    800013dc:	1d850513          	addi	a0,a0,472 # 800075b0 <userret+0x520>
    800013e0:	fffff097          	auipc	ra,0xfffff
    800013e4:	16e080e7          	jalr	366(ra) # 8000054e <panic>

00000000800013e8 <uvminit>:
{
    800013e8:	7179                	addi	sp,sp,-48
    800013ea:	f406                	sd	ra,40(sp)
    800013ec:	f022                	sd	s0,32(sp)
    800013ee:	ec26                	sd	s1,24(sp)
    800013f0:	e84a                	sd	s2,16(sp)
    800013f2:	e44e                	sd	s3,8(sp)
    800013f4:	e052                	sd	s4,0(sp)
    800013f6:	1800                	addi	s0,sp,48
  if(sz >= PGSIZE)
    800013f8:	6785                	lui	a5,0x1
    800013fa:	04f67863          	bgeu	a2,a5,8000144a <uvminit+0x62>
    800013fe:	8a2a                	mv	s4,a0
    80001400:	89ae                	mv	s3,a1
    80001402:	84b2                	mv	s1,a2
  mem = kalloc();
    80001404:	fffff097          	auipc	ra,0xfffff
    80001408:	55c080e7          	jalr	1372(ra) # 80000960 <kalloc>
    8000140c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000140e:	6605                	lui	a2,0x1
    80001410:	4581                	li	a1,0
    80001412:	fffff097          	auipc	ra,0xfffff
    80001416:	75c080e7          	jalr	1884(ra) # 80000b6e <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000141a:	4779                	li	a4,30
    8000141c:	86ca                	mv	a3,s2
    8000141e:	6605                	lui	a2,0x1
    80001420:	4581                	li	a1,0
    80001422:	8552                	mv	a0,s4
    80001424:	00000097          	auipc	ra,0x0
    80001428:	d26080e7          	jalr	-730(ra) # 8000114a <mappages>
  memmove(mem, src, sz);
    8000142c:	8626                	mv	a2,s1
    8000142e:	85ce                	mv	a1,s3
    80001430:	854a                	mv	a0,s2
    80001432:	fffff097          	auipc	ra,0xfffff
    80001436:	79c080e7          	jalr	1948(ra) # 80000bce <memmove>
}
    8000143a:	70a2                	ld	ra,40(sp)
    8000143c:	7402                	ld	s0,32(sp)
    8000143e:	64e2                	ld	s1,24(sp)
    80001440:	6942                	ld	s2,16(sp)
    80001442:	69a2                	ld	s3,8(sp)
    80001444:	6a02                	ld	s4,0(sp)
    80001446:	6145                	addi	sp,sp,48
    80001448:	8082                	ret
    panic("inituvm: more than a page");
    8000144a:	00006517          	auipc	a0,0x6
    8000144e:	18650513          	addi	a0,a0,390 # 800075d0 <userret+0x540>
    80001452:	fffff097          	auipc	ra,0xfffff
    80001456:	0fc080e7          	jalr	252(ra) # 8000054e <panic>

000000008000145a <uvmdealloc>:
{
    8000145a:	1101                	addi	sp,sp,-32
    8000145c:	ec06                	sd	ra,24(sp)
    8000145e:	e822                	sd	s0,16(sp)
    80001460:	e426                	sd	s1,8(sp)
    80001462:	1000                	addi	s0,sp,32
    return oldsz;
    80001464:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80001466:	00b67d63          	bgeu	a2,a1,80001480 <uvmdealloc+0x26>
    8000146a:	84b2                	mv	s1,a2
  uint64 newup = PGROUNDUP(newsz);
    8000146c:	6785                	lui	a5,0x1
    8000146e:	17fd                	addi	a5,a5,-1
    80001470:	00f60733          	add	a4,a2,a5
    80001474:	76fd                	lui	a3,0xfffff
    80001476:	8f75                	and	a4,a4,a3
  if(newup < PGROUNDUP(oldsz))
    80001478:	97ae                	add	a5,a5,a1
    8000147a:	8ff5                	and	a5,a5,a3
    8000147c:	00f76863          	bltu	a4,a5,8000148c <uvmdealloc+0x32>
}
    80001480:	8526                	mv	a0,s1
    80001482:	60e2                	ld	ra,24(sp)
    80001484:	6442                	ld	s0,16(sp)
    80001486:	64a2                	ld	s1,8(sp)
    80001488:	6105                	addi	sp,sp,32
    8000148a:	8082                	ret
    uvmunmap(pagetable, newup, oldsz - newup, 1);
    8000148c:	4685                	li	a3,1
    8000148e:	40e58633          	sub	a2,a1,a4
    80001492:	85ba                	mv	a1,a4
    80001494:	00000097          	auipc	ra,0x0
    80001498:	e4e080e7          	jalr	-434(ra) # 800012e2 <uvmunmap>
    8000149c:	b7d5                	j	80001480 <uvmdealloc+0x26>

000000008000149e <uvmalloc>:
  if(newsz < oldsz)
    8000149e:	0ab66163          	bltu	a2,a1,80001540 <uvmalloc+0xa2>
{
    800014a2:	7139                	addi	sp,sp,-64
    800014a4:	fc06                	sd	ra,56(sp)
    800014a6:	f822                	sd	s0,48(sp)
    800014a8:	f426                	sd	s1,40(sp)
    800014aa:	f04a                	sd	s2,32(sp)
    800014ac:	ec4e                	sd	s3,24(sp)
    800014ae:	e852                	sd	s4,16(sp)
    800014b0:	e456                	sd	s5,8(sp)
    800014b2:	0080                	addi	s0,sp,64
    800014b4:	8aaa                	mv	s5,a0
    800014b6:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800014b8:	6985                	lui	s3,0x1
    800014ba:	19fd                	addi	s3,s3,-1
    800014bc:	95ce                	add	a1,a1,s3
    800014be:	79fd                	lui	s3,0xfffff
    800014c0:	0135f9b3          	and	s3,a1,s3
  for(; a < newsz; a += PGSIZE){
    800014c4:	08c9f063          	bgeu	s3,a2,80001544 <uvmalloc+0xa6>
  a = oldsz;
    800014c8:	894e                	mv	s2,s3
    mem = kalloc();
    800014ca:	fffff097          	auipc	ra,0xfffff
    800014ce:	496080e7          	jalr	1174(ra) # 80000960 <kalloc>
    800014d2:	84aa                	mv	s1,a0
    if(mem == 0){
    800014d4:	c51d                	beqz	a0,80001502 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800014d6:	6605                	lui	a2,0x1
    800014d8:	4581                	li	a1,0
    800014da:	fffff097          	auipc	ra,0xfffff
    800014de:	694080e7          	jalr	1684(ra) # 80000b6e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800014e2:	4779                	li	a4,30
    800014e4:	86a6                	mv	a3,s1
    800014e6:	6605                	lui	a2,0x1
    800014e8:	85ca                	mv	a1,s2
    800014ea:	8556                	mv	a0,s5
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	c5e080e7          	jalr	-930(ra) # 8000114a <mappages>
    800014f4:	e905                	bnez	a0,80001524 <uvmalloc+0x86>
  for(; a < newsz; a += PGSIZE){
    800014f6:	6785                	lui	a5,0x1
    800014f8:	993e                	add	s2,s2,a5
    800014fa:	fd4968e3          	bltu	s2,s4,800014ca <uvmalloc+0x2c>
  return newsz;
    800014fe:	8552                	mv	a0,s4
    80001500:	a809                	j	80001512 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80001502:	864e                	mv	a2,s3
    80001504:	85ca                	mv	a1,s2
    80001506:	8556                	mv	a0,s5
    80001508:	00000097          	auipc	ra,0x0
    8000150c:	f52080e7          	jalr	-174(ra) # 8000145a <uvmdealloc>
      return 0;
    80001510:	4501                	li	a0,0
}
    80001512:	70e2                	ld	ra,56(sp)
    80001514:	7442                	ld	s0,48(sp)
    80001516:	74a2                	ld	s1,40(sp)
    80001518:	7902                	ld	s2,32(sp)
    8000151a:	69e2                	ld	s3,24(sp)
    8000151c:	6a42                	ld	s4,16(sp)
    8000151e:	6aa2                	ld	s5,8(sp)
    80001520:	6121                	addi	sp,sp,64
    80001522:	8082                	ret
      kfree(mem);
    80001524:	8526                	mv	a0,s1
    80001526:	fffff097          	auipc	ra,0xfffff
    8000152a:	33e080e7          	jalr	830(ra) # 80000864 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    8000152e:	864e                	mv	a2,s3
    80001530:	85ca                	mv	a1,s2
    80001532:	8556                	mv	a0,s5
    80001534:	00000097          	auipc	ra,0x0
    80001538:	f26080e7          	jalr	-218(ra) # 8000145a <uvmdealloc>
      return 0;
    8000153c:	4501                	li	a0,0
    8000153e:	bfd1                	j	80001512 <uvmalloc+0x74>
    return oldsz;
    80001540:	852e                	mv	a0,a1
}
    80001542:	8082                	ret
  return newsz;
    80001544:	8532                	mv	a0,a2
    80001546:	b7f1                	j	80001512 <uvmalloc+0x74>

0000000080001548 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80001548:	1101                	addi	sp,sp,-32
    8000154a:	ec06                	sd	ra,24(sp)
    8000154c:	e822                	sd	s0,16(sp)
    8000154e:	e426                	sd	s1,8(sp)
    80001550:	1000                	addi	s0,sp,32
    80001552:	84aa                	mv	s1,a0
    80001554:	862e                	mv	a2,a1
  uvmunmap(pagetable, 0, sz, 1);
    80001556:	4685                	li	a3,1
    80001558:	4581                	li	a1,0
    8000155a:	00000097          	auipc	ra,0x0
    8000155e:	d88080e7          	jalr	-632(ra) # 800012e2 <uvmunmap>
  freewalk(pagetable);
    80001562:	8526                	mv	a0,s1
    80001564:	00000097          	auipc	ra,0x0
    80001568:	ab8080e7          	jalr	-1352(ra) # 8000101c <freewalk>
}
    8000156c:	60e2                	ld	ra,24(sp)
    8000156e:	6442                	ld	s0,16(sp)
    80001570:	64a2                	ld	s1,8(sp)
    80001572:	6105                	addi	sp,sp,32
    80001574:	8082                	ret

0000000080001576 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001576:	c671                	beqz	a2,80001642 <uvmcopy+0xcc>
{
    80001578:	715d                	addi	sp,sp,-80
    8000157a:	e486                	sd	ra,72(sp)
    8000157c:	e0a2                	sd	s0,64(sp)
    8000157e:	fc26                	sd	s1,56(sp)
    80001580:	f84a                	sd	s2,48(sp)
    80001582:	f44e                	sd	s3,40(sp)
    80001584:	f052                	sd	s4,32(sp)
    80001586:	ec56                	sd	s5,24(sp)
    80001588:	e85a                	sd	s6,16(sp)
    8000158a:	e45e                	sd	s7,8(sp)
    8000158c:	0880                	addi	s0,sp,80
    8000158e:	8b2a                	mv	s6,a0
    80001590:	8aae                	mv	s5,a1
    80001592:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001594:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80001596:	4601                	li	a2,0
    80001598:	85ce                	mv	a1,s3
    8000159a:	855a                	mv	a0,s6
    8000159c:	00000097          	auipc	ra,0x0
    800015a0:	9da080e7          	jalr	-1574(ra) # 80000f76 <walk>
    800015a4:	c531                	beqz	a0,800015f0 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    800015a6:	6118                	ld	a4,0(a0)
    800015a8:	00177793          	andi	a5,a4,1
    800015ac:	cbb1                	beqz	a5,80001600 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800015ae:	00a75593          	srli	a1,a4,0xa
    800015b2:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800015b6:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    800015ba:	fffff097          	auipc	ra,0xfffff
    800015be:	3a6080e7          	jalr	934(ra) # 80000960 <kalloc>
    800015c2:	892a                	mv	s2,a0
    800015c4:	c939                	beqz	a0,8000161a <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015c6:	6605                	lui	a2,0x1
    800015c8:	85de                	mv	a1,s7
    800015ca:	fffff097          	auipc	ra,0xfffff
    800015ce:	604080e7          	jalr	1540(ra) # 80000bce <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015d2:	8726                	mv	a4,s1
    800015d4:	86ca                	mv	a3,s2
    800015d6:	6605                	lui	a2,0x1
    800015d8:	85ce                	mv	a1,s3
    800015da:	8556                	mv	a0,s5
    800015dc:	00000097          	auipc	ra,0x0
    800015e0:	b6e080e7          	jalr	-1170(ra) # 8000114a <mappages>
    800015e4:	e515                	bnez	a0,80001610 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015e6:	6785                	lui	a5,0x1
    800015e8:	99be                	add	s3,s3,a5
    800015ea:	fb49e6e3          	bltu	s3,s4,80001596 <uvmcopy+0x20>
    800015ee:	a83d                	j	8000162c <uvmcopy+0xb6>
      panic("uvmcopy: pte should exist");
    800015f0:	00006517          	auipc	a0,0x6
    800015f4:	00050513          	mv	a0,a0
    800015f8:	fffff097          	auipc	ra,0xfffff
    800015fc:	f56080e7          	jalr	-170(ra) # 8000054e <panic>
      panic("uvmcopy: page not present");
    80001600:	00006517          	auipc	a0,0x6
    80001604:	01050513          	addi	a0,a0,16 # 80007610 <userret+0x580>
    80001608:	fffff097          	auipc	ra,0xfffff
    8000160c:	f46080e7          	jalr	-186(ra) # 8000054e <panic>
      kfree(mem);
    80001610:	854a                	mv	a0,s2
    80001612:	fffff097          	auipc	ra,0xfffff
    80001616:	252080e7          	jalr	594(ra) # 80000864 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i, 1);
    8000161a:	4685                	li	a3,1
    8000161c:	864e                	mv	a2,s3
    8000161e:	4581                	li	a1,0
    80001620:	8556                	mv	a0,s5
    80001622:	00000097          	auipc	ra,0x0
    80001626:	cc0080e7          	jalr	-832(ra) # 800012e2 <uvmunmap>
  return -1;
    8000162a:	557d                	li	a0,-1
}
    8000162c:	60a6                	ld	ra,72(sp)
    8000162e:	6406                	ld	s0,64(sp)
    80001630:	74e2                	ld	s1,56(sp)
    80001632:	7942                	ld	s2,48(sp)
    80001634:	79a2                	ld	s3,40(sp)
    80001636:	7a02                	ld	s4,32(sp)
    80001638:	6ae2                	ld	s5,24(sp)
    8000163a:	6b42                	ld	s6,16(sp)
    8000163c:	6ba2                	ld	s7,8(sp)
    8000163e:	6161                	addi	sp,sp,80
    80001640:	8082                	ret
  return 0;
    80001642:	4501                	li	a0,0
}
    80001644:	8082                	ret

0000000080001646 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001646:	1141                	addi	sp,sp,-16
    80001648:	e406                	sd	ra,8(sp)
    8000164a:	e022                	sd	s0,0(sp)
    8000164c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000164e:	4601                	li	a2,0
    80001650:	00000097          	auipc	ra,0x0
    80001654:	926080e7          	jalr	-1754(ra) # 80000f76 <walk>
  if(pte == 0)
    80001658:	c901                	beqz	a0,80001668 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000165a:	611c                	ld	a5,0(a0)
    8000165c:	9bbd                	andi	a5,a5,-17
    8000165e:	e11c                	sd	a5,0(a0)
}
    80001660:	60a2                	ld	ra,8(sp)
    80001662:	6402                	ld	s0,0(sp)
    80001664:	0141                	addi	sp,sp,16
    80001666:	8082                	ret
    panic("uvmclear");
    80001668:	00006517          	auipc	a0,0x6
    8000166c:	fc850513          	addi	a0,a0,-56 # 80007630 <userret+0x5a0>
    80001670:	fffff097          	auipc	ra,0xfffff
    80001674:	ede080e7          	jalr	-290(ra) # 8000054e <panic>

0000000080001678 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001678:	c6bd                	beqz	a3,800016e6 <copyout+0x6e>
{
    8000167a:	715d                	addi	sp,sp,-80
    8000167c:	e486                	sd	ra,72(sp)
    8000167e:	e0a2                	sd	s0,64(sp)
    80001680:	fc26                	sd	s1,56(sp)
    80001682:	f84a                	sd	s2,48(sp)
    80001684:	f44e                	sd	s3,40(sp)
    80001686:	f052                	sd	s4,32(sp)
    80001688:	ec56                	sd	s5,24(sp)
    8000168a:	e85a                	sd	s6,16(sp)
    8000168c:	e45e                	sd	s7,8(sp)
    8000168e:	e062                	sd	s8,0(sp)
    80001690:	0880                	addi	s0,sp,80
    80001692:	8b2a                	mv	s6,a0
    80001694:	8c2e                	mv	s8,a1
    80001696:	8a32                	mv	s4,a2
    80001698:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8000169a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    8000169c:	6a85                	lui	s5,0x1
    8000169e:	a015                	j	800016c2 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800016a0:	9562                	add	a0,a0,s8
    800016a2:	0004861b          	sext.w	a2,s1
    800016a6:	85d2                	mv	a1,s4
    800016a8:	41250533          	sub	a0,a0,s2
    800016ac:	fffff097          	auipc	ra,0xfffff
    800016b0:	522080e7          	jalr	1314(ra) # 80000bce <memmove>

    len -= n;
    800016b4:	409989b3          	sub	s3,s3,s1
    src += n;
    800016b8:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800016ba:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016be:	02098263          	beqz	s3,800016e2 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016c2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016c6:	85ca                	mv	a1,s2
    800016c8:	855a                	mv	a0,s6
    800016ca:	00000097          	auipc	ra,0x0
    800016ce:	9e0080e7          	jalr	-1568(ra) # 800010aa <walkaddr>
    if(pa0 == 0)
    800016d2:	cd01                	beqz	a0,800016ea <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016d4:	418904b3          	sub	s1,s2,s8
    800016d8:	94d6                	add	s1,s1,s5
    if(n > len)
    800016da:	fc99f3e3          	bgeu	s3,s1,800016a0 <copyout+0x28>
    800016de:	84ce                	mv	s1,s3
    800016e0:	b7c1                	j	800016a0 <copyout+0x28>
  }
  return 0;
    800016e2:	4501                	li	a0,0
    800016e4:	a021                	j	800016ec <copyout+0x74>
    800016e6:	4501                	li	a0,0
}
    800016e8:	8082                	ret
      return -1;
    800016ea:	557d                	li	a0,-1
}
    800016ec:	60a6                	ld	ra,72(sp)
    800016ee:	6406                	ld	s0,64(sp)
    800016f0:	74e2                	ld	s1,56(sp)
    800016f2:	7942                	ld	s2,48(sp)
    800016f4:	79a2                	ld	s3,40(sp)
    800016f6:	7a02                	ld	s4,32(sp)
    800016f8:	6ae2                	ld	s5,24(sp)
    800016fa:	6b42                	ld	s6,16(sp)
    800016fc:	6ba2                	ld	s7,8(sp)
    800016fe:	6c02                	ld	s8,0(sp)
    80001700:	6161                	addi	sp,sp,80
    80001702:	8082                	ret

0000000080001704 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001704:	c6bd                	beqz	a3,80001772 <copyin+0x6e>
{
    80001706:	715d                	addi	sp,sp,-80
    80001708:	e486                	sd	ra,72(sp)
    8000170a:	e0a2                	sd	s0,64(sp)
    8000170c:	fc26                	sd	s1,56(sp)
    8000170e:	f84a                	sd	s2,48(sp)
    80001710:	f44e                	sd	s3,40(sp)
    80001712:	f052                	sd	s4,32(sp)
    80001714:	ec56                	sd	s5,24(sp)
    80001716:	e85a                	sd	s6,16(sp)
    80001718:	e45e                	sd	s7,8(sp)
    8000171a:	e062                	sd	s8,0(sp)
    8000171c:	0880                	addi	s0,sp,80
    8000171e:	8b2a                	mv	s6,a0
    80001720:	8a2e                	mv	s4,a1
    80001722:	8c32                	mv	s8,a2
    80001724:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001726:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001728:	6a85                	lui	s5,0x1
    8000172a:	a015                	j	8000174e <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000172c:	9562                	add	a0,a0,s8
    8000172e:	0004861b          	sext.w	a2,s1
    80001732:	412505b3          	sub	a1,a0,s2
    80001736:	8552                	mv	a0,s4
    80001738:	fffff097          	auipc	ra,0xfffff
    8000173c:	496080e7          	jalr	1174(ra) # 80000bce <memmove>

    len -= n;
    80001740:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001744:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80001746:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000174a:	02098263          	beqz	s3,8000176e <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    8000174e:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001752:	85ca                	mv	a1,s2
    80001754:	855a                	mv	a0,s6
    80001756:	00000097          	auipc	ra,0x0
    8000175a:	954080e7          	jalr	-1708(ra) # 800010aa <walkaddr>
    if(pa0 == 0)
    8000175e:	cd01                	beqz	a0,80001776 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80001760:	418904b3          	sub	s1,s2,s8
    80001764:	94d6                	add	s1,s1,s5
    if(n > len)
    80001766:	fc99f3e3          	bgeu	s3,s1,8000172c <copyin+0x28>
    8000176a:	84ce                	mv	s1,s3
    8000176c:	b7c1                	j	8000172c <copyin+0x28>
  }
  return 0;
    8000176e:	4501                	li	a0,0
    80001770:	a021                	j	80001778 <copyin+0x74>
    80001772:	4501                	li	a0,0
}
    80001774:	8082                	ret
      return -1;
    80001776:	557d                	li	a0,-1
}
    80001778:	60a6                	ld	ra,72(sp)
    8000177a:	6406                	ld	s0,64(sp)
    8000177c:	74e2                	ld	s1,56(sp)
    8000177e:	7942                	ld	s2,48(sp)
    80001780:	79a2                	ld	s3,40(sp)
    80001782:	7a02                	ld	s4,32(sp)
    80001784:	6ae2                	ld	s5,24(sp)
    80001786:	6b42                	ld	s6,16(sp)
    80001788:	6ba2                	ld	s7,8(sp)
    8000178a:	6c02                	ld	s8,0(sp)
    8000178c:	6161                	addi	sp,sp,80
    8000178e:	8082                	ret

0000000080001790 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001790:	c6c5                	beqz	a3,80001838 <copyinstr+0xa8>
{
    80001792:	715d                	addi	sp,sp,-80
    80001794:	e486                	sd	ra,72(sp)
    80001796:	e0a2                	sd	s0,64(sp)
    80001798:	fc26                	sd	s1,56(sp)
    8000179a:	f84a                	sd	s2,48(sp)
    8000179c:	f44e                	sd	s3,40(sp)
    8000179e:	f052                	sd	s4,32(sp)
    800017a0:	ec56                	sd	s5,24(sp)
    800017a2:	e85a                	sd	s6,16(sp)
    800017a4:	e45e                	sd	s7,8(sp)
    800017a6:	0880                	addi	s0,sp,80
    800017a8:	8a2a                	mv	s4,a0
    800017aa:	8b2e                	mv	s6,a1
    800017ac:	8bb2                	mv	s7,a2
    800017ae:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    800017b0:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800017b2:	6985                	lui	s3,0x1
    800017b4:	a035                	j	800017e0 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    800017b6:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017ba:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800017bc:	0017b793          	seqz	a5,a5
    800017c0:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017c4:	60a6                	ld	ra,72(sp)
    800017c6:	6406                	ld	s0,64(sp)
    800017c8:	74e2                	ld	s1,56(sp)
    800017ca:	7942                	ld	s2,48(sp)
    800017cc:	79a2                	ld	s3,40(sp)
    800017ce:	7a02                	ld	s4,32(sp)
    800017d0:	6ae2                	ld	s5,24(sp)
    800017d2:	6b42                	ld	s6,16(sp)
    800017d4:	6ba2                	ld	s7,8(sp)
    800017d6:	6161                	addi	sp,sp,80
    800017d8:	8082                	ret
    srcva = va0 + PGSIZE;
    800017da:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    800017de:	c8a9                	beqz	s1,80001830 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    800017e0:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    800017e4:	85ca                	mv	a1,s2
    800017e6:	8552                	mv	a0,s4
    800017e8:	00000097          	auipc	ra,0x0
    800017ec:	8c2080e7          	jalr	-1854(ra) # 800010aa <walkaddr>
    if(pa0 == 0)
    800017f0:	c131                	beqz	a0,80001834 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    800017f2:	41790833          	sub	a6,s2,s7
    800017f6:	984e                	add	a6,a6,s3
    if(n > max)
    800017f8:	0104f363          	bgeu	s1,a6,800017fe <copyinstr+0x6e>
    800017fc:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800017fe:	955e                	add	a0,a0,s7
    80001800:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80001804:	fc080be3          	beqz	a6,800017da <copyinstr+0x4a>
    80001808:	985a                	add	a6,a6,s6
    8000180a:	87da                	mv	a5,s6
      if(*p == '\0'){
    8000180c:	41650633          	sub	a2,a0,s6
    80001810:	14fd                	addi	s1,s1,-1
    80001812:	9b26                	add	s6,s6,s1
    80001814:	00f60733          	add	a4,a2,a5
    80001818:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd8fe4>
    8000181c:	df49                	beqz	a4,800017b6 <copyinstr+0x26>
        *dst = *p;
    8000181e:	00e78023          	sb	a4,0(a5)
      --max;
    80001822:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80001826:	0785                	addi	a5,a5,1
    while(n > 0){
    80001828:	ff0796e3          	bne	a5,a6,80001814 <copyinstr+0x84>
      dst++;
    8000182c:	8b42                	mv	s6,a6
    8000182e:	b775                	j	800017da <copyinstr+0x4a>
    80001830:	4781                	li	a5,0
    80001832:	b769                	j	800017bc <copyinstr+0x2c>
      return -1;
    80001834:	557d                	li	a0,-1
    80001836:	b779                	j	800017c4 <copyinstr+0x34>
  int got_null = 0;
    80001838:	4781                	li	a5,0
  if(got_null){
    8000183a:	0017b793          	seqz	a5,a5
    8000183e:	40f00533          	neg	a0,a5
}
    80001842:	8082                	ret

0000000080001844 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80001844:	1101                	addi	sp,sp,-32
    80001846:	ec06                	sd	ra,24(sp)
    80001848:	e822                	sd	s0,16(sp)
    8000184a:	e426                	sd	s1,8(sp)
    8000184c:	1000                	addi	s0,sp,32
    8000184e:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001850:	fffff097          	auipc	ra,0xfffff
    80001854:	242080e7          	jalr	578(ra) # 80000a92 <holding>
    80001858:	c909                	beqz	a0,8000186a <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    8000185a:	749c                	ld	a5,40(s1)
    8000185c:	00978f63          	beq	a5,s1,8000187a <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    80001860:	60e2                	ld	ra,24(sp)
    80001862:	6442                	ld	s0,16(sp)
    80001864:	64a2                	ld	s1,8(sp)
    80001866:	6105                	addi	sp,sp,32
    80001868:	8082                	ret
    panic("wakeup1");
    8000186a:	00006517          	auipc	a0,0x6
    8000186e:	dd650513          	addi	a0,a0,-554 # 80007640 <userret+0x5b0>
    80001872:	fffff097          	auipc	ra,0xfffff
    80001876:	cdc080e7          	jalr	-804(ra) # 8000054e <panic>
  if(p->chan == p && p->state == SLEEPING) {
    8000187a:	4c98                	lw	a4,24(s1)
    8000187c:	4785                	li	a5,1
    8000187e:	fef711e3          	bne	a4,a5,80001860 <wakeup1+0x1c>
    p->state = RUNNABLE;
    80001882:	4789                	li	a5,2
    80001884:	cc9c                	sw	a5,24(s1)
}
    80001886:	bfe9                	j	80001860 <wakeup1+0x1c>

0000000080001888 <procinit>:
{
    80001888:	715d                	addi	sp,sp,-80
    8000188a:	e486                	sd	ra,72(sp)
    8000188c:	e0a2                	sd	s0,64(sp)
    8000188e:	fc26                	sd	s1,56(sp)
    80001890:	f84a                	sd	s2,48(sp)
    80001892:	f44e                	sd	s3,40(sp)
    80001894:	f052                	sd	s4,32(sp)
    80001896:	ec56                	sd	s5,24(sp)
    80001898:	e85a                	sd	s6,16(sp)
    8000189a:	e45e                	sd	s7,8(sp)
    8000189c:	0880                	addi	s0,sp,80
  initlock(&pid_lock, "nextpid");
    8000189e:	00006597          	auipc	a1,0x6
    800018a2:	daa58593          	addi	a1,a1,-598 # 80007648 <userret+0x5b8>
    800018a6:	00010517          	auipc	a0,0x10
    800018aa:	04250513          	addi	a0,a0,66 # 800118e8 <pid_lock>
    800018ae:	fffff097          	auipc	ra,0xfffff
    800018b2:	112080e7          	jalr	274(ra) # 800009c0 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018b6:	00010917          	auipc	s2,0x10
    800018ba:	44a90913          	addi	s2,s2,1098 # 80011d00 <proc>
      initlock(&p->lock, "proc");
    800018be:	00006b97          	auipc	s7,0x6
    800018c2:	d92b8b93          	addi	s7,s7,-622 # 80007650 <userret+0x5c0>
      uint64 va = KSTACK((int) (p - proc));
    800018c6:	8b4a                	mv	s6,s2
    800018c8:	00006a97          	auipc	s5,0x6
    800018cc:	3c8a8a93          	addi	s5,s5,968 # 80007c90 <syscalls+0xb0>
    800018d0:	040009b7          	lui	s3,0x4000
    800018d4:	19fd                	addi	s3,s3,-1
    800018d6:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    800018d8:	00016a17          	auipc	s4,0x16
    800018dc:	e28a0a13          	addi	s4,s4,-472 # 80017700 <tickslock>
      initlock(&p->lock, "proc");
    800018e0:	85de                	mv	a1,s7
    800018e2:	854a                	mv	a0,s2
    800018e4:	fffff097          	auipc	ra,0xfffff
    800018e8:	0dc080e7          	jalr	220(ra) # 800009c0 <initlock>
      char *pa = kalloc();
    800018ec:	fffff097          	auipc	ra,0xfffff
    800018f0:	074080e7          	jalr	116(ra) # 80000960 <kalloc>
    800018f4:	85aa                	mv	a1,a0
      if(pa == 0)
    800018f6:	c929                	beqz	a0,80001948 <procinit+0xc0>
      uint64 va = KSTACK((int) (p - proc));
    800018f8:	416904b3          	sub	s1,s2,s6
    800018fc:	848d                	srai	s1,s1,0x3
    800018fe:	000ab783          	ld	a5,0(s5)
    80001902:	02f484b3          	mul	s1,s1,a5
    80001906:	2485                	addiw	s1,s1,1
    80001908:	00d4949b          	slliw	s1,s1,0xd
    8000190c:	409984b3          	sub	s1,s3,s1
      kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001910:	4699                	li	a3,6
    80001912:	6605                	lui	a2,0x1
    80001914:	8526                	mv	a0,s1
    80001916:	00000097          	auipc	ra,0x0
    8000191a:	8c2080e7          	jalr	-1854(ra) # 800011d8 <kvmmap>
      p->kstack = va;
    8000191e:	04993023          	sd	s1,64(s2)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001922:	16890913          	addi	s2,s2,360
    80001926:	fb491de3          	bne	s2,s4,800018e0 <procinit+0x58>
  kvminithart();
    8000192a:	fffff097          	auipc	ra,0xfffff
    8000192e:	75c080e7          	jalr	1884(ra) # 80001086 <kvminithart>
}
    80001932:	60a6                	ld	ra,72(sp)
    80001934:	6406                	ld	s0,64(sp)
    80001936:	74e2                	ld	s1,56(sp)
    80001938:	7942                	ld	s2,48(sp)
    8000193a:	79a2                	ld	s3,40(sp)
    8000193c:	7a02                	ld	s4,32(sp)
    8000193e:	6ae2                	ld	s5,24(sp)
    80001940:	6b42                	ld	s6,16(sp)
    80001942:	6ba2                	ld	s7,8(sp)
    80001944:	6161                	addi	sp,sp,80
    80001946:	8082                	ret
        panic("kalloc");
    80001948:	00006517          	auipc	a0,0x6
    8000194c:	d1050513          	addi	a0,a0,-752 # 80007658 <userret+0x5c8>
    80001950:	fffff097          	auipc	ra,0xfffff
    80001954:	bfe080e7          	jalr	-1026(ra) # 8000054e <panic>

0000000080001958 <cpuid>:
{
    80001958:	1141                	addi	sp,sp,-16
    8000195a:	e422                	sd	s0,8(sp)
    8000195c:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    8000195e:	8512                	mv	a0,tp
}
    80001960:	2501                	sext.w	a0,a0
    80001962:	6422                	ld	s0,8(sp)
    80001964:	0141                	addi	sp,sp,16
    80001966:	8082                	ret

0000000080001968 <mycpu>:
mycpu(void) {
    80001968:	1141                	addi	sp,sp,-16
    8000196a:	e422                	sd	s0,8(sp)
    8000196c:	0800                	addi	s0,sp,16
    8000196e:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    80001970:	2781                	sext.w	a5,a5
    80001972:	079e                	slli	a5,a5,0x7
}
    80001974:	00010517          	auipc	a0,0x10
    80001978:	f8c50513          	addi	a0,a0,-116 # 80011900 <cpus>
    8000197c:	953e                	add	a0,a0,a5
    8000197e:	6422                	ld	s0,8(sp)
    80001980:	0141                	addi	sp,sp,16
    80001982:	8082                	ret

0000000080001984 <myproc>:
myproc(void) {
    80001984:	1101                	addi	sp,sp,-32
    80001986:	ec06                	sd	ra,24(sp)
    80001988:	e822                	sd	s0,16(sp)
    8000198a:	e426                	sd	s1,8(sp)
    8000198c:	1000                	addi	s0,sp,32
  push_off();
    8000198e:	fffff097          	auipc	ra,0xfffff
    80001992:	048080e7          	jalr	72(ra) # 800009d6 <push_off>
    80001996:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    80001998:	2781                	sext.w	a5,a5
    8000199a:	079e                	slli	a5,a5,0x7
    8000199c:	00010717          	auipc	a4,0x10
    800019a0:	f4c70713          	addi	a4,a4,-180 # 800118e8 <pid_lock>
    800019a4:	97ba                	add	a5,a5,a4
    800019a6:	6f84                	ld	s1,24(a5)
  pop_off();
    800019a8:	fffff097          	auipc	ra,0xfffff
    800019ac:	07a080e7          	jalr	122(ra) # 80000a22 <pop_off>
}
    800019b0:	8526                	mv	a0,s1
    800019b2:	60e2                	ld	ra,24(sp)
    800019b4:	6442                	ld	s0,16(sp)
    800019b6:	64a2                	ld	s1,8(sp)
    800019b8:	6105                	addi	sp,sp,32
    800019ba:	8082                	ret

00000000800019bc <forkret>:
{
    800019bc:	1141                	addi	sp,sp,-16
    800019be:	e406                	sd	ra,8(sp)
    800019c0:	e022                	sd	s0,0(sp)
    800019c2:	0800                	addi	s0,sp,16
  release(&myproc()->lock);
    800019c4:	00000097          	auipc	ra,0x0
    800019c8:	fc0080e7          	jalr	-64(ra) # 80001984 <myproc>
    800019cc:	fffff097          	auipc	ra,0xfffff
    800019d0:	15a080e7          	jalr	346(ra) # 80000b26 <release>
  if (first) {
    800019d4:	00006797          	auipc	a5,0x6
    800019d8:	6607a783          	lw	a5,1632(a5) # 80008034 <first.1653>
    800019dc:	eb89                	bnez	a5,800019ee <forkret+0x32>
  usertrapret();
    800019de:	00001097          	auipc	ra,0x1
    800019e2:	bac080e7          	jalr	-1108(ra) # 8000258a <usertrapret>
}
    800019e6:	60a2                	ld	ra,8(sp)
    800019e8:	6402                	ld	s0,0(sp)
    800019ea:	0141                	addi	sp,sp,16
    800019ec:	8082                	ret
    first = 0;
    800019ee:	00006797          	auipc	a5,0x6
    800019f2:	6407a323          	sw	zero,1606(a5) # 80008034 <first.1653>
    fsinit(ROOTDEV);
    800019f6:	4505                	li	a0,1
    800019f8:	00002097          	auipc	ra,0x2
    800019fc:	8ca080e7          	jalr	-1846(ra) # 800032c2 <fsinit>
    80001a00:	bff9                	j	800019de <forkret+0x22>

0000000080001a02 <allocpid>:
allocpid() {
    80001a02:	1101                	addi	sp,sp,-32
    80001a04:	ec06                	sd	ra,24(sp)
    80001a06:	e822                	sd	s0,16(sp)
    80001a08:	e426                	sd	s1,8(sp)
    80001a0a:	e04a                	sd	s2,0(sp)
    80001a0c:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001a0e:	00010917          	auipc	s2,0x10
    80001a12:	eda90913          	addi	s2,s2,-294 # 800118e8 <pid_lock>
    80001a16:	854a                	mv	a0,s2
    80001a18:	fffff097          	auipc	ra,0xfffff
    80001a1c:	0ba080e7          	jalr	186(ra) # 80000ad2 <acquire>
  pid = nextpid;
    80001a20:	00006797          	auipc	a5,0x6
    80001a24:	61878793          	addi	a5,a5,1560 # 80008038 <nextpid>
    80001a28:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001a2a:	0014871b          	addiw	a4,s1,1
    80001a2e:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001a30:	854a                	mv	a0,s2
    80001a32:	fffff097          	auipc	ra,0xfffff
    80001a36:	0f4080e7          	jalr	244(ra) # 80000b26 <release>
}
    80001a3a:	8526                	mv	a0,s1
    80001a3c:	60e2                	ld	ra,24(sp)
    80001a3e:	6442                	ld	s0,16(sp)
    80001a40:	64a2                	ld	s1,8(sp)
    80001a42:	6902                	ld	s2,0(sp)
    80001a44:	6105                	addi	sp,sp,32
    80001a46:	8082                	ret

0000000080001a48 <proc_pagetable>:
{
    80001a48:	1101                	addi	sp,sp,-32
    80001a4a:	ec06                	sd	ra,24(sp)
    80001a4c:	e822                	sd	s0,16(sp)
    80001a4e:	e426                	sd	s1,8(sp)
    80001a50:	e04a                	sd	s2,0(sp)
    80001a52:	1000                	addi	s0,sp,32
    80001a54:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001a56:	00000097          	auipc	ra,0x0
    80001a5a:	954080e7          	jalr	-1708(ra) # 800013aa <uvmcreate>
    80001a5e:	84aa                	mv	s1,a0
  mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001a60:	4729                	li	a4,10
    80001a62:	00005697          	auipc	a3,0x5
    80001a66:	59e68693          	addi	a3,a3,1438 # 80007000 <trampoline>
    80001a6a:	6605                	lui	a2,0x1
    80001a6c:	040005b7          	lui	a1,0x4000
    80001a70:	15fd                	addi	a1,a1,-1
    80001a72:	05b2                	slli	a1,a1,0xc
    80001a74:	fffff097          	auipc	ra,0xfffff
    80001a78:	6d6080e7          	jalr	1750(ra) # 8000114a <mappages>
  mappages(pagetable, TRAPFRAME, PGSIZE,
    80001a7c:	4719                	li	a4,6
    80001a7e:	05893683          	ld	a3,88(s2)
    80001a82:	6605                	lui	a2,0x1
    80001a84:	020005b7          	lui	a1,0x2000
    80001a88:	15fd                	addi	a1,a1,-1
    80001a8a:	05b6                	slli	a1,a1,0xd
    80001a8c:	8526                	mv	a0,s1
    80001a8e:	fffff097          	auipc	ra,0xfffff
    80001a92:	6bc080e7          	jalr	1724(ra) # 8000114a <mappages>
}
    80001a96:	8526                	mv	a0,s1
    80001a98:	60e2                	ld	ra,24(sp)
    80001a9a:	6442                	ld	s0,16(sp)
    80001a9c:	64a2                	ld	s1,8(sp)
    80001a9e:	6902                	ld	s2,0(sp)
    80001aa0:	6105                	addi	sp,sp,32
    80001aa2:	8082                	ret

0000000080001aa4 <allocproc>:
{
    80001aa4:	1101                	addi	sp,sp,-32
    80001aa6:	ec06                	sd	ra,24(sp)
    80001aa8:	e822                	sd	s0,16(sp)
    80001aaa:	e426                	sd	s1,8(sp)
    80001aac:	e04a                	sd	s2,0(sp)
    80001aae:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ab0:	00010497          	auipc	s1,0x10
    80001ab4:	25048493          	addi	s1,s1,592 # 80011d00 <proc>
    80001ab8:	00016917          	auipc	s2,0x16
    80001abc:	c4890913          	addi	s2,s2,-952 # 80017700 <tickslock>
    acquire(&p->lock);
    80001ac0:	8526                	mv	a0,s1
    80001ac2:	fffff097          	auipc	ra,0xfffff
    80001ac6:	010080e7          	jalr	16(ra) # 80000ad2 <acquire>
    if(p->state == UNUSED) {
    80001aca:	4c9c                	lw	a5,24(s1)
    80001acc:	cf81                	beqz	a5,80001ae4 <allocproc+0x40>
      release(&p->lock);
    80001ace:	8526                	mv	a0,s1
    80001ad0:	fffff097          	auipc	ra,0xfffff
    80001ad4:	056080e7          	jalr	86(ra) # 80000b26 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ad8:	16848493          	addi	s1,s1,360
    80001adc:	ff2492e3          	bne	s1,s2,80001ac0 <allocproc+0x1c>
  return 0;
    80001ae0:	4481                	li	s1,0
    80001ae2:	a0a9                	j	80001b2c <allocproc+0x88>
  p->pid = allocpid();
    80001ae4:	00000097          	auipc	ra,0x0
    80001ae8:	f1e080e7          	jalr	-226(ra) # 80001a02 <allocpid>
    80001aec:	dc88                	sw	a0,56(s1)
  if((p->tf = (struct trapframe *)kalloc()) == 0){
    80001aee:	fffff097          	auipc	ra,0xfffff
    80001af2:	e72080e7          	jalr	-398(ra) # 80000960 <kalloc>
    80001af6:	892a                	mv	s2,a0
    80001af8:	eca8                	sd	a0,88(s1)
    80001afa:	c121                	beqz	a0,80001b3a <allocproc+0x96>
  p->pagetable = proc_pagetable(p);
    80001afc:	8526                	mv	a0,s1
    80001afe:	00000097          	auipc	ra,0x0
    80001b02:	f4a080e7          	jalr	-182(ra) # 80001a48 <proc_pagetable>
    80001b06:	e8a8                	sd	a0,80(s1)
  memset(&p->context, 0, sizeof p->context);
    80001b08:	07000613          	li	a2,112
    80001b0c:	4581                	li	a1,0
    80001b0e:	06048513          	addi	a0,s1,96
    80001b12:	fffff097          	auipc	ra,0xfffff
    80001b16:	05c080e7          	jalr	92(ra) # 80000b6e <memset>
  p->context.ra = (uint64)forkret;
    80001b1a:	00000797          	auipc	a5,0x0
    80001b1e:	ea278793          	addi	a5,a5,-350 # 800019bc <forkret>
    80001b22:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001b24:	60bc                	ld	a5,64(s1)
    80001b26:	6705                	lui	a4,0x1
    80001b28:	97ba                	add	a5,a5,a4
    80001b2a:	f4bc                	sd	a5,104(s1)
}
    80001b2c:	8526                	mv	a0,s1
    80001b2e:	60e2                	ld	ra,24(sp)
    80001b30:	6442                	ld	s0,16(sp)
    80001b32:	64a2                	ld	s1,8(sp)
    80001b34:	6902                	ld	s2,0(sp)
    80001b36:	6105                	addi	sp,sp,32
    80001b38:	8082                	ret
    release(&p->lock);
    80001b3a:	8526                	mv	a0,s1
    80001b3c:	fffff097          	auipc	ra,0xfffff
    80001b40:	fea080e7          	jalr	-22(ra) # 80000b26 <release>
    return 0;
    80001b44:	84ca                	mv	s1,s2
    80001b46:	b7dd                	j	80001b2c <allocproc+0x88>

0000000080001b48 <proc_freepagetable>:
{
    80001b48:	1101                	addi	sp,sp,-32
    80001b4a:	ec06                	sd	ra,24(sp)
    80001b4c:	e822                	sd	s0,16(sp)
    80001b4e:	e426                	sd	s1,8(sp)
    80001b50:	e04a                	sd	s2,0(sp)
    80001b52:	1000                	addi	s0,sp,32
    80001b54:	84aa                	mv	s1,a0
    80001b56:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, PGSIZE, 0);
    80001b58:	4681                	li	a3,0
    80001b5a:	6605                	lui	a2,0x1
    80001b5c:	040005b7          	lui	a1,0x4000
    80001b60:	15fd                	addi	a1,a1,-1
    80001b62:	05b2                	slli	a1,a1,0xc
    80001b64:	fffff097          	auipc	ra,0xfffff
    80001b68:	77e080e7          	jalr	1918(ra) # 800012e2 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, PGSIZE, 0);
    80001b6c:	4681                	li	a3,0
    80001b6e:	6605                	lui	a2,0x1
    80001b70:	020005b7          	lui	a1,0x2000
    80001b74:	15fd                	addi	a1,a1,-1
    80001b76:	05b6                	slli	a1,a1,0xd
    80001b78:	8526                	mv	a0,s1
    80001b7a:	fffff097          	auipc	ra,0xfffff
    80001b7e:	768080e7          	jalr	1896(ra) # 800012e2 <uvmunmap>
  if(sz > 0)
    80001b82:	00091863          	bnez	s2,80001b92 <proc_freepagetable+0x4a>
}
    80001b86:	60e2                	ld	ra,24(sp)
    80001b88:	6442                	ld	s0,16(sp)
    80001b8a:	64a2                	ld	s1,8(sp)
    80001b8c:	6902                	ld	s2,0(sp)
    80001b8e:	6105                	addi	sp,sp,32
    80001b90:	8082                	ret
    uvmfree(pagetable, sz);
    80001b92:	85ca                	mv	a1,s2
    80001b94:	8526                	mv	a0,s1
    80001b96:	00000097          	auipc	ra,0x0
    80001b9a:	9b2080e7          	jalr	-1614(ra) # 80001548 <uvmfree>
}
    80001b9e:	b7e5                	j	80001b86 <proc_freepagetable+0x3e>

0000000080001ba0 <freeproc>:
{
    80001ba0:	1101                	addi	sp,sp,-32
    80001ba2:	ec06                	sd	ra,24(sp)
    80001ba4:	e822                	sd	s0,16(sp)
    80001ba6:	e426                	sd	s1,8(sp)
    80001ba8:	1000                	addi	s0,sp,32
    80001baa:	84aa                	mv	s1,a0
  if(p->tf)
    80001bac:	6d28                	ld	a0,88(a0)
    80001bae:	c509                	beqz	a0,80001bb8 <freeproc+0x18>
    kfree((void*)p->tf);
    80001bb0:	fffff097          	auipc	ra,0xfffff
    80001bb4:	cb4080e7          	jalr	-844(ra) # 80000864 <kfree>
  p->tf = 0;
    80001bb8:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001bbc:	68a8                	ld	a0,80(s1)
    80001bbe:	c511                	beqz	a0,80001bca <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001bc0:	64ac                	ld	a1,72(s1)
    80001bc2:	00000097          	auipc	ra,0x0
    80001bc6:	f86080e7          	jalr	-122(ra) # 80001b48 <proc_freepagetable>
  p->pagetable = 0;
    80001bca:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001bce:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001bd2:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    80001bd6:	0204b023          	sd	zero,32(s1)
  p->name[0] = 0;
    80001bda:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001bde:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    80001be2:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    80001be6:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    80001bea:	0004ac23          	sw	zero,24(s1)
}
    80001bee:	60e2                	ld	ra,24(sp)
    80001bf0:	6442                	ld	s0,16(sp)
    80001bf2:	64a2                	ld	s1,8(sp)
    80001bf4:	6105                	addi	sp,sp,32
    80001bf6:	8082                	ret

0000000080001bf8 <userinit>:
{
    80001bf8:	1101                	addi	sp,sp,-32
    80001bfa:	ec06                	sd	ra,24(sp)
    80001bfc:	e822                	sd	s0,16(sp)
    80001bfe:	e426                	sd	s1,8(sp)
    80001c00:	1000                	addi	s0,sp,32
  p = allocproc();
    80001c02:	00000097          	auipc	ra,0x0
    80001c06:	ea2080e7          	jalr	-350(ra) # 80001aa4 <allocproc>
    80001c0a:	84aa                	mv	s1,a0
  initproc = p;
    80001c0c:	00024797          	auipc	a5,0x24
    80001c10:	40a7b223          	sd	a0,1028(a5) # 80026010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001c14:	03300613          	li	a2,51
    80001c18:	00006597          	auipc	a1,0x6
    80001c1c:	3e858593          	addi	a1,a1,1000 # 80008000 <initcode>
    80001c20:	6928                	ld	a0,80(a0)
    80001c22:	fffff097          	auipc	ra,0xfffff
    80001c26:	7c6080e7          	jalr	1990(ra) # 800013e8 <uvminit>
  p->sz = PGSIZE;
    80001c2a:	6785                	lui	a5,0x1
    80001c2c:	e4bc                	sd	a5,72(s1)
  p->tf->epc = 0;      // user program counter
    80001c2e:	6cb8                	ld	a4,88(s1)
    80001c30:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->tf->sp = PGSIZE;  // user stack pointer
    80001c34:	6cb8                	ld	a4,88(s1)
    80001c36:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001c38:	4641                	li	a2,16
    80001c3a:	00006597          	auipc	a1,0x6
    80001c3e:	a2658593          	addi	a1,a1,-1498 # 80007660 <userret+0x5d0>
    80001c42:	15848513          	addi	a0,s1,344
    80001c46:	fffff097          	auipc	ra,0xfffff
    80001c4a:	07e080e7          	jalr	126(ra) # 80000cc4 <safestrcpy>
  p->cwd = namei("/");
    80001c4e:	00006517          	auipc	a0,0x6
    80001c52:	a2250513          	addi	a0,a0,-1502 # 80007670 <userret+0x5e0>
    80001c56:	00002097          	auipc	ra,0x2
    80001c5a:	06e080e7          	jalr	110(ra) # 80003cc4 <namei>
    80001c5e:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001c62:	4789                	li	a5,2
    80001c64:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001c66:	8526                	mv	a0,s1
    80001c68:	fffff097          	auipc	ra,0xfffff
    80001c6c:	ebe080e7          	jalr	-322(ra) # 80000b26 <release>
}
    80001c70:	60e2                	ld	ra,24(sp)
    80001c72:	6442                	ld	s0,16(sp)
    80001c74:	64a2                	ld	s1,8(sp)
    80001c76:	6105                	addi	sp,sp,32
    80001c78:	8082                	ret

0000000080001c7a <growproc>:
{
    80001c7a:	1101                	addi	sp,sp,-32
    80001c7c:	ec06                	sd	ra,24(sp)
    80001c7e:	e822                	sd	s0,16(sp)
    80001c80:	e426                	sd	s1,8(sp)
    80001c82:	e04a                	sd	s2,0(sp)
    80001c84:	1000                	addi	s0,sp,32
    80001c86:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	cfc080e7          	jalr	-772(ra) # 80001984 <myproc>
    80001c90:	892a                	mv	s2,a0
  sz = p->sz;
    80001c92:	652c                	ld	a1,72(a0)
    80001c94:	0005861b          	sext.w	a2,a1
  if(n > 0){
    80001c98:	00904f63          	bgtz	s1,80001cb6 <growproc+0x3c>
  } else if(n < 0){
    80001c9c:	0204cc63          	bltz	s1,80001cd4 <growproc+0x5a>
  p->sz = sz;
    80001ca0:	1602                	slli	a2,a2,0x20
    80001ca2:	9201                	srli	a2,a2,0x20
    80001ca4:	04c93423          	sd	a2,72(s2)
  return 0;
    80001ca8:	4501                	li	a0,0
}
    80001caa:	60e2                	ld	ra,24(sp)
    80001cac:	6442                	ld	s0,16(sp)
    80001cae:	64a2                	ld	s1,8(sp)
    80001cb0:	6902                	ld	s2,0(sp)
    80001cb2:	6105                	addi	sp,sp,32
    80001cb4:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001cb6:	9e25                	addw	a2,a2,s1
    80001cb8:	1602                	slli	a2,a2,0x20
    80001cba:	9201                	srli	a2,a2,0x20
    80001cbc:	1582                	slli	a1,a1,0x20
    80001cbe:	9181                	srli	a1,a1,0x20
    80001cc0:	6928                	ld	a0,80(a0)
    80001cc2:	fffff097          	auipc	ra,0xfffff
    80001cc6:	7dc080e7          	jalr	2012(ra) # 8000149e <uvmalloc>
    80001cca:	0005061b          	sext.w	a2,a0
    80001cce:	fa69                	bnez	a2,80001ca0 <growproc+0x26>
      return -1;
    80001cd0:	557d                	li	a0,-1
    80001cd2:	bfe1                	j	80001caa <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001cd4:	9e25                	addw	a2,a2,s1
    80001cd6:	1602                	slli	a2,a2,0x20
    80001cd8:	9201                	srli	a2,a2,0x20
    80001cda:	1582                	slli	a1,a1,0x20
    80001cdc:	9181                	srli	a1,a1,0x20
    80001cde:	6928                	ld	a0,80(a0)
    80001ce0:	fffff097          	auipc	ra,0xfffff
    80001ce4:	77a080e7          	jalr	1914(ra) # 8000145a <uvmdealloc>
    80001ce8:	0005061b          	sext.w	a2,a0
    80001cec:	bf55                	j	80001ca0 <growproc+0x26>

0000000080001cee <fork>:
{
    80001cee:	7179                	addi	sp,sp,-48
    80001cf0:	f406                	sd	ra,40(sp)
    80001cf2:	f022                	sd	s0,32(sp)
    80001cf4:	ec26                	sd	s1,24(sp)
    80001cf6:	e84a                	sd	s2,16(sp)
    80001cf8:	e44e                	sd	s3,8(sp)
    80001cfa:	e052                	sd	s4,0(sp)
    80001cfc:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001cfe:	00000097          	auipc	ra,0x0
    80001d02:	c86080e7          	jalr	-890(ra) # 80001984 <myproc>
    80001d06:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	d9c080e7          	jalr	-612(ra) # 80001aa4 <allocproc>
    80001d10:	c175                	beqz	a0,80001df4 <fork+0x106>
    80001d12:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001d14:	04893603          	ld	a2,72(s2)
    80001d18:	692c                	ld	a1,80(a0)
    80001d1a:	05093503          	ld	a0,80(s2)
    80001d1e:	00000097          	auipc	ra,0x0
    80001d22:	858080e7          	jalr	-1960(ra) # 80001576 <uvmcopy>
    80001d26:	04054863          	bltz	a0,80001d76 <fork+0x88>
  np->sz = p->sz;
    80001d2a:	04893783          	ld	a5,72(s2)
    80001d2e:	04f9b423          	sd	a5,72(s3) # 4000048 <_entry-0x7bffffb8>
  np->parent = p;
    80001d32:	0329b023          	sd	s2,32(s3)
  *(np->tf) = *(p->tf);
    80001d36:	05893683          	ld	a3,88(s2)
    80001d3a:	87b6                	mv	a5,a3
    80001d3c:	0589b703          	ld	a4,88(s3)
    80001d40:	12068693          	addi	a3,a3,288
    80001d44:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001d48:	6788                	ld	a0,8(a5)
    80001d4a:	6b8c                	ld	a1,16(a5)
    80001d4c:	6f90                	ld	a2,24(a5)
    80001d4e:	01073023          	sd	a6,0(a4)
    80001d52:	e708                	sd	a0,8(a4)
    80001d54:	eb0c                	sd	a1,16(a4)
    80001d56:	ef10                	sd	a2,24(a4)
    80001d58:	02078793          	addi	a5,a5,32
    80001d5c:	02070713          	addi	a4,a4,32
    80001d60:	fed792e3          	bne	a5,a3,80001d44 <fork+0x56>
  np->tf->a0 = 0;
    80001d64:	0589b783          	ld	a5,88(s3)
    80001d68:	0607b823          	sd	zero,112(a5)
    80001d6c:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    80001d70:	15000a13          	li	s4,336
    80001d74:	a03d                	j	80001da2 <fork+0xb4>
    freeproc(np);
    80001d76:	854e                	mv	a0,s3
    80001d78:	00000097          	auipc	ra,0x0
    80001d7c:	e28080e7          	jalr	-472(ra) # 80001ba0 <freeproc>
    release(&np->lock);
    80001d80:	854e                	mv	a0,s3
    80001d82:	fffff097          	auipc	ra,0xfffff
    80001d86:	da4080e7          	jalr	-604(ra) # 80000b26 <release>
    return -1;
    80001d8a:	54fd                	li	s1,-1
    80001d8c:	a899                	j	80001de2 <fork+0xf4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001d8e:	00002097          	auipc	ra,0x2
    80001d92:	5c2080e7          	jalr	1474(ra) # 80004350 <filedup>
    80001d96:	009987b3          	add	a5,s3,s1
    80001d9a:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    80001d9c:	04a1                	addi	s1,s1,8
    80001d9e:	01448763          	beq	s1,s4,80001dac <fork+0xbe>
    if(p->ofile[i])
    80001da2:	009907b3          	add	a5,s2,s1
    80001da6:	6388                	ld	a0,0(a5)
    80001da8:	f17d                	bnez	a0,80001d8e <fork+0xa0>
    80001daa:	bfcd                	j	80001d9c <fork+0xae>
  np->cwd = idup(p->cwd);
    80001dac:	15093503          	ld	a0,336(s2)
    80001db0:	00001097          	auipc	ra,0x1
    80001db4:	74c080e7          	jalr	1868(ra) # 800034fc <idup>
    80001db8:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001dbc:	4641                	li	a2,16
    80001dbe:	15890593          	addi	a1,s2,344
    80001dc2:	15898513          	addi	a0,s3,344
    80001dc6:	fffff097          	auipc	ra,0xfffff
    80001dca:	efe080e7          	jalr	-258(ra) # 80000cc4 <safestrcpy>
  pid = np->pid;
    80001dce:	0389a483          	lw	s1,56(s3)
  np->state = RUNNABLE;
    80001dd2:	4789                	li	a5,2
    80001dd4:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001dd8:	854e                	mv	a0,s3
    80001dda:	fffff097          	auipc	ra,0xfffff
    80001dde:	d4c080e7          	jalr	-692(ra) # 80000b26 <release>
}
    80001de2:	8526                	mv	a0,s1
    80001de4:	70a2                	ld	ra,40(sp)
    80001de6:	7402                	ld	s0,32(sp)
    80001de8:	64e2                	ld	s1,24(sp)
    80001dea:	6942                	ld	s2,16(sp)
    80001dec:	69a2                	ld	s3,8(sp)
    80001dee:	6a02                	ld	s4,0(sp)
    80001df0:	6145                	addi	sp,sp,48
    80001df2:	8082                	ret
    return -1;
    80001df4:	54fd                	li	s1,-1
    80001df6:	b7f5                	j	80001de2 <fork+0xf4>

0000000080001df8 <reparent>:
{
    80001df8:	7179                	addi	sp,sp,-48
    80001dfa:	f406                	sd	ra,40(sp)
    80001dfc:	f022                	sd	s0,32(sp)
    80001dfe:	ec26                	sd	s1,24(sp)
    80001e00:	e84a                	sd	s2,16(sp)
    80001e02:	e44e                	sd	s3,8(sp)
    80001e04:	e052                	sd	s4,0(sp)
    80001e06:	1800                	addi	s0,sp,48
    80001e08:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001e0a:	00010497          	auipc	s1,0x10
    80001e0e:	ef648493          	addi	s1,s1,-266 # 80011d00 <proc>
      pp->parent = initproc;
    80001e12:	00024a17          	auipc	s4,0x24
    80001e16:	1fea0a13          	addi	s4,s4,510 # 80026010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001e1a:	00016997          	auipc	s3,0x16
    80001e1e:	8e698993          	addi	s3,s3,-1818 # 80017700 <tickslock>
    80001e22:	a029                	j	80001e2c <reparent+0x34>
    80001e24:	16848493          	addi	s1,s1,360
    80001e28:	03348363          	beq	s1,s3,80001e4e <reparent+0x56>
    if(pp->parent == p){
    80001e2c:	709c                	ld	a5,32(s1)
    80001e2e:	ff279be3          	bne	a5,s2,80001e24 <reparent+0x2c>
      acquire(&pp->lock);
    80001e32:	8526                	mv	a0,s1
    80001e34:	fffff097          	auipc	ra,0xfffff
    80001e38:	c9e080e7          	jalr	-866(ra) # 80000ad2 <acquire>
      pp->parent = initproc;
    80001e3c:	000a3783          	ld	a5,0(s4)
    80001e40:	f09c                	sd	a5,32(s1)
      release(&pp->lock);
    80001e42:	8526                	mv	a0,s1
    80001e44:	fffff097          	auipc	ra,0xfffff
    80001e48:	ce2080e7          	jalr	-798(ra) # 80000b26 <release>
    80001e4c:	bfe1                	j	80001e24 <reparent+0x2c>
}
    80001e4e:	70a2                	ld	ra,40(sp)
    80001e50:	7402                	ld	s0,32(sp)
    80001e52:	64e2                	ld	s1,24(sp)
    80001e54:	6942                	ld	s2,16(sp)
    80001e56:	69a2                	ld	s3,8(sp)
    80001e58:	6a02                	ld	s4,0(sp)
    80001e5a:	6145                	addi	sp,sp,48
    80001e5c:	8082                	ret

0000000080001e5e <scheduler>:
{
    80001e5e:	7139                	addi	sp,sp,-64
    80001e60:	fc06                	sd	ra,56(sp)
    80001e62:	f822                	sd	s0,48(sp)
    80001e64:	f426                	sd	s1,40(sp)
    80001e66:	f04a                	sd	s2,32(sp)
    80001e68:	ec4e                	sd	s3,24(sp)
    80001e6a:	e852                	sd	s4,16(sp)
    80001e6c:	e456                	sd	s5,8(sp)
    80001e6e:	e05a                	sd	s6,0(sp)
    80001e70:	0080                	addi	s0,sp,64
    80001e72:	8792                	mv	a5,tp
  int id = r_tp();
    80001e74:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001e76:	00779a93          	slli	s5,a5,0x7
    80001e7a:	00010717          	auipc	a4,0x10
    80001e7e:	a6e70713          	addi	a4,a4,-1426 # 800118e8 <pid_lock>
    80001e82:	9756                	add	a4,a4,s5
    80001e84:	00073c23          	sd	zero,24(a4)
        swtch(&c->scheduler, &p->context);
    80001e88:	00010717          	auipc	a4,0x10
    80001e8c:	a8070713          	addi	a4,a4,-1408 # 80011908 <cpus+0x8>
    80001e90:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001e92:	4989                	li	s3,2
        p->state = RUNNING;
    80001e94:	4b0d                	li	s6,3
        c->proc = p;
    80001e96:	079e                	slli	a5,a5,0x7
    80001e98:	00010a17          	auipc	s4,0x10
    80001e9c:	a50a0a13          	addi	s4,s4,-1456 # 800118e8 <pid_lock>
    80001ea0:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ea2:	00016917          	auipc	s2,0x16
    80001ea6:	85e90913          	addi	s2,s2,-1954 # 80017700 <tickslock>
  asm volatile("csrr %0, sie" : "=r" (x) );
    80001eaa:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80001eae:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80001eb2:	10479073          	csrw	sie,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001eb6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001eba:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ebe:	10079073          	csrw	sstatus,a5
    80001ec2:	00010497          	auipc	s1,0x10
    80001ec6:	e3e48493          	addi	s1,s1,-450 # 80011d00 <proc>
    80001eca:	a03d                	j	80001ef8 <scheduler+0x9a>
        p->state = RUNNING;
    80001ecc:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001ed0:	009a3c23          	sd	s1,24(s4)
        swtch(&c->scheduler, &p->context);
    80001ed4:	06048593          	addi	a1,s1,96
    80001ed8:	8556                	mv	a0,s5
    80001eda:	00000097          	auipc	ra,0x0
    80001ede:	606080e7          	jalr	1542(ra) # 800024e0 <swtch>
        c->proc = 0;
    80001ee2:	000a3c23          	sd	zero,24(s4)
      release(&p->lock);
    80001ee6:	8526                	mv	a0,s1
    80001ee8:	fffff097          	auipc	ra,0xfffff
    80001eec:	c3e080e7          	jalr	-962(ra) # 80000b26 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001ef0:	16848493          	addi	s1,s1,360
    80001ef4:	fb248be3          	beq	s1,s2,80001eaa <scheduler+0x4c>
      acquire(&p->lock);
    80001ef8:	8526                	mv	a0,s1
    80001efa:	fffff097          	auipc	ra,0xfffff
    80001efe:	bd8080e7          	jalr	-1064(ra) # 80000ad2 <acquire>
      if(p->state == RUNNABLE) {
    80001f02:	4c9c                	lw	a5,24(s1)
    80001f04:	ff3791e3          	bne	a5,s3,80001ee6 <scheduler+0x88>
    80001f08:	b7d1                	j	80001ecc <scheduler+0x6e>

0000000080001f0a <sched>:
{
    80001f0a:	7179                	addi	sp,sp,-48
    80001f0c:	f406                	sd	ra,40(sp)
    80001f0e:	f022                	sd	s0,32(sp)
    80001f10:	ec26                	sd	s1,24(sp)
    80001f12:	e84a                	sd	s2,16(sp)
    80001f14:	e44e                	sd	s3,8(sp)
    80001f16:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	a6c080e7          	jalr	-1428(ra) # 80001984 <myproc>
    80001f20:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001f22:	fffff097          	auipc	ra,0xfffff
    80001f26:	b70080e7          	jalr	-1168(ra) # 80000a92 <holding>
    80001f2a:	c93d                	beqz	a0,80001fa0 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f2c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001f2e:	2781                	sext.w	a5,a5
    80001f30:	079e                	slli	a5,a5,0x7
    80001f32:	00010717          	auipc	a4,0x10
    80001f36:	9b670713          	addi	a4,a4,-1610 # 800118e8 <pid_lock>
    80001f3a:	97ba                	add	a5,a5,a4
    80001f3c:	0907a703          	lw	a4,144(a5)
    80001f40:	4785                	li	a5,1
    80001f42:	06f71763          	bne	a4,a5,80001fb0 <sched+0xa6>
  if(p->state == RUNNING)
    80001f46:	4c98                	lw	a4,24(s1)
    80001f48:	478d                	li	a5,3
    80001f4a:	06f70b63          	beq	a4,a5,80001fc0 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f4e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f52:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001f54:	efb5                	bnez	a5,80001fd0 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001f56:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001f58:	00010917          	auipc	s2,0x10
    80001f5c:	99090913          	addi	s2,s2,-1648 # 800118e8 <pid_lock>
    80001f60:	2781                	sext.w	a5,a5
    80001f62:	079e                	slli	a5,a5,0x7
    80001f64:	97ca                	add	a5,a5,s2
    80001f66:	0947a983          	lw	s3,148(a5)
    80001f6a:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->scheduler);
    80001f6c:	2781                	sext.w	a5,a5
    80001f6e:	079e                	slli	a5,a5,0x7
    80001f70:	00010597          	auipc	a1,0x10
    80001f74:	99858593          	addi	a1,a1,-1640 # 80011908 <cpus+0x8>
    80001f78:	95be                	add	a1,a1,a5
    80001f7a:	06048513          	addi	a0,s1,96
    80001f7e:	00000097          	auipc	ra,0x0
    80001f82:	562080e7          	jalr	1378(ra) # 800024e0 <swtch>
    80001f86:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001f88:	2781                	sext.w	a5,a5
    80001f8a:	079e                	slli	a5,a5,0x7
    80001f8c:	97ca                	add	a5,a5,s2
    80001f8e:	0937aa23          	sw	s3,148(a5)
}
    80001f92:	70a2                	ld	ra,40(sp)
    80001f94:	7402                	ld	s0,32(sp)
    80001f96:	64e2                	ld	s1,24(sp)
    80001f98:	6942                	ld	s2,16(sp)
    80001f9a:	69a2                	ld	s3,8(sp)
    80001f9c:	6145                	addi	sp,sp,48
    80001f9e:	8082                	ret
    panic("sched p->lock");
    80001fa0:	00005517          	auipc	a0,0x5
    80001fa4:	6d850513          	addi	a0,a0,1752 # 80007678 <userret+0x5e8>
    80001fa8:	ffffe097          	auipc	ra,0xffffe
    80001fac:	5a6080e7          	jalr	1446(ra) # 8000054e <panic>
    panic("sched locks");
    80001fb0:	00005517          	auipc	a0,0x5
    80001fb4:	6d850513          	addi	a0,a0,1752 # 80007688 <userret+0x5f8>
    80001fb8:	ffffe097          	auipc	ra,0xffffe
    80001fbc:	596080e7          	jalr	1430(ra) # 8000054e <panic>
    panic("sched running");
    80001fc0:	00005517          	auipc	a0,0x5
    80001fc4:	6d850513          	addi	a0,a0,1752 # 80007698 <userret+0x608>
    80001fc8:	ffffe097          	auipc	ra,0xffffe
    80001fcc:	586080e7          	jalr	1414(ra) # 8000054e <panic>
    panic("sched interruptible");
    80001fd0:	00005517          	auipc	a0,0x5
    80001fd4:	6d850513          	addi	a0,a0,1752 # 800076a8 <userret+0x618>
    80001fd8:	ffffe097          	auipc	ra,0xffffe
    80001fdc:	576080e7          	jalr	1398(ra) # 8000054e <panic>

0000000080001fe0 <exit>:
{
    80001fe0:	7179                	addi	sp,sp,-48
    80001fe2:	f406                	sd	ra,40(sp)
    80001fe4:	f022                	sd	s0,32(sp)
    80001fe6:	ec26                	sd	s1,24(sp)
    80001fe8:	e84a                	sd	s2,16(sp)
    80001fea:	e44e                	sd	s3,8(sp)
    80001fec:	e052                	sd	s4,0(sp)
    80001fee:	1800                	addi	s0,sp,48
    80001ff0:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001ff2:	00000097          	auipc	ra,0x0
    80001ff6:	992080e7          	jalr	-1646(ra) # 80001984 <myproc>
    80001ffa:	89aa                	mv	s3,a0
  if(p == initproc)
    80001ffc:	00024797          	auipc	a5,0x24
    80002000:	0147b783          	ld	a5,20(a5) # 80026010 <initproc>
    80002004:	0d050493          	addi	s1,a0,208
    80002008:	15050913          	addi	s2,a0,336
    8000200c:	02a79363          	bne	a5,a0,80002032 <exit+0x52>
    panic("init exiting");
    80002010:	00005517          	auipc	a0,0x5
    80002014:	6b050513          	addi	a0,a0,1712 # 800076c0 <userret+0x630>
    80002018:	ffffe097          	auipc	ra,0xffffe
    8000201c:	536080e7          	jalr	1334(ra) # 8000054e <panic>
      fileclose(f);
    80002020:	00002097          	auipc	ra,0x2
    80002024:	382080e7          	jalr	898(ra) # 800043a2 <fileclose>
      p->ofile[fd] = 0;
    80002028:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000202c:	04a1                	addi	s1,s1,8
    8000202e:	01248563          	beq	s1,s2,80002038 <exit+0x58>
    if(p->ofile[fd]){
    80002032:	6088                	ld	a0,0(s1)
    80002034:	f575                	bnez	a0,80002020 <exit+0x40>
    80002036:	bfdd                	j	8000202c <exit+0x4c>
  begin_op();
    80002038:	00002097          	auipc	ra,0x2
    8000203c:	e98080e7          	jalr	-360(ra) # 80003ed0 <begin_op>
  iput(p->cwd);
    80002040:	1509b503          	ld	a0,336(s3)
    80002044:	00001097          	auipc	ra,0x1
    80002048:	604080e7          	jalr	1540(ra) # 80003648 <iput>
  end_op();
    8000204c:	00002097          	auipc	ra,0x2
    80002050:	f04080e7          	jalr	-252(ra) # 80003f50 <end_op>
  p->cwd = 0;
    80002054:	1409b823          	sd	zero,336(s3)
  acquire(&initproc->lock);
    80002058:	00024497          	auipc	s1,0x24
    8000205c:	fb848493          	addi	s1,s1,-72 # 80026010 <initproc>
    80002060:	6088                	ld	a0,0(s1)
    80002062:	fffff097          	auipc	ra,0xfffff
    80002066:	a70080e7          	jalr	-1424(ra) # 80000ad2 <acquire>
  wakeup1(initproc);
    8000206a:	6088                	ld	a0,0(s1)
    8000206c:	fffff097          	auipc	ra,0xfffff
    80002070:	7d8080e7          	jalr	2008(ra) # 80001844 <wakeup1>
  release(&initproc->lock);
    80002074:	6088                	ld	a0,0(s1)
    80002076:	fffff097          	auipc	ra,0xfffff
    8000207a:	ab0080e7          	jalr	-1360(ra) # 80000b26 <release>
  acquire(&p->lock);
    8000207e:	854e                	mv	a0,s3
    80002080:	fffff097          	auipc	ra,0xfffff
    80002084:	a52080e7          	jalr	-1454(ra) # 80000ad2 <acquire>
  struct proc *original_parent = p->parent;
    80002088:	0209b483          	ld	s1,32(s3)
  release(&p->lock);
    8000208c:	854e                	mv	a0,s3
    8000208e:	fffff097          	auipc	ra,0xfffff
    80002092:	a98080e7          	jalr	-1384(ra) # 80000b26 <release>
  acquire(&original_parent->lock);
    80002096:	8526                	mv	a0,s1
    80002098:	fffff097          	auipc	ra,0xfffff
    8000209c:	a3a080e7          	jalr	-1478(ra) # 80000ad2 <acquire>
  acquire(&p->lock);
    800020a0:	854e                	mv	a0,s3
    800020a2:	fffff097          	auipc	ra,0xfffff
    800020a6:	a30080e7          	jalr	-1488(ra) # 80000ad2 <acquire>
  reparent(p);
    800020aa:	854e                	mv	a0,s3
    800020ac:	00000097          	auipc	ra,0x0
    800020b0:	d4c080e7          	jalr	-692(ra) # 80001df8 <reparent>
  wakeup1(original_parent);
    800020b4:	8526                	mv	a0,s1
    800020b6:	fffff097          	auipc	ra,0xfffff
    800020ba:	78e080e7          	jalr	1934(ra) # 80001844 <wakeup1>
  p->xstate = status;
    800020be:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800020c2:	4791                	li	a5,4
    800020c4:	00f9ac23          	sw	a5,24(s3)
  release(&original_parent->lock);
    800020c8:	8526                	mv	a0,s1
    800020ca:	fffff097          	auipc	ra,0xfffff
    800020ce:	a5c080e7          	jalr	-1444(ra) # 80000b26 <release>
  sched();
    800020d2:	00000097          	auipc	ra,0x0
    800020d6:	e38080e7          	jalr	-456(ra) # 80001f0a <sched>
  panic("zombie exit");
    800020da:	00005517          	auipc	a0,0x5
    800020de:	5f650513          	addi	a0,a0,1526 # 800076d0 <userret+0x640>
    800020e2:	ffffe097          	auipc	ra,0xffffe
    800020e6:	46c080e7          	jalr	1132(ra) # 8000054e <panic>

00000000800020ea <yield>:
{
    800020ea:	1101                	addi	sp,sp,-32
    800020ec:	ec06                	sd	ra,24(sp)
    800020ee:	e822                	sd	s0,16(sp)
    800020f0:	e426                	sd	s1,8(sp)
    800020f2:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800020f4:	00000097          	auipc	ra,0x0
    800020f8:	890080e7          	jalr	-1904(ra) # 80001984 <myproc>
    800020fc:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800020fe:	fffff097          	auipc	ra,0xfffff
    80002102:	9d4080e7          	jalr	-1580(ra) # 80000ad2 <acquire>
  p->state = RUNNABLE;
    80002106:	4789                	li	a5,2
    80002108:	cc9c                	sw	a5,24(s1)
  sched();
    8000210a:	00000097          	auipc	ra,0x0
    8000210e:	e00080e7          	jalr	-512(ra) # 80001f0a <sched>
  release(&p->lock);
    80002112:	8526                	mv	a0,s1
    80002114:	fffff097          	auipc	ra,0xfffff
    80002118:	a12080e7          	jalr	-1518(ra) # 80000b26 <release>
}
    8000211c:	60e2                	ld	ra,24(sp)
    8000211e:	6442                	ld	s0,16(sp)
    80002120:	64a2                	ld	s1,8(sp)
    80002122:	6105                	addi	sp,sp,32
    80002124:	8082                	ret

0000000080002126 <sleep>:
{
    80002126:	7179                	addi	sp,sp,-48
    80002128:	f406                	sd	ra,40(sp)
    8000212a:	f022                	sd	s0,32(sp)
    8000212c:	ec26                	sd	s1,24(sp)
    8000212e:	e84a                	sd	s2,16(sp)
    80002130:	e44e                	sd	s3,8(sp)
    80002132:	1800                	addi	s0,sp,48
    80002134:	89aa                	mv	s3,a0
    80002136:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002138:	00000097          	auipc	ra,0x0
    8000213c:	84c080e7          	jalr	-1972(ra) # 80001984 <myproc>
    80002140:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    80002142:	05250663          	beq	a0,s2,8000218e <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    80002146:	fffff097          	auipc	ra,0xfffff
    8000214a:	98c080e7          	jalr	-1652(ra) # 80000ad2 <acquire>
    release(lk);
    8000214e:	854a                	mv	a0,s2
    80002150:	fffff097          	auipc	ra,0xfffff
    80002154:	9d6080e7          	jalr	-1578(ra) # 80000b26 <release>
  p->chan = chan;
    80002158:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    8000215c:	4785                	li	a5,1
    8000215e:	cc9c                	sw	a5,24(s1)
  sched();
    80002160:	00000097          	auipc	ra,0x0
    80002164:	daa080e7          	jalr	-598(ra) # 80001f0a <sched>
  p->chan = 0;
    80002168:	0204b423          	sd	zero,40(s1)
    release(&p->lock);
    8000216c:	8526                	mv	a0,s1
    8000216e:	fffff097          	auipc	ra,0xfffff
    80002172:	9b8080e7          	jalr	-1608(ra) # 80000b26 <release>
    acquire(lk);
    80002176:	854a                	mv	a0,s2
    80002178:	fffff097          	auipc	ra,0xfffff
    8000217c:	95a080e7          	jalr	-1702(ra) # 80000ad2 <acquire>
}
    80002180:	70a2                	ld	ra,40(sp)
    80002182:	7402                	ld	s0,32(sp)
    80002184:	64e2                	ld	s1,24(sp)
    80002186:	6942                	ld	s2,16(sp)
    80002188:	69a2                	ld	s3,8(sp)
    8000218a:	6145                	addi	sp,sp,48
    8000218c:	8082                	ret
  p->chan = chan;
    8000218e:	03353423          	sd	s3,40(a0)
  p->state = SLEEPING;
    80002192:	4785                	li	a5,1
    80002194:	cd1c                	sw	a5,24(a0)
  sched();
    80002196:	00000097          	auipc	ra,0x0
    8000219a:	d74080e7          	jalr	-652(ra) # 80001f0a <sched>
  p->chan = 0;
    8000219e:	0204b423          	sd	zero,40(s1)
  if(lk != &p->lock){
    800021a2:	bff9                	j	80002180 <sleep+0x5a>

00000000800021a4 <wait>:
{
    800021a4:	715d                	addi	sp,sp,-80
    800021a6:	e486                	sd	ra,72(sp)
    800021a8:	e0a2                	sd	s0,64(sp)
    800021aa:	fc26                	sd	s1,56(sp)
    800021ac:	f84a                	sd	s2,48(sp)
    800021ae:	f44e                	sd	s3,40(sp)
    800021b0:	f052                	sd	s4,32(sp)
    800021b2:	ec56                	sd	s5,24(sp)
    800021b4:	e85a                	sd	s6,16(sp)
    800021b6:	e45e                	sd	s7,8(sp)
    800021b8:	e062                	sd	s8,0(sp)
    800021ba:	0880                	addi	s0,sp,80
    800021bc:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800021be:	fffff097          	auipc	ra,0xfffff
    800021c2:	7c6080e7          	jalr	1990(ra) # 80001984 <myproc>
    800021c6:	892a                	mv	s2,a0
  acquire(&p->lock);
    800021c8:	8c2a                	mv	s8,a0
    800021ca:	fffff097          	auipc	ra,0xfffff
    800021ce:	908080e7          	jalr	-1784(ra) # 80000ad2 <acquire>
    havekids = 0;
    800021d2:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800021d4:	4a11                	li	s4,4
    for(np = proc; np < &proc[NPROC]; np++){
    800021d6:	00015997          	auipc	s3,0x15
    800021da:	52a98993          	addi	s3,s3,1322 # 80017700 <tickslock>
        havekids = 1;
    800021de:	4a85                	li	s5,1
    havekids = 0;
    800021e0:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800021e2:	00010497          	auipc	s1,0x10
    800021e6:	b1e48493          	addi	s1,s1,-1250 # 80011d00 <proc>
    800021ea:	a08d                	j	8000224c <wait+0xa8>
          pid = np->pid;
    800021ec:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800021f0:	000b0e63          	beqz	s6,8000220c <wait+0x68>
    800021f4:	4691                	li	a3,4
    800021f6:	03448613          	addi	a2,s1,52
    800021fa:	85da                	mv	a1,s6
    800021fc:	05093503          	ld	a0,80(s2)
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	478080e7          	jalr	1144(ra) # 80001678 <copyout>
    80002208:	02054263          	bltz	a0,8000222c <wait+0x88>
          freeproc(np);
    8000220c:	8526                	mv	a0,s1
    8000220e:	00000097          	auipc	ra,0x0
    80002212:	992080e7          	jalr	-1646(ra) # 80001ba0 <freeproc>
          release(&np->lock);
    80002216:	8526                	mv	a0,s1
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	90e080e7          	jalr	-1778(ra) # 80000b26 <release>
          release(&p->lock);
    80002220:	854a                	mv	a0,s2
    80002222:	fffff097          	auipc	ra,0xfffff
    80002226:	904080e7          	jalr	-1788(ra) # 80000b26 <release>
          return pid;
    8000222a:	a8a9                	j	80002284 <wait+0xe0>
            release(&np->lock);
    8000222c:	8526                	mv	a0,s1
    8000222e:	fffff097          	auipc	ra,0xfffff
    80002232:	8f8080e7          	jalr	-1800(ra) # 80000b26 <release>
            release(&p->lock);
    80002236:	854a                	mv	a0,s2
    80002238:	fffff097          	auipc	ra,0xfffff
    8000223c:	8ee080e7          	jalr	-1810(ra) # 80000b26 <release>
            return -1;
    80002240:	59fd                	li	s3,-1
    80002242:	a089                	j	80002284 <wait+0xe0>
    for(np = proc; np < &proc[NPROC]; np++){
    80002244:	16848493          	addi	s1,s1,360
    80002248:	03348463          	beq	s1,s3,80002270 <wait+0xcc>
      if(np->parent == p){
    8000224c:	709c                	ld	a5,32(s1)
    8000224e:	ff279be3          	bne	a5,s2,80002244 <wait+0xa0>
        acquire(&np->lock);
    80002252:	8526                	mv	a0,s1
    80002254:	fffff097          	auipc	ra,0xfffff
    80002258:	87e080e7          	jalr	-1922(ra) # 80000ad2 <acquire>
        if(np->state == ZOMBIE){
    8000225c:	4c9c                	lw	a5,24(s1)
    8000225e:	f94787e3          	beq	a5,s4,800021ec <wait+0x48>
        release(&np->lock);
    80002262:	8526                	mv	a0,s1
    80002264:	fffff097          	auipc	ra,0xfffff
    80002268:	8c2080e7          	jalr	-1854(ra) # 80000b26 <release>
        havekids = 1;
    8000226c:	8756                	mv	a4,s5
    8000226e:	bfd9                	j	80002244 <wait+0xa0>
    if(!havekids || p->killed){
    80002270:	c701                	beqz	a4,80002278 <wait+0xd4>
    80002272:	03092783          	lw	a5,48(s2)
    80002276:	c785                	beqz	a5,8000229e <wait+0xfa>
      release(&p->lock);
    80002278:	854a                	mv	a0,s2
    8000227a:	fffff097          	auipc	ra,0xfffff
    8000227e:	8ac080e7          	jalr	-1876(ra) # 80000b26 <release>
      return -1;
    80002282:	59fd                	li	s3,-1
}
    80002284:	854e                	mv	a0,s3
    80002286:	60a6                	ld	ra,72(sp)
    80002288:	6406                	ld	s0,64(sp)
    8000228a:	74e2                	ld	s1,56(sp)
    8000228c:	7942                	ld	s2,48(sp)
    8000228e:	79a2                	ld	s3,40(sp)
    80002290:	7a02                	ld	s4,32(sp)
    80002292:	6ae2                	ld	s5,24(sp)
    80002294:	6b42                	ld	s6,16(sp)
    80002296:	6ba2                	ld	s7,8(sp)
    80002298:	6c02                	ld	s8,0(sp)
    8000229a:	6161                	addi	sp,sp,80
    8000229c:	8082                	ret
    sleep(p, &p->lock);  //DOC: wait-sleep
    8000229e:	85e2                	mv	a1,s8
    800022a0:	854a                	mv	a0,s2
    800022a2:	00000097          	auipc	ra,0x0
    800022a6:	e84080e7          	jalr	-380(ra) # 80002126 <sleep>
    havekids = 0;
    800022aa:	bf1d                	j	800021e0 <wait+0x3c>

00000000800022ac <wakeup>:
{
    800022ac:	7139                	addi	sp,sp,-64
    800022ae:	fc06                	sd	ra,56(sp)
    800022b0:	f822                	sd	s0,48(sp)
    800022b2:	f426                	sd	s1,40(sp)
    800022b4:	f04a                	sd	s2,32(sp)
    800022b6:	ec4e                	sd	s3,24(sp)
    800022b8:	e852                	sd	s4,16(sp)
    800022ba:	e456                	sd	s5,8(sp)
    800022bc:	0080                	addi	s0,sp,64
    800022be:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    800022c0:	00010497          	auipc	s1,0x10
    800022c4:	a4048493          	addi	s1,s1,-1472 # 80011d00 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    800022c8:	4985                	li	s3,1
      p->state = RUNNABLE;
    800022ca:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    800022cc:	00015917          	auipc	s2,0x15
    800022d0:	43490913          	addi	s2,s2,1076 # 80017700 <tickslock>
    800022d4:	a821                	j	800022ec <wakeup+0x40>
      p->state = RUNNABLE;
    800022d6:	0154ac23          	sw	s5,24(s1)
    release(&p->lock);
    800022da:	8526                	mv	a0,s1
    800022dc:	fffff097          	auipc	ra,0xfffff
    800022e0:	84a080e7          	jalr	-1974(ra) # 80000b26 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800022e4:	16848493          	addi	s1,s1,360
    800022e8:	01248e63          	beq	s1,s2,80002304 <wakeup+0x58>
    acquire(&p->lock);
    800022ec:	8526                	mv	a0,s1
    800022ee:	ffffe097          	auipc	ra,0xffffe
    800022f2:	7e4080e7          	jalr	2020(ra) # 80000ad2 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    800022f6:	4c9c                	lw	a5,24(s1)
    800022f8:	ff3791e3          	bne	a5,s3,800022da <wakeup+0x2e>
    800022fc:	749c                	ld	a5,40(s1)
    800022fe:	fd479ee3          	bne	a5,s4,800022da <wakeup+0x2e>
    80002302:	bfd1                	j	800022d6 <wakeup+0x2a>
}
    80002304:	70e2                	ld	ra,56(sp)
    80002306:	7442                	ld	s0,48(sp)
    80002308:	74a2                	ld	s1,40(sp)
    8000230a:	7902                	ld	s2,32(sp)
    8000230c:	69e2                	ld	s3,24(sp)
    8000230e:	6a42                	ld	s4,16(sp)
    80002310:	6aa2                	ld	s5,8(sp)
    80002312:	6121                	addi	sp,sp,64
    80002314:	8082                	ret

0000000080002316 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80002316:	7179                	addi	sp,sp,-48
    80002318:	f406                	sd	ra,40(sp)
    8000231a:	f022                	sd	s0,32(sp)
    8000231c:	ec26                	sd	s1,24(sp)
    8000231e:	e84a                	sd	s2,16(sp)
    80002320:	e44e                	sd	s3,8(sp)
    80002322:	1800                	addi	s0,sp,48
    80002324:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80002326:	00010497          	auipc	s1,0x10
    8000232a:	9da48493          	addi	s1,s1,-1574 # 80011d00 <proc>
    8000232e:	00015997          	auipc	s3,0x15
    80002332:	3d298993          	addi	s3,s3,978 # 80017700 <tickslock>
    acquire(&p->lock);
    80002336:	8526                	mv	a0,s1
    80002338:	ffffe097          	auipc	ra,0xffffe
    8000233c:	79a080e7          	jalr	1946(ra) # 80000ad2 <acquire>
    if(p->pid == pid){
    80002340:	5c9c                	lw	a5,56(s1)
    80002342:	01278d63          	beq	a5,s2,8000235c <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002346:	8526                	mv	a0,s1
    80002348:	ffffe097          	auipc	ra,0xffffe
    8000234c:	7de080e7          	jalr	2014(ra) # 80000b26 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002350:	16848493          	addi	s1,s1,360
    80002354:	ff3491e3          	bne	s1,s3,80002336 <kill+0x20>
  }
  return -1;
    80002358:	557d                	li	a0,-1
    8000235a:	a821                	j	80002372 <kill+0x5c>
      p->killed = 1;
    8000235c:	4785                	li	a5,1
    8000235e:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    80002360:	4c98                	lw	a4,24(s1)
    80002362:	00f70f63          	beq	a4,a5,80002380 <kill+0x6a>
      release(&p->lock);
    80002366:	8526                	mv	a0,s1
    80002368:	ffffe097          	auipc	ra,0xffffe
    8000236c:	7be080e7          	jalr	1982(ra) # 80000b26 <release>
      return 0;
    80002370:	4501                	li	a0,0
}
    80002372:	70a2                	ld	ra,40(sp)
    80002374:	7402                	ld	s0,32(sp)
    80002376:	64e2                	ld	s1,24(sp)
    80002378:	6942                	ld	s2,16(sp)
    8000237a:	69a2                	ld	s3,8(sp)
    8000237c:	6145                	addi	sp,sp,48
    8000237e:	8082                	ret
        p->state = RUNNABLE;
    80002380:	4789                	li	a5,2
    80002382:	cc9c                	sw	a5,24(s1)
    80002384:	b7cd                	j	80002366 <kill+0x50>

0000000080002386 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002386:	7179                	addi	sp,sp,-48
    80002388:	f406                	sd	ra,40(sp)
    8000238a:	f022                	sd	s0,32(sp)
    8000238c:	ec26                	sd	s1,24(sp)
    8000238e:	e84a                	sd	s2,16(sp)
    80002390:	e44e                	sd	s3,8(sp)
    80002392:	e052                	sd	s4,0(sp)
    80002394:	1800                	addi	s0,sp,48
    80002396:	84aa                	mv	s1,a0
    80002398:	892e                	mv	s2,a1
    8000239a:	89b2                	mv	s3,a2
    8000239c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000239e:	fffff097          	auipc	ra,0xfffff
    800023a2:	5e6080e7          	jalr	1510(ra) # 80001984 <myproc>
  if(user_dst){
    800023a6:	c08d                	beqz	s1,800023c8 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800023a8:	86d2                	mv	a3,s4
    800023aa:	864e                	mv	a2,s3
    800023ac:	85ca                	mv	a1,s2
    800023ae:	6928                	ld	a0,80(a0)
    800023b0:	fffff097          	auipc	ra,0xfffff
    800023b4:	2c8080e7          	jalr	712(ra) # 80001678 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800023b8:	70a2                	ld	ra,40(sp)
    800023ba:	7402                	ld	s0,32(sp)
    800023bc:	64e2                	ld	s1,24(sp)
    800023be:	6942                	ld	s2,16(sp)
    800023c0:	69a2                	ld	s3,8(sp)
    800023c2:	6a02                	ld	s4,0(sp)
    800023c4:	6145                	addi	sp,sp,48
    800023c6:	8082                	ret
    memmove((char *)dst, src, len);
    800023c8:	000a061b          	sext.w	a2,s4
    800023cc:	85ce                	mv	a1,s3
    800023ce:	854a                	mv	a0,s2
    800023d0:	ffffe097          	auipc	ra,0xffffe
    800023d4:	7fe080e7          	jalr	2046(ra) # 80000bce <memmove>
    return 0;
    800023d8:	8526                	mv	a0,s1
    800023da:	bff9                	j	800023b8 <either_copyout+0x32>

00000000800023dc <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800023dc:	7179                	addi	sp,sp,-48
    800023de:	f406                	sd	ra,40(sp)
    800023e0:	f022                	sd	s0,32(sp)
    800023e2:	ec26                	sd	s1,24(sp)
    800023e4:	e84a                	sd	s2,16(sp)
    800023e6:	e44e                	sd	s3,8(sp)
    800023e8:	e052                	sd	s4,0(sp)
    800023ea:	1800                	addi	s0,sp,48
    800023ec:	892a                	mv	s2,a0
    800023ee:	84ae                	mv	s1,a1
    800023f0:	89b2                	mv	s3,a2
    800023f2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800023f4:	fffff097          	auipc	ra,0xfffff
    800023f8:	590080e7          	jalr	1424(ra) # 80001984 <myproc>
  if(user_src){
    800023fc:	c08d                	beqz	s1,8000241e <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800023fe:	86d2                	mv	a3,s4
    80002400:	864e                	mv	a2,s3
    80002402:	85ca                	mv	a1,s2
    80002404:	6928                	ld	a0,80(a0)
    80002406:	fffff097          	auipc	ra,0xfffff
    8000240a:	2fe080e7          	jalr	766(ra) # 80001704 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    8000240e:	70a2                	ld	ra,40(sp)
    80002410:	7402                	ld	s0,32(sp)
    80002412:	64e2                	ld	s1,24(sp)
    80002414:	6942                	ld	s2,16(sp)
    80002416:	69a2                	ld	s3,8(sp)
    80002418:	6a02                	ld	s4,0(sp)
    8000241a:	6145                	addi	sp,sp,48
    8000241c:	8082                	ret
    memmove(dst, (char*)src, len);
    8000241e:	000a061b          	sext.w	a2,s4
    80002422:	85ce                	mv	a1,s3
    80002424:	854a                	mv	a0,s2
    80002426:	ffffe097          	auipc	ra,0xffffe
    8000242a:	7a8080e7          	jalr	1960(ra) # 80000bce <memmove>
    return 0;
    8000242e:	8526                	mv	a0,s1
    80002430:	bff9                	j	8000240e <either_copyin+0x32>

0000000080002432 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80002432:	715d                	addi	sp,sp,-80
    80002434:	e486                	sd	ra,72(sp)
    80002436:	e0a2                	sd	s0,64(sp)
    80002438:	fc26                	sd	s1,56(sp)
    8000243a:	f84a                	sd	s2,48(sp)
    8000243c:	f44e                	sd	s3,40(sp)
    8000243e:	f052                	sd	s4,32(sp)
    80002440:	ec56                	sd	s5,24(sp)
    80002442:	e85a                	sd	s6,16(sp)
    80002444:	e45e                	sd	s7,8(sp)
    80002446:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80002448:	00005517          	auipc	a0,0x5
    8000244c:	0e050513          	addi	a0,a0,224 # 80007528 <userret+0x498>
    80002450:	ffffe097          	auipc	ra,0xffffe
    80002454:	148080e7          	jalr	328(ra) # 80000598 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002458:	00010497          	auipc	s1,0x10
    8000245c:	a0048493          	addi	s1,s1,-1536 # 80011e58 <proc+0x158>
    80002460:	00015917          	auipc	s2,0x15
    80002464:	3f890913          	addi	s2,s2,1016 # 80017858 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002468:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    8000246a:	00005997          	auipc	s3,0x5
    8000246e:	27698993          	addi	s3,s3,630 # 800076e0 <userret+0x650>
    printf("%d %s %s", p->pid, state, p->name);
    80002472:	00005a97          	auipc	s5,0x5
    80002476:	276a8a93          	addi	s5,s5,630 # 800076e8 <userret+0x658>
    printf("\n");
    8000247a:	00005a17          	auipc	s4,0x5
    8000247e:	0aea0a13          	addi	s4,s4,174 # 80007528 <userret+0x498>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002482:	00005b97          	auipc	s7,0x5
    80002486:	71eb8b93          	addi	s7,s7,1822 # 80007ba0 <states.1693>
    8000248a:	a00d                	j	800024ac <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    8000248c:	ee06a583          	lw	a1,-288(a3)
    80002490:	8556                	mv	a0,s5
    80002492:	ffffe097          	auipc	ra,0xffffe
    80002496:	106080e7          	jalr	262(ra) # 80000598 <printf>
    printf("\n");
    8000249a:	8552                	mv	a0,s4
    8000249c:	ffffe097          	auipc	ra,0xffffe
    800024a0:	0fc080e7          	jalr	252(ra) # 80000598 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800024a4:	16848493          	addi	s1,s1,360
    800024a8:	03248163          	beq	s1,s2,800024ca <procdump+0x98>
    if(p->state == UNUSED)
    800024ac:	86a6                	mv	a3,s1
    800024ae:	ec04a783          	lw	a5,-320(s1)
    800024b2:	dbed                	beqz	a5,800024a4 <procdump+0x72>
      state = "???";
    800024b4:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800024b6:	fcfb6be3          	bltu	s6,a5,8000248c <procdump+0x5a>
    800024ba:	1782                	slli	a5,a5,0x20
    800024bc:	9381                	srli	a5,a5,0x20
    800024be:	078e                	slli	a5,a5,0x3
    800024c0:	97de                	add	a5,a5,s7
    800024c2:	6390                	ld	a2,0(a5)
    800024c4:	f661                	bnez	a2,8000248c <procdump+0x5a>
      state = "???";
    800024c6:	864e                	mv	a2,s3
    800024c8:	b7d1                	j	8000248c <procdump+0x5a>
  }
}
    800024ca:	60a6                	ld	ra,72(sp)
    800024cc:	6406                	ld	s0,64(sp)
    800024ce:	74e2                	ld	s1,56(sp)
    800024d0:	7942                	ld	s2,48(sp)
    800024d2:	79a2                	ld	s3,40(sp)
    800024d4:	7a02                	ld	s4,32(sp)
    800024d6:	6ae2                	ld	s5,24(sp)
    800024d8:	6b42                	ld	s6,16(sp)
    800024da:	6ba2                	ld	s7,8(sp)
    800024dc:	6161                	addi	sp,sp,80
    800024de:	8082                	ret

00000000800024e0 <swtch>:
    800024e0:	00153023          	sd	ra,0(a0)
    800024e4:	00253423          	sd	sp,8(a0)
    800024e8:	e900                	sd	s0,16(a0)
    800024ea:	ed04                	sd	s1,24(a0)
    800024ec:	03253023          	sd	s2,32(a0)
    800024f0:	03353423          	sd	s3,40(a0)
    800024f4:	03453823          	sd	s4,48(a0)
    800024f8:	03553c23          	sd	s5,56(a0)
    800024fc:	05653023          	sd	s6,64(a0)
    80002500:	05753423          	sd	s7,72(a0)
    80002504:	05853823          	sd	s8,80(a0)
    80002508:	05953c23          	sd	s9,88(a0)
    8000250c:	07a53023          	sd	s10,96(a0)
    80002510:	07b53423          	sd	s11,104(a0)
    80002514:	0005b083          	ld	ra,0(a1)
    80002518:	0085b103          	ld	sp,8(a1)
    8000251c:	6980                	ld	s0,16(a1)
    8000251e:	6d84                	ld	s1,24(a1)
    80002520:	0205b903          	ld	s2,32(a1)
    80002524:	0285b983          	ld	s3,40(a1)
    80002528:	0305ba03          	ld	s4,48(a1)
    8000252c:	0385ba83          	ld	s5,56(a1)
    80002530:	0405bb03          	ld	s6,64(a1)
    80002534:	0485bb83          	ld	s7,72(a1)
    80002538:	0505bc03          	ld	s8,80(a1)
    8000253c:	0585bc83          	ld	s9,88(a1)
    80002540:	0605bd03          	ld	s10,96(a1)
    80002544:	0685bd83          	ld	s11,104(a1)
    80002548:	8082                	ret

000000008000254a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000254a:	1141                	addi	sp,sp,-16
    8000254c:	e406                	sd	ra,8(sp)
    8000254e:	e022                	sd	s0,0(sp)
    80002550:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002552:	00005597          	auipc	a1,0x5
    80002556:	1ce58593          	addi	a1,a1,462 # 80007720 <userret+0x690>
    8000255a:	00015517          	auipc	a0,0x15
    8000255e:	1a650513          	addi	a0,a0,422 # 80017700 <tickslock>
    80002562:	ffffe097          	auipc	ra,0xffffe
    80002566:	45e080e7          	jalr	1118(ra) # 800009c0 <initlock>
}
    8000256a:	60a2                	ld	ra,8(sp)
    8000256c:	6402                	ld	s0,0(sp)
    8000256e:	0141                	addi	sp,sp,16
    80002570:	8082                	ret

0000000080002572 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80002572:	1141                	addi	sp,sp,-16
    80002574:	e422                	sd	s0,8(sp)
    80002576:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002578:	00003797          	auipc	a5,0x3
    8000257c:	45878793          	addi	a5,a5,1112 # 800059d0 <kernelvec>
    80002580:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002584:	6422                	ld	s0,8(sp)
    80002586:	0141                	addi	sp,sp,16
    80002588:	8082                	ret

000000008000258a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    8000258a:	1141                	addi	sp,sp,-16
    8000258c:	e406                	sd	ra,8(sp)
    8000258e:	e022                	sd	s0,0(sp)
    80002590:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80002592:	fffff097          	auipc	ra,0xfffff
    80002596:	3f2080e7          	jalr	1010(ra) # 80001984 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000259a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000259e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025a0:	10079073          	csrw	sstatus,a5
  // turn off interrupts, since we're switching
  // now from kerneltrap() to usertrap().
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800025a4:	00005617          	auipc	a2,0x5
    800025a8:	a5c60613          	addi	a2,a2,-1444 # 80007000 <trampoline>
    800025ac:	00005697          	auipc	a3,0x5
    800025b0:	a5468693          	addi	a3,a3,-1452 # 80007000 <trampoline>
    800025b4:	8e91                	sub	a3,a3,a2
    800025b6:	040007b7          	lui	a5,0x4000
    800025ba:	17fd                	addi	a5,a5,-1
    800025bc:	07b2                	slli	a5,a5,0xc
    800025be:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800025c0:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->tf->kernel_satp = r_satp();         // kernel page table
    800025c4:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800025c6:	180026f3          	csrr	a3,satp
    800025ca:	e314                	sd	a3,0(a4)
  p->tf->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800025cc:	6d38                	ld	a4,88(a0)
    800025ce:	6134                	ld	a3,64(a0)
    800025d0:	6585                	lui	a1,0x1
    800025d2:	96ae                	add	a3,a3,a1
    800025d4:	e714                	sd	a3,8(a4)
  p->tf->kernel_trap = (uint64)usertrap;
    800025d6:	6d38                	ld	a4,88(a0)
    800025d8:	00000697          	auipc	a3,0x0
    800025dc:	12268693          	addi	a3,a3,290 # 800026fa <usertrap>
    800025e0:	eb14                	sd	a3,16(a4)
  p->tf->kernel_hartid = r_tp();         // hartid for cpuid()
    800025e2:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800025e4:	8692                	mv	a3,tp
    800025e6:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800025e8:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800025ec:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800025f0:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025f4:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->tf->epc);
    800025f8:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800025fa:	6f18                	ld	a4,24(a4)
    800025fc:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002600:	692c                	ld	a1,80(a0)
    80002602:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80002604:	00005717          	auipc	a4,0x5
    80002608:	a8c70713          	addi	a4,a4,-1396 # 80007090 <userret>
    8000260c:	8f11                	sub	a4,a4,a2
    8000260e:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002610:	577d                	li	a4,-1
    80002612:	177e                	slli	a4,a4,0x3f
    80002614:	8dd9                	or	a1,a1,a4
    80002616:	02000537          	lui	a0,0x2000
    8000261a:	157d                	addi	a0,a0,-1
    8000261c:	0536                	slli	a0,a0,0xd
    8000261e:	9782                	jalr	a5
}
    80002620:	60a2                	ld	ra,8(sp)
    80002622:	6402                	ld	s0,0(sp)
    80002624:	0141                	addi	sp,sp,16
    80002626:	8082                	ret

0000000080002628 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80002628:	1101                	addi	sp,sp,-32
    8000262a:	ec06                	sd	ra,24(sp)
    8000262c:	e822                	sd	s0,16(sp)
    8000262e:	e426                	sd	s1,8(sp)
    80002630:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80002632:	00015497          	auipc	s1,0x15
    80002636:	0ce48493          	addi	s1,s1,206 # 80017700 <tickslock>
    8000263a:	8526                	mv	a0,s1
    8000263c:	ffffe097          	auipc	ra,0xffffe
    80002640:	496080e7          	jalr	1174(ra) # 80000ad2 <acquire>
  ticks++;
    80002644:	00024517          	auipc	a0,0x24
    80002648:	9d450513          	addi	a0,a0,-1580 # 80026018 <ticks>
    8000264c:	411c                	lw	a5,0(a0)
    8000264e:	2785                	addiw	a5,a5,1
    80002650:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002652:	00000097          	auipc	ra,0x0
    80002656:	c5a080e7          	jalr	-934(ra) # 800022ac <wakeup>
  release(&tickslock);
    8000265a:	8526                	mv	a0,s1
    8000265c:	ffffe097          	auipc	ra,0xffffe
    80002660:	4ca080e7          	jalr	1226(ra) # 80000b26 <release>
}
    80002664:	60e2                	ld	ra,24(sp)
    80002666:	6442                	ld	s0,16(sp)
    80002668:	64a2                	ld	s1,8(sp)
    8000266a:	6105                	addi	sp,sp,32
    8000266c:	8082                	ret

000000008000266e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000266e:	1101                	addi	sp,sp,-32
    80002670:	ec06                	sd	ra,24(sp)
    80002672:	e822                	sd	s0,16(sp)
    80002674:	e426                	sd	s1,8(sp)
    80002676:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002678:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    8000267c:	00074d63          	bltz	a4,80002696 <devintr+0x28>
      virtio_disk_intr();
    }

    plic_complete(irq);
    return 1;
  } else if(scause == 0x8000000000000001L){
    80002680:	57fd                	li	a5,-1
    80002682:	17fe                	slli	a5,a5,0x3f
    80002684:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002686:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002688:	04f70863          	beq	a4,a5,800026d8 <devintr+0x6a>
  }
}
    8000268c:	60e2                	ld	ra,24(sp)
    8000268e:	6442                	ld	s0,16(sp)
    80002690:	64a2                	ld	s1,8(sp)
    80002692:	6105                	addi	sp,sp,32
    80002694:	8082                	ret
     (scause & 0xff) == 9){
    80002696:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    8000269a:	46a5                	li	a3,9
    8000269c:	fed792e3          	bne	a5,a3,80002680 <devintr+0x12>
    int irq = plic_claim();
    800026a0:	00003097          	auipc	ra,0x3
    800026a4:	44a080e7          	jalr	1098(ra) # 80005aea <plic_claim>
    800026a8:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800026aa:	47a9                	li	a5,10
    800026ac:	00f50c63          	beq	a0,a5,800026c4 <devintr+0x56>
    } else if(irq == VIRTIO0_IRQ){
    800026b0:	4785                	li	a5,1
    800026b2:	00f50e63          	beq	a0,a5,800026ce <devintr+0x60>
    plic_complete(irq);
    800026b6:	8526                	mv	a0,s1
    800026b8:	00003097          	auipc	ra,0x3
    800026bc:	456080e7          	jalr	1110(ra) # 80005b0e <plic_complete>
    return 1;
    800026c0:	4505                	li	a0,1
    800026c2:	b7e9                	j	8000268c <devintr+0x1e>
      uartintr();
    800026c4:	ffffe097          	auipc	ra,0xffffe
    800026c8:	174080e7          	jalr	372(ra) # 80000838 <uartintr>
    800026cc:	b7ed                	j	800026b6 <devintr+0x48>
      virtio_disk_intr();
    800026ce:	00004097          	auipc	ra,0x4
    800026d2:	8d0080e7          	jalr	-1840(ra) # 80005f9e <virtio_disk_intr>
    800026d6:	b7c5                	j	800026b6 <devintr+0x48>
    if(cpuid() == 0){
    800026d8:	fffff097          	auipc	ra,0xfffff
    800026dc:	280080e7          	jalr	640(ra) # 80001958 <cpuid>
    800026e0:	c901                	beqz	a0,800026f0 <devintr+0x82>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800026e2:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    800026e6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800026e8:	14479073          	csrw	sip,a5
    return 2;
    800026ec:	4509                	li	a0,2
    800026ee:	bf79                	j	8000268c <devintr+0x1e>
      clockintr();
    800026f0:	00000097          	auipc	ra,0x0
    800026f4:	f38080e7          	jalr	-200(ra) # 80002628 <clockintr>
    800026f8:	b7ed                	j	800026e2 <devintr+0x74>

00000000800026fa <usertrap>:
{
    800026fa:	1101                	addi	sp,sp,-32
    800026fc:	ec06                	sd	ra,24(sp)
    800026fe:	e822                	sd	s0,16(sp)
    80002700:	e426                	sd	s1,8(sp)
    80002702:	e04a                	sd	s2,0(sp)
    80002704:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002706:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    8000270a:	1007f793          	andi	a5,a5,256
    8000270e:	e7bd                	bnez	a5,8000277c <usertrap+0x82>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002710:	00003797          	auipc	a5,0x3
    80002714:	2c078793          	addi	a5,a5,704 # 800059d0 <kernelvec>
    80002718:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    8000271c:	fffff097          	auipc	ra,0xfffff
    80002720:	268080e7          	jalr	616(ra) # 80001984 <myproc>
    80002724:	84aa                	mv	s1,a0
  p->tf->epc = r_sepc();
    80002726:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002728:	14102773          	csrr	a4,sepc
    8000272c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000272e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002732:	47a1                	li	a5,8
    80002734:	06f71263          	bne	a4,a5,80002798 <usertrap+0x9e>
    if(p->killed)
    80002738:	591c                	lw	a5,48(a0)
    8000273a:	eba9                	bnez	a5,8000278c <usertrap+0x92>
    p->tf->epc += 4;
    8000273c:	6cb8                	ld	a4,88(s1)
    8000273e:	6f1c                	ld	a5,24(a4)
    80002740:	0791                	addi	a5,a5,4
    80002742:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sie" : "=r" (x) );
    80002744:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80002748:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    8000274c:	10479073          	csrw	sie,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002750:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002754:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002758:	10079073          	csrw	sstatus,a5
    syscall();
    8000275c:	00000097          	auipc	ra,0x0
    80002760:	2e0080e7          	jalr	736(ra) # 80002a3c <syscall>
  if(p->killed)
    80002764:	589c                	lw	a5,48(s1)
    80002766:	ebc1                	bnez	a5,800027f6 <usertrap+0xfc>
  usertrapret();
    80002768:	00000097          	auipc	ra,0x0
    8000276c:	e22080e7          	jalr	-478(ra) # 8000258a <usertrapret>
}
    80002770:	60e2                	ld	ra,24(sp)
    80002772:	6442                	ld	s0,16(sp)
    80002774:	64a2                	ld	s1,8(sp)
    80002776:	6902                	ld	s2,0(sp)
    80002778:	6105                	addi	sp,sp,32
    8000277a:	8082                	ret
    panic("usertrap: not from user mode");
    8000277c:	00005517          	auipc	a0,0x5
    80002780:	fac50513          	addi	a0,a0,-84 # 80007728 <userret+0x698>
    80002784:	ffffe097          	auipc	ra,0xffffe
    80002788:	dca080e7          	jalr	-566(ra) # 8000054e <panic>
      exit(-1);
    8000278c:	557d                	li	a0,-1
    8000278e:	00000097          	auipc	ra,0x0
    80002792:	852080e7          	jalr	-1966(ra) # 80001fe0 <exit>
    80002796:	b75d                	j	8000273c <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	ed6080e7          	jalr	-298(ra) # 8000266e <devintr>
    800027a0:	892a                	mv	s2,a0
    800027a2:	c501                	beqz	a0,800027aa <usertrap+0xb0>
  if(p->killed)
    800027a4:	589c                	lw	a5,48(s1)
    800027a6:	c3a1                	beqz	a5,800027e6 <usertrap+0xec>
    800027a8:	a815                	j	800027dc <usertrap+0xe2>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800027aa:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800027ae:	5c90                	lw	a2,56(s1)
    800027b0:	00005517          	auipc	a0,0x5
    800027b4:	f9850513          	addi	a0,a0,-104 # 80007748 <userret+0x6b8>
    800027b8:	ffffe097          	auipc	ra,0xffffe
    800027bc:	de0080e7          	jalr	-544(ra) # 80000598 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800027c0:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800027c4:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    800027c8:	00005517          	auipc	a0,0x5
    800027cc:	fb050513          	addi	a0,a0,-80 # 80007778 <userret+0x6e8>
    800027d0:	ffffe097          	auipc	ra,0xffffe
    800027d4:	dc8080e7          	jalr	-568(ra) # 80000598 <printf>
    p->killed = 1;
    800027d8:	4785                	li	a5,1
    800027da:	d89c                	sw	a5,48(s1)
    exit(-1);
    800027dc:	557d                	li	a0,-1
    800027de:	00000097          	auipc	ra,0x0
    800027e2:	802080e7          	jalr	-2046(ra) # 80001fe0 <exit>
  if(which_dev == 2)
    800027e6:	4789                	li	a5,2
    800027e8:	f8f910e3          	bne	s2,a5,80002768 <usertrap+0x6e>
    yield();
    800027ec:	00000097          	auipc	ra,0x0
    800027f0:	8fe080e7          	jalr	-1794(ra) # 800020ea <yield>
    800027f4:	bf95                	j	80002768 <usertrap+0x6e>
  int which_dev = 0;
    800027f6:	4901                	li	s2,0
    800027f8:	b7d5                	j	800027dc <usertrap+0xe2>

00000000800027fa <kerneltrap>:
{
    800027fa:	7179                	addi	sp,sp,-48
    800027fc:	f406                	sd	ra,40(sp)
    800027fe:	f022                	sd	s0,32(sp)
    80002800:	ec26                	sd	s1,24(sp)
    80002802:	e84a                	sd	s2,16(sp)
    80002804:	e44e                	sd	s3,8(sp)
    80002806:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002808:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000280c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002810:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002814:	1004f793          	andi	a5,s1,256
    80002818:	cb85                	beqz	a5,80002848 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000281a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000281e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002820:	ef85                	bnez	a5,80002858 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002822:	00000097          	auipc	ra,0x0
    80002826:	e4c080e7          	jalr	-436(ra) # 8000266e <devintr>
    8000282a:	cd1d                	beqz	a0,80002868 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000282c:	4789                	li	a5,2
    8000282e:	06f50a63          	beq	a0,a5,800028a2 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002832:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002836:	10049073          	csrw	sstatus,s1
}
    8000283a:	70a2                	ld	ra,40(sp)
    8000283c:	7402                	ld	s0,32(sp)
    8000283e:	64e2                	ld	s1,24(sp)
    80002840:	6942                	ld	s2,16(sp)
    80002842:	69a2                	ld	s3,8(sp)
    80002844:	6145                	addi	sp,sp,48
    80002846:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002848:	00005517          	auipc	a0,0x5
    8000284c:	f5050513          	addi	a0,a0,-176 # 80007798 <userret+0x708>
    80002850:	ffffe097          	auipc	ra,0xffffe
    80002854:	cfe080e7          	jalr	-770(ra) # 8000054e <panic>
    panic("kerneltrap: interrupts enabled");
    80002858:	00005517          	auipc	a0,0x5
    8000285c:	f6850513          	addi	a0,a0,-152 # 800077c0 <userret+0x730>
    80002860:	ffffe097          	auipc	ra,0xffffe
    80002864:	cee080e7          	jalr	-786(ra) # 8000054e <panic>
    printf("scause %p\n", scause);
    80002868:	85ce                	mv	a1,s3
    8000286a:	00005517          	auipc	a0,0x5
    8000286e:	f7650513          	addi	a0,a0,-138 # 800077e0 <userret+0x750>
    80002872:	ffffe097          	auipc	ra,0xffffe
    80002876:	d26080e7          	jalr	-730(ra) # 80000598 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000287a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000287e:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002882:	00005517          	auipc	a0,0x5
    80002886:	f6e50513          	addi	a0,a0,-146 # 800077f0 <userret+0x760>
    8000288a:	ffffe097          	auipc	ra,0xffffe
    8000288e:	d0e080e7          	jalr	-754(ra) # 80000598 <printf>
    panic("kerneltrap");
    80002892:	00005517          	auipc	a0,0x5
    80002896:	f7650513          	addi	a0,a0,-138 # 80007808 <userret+0x778>
    8000289a:	ffffe097          	auipc	ra,0xffffe
    8000289e:	cb4080e7          	jalr	-844(ra) # 8000054e <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800028a2:	fffff097          	auipc	ra,0xfffff
    800028a6:	0e2080e7          	jalr	226(ra) # 80001984 <myproc>
    800028aa:	d541                	beqz	a0,80002832 <kerneltrap+0x38>
    800028ac:	fffff097          	auipc	ra,0xfffff
    800028b0:	0d8080e7          	jalr	216(ra) # 80001984 <myproc>
    800028b4:	4d18                	lw	a4,24(a0)
    800028b6:	478d                	li	a5,3
    800028b8:	f6f71de3          	bne	a4,a5,80002832 <kerneltrap+0x38>
    yield();
    800028bc:	00000097          	auipc	ra,0x0
    800028c0:	82e080e7          	jalr	-2002(ra) # 800020ea <yield>
    800028c4:	b7bd                	j	80002832 <kerneltrap+0x38>

00000000800028c6 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    800028c6:	1101                	addi	sp,sp,-32
    800028c8:	ec06                	sd	ra,24(sp)
    800028ca:	e822                	sd	s0,16(sp)
    800028cc:	e426                	sd	s1,8(sp)
    800028ce:	1000                	addi	s0,sp,32
    800028d0:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800028d2:	fffff097          	auipc	ra,0xfffff
    800028d6:	0b2080e7          	jalr	178(ra) # 80001984 <myproc>
  switch (n) {
    800028da:	4795                	li	a5,5
    800028dc:	0497e163          	bltu	a5,s1,8000291e <argraw+0x58>
    800028e0:	048a                	slli	s1,s1,0x2
    800028e2:	00005717          	auipc	a4,0x5
    800028e6:	2e670713          	addi	a4,a4,742 # 80007bc8 <states.1693+0x28>
    800028ea:	94ba                	add	s1,s1,a4
    800028ec:	409c                	lw	a5,0(s1)
    800028ee:	97ba                	add	a5,a5,a4
    800028f0:	8782                	jr	a5
  case 0:
    return p->tf->a0;
    800028f2:	6d3c                	ld	a5,88(a0)
    800028f4:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->tf->a5;
  }
  panic("argraw");
  return -1;
}
    800028f6:	60e2                	ld	ra,24(sp)
    800028f8:	6442                	ld	s0,16(sp)
    800028fa:	64a2                	ld	s1,8(sp)
    800028fc:	6105                	addi	sp,sp,32
    800028fe:	8082                	ret
    return p->tf->a1;
    80002900:	6d3c                	ld	a5,88(a0)
    80002902:	7fa8                	ld	a0,120(a5)
    80002904:	bfcd                	j	800028f6 <argraw+0x30>
    return p->tf->a2;
    80002906:	6d3c                	ld	a5,88(a0)
    80002908:	63c8                	ld	a0,128(a5)
    8000290a:	b7f5                	j	800028f6 <argraw+0x30>
    return p->tf->a3;
    8000290c:	6d3c                	ld	a5,88(a0)
    8000290e:	67c8                	ld	a0,136(a5)
    80002910:	b7dd                	j	800028f6 <argraw+0x30>
    return p->tf->a4;
    80002912:	6d3c                	ld	a5,88(a0)
    80002914:	6bc8                	ld	a0,144(a5)
    80002916:	b7c5                	j	800028f6 <argraw+0x30>
    return p->tf->a5;
    80002918:	6d3c                	ld	a5,88(a0)
    8000291a:	6fc8                	ld	a0,152(a5)
    8000291c:	bfe9                	j	800028f6 <argraw+0x30>
  panic("argraw");
    8000291e:	00005517          	auipc	a0,0x5
    80002922:	efa50513          	addi	a0,a0,-262 # 80007818 <userret+0x788>
    80002926:	ffffe097          	auipc	ra,0xffffe
    8000292a:	c28080e7          	jalr	-984(ra) # 8000054e <panic>

000000008000292e <fetchaddr>:
{
    8000292e:	1101                	addi	sp,sp,-32
    80002930:	ec06                	sd	ra,24(sp)
    80002932:	e822                	sd	s0,16(sp)
    80002934:	e426                	sd	s1,8(sp)
    80002936:	e04a                	sd	s2,0(sp)
    80002938:	1000                	addi	s0,sp,32
    8000293a:	84aa                	mv	s1,a0
    8000293c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000293e:	fffff097          	auipc	ra,0xfffff
    80002942:	046080e7          	jalr	70(ra) # 80001984 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002946:	653c                	ld	a5,72(a0)
    80002948:	02f4f863          	bgeu	s1,a5,80002978 <fetchaddr+0x4a>
    8000294c:	00848713          	addi	a4,s1,8
    80002950:	02e7e663          	bltu	a5,a4,8000297c <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002954:	46a1                	li	a3,8
    80002956:	8626                	mv	a2,s1
    80002958:	85ca                	mv	a1,s2
    8000295a:	6928                	ld	a0,80(a0)
    8000295c:	fffff097          	auipc	ra,0xfffff
    80002960:	da8080e7          	jalr	-600(ra) # 80001704 <copyin>
    80002964:	00a03533          	snez	a0,a0
    80002968:	40a00533          	neg	a0,a0
}
    8000296c:	60e2                	ld	ra,24(sp)
    8000296e:	6442                	ld	s0,16(sp)
    80002970:	64a2                	ld	s1,8(sp)
    80002972:	6902                	ld	s2,0(sp)
    80002974:	6105                	addi	sp,sp,32
    80002976:	8082                	ret
    return -1;
    80002978:	557d                	li	a0,-1
    8000297a:	bfcd                	j	8000296c <fetchaddr+0x3e>
    8000297c:	557d                	li	a0,-1
    8000297e:	b7fd                	j	8000296c <fetchaddr+0x3e>

0000000080002980 <fetchstr>:
{
    80002980:	7179                	addi	sp,sp,-48
    80002982:	f406                	sd	ra,40(sp)
    80002984:	f022                	sd	s0,32(sp)
    80002986:	ec26                	sd	s1,24(sp)
    80002988:	e84a                	sd	s2,16(sp)
    8000298a:	e44e                	sd	s3,8(sp)
    8000298c:	1800                	addi	s0,sp,48
    8000298e:	892a                	mv	s2,a0
    80002990:	84ae                	mv	s1,a1
    80002992:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002994:	fffff097          	auipc	ra,0xfffff
    80002998:	ff0080e7          	jalr	-16(ra) # 80001984 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    8000299c:	86ce                	mv	a3,s3
    8000299e:	864a                	mv	a2,s2
    800029a0:	85a6                	mv	a1,s1
    800029a2:	6928                	ld	a0,80(a0)
    800029a4:	fffff097          	auipc	ra,0xfffff
    800029a8:	dec080e7          	jalr	-532(ra) # 80001790 <copyinstr>
  if(err < 0)
    800029ac:	00054763          	bltz	a0,800029ba <fetchstr+0x3a>
  return strlen(buf);
    800029b0:	8526                	mv	a0,s1
    800029b2:	ffffe097          	auipc	ra,0xffffe
    800029b6:	344080e7          	jalr	836(ra) # 80000cf6 <strlen>
}
    800029ba:	70a2                	ld	ra,40(sp)
    800029bc:	7402                	ld	s0,32(sp)
    800029be:	64e2                	ld	s1,24(sp)
    800029c0:	6942                	ld	s2,16(sp)
    800029c2:	69a2                	ld	s3,8(sp)
    800029c4:	6145                	addi	sp,sp,48
    800029c6:	8082                	ret

00000000800029c8 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    800029c8:	1101                	addi	sp,sp,-32
    800029ca:	ec06                	sd	ra,24(sp)
    800029cc:	e822                	sd	s0,16(sp)
    800029ce:	e426                	sd	s1,8(sp)
    800029d0:	1000                	addi	s0,sp,32
    800029d2:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800029d4:	00000097          	auipc	ra,0x0
    800029d8:	ef2080e7          	jalr	-270(ra) # 800028c6 <argraw>
    800029dc:	c088                	sw	a0,0(s1)
  return 0;
}
    800029de:	4501                	li	a0,0
    800029e0:	60e2                	ld	ra,24(sp)
    800029e2:	6442                	ld	s0,16(sp)
    800029e4:	64a2                	ld	s1,8(sp)
    800029e6:	6105                	addi	sp,sp,32
    800029e8:	8082                	ret

00000000800029ea <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    800029ea:	1101                	addi	sp,sp,-32
    800029ec:	ec06                	sd	ra,24(sp)
    800029ee:	e822                	sd	s0,16(sp)
    800029f0:	e426                	sd	s1,8(sp)
    800029f2:	1000                	addi	s0,sp,32
    800029f4:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800029f6:	00000097          	auipc	ra,0x0
    800029fa:	ed0080e7          	jalr	-304(ra) # 800028c6 <argraw>
    800029fe:	e088                	sd	a0,0(s1)
  return 0;
}
    80002a00:	4501                	li	a0,0
    80002a02:	60e2                	ld	ra,24(sp)
    80002a04:	6442                	ld	s0,16(sp)
    80002a06:	64a2                	ld	s1,8(sp)
    80002a08:	6105                	addi	sp,sp,32
    80002a0a:	8082                	ret

0000000080002a0c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002a0c:	1101                	addi	sp,sp,-32
    80002a0e:	ec06                	sd	ra,24(sp)
    80002a10:	e822                	sd	s0,16(sp)
    80002a12:	e426                	sd	s1,8(sp)
    80002a14:	e04a                	sd	s2,0(sp)
    80002a16:	1000                	addi	s0,sp,32
    80002a18:	84ae                	mv	s1,a1
    80002a1a:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	eaa080e7          	jalr	-342(ra) # 800028c6 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002a24:	864a                	mv	a2,s2
    80002a26:	85a6                	mv	a1,s1
    80002a28:	00000097          	auipc	ra,0x0
    80002a2c:	f58080e7          	jalr	-168(ra) # 80002980 <fetchstr>
}
    80002a30:	60e2                	ld	ra,24(sp)
    80002a32:	6442                	ld	s0,16(sp)
    80002a34:	64a2                	ld	s1,8(sp)
    80002a36:	6902                	ld	s2,0(sp)
    80002a38:	6105                	addi	sp,sp,32
    80002a3a:	8082                	ret

0000000080002a3c <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80002a3c:	1101                	addi	sp,sp,-32
    80002a3e:	ec06                	sd	ra,24(sp)
    80002a40:	e822                	sd	s0,16(sp)
    80002a42:	e426                	sd	s1,8(sp)
    80002a44:	e04a                	sd	s2,0(sp)
    80002a46:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002a48:	fffff097          	auipc	ra,0xfffff
    80002a4c:	f3c080e7          	jalr	-196(ra) # 80001984 <myproc>
    80002a50:	84aa                	mv	s1,a0

  num = p->tf->a7;
    80002a52:	05853903          	ld	s2,88(a0)
    80002a56:	0a893783          	ld	a5,168(s2)
    80002a5a:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002a5e:	37fd                	addiw	a5,a5,-1
    80002a60:	4751                	li	a4,20
    80002a62:	00f76f63          	bltu	a4,a5,80002a80 <syscall+0x44>
    80002a66:	00369713          	slli	a4,a3,0x3
    80002a6a:	00005797          	auipc	a5,0x5
    80002a6e:	17678793          	addi	a5,a5,374 # 80007be0 <syscalls>
    80002a72:	97ba                	add	a5,a5,a4
    80002a74:	639c                	ld	a5,0(a5)
    80002a76:	c789                	beqz	a5,80002a80 <syscall+0x44>
    p->tf->a0 = syscalls[num]();
    80002a78:	9782                	jalr	a5
    80002a7a:	06a93823          	sd	a0,112(s2)
    80002a7e:	a839                	j	80002a9c <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002a80:	15848613          	addi	a2,s1,344
    80002a84:	5c8c                	lw	a1,56(s1)
    80002a86:	00005517          	auipc	a0,0x5
    80002a8a:	d9a50513          	addi	a0,a0,-614 # 80007820 <userret+0x790>
    80002a8e:	ffffe097          	auipc	ra,0xffffe
    80002a92:	b0a080e7          	jalr	-1270(ra) # 80000598 <printf>
            p->pid, p->name, num);
    p->tf->a0 = -1;
    80002a96:	6cbc                	ld	a5,88(s1)
    80002a98:	577d                	li	a4,-1
    80002a9a:	fbb8                	sd	a4,112(a5)
  }
}
    80002a9c:	60e2                	ld	ra,24(sp)
    80002a9e:	6442                	ld	s0,16(sp)
    80002aa0:	64a2                	ld	s1,8(sp)
    80002aa2:	6902                	ld	s2,0(sp)
    80002aa4:	6105                	addi	sp,sp,32
    80002aa6:	8082                	ret

0000000080002aa8 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002aa8:	1101                	addi	sp,sp,-32
    80002aaa:	ec06                	sd	ra,24(sp)
    80002aac:	e822                	sd	s0,16(sp)
    80002aae:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002ab0:	fec40593          	addi	a1,s0,-20
    80002ab4:	4501                	li	a0,0
    80002ab6:	00000097          	auipc	ra,0x0
    80002aba:	f12080e7          	jalr	-238(ra) # 800029c8 <argint>
    return -1;
    80002abe:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002ac0:	00054963          	bltz	a0,80002ad2 <sys_exit+0x2a>
  exit(n);
    80002ac4:	fec42503          	lw	a0,-20(s0)
    80002ac8:	fffff097          	auipc	ra,0xfffff
    80002acc:	518080e7          	jalr	1304(ra) # 80001fe0 <exit>
  return 0;  // not reached
    80002ad0:	4781                	li	a5,0
}
    80002ad2:	853e                	mv	a0,a5
    80002ad4:	60e2                	ld	ra,24(sp)
    80002ad6:	6442                	ld	s0,16(sp)
    80002ad8:	6105                	addi	sp,sp,32
    80002ada:	8082                	ret

0000000080002adc <sys_getpid>:

uint64
sys_getpid(void)
{
    80002adc:	1141                	addi	sp,sp,-16
    80002ade:	e406                	sd	ra,8(sp)
    80002ae0:	e022                	sd	s0,0(sp)
    80002ae2:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002ae4:	fffff097          	auipc	ra,0xfffff
    80002ae8:	ea0080e7          	jalr	-352(ra) # 80001984 <myproc>
}
    80002aec:	5d08                	lw	a0,56(a0)
    80002aee:	60a2                	ld	ra,8(sp)
    80002af0:	6402                	ld	s0,0(sp)
    80002af2:	0141                	addi	sp,sp,16
    80002af4:	8082                	ret

0000000080002af6 <sys_fork>:

uint64
sys_fork(void)
{
    80002af6:	1141                	addi	sp,sp,-16
    80002af8:	e406                	sd	ra,8(sp)
    80002afa:	e022                	sd	s0,0(sp)
    80002afc:	0800                	addi	s0,sp,16
  return fork();
    80002afe:	fffff097          	auipc	ra,0xfffff
    80002b02:	1f0080e7          	jalr	496(ra) # 80001cee <fork>
}
    80002b06:	60a2                	ld	ra,8(sp)
    80002b08:	6402                	ld	s0,0(sp)
    80002b0a:	0141                	addi	sp,sp,16
    80002b0c:	8082                	ret

0000000080002b0e <sys_wait>:

uint64
sys_wait(void)
{
    80002b0e:	1101                	addi	sp,sp,-32
    80002b10:	ec06                	sd	ra,24(sp)
    80002b12:	e822                	sd	s0,16(sp)
    80002b14:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002b16:	fe840593          	addi	a1,s0,-24
    80002b1a:	4501                	li	a0,0
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	ece080e7          	jalr	-306(ra) # 800029ea <argaddr>
    80002b24:	87aa                	mv	a5,a0
    return -1;
    80002b26:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002b28:	0007c863          	bltz	a5,80002b38 <sys_wait+0x2a>
  return wait(p);
    80002b2c:	fe843503          	ld	a0,-24(s0)
    80002b30:	fffff097          	auipc	ra,0xfffff
    80002b34:	674080e7          	jalr	1652(ra) # 800021a4 <wait>
}
    80002b38:	60e2                	ld	ra,24(sp)
    80002b3a:	6442                	ld	s0,16(sp)
    80002b3c:	6105                	addi	sp,sp,32
    80002b3e:	8082                	ret

0000000080002b40 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002b40:	7179                	addi	sp,sp,-48
    80002b42:	f406                	sd	ra,40(sp)
    80002b44:	f022                	sd	s0,32(sp)
    80002b46:	ec26                	sd	s1,24(sp)
    80002b48:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002b4a:	fdc40593          	addi	a1,s0,-36
    80002b4e:	4501                	li	a0,0
    80002b50:	00000097          	auipc	ra,0x0
    80002b54:	e78080e7          	jalr	-392(ra) # 800029c8 <argint>
    80002b58:	87aa                	mv	a5,a0
    return -1;
    80002b5a:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002b5c:	0207c063          	bltz	a5,80002b7c <sys_sbrk+0x3c>
  addr = myproc()->sz;
    80002b60:	fffff097          	auipc	ra,0xfffff
    80002b64:	e24080e7          	jalr	-476(ra) # 80001984 <myproc>
    80002b68:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002b6a:	fdc42503          	lw	a0,-36(s0)
    80002b6e:	fffff097          	auipc	ra,0xfffff
    80002b72:	10c080e7          	jalr	268(ra) # 80001c7a <growproc>
    80002b76:	00054863          	bltz	a0,80002b86 <sys_sbrk+0x46>
    return -1;
  return addr;
    80002b7a:	8526                	mv	a0,s1
}
    80002b7c:	70a2                	ld	ra,40(sp)
    80002b7e:	7402                	ld	s0,32(sp)
    80002b80:	64e2                	ld	s1,24(sp)
    80002b82:	6145                	addi	sp,sp,48
    80002b84:	8082                	ret
    return -1;
    80002b86:	557d                	li	a0,-1
    80002b88:	bfd5                	j	80002b7c <sys_sbrk+0x3c>

0000000080002b8a <sys_sleep>:

uint64
sys_sleep(void)
{
    80002b8a:	7139                	addi	sp,sp,-64
    80002b8c:	fc06                	sd	ra,56(sp)
    80002b8e:	f822                	sd	s0,48(sp)
    80002b90:	f426                	sd	s1,40(sp)
    80002b92:	f04a                	sd	s2,32(sp)
    80002b94:	ec4e                	sd	s3,24(sp)
    80002b96:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002b98:	fcc40593          	addi	a1,s0,-52
    80002b9c:	4501                	li	a0,0
    80002b9e:	00000097          	auipc	ra,0x0
    80002ba2:	e2a080e7          	jalr	-470(ra) # 800029c8 <argint>
    return -1;
    80002ba6:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002ba8:	06054563          	bltz	a0,80002c12 <sys_sleep+0x88>
  acquire(&tickslock);
    80002bac:	00015517          	auipc	a0,0x15
    80002bb0:	b5450513          	addi	a0,a0,-1196 # 80017700 <tickslock>
    80002bb4:	ffffe097          	auipc	ra,0xffffe
    80002bb8:	f1e080e7          	jalr	-226(ra) # 80000ad2 <acquire>
  ticks0 = ticks;
    80002bbc:	00023917          	auipc	s2,0x23
    80002bc0:	45c92903          	lw	s2,1116(s2) # 80026018 <ticks>
  while(ticks - ticks0 < n){
    80002bc4:	fcc42783          	lw	a5,-52(s0)
    80002bc8:	cf85                	beqz	a5,80002c00 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002bca:	00015997          	auipc	s3,0x15
    80002bce:	b3698993          	addi	s3,s3,-1226 # 80017700 <tickslock>
    80002bd2:	00023497          	auipc	s1,0x23
    80002bd6:	44648493          	addi	s1,s1,1094 # 80026018 <ticks>
    if(myproc()->killed){
    80002bda:	fffff097          	auipc	ra,0xfffff
    80002bde:	daa080e7          	jalr	-598(ra) # 80001984 <myproc>
    80002be2:	591c                	lw	a5,48(a0)
    80002be4:	ef9d                	bnez	a5,80002c22 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002be6:	85ce                	mv	a1,s3
    80002be8:	8526                	mv	a0,s1
    80002bea:	fffff097          	auipc	ra,0xfffff
    80002bee:	53c080e7          	jalr	1340(ra) # 80002126 <sleep>
  while(ticks - ticks0 < n){
    80002bf2:	409c                	lw	a5,0(s1)
    80002bf4:	412787bb          	subw	a5,a5,s2
    80002bf8:	fcc42703          	lw	a4,-52(s0)
    80002bfc:	fce7efe3          	bltu	a5,a4,80002bda <sys_sleep+0x50>
  }
  release(&tickslock);
    80002c00:	00015517          	auipc	a0,0x15
    80002c04:	b0050513          	addi	a0,a0,-1280 # 80017700 <tickslock>
    80002c08:	ffffe097          	auipc	ra,0xffffe
    80002c0c:	f1e080e7          	jalr	-226(ra) # 80000b26 <release>
  return 0;
    80002c10:	4781                	li	a5,0
}
    80002c12:	853e                	mv	a0,a5
    80002c14:	70e2                	ld	ra,56(sp)
    80002c16:	7442                	ld	s0,48(sp)
    80002c18:	74a2                	ld	s1,40(sp)
    80002c1a:	7902                	ld	s2,32(sp)
    80002c1c:	69e2                	ld	s3,24(sp)
    80002c1e:	6121                	addi	sp,sp,64
    80002c20:	8082                	ret
      release(&tickslock);
    80002c22:	00015517          	auipc	a0,0x15
    80002c26:	ade50513          	addi	a0,a0,-1314 # 80017700 <tickslock>
    80002c2a:	ffffe097          	auipc	ra,0xffffe
    80002c2e:	efc080e7          	jalr	-260(ra) # 80000b26 <release>
      return -1;
    80002c32:	57fd                	li	a5,-1
    80002c34:	bff9                	j	80002c12 <sys_sleep+0x88>

0000000080002c36 <sys_kill>:

uint64
sys_kill(void)
{
    80002c36:	1101                	addi	sp,sp,-32
    80002c38:	ec06                	sd	ra,24(sp)
    80002c3a:	e822                	sd	s0,16(sp)
    80002c3c:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002c3e:	fec40593          	addi	a1,s0,-20
    80002c42:	4501                	li	a0,0
    80002c44:	00000097          	auipc	ra,0x0
    80002c48:	d84080e7          	jalr	-636(ra) # 800029c8 <argint>
    80002c4c:	87aa                	mv	a5,a0
    return -1;
    80002c4e:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002c50:	0007c863          	bltz	a5,80002c60 <sys_kill+0x2a>
  return kill(pid);
    80002c54:	fec42503          	lw	a0,-20(s0)
    80002c58:	fffff097          	auipc	ra,0xfffff
    80002c5c:	6be080e7          	jalr	1726(ra) # 80002316 <kill>
}
    80002c60:	60e2                	ld	ra,24(sp)
    80002c62:	6442                	ld	s0,16(sp)
    80002c64:	6105                	addi	sp,sp,32
    80002c66:	8082                	ret

0000000080002c68 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002c68:	1101                	addi	sp,sp,-32
    80002c6a:	ec06                	sd	ra,24(sp)
    80002c6c:	e822                	sd	s0,16(sp)
    80002c6e:	e426                	sd	s1,8(sp)
    80002c70:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002c72:	00015517          	auipc	a0,0x15
    80002c76:	a8e50513          	addi	a0,a0,-1394 # 80017700 <tickslock>
    80002c7a:	ffffe097          	auipc	ra,0xffffe
    80002c7e:	e58080e7          	jalr	-424(ra) # 80000ad2 <acquire>
  xticks = ticks;
    80002c82:	00023497          	auipc	s1,0x23
    80002c86:	3964a483          	lw	s1,918(s1) # 80026018 <ticks>
  release(&tickslock);
    80002c8a:	00015517          	auipc	a0,0x15
    80002c8e:	a7650513          	addi	a0,a0,-1418 # 80017700 <tickslock>
    80002c92:	ffffe097          	auipc	ra,0xffffe
    80002c96:	e94080e7          	jalr	-364(ra) # 80000b26 <release>
  return xticks;
}
    80002c9a:	02049513          	slli	a0,s1,0x20
    80002c9e:	9101                	srli	a0,a0,0x20
    80002ca0:	60e2                	ld	ra,24(sp)
    80002ca2:	6442                	ld	s0,16(sp)
    80002ca4:	64a2                	ld	s1,8(sp)
    80002ca6:	6105                	addi	sp,sp,32
    80002ca8:	8082                	ret

0000000080002caa <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002caa:	7179                	addi	sp,sp,-48
    80002cac:	f406                	sd	ra,40(sp)
    80002cae:	f022                	sd	s0,32(sp)
    80002cb0:	ec26                	sd	s1,24(sp)
    80002cb2:	e84a                	sd	s2,16(sp)
    80002cb4:	e44e                	sd	s3,8(sp)
    80002cb6:	e052                	sd	s4,0(sp)
    80002cb8:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002cba:	00005597          	auipc	a1,0x5
    80002cbe:	b8658593          	addi	a1,a1,-1146 # 80007840 <userret+0x7b0>
    80002cc2:	00015517          	auipc	a0,0x15
    80002cc6:	a5650513          	addi	a0,a0,-1450 # 80017718 <bcache>
    80002cca:	ffffe097          	auipc	ra,0xffffe
    80002cce:	cf6080e7          	jalr	-778(ra) # 800009c0 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002cd2:	0001d797          	auipc	a5,0x1d
    80002cd6:	a4678793          	addi	a5,a5,-1466 # 8001f718 <bcache+0x8000>
    80002cda:	0001d717          	auipc	a4,0x1d
    80002cde:	d9670713          	addi	a4,a4,-618 # 8001fa70 <bcache+0x8358>
    80002ce2:	3ae7b023          	sd	a4,928(a5)
  bcache.head.next = &bcache.head;
    80002ce6:	3ae7b423          	sd	a4,936(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002cea:	00015497          	auipc	s1,0x15
    80002cee:	a4648493          	addi	s1,s1,-1466 # 80017730 <bcache+0x18>
    b->next = bcache.head.next;
    80002cf2:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002cf4:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002cf6:	00005a17          	auipc	s4,0x5
    80002cfa:	b52a0a13          	addi	s4,s4,-1198 # 80007848 <userret+0x7b8>
    b->next = bcache.head.next;
    80002cfe:	3a893783          	ld	a5,936(s2)
    80002d02:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002d04:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002d08:	85d2                	mv	a1,s4
    80002d0a:	01048513          	addi	a0,s1,16
    80002d0e:	00001097          	auipc	ra,0x1
    80002d12:	486080e7          	jalr	1158(ra) # 80004194 <initsleeplock>
    bcache.head.next->prev = b;
    80002d16:	3a893783          	ld	a5,936(s2)
    80002d1a:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002d1c:	3a993423          	sd	s1,936(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002d20:	46048493          	addi	s1,s1,1120
    80002d24:	fd349de3          	bne	s1,s3,80002cfe <binit+0x54>
  }
}
    80002d28:	70a2                	ld	ra,40(sp)
    80002d2a:	7402                	ld	s0,32(sp)
    80002d2c:	64e2                	ld	s1,24(sp)
    80002d2e:	6942                	ld	s2,16(sp)
    80002d30:	69a2                	ld	s3,8(sp)
    80002d32:	6a02                	ld	s4,0(sp)
    80002d34:	6145                	addi	sp,sp,48
    80002d36:	8082                	ret

0000000080002d38 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002d38:	7179                	addi	sp,sp,-48
    80002d3a:	f406                	sd	ra,40(sp)
    80002d3c:	f022                	sd	s0,32(sp)
    80002d3e:	ec26                	sd	s1,24(sp)
    80002d40:	e84a                	sd	s2,16(sp)
    80002d42:	e44e                	sd	s3,8(sp)
    80002d44:	1800                	addi	s0,sp,48
    80002d46:	89aa                	mv	s3,a0
    80002d48:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    80002d4a:	00015517          	auipc	a0,0x15
    80002d4e:	9ce50513          	addi	a0,a0,-1586 # 80017718 <bcache>
    80002d52:	ffffe097          	auipc	ra,0xffffe
    80002d56:	d80080e7          	jalr	-640(ra) # 80000ad2 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002d5a:	0001d497          	auipc	s1,0x1d
    80002d5e:	d664b483          	ld	s1,-666(s1) # 8001fac0 <bcache+0x83a8>
    80002d62:	0001d797          	auipc	a5,0x1d
    80002d66:	d0e78793          	addi	a5,a5,-754 # 8001fa70 <bcache+0x8358>
    80002d6a:	02f48f63          	beq	s1,a5,80002da8 <bread+0x70>
    80002d6e:	873e                	mv	a4,a5
    80002d70:	a021                	j	80002d78 <bread+0x40>
    80002d72:	68a4                	ld	s1,80(s1)
    80002d74:	02e48a63          	beq	s1,a4,80002da8 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002d78:	449c                	lw	a5,8(s1)
    80002d7a:	ff379ce3          	bne	a5,s3,80002d72 <bread+0x3a>
    80002d7e:	44dc                	lw	a5,12(s1)
    80002d80:	ff2799e3          	bne	a5,s2,80002d72 <bread+0x3a>
      b->refcnt++;
    80002d84:	40bc                	lw	a5,64(s1)
    80002d86:	2785                	addiw	a5,a5,1
    80002d88:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002d8a:	00015517          	auipc	a0,0x15
    80002d8e:	98e50513          	addi	a0,a0,-1650 # 80017718 <bcache>
    80002d92:	ffffe097          	auipc	ra,0xffffe
    80002d96:	d94080e7          	jalr	-620(ra) # 80000b26 <release>
      acquiresleep(&b->lock);
    80002d9a:	01048513          	addi	a0,s1,16
    80002d9e:	00001097          	auipc	ra,0x1
    80002da2:	430080e7          	jalr	1072(ra) # 800041ce <acquiresleep>
      return b;
    80002da6:	a8b9                	j	80002e04 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002da8:	0001d497          	auipc	s1,0x1d
    80002dac:	d104b483          	ld	s1,-752(s1) # 8001fab8 <bcache+0x83a0>
    80002db0:	0001d797          	auipc	a5,0x1d
    80002db4:	cc078793          	addi	a5,a5,-832 # 8001fa70 <bcache+0x8358>
    80002db8:	00f48863          	beq	s1,a5,80002dc8 <bread+0x90>
    80002dbc:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002dbe:	40bc                	lw	a5,64(s1)
    80002dc0:	cf81                	beqz	a5,80002dd8 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002dc2:	64a4                	ld	s1,72(s1)
    80002dc4:	fee49de3          	bne	s1,a4,80002dbe <bread+0x86>
  panic("bget: no buffers");
    80002dc8:	00005517          	auipc	a0,0x5
    80002dcc:	a8850513          	addi	a0,a0,-1400 # 80007850 <userret+0x7c0>
    80002dd0:	ffffd097          	auipc	ra,0xffffd
    80002dd4:	77e080e7          	jalr	1918(ra) # 8000054e <panic>
      b->dev = dev;
    80002dd8:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    80002ddc:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80002de0:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002de4:	4785                	li	a5,1
    80002de6:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002de8:	00015517          	auipc	a0,0x15
    80002dec:	93050513          	addi	a0,a0,-1744 # 80017718 <bcache>
    80002df0:	ffffe097          	auipc	ra,0xffffe
    80002df4:	d36080e7          	jalr	-714(ra) # 80000b26 <release>
      acquiresleep(&b->lock);
    80002df8:	01048513          	addi	a0,s1,16
    80002dfc:	00001097          	auipc	ra,0x1
    80002e00:	3d2080e7          	jalr	978(ra) # 800041ce <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002e04:	409c                	lw	a5,0(s1)
    80002e06:	cb89                	beqz	a5,80002e18 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002e08:	8526                	mv	a0,s1
    80002e0a:	70a2                	ld	ra,40(sp)
    80002e0c:	7402                	ld	s0,32(sp)
    80002e0e:	64e2                	ld	s1,24(sp)
    80002e10:	6942                	ld	s2,16(sp)
    80002e12:	69a2                	ld	s3,8(sp)
    80002e14:	6145                	addi	sp,sp,48
    80002e16:	8082                	ret
    virtio_disk_rw(b, 0);
    80002e18:	4581                	li	a1,0
    80002e1a:	8526                	mv	a0,s1
    80002e1c:	00003097          	auipc	ra,0x3
    80002e20:	ee2080e7          	jalr	-286(ra) # 80005cfe <virtio_disk_rw>
    b->valid = 1;
    80002e24:	4785                	li	a5,1
    80002e26:	c09c                	sw	a5,0(s1)
  return b;
    80002e28:	b7c5                	j	80002e08 <bread+0xd0>

0000000080002e2a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002e2a:	1101                	addi	sp,sp,-32
    80002e2c:	ec06                	sd	ra,24(sp)
    80002e2e:	e822                	sd	s0,16(sp)
    80002e30:	e426                	sd	s1,8(sp)
    80002e32:	1000                	addi	s0,sp,32
    80002e34:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002e36:	0541                	addi	a0,a0,16
    80002e38:	00001097          	auipc	ra,0x1
    80002e3c:	430080e7          	jalr	1072(ra) # 80004268 <holdingsleep>
    80002e40:	cd01                	beqz	a0,80002e58 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002e42:	4585                	li	a1,1
    80002e44:	8526                	mv	a0,s1
    80002e46:	00003097          	auipc	ra,0x3
    80002e4a:	eb8080e7          	jalr	-328(ra) # 80005cfe <virtio_disk_rw>
}
    80002e4e:	60e2                	ld	ra,24(sp)
    80002e50:	6442                	ld	s0,16(sp)
    80002e52:	64a2                	ld	s1,8(sp)
    80002e54:	6105                	addi	sp,sp,32
    80002e56:	8082                	ret
    panic("bwrite");
    80002e58:	00005517          	auipc	a0,0x5
    80002e5c:	a1050513          	addi	a0,a0,-1520 # 80007868 <userret+0x7d8>
    80002e60:	ffffd097          	auipc	ra,0xffffd
    80002e64:	6ee080e7          	jalr	1774(ra) # 8000054e <panic>

0000000080002e68 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
    80002e68:	1101                	addi	sp,sp,-32
    80002e6a:	ec06                	sd	ra,24(sp)
    80002e6c:	e822                	sd	s0,16(sp)
    80002e6e:	e426                	sd	s1,8(sp)
    80002e70:	e04a                	sd	s2,0(sp)
    80002e72:	1000                	addi	s0,sp,32
    80002e74:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002e76:	01050913          	addi	s2,a0,16
    80002e7a:	854a                	mv	a0,s2
    80002e7c:	00001097          	auipc	ra,0x1
    80002e80:	3ec080e7          	jalr	1004(ra) # 80004268 <holdingsleep>
    80002e84:	c92d                	beqz	a0,80002ef6 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002e86:	854a                	mv	a0,s2
    80002e88:	00001097          	auipc	ra,0x1
    80002e8c:	39c080e7          	jalr	924(ra) # 80004224 <releasesleep>

  acquire(&bcache.lock);
    80002e90:	00015517          	auipc	a0,0x15
    80002e94:	88850513          	addi	a0,a0,-1912 # 80017718 <bcache>
    80002e98:	ffffe097          	auipc	ra,0xffffe
    80002e9c:	c3a080e7          	jalr	-966(ra) # 80000ad2 <acquire>
  b->refcnt--;
    80002ea0:	40bc                	lw	a5,64(s1)
    80002ea2:	37fd                	addiw	a5,a5,-1
    80002ea4:	0007871b          	sext.w	a4,a5
    80002ea8:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002eaa:	eb05                	bnez	a4,80002eda <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002eac:	68bc                	ld	a5,80(s1)
    80002eae:	64b8                	ld	a4,72(s1)
    80002eb0:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002eb2:	64bc                	ld	a5,72(s1)
    80002eb4:	68b8                	ld	a4,80(s1)
    80002eb6:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002eb8:	0001d797          	auipc	a5,0x1d
    80002ebc:	86078793          	addi	a5,a5,-1952 # 8001f718 <bcache+0x8000>
    80002ec0:	3a87b703          	ld	a4,936(a5)
    80002ec4:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002ec6:	0001d717          	auipc	a4,0x1d
    80002eca:	baa70713          	addi	a4,a4,-1110 # 8001fa70 <bcache+0x8358>
    80002ece:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002ed0:	3a87b703          	ld	a4,936(a5)
    80002ed4:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002ed6:	3a97b423          	sd	s1,936(a5)
  }
  
  release(&bcache.lock);
    80002eda:	00015517          	auipc	a0,0x15
    80002ede:	83e50513          	addi	a0,a0,-1986 # 80017718 <bcache>
    80002ee2:	ffffe097          	auipc	ra,0xffffe
    80002ee6:	c44080e7          	jalr	-956(ra) # 80000b26 <release>
}
    80002eea:	60e2                	ld	ra,24(sp)
    80002eec:	6442                	ld	s0,16(sp)
    80002eee:	64a2                	ld	s1,8(sp)
    80002ef0:	6902                	ld	s2,0(sp)
    80002ef2:	6105                	addi	sp,sp,32
    80002ef4:	8082                	ret
    panic("brelse");
    80002ef6:	00005517          	auipc	a0,0x5
    80002efa:	97a50513          	addi	a0,a0,-1670 # 80007870 <userret+0x7e0>
    80002efe:	ffffd097          	auipc	ra,0xffffd
    80002f02:	650080e7          	jalr	1616(ra) # 8000054e <panic>

0000000080002f06 <bpin>:

void
bpin(struct buf *b) {
    80002f06:	1101                	addi	sp,sp,-32
    80002f08:	ec06                	sd	ra,24(sp)
    80002f0a:	e822                	sd	s0,16(sp)
    80002f0c:	e426                	sd	s1,8(sp)
    80002f0e:	1000                	addi	s0,sp,32
    80002f10:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002f12:	00015517          	auipc	a0,0x15
    80002f16:	80650513          	addi	a0,a0,-2042 # 80017718 <bcache>
    80002f1a:	ffffe097          	auipc	ra,0xffffe
    80002f1e:	bb8080e7          	jalr	-1096(ra) # 80000ad2 <acquire>
  b->refcnt++;
    80002f22:	40bc                	lw	a5,64(s1)
    80002f24:	2785                	addiw	a5,a5,1
    80002f26:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002f28:	00014517          	auipc	a0,0x14
    80002f2c:	7f050513          	addi	a0,a0,2032 # 80017718 <bcache>
    80002f30:	ffffe097          	auipc	ra,0xffffe
    80002f34:	bf6080e7          	jalr	-1034(ra) # 80000b26 <release>
}
    80002f38:	60e2                	ld	ra,24(sp)
    80002f3a:	6442                	ld	s0,16(sp)
    80002f3c:	64a2                	ld	s1,8(sp)
    80002f3e:	6105                	addi	sp,sp,32
    80002f40:	8082                	ret

0000000080002f42 <bunpin>:

void
bunpin(struct buf *b) {
    80002f42:	1101                	addi	sp,sp,-32
    80002f44:	ec06                	sd	ra,24(sp)
    80002f46:	e822                	sd	s0,16(sp)
    80002f48:	e426                	sd	s1,8(sp)
    80002f4a:	1000                	addi	s0,sp,32
    80002f4c:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002f4e:	00014517          	auipc	a0,0x14
    80002f52:	7ca50513          	addi	a0,a0,1994 # 80017718 <bcache>
    80002f56:	ffffe097          	auipc	ra,0xffffe
    80002f5a:	b7c080e7          	jalr	-1156(ra) # 80000ad2 <acquire>
  b->refcnt--;
    80002f5e:	40bc                	lw	a5,64(s1)
    80002f60:	37fd                	addiw	a5,a5,-1
    80002f62:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002f64:	00014517          	auipc	a0,0x14
    80002f68:	7b450513          	addi	a0,a0,1972 # 80017718 <bcache>
    80002f6c:	ffffe097          	auipc	ra,0xffffe
    80002f70:	bba080e7          	jalr	-1094(ra) # 80000b26 <release>
}
    80002f74:	60e2                	ld	ra,24(sp)
    80002f76:	6442                	ld	s0,16(sp)
    80002f78:	64a2                	ld	s1,8(sp)
    80002f7a:	6105                	addi	sp,sp,32
    80002f7c:	8082                	ret

0000000080002f7e <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002f7e:	1101                	addi	sp,sp,-32
    80002f80:	ec06                	sd	ra,24(sp)
    80002f82:	e822                	sd	s0,16(sp)
    80002f84:	e426                	sd	s1,8(sp)
    80002f86:	e04a                	sd	s2,0(sp)
    80002f88:	1000                	addi	s0,sp,32
    80002f8a:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002f8c:	00d5d59b          	srliw	a1,a1,0xd
    80002f90:	0001d797          	auipc	a5,0x1d
    80002f94:	f5c7a783          	lw	a5,-164(a5) # 8001feec <sb+0x1c>
    80002f98:	9dbd                	addw	a1,a1,a5
    80002f9a:	00000097          	auipc	ra,0x0
    80002f9e:	d9e080e7          	jalr	-610(ra) # 80002d38 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002fa2:	0074f713          	andi	a4,s1,7
    80002fa6:	4785                	li	a5,1
    80002fa8:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002fac:	14ce                	slli	s1,s1,0x33
    80002fae:	90d9                	srli	s1,s1,0x36
    80002fb0:	00950733          	add	a4,a0,s1
    80002fb4:	06074703          	lbu	a4,96(a4)
    80002fb8:	00e7f6b3          	and	a3,a5,a4
    80002fbc:	c69d                	beqz	a3,80002fea <bfree+0x6c>
    80002fbe:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002fc0:	94aa                	add	s1,s1,a0
    80002fc2:	fff7c793          	not	a5,a5
    80002fc6:	8ff9                	and	a5,a5,a4
    80002fc8:	06f48023          	sb	a5,96(s1)
  log_write(bp);
    80002fcc:	00001097          	auipc	ra,0x1
    80002fd0:	0da080e7          	jalr	218(ra) # 800040a6 <log_write>
  brelse(bp);
    80002fd4:	854a                	mv	a0,s2
    80002fd6:	00000097          	auipc	ra,0x0
    80002fda:	e92080e7          	jalr	-366(ra) # 80002e68 <brelse>
}
    80002fde:	60e2                	ld	ra,24(sp)
    80002fe0:	6442                	ld	s0,16(sp)
    80002fe2:	64a2                	ld	s1,8(sp)
    80002fe4:	6902                	ld	s2,0(sp)
    80002fe6:	6105                	addi	sp,sp,32
    80002fe8:	8082                	ret
    panic("freeing free block");
    80002fea:	00005517          	auipc	a0,0x5
    80002fee:	88e50513          	addi	a0,a0,-1906 # 80007878 <userret+0x7e8>
    80002ff2:	ffffd097          	auipc	ra,0xffffd
    80002ff6:	55c080e7          	jalr	1372(ra) # 8000054e <panic>

0000000080002ffa <balloc>:
{
    80002ffa:	711d                	addi	sp,sp,-96
    80002ffc:	ec86                	sd	ra,88(sp)
    80002ffe:	e8a2                	sd	s0,80(sp)
    80003000:	e4a6                	sd	s1,72(sp)
    80003002:	e0ca                	sd	s2,64(sp)
    80003004:	fc4e                	sd	s3,56(sp)
    80003006:	f852                	sd	s4,48(sp)
    80003008:	f456                	sd	s5,40(sp)
    8000300a:	f05a                	sd	s6,32(sp)
    8000300c:	ec5e                	sd	s7,24(sp)
    8000300e:	e862                	sd	s8,16(sp)
    80003010:	e466                	sd	s9,8(sp)
    80003012:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003014:	0001d797          	auipc	a5,0x1d
    80003018:	ec07a783          	lw	a5,-320(a5) # 8001fed4 <sb+0x4>
    8000301c:	cbd1                	beqz	a5,800030b0 <balloc+0xb6>
    8000301e:	8baa                	mv	s7,a0
    80003020:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003022:	0001db17          	auipc	s6,0x1d
    80003026:	eaeb0b13          	addi	s6,s6,-338 # 8001fed0 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000302a:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000302c:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000302e:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003030:	6c89                	lui	s9,0x2
    80003032:	a831                	j	8000304e <balloc+0x54>
    brelse(bp);
    80003034:	854a                	mv	a0,s2
    80003036:	00000097          	auipc	ra,0x0
    8000303a:	e32080e7          	jalr	-462(ra) # 80002e68 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000303e:	015c87bb          	addw	a5,s9,s5
    80003042:	00078a9b          	sext.w	s5,a5
    80003046:	004b2703          	lw	a4,4(s6)
    8000304a:	06eaf363          	bgeu	s5,a4,800030b0 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    8000304e:	41fad79b          	sraiw	a5,s5,0x1f
    80003052:	0137d79b          	srliw	a5,a5,0x13
    80003056:	015787bb          	addw	a5,a5,s5
    8000305a:	40d7d79b          	sraiw	a5,a5,0xd
    8000305e:	01cb2583          	lw	a1,28(s6)
    80003062:	9dbd                	addw	a1,a1,a5
    80003064:	855e                	mv	a0,s7
    80003066:	00000097          	auipc	ra,0x0
    8000306a:	cd2080e7          	jalr	-814(ra) # 80002d38 <bread>
    8000306e:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003070:	004b2503          	lw	a0,4(s6)
    80003074:	000a849b          	sext.w	s1,s5
    80003078:	8662                	mv	a2,s8
    8000307a:	faa4fde3          	bgeu	s1,a0,80003034 <balloc+0x3a>
      m = 1 << (bi % 8);
    8000307e:	41f6579b          	sraiw	a5,a2,0x1f
    80003082:	01d7d69b          	srliw	a3,a5,0x1d
    80003086:	00c6873b          	addw	a4,a3,a2
    8000308a:	00777793          	andi	a5,a4,7
    8000308e:	9f95                	subw	a5,a5,a3
    80003090:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80003094:	4037571b          	sraiw	a4,a4,0x3
    80003098:	00e906b3          	add	a3,s2,a4
    8000309c:	0606c683          	lbu	a3,96(a3)
    800030a0:	00d7f5b3          	and	a1,a5,a3
    800030a4:	cd91                	beqz	a1,800030c0 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800030a6:	2605                	addiw	a2,a2,1
    800030a8:	2485                	addiw	s1,s1,1
    800030aa:	fd4618e3          	bne	a2,s4,8000307a <balloc+0x80>
    800030ae:	b759                	j	80003034 <balloc+0x3a>
  panic("balloc: out of blocks");
    800030b0:	00004517          	auipc	a0,0x4
    800030b4:	7e050513          	addi	a0,a0,2016 # 80007890 <userret+0x800>
    800030b8:	ffffd097          	auipc	ra,0xffffd
    800030bc:	496080e7          	jalr	1174(ra) # 8000054e <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800030c0:	974a                	add	a4,a4,s2
    800030c2:	8fd5                	or	a5,a5,a3
    800030c4:	06f70023          	sb	a5,96(a4)
        log_write(bp);
    800030c8:	854a                	mv	a0,s2
    800030ca:	00001097          	auipc	ra,0x1
    800030ce:	fdc080e7          	jalr	-36(ra) # 800040a6 <log_write>
        brelse(bp);
    800030d2:	854a                	mv	a0,s2
    800030d4:	00000097          	auipc	ra,0x0
    800030d8:	d94080e7          	jalr	-620(ra) # 80002e68 <brelse>
  bp = bread(dev, bno);
    800030dc:	85a6                	mv	a1,s1
    800030de:	855e                	mv	a0,s7
    800030e0:	00000097          	auipc	ra,0x0
    800030e4:	c58080e7          	jalr	-936(ra) # 80002d38 <bread>
    800030e8:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800030ea:	40000613          	li	a2,1024
    800030ee:	4581                	li	a1,0
    800030f0:	06050513          	addi	a0,a0,96
    800030f4:	ffffe097          	auipc	ra,0xffffe
    800030f8:	a7a080e7          	jalr	-1414(ra) # 80000b6e <memset>
  log_write(bp);
    800030fc:	854a                	mv	a0,s2
    800030fe:	00001097          	auipc	ra,0x1
    80003102:	fa8080e7          	jalr	-88(ra) # 800040a6 <log_write>
  brelse(bp);
    80003106:	854a                	mv	a0,s2
    80003108:	00000097          	auipc	ra,0x0
    8000310c:	d60080e7          	jalr	-672(ra) # 80002e68 <brelse>
}
    80003110:	8526                	mv	a0,s1
    80003112:	60e6                	ld	ra,88(sp)
    80003114:	6446                	ld	s0,80(sp)
    80003116:	64a6                	ld	s1,72(sp)
    80003118:	6906                	ld	s2,64(sp)
    8000311a:	79e2                	ld	s3,56(sp)
    8000311c:	7a42                	ld	s4,48(sp)
    8000311e:	7aa2                	ld	s5,40(sp)
    80003120:	7b02                	ld	s6,32(sp)
    80003122:	6be2                	ld	s7,24(sp)
    80003124:	6c42                	ld	s8,16(sp)
    80003126:	6ca2                	ld	s9,8(sp)
    80003128:	6125                	addi	sp,sp,96
    8000312a:	8082                	ret

000000008000312c <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000312c:	7179                	addi	sp,sp,-48
    8000312e:	f406                	sd	ra,40(sp)
    80003130:	f022                	sd	s0,32(sp)
    80003132:	ec26                	sd	s1,24(sp)
    80003134:	e84a                	sd	s2,16(sp)
    80003136:	e44e                	sd	s3,8(sp)
    80003138:	e052                	sd	s4,0(sp)
    8000313a:	1800                	addi	s0,sp,48
    8000313c:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000313e:	47ad                	li	a5,11
    80003140:	04b7fe63          	bgeu	a5,a1,8000319c <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80003144:	ff45849b          	addiw	s1,a1,-12
    80003148:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000314c:	0ff00793          	li	a5,255
    80003150:	0ae7e363          	bltu	a5,a4,800031f6 <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80003154:	08052583          	lw	a1,128(a0)
    80003158:	c5ad                	beqz	a1,800031c2 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000315a:	00092503          	lw	a0,0(s2)
    8000315e:	00000097          	auipc	ra,0x0
    80003162:	bda080e7          	jalr	-1062(ra) # 80002d38 <bread>
    80003166:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80003168:	06050793          	addi	a5,a0,96
    if((addr = a[bn]) == 0){
    8000316c:	02049593          	slli	a1,s1,0x20
    80003170:	9181                	srli	a1,a1,0x20
    80003172:	058a                	slli	a1,a1,0x2
    80003174:	00b784b3          	add	s1,a5,a1
    80003178:	0004a983          	lw	s3,0(s1)
    8000317c:	04098d63          	beqz	s3,800031d6 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80003180:	8552                	mv	a0,s4
    80003182:	00000097          	auipc	ra,0x0
    80003186:	ce6080e7          	jalr	-794(ra) # 80002e68 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    8000318a:	854e                	mv	a0,s3
    8000318c:	70a2                	ld	ra,40(sp)
    8000318e:	7402                	ld	s0,32(sp)
    80003190:	64e2                	ld	s1,24(sp)
    80003192:	6942                	ld	s2,16(sp)
    80003194:	69a2                	ld	s3,8(sp)
    80003196:	6a02                	ld	s4,0(sp)
    80003198:	6145                	addi	sp,sp,48
    8000319a:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000319c:	02059493          	slli	s1,a1,0x20
    800031a0:	9081                	srli	s1,s1,0x20
    800031a2:	048a                	slli	s1,s1,0x2
    800031a4:	94aa                	add	s1,s1,a0
    800031a6:	0504a983          	lw	s3,80(s1)
    800031aa:	fe0990e3          	bnez	s3,8000318a <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800031ae:	4108                	lw	a0,0(a0)
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	e4a080e7          	jalr	-438(ra) # 80002ffa <balloc>
    800031b8:	0005099b          	sext.w	s3,a0
    800031bc:	0534a823          	sw	s3,80(s1)
    800031c0:	b7e9                	j	8000318a <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800031c2:	4108                	lw	a0,0(a0)
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	e36080e7          	jalr	-458(ra) # 80002ffa <balloc>
    800031cc:	0005059b          	sext.w	a1,a0
    800031d0:	08b92023          	sw	a1,128(s2)
    800031d4:	b759                	j	8000315a <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800031d6:	00092503          	lw	a0,0(s2)
    800031da:	00000097          	auipc	ra,0x0
    800031de:	e20080e7          	jalr	-480(ra) # 80002ffa <balloc>
    800031e2:	0005099b          	sext.w	s3,a0
    800031e6:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    800031ea:	8552                	mv	a0,s4
    800031ec:	00001097          	auipc	ra,0x1
    800031f0:	eba080e7          	jalr	-326(ra) # 800040a6 <log_write>
    800031f4:	b771                	j	80003180 <bmap+0x54>
  panic("bmap: out of range");
    800031f6:	00004517          	auipc	a0,0x4
    800031fa:	6b250513          	addi	a0,a0,1714 # 800078a8 <userret+0x818>
    800031fe:	ffffd097          	auipc	ra,0xffffd
    80003202:	350080e7          	jalr	848(ra) # 8000054e <panic>

0000000080003206 <iget>:
{
    80003206:	7179                	addi	sp,sp,-48
    80003208:	f406                	sd	ra,40(sp)
    8000320a:	f022                	sd	s0,32(sp)
    8000320c:	ec26                	sd	s1,24(sp)
    8000320e:	e84a                	sd	s2,16(sp)
    80003210:	e44e                	sd	s3,8(sp)
    80003212:	e052                	sd	s4,0(sp)
    80003214:	1800                	addi	s0,sp,48
    80003216:	89aa                	mv	s3,a0
    80003218:	8a2e                	mv	s4,a1
  acquire(&icache.lock);
    8000321a:	0001d517          	auipc	a0,0x1d
    8000321e:	cd650513          	addi	a0,a0,-810 # 8001fef0 <icache>
    80003222:	ffffe097          	auipc	ra,0xffffe
    80003226:	8b0080e7          	jalr	-1872(ra) # 80000ad2 <acquire>
  empty = 0;
    8000322a:	4901                	li	s2,0
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    8000322c:	0001d497          	auipc	s1,0x1d
    80003230:	cdc48493          	addi	s1,s1,-804 # 8001ff08 <icache+0x18>
    80003234:	0001e697          	auipc	a3,0x1e
    80003238:	76468693          	addi	a3,a3,1892 # 80021998 <log>
    8000323c:	a039                	j	8000324a <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000323e:	02090b63          	beqz	s2,80003274 <iget+0x6e>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80003242:	08848493          	addi	s1,s1,136
    80003246:	02d48a63          	beq	s1,a3,8000327a <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000324a:	449c                	lw	a5,8(s1)
    8000324c:	fef059e3          	blez	a5,8000323e <iget+0x38>
    80003250:	4098                	lw	a4,0(s1)
    80003252:	ff3716e3          	bne	a4,s3,8000323e <iget+0x38>
    80003256:	40d8                	lw	a4,4(s1)
    80003258:	ff4713e3          	bne	a4,s4,8000323e <iget+0x38>
      ip->ref++;
    8000325c:	2785                	addiw	a5,a5,1
    8000325e:	c49c                	sw	a5,8(s1)
      release(&icache.lock);
    80003260:	0001d517          	auipc	a0,0x1d
    80003264:	c9050513          	addi	a0,a0,-880 # 8001fef0 <icache>
    80003268:	ffffe097          	auipc	ra,0xffffe
    8000326c:	8be080e7          	jalr	-1858(ra) # 80000b26 <release>
      return ip;
    80003270:	8926                	mv	s2,s1
    80003272:	a03d                	j	800032a0 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003274:	f7f9                	bnez	a5,80003242 <iget+0x3c>
    80003276:	8926                	mv	s2,s1
    80003278:	b7e9                	j	80003242 <iget+0x3c>
  if(empty == 0)
    8000327a:	02090c63          	beqz	s2,800032b2 <iget+0xac>
  ip->dev = dev;
    8000327e:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80003282:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80003286:	4785                	li	a5,1
    80003288:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000328c:	04092023          	sw	zero,64(s2)
  release(&icache.lock);
    80003290:	0001d517          	auipc	a0,0x1d
    80003294:	c6050513          	addi	a0,a0,-928 # 8001fef0 <icache>
    80003298:	ffffe097          	auipc	ra,0xffffe
    8000329c:	88e080e7          	jalr	-1906(ra) # 80000b26 <release>
}
    800032a0:	854a                	mv	a0,s2
    800032a2:	70a2                	ld	ra,40(sp)
    800032a4:	7402                	ld	s0,32(sp)
    800032a6:	64e2                	ld	s1,24(sp)
    800032a8:	6942                	ld	s2,16(sp)
    800032aa:	69a2                	ld	s3,8(sp)
    800032ac:	6a02                	ld	s4,0(sp)
    800032ae:	6145                	addi	sp,sp,48
    800032b0:	8082                	ret
    panic("iget: no inodes");
    800032b2:	00004517          	auipc	a0,0x4
    800032b6:	60e50513          	addi	a0,a0,1550 # 800078c0 <userret+0x830>
    800032ba:	ffffd097          	auipc	ra,0xffffd
    800032be:	294080e7          	jalr	660(ra) # 8000054e <panic>

00000000800032c2 <fsinit>:
fsinit(int dev) {
    800032c2:	7179                	addi	sp,sp,-48
    800032c4:	f406                	sd	ra,40(sp)
    800032c6:	f022                	sd	s0,32(sp)
    800032c8:	ec26                	sd	s1,24(sp)
    800032ca:	e84a                	sd	s2,16(sp)
    800032cc:	e44e                	sd	s3,8(sp)
    800032ce:	1800                	addi	s0,sp,48
    800032d0:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800032d2:	4585                	li	a1,1
    800032d4:	00000097          	auipc	ra,0x0
    800032d8:	a64080e7          	jalr	-1436(ra) # 80002d38 <bread>
    800032dc:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800032de:	0001d997          	auipc	s3,0x1d
    800032e2:	bf298993          	addi	s3,s3,-1038 # 8001fed0 <sb>
    800032e6:	02000613          	li	a2,32
    800032ea:	06050593          	addi	a1,a0,96
    800032ee:	854e                	mv	a0,s3
    800032f0:	ffffe097          	auipc	ra,0xffffe
    800032f4:	8de080e7          	jalr	-1826(ra) # 80000bce <memmove>
  brelse(bp);
    800032f8:	8526                	mv	a0,s1
    800032fa:	00000097          	auipc	ra,0x0
    800032fe:	b6e080e7          	jalr	-1170(ra) # 80002e68 <brelse>
  if(sb.magic != FSMAGIC)
    80003302:	0009a703          	lw	a4,0(s3)
    80003306:	102037b7          	lui	a5,0x10203
    8000330a:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000330e:	02f71263          	bne	a4,a5,80003332 <fsinit+0x70>
  initlog(dev, &sb);
    80003312:	0001d597          	auipc	a1,0x1d
    80003316:	bbe58593          	addi	a1,a1,-1090 # 8001fed0 <sb>
    8000331a:	854a                	mv	a0,s2
    8000331c:	00001097          	auipc	ra,0x1
    80003320:	b12080e7          	jalr	-1262(ra) # 80003e2e <initlog>
}
    80003324:	70a2                	ld	ra,40(sp)
    80003326:	7402                	ld	s0,32(sp)
    80003328:	64e2                	ld	s1,24(sp)
    8000332a:	6942                	ld	s2,16(sp)
    8000332c:	69a2                	ld	s3,8(sp)
    8000332e:	6145                	addi	sp,sp,48
    80003330:	8082                	ret
    panic("invalid file system");
    80003332:	00004517          	auipc	a0,0x4
    80003336:	59e50513          	addi	a0,a0,1438 # 800078d0 <userret+0x840>
    8000333a:	ffffd097          	auipc	ra,0xffffd
    8000333e:	214080e7          	jalr	532(ra) # 8000054e <panic>

0000000080003342 <iinit>:
{
    80003342:	7179                	addi	sp,sp,-48
    80003344:	f406                	sd	ra,40(sp)
    80003346:	f022                	sd	s0,32(sp)
    80003348:	ec26                	sd	s1,24(sp)
    8000334a:	e84a                	sd	s2,16(sp)
    8000334c:	e44e                	sd	s3,8(sp)
    8000334e:	1800                	addi	s0,sp,48
  initlock(&icache.lock, "icache");
    80003350:	00004597          	auipc	a1,0x4
    80003354:	59858593          	addi	a1,a1,1432 # 800078e8 <userret+0x858>
    80003358:	0001d517          	auipc	a0,0x1d
    8000335c:	b9850513          	addi	a0,a0,-1128 # 8001fef0 <icache>
    80003360:	ffffd097          	auipc	ra,0xffffd
    80003364:	660080e7          	jalr	1632(ra) # 800009c0 <initlock>
  for(i = 0; i < NINODE; i++) {
    80003368:	0001d497          	auipc	s1,0x1d
    8000336c:	bb048493          	addi	s1,s1,-1104 # 8001ff18 <icache+0x28>
    80003370:	0001e997          	auipc	s3,0x1e
    80003374:	63898993          	addi	s3,s3,1592 # 800219a8 <log+0x10>
    initsleeplock(&icache.inode[i].lock, "inode");
    80003378:	00004917          	auipc	s2,0x4
    8000337c:	57890913          	addi	s2,s2,1400 # 800078f0 <userret+0x860>
    80003380:	85ca                	mv	a1,s2
    80003382:	8526                	mv	a0,s1
    80003384:	00001097          	auipc	ra,0x1
    80003388:	e10080e7          	jalr	-496(ra) # 80004194 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000338c:	08848493          	addi	s1,s1,136
    80003390:	ff3498e3          	bne	s1,s3,80003380 <iinit+0x3e>
}
    80003394:	70a2                	ld	ra,40(sp)
    80003396:	7402                	ld	s0,32(sp)
    80003398:	64e2                	ld	s1,24(sp)
    8000339a:	6942                	ld	s2,16(sp)
    8000339c:	69a2                	ld	s3,8(sp)
    8000339e:	6145                	addi	sp,sp,48
    800033a0:	8082                	ret

00000000800033a2 <ialloc>:
{
    800033a2:	715d                	addi	sp,sp,-80
    800033a4:	e486                	sd	ra,72(sp)
    800033a6:	e0a2                	sd	s0,64(sp)
    800033a8:	fc26                	sd	s1,56(sp)
    800033aa:	f84a                	sd	s2,48(sp)
    800033ac:	f44e                	sd	s3,40(sp)
    800033ae:	f052                	sd	s4,32(sp)
    800033b0:	ec56                	sd	s5,24(sp)
    800033b2:	e85a                	sd	s6,16(sp)
    800033b4:	e45e                	sd	s7,8(sp)
    800033b6:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    800033b8:	0001d717          	auipc	a4,0x1d
    800033bc:	b2472703          	lw	a4,-1244(a4) # 8001fedc <sb+0xc>
    800033c0:	4785                	li	a5,1
    800033c2:	04e7fa63          	bgeu	a5,a4,80003416 <ialloc+0x74>
    800033c6:	8aaa                	mv	s5,a0
    800033c8:	8bae                	mv	s7,a1
    800033ca:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800033cc:	0001da17          	auipc	s4,0x1d
    800033d0:	b04a0a13          	addi	s4,s4,-1276 # 8001fed0 <sb>
    800033d4:	00048b1b          	sext.w	s6,s1
    800033d8:	0044d593          	srli	a1,s1,0x4
    800033dc:	018a2783          	lw	a5,24(s4)
    800033e0:	9dbd                	addw	a1,a1,a5
    800033e2:	8556                	mv	a0,s5
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	954080e7          	jalr	-1708(ra) # 80002d38 <bread>
    800033ec:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800033ee:	06050993          	addi	s3,a0,96
    800033f2:	00f4f793          	andi	a5,s1,15
    800033f6:	079a                	slli	a5,a5,0x6
    800033f8:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800033fa:	00099783          	lh	a5,0(s3)
    800033fe:	c785                	beqz	a5,80003426 <ialloc+0x84>
    brelse(bp);
    80003400:	00000097          	auipc	ra,0x0
    80003404:	a68080e7          	jalr	-1432(ra) # 80002e68 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003408:	0485                	addi	s1,s1,1
    8000340a:	00ca2703          	lw	a4,12(s4)
    8000340e:	0004879b          	sext.w	a5,s1
    80003412:	fce7e1e3          	bltu	a5,a4,800033d4 <ialloc+0x32>
  panic("ialloc: no inodes");
    80003416:	00004517          	auipc	a0,0x4
    8000341a:	4e250513          	addi	a0,a0,1250 # 800078f8 <userret+0x868>
    8000341e:	ffffd097          	auipc	ra,0xffffd
    80003422:	130080e7          	jalr	304(ra) # 8000054e <panic>
      memset(dip, 0, sizeof(*dip));
    80003426:	04000613          	li	a2,64
    8000342a:	4581                	li	a1,0
    8000342c:	854e                	mv	a0,s3
    8000342e:	ffffd097          	auipc	ra,0xffffd
    80003432:	740080e7          	jalr	1856(ra) # 80000b6e <memset>
      dip->type = type;
    80003436:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000343a:	854a                	mv	a0,s2
    8000343c:	00001097          	auipc	ra,0x1
    80003440:	c6a080e7          	jalr	-918(ra) # 800040a6 <log_write>
      brelse(bp);
    80003444:	854a                	mv	a0,s2
    80003446:	00000097          	auipc	ra,0x0
    8000344a:	a22080e7          	jalr	-1502(ra) # 80002e68 <brelse>
      return iget(dev, inum);
    8000344e:	85da                	mv	a1,s6
    80003450:	8556                	mv	a0,s5
    80003452:	00000097          	auipc	ra,0x0
    80003456:	db4080e7          	jalr	-588(ra) # 80003206 <iget>
}
    8000345a:	60a6                	ld	ra,72(sp)
    8000345c:	6406                	ld	s0,64(sp)
    8000345e:	74e2                	ld	s1,56(sp)
    80003460:	7942                	ld	s2,48(sp)
    80003462:	79a2                	ld	s3,40(sp)
    80003464:	7a02                	ld	s4,32(sp)
    80003466:	6ae2                	ld	s5,24(sp)
    80003468:	6b42                	ld	s6,16(sp)
    8000346a:	6ba2                	ld	s7,8(sp)
    8000346c:	6161                	addi	sp,sp,80
    8000346e:	8082                	ret

0000000080003470 <iupdate>:
{
    80003470:	1101                	addi	sp,sp,-32
    80003472:	ec06                	sd	ra,24(sp)
    80003474:	e822                	sd	s0,16(sp)
    80003476:	e426                	sd	s1,8(sp)
    80003478:	e04a                	sd	s2,0(sp)
    8000347a:	1000                	addi	s0,sp,32
    8000347c:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000347e:	415c                	lw	a5,4(a0)
    80003480:	0047d79b          	srliw	a5,a5,0x4
    80003484:	0001d597          	auipc	a1,0x1d
    80003488:	a645a583          	lw	a1,-1436(a1) # 8001fee8 <sb+0x18>
    8000348c:	9dbd                	addw	a1,a1,a5
    8000348e:	4108                	lw	a0,0(a0)
    80003490:	00000097          	auipc	ra,0x0
    80003494:	8a8080e7          	jalr	-1880(ra) # 80002d38 <bread>
    80003498:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000349a:	06050793          	addi	a5,a0,96
    8000349e:	40c8                	lw	a0,4(s1)
    800034a0:	893d                	andi	a0,a0,15
    800034a2:	051a                	slli	a0,a0,0x6
    800034a4:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    800034a6:	04449703          	lh	a4,68(s1)
    800034aa:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    800034ae:	04649703          	lh	a4,70(s1)
    800034b2:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    800034b6:	04849703          	lh	a4,72(s1)
    800034ba:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    800034be:	04a49703          	lh	a4,74(s1)
    800034c2:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    800034c6:	44f8                	lw	a4,76(s1)
    800034c8:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800034ca:	03400613          	li	a2,52
    800034ce:	05048593          	addi	a1,s1,80
    800034d2:	0531                	addi	a0,a0,12
    800034d4:	ffffd097          	auipc	ra,0xffffd
    800034d8:	6fa080e7          	jalr	1786(ra) # 80000bce <memmove>
  log_write(bp);
    800034dc:	854a                	mv	a0,s2
    800034de:	00001097          	auipc	ra,0x1
    800034e2:	bc8080e7          	jalr	-1080(ra) # 800040a6 <log_write>
  brelse(bp);
    800034e6:	854a                	mv	a0,s2
    800034e8:	00000097          	auipc	ra,0x0
    800034ec:	980080e7          	jalr	-1664(ra) # 80002e68 <brelse>
}
    800034f0:	60e2                	ld	ra,24(sp)
    800034f2:	6442                	ld	s0,16(sp)
    800034f4:	64a2                	ld	s1,8(sp)
    800034f6:	6902                	ld	s2,0(sp)
    800034f8:	6105                	addi	sp,sp,32
    800034fa:	8082                	ret

00000000800034fc <idup>:
{
    800034fc:	1101                	addi	sp,sp,-32
    800034fe:	ec06                	sd	ra,24(sp)
    80003500:	e822                	sd	s0,16(sp)
    80003502:	e426                	sd	s1,8(sp)
    80003504:	1000                	addi	s0,sp,32
    80003506:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    80003508:	0001d517          	auipc	a0,0x1d
    8000350c:	9e850513          	addi	a0,a0,-1560 # 8001fef0 <icache>
    80003510:	ffffd097          	auipc	ra,0xffffd
    80003514:	5c2080e7          	jalr	1474(ra) # 80000ad2 <acquire>
  ip->ref++;
    80003518:	449c                	lw	a5,8(s1)
    8000351a:	2785                	addiw	a5,a5,1
    8000351c:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    8000351e:	0001d517          	auipc	a0,0x1d
    80003522:	9d250513          	addi	a0,a0,-1582 # 8001fef0 <icache>
    80003526:	ffffd097          	auipc	ra,0xffffd
    8000352a:	600080e7          	jalr	1536(ra) # 80000b26 <release>
}
    8000352e:	8526                	mv	a0,s1
    80003530:	60e2                	ld	ra,24(sp)
    80003532:	6442                	ld	s0,16(sp)
    80003534:	64a2                	ld	s1,8(sp)
    80003536:	6105                	addi	sp,sp,32
    80003538:	8082                	ret

000000008000353a <ilock>:
{
    8000353a:	1101                	addi	sp,sp,-32
    8000353c:	ec06                	sd	ra,24(sp)
    8000353e:	e822                	sd	s0,16(sp)
    80003540:	e426                	sd	s1,8(sp)
    80003542:	e04a                	sd	s2,0(sp)
    80003544:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003546:	c115                	beqz	a0,8000356a <ilock+0x30>
    80003548:	84aa                	mv	s1,a0
    8000354a:	451c                	lw	a5,8(a0)
    8000354c:	00f05f63          	blez	a5,8000356a <ilock+0x30>
  acquiresleep(&ip->lock);
    80003550:	0541                	addi	a0,a0,16
    80003552:	00001097          	auipc	ra,0x1
    80003556:	c7c080e7          	jalr	-900(ra) # 800041ce <acquiresleep>
  if(ip->valid == 0){
    8000355a:	40bc                	lw	a5,64(s1)
    8000355c:	cf99                	beqz	a5,8000357a <ilock+0x40>
}
    8000355e:	60e2                	ld	ra,24(sp)
    80003560:	6442                	ld	s0,16(sp)
    80003562:	64a2                	ld	s1,8(sp)
    80003564:	6902                	ld	s2,0(sp)
    80003566:	6105                	addi	sp,sp,32
    80003568:	8082                	ret
    panic("ilock");
    8000356a:	00004517          	auipc	a0,0x4
    8000356e:	3a650513          	addi	a0,a0,934 # 80007910 <userret+0x880>
    80003572:	ffffd097          	auipc	ra,0xffffd
    80003576:	fdc080e7          	jalr	-36(ra) # 8000054e <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000357a:	40dc                	lw	a5,4(s1)
    8000357c:	0047d79b          	srliw	a5,a5,0x4
    80003580:	0001d597          	auipc	a1,0x1d
    80003584:	9685a583          	lw	a1,-1688(a1) # 8001fee8 <sb+0x18>
    80003588:	9dbd                	addw	a1,a1,a5
    8000358a:	4088                	lw	a0,0(s1)
    8000358c:	fffff097          	auipc	ra,0xfffff
    80003590:	7ac080e7          	jalr	1964(ra) # 80002d38 <bread>
    80003594:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003596:	06050593          	addi	a1,a0,96
    8000359a:	40dc                	lw	a5,4(s1)
    8000359c:	8bbd                	andi	a5,a5,15
    8000359e:	079a                	slli	a5,a5,0x6
    800035a0:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800035a2:	00059783          	lh	a5,0(a1)
    800035a6:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800035aa:	00259783          	lh	a5,2(a1)
    800035ae:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    800035b2:	00459783          	lh	a5,4(a1)
    800035b6:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800035ba:	00659783          	lh	a5,6(a1)
    800035be:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800035c2:	459c                	lw	a5,8(a1)
    800035c4:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800035c6:	03400613          	li	a2,52
    800035ca:	05b1                	addi	a1,a1,12
    800035cc:	05048513          	addi	a0,s1,80
    800035d0:	ffffd097          	auipc	ra,0xffffd
    800035d4:	5fe080e7          	jalr	1534(ra) # 80000bce <memmove>
    brelse(bp);
    800035d8:	854a                	mv	a0,s2
    800035da:	00000097          	auipc	ra,0x0
    800035de:	88e080e7          	jalr	-1906(ra) # 80002e68 <brelse>
    ip->valid = 1;
    800035e2:	4785                	li	a5,1
    800035e4:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800035e6:	04449783          	lh	a5,68(s1)
    800035ea:	fbb5                	bnez	a5,8000355e <ilock+0x24>
      panic("ilock: no type");
    800035ec:	00004517          	auipc	a0,0x4
    800035f0:	32c50513          	addi	a0,a0,812 # 80007918 <userret+0x888>
    800035f4:	ffffd097          	auipc	ra,0xffffd
    800035f8:	f5a080e7          	jalr	-166(ra) # 8000054e <panic>

00000000800035fc <iunlock>:
{
    800035fc:	1101                	addi	sp,sp,-32
    800035fe:	ec06                	sd	ra,24(sp)
    80003600:	e822                	sd	s0,16(sp)
    80003602:	e426                	sd	s1,8(sp)
    80003604:	e04a                	sd	s2,0(sp)
    80003606:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003608:	c905                	beqz	a0,80003638 <iunlock+0x3c>
    8000360a:	84aa                	mv	s1,a0
    8000360c:	01050913          	addi	s2,a0,16
    80003610:	854a                	mv	a0,s2
    80003612:	00001097          	auipc	ra,0x1
    80003616:	c56080e7          	jalr	-938(ra) # 80004268 <holdingsleep>
    8000361a:	cd19                	beqz	a0,80003638 <iunlock+0x3c>
    8000361c:	449c                	lw	a5,8(s1)
    8000361e:	00f05d63          	blez	a5,80003638 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003622:	854a                	mv	a0,s2
    80003624:	00001097          	auipc	ra,0x1
    80003628:	c00080e7          	jalr	-1024(ra) # 80004224 <releasesleep>
}
    8000362c:	60e2                	ld	ra,24(sp)
    8000362e:	6442                	ld	s0,16(sp)
    80003630:	64a2                	ld	s1,8(sp)
    80003632:	6902                	ld	s2,0(sp)
    80003634:	6105                	addi	sp,sp,32
    80003636:	8082                	ret
    panic("iunlock");
    80003638:	00004517          	auipc	a0,0x4
    8000363c:	2f050513          	addi	a0,a0,752 # 80007928 <userret+0x898>
    80003640:	ffffd097          	auipc	ra,0xffffd
    80003644:	f0e080e7          	jalr	-242(ra) # 8000054e <panic>

0000000080003648 <iput>:
{
    80003648:	7139                	addi	sp,sp,-64
    8000364a:	fc06                	sd	ra,56(sp)
    8000364c:	f822                	sd	s0,48(sp)
    8000364e:	f426                	sd	s1,40(sp)
    80003650:	f04a                	sd	s2,32(sp)
    80003652:	ec4e                	sd	s3,24(sp)
    80003654:	e852                	sd	s4,16(sp)
    80003656:	e456                	sd	s5,8(sp)
    80003658:	0080                	addi	s0,sp,64
    8000365a:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    8000365c:	0001d517          	auipc	a0,0x1d
    80003660:	89450513          	addi	a0,a0,-1900 # 8001fef0 <icache>
    80003664:	ffffd097          	auipc	ra,0xffffd
    80003668:	46e080e7          	jalr	1134(ra) # 80000ad2 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000366c:	4498                	lw	a4,8(s1)
    8000366e:	4785                	li	a5,1
    80003670:	02f70663          	beq	a4,a5,8000369c <iput+0x54>
  ip->ref--;
    80003674:	449c                	lw	a5,8(s1)
    80003676:	37fd                	addiw	a5,a5,-1
    80003678:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    8000367a:	0001d517          	auipc	a0,0x1d
    8000367e:	87650513          	addi	a0,a0,-1930 # 8001fef0 <icache>
    80003682:	ffffd097          	auipc	ra,0xffffd
    80003686:	4a4080e7          	jalr	1188(ra) # 80000b26 <release>
}
    8000368a:	70e2                	ld	ra,56(sp)
    8000368c:	7442                	ld	s0,48(sp)
    8000368e:	74a2                	ld	s1,40(sp)
    80003690:	7902                	ld	s2,32(sp)
    80003692:	69e2                	ld	s3,24(sp)
    80003694:	6a42                	ld	s4,16(sp)
    80003696:	6aa2                	ld	s5,8(sp)
    80003698:	6121                	addi	sp,sp,64
    8000369a:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000369c:	40bc                	lw	a5,64(s1)
    8000369e:	dbf9                	beqz	a5,80003674 <iput+0x2c>
    800036a0:	04a49783          	lh	a5,74(s1)
    800036a4:	fbe1                	bnez	a5,80003674 <iput+0x2c>
    acquiresleep(&ip->lock);
    800036a6:	01048a13          	addi	s4,s1,16
    800036aa:	8552                	mv	a0,s4
    800036ac:	00001097          	auipc	ra,0x1
    800036b0:	b22080e7          	jalr	-1246(ra) # 800041ce <acquiresleep>
    release(&icache.lock);
    800036b4:	0001d517          	auipc	a0,0x1d
    800036b8:	83c50513          	addi	a0,a0,-1988 # 8001fef0 <icache>
    800036bc:	ffffd097          	auipc	ra,0xffffd
    800036c0:	46a080e7          	jalr	1130(ra) # 80000b26 <release>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800036c4:	05048913          	addi	s2,s1,80
    800036c8:	08048993          	addi	s3,s1,128
    800036cc:	a819                	j	800036e2 <iput+0x9a>
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
    800036ce:	4088                	lw	a0,0(s1)
    800036d0:	00000097          	auipc	ra,0x0
    800036d4:	8ae080e7          	jalr	-1874(ra) # 80002f7e <bfree>
      ip->addrs[i] = 0;
    800036d8:	00092023          	sw	zero,0(s2)
  for(i = 0; i < NDIRECT; i++){
    800036dc:	0911                	addi	s2,s2,4
    800036de:	01390663          	beq	s2,s3,800036ea <iput+0xa2>
    if(ip->addrs[i]){
    800036e2:	00092583          	lw	a1,0(s2)
    800036e6:	d9fd                	beqz	a1,800036dc <iput+0x94>
    800036e8:	b7dd                	j	800036ce <iput+0x86>
    }
  }

  if(ip->addrs[NDIRECT]){
    800036ea:	0804a583          	lw	a1,128(s1)
    800036ee:	ed9d                	bnez	a1,8000372c <iput+0xe4>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800036f0:	0404a623          	sw	zero,76(s1)
  iupdate(ip);
    800036f4:	8526                	mv	a0,s1
    800036f6:	00000097          	auipc	ra,0x0
    800036fa:	d7a080e7          	jalr	-646(ra) # 80003470 <iupdate>
    ip->type = 0;
    800036fe:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003702:	8526                	mv	a0,s1
    80003704:	00000097          	auipc	ra,0x0
    80003708:	d6c080e7          	jalr	-660(ra) # 80003470 <iupdate>
    ip->valid = 0;
    8000370c:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003710:	8552                	mv	a0,s4
    80003712:	00001097          	auipc	ra,0x1
    80003716:	b12080e7          	jalr	-1262(ra) # 80004224 <releasesleep>
    acquire(&icache.lock);
    8000371a:	0001c517          	auipc	a0,0x1c
    8000371e:	7d650513          	addi	a0,a0,2006 # 8001fef0 <icache>
    80003722:	ffffd097          	auipc	ra,0xffffd
    80003726:	3b0080e7          	jalr	944(ra) # 80000ad2 <acquire>
    8000372a:	b7a9                	j	80003674 <iput+0x2c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000372c:	4088                	lw	a0,0(s1)
    8000372e:	fffff097          	auipc	ra,0xfffff
    80003732:	60a080e7          	jalr	1546(ra) # 80002d38 <bread>
    80003736:	8aaa                	mv	s5,a0
    for(j = 0; j < NINDIRECT; j++){
    80003738:	06050913          	addi	s2,a0,96
    8000373c:	46050993          	addi	s3,a0,1120
    80003740:	a809                	j	80003752 <iput+0x10a>
        bfree(ip->dev, a[j]);
    80003742:	4088                	lw	a0,0(s1)
    80003744:	00000097          	auipc	ra,0x0
    80003748:	83a080e7          	jalr	-1990(ra) # 80002f7e <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000374c:	0911                	addi	s2,s2,4
    8000374e:	01390663          	beq	s2,s3,8000375a <iput+0x112>
      if(a[j])
    80003752:	00092583          	lw	a1,0(s2)
    80003756:	d9fd                	beqz	a1,8000374c <iput+0x104>
    80003758:	b7ed                	j	80003742 <iput+0xfa>
    brelse(bp);
    8000375a:	8556                	mv	a0,s5
    8000375c:	fffff097          	auipc	ra,0xfffff
    80003760:	70c080e7          	jalr	1804(ra) # 80002e68 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003764:	0804a583          	lw	a1,128(s1)
    80003768:	4088                	lw	a0,0(s1)
    8000376a:	00000097          	auipc	ra,0x0
    8000376e:	814080e7          	jalr	-2028(ra) # 80002f7e <bfree>
    ip->addrs[NDIRECT] = 0;
    80003772:	0804a023          	sw	zero,128(s1)
    80003776:	bfad                	j	800036f0 <iput+0xa8>

0000000080003778 <iunlockput>:
{
    80003778:	1101                	addi	sp,sp,-32
    8000377a:	ec06                	sd	ra,24(sp)
    8000377c:	e822                	sd	s0,16(sp)
    8000377e:	e426                	sd	s1,8(sp)
    80003780:	1000                	addi	s0,sp,32
    80003782:	84aa                	mv	s1,a0
  iunlock(ip);
    80003784:	00000097          	auipc	ra,0x0
    80003788:	e78080e7          	jalr	-392(ra) # 800035fc <iunlock>
  iput(ip);
    8000378c:	8526                	mv	a0,s1
    8000378e:	00000097          	auipc	ra,0x0
    80003792:	eba080e7          	jalr	-326(ra) # 80003648 <iput>
}
    80003796:	60e2                	ld	ra,24(sp)
    80003798:	6442                	ld	s0,16(sp)
    8000379a:	64a2                	ld	s1,8(sp)
    8000379c:	6105                	addi	sp,sp,32
    8000379e:	8082                	ret

00000000800037a0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800037a0:	1141                	addi	sp,sp,-16
    800037a2:	e422                	sd	s0,8(sp)
    800037a4:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800037a6:	411c                	lw	a5,0(a0)
    800037a8:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800037aa:	415c                	lw	a5,4(a0)
    800037ac:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800037ae:	04451783          	lh	a5,68(a0)
    800037b2:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800037b6:	04a51783          	lh	a5,74(a0)
    800037ba:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800037be:	04c56783          	lwu	a5,76(a0)
    800037c2:	e99c                	sd	a5,16(a1)
}
    800037c4:	6422                	ld	s0,8(sp)
    800037c6:	0141                	addi	sp,sp,16
    800037c8:	8082                	ret

00000000800037ca <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800037ca:	457c                	lw	a5,76(a0)
    800037cc:	0ed7e563          	bltu	a5,a3,800038b6 <readi+0xec>
{
    800037d0:	7159                	addi	sp,sp,-112
    800037d2:	f486                	sd	ra,104(sp)
    800037d4:	f0a2                	sd	s0,96(sp)
    800037d6:	eca6                	sd	s1,88(sp)
    800037d8:	e8ca                	sd	s2,80(sp)
    800037da:	e4ce                	sd	s3,72(sp)
    800037dc:	e0d2                	sd	s4,64(sp)
    800037de:	fc56                	sd	s5,56(sp)
    800037e0:	f85a                	sd	s6,48(sp)
    800037e2:	f45e                	sd	s7,40(sp)
    800037e4:	f062                	sd	s8,32(sp)
    800037e6:	ec66                	sd	s9,24(sp)
    800037e8:	e86a                	sd	s10,16(sp)
    800037ea:	e46e                	sd	s11,8(sp)
    800037ec:	1880                	addi	s0,sp,112
    800037ee:	8baa                	mv	s7,a0
    800037f0:	8c2e                	mv	s8,a1
    800037f2:	8ab2                	mv	s5,a2
    800037f4:	8936                	mv	s2,a3
    800037f6:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800037f8:	9f35                	addw	a4,a4,a3
    800037fa:	0cd76063          	bltu	a4,a3,800038ba <readi+0xf0>
    return -1;
  if(off + n > ip->size)
    800037fe:	00e7f463          	bgeu	a5,a4,80003806 <readi+0x3c>
    n = ip->size - off;
    80003802:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003806:	080b0763          	beqz	s6,80003894 <readi+0xca>
    8000380a:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    8000380c:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003810:	5cfd                	li	s9,-1
    80003812:	a82d                	j	8000384c <readi+0x82>
    80003814:	02099d93          	slli	s11,s3,0x20
    80003818:	020ddd93          	srli	s11,s11,0x20
    8000381c:	06048613          	addi	a2,s1,96
    80003820:	86ee                	mv	a3,s11
    80003822:	963a                	add	a2,a2,a4
    80003824:	85d6                	mv	a1,s5
    80003826:	8562                	mv	a0,s8
    80003828:	fffff097          	auipc	ra,0xfffff
    8000382c:	b5e080e7          	jalr	-1186(ra) # 80002386 <either_copyout>
    80003830:	05950d63          	beq	a0,s9,8000388a <readi+0xc0>
      brelse(bp);
      break;
    }
    brelse(bp);
    80003834:	8526                	mv	a0,s1
    80003836:	fffff097          	auipc	ra,0xfffff
    8000383a:	632080e7          	jalr	1586(ra) # 80002e68 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000383e:	01498a3b          	addw	s4,s3,s4
    80003842:	0129893b          	addw	s2,s3,s2
    80003846:	9aee                	add	s5,s5,s11
    80003848:	056a7663          	bgeu	s4,s6,80003894 <readi+0xca>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000384c:	000ba483          	lw	s1,0(s7)
    80003850:	00a9559b          	srliw	a1,s2,0xa
    80003854:	855e                	mv	a0,s7
    80003856:	00000097          	auipc	ra,0x0
    8000385a:	8d6080e7          	jalr	-1834(ra) # 8000312c <bmap>
    8000385e:	0005059b          	sext.w	a1,a0
    80003862:	8526                	mv	a0,s1
    80003864:	fffff097          	auipc	ra,0xfffff
    80003868:	4d4080e7          	jalr	1236(ra) # 80002d38 <bread>
    8000386c:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000386e:	3ff97713          	andi	a4,s2,1023
    80003872:	40ed07bb          	subw	a5,s10,a4
    80003876:	414b06bb          	subw	a3,s6,s4
    8000387a:	89be                	mv	s3,a5
    8000387c:	2781                	sext.w	a5,a5
    8000387e:	0006861b          	sext.w	a2,a3
    80003882:	f8f679e3          	bgeu	a2,a5,80003814 <readi+0x4a>
    80003886:	89b6                	mv	s3,a3
    80003888:	b771                	j	80003814 <readi+0x4a>
      brelse(bp);
    8000388a:	8526                	mv	a0,s1
    8000388c:	fffff097          	auipc	ra,0xfffff
    80003890:	5dc080e7          	jalr	1500(ra) # 80002e68 <brelse>
  }
  return n;
    80003894:	000b051b          	sext.w	a0,s6
}
    80003898:	70a6                	ld	ra,104(sp)
    8000389a:	7406                	ld	s0,96(sp)
    8000389c:	64e6                	ld	s1,88(sp)
    8000389e:	6946                	ld	s2,80(sp)
    800038a0:	69a6                	ld	s3,72(sp)
    800038a2:	6a06                	ld	s4,64(sp)
    800038a4:	7ae2                	ld	s5,56(sp)
    800038a6:	7b42                	ld	s6,48(sp)
    800038a8:	7ba2                	ld	s7,40(sp)
    800038aa:	7c02                	ld	s8,32(sp)
    800038ac:	6ce2                	ld	s9,24(sp)
    800038ae:	6d42                	ld	s10,16(sp)
    800038b0:	6da2                	ld	s11,8(sp)
    800038b2:	6165                	addi	sp,sp,112
    800038b4:	8082                	ret
    return -1;
    800038b6:	557d                	li	a0,-1
}
    800038b8:	8082                	ret
    return -1;
    800038ba:	557d                	li	a0,-1
    800038bc:	bff1                	j	80003898 <readi+0xce>

00000000800038be <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800038be:	457c                	lw	a5,76(a0)
    800038c0:	10d7e663          	bltu	a5,a3,800039cc <writei+0x10e>
{
    800038c4:	7159                	addi	sp,sp,-112
    800038c6:	f486                	sd	ra,104(sp)
    800038c8:	f0a2                	sd	s0,96(sp)
    800038ca:	eca6                	sd	s1,88(sp)
    800038cc:	e8ca                	sd	s2,80(sp)
    800038ce:	e4ce                	sd	s3,72(sp)
    800038d0:	e0d2                	sd	s4,64(sp)
    800038d2:	fc56                	sd	s5,56(sp)
    800038d4:	f85a                	sd	s6,48(sp)
    800038d6:	f45e                	sd	s7,40(sp)
    800038d8:	f062                	sd	s8,32(sp)
    800038da:	ec66                	sd	s9,24(sp)
    800038dc:	e86a                	sd	s10,16(sp)
    800038de:	e46e                	sd	s11,8(sp)
    800038e0:	1880                	addi	s0,sp,112
    800038e2:	8baa                	mv	s7,a0
    800038e4:	8c2e                	mv	s8,a1
    800038e6:	8ab2                	mv	s5,a2
    800038e8:	8936                	mv	s2,a3
    800038ea:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800038ec:	00e687bb          	addw	a5,a3,a4
    800038f0:	0ed7e063          	bltu	a5,a3,800039d0 <writei+0x112>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800038f4:	00043737          	lui	a4,0x43
    800038f8:	0cf76e63          	bltu	a4,a5,800039d4 <writei+0x116>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800038fc:	0a0b0763          	beqz	s6,800039aa <writei+0xec>
    80003900:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003902:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003906:	5cfd                	li	s9,-1
    80003908:	a091                	j	8000394c <writei+0x8e>
    8000390a:	02099d93          	slli	s11,s3,0x20
    8000390e:	020ddd93          	srli	s11,s11,0x20
    80003912:	06048513          	addi	a0,s1,96
    80003916:	86ee                	mv	a3,s11
    80003918:	8656                	mv	a2,s5
    8000391a:	85e2                	mv	a1,s8
    8000391c:	953a                	add	a0,a0,a4
    8000391e:	fffff097          	auipc	ra,0xfffff
    80003922:	abe080e7          	jalr	-1346(ra) # 800023dc <either_copyin>
    80003926:	07950263          	beq	a0,s9,8000398a <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    8000392a:	8526                	mv	a0,s1
    8000392c:	00000097          	auipc	ra,0x0
    80003930:	77a080e7          	jalr	1914(ra) # 800040a6 <log_write>
    brelse(bp);
    80003934:	8526                	mv	a0,s1
    80003936:	fffff097          	auipc	ra,0xfffff
    8000393a:	532080e7          	jalr	1330(ra) # 80002e68 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000393e:	01498a3b          	addw	s4,s3,s4
    80003942:	0129893b          	addw	s2,s3,s2
    80003946:	9aee                	add	s5,s5,s11
    80003948:	056a7663          	bgeu	s4,s6,80003994 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000394c:	000ba483          	lw	s1,0(s7)
    80003950:	00a9559b          	srliw	a1,s2,0xa
    80003954:	855e                	mv	a0,s7
    80003956:	fffff097          	auipc	ra,0xfffff
    8000395a:	7d6080e7          	jalr	2006(ra) # 8000312c <bmap>
    8000395e:	0005059b          	sext.w	a1,a0
    80003962:	8526                	mv	a0,s1
    80003964:	fffff097          	auipc	ra,0xfffff
    80003968:	3d4080e7          	jalr	980(ra) # 80002d38 <bread>
    8000396c:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000396e:	3ff97713          	andi	a4,s2,1023
    80003972:	40ed07bb          	subw	a5,s10,a4
    80003976:	414b06bb          	subw	a3,s6,s4
    8000397a:	89be                	mv	s3,a5
    8000397c:	2781                	sext.w	a5,a5
    8000397e:	0006861b          	sext.w	a2,a3
    80003982:	f8f674e3          	bgeu	a2,a5,8000390a <writei+0x4c>
    80003986:	89b6                	mv	s3,a3
    80003988:	b749                	j	8000390a <writei+0x4c>
      brelse(bp);
    8000398a:	8526                	mv	a0,s1
    8000398c:	fffff097          	auipc	ra,0xfffff
    80003990:	4dc080e7          	jalr	1244(ra) # 80002e68 <brelse>
  }

  if(n > 0){
    if(off > ip->size)
    80003994:	04cba783          	lw	a5,76(s7)
    80003998:	0127f463          	bgeu	a5,s2,800039a0 <writei+0xe2>
      ip->size = off;
    8000399c:	052ba623          	sw	s2,76(s7)
    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    800039a0:	855e                	mv	a0,s7
    800039a2:	00000097          	auipc	ra,0x0
    800039a6:	ace080e7          	jalr	-1330(ra) # 80003470 <iupdate>
  }

  return n;
    800039aa:	000b051b          	sext.w	a0,s6
}
    800039ae:	70a6                	ld	ra,104(sp)
    800039b0:	7406                	ld	s0,96(sp)
    800039b2:	64e6                	ld	s1,88(sp)
    800039b4:	6946                	ld	s2,80(sp)
    800039b6:	69a6                	ld	s3,72(sp)
    800039b8:	6a06                	ld	s4,64(sp)
    800039ba:	7ae2                	ld	s5,56(sp)
    800039bc:	7b42                	ld	s6,48(sp)
    800039be:	7ba2                	ld	s7,40(sp)
    800039c0:	7c02                	ld	s8,32(sp)
    800039c2:	6ce2                	ld	s9,24(sp)
    800039c4:	6d42                	ld	s10,16(sp)
    800039c6:	6da2                	ld	s11,8(sp)
    800039c8:	6165                	addi	sp,sp,112
    800039ca:	8082                	ret
    return -1;
    800039cc:	557d                	li	a0,-1
}
    800039ce:	8082                	ret
    return -1;
    800039d0:	557d                	li	a0,-1
    800039d2:	bff1                	j	800039ae <writei+0xf0>
    return -1;
    800039d4:	557d                	li	a0,-1
    800039d6:	bfe1                	j	800039ae <writei+0xf0>

00000000800039d8 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800039d8:	1141                	addi	sp,sp,-16
    800039da:	e406                	sd	ra,8(sp)
    800039dc:	e022                	sd	s0,0(sp)
    800039de:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800039e0:	4639                	li	a2,14
    800039e2:	ffffd097          	auipc	ra,0xffffd
    800039e6:	268080e7          	jalr	616(ra) # 80000c4a <strncmp>
}
    800039ea:	60a2                	ld	ra,8(sp)
    800039ec:	6402                	ld	s0,0(sp)
    800039ee:	0141                	addi	sp,sp,16
    800039f0:	8082                	ret

00000000800039f2 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800039f2:	7139                	addi	sp,sp,-64
    800039f4:	fc06                	sd	ra,56(sp)
    800039f6:	f822                	sd	s0,48(sp)
    800039f8:	f426                	sd	s1,40(sp)
    800039fa:	f04a                	sd	s2,32(sp)
    800039fc:	ec4e                	sd	s3,24(sp)
    800039fe:	e852                	sd	s4,16(sp)
    80003a00:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003a02:	04451703          	lh	a4,68(a0)
    80003a06:	4785                	li	a5,1
    80003a08:	00f71a63          	bne	a4,a5,80003a1c <dirlookup+0x2a>
    80003a0c:	892a                	mv	s2,a0
    80003a0e:	89ae                	mv	s3,a1
    80003a10:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003a12:	457c                	lw	a5,76(a0)
    80003a14:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003a16:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003a18:	e79d                	bnez	a5,80003a46 <dirlookup+0x54>
    80003a1a:	a8a5                	j	80003a92 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003a1c:	00004517          	auipc	a0,0x4
    80003a20:	f1450513          	addi	a0,a0,-236 # 80007930 <userret+0x8a0>
    80003a24:	ffffd097          	auipc	ra,0xffffd
    80003a28:	b2a080e7          	jalr	-1238(ra) # 8000054e <panic>
      panic("dirlookup read");
    80003a2c:	00004517          	auipc	a0,0x4
    80003a30:	f1c50513          	addi	a0,a0,-228 # 80007948 <userret+0x8b8>
    80003a34:	ffffd097          	auipc	ra,0xffffd
    80003a38:	b1a080e7          	jalr	-1254(ra) # 8000054e <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003a3c:	24c1                	addiw	s1,s1,16
    80003a3e:	04c92783          	lw	a5,76(s2)
    80003a42:	04f4f763          	bgeu	s1,a5,80003a90 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003a46:	4741                	li	a4,16
    80003a48:	86a6                	mv	a3,s1
    80003a4a:	fc040613          	addi	a2,s0,-64
    80003a4e:	4581                	li	a1,0
    80003a50:	854a                	mv	a0,s2
    80003a52:	00000097          	auipc	ra,0x0
    80003a56:	d78080e7          	jalr	-648(ra) # 800037ca <readi>
    80003a5a:	47c1                	li	a5,16
    80003a5c:	fcf518e3          	bne	a0,a5,80003a2c <dirlookup+0x3a>
    if(de.inum == 0)
    80003a60:	fc045783          	lhu	a5,-64(s0)
    80003a64:	dfe1                	beqz	a5,80003a3c <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003a66:	fc240593          	addi	a1,s0,-62
    80003a6a:	854e                	mv	a0,s3
    80003a6c:	00000097          	auipc	ra,0x0
    80003a70:	f6c080e7          	jalr	-148(ra) # 800039d8 <namecmp>
    80003a74:	f561                	bnez	a0,80003a3c <dirlookup+0x4a>
      if(poff)
    80003a76:	000a0463          	beqz	s4,80003a7e <dirlookup+0x8c>
        *poff = off;
    80003a7a:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003a7e:	fc045583          	lhu	a1,-64(s0)
    80003a82:	00092503          	lw	a0,0(s2)
    80003a86:	fffff097          	auipc	ra,0xfffff
    80003a8a:	780080e7          	jalr	1920(ra) # 80003206 <iget>
    80003a8e:	a011                	j	80003a92 <dirlookup+0xa0>
  return 0;
    80003a90:	4501                	li	a0,0
}
    80003a92:	70e2                	ld	ra,56(sp)
    80003a94:	7442                	ld	s0,48(sp)
    80003a96:	74a2                	ld	s1,40(sp)
    80003a98:	7902                	ld	s2,32(sp)
    80003a9a:	69e2                	ld	s3,24(sp)
    80003a9c:	6a42                	ld	s4,16(sp)
    80003a9e:	6121                	addi	sp,sp,64
    80003aa0:	8082                	ret

0000000080003aa2 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003aa2:	711d                	addi	sp,sp,-96
    80003aa4:	ec86                	sd	ra,88(sp)
    80003aa6:	e8a2                	sd	s0,80(sp)
    80003aa8:	e4a6                	sd	s1,72(sp)
    80003aaa:	e0ca                	sd	s2,64(sp)
    80003aac:	fc4e                	sd	s3,56(sp)
    80003aae:	f852                	sd	s4,48(sp)
    80003ab0:	f456                	sd	s5,40(sp)
    80003ab2:	f05a                	sd	s6,32(sp)
    80003ab4:	ec5e                	sd	s7,24(sp)
    80003ab6:	e862                	sd	s8,16(sp)
    80003ab8:	e466                	sd	s9,8(sp)
    80003aba:	1080                	addi	s0,sp,96
    80003abc:	84aa                	mv	s1,a0
    80003abe:	8b2e                	mv	s6,a1
    80003ac0:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003ac2:	00054703          	lbu	a4,0(a0)
    80003ac6:	02f00793          	li	a5,47
    80003aca:	02f70363          	beq	a4,a5,80003af0 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003ace:	ffffe097          	auipc	ra,0xffffe
    80003ad2:	eb6080e7          	jalr	-330(ra) # 80001984 <myproc>
    80003ad6:	15053503          	ld	a0,336(a0)
    80003ada:	00000097          	auipc	ra,0x0
    80003ade:	a22080e7          	jalr	-1502(ra) # 800034fc <idup>
    80003ae2:	89aa                	mv	s3,a0
  while(*path == '/')
    80003ae4:	02f00913          	li	s2,47
  len = path - s;
    80003ae8:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003aea:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003aec:	4c05                	li	s8,1
    80003aee:	a865                	j	80003ba6 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003af0:	4585                	li	a1,1
    80003af2:	4505                	li	a0,1
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	712080e7          	jalr	1810(ra) # 80003206 <iget>
    80003afc:	89aa                	mv	s3,a0
    80003afe:	b7dd                	j	80003ae4 <namex+0x42>
      iunlockput(ip);
    80003b00:	854e                	mv	a0,s3
    80003b02:	00000097          	auipc	ra,0x0
    80003b06:	c76080e7          	jalr	-906(ra) # 80003778 <iunlockput>
      return 0;
    80003b0a:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003b0c:	854e                	mv	a0,s3
    80003b0e:	60e6                	ld	ra,88(sp)
    80003b10:	6446                	ld	s0,80(sp)
    80003b12:	64a6                	ld	s1,72(sp)
    80003b14:	6906                	ld	s2,64(sp)
    80003b16:	79e2                	ld	s3,56(sp)
    80003b18:	7a42                	ld	s4,48(sp)
    80003b1a:	7aa2                	ld	s5,40(sp)
    80003b1c:	7b02                	ld	s6,32(sp)
    80003b1e:	6be2                	ld	s7,24(sp)
    80003b20:	6c42                	ld	s8,16(sp)
    80003b22:	6ca2                	ld	s9,8(sp)
    80003b24:	6125                	addi	sp,sp,96
    80003b26:	8082                	ret
      iunlock(ip);
    80003b28:	854e                	mv	a0,s3
    80003b2a:	00000097          	auipc	ra,0x0
    80003b2e:	ad2080e7          	jalr	-1326(ra) # 800035fc <iunlock>
      return ip;
    80003b32:	bfe9                	j	80003b0c <namex+0x6a>
      iunlockput(ip);
    80003b34:	854e                	mv	a0,s3
    80003b36:	00000097          	auipc	ra,0x0
    80003b3a:	c42080e7          	jalr	-958(ra) # 80003778 <iunlockput>
      return 0;
    80003b3e:	89d2                	mv	s3,s4
    80003b40:	b7f1                	j	80003b0c <namex+0x6a>
  len = path - s;
    80003b42:	40b48633          	sub	a2,s1,a1
    80003b46:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003b4a:	094cd463          	bge	s9,s4,80003bd2 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003b4e:	4639                	li	a2,14
    80003b50:	8556                	mv	a0,s5
    80003b52:	ffffd097          	auipc	ra,0xffffd
    80003b56:	07c080e7          	jalr	124(ra) # 80000bce <memmove>
  while(*path == '/')
    80003b5a:	0004c783          	lbu	a5,0(s1)
    80003b5e:	01279763          	bne	a5,s2,80003b6c <namex+0xca>
    path++;
    80003b62:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003b64:	0004c783          	lbu	a5,0(s1)
    80003b68:	ff278de3          	beq	a5,s2,80003b62 <namex+0xc0>
    ilock(ip);
    80003b6c:	854e                	mv	a0,s3
    80003b6e:	00000097          	auipc	ra,0x0
    80003b72:	9cc080e7          	jalr	-1588(ra) # 8000353a <ilock>
    if(ip->type != T_DIR){
    80003b76:	04499783          	lh	a5,68(s3)
    80003b7a:	f98793e3          	bne	a5,s8,80003b00 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003b7e:	000b0563          	beqz	s6,80003b88 <namex+0xe6>
    80003b82:	0004c783          	lbu	a5,0(s1)
    80003b86:	d3cd                	beqz	a5,80003b28 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003b88:	865e                	mv	a2,s7
    80003b8a:	85d6                	mv	a1,s5
    80003b8c:	854e                	mv	a0,s3
    80003b8e:	00000097          	auipc	ra,0x0
    80003b92:	e64080e7          	jalr	-412(ra) # 800039f2 <dirlookup>
    80003b96:	8a2a                	mv	s4,a0
    80003b98:	dd51                	beqz	a0,80003b34 <namex+0x92>
    iunlockput(ip);
    80003b9a:	854e                	mv	a0,s3
    80003b9c:	00000097          	auipc	ra,0x0
    80003ba0:	bdc080e7          	jalr	-1060(ra) # 80003778 <iunlockput>
    ip = next;
    80003ba4:	89d2                	mv	s3,s4
  while(*path == '/')
    80003ba6:	0004c783          	lbu	a5,0(s1)
    80003baa:	05279763          	bne	a5,s2,80003bf8 <namex+0x156>
    path++;
    80003bae:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003bb0:	0004c783          	lbu	a5,0(s1)
    80003bb4:	ff278de3          	beq	a5,s2,80003bae <namex+0x10c>
  if(*path == 0)
    80003bb8:	c79d                	beqz	a5,80003be6 <namex+0x144>
    path++;
    80003bba:	85a6                	mv	a1,s1
  len = path - s;
    80003bbc:	8a5e                	mv	s4,s7
    80003bbe:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003bc0:	01278963          	beq	a5,s2,80003bd2 <namex+0x130>
    80003bc4:	dfbd                	beqz	a5,80003b42 <namex+0xa0>
    path++;
    80003bc6:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003bc8:	0004c783          	lbu	a5,0(s1)
    80003bcc:	ff279ce3          	bne	a5,s2,80003bc4 <namex+0x122>
    80003bd0:	bf8d                	j	80003b42 <namex+0xa0>
    memmove(name, s, len);
    80003bd2:	2601                	sext.w	a2,a2
    80003bd4:	8556                	mv	a0,s5
    80003bd6:	ffffd097          	auipc	ra,0xffffd
    80003bda:	ff8080e7          	jalr	-8(ra) # 80000bce <memmove>
    name[len] = 0;
    80003bde:	9a56                	add	s4,s4,s5
    80003be0:	000a0023          	sb	zero,0(s4)
    80003be4:	bf9d                	j	80003b5a <namex+0xb8>
  if(nameiparent){
    80003be6:	f20b03e3          	beqz	s6,80003b0c <namex+0x6a>
    iput(ip);
    80003bea:	854e                	mv	a0,s3
    80003bec:	00000097          	auipc	ra,0x0
    80003bf0:	a5c080e7          	jalr	-1444(ra) # 80003648 <iput>
    return 0;
    80003bf4:	4981                	li	s3,0
    80003bf6:	bf19                	j	80003b0c <namex+0x6a>
  if(*path == 0)
    80003bf8:	d7fd                	beqz	a5,80003be6 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003bfa:	0004c783          	lbu	a5,0(s1)
    80003bfe:	85a6                	mv	a1,s1
    80003c00:	b7d1                	j	80003bc4 <namex+0x122>

0000000080003c02 <dirlink>:
{
    80003c02:	7139                	addi	sp,sp,-64
    80003c04:	fc06                	sd	ra,56(sp)
    80003c06:	f822                	sd	s0,48(sp)
    80003c08:	f426                	sd	s1,40(sp)
    80003c0a:	f04a                	sd	s2,32(sp)
    80003c0c:	ec4e                	sd	s3,24(sp)
    80003c0e:	e852                	sd	s4,16(sp)
    80003c10:	0080                	addi	s0,sp,64
    80003c12:	892a                	mv	s2,a0
    80003c14:	8a2e                	mv	s4,a1
    80003c16:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003c18:	4601                	li	a2,0
    80003c1a:	00000097          	auipc	ra,0x0
    80003c1e:	dd8080e7          	jalr	-552(ra) # 800039f2 <dirlookup>
    80003c22:	e93d                	bnez	a0,80003c98 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003c24:	04c92483          	lw	s1,76(s2)
    80003c28:	c49d                	beqz	s1,80003c56 <dirlink+0x54>
    80003c2a:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003c2c:	4741                	li	a4,16
    80003c2e:	86a6                	mv	a3,s1
    80003c30:	fc040613          	addi	a2,s0,-64
    80003c34:	4581                	li	a1,0
    80003c36:	854a                	mv	a0,s2
    80003c38:	00000097          	auipc	ra,0x0
    80003c3c:	b92080e7          	jalr	-1134(ra) # 800037ca <readi>
    80003c40:	47c1                	li	a5,16
    80003c42:	06f51163          	bne	a0,a5,80003ca4 <dirlink+0xa2>
    if(de.inum == 0)
    80003c46:	fc045783          	lhu	a5,-64(s0)
    80003c4a:	c791                	beqz	a5,80003c56 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003c4c:	24c1                	addiw	s1,s1,16
    80003c4e:	04c92783          	lw	a5,76(s2)
    80003c52:	fcf4ede3          	bltu	s1,a5,80003c2c <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003c56:	4639                	li	a2,14
    80003c58:	85d2                	mv	a1,s4
    80003c5a:	fc240513          	addi	a0,s0,-62
    80003c5e:	ffffd097          	auipc	ra,0xffffd
    80003c62:	028080e7          	jalr	40(ra) # 80000c86 <strncpy>
  de.inum = inum;
    80003c66:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003c6a:	4741                	li	a4,16
    80003c6c:	86a6                	mv	a3,s1
    80003c6e:	fc040613          	addi	a2,s0,-64
    80003c72:	4581                	li	a1,0
    80003c74:	854a                	mv	a0,s2
    80003c76:	00000097          	auipc	ra,0x0
    80003c7a:	c48080e7          	jalr	-952(ra) # 800038be <writei>
    80003c7e:	872a                	mv	a4,a0
    80003c80:	47c1                	li	a5,16
  return 0;
    80003c82:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003c84:	02f71863          	bne	a4,a5,80003cb4 <dirlink+0xb2>
}
    80003c88:	70e2                	ld	ra,56(sp)
    80003c8a:	7442                	ld	s0,48(sp)
    80003c8c:	74a2                	ld	s1,40(sp)
    80003c8e:	7902                	ld	s2,32(sp)
    80003c90:	69e2                	ld	s3,24(sp)
    80003c92:	6a42                	ld	s4,16(sp)
    80003c94:	6121                	addi	sp,sp,64
    80003c96:	8082                	ret
    iput(ip);
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	9b0080e7          	jalr	-1616(ra) # 80003648 <iput>
    return -1;
    80003ca0:	557d                	li	a0,-1
    80003ca2:	b7dd                	j	80003c88 <dirlink+0x86>
      panic("dirlink read");
    80003ca4:	00004517          	auipc	a0,0x4
    80003ca8:	cb450513          	addi	a0,a0,-844 # 80007958 <userret+0x8c8>
    80003cac:	ffffd097          	auipc	ra,0xffffd
    80003cb0:	8a2080e7          	jalr	-1886(ra) # 8000054e <panic>
    panic("dirlink");
    80003cb4:	00004517          	auipc	a0,0x4
    80003cb8:	dc450513          	addi	a0,a0,-572 # 80007a78 <userret+0x9e8>
    80003cbc:	ffffd097          	auipc	ra,0xffffd
    80003cc0:	892080e7          	jalr	-1902(ra) # 8000054e <panic>

0000000080003cc4 <namei>:

struct inode*
namei(char *path)
{
    80003cc4:	1101                	addi	sp,sp,-32
    80003cc6:	ec06                	sd	ra,24(sp)
    80003cc8:	e822                	sd	s0,16(sp)
    80003cca:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003ccc:	fe040613          	addi	a2,s0,-32
    80003cd0:	4581                	li	a1,0
    80003cd2:	00000097          	auipc	ra,0x0
    80003cd6:	dd0080e7          	jalr	-560(ra) # 80003aa2 <namex>
}
    80003cda:	60e2                	ld	ra,24(sp)
    80003cdc:	6442                	ld	s0,16(sp)
    80003cde:	6105                	addi	sp,sp,32
    80003ce0:	8082                	ret

0000000080003ce2 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003ce2:	1141                	addi	sp,sp,-16
    80003ce4:	e406                	sd	ra,8(sp)
    80003ce6:	e022                	sd	s0,0(sp)
    80003ce8:	0800                	addi	s0,sp,16
    80003cea:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003cec:	4585                	li	a1,1
    80003cee:	00000097          	auipc	ra,0x0
    80003cf2:	db4080e7          	jalr	-588(ra) # 80003aa2 <namex>
}
    80003cf6:	60a2                	ld	ra,8(sp)
    80003cf8:	6402                	ld	s0,0(sp)
    80003cfa:	0141                	addi	sp,sp,16
    80003cfc:	8082                	ret

0000000080003cfe <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003cfe:	1101                	addi	sp,sp,-32
    80003d00:	ec06                	sd	ra,24(sp)
    80003d02:	e822                	sd	s0,16(sp)
    80003d04:	e426                	sd	s1,8(sp)
    80003d06:	e04a                	sd	s2,0(sp)
    80003d08:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003d0a:	0001e917          	auipc	s2,0x1e
    80003d0e:	c8e90913          	addi	s2,s2,-882 # 80021998 <log>
    80003d12:	01892583          	lw	a1,24(s2)
    80003d16:	02892503          	lw	a0,40(s2)
    80003d1a:	fffff097          	auipc	ra,0xfffff
    80003d1e:	01e080e7          	jalr	30(ra) # 80002d38 <bread>
    80003d22:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003d24:	02c92683          	lw	a3,44(s2)
    80003d28:	d134                	sw	a3,96(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003d2a:	02d05763          	blez	a3,80003d58 <write_head+0x5a>
    80003d2e:	0001e797          	auipc	a5,0x1e
    80003d32:	c9a78793          	addi	a5,a5,-870 # 800219c8 <log+0x30>
    80003d36:	06450713          	addi	a4,a0,100
    80003d3a:	36fd                	addiw	a3,a3,-1
    80003d3c:	1682                	slli	a3,a3,0x20
    80003d3e:	9281                	srli	a3,a3,0x20
    80003d40:	068a                	slli	a3,a3,0x2
    80003d42:	0001e617          	auipc	a2,0x1e
    80003d46:	c8a60613          	addi	a2,a2,-886 # 800219cc <log+0x34>
    80003d4a:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003d4c:	4390                	lw	a2,0(a5)
    80003d4e:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003d50:	0791                	addi	a5,a5,4
    80003d52:	0711                	addi	a4,a4,4
    80003d54:	fed79ce3          	bne	a5,a3,80003d4c <write_head+0x4e>
  }
  bwrite(buf);
    80003d58:	8526                	mv	a0,s1
    80003d5a:	fffff097          	auipc	ra,0xfffff
    80003d5e:	0d0080e7          	jalr	208(ra) # 80002e2a <bwrite>
  brelse(buf);
    80003d62:	8526                	mv	a0,s1
    80003d64:	fffff097          	auipc	ra,0xfffff
    80003d68:	104080e7          	jalr	260(ra) # 80002e68 <brelse>
}
    80003d6c:	60e2                	ld	ra,24(sp)
    80003d6e:	6442                	ld	s0,16(sp)
    80003d70:	64a2                	ld	s1,8(sp)
    80003d72:	6902                	ld	s2,0(sp)
    80003d74:	6105                	addi	sp,sp,32
    80003d76:	8082                	ret

0000000080003d78 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003d78:	0001e797          	auipc	a5,0x1e
    80003d7c:	c4c7a783          	lw	a5,-948(a5) # 800219c4 <log+0x2c>
    80003d80:	0af05663          	blez	a5,80003e2c <install_trans+0xb4>
{
    80003d84:	7139                	addi	sp,sp,-64
    80003d86:	fc06                	sd	ra,56(sp)
    80003d88:	f822                	sd	s0,48(sp)
    80003d8a:	f426                	sd	s1,40(sp)
    80003d8c:	f04a                	sd	s2,32(sp)
    80003d8e:	ec4e                	sd	s3,24(sp)
    80003d90:	e852                	sd	s4,16(sp)
    80003d92:	e456                	sd	s5,8(sp)
    80003d94:	0080                	addi	s0,sp,64
    80003d96:	0001ea97          	auipc	s5,0x1e
    80003d9a:	c32a8a93          	addi	s5,s5,-974 # 800219c8 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003d9e:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003da0:	0001e997          	auipc	s3,0x1e
    80003da4:	bf898993          	addi	s3,s3,-1032 # 80021998 <log>
    80003da8:	0189a583          	lw	a1,24(s3)
    80003dac:	014585bb          	addw	a1,a1,s4
    80003db0:	2585                	addiw	a1,a1,1
    80003db2:	0289a503          	lw	a0,40(s3)
    80003db6:	fffff097          	auipc	ra,0xfffff
    80003dba:	f82080e7          	jalr	-126(ra) # 80002d38 <bread>
    80003dbe:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003dc0:	000aa583          	lw	a1,0(s5)
    80003dc4:	0289a503          	lw	a0,40(s3)
    80003dc8:	fffff097          	auipc	ra,0xfffff
    80003dcc:	f70080e7          	jalr	-144(ra) # 80002d38 <bread>
    80003dd0:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003dd2:	40000613          	li	a2,1024
    80003dd6:	06090593          	addi	a1,s2,96
    80003dda:	06050513          	addi	a0,a0,96
    80003dde:	ffffd097          	auipc	ra,0xffffd
    80003de2:	df0080e7          	jalr	-528(ra) # 80000bce <memmove>
    bwrite(dbuf);  // write dst to disk
    80003de6:	8526                	mv	a0,s1
    80003de8:	fffff097          	auipc	ra,0xfffff
    80003dec:	042080e7          	jalr	66(ra) # 80002e2a <bwrite>
    bunpin(dbuf);
    80003df0:	8526                	mv	a0,s1
    80003df2:	fffff097          	auipc	ra,0xfffff
    80003df6:	150080e7          	jalr	336(ra) # 80002f42 <bunpin>
    brelse(lbuf);
    80003dfa:	854a                	mv	a0,s2
    80003dfc:	fffff097          	auipc	ra,0xfffff
    80003e00:	06c080e7          	jalr	108(ra) # 80002e68 <brelse>
    brelse(dbuf);
    80003e04:	8526                	mv	a0,s1
    80003e06:	fffff097          	auipc	ra,0xfffff
    80003e0a:	062080e7          	jalr	98(ra) # 80002e68 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003e0e:	2a05                	addiw	s4,s4,1
    80003e10:	0a91                	addi	s5,s5,4
    80003e12:	02c9a783          	lw	a5,44(s3)
    80003e16:	f8fa49e3          	blt	s4,a5,80003da8 <install_trans+0x30>
}
    80003e1a:	70e2                	ld	ra,56(sp)
    80003e1c:	7442                	ld	s0,48(sp)
    80003e1e:	74a2                	ld	s1,40(sp)
    80003e20:	7902                	ld	s2,32(sp)
    80003e22:	69e2                	ld	s3,24(sp)
    80003e24:	6a42                	ld	s4,16(sp)
    80003e26:	6aa2                	ld	s5,8(sp)
    80003e28:	6121                	addi	sp,sp,64
    80003e2a:	8082                	ret
    80003e2c:	8082                	ret

0000000080003e2e <initlog>:
{
    80003e2e:	7179                	addi	sp,sp,-48
    80003e30:	f406                	sd	ra,40(sp)
    80003e32:	f022                	sd	s0,32(sp)
    80003e34:	ec26                	sd	s1,24(sp)
    80003e36:	e84a                	sd	s2,16(sp)
    80003e38:	e44e                	sd	s3,8(sp)
    80003e3a:	1800                	addi	s0,sp,48
    80003e3c:	892a                	mv	s2,a0
    80003e3e:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003e40:	0001e497          	auipc	s1,0x1e
    80003e44:	b5848493          	addi	s1,s1,-1192 # 80021998 <log>
    80003e48:	00004597          	auipc	a1,0x4
    80003e4c:	b2058593          	addi	a1,a1,-1248 # 80007968 <userret+0x8d8>
    80003e50:	8526                	mv	a0,s1
    80003e52:	ffffd097          	auipc	ra,0xffffd
    80003e56:	b6e080e7          	jalr	-1170(ra) # 800009c0 <initlock>
  log.start = sb->logstart;
    80003e5a:	0149a583          	lw	a1,20(s3)
    80003e5e:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003e60:	0109a783          	lw	a5,16(s3)
    80003e64:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003e66:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003e6a:	854a                	mv	a0,s2
    80003e6c:	fffff097          	auipc	ra,0xfffff
    80003e70:	ecc080e7          	jalr	-308(ra) # 80002d38 <bread>
  log.lh.n = lh->n;
    80003e74:	513c                	lw	a5,96(a0)
    80003e76:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003e78:	02f05563          	blez	a5,80003ea2 <initlog+0x74>
    80003e7c:	06450713          	addi	a4,a0,100
    80003e80:	0001e697          	auipc	a3,0x1e
    80003e84:	b4868693          	addi	a3,a3,-1208 # 800219c8 <log+0x30>
    80003e88:	37fd                	addiw	a5,a5,-1
    80003e8a:	1782                	slli	a5,a5,0x20
    80003e8c:	9381                	srli	a5,a5,0x20
    80003e8e:	078a                	slli	a5,a5,0x2
    80003e90:	06850613          	addi	a2,a0,104
    80003e94:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003e96:	4310                	lw	a2,0(a4)
    80003e98:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    80003e9a:	0711                	addi	a4,a4,4
    80003e9c:	0691                	addi	a3,a3,4
    80003e9e:	fef71ce3          	bne	a4,a5,80003e96 <initlog+0x68>
  brelse(buf);
    80003ea2:	fffff097          	auipc	ra,0xfffff
    80003ea6:	fc6080e7          	jalr	-58(ra) # 80002e68 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
    80003eaa:	00000097          	auipc	ra,0x0
    80003eae:	ece080e7          	jalr	-306(ra) # 80003d78 <install_trans>
  log.lh.n = 0;
    80003eb2:	0001e797          	auipc	a5,0x1e
    80003eb6:	b007a923          	sw	zero,-1262(a5) # 800219c4 <log+0x2c>
  write_head(); // clear the log
    80003eba:	00000097          	auipc	ra,0x0
    80003ebe:	e44080e7          	jalr	-444(ra) # 80003cfe <write_head>
}
    80003ec2:	70a2                	ld	ra,40(sp)
    80003ec4:	7402                	ld	s0,32(sp)
    80003ec6:	64e2                	ld	s1,24(sp)
    80003ec8:	6942                	ld	s2,16(sp)
    80003eca:	69a2                	ld	s3,8(sp)
    80003ecc:	6145                	addi	sp,sp,48
    80003ece:	8082                	ret

0000000080003ed0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003ed0:	1101                	addi	sp,sp,-32
    80003ed2:	ec06                	sd	ra,24(sp)
    80003ed4:	e822                	sd	s0,16(sp)
    80003ed6:	e426                	sd	s1,8(sp)
    80003ed8:	e04a                	sd	s2,0(sp)
    80003eda:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003edc:	0001e517          	auipc	a0,0x1e
    80003ee0:	abc50513          	addi	a0,a0,-1348 # 80021998 <log>
    80003ee4:	ffffd097          	auipc	ra,0xffffd
    80003ee8:	bee080e7          	jalr	-1042(ra) # 80000ad2 <acquire>
  while(1){
    if(log.committing){
    80003eec:	0001e497          	auipc	s1,0x1e
    80003ef0:	aac48493          	addi	s1,s1,-1364 # 80021998 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003ef4:	4979                	li	s2,30
    80003ef6:	a039                	j	80003f04 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003ef8:	85a6                	mv	a1,s1
    80003efa:	8526                	mv	a0,s1
    80003efc:	ffffe097          	auipc	ra,0xffffe
    80003f00:	22a080e7          	jalr	554(ra) # 80002126 <sleep>
    if(log.committing){
    80003f04:	50dc                	lw	a5,36(s1)
    80003f06:	fbed                	bnez	a5,80003ef8 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003f08:	509c                	lw	a5,32(s1)
    80003f0a:	0017871b          	addiw	a4,a5,1
    80003f0e:	0007069b          	sext.w	a3,a4
    80003f12:	0027179b          	slliw	a5,a4,0x2
    80003f16:	9fb9                	addw	a5,a5,a4
    80003f18:	0017979b          	slliw	a5,a5,0x1
    80003f1c:	54d8                	lw	a4,44(s1)
    80003f1e:	9fb9                	addw	a5,a5,a4
    80003f20:	00f95963          	bge	s2,a5,80003f32 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003f24:	85a6                	mv	a1,s1
    80003f26:	8526                	mv	a0,s1
    80003f28:	ffffe097          	auipc	ra,0xffffe
    80003f2c:	1fe080e7          	jalr	510(ra) # 80002126 <sleep>
    80003f30:	bfd1                	j	80003f04 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003f32:	0001e517          	auipc	a0,0x1e
    80003f36:	a6650513          	addi	a0,a0,-1434 # 80021998 <log>
    80003f3a:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003f3c:	ffffd097          	auipc	ra,0xffffd
    80003f40:	bea080e7          	jalr	-1046(ra) # 80000b26 <release>
      break;
    }
  }
}
    80003f44:	60e2                	ld	ra,24(sp)
    80003f46:	6442                	ld	s0,16(sp)
    80003f48:	64a2                	ld	s1,8(sp)
    80003f4a:	6902                	ld	s2,0(sp)
    80003f4c:	6105                	addi	sp,sp,32
    80003f4e:	8082                	ret

0000000080003f50 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003f50:	7139                	addi	sp,sp,-64
    80003f52:	fc06                	sd	ra,56(sp)
    80003f54:	f822                	sd	s0,48(sp)
    80003f56:	f426                	sd	s1,40(sp)
    80003f58:	f04a                	sd	s2,32(sp)
    80003f5a:	ec4e                	sd	s3,24(sp)
    80003f5c:	e852                	sd	s4,16(sp)
    80003f5e:	e456                	sd	s5,8(sp)
    80003f60:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003f62:	0001e497          	auipc	s1,0x1e
    80003f66:	a3648493          	addi	s1,s1,-1482 # 80021998 <log>
    80003f6a:	8526                	mv	a0,s1
    80003f6c:	ffffd097          	auipc	ra,0xffffd
    80003f70:	b66080e7          	jalr	-1178(ra) # 80000ad2 <acquire>
  log.outstanding -= 1;
    80003f74:	509c                	lw	a5,32(s1)
    80003f76:	37fd                	addiw	a5,a5,-1
    80003f78:	0007891b          	sext.w	s2,a5
    80003f7c:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003f7e:	50dc                	lw	a5,36(s1)
    80003f80:	efb9                	bnez	a5,80003fde <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003f82:	06091663          	bnez	s2,80003fee <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    80003f86:	0001e497          	auipc	s1,0x1e
    80003f8a:	a1248493          	addi	s1,s1,-1518 # 80021998 <log>
    80003f8e:	4785                	li	a5,1
    80003f90:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003f92:	8526                	mv	a0,s1
    80003f94:	ffffd097          	auipc	ra,0xffffd
    80003f98:	b92080e7          	jalr	-1134(ra) # 80000b26 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003f9c:	54dc                	lw	a5,44(s1)
    80003f9e:	06f04763          	bgtz	a5,8000400c <end_op+0xbc>
    acquire(&log.lock);
    80003fa2:	0001e497          	auipc	s1,0x1e
    80003fa6:	9f648493          	addi	s1,s1,-1546 # 80021998 <log>
    80003faa:	8526                	mv	a0,s1
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	b26080e7          	jalr	-1242(ra) # 80000ad2 <acquire>
    log.committing = 0;
    80003fb4:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003fb8:	8526                	mv	a0,s1
    80003fba:	ffffe097          	auipc	ra,0xffffe
    80003fbe:	2f2080e7          	jalr	754(ra) # 800022ac <wakeup>
    release(&log.lock);
    80003fc2:	8526                	mv	a0,s1
    80003fc4:	ffffd097          	auipc	ra,0xffffd
    80003fc8:	b62080e7          	jalr	-1182(ra) # 80000b26 <release>
}
    80003fcc:	70e2                	ld	ra,56(sp)
    80003fce:	7442                	ld	s0,48(sp)
    80003fd0:	74a2                	ld	s1,40(sp)
    80003fd2:	7902                	ld	s2,32(sp)
    80003fd4:	69e2                	ld	s3,24(sp)
    80003fd6:	6a42                	ld	s4,16(sp)
    80003fd8:	6aa2                	ld	s5,8(sp)
    80003fda:	6121                	addi	sp,sp,64
    80003fdc:	8082                	ret
    panic("log.committing");
    80003fde:	00004517          	auipc	a0,0x4
    80003fe2:	99250513          	addi	a0,a0,-1646 # 80007970 <userret+0x8e0>
    80003fe6:	ffffc097          	auipc	ra,0xffffc
    80003fea:	568080e7          	jalr	1384(ra) # 8000054e <panic>
    wakeup(&log);
    80003fee:	0001e497          	auipc	s1,0x1e
    80003ff2:	9aa48493          	addi	s1,s1,-1622 # 80021998 <log>
    80003ff6:	8526                	mv	a0,s1
    80003ff8:	ffffe097          	auipc	ra,0xffffe
    80003ffc:	2b4080e7          	jalr	692(ra) # 800022ac <wakeup>
  release(&log.lock);
    80004000:	8526                	mv	a0,s1
    80004002:	ffffd097          	auipc	ra,0xffffd
    80004006:	b24080e7          	jalr	-1244(ra) # 80000b26 <release>
  if(do_commit){
    8000400a:	b7c9                	j	80003fcc <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000400c:	0001ea97          	auipc	s5,0x1e
    80004010:	9bca8a93          	addi	s5,s5,-1604 # 800219c8 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004014:	0001ea17          	auipc	s4,0x1e
    80004018:	984a0a13          	addi	s4,s4,-1660 # 80021998 <log>
    8000401c:	018a2583          	lw	a1,24(s4)
    80004020:	012585bb          	addw	a1,a1,s2
    80004024:	2585                	addiw	a1,a1,1
    80004026:	028a2503          	lw	a0,40(s4)
    8000402a:	fffff097          	auipc	ra,0xfffff
    8000402e:	d0e080e7          	jalr	-754(ra) # 80002d38 <bread>
    80004032:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80004034:	000aa583          	lw	a1,0(s5)
    80004038:	028a2503          	lw	a0,40(s4)
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	cfc080e7          	jalr	-772(ra) # 80002d38 <bread>
    80004044:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80004046:	40000613          	li	a2,1024
    8000404a:	06050593          	addi	a1,a0,96
    8000404e:	06048513          	addi	a0,s1,96
    80004052:	ffffd097          	auipc	ra,0xffffd
    80004056:	b7c080e7          	jalr	-1156(ra) # 80000bce <memmove>
    bwrite(to);  // write the log
    8000405a:	8526                	mv	a0,s1
    8000405c:	fffff097          	auipc	ra,0xfffff
    80004060:	dce080e7          	jalr	-562(ra) # 80002e2a <bwrite>
    brelse(from);
    80004064:	854e                	mv	a0,s3
    80004066:	fffff097          	auipc	ra,0xfffff
    8000406a:	e02080e7          	jalr	-510(ra) # 80002e68 <brelse>
    brelse(to);
    8000406e:	8526                	mv	a0,s1
    80004070:	fffff097          	auipc	ra,0xfffff
    80004074:	df8080e7          	jalr	-520(ra) # 80002e68 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004078:	2905                	addiw	s2,s2,1
    8000407a:	0a91                	addi	s5,s5,4
    8000407c:	02ca2783          	lw	a5,44(s4)
    80004080:	f8f94ee3          	blt	s2,a5,8000401c <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80004084:	00000097          	auipc	ra,0x0
    80004088:	c7a080e7          	jalr	-902(ra) # 80003cfe <write_head>
    install_trans(); // Now install writes to home locations
    8000408c:	00000097          	auipc	ra,0x0
    80004090:	cec080e7          	jalr	-788(ra) # 80003d78 <install_trans>
    log.lh.n = 0;
    80004094:	0001e797          	auipc	a5,0x1e
    80004098:	9207a823          	sw	zero,-1744(a5) # 800219c4 <log+0x2c>
    write_head();    // Erase the transaction from the log
    8000409c:	00000097          	auipc	ra,0x0
    800040a0:	c62080e7          	jalr	-926(ra) # 80003cfe <write_head>
    800040a4:	bdfd                	j	80003fa2 <end_op+0x52>

00000000800040a6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800040a6:	1101                	addi	sp,sp,-32
    800040a8:	ec06                	sd	ra,24(sp)
    800040aa:	e822                	sd	s0,16(sp)
    800040ac:	e426                	sd	s1,8(sp)
    800040ae:	e04a                	sd	s2,0(sp)
    800040b0:	1000                	addi	s0,sp,32
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800040b2:	0001e717          	auipc	a4,0x1e
    800040b6:	91272703          	lw	a4,-1774(a4) # 800219c4 <log+0x2c>
    800040ba:	47f5                	li	a5,29
    800040bc:	08e7c063          	blt	a5,a4,8000413c <log_write+0x96>
    800040c0:	84aa                	mv	s1,a0
    800040c2:	0001e797          	auipc	a5,0x1e
    800040c6:	8f27a783          	lw	a5,-1806(a5) # 800219b4 <log+0x1c>
    800040ca:	37fd                	addiw	a5,a5,-1
    800040cc:	06f75863          	bge	a4,a5,8000413c <log_write+0x96>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800040d0:	0001e797          	auipc	a5,0x1e
    800040d4:	8e87a783          	lw	a5,-1816(a5) # 800219b8 <log+0x20>
    800040d8:	06f05a63          	blez	a5,8000414c <log_write+0xa6>
    panic("log_write outside of trans");

  acquire(&log.lock);
    800040dc:	0001e917          	auipc	s2,0x1e
    800040e0:	8bc90913          	addi	s2,s2,-1860 # 80021998 <log>
    800040e4:	854a                	mv	a0,s2
    800040e6:	ffffd097          	auipc	ra,0xffffd
    800040ea:	9ec080e7          	jalr	-1556(ra) # 80000ad2 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    800040ee:	02c92603          	lw	a2,44(s2)
    800040f2:	06c05563          	blez	a2,8000415c <log_write+0xb6>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    800040f6:	44cc                	lw	a1,12(s1)
    800040f8:	0001e717          	auipc	a4,0x1e
    800040fc:	8d070713          	addi	a4,a4,-1840 # 800219c8 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80004100:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    80004102:	4314                	lw	a3,0(a4)
    80004104:	04b68d63          	beq	a3,a1,8000415e <log_write+0xb8>
  for (i = 0; i < log.lh.n; i++) {
    80004108:	2785                	addiw	a5,a5,1
    8000410a:	0711                	addi	a4,a4,4
    8000410c:	fec79be3          	bne	a5,a2,80004102 <log_write+0x5c>
      break;
  }
  log.lh.block[i] = b->blockno;
    80004110:	0621                	addi	a2,a2,8
    80004112:	060a                	slli	a2,a2,0x2
    80004114:	0001e797          	auipc	a5,0x1e
    80004118:	88478793          	addi	a5,a5,-1916 # 80021998 <log>
    8000411c:	963e                	add	a2,a2,a5
    8000411e:	44dc                	lw	a5,12(s1)
    80004120:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80004122:	8526                	mv	a0,s1
    80004124:	fffff097          	auipc	ra,0xfffff
    80004128:	de2080e7          	jalr	-542(ra) # 80002f06 <bpin>
    log.lh.n++;
    8000412c:	0001e717          	auipc	a4,0x1e
    80004130:	86c70713          	addi	a4,a4,-1940 # 80021998 <log>
    80004134:	575c                	lw	a5,44(a4)
    80004136:	2785                	addiw	a5,a5,1
    80004138:	d75c                	sw	a5,44(a4)
    8000413a:	a83d                	j	80004178 <log_write+0xd2>
    panic("too big a transaction");
    8000413c:	00004517          	auipc	a0,0x4
    80004140:	84450513          	addi	a0,a0,-1980 # 80007980 <userret+0x8f0>
    80004144:	ffffc097          	auipc	ra,0xffffc
    80004148:	40a080e7          	jalr	1034(ra) # 8000054e <panic>
    panic("log_write outside of trans");
    8000414c:	00004517          	auipc	a0,0x4
    80004150:	84c50513          	addi	a0,a0,-1972 # 80007998 <userret+0x908>
    80004154:	ffffc097          	auipc	ra,0xffffc
    80004158:	3fa080e7          	jalr	1018(ra) # 8000054e <panic>
  for (i = 0; i < log.lh.n; i++) {
    8000415c:	4781                	li	a5,0
  log.lh.block[i] = b->blockno;
    8000415e:	00878713          	addi	a4,a5,8
    80004162:	00271693          	slli	a3,a4,0x2
    80004166:	0001e717          	auipc	a4,0x1e
    8000416a:	83270713          	addi	a4,a4,-1998 # 80021998 <log>
    8000416e:	9736                	add	a4,a4,a3
    80004170:	44d4                	lw	a3,12(s1)
    80004172:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80004174:	faf607e3          	beq	a2,a5,80004122 <log_write+0x7c>
  }
  release(&log.lock);
    80004178:	0001e517          	auipc	a0,0x1e
    8000417c:	82050513          	addi	a0,a0,-2016 # 80021998 <log>
    80004180:	ffffd097          	auipc	ra,0xffffd
    80004184:	9a6080e7          	jalr	-1626(ra) # 80000b26 <release>
}
    80004188:	60e2                	ld	ra,24(sp)
    8000418a:	6442                	ld	s0,16(sp)
    8000418c:	64a2                	ld	s1,8(sp)
    8000418e:	6902                	ld	s2,0(sp)
    80004190:	6105                	addi	sp,sp,32
    80004192:	8082                	ret

0000000080004194 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004194:	1101                	addi	sp,sp,-32
    80004196:	ec06                	sd	ra,24(sp)
    80004198:	e822                	sd	s0,16(sp)
    8000419a:	e426                	sd	s1,8(sp)
    8000419c:	e04a                	sd	s2,0(sp)
    8000419e:	1000                	addi	s0,sp,32
    800041a0:	84aa                	mv	s1,a0
    800041a2:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800041a4:	00004597          	auipc	a1,0x4
    800041a8:	81458593          	addi	a1,a1,-2028 # 800079b8 <userret+0x928>
    800041ac:	0521                	addi	a0,a0,8
    800041ae:	ffffd097          	auipc	ra,0xffffd
    800041b2:	812080e7          	jalr	-2030(ra) # 800009c0 <initlock>
  lk->name = name;
    800041b6:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800041ba:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800041be:	0204a423          	sw	zero,40(s1)
}
    800041c2:	60e2                	ld	ra,24(sp)
    800041c4:	6442                	ld	s0,16(sp)
    800041c6:	64a2                	ld	s1,8(sp)
    800041c8:	6902                	ld	s2,0(sp)
    800041ca:	6105                	addi	sp,sp,32
    800041cc:	8082                	ret

00000000800041ce <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800041ce:	1101                	addi	sp,sp,-32
    800041d0:	ec06                	sd	ra,24(sp)
    800041d2:	e822                	sd	s0,16(sp)
    800041d4:	e426                	sd	s1,8(sp)
    800041d6:	e04a                	sd	s2,0(sp)
    800041d8:	1000                	addi	s0,sp,32
    800041da:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800041dc:	00850913          	addi	s2,a0,8
    800041e0:	854a                	mv	a0,s2
    800041e2:	ffffd097          	auipc	ra,0xffffd
    800041e6:	8f0080e7          	jalr	-1808(ra) # 80000ad2 <acquire>
  while (lk->locked) {
    800041ea:	409c                	lw	a5,0(s1)
    800041ec:	cb89                	beqz	a5,800041fe <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800041ee:	85ca                	mv	a1,s2
    800041f0:	8526                	mv	a0,s1
    800041f2:	ffffe097          	auipc	ra,0xffffe
    800041f6:	f34080e7          	jalr	-204(ra) # 80002126 <sleep>
  while (lk->locked) {
    800041fa:	409c                	lw	a5,0(s1)
    800041fc:	fbed                	bnez	a5,800041ee <acquiresleep+0x20>
  }
  lk->locked = 1;
    800041fe:	4785                	li	a5,1
    80004200:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80004202:	ffffd097          	auipc	ra,0xffffd
    80004206:	782080e7          	jalr	1922(ra) # 80001984 <myproc>
    8000420a:	5d1c                	lw	a5,56(a0)
    8000420c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000420e:	854a                	mv	a0,s2
    80004210:	ffffd097          	auipc	ra,0xffffd
    80004214:	916080e7          	jalr	-1770(ra) # 80000b26 <release>
}
    80004218:	60e2                	ld	ra,24(sp)
    8000421a:	6442                	ld	s0,16(sp)
    8000421c:	64a2                	ld	s1,8(sp)
    8000421e:	6902                	ld	s2,0(sp)
    80004220:	6105                	addi	sp,sp,32
    80004222:	8082                	ret

0000000080004224 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004224:	1101                	addi	sp,sp,-32
    80004226:	ec06                	sd	ra,24(sp)
    80004228:	e822                	sd	s0,16(sp)
    8000422a:	e426                	sd	s1,8(sp)
    8000422c:	e04a                	sd	s2,0(sp)
    8000422e:	1000                	addi	s0,sp,32
    80004230:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004232:	00850913          	addi	s2,a0,8
    80004236:	854a                	mv	a0,s2
    80004238:	ffffd097          	auipc	ra,0xffffd
    8000423c:	89a080e7          	jalr	-1894(ra) # 80000ad2 <acquire>
  lk->locked = 0;
    80004240:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004244:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80004248:	8526                	mv	a0,s1
    8000424a:	ffffe097          	auipc	ra,0xffffe
    8000424e:	062080e7          	jalr	98(ra) # 800022ac <wakeup>
  release(&lk->lk);
    80004252:	854a                	mv	a0,s2
    80004254:	ffffd097          	auipc	ra,0xffffd
    80004258:	8d2080e7          	jalr	-1838(ra) # 80000b26 <release>
}
    8000425c:	60e2                	ld	ra,24(sp)
    8000425e:	6442                	ld	s0,16(sp)
    80004260:	64a2                	ld	s1,8(sp)
    80004262:	6902                	ld	s2,0(sp)
    80004264:	6105                	addi	sp,sp,32
    80004266:	8082                	ret

0000000080004268 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004268:	7179                	addi	sp,sp,-48
    8000426a:	f406                	sd	ra,40(sp)
    8000426c:	f022                	sd	s0,32(sp)
    8000426e:	ec26                	sd	s1,24(sp)
    80004270:	e84a                	sd	s2,16(sp)
    80004272:	e44e                	sd	s3,8(sp)
    80004274:	1800                	addi	s0,sp,48
    80004276:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004278:	00850913          	addi	s2,a0,8
    8000427c:	854a                	mv	a0,s2
    8000427e:	ffffd097          	auipc	ra,0xffffd
    80004282:	854080e7          	jalr	-1964(ra) # 80000ad2 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80004286:	409c                	lw	a5,0(s1)
    80004288:	ef99                	bnez	a5,800042a6 <holdingsleep+0x3e>
    8000428a:	4481                	li	s1,0
  release(&lk->lk);
    8000428c:	854a                	mv	a0,s2
    8000428e:	ffffd097          	auipc	ra,0xffffd
    80004292:	898080e7          	jalr	-1896(ra) # 80000b26 <release>
  return r;
}
    80004296:	8526                	mv	a0,s1
    80004298:	70a2                	ld	ra,40(sp)
    8000429a:	7402                	ld	s0,32(sp)
    8000429c:	64e2                	ld	s1,24(sp)
    8000429e:	6942                	ld	s2,16(sp)
    800042a0:	69a2                	ld	s3,8(sp)
    800042a2:	6145                	addi	sp,sp,48
    800042a4:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800042a6:	0284a983          	lw	s3,40(s1)
    800042aa:	ffffd097          	auipc	ra,0xffffd
    800042ae:	6da080e7          	jalr	1754(ra) # 80001984 <myproc>
    800042b2:	5d04                	lw	s1,56(a0)
    800042b4:	413484b3          	sub	s1,s1,s3
    800042b8:	0014b493          	seqz	s1,s1
    800042bc:	bfc1                	j	8000428c <holdingsleep+0x24>

00000000800042be <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800042be:	1141                	addi	sp,sp,-16
    800042c0:	e406                	sd	ra,8(sp)
    800042c2:	e022                	sd	s0,0(sp)
    800042c4:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800042c6:	00003597          	auipc	a1,0x3
    800042ca:	70258593          	addi	a1,a1,1794 # 800079c8 <userret+0x938>
    800042ce:	0001e517          	auipc	a0,0x1e
    800042d2:	81250513          	addi	a0,a0,-2030 # 80021ae0 <ftable>
    800042d6:	ffffc097          	auipc	ra,0xffffc
    800042da:	6ea080e7          	jalr	1770(ra) # 800009c0 <initlock>
}
    800042de:	60a2                	ld	ra,8(sp)
    800042e0:	6402                	ld	s0,0(sp)
    800042e2:	0141                	addi	sp,sp,16
    800042e4:	8082                	ret

00000000800042e6 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800042e6:	1101                	addi	sp,sp,-32
    800042e8:	ec06                	sd	ra,24(sp)
    800042ea:	e822                	sd	s0,16(sp)
    800042ec:	e426                	sd	s1,8(sp)
    800042ee:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800042f0:	0001d517          	auipc	a0,0x1d
    800042f4:	7f050513          	addi	a0,a0,2032 # 80021ae0 <ftable>
    800042f8:	ffffc097          	auipc	ra,0xffffc
    800042fc:	7da080e7          	jalr	2010(ra) # 80000ad2 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004300:	0001d497          	auipc	s1,0x1d
    80004304:	7f848493          	addi	s1,s1,2040 # 80021af8 <ftable+0x18>
    80004308:	0001e717          	auipc	a4,0x1e
    8000430c:	79070713          	addi	a4,a4,1936 # 80022a98 <ftable+0xfb8>
    if(f->ref == 0){
    80004310:	40dc                	lw	a5,4(s1)
    80004312:	cf99                	beqz	a5,80004330 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004314:	02848493          	addi	s1,s1,40
    80004318:	fee49ce3          	bne	s1,a4,80004310 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000431c:	0001d517          	auipc	a0,0x1d
    80004320:	7c450513          	addi	a0,a0,1988 # 80021ae0 <ftable>
    80004324:	ffffd097          	auipc	ra,0xffffd
    80004328:	802080e7          	jalr	-2046(ra) # 80000b26 <release>
  return 0;
    8000432c:	4481                	li	s1,0
    8000432e:	a819                	j	80004344 <filealloc+0x5e>
      f->ref = 1;
    80004330:	4785                	li	a5,1
    80004332:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80004334:	0001d517          	auipc	a0,0x1d
    80004338:	7ac50513          	addi	a0,a0,1964 # 80021ae0 <ftable>
    8000433c:	ffffc097          	auipc	ra,0xffffc
    80004340:	7ea080e7          	jalr	2026(ra) # 80000b26 <release>
}
    80004344:	8526                	mv	a0,s1
    80004346:	60e2                	ld	ra,24(sp)
    80004348:	6442                	ld	s0,16(sp)
    8000434a:	64a2                	ld	s1,8(sp)
    8000434c:	6105                	addi	sp,sp,32
    8000434e:	8082                	ret

0000000080004350 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004350:	1101                	addi	sp,sp,-32
    80004352:	ec06                	sd	ra,24(sp)
    80004354:	e822                	sd	s0,16(sp)
    80004356:	e426                	sd	s1,8(sp)
    80004358:	1000                	addi	s0,sp,32
    8000435a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000435c:	0001d517          	auipc	a0,0x1d
    80004360:	78450513          	addi	a0,a0,1924 # 80021ae0 <ftable>
    80004364:	ffffc097          	auipc	ra,0xffffc
    80004368:	76e080e7          	jalr	1902(ra) # 80000ad2 <acquire>
  if(f->ref < 1)
    8000436c:	40dc                	lw	a5,4(s1)
    8000436e:	02f05263          	blez	a5,80004392 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004372:	2785                	addiw	a5,a5,1
    80004374:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004376:	0001d517          	auipc	a0,0x1d
    8000437a:	76a50513          	addi	a0,a0,1898 # 80021ae0 <ftable>
    8000437e:	ffffc097          	auipc	ra,0xffffc
    80004382:	7a8080e7          	jalr	1960(ra) # 80000b26 <release>
  return f;
}
    80004386:	8526                	mv	a0,s1
    80004388:	60e2                	ld	ra,24(sp)
    8000438a:	6442                	ld	s0,16(sp)
    8000438c:	64a2                	ld	s1,8(sp)
    8000438e:	6105                	addi	sp,sp,32
    80004390:	8082                	ret
    panic("filedup");
    80004392:	00003517          	auipc	a0,0x3
    80004396:	63e50513          	addi	a0,a0,1598 # 800079d0 <userret+0x940>
    8000439a:	ffffc097          	auipc	ra,0xffffc
    8000439e:	1b4080e7          	jalr	436(ra) # 8000054e <panic>

00000000800043a2 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800043a2:	7139                	addi	sp,sp,-64
    800043a4:	fc06                	sd	ra,56(sp)
    800043a6:	f822                	sd	s0,48(sp)
    800043a8:	f426                	sd	s1,40(sp)
    800043aa:	f04a                	sd	s2,32(sp)
    800043ac:	ec4e                	sd	s3,24(sp)
    800043ae:	e852                	sd	s4,16(sp)
    800043b0:	e456                	sd	s5,8(sp)
    800043b2:	0080                	addi	s0,sp,64
    800043b4:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800043b6:	0001d517          	auipc	a0,0x1d
    800043ba:	72a50513          	addi	a0,a0,1834 # 80021ae0 <ftable>
    800043be:	ffffc097          	auipc	ra,0xffffc
    800043c2:	714080e7          	jalr	1812(ra) # 80000ad2 <acquire>
  if(f->ref < 1)
    800043c6:	40dc                	lw	a5,4(s1)
    800043c8:	06f05163          	blez	a5,8000442a <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800043cc:	37fd                	addiw	a5,a5,-1
    800043ce:	0007871b          	sext.w	a4,a5
    800043d2:	c0dc                	sw	a5,4(s1)
    800043d4:	06e04363          	bgtz	a4,8000443a <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800043d8:	0004a903          	lw	s2,0(s1)
    800043dc:	0094ca83          	lbu	s5,9(s1)
    800043e0:	0104ba03          	ld	s4,16(s1)
    800043e4:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    800043e8:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800043ec:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800043f0:	0001d517          	auipc	a0,0x1d
    800043f4:	6f050513          	addi	a0,a0,1776 # 80021ae0 <ftable>
    800043f8:	ffffc097          	auipc	ra,0xffffc
    800043fc:	72e080e7          	jalr	1838(ra) # 80000b26 <release>

  if(ff.type == FD_PIPE){
    80004400:	4785                	li	a5,1
    80004402:	04f90d63          	beq	s2,a5,8000445c <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004406:	3979                	addiw	s2,s2,-2
    80004408:	4785                	li	a5,1
    8000440a:	0527e063          	bltu	a5,s2,8000444a <fileclose+0xa8>
    begin_op();
    8000440e:	00000097          	auipc	ra,0x0
    80004412:	ac2080e7          	jalr	-1342(ra) # 80003ed0 <begin_op>
    iput(ff.ip);
    80004416:	854e                	mv	a0,s3
    80004418:	fffff097          	auipc	ra,0xfffff
    8000441c:	230080e7          	jalr	560(ra) # 80003648 <iput>
    end_op();
    80004420:	00000097          	auipc	ra,0x0
    80004424:	b30080e7          	jalr	-1232(ra) # 80003f50 <end_op>
    80004428:	a00d                	j	8000444a <fileclose+0xa8>
    panic("fileclose");
    8000442a:	00003517          	auipc	a0,0x3
    8000442e:	5ae50513          	addi	a0,a0,1454 # 800079d8 <userret+0x948>
    80004432:	ffffc097          	auipc	ra,0xffffc
    80004436:	11c080e7          	jalr	284(ra) # 8000054e <panic>
    release(&ftable.lock);
    8000443a:	0001d517          	auipc	a0,0x1d
    8000443e:	6a650513          	addi	a0,a0,1702 # 80021ae0 <ftable>
    80004442:	ffffc097          	auipc	ra,0xffffc
    80004446:	6e4080e7          	jalr	1764(ra) # 80000b26 <release>
  }
}
    8000444a:	70e2                	ld	ra,56(sp)
    8000444c:	7442                	ld	s0,48(sp)
    8000444e:	74a2                	ld	s1,40(sp)
    80004450:	7902                	ld	s2,32(sp)
    80004452:	69e2                	ld	s3,24(sp)
    80004454:	6a42                	ld	s4,16(sp)
    80004456:	6aa2                	ld	s5,8(sp)
    80004458:	6121                	addi	sp,sp,64
    8000445a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000445c:	85d6                	mv	a1,s5
    8000445e:	8552                	mv	a0,s4
    80004460:	00000097          	auipc	ra,0x0
    80004464:	372080e7          	jalr	882(ra) # 800047d2 <pipeclose>
    80004468:	b7cd                	j	8000444a <fileclose+0xa8>

000000008000446a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    8000446a:	715d                	addi	sp,sp,-80
    8000446c:	e486                	sd	ra,72(sp)
    8000446e:	e0a2                	sd	s0,64(sp)
    80004470:	fc26                	sd	s1,56(sp)
    80004472:	f84a                	sd	s2,48(sp)
    80004474:	f44e                	sd	s3,40(sp)
    80004476:	0880                	addi	s0,sp,80
    80004478:	84aa                	mv	s1,a0
    8000447a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000447c:	ffffd097          	auipc	ra,0xffffd
    80004480:	508080e7          	jalr	1288(ra) # 80001984 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004484:	409c                	lw	a5,0(s1)
    80004486:	37f9                	addiw	a5,a5,-2
    80004488:	4705                	li	a4,1
    8000448a:	04f76763          	bltu	a4,a5,800044d8 <filestat+0x6e>
    8000448e:	892a                	mv	s2,a0
    ilock(f->ip);
    80004490:	6c88                	ld	a0,24(s1)
    80004492:	fffff097          	auipc	ra,0xfffff
    80004496:	0a8080e7          	jalr	168(ra) # 8000353a <ilock>
    stati(f->ip, &st);
    8000449a:	fb840593          	addi	a1,s0,-72
    8000449e:	6c88                	ld	a0,24(s1)
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	300080e7          	jalr	768(ra) # 800037a0 <stati>
    iunlock(f->ip);
    800044a8:	6c88                	ld	a0,24(s1)
    800044aa:	fffff097          	auipc	ra,0xfffff
    800044ae:	152080e7          	jalr	338(ra) # 800035fc <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800044b2:	46e1                	li	a3,24
    800044b4:	fb840613          	addi	a2,s0,-72
    800044b8:	85ce                	mv	a1,s3
    800044ba:	05093503          	ld	a0,80(s2)
    800044be:	ffffd097          	auipc	ra,0xffffd
    800044c2:	1ba080e7          	jalr	442(ra) # 80001678 <copyout>
    800044c6:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800044ca:	60a6                	ld	ra,72(sp)
    800044cc:	6406                	ld	s0,64(sp)
    800044ce:	74e2                	ld	s1,56(sp)
    800044d0:	7942                	ld	s2,48(sp)
    800044d2:	79a2                	ld	s3,40(sp)
    800044d4:	6161                	addi	sp,sp,80
    800044d6:	8082                	ret
  return -1;
    800044d8:	557d                	li	a0,-1
    800044da:	bfc5                	j	800044ca <filestat+0x60>

00000000800044dc <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800044dc:	7179                	addi	sp,sp,-48
    800044de:	f406                	sd	ra,40(sp)
    800044e0:	f022                	sd	s0,32(sp)
    800044e2:	ec26                	sd	s1,24(sp)
    800044e4:	e84a                	sd	s2,16(sp)
    800044e6:	e44e                	sd	s3,8(sp)
    800044e8:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800044ea:	00854783          	lbu	a5,8(a0)
    800044ee:	c3d5                	beqz	a5,80004592 <fileread+0xb6>
    800044f0:	84aa                	mv	s1,a0
    800044f2:	89ae                	mv	s3,a1
    800044f4:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    800044f6:	411c                	lw	a5,0(a0)
    800044f8:	4705                	li	a4,1
    800044fa:	04e78963          	beq	a5,a4,8000454c <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800044fe:	470d                	li	a4,3
    80004500:	04e78d63          	beq	a5,a4,8000455a <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004504:	4709                	li	a4,2
    80004506:	06e79e63          	bne	a5,a4,80004582 <fileread+0xa6>
    ilock(f->ip);
    8000450a:	6d08                	ld	a0,24(a0)
    8000450c:	fffff097          	auipc	ra,0xfffff
    80004510:	02e080e7          	jalr	46(ra) # 8000353a <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004514:	874a                	mv	a4,s2
    80004516:	5094                	lw	a3,32(s1)
    80004518:	864e                	mv	a2,s3
    8000451a:	4585                	li	a1,1
    8000451c:	6c88                	ld	a0,24(s1)
    8000451e:	fffff097          	auipc	ra,0xfffff
    80004522:	2ac080e7          	jalr	684(ra) # 800037ca <readi>
    80004526:	892a                	mv	s2,a0
    80004528:	00a05563          	blez	a0,80004532 <fileread+0x56>
      f->off += r;
    8000452c:	509c                	lw	a5,32(s1)
    8000452e:	9fa9                	addw	a5,a5,a0
    80004530:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004532:	6c88                	ld	a0,24(s1)
    80004534:	fffff097          	auipc	ra,0xfffff
    80004538:	0c8080e7          	jalr	200(ra) # 800035fc <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    8000453c:	854a                	mv	a0,s2
    8000453e:	70a2                	ld	ra,40(sp)
    80004540:	7402                	ld	s0,32(sp)
    80004542:	64e2                	ld	s1,24(sp)
    80004544:	6942                	ld	s2,16(sp)
    80004546:	69a2                	ld	s3,8(sp)
    80004548:	6145                	addi	sp,sp,48
    8000454a:	8082                	ret
    r = piperead(f->pipe, addr, n);
    8000454c:	6908                	ld	a0,16(a0)
    8000454e:	00000097          	auipc	ra,0x0
    80004552:	408080e7          	jalr	1032(ra) # 80004956 <piperead>
    80004556:	892a                	mv	s2,a0
    80004558:	b7d5                	j	8000453c <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000455a:	02451783          	lh	a5,36(a0)
    8000455e:	03079693          	slli	a3,a5,0x30
    80004562:	92c1                	srli	a3,a3,0x30
    80004564:	4725                	li	a4,9
    80004566:	02d76863          	bltu	a4,a3,80004596 <fileread+0xba>
    8000456a:	0792                	slli	a5,a5,0x4
    8000456c:	0001d717          	auipc	a4,0x1d
    80004570:	4d470713          	addi	a4,a4,1236 # 80021a40 <devsw>
    80004574:	97ba                	add	a5,a5,a4
    80004576:	639c                	ld	a5,0(a5)
    80004578:	c38d                	beqz	a5,8000459a <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    8000457a:	4505                	li	a0,1
    8000457c:	9782                	jalr	a5
    8000457e:	892a                	mv	s2,a0
    80004580:	bf75                	j	8000453c <fileread+0x60>
    panic("fileread");
    80004582:	00003517          	auipc	a0,0x3
    80004586:	46650513          	addi	a0,a0,1126 # 800079e8 <userret+0x958>
    8000458a:	ffffc097          	auipc	ra,0xffffc
    8000458e:	fc4080e7          	jalr	-60(ra) # 8000054e <panic>
    return -1;
    80004592:	597d                	li	s2,-1
    80004594:	b765                	j	8000453c <fileread+0x60>
      return -1;
    80004596:	597d                	li	s2,-1
    80004598:	b755                	j	8000453c <fileread+0x60>
    8000459a:	597d                	li	s2,-1
    8000459c:	b745                	j	8000453c <fileread+0x60>

000000008000459e <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    8000459e:	00954783          	lbu	a5,9(a0)
    800045a2:	14078563          	beqz	a5,800046ec <filewrite+0x14e>
{
    800045a6:	715d                	addi	sp,sp,-80
    800045a8:	e486                	sd	ra,72(sp)
    800045aa:	e0a2                	sd	s0,64(sp)
    800045ac:	fc26                	sd	s1,56(sp)
    800045ae:	f84a                	sd	s2,48(sp)
    800045b0:	f44e                	sd	s3,40(sp)
    800045b2:	f052                	sd	s4,32(sp)
    800045b4:	ec56                	sd	s5,24(sp)
    800045b6:	e85a                	sd	s6,16(sp)
    800045b8:	e45e                	sd	s7,8(sp)
    800045ba:	e062                	sd	s8,0(sp)
    800045bc:	0880                	addi	s0,sp,80
    800045be:	892a                	mv	s2,a0
    800045c0:	8aae                	mv	s5,a1
    800045c2:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800045c4:	411c                	lw	a5,0(a0)
    800045c6:	4705                	li	a4,1
    800045c8:	02e78263          	beq	a5,a4,800045ec <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800045cc:	470d                	li	a4,3
    800045ce:	02e78563          	beq	a5,a4,800045f8 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800045d2:	4709                	li	a4,2
    800045d4:	10e79463          	bne	a5,a4,800046dc <filewrite+0x13e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800045d8:	0ec05e63          	blez	a2,800046d4 <filewrite+0x136>
    int i = 0;
    800045dc:	4981                	li	s3,0
    800045de:	6b05                	lui	s6,0x1
    800045e0:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800045e4:	6b85                	lui	s7,0x1
    800045e6:	c00b8b9b          	addiw	s7,s7,-1024
    800045ea:	a851                	j	8000467e <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    800045ec:	6908                	ld	a0,16(a0)
    800045ee:	00000097          	auipc	ra,0x0
    800045f2:	254080e7          	jalr	596(ra) # 80004842 <pipewrite>
    800045f6:	a85d                	j	800046ac <filewrite+0x10e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800045f8:	02451783          	lh	a5,36(a0)
    800045fc:	03079693          	slli	a3,a5,0x30
    80004600:	92c1                	srli	a3,a3,0x30
    80004602:	4725                	li	a4,9
    80004604:	0ed76663          	bltu	a4,a3,800046f0 <filewrite+0x152>
    80004608:	0792                	slli	a5,a5,0x4
    8000460a:	0001d717          	auipc	a4,0x1d
    8000460e:	43670713          	addi	a4,a4,1078 # 80021a40 <devsw>
    80004612:	97ba                	add	a5,a5,a4
    80004614:	679c                	ld	a5,8(a5)
    80004616:	cff9                	beqz	a5,800046f4 <filewrite+0x156>
    ret = devsw[f->major].write(1, addr, n);
    80004618:	4505                	li	a0,1
    8000461a:	9782                	jalr	a5
    8000461c:	a841                	j	800046ac <filewrite+0x10e>
    8000461e:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80004622:	00000097          	auipc	ra,0x0
    80004626:	8ae080e7          	jalr	-1874(ra) # 80003ed0 <begin_op>
      ilock(f->ip);
    8000462a:	01893503          	ld	a0,24(s2)
    8000462e:	fffff097          	auipc	ra,0xfffff
    80004632:	f0c080e7          	jalr	-244(ra) # 8000353a <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004636:	8762                	mv	a4,s8
    80004638:	02092683          	lw	a3,32(s2)
    8000463c:	01598633          	add	a2,s3,s5
    80004640:	4585                	li	a1,1
    80004642:	01893503          	ld	a0,24(s2)
    80004646:	fffff097          	auipc	ra,0xfffff
    8000464a:	278080e7          	jalr	632(ra) # 800038be <writei>
    8000464e:	84aa                	mv	s1,a0
    80004650:	02a05f63          	blez	a0,8000468e <filewrite+0xf0>
        f->off += r;
    80004654:	02092783          	lw	a5,32(s2)
    80004658:	9fa9                	addw	a5,a5,a0
    8000465a:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    8000465e:	01893503          	ld	a0,24(s2)
    80004662:	fffff097          	auipc	ra,0xfffff
    80004666:	f9a080e7          	jalr	-102(ra) # 800035fc <iunlock>
      end_op();
    8000466a:	00000097          	auipc	ra,0x0
    8000466e:	8e6080e7          	jalr	-1818(ra) # 80003f50 <end_op>

      if(r < 0)
        break;
      if(r != n1)
    80004672:	049c1963          	bne	s8,s1,800046c4 <filewrite+0x126>
        panic("short filewrite");
      i += r;
    80004676:	013489bb          	addw	s3,s1,s3
    while(i < n){
    8000467a:	0349d663          	bge	s3,s4,800046a6 <filewrite+0x108>
      int n1 = n - i;
    8000467e:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80004682:	84be                	mv	s1,a5
    80004684:	2781                	sext.w	a5,a5
    80004686:	f8fb5ce3          	bge	s6,a5,8000461e <filewrite+0x80>
    8000468a:	84de                	mv	s1,s7
    8000468c:	bf49                	j	8000461e <filewrite+0x80>
      iunlock(f->ip);
    8000468e:	01893503          	ld	a0,24(s2)
    80004692:	fffff097          	auipc	ra,0xfffff
    80004696:	f6a080e7          	jalr	-150(ra) # 800035fc <iunlock>
      end_op();
    8000469a:	00000097          	auipc	ra,0x0
    8000469e:	8b6080e7          	jalr	-1866(ra) # 80003f50 <end_op>
      if(r < 0)
    800046a2:	fc04d8e3          	bgez	s1,80004672 <filewrite+0xd4>
    }
    ret = (i == n ? n : -1);
    800046a6:	8552                	mv	a0,s4
    800046a8:	033a1863          	bne	s4,s3,800046d8 <filewrite+0x13a>
  } else {
    panic("filewrite");
  }

  return ret;
}
    800046ac:	60a6                	ld	ra,72(sp)
    800046ae:	6406                	ld	s0,64(sp)
    800046b0:	74e2                	ld	s1,56(sp)
    800046b2:	7942                	ld	s2,48(sp)
    800046b4:	79a2                	ld	s3,40(sp)
    800046b6:	7a02                	ld	s4,32(sp)
    800046b8:	6ae2                	ld	s5,24(sp)
    800046ba:	6b42                	ld	s6,16(sp)
    800046bc:	6ba2                	ld	s7,8(sp)
    800046be:	6c02                	ld	s8,0(sp)
    800046c0:	6161                	addi	sp,sp,80
    800046c2:	8082                	ret
        panic("short filewrite");
    800046c4:	00003517          	auipc	a0,0x3
    800046c8:	33450513          	addi	a0,a0,820 # 800079f8 <userret+0x968>
    800046cc:	ffffc097          	auipc	ra,0xffffc
    800046d0:	e82080e7          	jalr	-382(ra) # 8000054e <panic>
    int i = 0;
    800046d4:	4981                	li	s3,0
    800046d6:	bfc1                	j	800046a6 <filewrite+0x108>
    ret = (i == n ? n : -1);
    800046d8:	557d                	li	a0,-1
    800046da:	bfc9                	j	800046ac <filewrite+0x10e>
    panic("filewrite");
    800046dc:	00003517          	auipc	a0,0x3
    800046e0:	32c50513          	addi	a0,a0,812 # 80007a08 <userret+0x978>
    800046e4:	ffffc097          	auipc	ra,0xffffc
    800046e8:	e6a080e7          	jalr	-406(ra) # 8000054e <panic>
    return -1;
    800046ec:	557d                	li	a0,-1
}
    800046ee:	8082                	ret
      return -1;
    800046f0:	557d                	li	a0,-1
    800046f2:	bf6d                	j	800046ac <filewrite+0x10e>
    800046f4:	557d                	li	a0,-1
    800046f6:	bf5d                	j	800046ac <filewrite+0x10e>

00000000800046f8 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800046f8:	7179                	addi	sp,sp,-48
    800046fa:	f406                	sd	ra,40(sp)
    800046fc:	f022                	sd	s0,32(sp)
    800046fe:	ec26                	sd	s1,24(sp)
    80004700:	e84a                	sd	s2,16(sp)
    80004702:	e44e                	sd	s3,8(sp)
    80004704:	e052                	sd	s4,0(sp)
    80004706:	1800                	addi	s0,sp,48
    80004708:	84aa                	mv	s1,a0
    8000470a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    8000470c:	0005b023          	sd	zero,0(a1)
    80004710:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004714:	00000097          	auipc	ra,0x0
    80004718:	bd2080e7          	jalr	-1070(ra) # 800042e6 <filealloc>
    8000471c:	e088                	sd	a0,0(s1)
    8000471e:	c551                	beqz	a0,800047aa <pipealloc+0xb2>
    80004720:	00000097          	auipc	ra,0x0
    80004724:	bc6080e7          	jalr	-1082(ra) # 800042e6 <filealloc>
    80004728:	00aa3023          	sd	a0,0(s4)
    8000472c:	c92d                	beqz	a0,8000479e <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    8000472e:	ffffc097          	auipc	ra,0xffffc
    80004732:	232080e7          	jalr	562(ra) # 80000960 <kalloc>
    80004736:	892a                	mv	s2,a0
    80004738:	c125                	beqz	a0,80004798 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    8000473a:	4985                	li	s3,1
    8000473c:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004740:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004744:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004748:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    8000474c:	00003597          	auipc	a1,0x3
    80004750:	2cc58593          	addi	a1,a1,716 # 80007a18 <userret+0x988>
    80004754:	ffffc097          	auipc	ra,0xffffc
    80004758:	26c080e7          	jalr	620(ra) # 800009c0 <initlock>
  (*f0)->type = FD_PIPE;
    8000475c:	609c                	ld	a5,0(s1)
    8000475e:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004762:	609c                	ld	a5,0(s1)
    80004764:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004768:	609c                	ld	a5,0(s1)
    8000476a:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    8000476e:	609c                	ld	a5,0(s1)
    80004770:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004774:	000a3783          	ld	a5,0(s4)
    80004778:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    8000477c:	000a3783          	ld	a5,0(s4)
    80004780:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004784:	000a3783          	ld	a5,0(s4)
    80004788:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    8000478c:	000a3783          	ld	a5,0(s4)
    80004790:	0127b823          	sd	s2,16(a5)
  return 0;
    80004794:	4501                	li	a0,0
    80004796:	a025                	j	800047be <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004798:	6088                	ld	a0,0(s1)
    8000479a:	e501                	bnez	a0,800047a2 <pipealloc+0xaa>
    8000479c:	a039                	j	800047aa <pipealloc+0xb2>
    8000479e:	6088                	ld	a0,0(s1)
    800047a0:	c51d                	beqz	a0,800047ce <pipealloc+0xd6>
    fileclose(*f0);
    800047a2:	00000097          	auipc	ra,0x0
    800047a6:	c00080e7          	jalr	-1024(ra) # 800043a2 <fileclose>
  if(*f1)
    800047aa:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    800047ae:	557d                	li	a0,-1
  if(*f1)
    800047b0:	c799                	beqz	a5,800047be <pipealloc+0xc6>
    fileclose(*f1);
    800047b2:	853e                	mv	a0,a5
    800047b4:	00000097          	auipc	ra,0x0
    800047b8:	bee080e7          	jalr	-1042(ra) # 800043a2 <fileclose>
  return -1;
    800047bc:	557d                	li	a0,-1
}
    800047be:	70a2                	ld	ra,40(sp)
    800047c0:	7402                	ld	s0,32(sp)
    800047c2:	64e2                	ld	s1,24(sp)
    800047c4:	6942                	ld	s2,16(sp)
    800047c6:	69a2                	ld	s3,8(sp)
    800047c8:	6a02                	ld	s4,0(sp)
    800047ca:	6145                	addi	sp,sp,48
    800047cc:	8082                	ret
  return -1;
    800047ce:	557d                	li	a0,-1
    800047d0:	b7fd                	j	800047be <pipealloc+0xc6>

00000000800047d2 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800047d2:	1101                	addi	sp,sp,-32
    800047d4:	ec06                	sd	ra,24(sp)
    800047d6:	e822                	sd	s0,16(sp)
    800047d8:	e426                	sd	s1,8(sp)
    800047da:	e04a                	sd	s2,0(sp)
    800047dc:	1000                	addi	s0,sp,32
    800047de:	84aa                	mv	s1,a0
    800047e0:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800047e2:	ffffc097          	auipc	ra,0xffffc
    800047e6:	2f0080e7          	jalr	752(ra) # 80000ad2 <acquire>
  if(writable){
    800047ea:	02090d63          	beqz	s2,80004824 <pipeclose+0x52>
    pi->writeopen = 0;
    800047ee:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800047f2:	21848513          	addi	a0,s1,536
    800047f6:	ffffe097          	auipc	ra,0xffffe
    800047fa:	ab6080e7          	jalr	-1354(ra) # 800022ac <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800047fe:	2204b783          	ld	a5,544(s1)
    80004802:	eb95                	bnez	a5,80004836 <pipeclose+0x64>
    release(&pi->lock);
    80004804:	8526                	mv	a0,s1
    80004806:	ffffc097          	auipc	ra,0xffffc
    8000480a:	320080e7          	jalr	800(ra) # 80000b26 <release>
    kfree((char*)pi);
    8000480e:	8526                	mv	a0,s1
    80004810:	ffffc097          	auipc	ra,0xffffc
    80004814:	054080e7          	jalr	84(ra) # 80000864 <kfree>
  } else
    release(&pi->lock);
}
    80004818:	60e2                	ld	ra,24(sp)
    8000481a:	6442                	ld	s0,16(sp)
    8000481c:	64a2                	ld	s1,8(sp)
    8000481e:	6902                	ld	s2,0(sp)
    80004820:	6105                	addi	sp,sp,32
    80004822:	8082                	ret
    pi->readopen = 0;
    80004824:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004828:	21c48513          	addi	a0,s1,540
    8000482c:	ffffe097          	auipc	ra,0xffffe
    80004830:	a80080e7          	jalr	-1408(ra) # 800022ac <wakeup>
    80004834:	b7e9                	j	800047fe <pipeclose+0x2c>
    release(&pi->lock);
    80004836:	8526                	mv	a0,s1
    80004838:	ffffc097          	auipc	ra,0xffffc
    8000483c:	2ee080e7          	jalr	750(ra) # 80000b26 <release>
}
    80004840:	bfe1                	j	80004818 <pipeclose+0x46>

0000000080004842 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004842:	7159                	addi	sp,sp,-112
    80004844:	f486                	sd	ra,104(sp)
    80004846:	f0a2                	sd	s0,96(sp)
    80004848:	eca6                	sd	s1,88(sp)
    8000484a:	e8ca                	sd	s2,80(sp)
    8000484c:	e4ce                	sd	s3,72(sp)
    8000484e:	e0d2                	sd	s4,64(sp)
    80004850:	fc56                	sd	s5,56(sp)
    80004852:	f85a                	sd	s6,48(sp)
    80004854:	f45e                	sd	s7,40(sp)
    80004856:	f062                	sd	s8,32(sp)
    80004858:	ec66                	sd	s9,24(sp)
    8000485a:	1880                	addi	s0,sp,112
    8000485c:	84aa                	mv	s1,a0
    8000485e:	8b2e                	mv	s6,a1
    80004860:	8ab2                	mv	s5,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    80004862:	ffffd097          	auipc	ra,0xffffd
    80004866:	122080e7          	jalr	290(ra) # 80001984 <myproc>
    8000486a:	8c2a                	mv	s8,a0

  acquire(&pi->lock);
    8000486c:	8526                	mv	a0,s1
    8000486e:	ffffc097          	auipc	ra,0xffffc
    80004872:	264080e7          	jalr	612(ra) # 80000ad2 <acquire>
  for(i = 0; i < n; i++){
    80004876:	0b505063          	blez	s5,80004916 <pipewrite+0xd4>
    8000487a:	8926                	mv	s2,s1
    8000487c:	fffa8b9b          	addiw	s7,s5,-1
    80004880:	1b82                	slli	s7,s7,0x20
    80004882:	020bdb93          	srli	s7,s7,0x20
    80004886:	001b0793          	addi	a5,s6,1
    8000488a:	9bbe                	add	s7,s7,a5
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || myproc()->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    8000488c:	21848a13          	addi	s4,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004890:	21c48993          	addi	s3,s1,540
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004894:	5cfd                	li	s9,-1
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    80004896:	2184a783          	lw	a5,536(s1)
    8000489a:	21c4a703          	lw	a4,540(s1)
    8000489e:	2007879b          	addiw	a5,a5,512
    800048a2:	02f71e63          	bne	a4,a5,800048de <pipewrite+0x9c>
      if(pi->readopen == 0 || myproc()->killed){
    800048a6:	2204a783          	lw	a5,544(s1)
    800048aa:	c3d9                	beqz	a5,80004930 <pipewrite+0xee>
    800048ac:	ffffd097          	auipc	ra,0xffffd
    800048b0:	0d8080e7          	jalr	216(ra) # 80001984 <myproc>
    800048b4:	591c                	lw	a5,48(a0)
    800048b6:	efad                	bnez	a5,80004930 <pipewrite+0xee>
      wakeup(&pi->nread);
    800048b8:	8552                	mv	a0,s4
    800048ba:	ffffe097          	auipc	ra,0xffffe
    800048be:	9f2080e7          	jalr	-1550(ra) # 800022ac <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800048c2:	85ca                	mv	a1,s2
    800048c4:	854e                	mv	a0,s3
    800048c6:	ffffe097          	auipc	ra,0xffffe
    800048ca:	860080e7          	jalr	-1952(ra) # 80002126 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    800048ce:	2184a783          	lw	a5,536(s1)
    800048d2:	21c4a703          	lw	a4,540(s1)
    800048d6:	2007879b          	addiw	a5,a5,512
    800048da:	fcf706e3          	beq	a4,a5,800048a6 <pipewrite+0x64>
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800048de:	4685                	li	a3,1
    800048e0:	865a                	mv	a2,s6
    800048e2:	f9f40593          	addi	a1,s0,-97
    800048e6:	050c3503          	ld	a0,80(s8)
    800048ea:	ffffd097          	auipc	ra,0xffffd
    800048ee:	e1a080e7          	jalr	-486(ra) # 80001704 <copyin>
    800048f2:	03950263          	beq	a0,s9,80004916 <pipewrite+0xd4>
      break;
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800048f6:	21c4a783          	lw	a5,540(s1)
    800048fa:	0017871b          	addiw	a4,a5,1
    800048fe:	20e4ae23          	sw	a4,540(s1)
    80004902:	1ff7f793          	andi	a5,a5,511
    80004906:	97a6                	add	a5,a5,s1
    80004908:	f9f44703          	lbu	a4,-97(s0)
    8000490c:	00e78c23          	sb	a4,24(a5)
  for(i = 0; i < n; i++){
    80004910:	0b05                	addi	s6,s6,1
    80004912:	f97b12e3          	bne	s6,s7,80004896 <pipewrite+0x54>
  }
  wakeup(&pi->nread);
    80004916:	21848513          	addi	a0,s1,536
    8000491a:	ffffe097          	auipc	ra,0xffffe
    8000491e:	992080e7          	jalr	-1646(ra) # 800022ac <wakeup>
  release(&pi->lock);
    80004922:	8526                	mv	a0,s1
    80004924:	ffffc097          	auipc	ra,0xffffc
    80004928:	202080e7          	jalr	514(ra) # 80000b26 <release>
  return n;
    8000492c:	8556                	mv	a0,s5
    8000492e:	a039                	j	8000493c <pipewrite+0xfa>
        release(&pi->lock);
    80004930:	8526                	mv	a0,s1
    80004932:	ffffc097          	auipc	ra,0xffffc
    80004936:	1f4080e7          	jalr	500(ra) # 80000b26 <release>
        return -1;
    8000493a:	557d                	li	a0,-1
}
    8000493c:	70a6                	ld	ra,104(sp)
    8000493e:	7406                	ld	s0,96(sp)
    80004940:	64e6                	ld	s1,88(sp)
    80004942:	6946                	ld	s2,80(sp)
    80004944:	69a6                	ld	s3,72(sp)
    80004946:	6a06                	ld	s4,64(sp)
    80004948:	7ae2                	ld	s5,56(sp)
    8000494a:	7b42                	ld	s6,48(sp)
    8000494c:	7ba2                	ld	s7,40(sp)
    8000494e:	7c02                	ld	s8,32(sp)
    80004950:	6ce2                	ld	s9,24(sp)
    80004952:	6165                	addi	sp,sp,112
    80004954:	8082                	ret

0000000080004956 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004956:	715d                	addi	sp,sp,-80
    80004958:	e486                	sd	ra,72(sp)
    8000495a:	e0a2                	sd	s0,64(sp)
    8000495c:	fc26                	sd	s1,56(sp)
    8000495e:	f84a                	sd	s2,48(sp)
    80004960:	f44e                	sd	s3,40(sp)
    80004962:	f052                	sd	s4,32(sp)
    80004964:	ec56                	sd	s5,24(sp)
    80004966:	e85a                	sd	s6,16(sp)
    80004968:	0880                	addi	s0,sp,80
    8000496a:	84aa                	mv	s1,a0
    8000496c:	892e                	mv	s2,a1
    8000496e:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    80004970:	ffffd097          	auipc	ra,0xffffd
    80004974:	014080e7          	jalr	20(ra) # 80001984 <myproc>
    80004978:	8aaa                	mv	s5,a0
  char ch;

  acquire(&pi->lock);
    8000497a:	8b26                	mv	s6,s1
    8000497c:	8526                	mv	a0,s1
    8000497e:	ffffc097          	auipc	ra,0xffffc
    80004982:	154080e7          	jalr	340(ra) # 80000ad2 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004986:	2184a703          	lw	a4,536(s1)
    8000498a:	21c4a783          	lw	a5,540(s1)
    if(myproc()->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000498e:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004992:	02f71763          	bne	a4,a5,800049c0 <piperead+0x6a>
    80004996:	2244a783          	lw	a5,548(s1)
    8000499a:	c39d                	beqz	a5,800049c0 <piperead+0x6a>
    if(myproc()->killed){
    8000499c:	ffffd097          	auipc	ra,0xffffd
    800049a0:	fe8080e7          	jalr	-24(ra) # 80001984 <myproc>
    800049a4:	591c                	lw	a5,48(a0)
    800049a6:	ebc1                	bnez	a5,80004a36 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800049a8:	85da                	mv	a1,s6
    800049aa:	854e                	mv	a0,s3
    800049ac:	ffffd097          	auipc	ra,0xffffd
    800049b0:	77a080e7          	jalr	1914(ra) # 80002126 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800049b4:	2184a703          	lw	a4,536(s1)
    800049b8:	21c4a783          	lw	a5,540(s1)
    800049bc:	fcf70de3          	beq	a4,a5,80004996 <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800049c0:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800049c2:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800049c4:	05405363          	blez	s4,80004a0a <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    800049c8:	2184a783          	lw	a5,536(s1)
    800049cc:	21c4a703          	lw	a4,540(s1)
    800049d0:	02f70d63          	beq	a4,a5,80004a0a <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800049d4:	0017871b          	addiw	a4,a5,1
    800049d8:	20e4ac23          	sw	a4,536(s1)
    800049dc:	1ff7f793          	andi	a5,a5,511
    800049e0:	97a6                	add	a5,a5,s1
    800049e2:	0187c783          	lbu	a5,24(a5)
    800049e6:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800049ea:	4685                	li	a3,1
    800049ec:	fbf40613          	addi	a2,s0,-65
    800049f0:	85ca                	mv	a1,s2
    800049f2:	050ab503          	ld	a0,80(s5)
    800049f6:	ffffd097          	auipc	ra,0xffffd
    800049fa:	c82080e7          	jalr	-894(ra) # 80001678 <copyout>
    800049fe:	01650663          	beq	a0,s6,80004a0a <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004a02:	2985                	addiw	s3,s3,1
    80004a04:	0905                	addi	s2,s2,1
    80004a06:	fd3a11e3          	bne	s4,s3,800049c8 <piperead+0x72>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004a0a:	21c48513          	addi	a0,s1,540
    80004a0e:	ffffe097          	auipc	ra,0xffffe
    80004a12:	89e080e7          	jalr	-1890(ra) # 800022ac <wakeup>
  release(&pi->lock);
    80004a16:	8526                	mv	a0,s1
    80004a18:	ffffc097          	auipc	ra,0xffffc
    80004a1c:	10e080e7          	jalr	270(ra) # 80000b26 <release>
  return i;
}
    80004a20:	854e                	mv	a0,s3
    80004a22:	60a6                	ld	ra,72(sp)
    80004a24:	6406                	ld	s0,64(sp)
    80004a26:	74e2                	ld	s1,56(sp)
    80004a28:	7942                	ld	s2,48(sp)
    80004a2a:	79a2                	ld	s3,40(sp)
    80004a2c:	7a02                	ld	s4,32(sp)
    80004a2e:	6ae2                	ld	s5,24(sp)
    80004a30:	6b42                	ld	s6,16(sp)
    80004a32:	6161                	addi	sp,sp,80
    80004a34:	8082                	ret
      release(&pi->lock);
    80004a36:	8526                	mv	a0,s1
    80004a38:	ffffc097          	auipc	ra,0xffffc
    80004a3c:	0ee080e7          	jalr	238(ra) # 80000b26 <release>
      return -1;
    80004a40:	59fd                	li	s3,-1
    80004a42:	bff9                	j	80004a20 <piperead+0xca>

0000000080004a44 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004a44:	df010113          	addi	sp,sp,-528
    80004a48:	20113423          	sd	ra,520(sp)
    80004a4c:	20813023          	sd	s0,512(sp)
    80004a50:	ffa6                	sd	s1,504(sp)
    80004a52:	fbca                	sd	s2,496(sp)
    80004a54:	f7ce                	sd	s3,488(sp)
    80004a56:	f3d2                	sd	s4,480(sp)
    80004a58:	efd6                	sd	s5,472(sp)
    80004a5a:	ebda                	sd	s6,464(sp)
    80004a5c:	e7de                	sd	s7,456(sp)
    80004a5e:	e3e2                	sd	s8,448(sp)
    80004a60:	ff66                	sd	s9,440(sp)
    80004a62:	fb6a                	sd	s10,432(sp)
    80004a64:	f76e                	sd	s11,424(sp)
    80004a66:	0c00                	addi	s0,sp,528
    80004a68:	84aa                	mv	s1,a0
    80004a6a:	dea43c23          	sd	a0,-520(s0)
    80004a6e:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004a72:	ffffd097          	auipc	ra,0xffffd
    80004a76:	f12080e7          	jalr	-238(ra) # 80001984 <myproc>
    80004a7a:	892a                	mv	s2,a0

  begin_op();
    80004a7c:	fffff097          	auipc	ra,0xfffff
    80004a80:	454080e7          	jalr	1108(ra) # 80003ed0 <begin_op>

  if((ip = namei(path)) == 0){
    80004a84:	8526                	mv	a0,s1
    80004a86:	fffff097          	auipc	ra,0xfffff
    80004a8a:	23e080e7          	jalr	574(ra) # 80003cc4 <namei>
    80004a8e:	c92d                	beqz	a0,80004b00 <exec+0xbc>
    80004a90:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004a92:	fffff097          	auipc	ra,0xfffff
    80004a96:	aa8080e7          	jalr	-1368(ra) # 8000353a <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004a9a:	04000713          	li	a4,64
    80004a9e:	4681                	li	a3,0
    80004aa0:	e4840613          	addi	a2,s0,-440
    80004aa4:	4581                	li	a1,0
    80004aa6:	8526                	mv	a0,s1
    80004aa8:	fffff097          	auipc	ra,0xfffff
    80004aac:	d22080e7          	jalr	-734(ra) # 800037ca <readi>
    80004ab0:	04000793          	li	a5,64
    80004ab4:	00f51a63          	bne	a0,a5,80004ac8 <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004ab8:	e4842703          	lw	a4,-440(s0)
    80004abc:	464c47b7          	lui	a5,0x464c4
    80004ac0:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004ac4:	04f70463          	beq	a4,a5,80004b0c <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004ac8:	8526                	mv	a0,s1
    80004aca:	fffff097          	auipc	ra,0xfffff
    80004ace:	cae080e7          	jalr	-850(ra) # 80003778 <iunlockput>
    end_op();
    80004ad2:	fffff097          	auipc	ra,0xfffff
    80004ad6:	47e080e7          	jalr	1150(ra) # 80003f50 <end_op>
  }
  return -1;
    80004ada:	557d                	li	a0,-1
}
    80004adc:	20813083          	ld	ra,520(sp)
    80004ae0:	20013403          	ld	s0,512(sp)
    80004ae4:	74fe                	ld	s1,504(sp)
    80004ae6:	795e                	ld	s2,496(sp)
    80004ae8:	79be                	ld	s3,488(sp)
    80004aea:	7a1e                	ld	s4,480(sp)
    80004aec:	6afe                	ld	s5,472(sp)
    80004aee:	6b5e                	ld	s6,464(sp)
    80004af0:	6bbe                	ld	s7,456(sp)
    80004af2:	6c1e                	ld	s8,448(sp)
    80004af4:	7cfa                	ld	s9,440(sp)
    80004af6:	7d5a                	ld	s10,432(sp)
    80004af8:	7dba                	ld	s11,424(sp)
    80004afa:	21010113          	addi	sp,sp,528
    80004afe:	8082                	ret
    end_op();
    80004b00:	fffff097          	auipc	ra,0xfffff
    80004b04:	450080e7          	jalr	1104(ra) # 80003f50 <end_op>
    return -1;
    80004b08:	557d                	li	a0,-1
    80004b0a:	bfc9                	j	80004adc <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80004b0c:	854a                	mv	a0,s2
    80004b0e:	ffffd097          	auipc	ra,0xffffd
    80004b12:	f3a080e7          	jalr	-198(ra) # 80001a48 <proc_pagetable>
    80004b16:	8c2a                	mv	s8,a0
    80004b18:	d945                	beqz	a0,80004ac8 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004b1a:	e6842983          	lw	s3,-408(s0)
    80004b1e:	e8045783          	lhu	a5,-384(s0)
    80004b22:	c7fd                	beqz	a5,80004c10 <exec+0x1cc>
  sz = 0;
    80004b24:	e0043423          	sd	zero,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004b28:	4b81                	li	s7,0
    if(ph.vaddr % PGSIZE != 0)
    80004b2a:	6b05                	lui	s6,0x1
    80004b2c:	fffb0793          	addi	a5,s6,-1 # fff <_entry-0x7ffff001>
    80004b30:	def43823          	sd	a5,-528(s0)
    80004b34:	a0a5                	j	80004b9c <exec+0x158>
    panic("loadseg: va must be page aligned");

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004b36:	00003517          	auipc	a0,0x3
    80004b3a:	eea50513          	addi	a0,a0,-278 # 80007a20 <userret+0x990>
    80004b3e:	ffffc097          	auipc	ra,0xffffc
    80004b42:	a10080e7          	jalr	-1520(ra) # 8000054e <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004b46:	8756                	mv	a4,s5
    80004b48:	012d86bb          	addw	a3,s11,s2
    80004b4c:	4581                	li	a1,0
    80004b4e:	8526                	mv	a0,s1
    80004b50:	fffff097          	auipc	ra,0xfffff
    80004b54:	c7a080e7          	jalr	-902(ra) # 800037ca <readi>
    80004b58:	2501                	sext.w	a0,a0
    80004b5a:	10aa9163          	bne	s5,a0,80004c5c <exec+0x218>
  for(i = 0; i < sz; i += PGSIZE){
    80004b5e:	6785                	lui	a5,0x1
    80004b60:	0127893b          	addw	s2,a5,s2
    80004b64:	77fd                	lui	a5,0xfffff
    80004b66:	01478a3b          	addw	s4,a5,s4
    80004b6a:	03997263          	bgeu	s2,s9,80004b8e <exec+0x14a>
    pa = walkaddr(pagetable, va + i);
    80004b6e:	02091593          	slli	a1,s2,0x20
    80004b72:	9181                	srli	a1,a1,0x20
    80004b74:	95ea                	add	a1,a1,s10
    80004b76:	8562                	mv	a0,s8
    80004b78:	ffffc097          	auipc	ra,0xffffc
    80004b7c:	532080e7          	jalr	1330(ra) # 800010aa <walkaddr>
    80004b80:	862a                	mv	a2,a0
    if(pa == 0)
    80004b82:	d955                	beqz	a0,80004b36 <exec+0xf2>
      n = PGSIZE;
    80004b84:	8ada                	mv	s5,s6
    if(sz - i < PGSIZE)
    80004b86:	fd6a70e3          	bgeu	s4,s6,80004b46 <exec+0x102>
      n = sz - i;
    80004b8a:	8ad2                	mv	s5,s4
    80004b8c:	bf6d                	j	80004b46 <exec+0x102>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004b8e:	2b85                	addiw	s7,s7,1
    80004b90:	0389899b          	addiw	s3,s3,56
    80004b94:	e8045783          	lhu	a5,-384(s0)
    80004b98:	06fbde63          	bge	s7,a5,80004c14 <exec+0x1d0>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004b9c:	2981                	sext.w	s3,s3
    80004b9e:	03800713          	li	a4,56
    80004ba2:	86ce                	mv	a3,s3
    80004ba4:	e1040613          	addi	a2,s0,-496
    80004ba8:	4581                	li	a1,0
    80004baa:	8526                	mv	a0,s1
    80004bac:	fffff097          	auipc	ra,0xfffff
    80004bb0:	c1e080e7          	jalr	-994(ra) # 800037ca <readi>
    80004bb4:	03800793          	li	a5,56
    80004bb8:	0af51263          	bne	a0,a5,80004c5c <exec+0x218>
    if(ph.type != ELF_PROG_LOAD)
    80004bbc:	e1042783          	lw	a5,-496(s0)
    80004bc0:	4705                	li	a4,1
    80004bc2:	fce796e3          	bne	a5,a4,80004b8e <exec+0x14a>
    if(ph.memsz < ph.filesz)
    80004bc6:	e3843603          	ld	a2,-456(s0)
    80004bca:	e3043783          	ld	a5,-464(s0)
    80004bce:	08f66763          	bltu	a2,a5,80004c5c <exec+0x218>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004bd2:	e2043783          	ld	a5,-480(s0)
    80004bd6:	963e                	add	a2,a2,a5
    80004bd8:	08f66263          	bltu	a2,a5,80004c5c <exec+0x218>
    if((sz = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004bdc:	e0843583          	ld	a1,-504(s0)
    80004be0:	8562                	mv	a0,s8
    80004be2:	ffffd097          	auipc	ra,0xffffd
    80004be6:	8bc080e7          	jalr	-1860(ra) # 8000149e <uvmalloc>
    80004bea:	e0a43423          	sd	a0,-504(s0)
    80004bee:	c53d                	beqz	a0,80004c5c <exec+0x218>
    if(ph.vaddr % PGSIZE != 0)
    80004bf0:	e2043d03          	ld	s10,-480(s0)
    80004bf4:	df043783          	ld	a5,-528(s0)
    80004bf8:	00fd77b3          	and	a5,s10,a5
    80004bfc:	e3a5                	bnez	a5,80004c5c <exec+0x218>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004bfe:	e1842d83          	lw	s11,-488(s0)
    80004c02:	e3042c83          	lw	s9,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004c06:	f80c84e3          	beqz	s9,80004b8e <exec+0x14a>
    80004c0a:	8a66                	mv	s4,s9
    80004c0c:	4901                	li	s2,0
    80004c0e:	b785                	j	80004b6e <exec+0x12a>
  sz = 0;
    80004c10:	e0043423          	sd	zero,-504(s0)
  iunlockput(ip);
    80004c14:	8526                	mv	a0,s1
    80004c16:	fffff097          	auipc	ra,0xfffff
    80004c1a:	b62080e7          	jalr	-1182(ra) # 80003778 <iunlockput>
  end_op();
    80004c1e:	fffff097          	auipc	ra,0xfffff
    80004c22:	332080e7          	jalr	818(ra) # 80003f50 <end_op>
  p = myproc();
    80004c26:	ffffd097          	auipc	ra,0xffffd
    80004c2a:	d5e080e7          	jalr	-674(ra) # 80001984 <myproc>
    80004c2e:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004c30:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004c34:	6585                	lui	a1,0x1
    80004c36:	15fd                	addi	a1,a1,-1
    80004c38:	e0843783          	ld	a5,-504(s0)
    80004c3c:	00b78b33          	add	s6,a5,a1
    80004c40:	75fd                	lui	a1,0xfffff
    80004c42:	00bb75b3          	and	a1,s6,a1
  if((sz = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004c46:	6609                	lui	a2,0x2
    80004c48:	962e                	add	a2,a2,a1
    80004c4a:	8562                	mv	a0,s8
    80004c4c:	ffffd097          	auipc	ra,0xffffd
    80004c50:	852080e7          	jalr	-1966(ra) # 8000149e <uvmalloc>
    80004c54:	e0a43423          	sd	a0,-504(s0)
  ip = 0;
    80004c58:	4481                	li	s1,0
  if((sz = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004c5a:	ed01                	bnez	a0,80004c72 <exec+0x22e>
    proc_freepagetable(pagetable, sz);
    80004c5c:	e0843583          	ld	a1,-504(s0)
    80004c60:	8562                	mv	a0,s8
    80004c62:	ffffd097          	auipc	ra,0xffffd
    80004c66:	ee6080e7          	jalr	-282(ra) # 80001b48 <proc_freepagetable>
  if(ip){
    80004c6a:	e4049fe3          	bnez	s1,80004ac8 <exec+0x84>
  return -1;
    80004c6e:	557d                	li	a0,-1
    80004c70:	b5b5                	j	80004adc <exec+0x98>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004c72:	75f9                	lui	a1,0xffffe
    80004c74:	84aa                	mv	s1,a0
    80004c76:	95aa                	add	a1,a1,a0
    80004c78:	8562                	mv	a0,s8
    80004c7a:	ffffd097          	auipc	ra,0xffffd
    80004c7e:	9cc080e7          	jalr	-1588(ra) # 80001646 <uvmclear>
  stackbase = sp - PGSIZE;
    80004c82:	7afd                	lui	s5,0xfffff
    80004c84:	9aa6                	add	s5,s5,s1
  for(argc = 0; argv[argc]; argc++) {
    80004c86:	e0043783          	ld	a5,-512(s0)
    80004c8a:	6388                	ld	a0,0(a5)
    80004c8c:	c135                	beqz	a0,80004cf0 <exec+0x2ac>
    80004c8e:	e8840993          	addi	s3,s0,-376
    80004c92:	f8840c93          	addi	s9,s0,-120
    80004c96:	4901                	li	s2,0
    sp -= strlen(argv[argc]) + 1;
    80004c98:	ffffc097          	auipc	ra,0xffffc
    80004c9c:	05e080e7          	jalr	94(ra) # 80000cf6 <strlen>
    80004ca0:	2505                	addiw	a0,a0,1
    80004ca2:	8c89                	sub	s1,s1,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004ca4:	98c1                	andi	s1,s1,-16
    if(sp < stackbase)
    80004ca6:	0f54ea63          	bltu	s1,s5,80004d9a <exec+0x356>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004caa:	e0043b03          	ld	s6,-512(s0)
    80004cae:	000b3a03          	ld	s4,0(s6)
    80004cb2:	8552                	mv	a0,s4
    80004cb4:	ffffc097          	auipc	ra,0xffffc
    80004cb8:	042080e7          	jalr	66(ra) # 80000cf6 <strlen>
    80004cbc:	0015069b          	addiw	a3,a0,1
    80004cc0:	8652                	mv	a2,s4
    80004cc2:	85a6                	mv	a1,s1
    80004cc4:	8562                	mv	a0,s8
    80004cc6:	ffffd097          	auipc	ra,0xffffd
    80004cca:	9b2080e7          	jalr	-1614(ra) # 80001678 <copyout>
    80004cce:	0c054863          	bltz	a0,80004d9e <exec+0x35a>
    ustack[argc] = sp;
    80004cd2:	0099b023          	sd	s1,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004cd6:	0905                	addi	s2,s2,1
    80004cd8:	008b0793          	addi	a5,s6,8
    80004cdc:	e0f43023          	sd	a5,-512(s0)
    80004ce0:	008b3503          	ld	a0,8(s6)
    80004ce4:	c909                	beqz	a0,80004cf6 <exec+0x2b2>
    if(argc >= MAXARG)
    80004ce6:	09a1                	addi	s3,s3,8
    80004ce8:	fb3c98e3          	bne	s9,s3,80004c98 <exec+0x254>
  ip = 0;
    80004cec:	4481                	li	s1,0
    80004cee:	b7bd                	j	80004c5c <exec+0x218>
  sp = sz;
    80004cf0:	e0843483          	ld	s1,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80004cf4:	4901                	li	s2,0
  ustack[argc] = 0;
    80004cf6:	00391793          	slli	a5,s2,0x3
    80004cfa:	f9040713          	addi	a4,s0,-112
    80004cfe:	97ba                	add	a5,a5,a4
    80004d00:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <end+0xffffffff7ffd8edc>
  sp -= (argc+1) * sizeof(uint64);
    80004d04:	00190693          	addi	a3,s2,1
    80004d08:	068e                	slli	a3,a3,0x3
    80004d0a:	8c95                	sub	s1,s1,a3
  sp -= sp % 16;
    80004d0c:	ff04f993          	andi	s3,s1,-16
  ip = 0;
    80004d10:	4481                	li	s1,0
  if(sp < stackbase)
    80004d12:	f559e5e3          	bltu	s3,s5,80004c5c <exec+0x218>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004d16:	e8840613          	addi	a2,s0,-376
    80004d1a:	85ce                	mv	a1,s3
    80004d1c:	8562                	mv	a0,s8
    80004d1e:	ffffd097          	auipc	ra,0xffffd
    80004d22:	95a080e7          	jalr	-1702(ra) # 80001678 <copyout>
    80004d26:	06054e63          	bltz	a0,80004da2 <exec+0x35e>
  p->tf->a1 = sp;
    80004d2a:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80004d2e:	0737bc23          	sd	s3,120(a5)
  for(last=s=path; *s; s++)
    80004d32:	df843783          	ld	a5,-520(s0)
    80004d36:	0007c703          	lbu	a4,0(a5)
    80004d3a:	cf11                	beqz	a4,80004d56 <exec+0x312>
    80004d3c:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004d3e:	02f00693          	li	a3,47
    80004d42:	a029                	j	80004d4c <exec+0x308>
  for(last=s=path; *s; s++)
    80004d44:	0785                	addi	a5,a5,1
    80004d46:	fff7c703          	lbu	a4,-1(a5)
    80004d4a:	c711                	beqz	a4,80004d56 <exec+0x312>
    if(*s == '/')
    80004d4c:	fed71ce3          	bne	a4,a3,80004d44 <exec+0x300>
      last = s+1;
    80004d50:	def43c23          	sd	a5,-520(s0)
    80004d54:	bfc5                	j	80004d44 <exec+0x300>
  safestrcpy(p->name, last, sizeof(p->name));
    80004d56:	4641                	li	a2,16
    80004d58:	df843583          	ld	a1,-520(s0)
    80004d5c:	158b8513          	addi	a0,s7,344
    80004d60:	ffffc097          	auipc	ra,0xffffc
    80004d64:	f64080e7          	jalr	-156(ra) # 80000cc4 <safestrcpy>
  oldpagetable = p->pagetable;
    80004d68:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004d6c:	058bb823          	sd	s8,80(s7)
  p->sz = sz;
    80004d70:	e0843783          	ld	a5,-504(s0)
    80004d74:	04fbb423          	sd	a5,72(s7)
  p->tf->epc = elf.entry;  // initial program counter = main
    80004d78:	058bb783          	ld	a5,88(s7)
    80004d7c:	e6043703          	ld	a4,-416(s0)
    80004d80:	ef98                	sd	a4,24(a5)
  p->tf->sp = sp; // initial stack pointer
    80004d82:	058bb783          	ld	a5,88(s7)
    80004d86:	0337b823          	sd	s3,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004d8a:	85ea                	mv	a1,s10
    80004d8c:	ffffd097          	auipc	ra,0xffffd
    80004d90:	dbc080e7          	jalr	-580(ra) # 80001b48 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004d94:	0009051b          	sext.w	a0,s2
    80004d98:	b391                	j	80004adc <exec+0x98>
  ip = 0;
    80004d9a:	4481                	li	s1,0
    80004d9c:	b5c1                	j	80004c5c <exec+0x218>
    80004d9e:	4481                	li	s1,0
    80004da0:	bd75                	j	80004c5c <exec+0x218>
    80004da2:	4481                	li	s1,0
    80004da4:	bd65                	j	80004c5c <exec+0x218>

0000000080004da6 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004da6:	7179                	addi	sp,sp,-48
    80004da8:	f406                	sd	ra,40(sp)
    80004daa:	f022                	sd	s0,32(sp)
    80004dac:	ec26                	sd	s1,24(sp)
    80004dae:	e84a                	sd	s2,16(sp)
    80004db0:	1800                	addi	s0,sp,48
    80004db2:	892e                	mv	s2,a1
    80004db4:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004db6:	fdc40593          	addi	a1,s0,-36
    80004dba:	ffffe097          	auipc	ra,0xffffe
    80004dbe:	c0e080e7          	jalr	-1010(ra) # 800029c8 <argint>
    80004dc2:	04054063          	bltz	a0,80004e02 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004dc6:	fdc42703          	lw	a4,-36(s0)
    80004dca:	47bd                	li	a5,15
    80004dcc:	02e7ed63          	bltu	a5,a4,80004e06 <argfd+0x60>
    80004dd0:	ffffd097          	auipc	ra,0xffffd
    80004dd4:	bb4080e7          	jalr	-1100(ra) # 80001984 <myproc>
    80004dd8:	fdc42703          	lw	a4,-36(s0)
    80004ddc:	01a70793          	addi	a5,a4,26
    80004de0:	078e                	slli	a5,a5,0x3
    80004de2:	953e                	add	a0,a0,a5
    80004de4:	611c                	ld	a5,0(a0)
    80004de6:	c395                	beqz	a5,80004e0a <argfd+0x64>
    return -1;
  if(pfd)
    80004de8:	00090463          	beqz	s2,80004df0 <argfd+0x4a>
    *pfd = fd;
    80004dec:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004df0:	4501                	li	a0,0
  if(pf)
    80004df2:	c091                	beqz	s1,80004df6 <argfd+0x50>
    *pf = f;
    80004df4:	e09c                	sd	a5,0(s1)
}
    80004df6:	70a2                	ld	ra,40(sp)
    80004df8:	7402                	ld	s0,32(sp)
    80004dfa:	64e2                	ld	s1,24(sp)
    80004dfc:	6942                	ld	s2,16(sp)
    80004dfe:	6145                	addi	sp,sp,48
    80004e00:	8082                	ret
    return -1;
    80004e02:	557d                	li	a0,-1
    80004e04:	bfcd                	j	80004df6 <argfd+0x50>
    return -1;
    80004e06:	557d                	li	a0,-1
    80004e08:	b7fd                	j	80004df6 <argfd+0x50>
    80004e0a:	557d                	li	a0,-1
    80004e0c:	b7ed                	j	80004df6 <argfd+0x50>

0000000080004e0e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004e0e:	1101                	addi	sp,sp,-32
    80004e10:	ec06                	sd	ra,24(sp)
    80004e12:	e822                	sd	s0,16(sp)
    80004e14:	e426                	sd	s1,8(sp)
    80004e16:	1000                	addi	s0,sp,32
    80004e18:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004e1a:	ffffd097          	auipc	ra,0xffffd
    80004e1e:	b6a080e7          	jalr	-1174(ra) # 80001984 <myproc>
    80004e22:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004e24:	0d050793          	addi	a5,a0,208
    80004e28:	4501                	li	a0,0
    80004e2a:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004e2c:	6398                	ld	a4,0(a5)
    80004e2e:	cb19                	beqz	a4,80004e44 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004e30:	2505                	addiw	a0,a0,1
    80004e32:	07a1                	addi	a5,a5,8
    80004e34:	fed51ce3          	bne	a0,a3,80004e2c <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004e38:	557d                	li	a0,-1
}
    80004e3a:	60e2                	ld	ra,24(sp)
    80004e3c:	6442                	ld	s0,16(sp)
    80004e3e:	64a2                	ld	s1,8(sp)
    80004e40:	6105                	addi	sp,sp,32
    80004e42:	8082                	ret
      p->ofile[fd] = f;
    80004e44:	01a50793          	addi	a5,a0,26
    80004e48:	078e                	slli	a5,a5,0x3
    80004e4a:	963e                	add	a2,a2,a5
    80004e4c:	e204                	sd	s1,0(a2)
      return fd;
    80004e4e:	b7f5                	j	80004e3a <fdalloc+0x2c>

0000000080004e50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004e50:	715d                	addi	sp,sp,-80
    80004e52:	e486                	sd	ra,72(sp)
    80004e54:	e0a2                	sd	s0,64(sp)
    80004e56:	fc26                	sd	s1,56(sp)
    80004e58:	f84a                	sd	s2,48(sp)
    80004e5a:	f44e                	sd	s3,40(sp)
    80004e5c:	f052                	sd	s4,32(sp)
    80004e5e:	ec56                	sd	s5,24(sp)
    80004e60:	0880                	addi	s0,sp,80
    80004e62:	89ae                	mv	s3,a1
    80004e64:	8ab2                	mv	s5,a2
    80004e66:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004e68:	fb040593          	addi	a1,s0,-80
    80004e6c:	fffff097          	auipc	ra,0xfffff
    80004e70:	e76080e7          	jalr	-394(ra) # 80003ce2 <nameiparent>
    80004e74:	892a                	mv	s2,a0
    80004e76:	12050e63          	beqz	a0,80004fb2 <create+0x162>
    return 0;

  ilock(dp);
    80004e7a:	ffffe097          	auipc	ra,0xffffe
    80004e7e:	6c0080e7          	jalr	1728(ra) # 8000353a <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004e82:	4601                	li	a2,0
    80004e84:	fb040593          	addi	a1,s0,-80
    80004e88:	854a                	mv	a0,s2
    80004e8a:	fffff097          	auipc	ra,0xfffff
    80004e8e:	b68080e7          	jalr	-1176(ra) # 800039f2 <dirlookup>
    80004e92:	84aa                	mv	s1,a0
    80004e94:	c921                	beqz	a0,80004ee4 <create+0x94>
    iunlockput(dp);
    80004e96:	854a                	mv	a0,s2
    80004e98:	fffff097          	auipc	ra,0xfffff
    80004e9c:	8e0080e7          	jalr	-1824(ra) # 80003778 <iunlockput>
    ilock(ip);
    80004ea0:	8526                	mv	a0,s1
    80004ea2:	ffffe097          	auipc	ra,0xffffe
    80004ea6:	698080e7          	jalr	1688(ra) # 8000353a <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004eaa:	2981                	sext.w	s3,s3
    80004eac:	4789                	li	a5,2
    80004eae:	02f99463          	bne	s3,a5,80004ed6 <create+0x86>
    80004eb2:	0444d783          	lhu	a5,68(s1)
    80004eb6:	37f9                	addiw	a5,a5,-2
    80004eb8:	17c2                	slli	a5,a5,0x30
    80004eba:	93c1                	srli	a5,a5,0x30
    80004ebc:	4705                	li	a4,1
    80004ebe:	00f76c63          	bltu	a4,a5,80004ed6 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004ec2:	8526                	mv	a0,s1
    80004ec4:	60a6                	ld	ra,72(sp)
    80004ec6:	6406                	ld	s0,64(sp)
    80004ec8:	74e2                	ld	s1,56(sp)
    80004eca:	7942                	ld	s2,48(sp)
    80004ecc:	79a2                	ld	s3,40(sp)
    80004ece:	7a02                	ld	s4,32(sp)
    80004ed0:	6ae2                	ld	s5,24(sp)
    80004ed2:	6161                	addi	sp,sp,80
    80004ed4:	8082                	ret
    iunlockput(ip);
    80004ed6:	8526                	mv	a0,s1
    80004ed8:	fffff097          	auipc	ra,0xfffff
    80004edc:	8a0080e7          	jalr	-1888(ra) # 80003778 <iunlockput>
    return 0;
    80004ee0:	4481                	li	s1,0
    80004ee2:	b7c5                	j	80004ec2 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004ee4:	85ce                	mv	a1,s3
    80004ee6:	00092503          	lw	a0,0(s2)
    80004eea:	ffffe097          	auipc	ra,0xffffe
    80004eee:	4b8080e7          	jalr	1208(ra) # 800033a2 <ialloc>
    80004ef2:	84aa                	mv	s1,a0
    80004ef4:	c521                	beqz	a0,80004f3c <create+0xec>
  ilock(ip);
    80004ef6:	ffffe097          	auipc	ra,0xffffe
    80004efa:	644080e7          	jalr	1604(ra) # 8000353a <ilock>
  ip->major = major;
    80004efe:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80004f02:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80004f06:	4a05                	li	s4,1
    80004f08:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    80004f0c:	8526                	mv	a0,s1
    80004f0e:	ffffe097          	auipc	ra,0xffffe
    80004f12:	562080e7          	jalr	1378(ra) # 80003470 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004f16:	2981                	sext.w	s3,s3
    80004f18:	03498a63          	beq	s3,s4,80004f4c <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    80004f1c:	40d0                	lw	a2,4(s1)
    80004f1e:	fb040593          	addi	a1,s0,-80
    80004f22:	854a                	mv	a0,s2
    80004f24:	fffff097          	auipc	ra,0xfffff
    80004f28:	cde080e7          	jalr	-802(ra) # 80003c02 <dirlink>
    80004f2c:	06054b63          	bltz	a0,80004fa2 <create+0x152>
  iunlockput(dp);
    80004f30:	854a                	mv	a0,s2
    80004f32:	fffff097          	auipc	ra,0xfffff
    80004f36:	846080e7          	jalr	-1978(ra) # 80003778 <iunlockput>
  return ip;
    80004f3a:	b761                	j	80004ec2 <create+0x72>
    panic("create: ialloc");
    80004f3c:	00003517          	auipc	a0,0x3
    80004f40:	b0450513          	addi	a0,a0,-1276 # 80007a40 <userret+0x9b0>
    80004f44:	ffffb097          	auipc	ra,0xffffb
    80004f48:	60a080e7          	jalr	1546(ra) # 8000054e <panic>
    dp->nlink++;  // for ".."
    80004f4c:	04a95783          	lhu	a5,74(s2)
    80004f50:	2785                	addiw	a5,a5,1
    80004f52:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80004f56:	854a                	mv	a0,s2
    80004f58:	ffffe097          	auipc	ra,0xffffe
    80004f5c:	518080e7          	jalr	1304(ra) # 80003470 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004f60:	40d0                	lw	a2,4(s1)
    80004f62:	00003597          	auipc	a1,0x3
    80004f66:	aee58593          	addi	a1,a1,-1298 # 80007a50 <userret+0x9c0>
    80004f6a:	8526                	mv	a0,s1
    80004f6c:	fffff097          	auipc	ra,0xfffff
    80004f70:	c96080e7          	jalr	-874(ra) # 80003c02 <dirlink>
    80004f74:	00054f63          	bltz	a0,80004f92 <create+0x142>
    80004f78:	00492603          	lw	a2,4(s2)
    80004f7c:	00003597          	auipc	a1,0x3
    80004f80:	adc58593          	addi	a1,a1,-1316 # 80007a58 <userret+0x9c8>
    80004f84:	8526                	mv	a0,s1
    80004f86:	fffff097          	auipc	ra,0xfffff
    80004f8a:	c7c080e7          	jalr	-900(ra) # 80003c02 <dirlink>
    80004f8e:	f80557e3          	bgez	a0,80004f1c <create+0xcc>
      panic("create dots");
    80004f92:	00003517          	auipc	a0,0x3
    80004f96:	ace50513          	addi	a0,a0,-1330 # 80007a60 <userret+0x9d0>
    80004f9a:	ffffb097          	auipc	ra,0xffffb
    80004f9e:	5b4080e7          	jalr	1460(ra) # 8000054e <panic>
    panic("create: dirlink");
    80004fa2:	00003517          	auipc	a0,0x3
    80004fa6:	ace50513          	addi	a0,a0,-1330 # 80007a70 <userret+0x9e0>
    80004faa:	ffffb097          	auipc	ra,0xffffb
    80004fae:	5a4080e7          	jalr	1444(ra) # 8000054e <panic>
    return 0;
    80004fb2:	84aa                	mv	s1,a0
    80004fb4:	b739                	j	80004ec2 <create+0x72>

0000000080004fb6 <sys_dup>:
{
    80004fb6:	7179                	addi	sp,sp,-48
    80004fb8:	f406                	sd	ra,40(sp)
    80004fba:	f022                	sd	s0,32(sp)
    80004fbc:	ec26                	sd	s1,24(sp)
    80004fbe:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004fc0:	fd840613          	addi	a2,s0,-40
    80004fc4:	4581                	li	a1,0
    80004fc6:	4501                	li	a0,0
    80004fc8:	00000097          	auipc	ra,0x0
    80004fcc:	dde080e7          	jalr	-546(ra) # 80004da6 <argfd>
    return -1;
    80004fd0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004fd2:	02054363          	bltz	a0,80004ff8 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004fd6:	fd843503          	ld	a0,-40(s0)
    80004fda:	00000097          	auipc	ra,0x0
    80004fde:	e34080e7          	jalr	-460(ra) # 80004e0e <fdalloc>
    80004fe2:	84aa                	mv	s1,a0
    return -1;
    80004fe4:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004fe6:	00054963          	bltz	a0,80004ff8 <sys_dup+0x42>
  filedup(f);
    80004fea:	fd843503          	ld	a0,-40(s0)
    80004fee:	fffff097          	auipc	ra,0xfffff
    80004ff2:	362080e7          	jalr	866(ra) # 80004350 <filedup>
  return fd;
    80004ff6:	87a6                	mv	a5,s1
}
    80004ff8:	853e                	mv	a0,a5
    80004ffa:	70a2                	ld	ra,40(sp)
    80004ffc:	7402                	ld	s0,32(sp)
    80004ffe:	64e2                	ld	s1,24(sp)
    80005000:	6145                	addi	sp,sp,48
    80005002:	8082                	ret

0000000080005004 <sys_read>:
{
    80005004:	7179                	addi	sp,sp,-48
    80005006:	f406                	sd	ra,40(sp)
    80005008:	f022                	sd	s0,32(sp)
    8000500a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000500c:	fe840613          	addi	a2,s0,-24
    80005010:	4581                	li	a1,0
    80005012:	4501                	li	a0,0
    80005014:	00000097          	auipc	ra,0x0
    80005018:	d92080e7          	jalr	-622(ra) # 80004da6 <argfd>
    return -1;
    8000501c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000501e:	04054163          	bltz	a0,80005060 <sys_read+0x5c>
    80005022:	fe440593          	addi	a1,s0,-28
    80005026:	4509                	li	a0,2
    80005028:	ffffe097          	auipc	ra,0xffffe
    8000502c:	9a0080e7          	jalr	-1632(ra) # 800029c8 <argint>
    return -1;
    80005030:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005032:	02054763          	bltz	a0,80005060 <sys_read+0x5c>
    80005036:	fd840593          	addi	a1,s0,-40
    8000503a:	4505                	li	a0,1
    8000503c:	ffffe097          	auipc	ra,0xffffe
    80005040:	9ae080e7          	jalr	-1618(ra) # 800029ea <argaddr>
    return -1;
    80005044:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005046:	00054d63          	bltz	a0,80005060 <sys_read+0x5c>
  return fileread(f, p, n);
    8000504a:	fe442603          	lw	a2,-28(s0)
    8000504e:	fd843583          	ld	a1,-40(s0)
    80005052:	fe843503          	ld	a0,-24(s0)
    80005056:	fffff097          	auipc	ra,0xfffff
    8000505a:	486080e7          	jalr	1158(ra) # 800044dc <fileread>
    8000505e:	87aa                	mv	a5,a0
}
    80005060:	853e                	mv	a0,a5
    80005062:	70a2                	ld	ra,40(sp)
    80005064:	7402                	ld	s0,32(sp)
    80005066:	6145                	addi	sp,sp,48
    80005068:	8082                	ret

000000008000506a <sys_write>:
{
    8000506a:	7179                	addi	sp,sp,-48
    8000506c:	f406                	sd	ra,40(sp)
    8000506e:	f022                	sd	s0,32(sp)
    80005070:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005072:	fe840613          	addi	a2,s0,-24
    80005076:	4581                	li	a1,0
    80005078:	4501                	li	a0,0
    8000507a:	00000097          	auipc	ra,0x0
    8000507e:	d2c080e7          	jalr	-724(ra) # 80004da6 <argfd>
    return -1;
    80005082:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005084:	04054163          	bltz	a0,800050c6 <sys_write+0x5c>
    80005088:	fe440593          	addi	a1,s0,-28
    8000508c:	4509                	li	a0,2
    8000508e:	ffffe097          	auipc	ra,0xffffe
    80005092:	93a080e7          	jalr	-1734(ra) # 800029c8 <argint>
    return -1;
    80005096:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005098:	02054763          	bltz	a0,800050c6 <sys_write+0x5c>
    8000509c:	fd840593          	addi	a1,s0,-40
    800050a0:	4505                	li	a0,1
    800050a2:	ffffe097          	auipc	ra,0xffffe
    800050a6:	948080e7          	jalr	-1720(ra) # 800029ea <argaddr>
    return -1;
    800050aa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800050ac:	00054d63          	bltz	a0,800050c6 <sys_write+0x5c>
  return filewrite(f, p, n);
    800050b0:	fe442603          	lw	a2,-28(s0)
    800050b4:	fd843583          	ld	a1,-40(s0)
    800050b8:	fe843503          	ld	a0,-24(s0)
    800050bc:	fffff097          	auipc	ra,0xfffff
    800050c0:	4e2080e7          	jalr	1250(ra) # 8000459e <filewrite>
    800050c4:	87aa                	mv	a5,a0
}
    800050c6:	853e                	mv	a0,a5
    800050c8:	70a2                	ld	ra,40(sp)
    800050ca:	7402                	ld	s0,32(sp)
    800050cc:	6145                	addi	sp,sp,48
    800050ce:	8082                	ret

00000000800050d0 <sys_close>:
{
    800050d0:	1101                	addi	sp,sp,-32
    800050d2:	ec06                	sd	ra,24(sp)
    800050d4:	e822                	sd	s0,16(sp)
    800050d6:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800050d8:	fe040613          	addi	a2,s0,-32
    800050dc:	fec40593          	addi	a1,s0,-20
    800050e0:	4501                	li	a0,0
    800050e2:	00000097          	auipc	ra,0x0
    800050e6:	cc4080e7          	jalr	-828(ra) # 80004da6 <argfd>
    return -1;
    800050ea:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800050ec:	02054463          	bltz	a0,80005114 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800050f0:	ffffd097          	auipc	ra,0xffffd
    800050f4:	894080e7          	jalr	-1900(ra) # 80001984 <myproc>
    800050f8:	fec42783          	lw	a5,-20(s0)
    800050fc:	07e9                	addi	a5,a5,26
    800050fe:	078e                	slli	a5,a5,0x3
    80005100:	97aa                	add	a5,a5,a0
    80005102:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80005106:	fe043503          	ld	a0,-32(s0)
    8000510a:	fffff097          	auipc	ra,0xfffff
    8000510e:	298080e7          	jalr	664(ra) # 800043a2 <fileclose>
  return 0;
    80005112:	4781                	li	a5,0
}
    80005114:	853e                	mv	a0,a5
    80005116:	60e2                	ld	ra,24(sp)
    80005118:	6442                	ld	s0,16(sp)
    8000511a:	6105                	addi	sp,sp,32
    8000511c:	8082                	ret

000000008000511e <sys_fstat>:
{
    8000511e:	1101                	addi	sp,sp,-32
    80005120:	ec06                	sd	ra,24(sp)
    80005122:	e822                	sd	s0,16(sp)
    80005124:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005126:	fe840613          	addi	a2,s0,-24
    8000512a:	4581                	li	a1,0
    8000512c:	4501                	li	a0,0
    8000512e:	00000097          	auipc	ra,0x0
    80005132:	c78080e7          	jalr	-904(ra) # 80004da6 <argfd>
    return -1;
    80005136:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005138:	02054563          	bltz	a0,80005162 <sys_fstat+0x44>
    8000513c:	fe040593          	addi	a1,s0,-32
    80005140:	4505                	li	a0,1
    80005142:	ffffe097          	auipc	ra,0xffffe
    80005146:	8a8080e7          	jalr	-1880(ra) # 800029ea <argaddr>
    return -1;
    8000514a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000514c:	00054b63          	bltz	a0,80005162 <sys_fstat+0x44>
  return filestat(f, st);
    80005150:	fe043583          	ld	a1,-32(s0)
    80005154:	fe843503          	ld	a0,-24(s0)
    80005158:	fffff097          	auipc	ra,0xfffff
    8000515c:	312080e7          	jalr	786(ra) # 8000446a <filestat>
    80005160:	87aa                	mv	a5,a0
}
    80005162:	853e                	mv	a0,a5
    80005164:	60e2                	ld	ra,24(sp)
    80005166:	6442                	ld	s0,16(sp)
    80005168:	6105                	addi	sp,sp,32
    8000516a:	8082                	ret

000000008000516c <sys_link>:
{
    8000516c:	7169                	addi	sp,sp,-304
    8000516e:	f606                	sd	ra,296(sp)
    80005170:	f222                	sd	s0,288(sp)
    80005172:	ee26                	sd	s1,280(sp)
    80005174:	ea4a                	sd	s2,272(sp)
    80005176:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005178:	08000613          	li	a2,128
    8000517c:	ed040593          	addi	a1,s0,-304
    80005180:	4501                	li	a0,0
    80005182:	ffffe097          	auipc	ra,0xffffe
    80005186:	88a080e7          	jalr	-1910(ra) # 80002a0c <argstr>
    return -1;
    8000518a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000518c:	10054e63          	bltz	a0,800052a8 <sys_link+0x13c>
    80005190:	08000613          	li	a2,128
    80005194:	f5040593          	addi	a1,s0,-176
    80005198:	4505                	li	a0,1
    8000519a:	ffffe097          	auipc	ra,0xffffe
    8000519e:	872080e7          	jalr	-1934(ra) # 80002a0c <argstr>
    return -1;
    800051a2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800051a4:	10054263          	bltz	a0,800052a8 <sys_link+0x13c>
  begin_op();
    800051a8:	fffff097          	auipc	ra,0xfffff
    800051ac:	d28080e7          	jalr	-728(ra) # 80003ed0 <begin_op>
  if((ip = namei(old)) == 0){
    800051b0:	ed040513          	addi	a0,s0,-304
    800051b4:	fffff097          	auipc	ra,0xfffff
    800051b8:	b10080e7          	jalr	-1264(ra) # 80003cc4 <namei>
    800051bc:	84aa                	mv	s1,a0
    800051be:	c551                	beqz	a0,8000524a <sys_link+0xde>
  ilock(ip);
    800051c0:	ffffe097          	auipc	ra,0xffffe
    800051c4:	37a080e7          	jalr	890(ra) # 8000353a <ilock>
  if(ip->type == T_DIR){
    800051c8:	04449703          	lh	a4,68(s1)
    800051cc:	4785                	li	a5,1
    800051ce:	08f70463          	beq	a4,a5,80005256 <sys_link+0xea>
  ip->nlink++;
    800051d2:	04a4d783          	lhu	a5,74(s1)
    800051d6:	2785                	addiw	a5,a5,1
    800051d8:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800051dc:	8526                	mv	a0,s1
    800051de:	ffffe097          	auipc	ra,0xffffe
    800051e2:	292080e7          	jalr	658(ra) # 80003470 <iupdate>
  iunlock(ip);
    800051e6:	8526                	mv	a0,s1
    800051e8:	ffffe097          	auipc	ra,0xffffe
    800051ec:	414080e7          	jalr	1044(ra) # 800035fc <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800051f0:	fd040593          	addi	a1,s0,-48
    800051f4:	f5040513          	addi	a0,s0,-176
    800051f8:	fffff097          	auipc	ra,0xfffff
    800051fc:	aea080e7          	jalr	-1302(ra) # 80003ce2 <nameiparent>
    80005200:	892a                	mv	s2,a0
    80005202:	c935                	beqz	a0,80005276 <sys_link+0x10a>
  ilock(dp);
    80005204:	ffffe097          	auipc	ra,0xffffe
    80005208:	336080e7          	jalr	822(ra) # 8000353a <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000520c:	00092703          	lw	a4,0(s2)
    80005210:	409c                	lw	a5,0(s1)
    80005212:	04f71d63          	bne	a4,a5,8000526c <sys_link+0x100>
    80005216:	40d0                	lw	a2,4(s1)
    80005218:	fd040593          	addi	a1,s0,-48
    8000521c:	854a                	mv	a0,s2
    8000521e:	fffff097          	auipc	ra,0xfffff
    80005222:	9e4080e7          	jalr	-1564(ra) # 80003c02 <dirlink>
    80005226:	04054363          	bltz	a0,8000526c <sys_link+0x100>
  iunlockput(dp);
    8000522a:	854a                	mv	a0,s2
    8000522c:	ffffe097          	auipc	ra,0xffffe
    80005230:	54c080e7          	jalr	1356(ra) # 80003778 <iunlockput>
  iput(ip);
    80005234:	8526                	mv	a0,s1
    80005236:	ffffe097          	auipc	ra,0xffffe
    8000523a:	412080e7          	jalr	1042(ra) # 80003648 <iput>
  end_op();
    8000523e:	fffff097          	auipc	ra,0xfffff
    80005242:	d12080e7          	jalr	-750(ra) # 80003f50 <end_op>
  return 0;
    80005246:	4781                	li	a5,0
    80005248:	a085                	j	800052a8 <sys_link+0x13c>
    end_op();
    8000524a:	fffff097          	auipc	ra,0xfffff
    8000524e:	d06080e7          	jalr	-762(ra) # 80003f50 <end_op>
    return -1;
    80005252:	57fd                	li	a5,-1
    80005254:	a891                	j	800052a8 <sys_link+0x13c>
    iunlockput(ip);
    80005256:	8526                	mv	a0,s1
    80005258:	ffffe097          	auipc	ra,0xffffe
    8000525c:	520080e7          	jalr	1312(ra) # 80003778 <iunlockput>
    end_op();
    80005260:	fffff097          	auipc	ra,0xfffff
    80005264:	cf0080e7          	jalr	-784(ra) # 80003f50 <end_op>
    return -1;
    80005268:	57fd                	li	a5,-1
    8000526a:	a83d                	j	800052a8 <sys_link+0x13c>
    iunlockput(dp);
    8000526c:	854a                	mv	a0,s2
    8000526e:	ffffe097          	auipc	ra,0xffffe
    80005272:	50a080e7          	jalr	1290(ra) # 80003778 <iunlockput>
  ilock(ip);
    80005276:	8526                	mv	a0,s1
    80005278:	ffffe097          	auipc	ra,0xffffe
    8000527c:	2c2080e7          	jalr	706(ra) # 8000353a <ilock>
  ip->nlink--;
    80005280:	04a4d783          	lhu	a5,74(s1)
    80005284:	37fd                	addiw	a5,a5,-1
    80005286:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000528a:	8526                	mv	a0,s1
    8000528c:	ffffe097          	auipc	ra,0xffffe
    80005290:	1e4080e7          	jalr	484(ra) # 80003470 <iupdate>
  iunlockput(ip);
    80005294:	8526                	mv	a0,s1
    80005296:	ffffe097          	auipc	ra,0xffffe
    8000529a:	4e2080e7          	jalr	1250(ra) # 80003778 <iunlockput>
  end_op();
    8000529e:	fffff097          	auipc	ra,0xfffff
    800052a2:	cb2080e7          	jalr	-846(ra) # 80003f50 <end_op>
  return -1;
    800052a6:	57fd                	li	a5,-1
}
    800052a8:	853e                	mv	a0,a5
    800052aa:	70b2                	ld	ra,296(sp)
    800052ac:	7412                	ld	s0,288(sp)
    800052ae:	64f2                	ld	s1,280(sp)
    800052b0:	6952                	ld	s2,272(sp)
    800052b2:	6155                	addi	sp,sp,304
    800052b4:	8082                	ret

00000000800052b6 <sys_unlink>:
{
    800052b6:	7151                	addi	sp,sp,-240
    800052b8:	f586                	sd	ra,232(sp)
    800052ba:	f1a2                	sd	s0,224(sp)
    800052bc:	eda6                	sd	s1,216(sp)
    800052be:	e9ca                	sd	s2,208(sp)
    800052c0:	e5ce                	sd	s3,200(sp)
    800052c2:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800052c4:	08000613          	li	a2,128
    800052c8:	f3040593          	addi	a1,s0,-208
    800052cc:	4501                	li	a0,0
    800052ce:	ffffd097          	auipc	ra,0xffffd
    800052d2:	73e080e7          	jalr	1854(ra) # 80002a0c <argstr>
    800052d6:	18054163          	bltz	a0,80005458 <sys_unlink+0x1a2>
  begin_op();
    800052da:	fffff097          	auipc	ra,0xfffff
    800052de:	bf6080e7          	jalr	-1034(ra) # 80003ed0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800052e2:	fb040593          	addi	a1,s0,-80
    800052e6:	f3040513          	addi	a0,s0,-208
    800052ea:	fffff097          	auipc	ra,0xfffff
    800052ee:	9f8080e7          	jalr	-1544(ra) # 80003ce2 <nameiparent>
    800052f2:	84aa                	mv	s1,a0
    800052f4:	c979                	beqz	a0,800053ca <sys_unlink+0x114>
  ilock(dp);
    800052f6:	ffffe097          	auipc	ra,0xffffe
    800052fa:	244080e7          	jalr	580(ra) # 8000353a <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800052fe:	00002597          	auipc	a1,0x2
    80005302:	75258593          	addi	a1,a1,1874 # 80007a50 <userret+0x9c0>
    80005306:	fb040513          	addi	a0,s0,-80
    8000530a:	ffffe097          	auipc	ra,0xffffe
    8000530e:	6ce080e7          	jalr	1742(ra) # 800039d8 <namecmp>
    80005312:	14050a63          	beqz	a0,80005466 <sys_unlink+0x1b0>
    80005316:	00002597          	auipc	a1,0x2
    8000531a:	74258593          	addi	a1,a1,1858 # 80007a58 <userret+0x9c8>
    8000531e:	fb040513          	addi	a0,s0,-80
    80005322:	ffffe097          	auipc	ra,0xffffe
    80005326:	6b6080e7          	jalr	1718(ra) # 800039d8 <namecmp>
    8000532a:	12050e63          	beqz	a0,80005466 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000532e:	f2c40613          	addi	a2,s0,-212
    80005332:	fb040593          	addi	a1,s0,-80
    80005336:	8526                	mv	a0,s1
    80005338:	ffffe097          	auipc	ra,0xffffe
    8000533c:	6ba080e7          	jalr	1722(ra) # 800039f2 <dirlookup>
    80005340:	892a                	mv	s2,a0
    80005342:	12050263          	beqz	a0,80005466 <sys_unlink+0x1b0>
  ilock(ip);
    80005346:	ffffe097          	auipc	ra,0xffffe
    8000534a:	1f4080e7          	jalr	500(ra) # 8000353a <ilock>
  if(ip->nlink < 1)
    8000534e:	04a91783          	lh	a5,74(s2)
    80005352:	08f05263          	blez	a5,800053d6 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005356:	04491703          	lh	a4,68(s2)
    8000535a:	4785                	li	a5,1
    8000535c:	08f70563          	beq	a4,a5,800053e6 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80005360:	4641                	li	a2,16
    80005362:	4581                	li	a1,0
    80005364:	fc040513          	addi	a0,s0,-64
    80005368:	ffffc097          	auipc	ra,0xffffc
    8000536c:	806080e7          	jalr	-2042(ra) # 80000b6e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005370:	4741                	li	a4,16
    80005372:	f2c42683          	lw	a3,-212(s0)
    80005376:	fc040613          	addi	a2,s0,-64
    8000537a:	4581                	li	a1,0
    8000537c:	8526                	mv	a0,s1
    8000537e:	ffffe097          	auipc	ra,0xffffe
    80005382:	540080e7          	jalr	1344(ra) # 800038be <writei>
    80005386:	47c1                	li	a5,16
    80005388:	0af51563          	bne	a0,a5,80005432 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000538c:	04491703          	lh	a4,68(s2)
    80005390:	4785                	li	a5,1
    80005392:	0af70863          	beq	a4,a5,80005442 <sys_unlink+0x18c>
  iunlockput(dp);
    80005396:	8526                	mv	a0,s1
    80005398:	ffffe097          	auipc	ra,0xffffe
    8000539c:	3e0080e7          	jalr	992(ra) # 80003778 <iunlockput>
  ip->nlink--;
    800053a0:	04a95783          	lhu	a5,74(s2)
    800053a4:	37fd                	addiw	a5,a5,-1
    800053a6:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800053aa:	854a                	mv	a0,s2
    800053ac:	ffffe097          	auipc	ra,0xffffe
    800053b0:	0c4080e7          	jalr	196(ra) # 80003470 <iupdate>
  iunlockput(ip);
    800053b4:	854a                	mv	a0,s2
    800053b6:	ffffe097          	auipc	ra,0xffffe
    800053ba:	3c2080e7          	jalr	962(ra) # 80003778 <iunlockput>
  end_op();
    800053be:	fffff097          	auipc	ra,0xfffff
    800053c2:	b92080e7          	jalr	-1134(ra) # 80003f50 <end_op>
  return 0;
    800053c6:	4501                	li	a0,0
    800053c8:	a84d                	j	8000547a <sys_unlink+0x1c4>
    end_op();
    800053ca:	fffff097          	auipc	ra,0xfffff
    800053ce:	b86080e7          	jalr	-1146(ra) # 80003f50 <end_op>
    return -1;
    800053d2:	557d                	li	a0,-1
    800053d4:	a05d                	j	8000547a <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800053d6:	00002517          	auipc	a0,0x2
    800053da:	6aa50513          	addi	a0,a0,1706 # 80007a80 <userret+0x9f0>
    800053de:	ffffb097          	auipc	ra,0xffffb
    800053e2:	170080e7          	jalr	368(ra) # 8000054e <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800053e6:	04c92703          	lw	a4,76(s2)
    800053ea:	02000793          	li	a5,32
    800053ee:	f6e7f9e3          	bgeu	a5,a4,80005360 <sys_unlink+0xaa>
    800053f2:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800053f6:	4741                	li	a4,16
    800053f8:	86ce                	mv	a3,s3
    800053fa:	f1840613          	addi	a2,s0,-232
    800053fe:	4581                	li	a1,0
    80005400:	854a                	mv	a0,s2
    80005402:	ffffe097          	auipc	ra,0xffffe
    80005406:	3c8080e7          	jalr	968(ra) # 800037ca <readi>
    8000540a:	47c1                	li	a5,16
    8000540c:	00f51b63          	bne	a0,a5,80005422 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005410:	f1845783          	lhu	a5,-232(s0)
    80005414:	e7a1                	bnez	a5,8000545c <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005416:	29c1                	addiw	s3,s3,16
    80005418:	04c92783          	lw	a5,76(s2)
    8000541c:	fcf9ede3          	bltu	s3,a5,800053f6 <sys_unlink+0x140>
    80005420:	b781                	j	80005360 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005422:	00002517          	auipc	a0,0x2
    80005426:	67650513          	addi	a0,a0,1654 # 80007a98 <userret+0xa08>
    8000542a:	ffffb097          	auipc	ra,0xffffb
    8000542e:	124080e7          	jalr	292(ra) # 8000054e <panic>
    panic("unlink: writei");
    80005432:	00002517          	auipc	a0,0x2
    80005436:	67e50513          	addi	a0,a0,1662 # 80007ab0 <userret+0xa20>
    8000543a:	ffffb097          	auipc	ra,0xffffb
    8000543e:	114080e7          	jalr	276(ra) # 8000054e <panic>
    dp->nlink--;
    80005442:	04a4d783          	lhu	a5,74(s1)
    80005446:	37fd                	addiw	a5,a5,-1
    80005448:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000544c:	8526                	mv	a0,s1
    8000544e:	ffffe097          	auipc	ra,0xffffe
    80005452:	022080e7          	jalr	34(ra) # 80003470 <iupdate>
    80005456:	b781                	j	80005396 <sys_unlink+0xe0>
    return -1;
    80005458:	557d                	li	a0,-1
    8000545a:	a005                	j	8000547a <sys_unlink+0x1c4>
    iunlockput(ip);
    8000545c:	854a                	mv	a0,s2
    8000545e:	ffffe097          	auipc	ra,0xffffe
    80005462:	31a080e7          	jalr	794(ra) # 80003778 <iunlockput>
  iunlockput(dp);
    80005466:	8526                	mv	a0,s1
    80005468:	ffffe097          	auipc	ra,0xffffe
    8000546c:	310080e7          	jalr	784(ra) # 80003778 <iunlockput>
  end_op();
    80005470:	fffff097          	auipc	ra,0xfffff
    80005474:	ae0080e7          	jalr	-1312(ra) # 80003f50 <end_op>
  return -1;
    80005478:	557d                	li	a0,-1
}
    8000547a:	70ae                	ld	ra,232(sp)
    8000547c:	740e                	ld	s0,224(sp)
    8000547e:	64ee                	ld	s1,216(sp)
    80005480:	694e                	ld	s2,208(sp)
    80005482:	69ae                	ld	s3,200(sp)
    80005484:	616d                	addi	sp,sp,240
    80005486:	8082                	ret

0000000080005488 <sys_open>:

uint64
sys_open(void)
{
    80005488:	7131                	addi	sp,sp,-192
    8000548a:	fd06                	sd	ra,184(sp)
    8000548c:	f922                	sd	s0,176(sp)
    8000548e:	f526                	sd	s1,168(sp)
    80005490:	f14a                	sd	s2,160(sp)
    80005492:	ed4e                	sd	s3,152(sp)
    80005494:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005496:	08000613          	li	a2,128
    8000549a:	f5040593          	addi	a1,s0,-176
    8000549e:	4501                	li	a0,0
    800054a0:	ffffd097          	auipc	ra,0xffffd
    800054a4:	56c080e7          	jalr	1388(ra) # 80002a0c <argstr>
    return -1;
    800054a8:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800054aa:	0a054763          	bltz	a0,80005558 <sys_open+0xd0>
    800054ae:	f4c40593          	addi	a1,s0,-180
    800054b2:	4505                	li	a0,1
    800054b4:	ffffd097          	auipc	ra,0xffffd
    800054b8:	514080e7          	jalr	1300(ra) # 800029c8 <argint>
    800054bc:	08054e63          	bltz	a0,80005558 <sys_open+0xd0>

  begin_op();
    800054c0:	fffff097          	auipc	ra,0xfffff
    800054c4:	a10080e7          	jalr	-1520(ra) # 80003ed0 <begin_op>

  if(omode & O_CREATE){
    800054c8:	f4c42783          	lw	a5,-180(s0)
    800054cc:	2007f793          	andi	a5,a5,512
    800054d0:	c3cd                	beqz	a5,80005572 <sys_open+0xea>
    ip = create(path, T_FILE, 0, 0);
    800054d2:	4681                	li	a3,0
    800054d4:	4601                	li	a2,0
    800054d6:	4589                	li	a1,2
    800054d8:	f5040513          	addi	a0,s0,-176
    800054dc:	00000097          	auipc	ra,0x0
    800054e0:	974080e7          	jalr	-1676(ra) # 80004e50 <create>
    800054e4:	892a                	mv	s2,a0
    if(ip == 0){
    800054e6:	c149                	beqz	a0,80005568 <sys_open+0xe0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800054e8:	04491703          	lh	a4,68(s2)
    800054ec:	478d                	li	a5,3
    800054ee:	00f71763          	bne	a4,a5,800054fc <sys_open+0x74>
    800054f2:	04695703          	lhu	a4,70(s2)
    800054f6:	47a5                	li	a5,9
    800054f8:	0ce7e263          	bltu	a5,a4,800055bc <sys_open+0x134>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800054fc:	fffff097          	auipc	ra,0xfffff
    80005500:	dea080e7          	jalr	-534(ra) # 800042e6 <filealloc>
    80005504:	89aa                	mv	s3,a0
    80005506:	c175                	beqz	a0,800055ea <sys_open+0x162>
    80005508:	00000097          	auipc	ra,0x0
    8000550c:	906080e7          	jalr	-1786(ra) # 80004e0e <fdalloc>
    80005510:	84aa                	mv	s1,a0
    80005512:	0c054763          	bltz	a0,800055e0 <sys_open+0x158>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005516:	04491703          	lh	a4,68(s2)
    8000551a:	478d                	li	a5,3
    8000551c:	0af70b63          	beq	a4,a5,800055d2 <sys_open+0x14a>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005520:	4789                	li	a5,2
    80005522:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80005526:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    8000552a:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    8000552e:	f4c42783          	lw	a5,-180(s0)
    80005532:	0017c713          	xori	a4,a5,1
    80005536:	8b05                	andi	a4,a4,1
    80005538:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000553c:	8b8d                	andi	a5,a5,3
    8000553e:	00f037b3          	snez	a5,a5
    80005542:	00f984a3          	sb	a5,9(s3)

  iunlock(ip);
    80005546:	854a                	mv	a0,s2
    80005548:	ffffe097          	auipc	ra,0xffffe
    8000554c:	0b4080e7          	jalr	180(ra) # 800035fc <iunlock>
  end_op();
    80005550:	fffff097          	auipc	ra,0xfffff
    80005554:	a00080e7          	jalr	-1536(ra) # 80003f50 <end_op>

  return fd;
}
    80005558:	8526                	mv	a0,s1
    8000555a:	70ea                	ld	ra,184(sp)
    8000555c:	744a                	ld	s0,176(sp)
    8000555e:	74aa                	ld	s1,168(sp)
    80005560:	790a                	ld	s2,160(sp)
    80005562:	69ea                	ld	s3,152(sp)
    80005564:	6129                	addi	sp,sp,192
    80005566:	8082                	ret
      end_op();
    80005568:	fffff097          	auipc	ra,0xfffff
    8000556c:	9e8080e7          	jalr	-1560(ra) # 80003f50 <end_op>
      return -1;
    80005570:	b7e5                	j	80005558 <sys_open+0xd0>
    if((ip = namei(path)) == 0){
    80005572:	f5040513          	addi	a0,s0,-176
    80005576:	ffffe097          	auipc	ra,0xffffe
    8000557a:	74e080e7          	jalr	1870(ra) # 80003cc4 <namei>
    8000557e:	892a                	mv	s2,a0
    80005580:	c905                	beqz	a0,800055b0 <sys_open+0x128>
    ilock(ip);
    80005582:	ffffe097          	auipc	ra,0xffffe
    80005586:	fb8080e7          	jalr	-72(ra) # 8000353a <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000558a:	04491703          	lh	a4,68(s2)
    8000558e:	4785                	li	a5,1
    80005590:	f4f71ce3          	bne	a4,a5,800054e8 <sys_open+0x60>
    80005594:	f4c42783          	lw	a5,-180(s0)
    80005598:	d3b5                	beqz	a5,800054fc <sys_open+0x74>
      iunlockput(ip);
    8000559a:	854a                	mv	a0,s2
    8000559c:	ffffe097          	auipc	ra,0xffffe
    800055a0:	1dc080e7          	jalr	476(ra) # 80003778 <iunlockput>
      end_op();
    800055a4:	fffff097          	auipc	ra,0xfffff
    800055a8:	9ac080e7          	jalr	-1620(ra) # 80003f50 <end_op>
      return -1;
    800055ac:	54fd                	li	s1,-1
    800055ae:	b76d                	j	80005558 <sys_open+0xd0>
      end_op();
    800055b0:	fffff097          	auipc	ra,0xfffff
    800055b4:	9a0080e7          	jalr	-1632(ra) # 80003f50 <end_op>
      return -1;
    800055b8:	54fd                	li	s1,-1
    800055ba:	bf79                	j	80005558 <sys_open+0xd0>
    iunlockput(ip);
    800055bc:	854a                	mv	a0,s2
    800055be:	ffffe097          	auipc	ra,0xffffe
    800055c2:	1ba080e7          	jalr	442(ra) # 80003778 <iunlockput>
    end_op();
    800055c6:	fffff097          	auipc	ra,0xfffff
    800055ca:	98a080e7          	jalr	-1654(ra) # 80003f50 <end_op>
    return -1;
    800055ce:	54fd                	li	s1,-1
    800055d0:	b761                	j	80005558 <sys_open+0xd0>
    f->type = FD_DEVICE;
    800055d2:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800055d6:	04691783          	lh	a5,70(s2)
    800055da:	02f99223          	sh	a5,36(s3)
    800055de:	b7b1                	j	8000552a <sys_open+0xa2>
      fileclose(f);
    800055e0:	854e                	mv	a0,s3
    800055e2:	fffff097          	auipc	ra,0xfffff
    800055e6:	dc0080e7          	jalr	-576(ra) # 800043a2 <fileclose>
    iunlockput(ip);
    800055ea:	854a                	mv	a0,s2
    800055ec:	ffffe097          	auipc	ra,0xffffe
    800055f0:	18c080e7          	jalr	396(ra) # 80003778 <iunlockput>
    end_op();
    800055f4:	fffff097          	auipc	ra,0xfffff
    800055f8:	95c080e7          	jalr	-1700(ra) # 80003f50 <end_op>
    return -1;
    800055fc:	54fd                	li	s1,-1
    800055fe:	bfa9                	j	80005558 <sys_open+0xd0>

0000000080005600 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005600:	7175                	addi	sp,sp,-144
    80005602:	e506                	sd	ra,136(sp)
    80005604:	e122                	sd	s0,128(sp)
    80005606:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005608:	fffff097          	auipc	ra,0xfffff
    8000560c:	8c8080e7          	jalr	-1848(ra) # 80003ed0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005610:	08000613          	li	a2,128
    80005614:	f7040593          	addi	a1,s0,-144
    80005618:	4501                	li	a0,0
    8000561a:	ffffd097          	auipc	ra,0xffffd
    8000561e:	3f2080e7          	jalr	1010(ra) # 80002a0c <argstr>
    80005622:	02054963          	bltz	a0,80005654 <sys_mkdir+0x54>
    80005626:	4681                	li	a3,0
    80005628:	4601                	li	a2,0
    8000562a:	4585                	li	a1,1
    8000562c:	f7040513          	addi	a0,s0,-144
    80005630:	00000097          	auipc	ra,0x0
    80005634:	820080e7          	jalr	-2016(ra) # 80004e50 <create>
    80005638:	cd11                	beqz	a0,80005654 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000563a:	ffffe097          	auipc	ra,0xffffe
    8000563e:	13e080e7          	jalr	318(ra) # 80003778 <iunlockput>
  end_op();
    80005642:	fffff097          	auipc	ra,0xfffff
    80005646:	90e080e7          	jalr	-1778(ra) # 80003f50 <end_op>
  return 0;
    8000564a:	4501                	li	a0,0
}
    8000564c:	60aa                	ld	ra,136(sp)
    8000564e:	640a                	ld	s0,128(sp)
    80005650:	6149                	addi	sp,sp,144
    80005652:	8082                	ret
    end_op();
    80005654:	fffff097          	auipc	ra,0xfffff
    80005658:	8fc080e7          	jalr	-1796(ra) # 80003f50 <end_op>
    return -1;
    8000565c:	557d                	li	a0,-1
    8000565e:	b7fd                	j	8000564c <sys_mkdir+0x4c>

0000000080005660 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005660:	7135                	addi	sp,sp,-160
    80005662:	ed06                	sd	ra,152(sp)
    80005664:	e922                	sd	s0,144(sp)
    80005666:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005668:	fffff097          	auipc	ra,0xfffff
    8000566c:	868080e7          	jalr	-1944(ra) # 80003ed0 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005670:	08000613          	li	a2,128
    80005674:	f7040593          	addi	a1,s0,-144
    80005678:	4501                	li	a0,0
    8000567a:	ffffd097          	auipc	ra,0xffffd
    8000567e:	392080e7          	jalr	914(ra) # 80002a0c <argstr>
    80005682:	04054a63          	bltz	a0,800056d6 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80005686:	f6c40593          	addi	a1,s0,-148
    8000568a:	4505                	li	a0,1
    8000568c:	ffffd097          	auipc	ra,0xffffd
    80005690:	33c080e7          	jalr	828(ra) # 800029c8 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005694:	04054163          	bltz	a0,800056d6 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80005698:	f6840593          	addi	a1,s0,-152
    8000569c:	4509                	li	a0,2
    8000569e:	ffffd097          	auipc	ra,0xffffd
    800056a2:	32a080e7          	jalr	810(ra) # 800029c8 <argint>
     argint(1, &major) < 0 ||
    800056a6:	02054863          	bltz	a0,800056d6 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800056aa:	f6841683          	lh	a3,-152(s0)
    800056ae:	f6c41603          	lh	a2,-148(s0)
    800056b2:	458d                	li	a1,3
    800056b4:	f7040513          	addi	a0,s0,-144
    800056b8:	fffff097          	auipc	ra,0xfffff
    800056bc:	798080e7          	jalr	1944(ra) # 80004e50 <create>
     argint(2, &minor) < 0 ||
    800056c0:	c919                	beqz	a0,800056d6 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800056c2:	ffffe097          	auipc	ra,0xffffe
    800056c6:	0b6080e7          	jalr	182(ra) # 80003778 <iunlockput>
  end_op();
    800056ca:	fffff097          	auipc	ra,0xfffff
    800056ce:	886080e7          	jalr	-1914(ra) # 80003f50 <end_op>
  return 0;
    800056d2:	4501                	li	a0,0
    800056d4:	a031                	j	800056e0 <sys_mknod+0x80>
    end_op();
    800056d6:	fffff097          	auipc	ra,0xfffff
    800056da:	87a080e7          	jalr	-1926(ra) # 80003f50 <end_op>
    return -1;
    800056de:	557d                	li	a0,-1
}
    800056e0:	60ea                	ld	ra,152(sp)
    800056e2:	644a                	ld	s0,144(sp)
    800056e4:	610d                	addi	sp,sp,160
    800056e6:	8082                	ret

00000000800056e8 <sys_chdir>:

uint64
sys_chdir(void)
{
    800056e8:	7135                	addi	sp,sp,-160
    800056ea:	ed06                	sd	ra,152(sp)
    800056ec:	e922                	sd	s0,144(sp)
    800056ee:	e526                	sd	s1,136(sp)
    800056f0:	e14a                	sd	s2,128(sp)
    800056f2:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800056f4:	ffffc097          	auipc	ra,0xffffc
    800056f8:	290080e7          	jalr	656(ra) # 80001984 <myproc>
    800056fc:	892a                	mv	s2,a0
  
  begin_op();
    800056fe:	ffffe097          	auipc	ra,0xffffe
    80005702:	7d2080e7          	jalr	2002(ra) # 80003ed0 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005706:	08000613          	li	a2,128
    8000570a:	f6040593          	addi	a1,s0,-160
    8000570e:	4501                	li	a0,0
    80005710:	ffffd097          	auipc	ra,0xffffd
    80005714:	2fc080e7          	jalr	764(ra) # 80002a0c <argstr>
    80005718:	04054b63          	bltz	a0,8000576e <sys_chdir+0x86>
    8000571c:	f6040513          	addi	a0,s0,-160
    80005720:	ffffe097          	auipc	ra,0xffffe
    80005724:	5a4080e7          	jalr	1444(ra) # 80003cc4 <namei>
    80005728:	84aa                	mv	s1,a0
    8000572a:	c131                	beqz	a0,8000576e <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    8000572c:	ffffe097          	auipc	ra,0xffffe
    80005730:	e0e080e7          	jalr	-498(ra) # 8000353a <ilock>
  if(ip->type != T_DIR){
    80005734:	04449703          	lh	a4,68(s1)
    80005738:	4785                	li	a5,1
    8000573a:	04f71063          	bne	a4,a5,8000577a <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000573e:	8526                	mv	a0,s1
    80005740:	ffffe097          	auipc	ra,0xffffe
    80005744:	ebc080e7          	jalr	-324(ra) # 800035fc <iunlock>
  iput(p->cwd);
    80005748:	15093503          	ld	a0,336(s2)
    8000574c:	ffffe097          	auipc	ra,0xffffe
    80005750:	efc080e7          	jalr	-260(ra) # 80003648 <iput>
  end_op();
    80005754:	ffffe097          	auipc	ra,0xffffe
    80005758:	7fc080e7          	jalr	2044(ra) # 80003f50 <end_op>
  p->cwd = ip;
    8000575c:	14993823          	sd	s1,336(s2)
  return 0;
    80005760:	4501                	li	a0,0
}
    80005762:	60ea                	ld	ra,152(sp)
    80005764:	644a                	ld	s0,144(sp)
    80005766:	64aa                	ld	s1,136(sp)
    80005768:	690a                	ld	s2,128(sp)
    8000576a:	610d                	addi	sp,sp,160
    8000576c:	8082                	ret
    end_op();
    8000576e:	ffffe097          	auipc	ra,0xffffe
    80005772:	7e2080e7          	jalr	2018(ra) # 80003f50 <end_op>
    return -1;
    80005776:	557d                	li	a0,-1
    80005778:	b7ed                	j	80005762 <sys_chdir+0x7a>
    iunlockput(ip);
    8000577a:	8526                	mv	a0,s1
    8000577c:	ffffe097          	auipc	ra,0xffffe
    80005780:	ffc080e7          	jalr	-4(ra) # 80003778 <iunlockput>
    end_op();
    80005784:	ffffe097          	auipc	ra,0xffffe
    80005788:	7cc080e7          	jalr	1996(ra) # 80003f50 <end_op>
    return -1;
    8000578c:	557d                	li	a0,-1
    8000578e:	bfd1                	j	80005762 <sys_chdir+0x7a>

0000000080005790 <sys_exec>:

uint64
sys_exec(void)
{
    80005790:	7145                	addi	sp,sp,-464
    80005792:	e786                	sd	ra,456(sp)
    80005794:	e3a2                	sd	s0,448(sp)
    80005796:	ff26                	sd	s1,440(sp)
    80005798:	fb4a                	sd	s2,432(sp)
    8000579a:	f74e                	sd	s3,424(sp)
    8000579c:	f352                	sd	s4,416(sp)
    8000579e:	ef56                	sd	s5,408(sp)
    800057a0:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800057a2:	08000613          	li	a2,128
    800057a6:	f4040593          	addi	a1,s0,-192
    800057aa:	4501                	li	a0,0
    800057ac:	ffffd097          	auipc	ra,0xffffd
    800057b0:	260080e7          	jalr	608(ra) # 80002a0c <argstr>
    800057b4:	0e054663          	bltz	a0,800058a0 <sys_exec+0x110>
    800057b8:	e3840593          	addi	a1,s0,-456
    800057bc:	4505                	li	a0,1
    800057be:	ffffd097          	auipc	ra,0xffffd
    800057c2:	22c080e7          	jalr	556(ra) # 800029ea <argaddr>
    800057c6:	0e054763          	bltz	a0,800058b4 <sys_exec+0x124>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    800057ca:	10000613          	li	a2,256
    800057ce:	4581                	li	a1,0
    800057d0:	e4040513          	addi	a0,s0,-448
    800057d4:	ffffb097          	auipc	ra,0xffffb
    800057d8:	39a080e7          	jalr	922(ra) # 80000b6e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800057dc:	e4040913          	addi	s2,s0,-448
  memset(argv, 0, sizeof(argv));
    800057e0:	89ca                	mv	s3,s2
    800057e2:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    800057e4:	02000a13          	li	s4,32
    800057e8:	00048a9b          	sext.w	s5,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800057ec:	00349513          	slli	a0,s1,0x3
    800057f0:	e3040593          	addi	a1,s0,-464
    800057f4:	e3843783          	ld	a5,-456(s0)
    800057f8:	953e                	add	a0,a0,a5
    800057fa:	ffffd097          	auipc	ra,0xffffd
    800057fe:	134080e7          	jalr	308(ra) # 8000292e <fetchaddr>
    80005802:	02054a63          	bltz	a0,80005836 <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80005806:	e3043783          	ld	a5,-464(s0)
    8000580a:	c7a1                	beqz	a5,80005852 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    8000580c:	ffffb097          	auipc	ra,0xffffb
    80005810:	154080e7          	jalr	340(ra) # 80000960 <kalloc>
    80005814:	85aa                	mv	a1,a0
    80005816:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    8000581a:	c92d                	beqz	a0,8000588c <sys_exec+0xfc>
      panic("sys_exec kalloc");
    if(fetchstr(uarg, argv[i], PGSIZE) < 0){
    8000581c:	6605                	lui	a2,0x1
    8000581e:	e3043503          	ld	a0,-464(s0)
    80005822:	ffffd097          	auipc	ra,0xffffd
    80005826:	15e080e7          	jalr	350(ra) # 80002980 <fetchstr>
    8000582a:	00054663          	bltz	a0,80005836 <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    8000582e:	0485                	addi	s1,s1,1
    80005830:	09a1                	addi	s3,s3,8
    80005832:	fb449be3          	bne	s1,s4,800057e8 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005836:	10090493          	addi	s1,s2,256
    8000583a:	00093503          	ld	a0,0(s2)
    8000583e:	cd39                	beqz	a0,8000589c <sys_exec+0x10c>
    kfree(argv[i]);
    80005840:	ffffb097          	auipc	ra,0xffffb
    80005844:	024080e7          	jalr	36(ra) # 80000864 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005848:	0921                	addi	s2,s2,8
    8000584a:	fe9918e3          	bne	s2,s1,8000583a <sys_exec+0xaa>
  return -1;
    8000584e:	557d                	li	a0,-1
    80005850:	a889                	j	800058a2 <sys_exec+0x112>
      argv[i] = 0;
    80005852:	0a8e                	slli	s5,s5,0x3
    80005854:	fc040793          	addi	a5,s0,-64
    80005858:	9abe                	add	s5,s5,a5
    8000585a:	e80ab023          	sd	zero,-384(s5) # ffffffffffffee80 <end+0xffffffff7ffd8e64>
  int ret = exec(path, argv);
    8000585e:	e4040593          	addi	a1,s0,-448
    80005862:	f4040513          	addi	a0,s0,-192
    80005866:	fffff097          	auipc	ra,0xfffff
    8000586a:	1de080e7          	jalr	478(ra) # 80004a44 <exec>
    8000586e:	84aa                	mv	s1,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005870:	10090993          	addi	s3,s2,256
    80005874:	00093503          	ld	a0,0(s2)
    80005878:	c901                	beqz	a0,80005888 <sys_exec+0xf8>
    kfree(argv[i]);
    8000587a:	ffffb097          	auipc	ra,0xffffb
    8000587e:	fea080e7          	jalr	-22(ra) # 80000864 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005882:	0921                	addi	s2,s2,8
    80005884:	ff3918e3          	bne	s2,s3,80005874 <sys_exec+0xe4>
  return ret;
    80005888:	8526                	mv	a0,s1
    8000588a:	a821                	j	800058a2 <sys_exec+0x112>
      panic("sys_exec kalloc");
    8000588c:	00002517          	auipc	a0,0x2
    80005890:	23450513          	addi	a0,a0,564 # 80007ac0 <userret+0xa30>
    80005894:	ffffb097          	auipc	ra,0xffffb
    80005898:	cba080e7          	jalr	-838(ra) # 8000054e <panic>
  return -1;
    8000589c:	557d                	li	a0,-1
    8000589e:	a011                	j	800058a2 <sys_exec+0x112>
    return -1;
    800058a0:	557d                	li	a0,-1
}
    800058a2:	60be                	ld	ra,456(sp)
    800058a4:	641e                	ld	s0,448(sp)
    800058a6:	74fa                	ld	s1,440(sp)
    800058a8:	795a                	ld	s2,432(sp)
    800058aa:	79ba                	ld	s3,424(sp)
    800058ac:	7a1a                	ld	s4,416(sp)
    800058ae:	6afa                	ld	s5,408(sp)
    800058b0:	6179                	addi	sp,sp,464
    800058b2:	8082                	ret
    return -1;
    800058b4:	557d                	li	a0,-1
    800058b6:	b7f5                	j	800058a2 <sys_exec+0x112>

00000000800058b8 <sys_pipe>:

uint64
sys_pipe(void)
{
    800058b8:	7139                	addi	sp,sp,-64
    800058ba:	fc06                	sd	ra,56(sp)
    800058bc:	f822                	sd	s0,48(sp)
    800058be:	f426                	sd	s1,40(sp)
    800058c0:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800058c2:	ffffc097          	auipc	ra,0xffffc
    800058c6:	0c2080e7          	jalr	194(ra) # 80001984 <myproc>
    800058ca:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800058cc:	fd840593          	addi	a1,s0,-40
    800058d0:	4501                	li	a0,0
    800058d2:	ffffd097          	auipc	ra,0xffffd
    800058d6:	118080e7          	jalr	280(ra) # 800029ea <argaddr>
    return -1;
    800058da:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800058dc:	0e054063          	bltz	a0,800059bc <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    800058e0:	fc840593          	addi	a1,s0,-56
    800058e4:	fd040513          	addi	a0,s0,-48
    800058e8:	fffff097          	auipc	ra,0xfffff
    800058ec:	e10080e7          	jalr	-496(ra) # 800046f8 <pipealloc>
    return -1;
    800058f0:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800058f2:	0c054563          	bltz	a0,800059bc <sys_pipe+0x104>
  fd0 = -1;
    800058f6:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800058fa:	fd043503          	ld	a0,-48(s0)
    800058fe:	fffff097          	auipc	ra,0xfffff
    80005902:	510080e7          	jalr	1296(ra) # 80004e0e <fdalloc>
    80005906:	fca42223          	sw	a0,-60(s0)
    8000590a:	08054c63          	bltz	a0,800059a2 <sys_pipe+0xea>
    8000590e:	fc843503          	ld	a0,-56(s0)
    80005912:	fffff097          	auipc	ra,0xfffff
    80005916:	4fc080e7          	jalr	1276(ra) # 80004e0e <fdalloc>
    8000591a:	fca42023          	sw	a0,-64(s0)
    8000591e:	06054863          	bltz	a0,8000598e <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005922:	4691                	li	a3,4
    80005924:	fc440613          	addi	a2,s0,-60
    80005928:	fd843583          	ld	a1,-40(s0)
    8000592c:	68a8                	ld	a0,80(s1)
    8000592e:	ffffc097          	auipc	ra,0xffffc
    80005932:	d4a080e7          	jalr	-694(ra) # 80001678 <copyout>
    80005936:	02054063          	bltz	a0,80005956 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000593a:	4691                	li	a3,4
    8000593c:	fc040613          	addi	a2,s0,-64
    80005940:	fd843583          	ld	a1,-40(s0)
    80005944:	0591                	addi	a1,a1,4
    80005946:	68a8                	ld	a0,80(s1)
    80005948:	ffffc097          	auipc	ra,0xffffc
    8000594c:	d30080e7          	jalr	-720(ra) # 80001678 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005950:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005952:	06055563          	bgez	a0,800059bc <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005956:	fc442783          	lw	a5,-60(s0)
    8000595a:	07e9                	addi	a5,a5,26
    8000595c:	078e                	slli	a5,a5,0x3
    8000595e:	97a6                	add	a5,a5,s1
    80005960:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005964:	fc042503          	lw	a0,-64(s0)
    80005968:	0569                	addi	a0,a0,26
    8000596a:	050e                	slli	a0,a0,0x3
    8000596c:	9526                	add	a0,a0,s1
    8000596e:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005972:	fd043503          	ld	a0,-48(s0)
    80005976:	fffff097          	auipc	ra,0xfffff
    8000597a:	a2c080e7          	jalr	-1492(ra) # 800043a2 <fileclose>
    fileclose(wf);
    8000597e:	fc843503          	ld	a0,-56(s0)
    80005982:	fffff097          	auipc	ra,0xfffff
    80005986:	a20080e7          	jalr	-1504(ra) # 800043a2 <fileclose>
    return -1;
    8000598a:	57fd                	li	a5,-1
    8000598c:	a805                	j	800059bc <sys_pipe+0x104>
    if(fd0 >= 0)
    8000598e:	fc442783          	lw	a5,-60(s0)
    80005992:	0007c863          	bltz	a5,800059a2 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005996:	01a78513          	addi	a0,a5,26
    8000599a:	050e                	slli	a0,a0,0x3
    8000599c:	9526                	add	a0,a0,s1
    8000599e:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    800059a2:	fd043503          	ld	a0,-48(s0)
    800059a6:	fffff097          	auipc	ra,0xfffff
    800059aa:	9fc080e7          	jalr	-1540(ra) # 800043a2 <fileclose>
    fileclose(wf);
    800059ae:	fc843503          	ld	a0,-56(s0)
    800059b2:	fffff097          	auipc	ra,0xfffff
    800059b6:	9f0080e7          	jalr	-1552(ra) # 800043a2 <fileclose>
    return -1;
    800059ba:	57fd                	li	a5,-1
}
    800059bc:	853e                	mv	a0,a5
    800059be:	70e2                	ld	ra,56(sp)
    800059c0:	7442                	ld	s0,48(sp)
    800059c2:	74a2                	ld	s1,40(sp)
    800059c4:	6121                	addi	sp,sp,64
    800059c6:	8082                	ret
	...

00000000800059d0 <kernelvec>:
    800059d0:	7111                	addi	sp,sp,-256
    800059d2:	e006                	sd	ra,0(sp)
    800059d4:	e40a                	sd	sp,8(sp)
    800059d6:	e80e                	sd	gp,16(sp)
    800059d8:	ec12                	sd	tp,24(sp)
    800059da:	f016                	sd	t0,32(sp)
    800059dc:	f41a                	sd	t1,40(sp)
    800059de:	f81e                	sd	t2,48(sp)
    800059e0:	fc22                	sd	s0,56(sp)
    800059e2:	e0a6                	sd	s1,64(sp)
    800059e4:	e4aa                	sd	a0,72(sp)
    800059e6:	e8ae                	sd	a1,80(sp)
    800059e8:	ecb2                	sd	a2,88(sp)
    800059ea:	f0b6                	sd	a3,96(sp)
    800059ec:	f4ba                	sd	a4,104(sp)
    800059ee:	f8be                	sd	a5,112(sp)
    800059f0:	fcc2                	sd	a6,120(sp)
    800059f2:	e146                	sd	a7,128(sp)
    800059f4:	e54a                	sd	s2,136(sp)
    800059f6:	e94e                	sd	s3,144(sp)
    800059f8:	ed52                	sd	s4,152(sp)
    800059fa:	f156                	sd	s5,160(sp)
    800059fc:	f55a                	sd	s6,168(sp)
    800059fe:	f95e                	sd	s7,176(sp)
    80005a00:	fd62                	sd	s8,184(sp)
    80005a02:	e1e6                	sd	s9,192(sp)
    80005a04:	e5ea                	sd	s10,200(sp)
    80005a06:	e9ee                	sd	s11,208(sp)
    80005a08:	edf2                	sd	t3,216(sp)
    80005a0a:	f1f6                	sd	t4,224(sp)
    80005a0c:	f5fa                	sd	t5,232(sp)
    80005a0e:	f9fe                	sd	t6,240(sp)
    80005a10:	debfc0ef          	jal	ra,800027fa <kerneltrap>
    80005a14:	6082                	ld	ra,0(sp)
    80005a16:	6122                	ld	sp,8(sp)
    80005a18:	61c2                	ld	gp,16(sp)
    80005a1a:	7282                	ld	t0,32(sp)
    80005a1c:	7322                	ld	t1,40(sp)
    80005a1e:	73c2                	ld	t2,48(sp)
    80005a20:	7462                	ld	s0,56(sp)
    80005a22:	6486                	ld	s1,64(sp)
    80005a24:	6526                	ld	a0,72(sp)
    80005a26:	65c6                	ld	a1,80(sp)
    80005a28:	6666                	ld	a2,88(sp)
    80005a2a:	7686                	ld	a3,96(sp)
    80005a2c:	7726                	ld	a4,104(sp)
    80005a2e:	77c6                	ld	a5,112(sp)
    80005a30:	7866                	ld	a6,120(sp)
    80005a32:	688a                	ld	a7,128(sp)
    80005a34:	692a                	ld	s2,136(sp)
    80005a36:	69ca                	ld	s3,144(sp)
    80005a38:	6a6a                	ld	s4,152(sp)
    80005a3a:	7a8a                	ld	s5,160(sp)
    80005a3c:	7b2a                	ld	s6,168(sp)
    80005a3e:	7bca                	ld	s7,176(sp)
    80005a40:	7c6a                	ld	s8,184(sp)
    80005a42:	6c8e                	ld	s9,192(sp)
    80005a44:	6d2e                	ld	s10,200(sp)
    80005a46:	6dce                	ld	s11,208(sp)
    80005a48:	6e6e                	ld	t3,216(sp)
    80005a4a:	7e8e                	ld	t4,224(sp)
    80005a4c:	7f2e                	ld	t5,232(sp)
    80005a4e:	7fce                	ld	t6,240(sp)
    80005a50:	6111                	addi	sp,sp,256
    80005a52:	10200073          	sret
    80005a56:	00000013          	nop
    80005a5a:	00000013          	nop
    80005a5e:	0001                	nop

0000000080005a60 <timervec>:
    80005a60:	34051573          	csrrw	a0,mscratch,a0
    80005a64:	e10c                	sd	a1,0(a0)
    80005a66:	e510                	sd	a2,8(a0)
    80005a68:	e914                	sd	a3,16(a0)
    80005a6a:	710c                	ld	a1,32(a0)
    80005a6c:	7510                	ld	a2,40(a0)
    80005a6e:	6194                	ld	a3,0(a1)
    80005a70:	96b2                	add	a3,a3,a2
    80005a72:	e194                	sd	a3,0(a1)
    80005a74:	4589                	li	a1,2
    80005a76:	14459073          	csrw	sip,a1
    80005a7a:	6914                	ld	a3,16(a0)
    80005a7c:	6510                	ld	a2,8(a0)
    80005a7e:	610c                	ld	a1,0(a0)
    80005a80:	34051573          	csrrw	a0,mscratch,a0
    80005a84:	30200073          	mret
	...

0000000080005a8a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005a8a:	1141                	addi	sp,sp,-16
    80005a8c:	e422                	sd	s0,8(sp)
    80005a8e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005a90:	0c0007b7          	lui	a5,0xc000
    80005a94:	4705                	li	a4,1
    80005a96:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005a98:	c3d8                	sw	a4,4(a5)
}
    80005a9a:	6422                	ld	s0,8(sp)
    80005a9c:	0141                	addi	sp,sp,16
    80005a9e:	8082                	ret

0000000080005aa0 <plicinithart>:

void
plicinithart(void)
{
    80005aa0:	1141                	addi	sp,sp,-16
    80005aa2:	e406                	sd	ra,8(sp)
    80005aa4:	e022                	sd	s0,0(sp)
    80005aa6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005aa8:	ffffc097          	auipc	ra,0xffffc
    80005aac:	eb0080e7          	jalr	-336(ra) # 80001958 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005ab0:	0085171b          	slliw	a4,a0,0x8
    80005ab4:	0c0027b7          	lui	a5,0xc002
    80005ab8:	97ba                	add	a5,a5,a4
    80005aba:	40200713          	li	a4,1026
    80005abe:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005ac2:	00d5151b          	slliw	a0,a0,0xd
    80005ac6:	0c2017b7          	lui	a5,0xc201
    80005aca:	953e                	add	a0,a0,a5
    80005acc:	00052023          	sw	zero,0(a0)
}
    80005ad0:	60a2                	ld	ra,8(sp)
    80005ad2:	6402                	ld	s0,0(sp)
    80005ad4:	0141                	addi	sp,sp,16
    80005ad6:	8082                	ret

0000000080005ad8 <plic_pending>:

// return a bitmap of which IRQs are waiting
// to be served.
uint64
plic_pending(void)
{
    80005ad8:	1141                	addi	sp,sp,-16
    80005ada:	e422                	sd	s0,8(sp)
    80005adc:	0800                	addi	s0,sp,16
  //mask = *(uint32*)(PLIC + 0x1000);
  //mask |= (uint64)*(uint32*)(PLIC + 0x1004) << 32;
  mask = *(uint64*)PLIC_PENDING;

  return mask;
}
    80005ade:	0c0017b7          	lui	a5,0xc001
    80005ae2:	6388                	ld	a0,0(a5)
    80005ae4:	6422                	ld	s0,8(sp)
    80005ae6:	0141                	addi	sp,sp,16
    80005ae8:	8082                	ret

0000000080005aea <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005aea:	1141                	addi	sp,sp,-16
    80005aec:	e406                	sd	ra,8(sp)
    80005aee:	e022                	sd	s0,0(sp)
    80005af0:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005af2:	ffffc097          	auipc	ra,0xffffc
    80005af6:	e66080e7          	jalr	-410(ra) # 80001958 <cpuid>
  //int irq = *(uint32*)(PLIC + 0x201004);
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005afa:	00d5179b          	slliw	a5,a0,0xd
    80005afe:	0c201537          	lui	a0,0xc201
    80005b02:	953e                	add	a0,a0,a5
  return irq;
}
    80005b04:	4148                	lw	a0,4(a0)
    80005b06:	60a2                	ld	ra,8(sp)
    80005b08:	6402                	ld	s0,0(sp)
    80005b0a:	0141                	addi	sp,sp,16
    80005b0c:	8082                	ret

0000000080005b0e <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005b0e:	1101                	addi	sp,sp,-32
    80005b10:	ec06                	sd	ra,24(sp)
    80005b12:	e822                	sd	s0,16(sp)
    80005b14:	e426                	sd	s1,8(sp)
    80005b16:	1000                	addi	s0,sp,32
    80005b18:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005b1a:	ffffc097          	auipc	ra,0xffffc
    80005b1e:	e3e080e7          	jalr	-450(ra) # 80001958 <cpuid>
  //*(uint32*)(PLIC + 0x201004) = irq;
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005b22:	00d5151b          	slliw	a0,a0,0xd
    80005b26:	0c2017b7          	lui	a5,0xc201
    80005b2a:	97aa                	add	a5,a5,a0
    80005b2c:	c3c4                	sw	s1,4(a5)
}
    80005b2e:	60e2                	ld	ra,24(sp)
    80005b30:	6442                	ld	s0,16(sp)
    80005b32:	64a2                	ld	s1,8(sp)
    80005b34:	6105                	addi	sp,sp,32
    80005b36:	8082                	ret

0000000080005b38 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005b38:	1141                	addi	sp,sp,-16
    80005b3a:	e406                	sd	ra,8(sp)
    80005b3c:	e022                	sd	s0,0(sp)
    80005b3e:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005b40:	479d                	li	a5,7
    80005b42:	04a7cc63          	blt	a5,a0,80005b9a <free_desc+0x62>
    panic("virtio_disk_intr 1");
  if(disk.free[i])
    80005b46:	0001d797          	auipc	a5,0x1d
    80005b4a:	4ba78793          	addi	a5,a5,1210 # 80023000 <disk>
    80005b4e:	00a78733          	add	a4,a5,a0
    80005b52:	6789                	lui	a5,0x2
    80005b54:	97ba                	add	a5,a5,a4
    80005b56:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005b5a:	eba1                	bnez	a5,80005baa <free_desc+0x72>
    panic("virtio_disk_intr 2");
  disk.desc[i].addr = 0;
    80005b5c:	00451713          	slli	a4,a0,0x4
    80005b60:	0001f797          	auipc	a5,0x1f
    80005b64:	4a07b783          	ld	a5,1184(a5) # 80025000 <disk+0x2000>
    80005b68:	97ba                	add	a5,a5,a4
    80005b6a:	0007b023          	sd	zero,0(a5)
  disk.free[i] = 1;
    80005b6e:	0001d797          	auipc	a5,0x1d
    80005b72:	49278793          	addi	a5,a5,1170 # 80023000 <disk>
    80005b76:	97aa                	add	a5,a5,a0
    80005b78:	6509                	lui	a0,0x2
    80005b7a:	953e                	add	a0,a0,a5
    80005b7c:	4785                	li	a5,1
    80005b7e:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005b82:	0001f517          	auipc	a0,0x1f
    80005b86:	49650513          	addi	a0,a0,1174 # 80025018 <disk+0x2018>
    80005b8a:	ffffc097          	auipc	ra,0xffffc
    80005b8e:	722080e7          	jalr	1826(ra) # 800022ac <wakeup>
}
    80005b92:	60a2                	ld	ra,8(sp)
    80005b94:	6402                	ld	s0,0(sp)
    80005b96:	0141                	addi	sp,sp,16
    80005b98:	8082                	ret
    panic("virtio_disk_intr 1");
    80005b9a:	00002517          	auipc	a0,0x2
    80005b9e:	f3650513          	addi	a0,a0,-202 # 80007ad0 <userret+0xa40>
    80005ba2:	ffffb097          	auipc	ra,0xffffb
    80005ba6:	9ac080e7          	jalr	-1620(ra) # 8000054e <panic>
    panic("virtio_disk_intr 2");
    80005baa:	00002517          	auipc	a0,0x2
    80005bae:	f3e50513          	addi	a0,a0,-194 # 80007ae8 <userret+0xa58>
    80005bb2:	ffffb097          	auipc	ra,0xffffb
    80005bb6:	99c080e7          	jalr	-1636(ra) # 8000054e <panic>

0000000080005bba <virtio_disk_init>:
{
    80005bba:	1101                	addi	sp,sp,-32
    80005bbc:	ec06                	sd	ra,24(sp)
    80005bbe:	e822                	sd	s0,16(sp)
    80005bc0:	e426                	sd	s1,8(sp)
    80005bc2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005bc4:	00002597          	auipc	a1,0x2
    80005bc8:	f3c58593          	addi	a1,a1,-196 # 80007b00 <userret+0xa70>
    80005bcc:	0001f517          	auipc	a0,0x1f
    80005bd0:	4dc50513          	addi	a0,a0,1244 # 800250a8 <disk+0x20a8>
    80005bd4:	ffffb097          	auipc	ra,0xffffb
    80005bd8:	dec080e7          	jalr	-532(ra) # 800009c0 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005bdc:	100017b7          	lui	a5,0x10001
    80005be0:	4398                	lw	a4,0(a5)
    80005be2:	2701                	sext.w	a4,a4
    80005be4:	747277b7          	lui	a5,0x74727
    80005be8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005bec:	0ef71163          	bne	a4,a5,80005cce <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005bf0:	100017b7          	lui	a5,0x10001
    80005bf4:	43dc                	lw	a5,4(a5)
    80005bf6:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005bf8:	4705                	li	a4,1
    80005bfa:	0ce79a63          	bne	a5,a4,80005cce <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005bfe:	100017b7          	lui	a5,0x10001
    80005c02:	479c                	lw	a5,8(a5)
    80005c04:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005c06:	4709                	li	a4,2
    80005c08:	0ce79363          	bne	a5,a4,80005cce <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005c0c:	100017b7          	lui	a5,0x10001
    80005c10:	47d8                	lw	a4,12(a5)
    80005c12:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005c14:	554d47b7          	lui	a5,0x554d4
    80005c18:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005c1c:	0af71963          	bne	a4,a5,80005cce <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005c20:	100017b7          	lui	a5,0x10001
    80005c24:	4705                	li	a4,1
    80005c26:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005c28:	470d                	li	a4,3
    80005c2a:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005c2c:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005c2e:	c7ffe737          	lui	a4,0xc7ffe
    80005c32:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd8743>
    80005c36:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005c38:	2701                	sext.w	a4,a4
    80005c3a:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005c3c:	472d                	li	a4,11
    80005c3e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005c40:	473d                	li	a4,15
    80005c42:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005c44:	6705                	lui	a4,0x1
    80005c46:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005c48:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005c4c:	5bdc                	lw	a5,52(a5)
    80005c4e:	2781                	sext.w	a5,a5
  if(max == 0)
    80005c50:	c7d9                	beqz	a5,80005cde <virtio_disk_init+0x124>
  if(max < NUM)
    80005c52:	471d                	li	a4,7
    80005c54:	08f77d63          	bgeu	a4,a5,80005cee <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005c58:	100014b7          	lui	s1,0x10001
    80005c5c:	47a1                	li	a5,8
    80005c5e:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005c60:	6609                	lui	a2,0x2
    80005c62:	4581                	li	a1,0
    80005c64:	0001d517          	auipc	a0,0x1d
    80005c68:	39c50513          	addi	a0,a0,924 # 80023000 <disk>
    80005c6c:	ffffb097          	auipc	ra,0xffffb
    80005c70:	f02080e7          	jalr	-254(ra) # 80000b6e <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005c74:	0001d717          	auipc	a4,0x1d
    80005c78:	38c70713          	addi	a4,a4,908 # 80023000 <disk>
    80005c7c:	00c75793          	srli	a5,a4,0xc
    80005c80:	2781                	sext.w	a5,a5
    80005c82:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct VRingDesc *) disk.pages;
    80005c84:	0001f797          	auipc	a5,0x1f
    80005c88:	37c78793          	addi	a5,a5,892 # 80025000 <disk+0x2000>
    80005c8c:	e398                	sd	a4,0(a5)
  disk.avail = (uint16*)(((char*)disk.desc) + NUM*sizeof(struct VRingDesc));
    80005c8e:	0001d717          	auipc	a4,0x1d
    80005c92:	3f270713          	addi	a4,a4,1010 # 80023080 <disk+0x80>
    80005c96:	e798                	sd	a4,8(a5)
  disk.used = (struct UsedArea *) (disk.pages + PGSIZE);
    80005c98:	0001e717          	auipc	a4,0x1e
    80005c9c:	36870713          	addi	a4,a4,872 # 80024000 <disk+0x1000>
    80005ca0:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005ca2:	4705                	li	a4,1
    80005ca4:	00e78c23          	sb	a4,24(a5)
    80005ca8:	00e78ca3          	sb	a4,25(a5)
    80005cac:	00e78d23          	sb	a4,26(a5)
    80005cb0:	00e78da3          	sb	a4,27(a5)
    80005cb4:	00e78e23          	sb	a4,28(a5)
    80005cb8:	00e78ea3          	sb	a4,29(a5)
    80005cbc:	00e78f23          	sb	a4,30(a5)
    80005cc0:	00e78fa3          	sb	a4,31(a5)
}
    80005cc4:	60e2                	ld	ra,24(sp)
    80005cc6:	6442                	ld	s0,16(sp)
    80005cc8:	64a2                	ld	s1,8(sp)
    80005cca:	6105                	addi	sp,sp,32
    80005ccc:	8082                	ret
    panic("could not find virtio disk");
    80005cce:	00002517          	auipc	a0,0x2
    80005cd2:	e4250513          	addi	a0,a0,-446 # 80007b10 <userret+0xa80>
    80005cd6:	ffffb097          	auipc	ra,0xffffb
    80005cda:	878080e7          	jalr	-1928(ra) # 8000054e <panic>
    panic("virtio disk has no queue 0");
    80005cde:	00002517          	auipc	a0,0x2
    80005ce2:	e5250513          	addi	a0,a0,-430 # 80007b30 <userret+0xaa0>
    80005ce6:	ffffb097          	auipc	ra,0xffffb
    80005cea:	868080e7          	jalr	-1944(ra) # 8000054e <panic>
    panic("virtio disk max queue too short");
    80005cee:	00002517          	auipc	a0,0x2
    80005cf2:	e6250513          	addi	a0,a0,-414 # 80007b50 <userret+0xac0>
    80005cf6:	ffffb097          	auipc	ra,0xffffb
    80005cfa:	858080e7          	jalr	-1960(ra) # 8000054e <panic>

0000000080005cfe <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005cfe:	7119                	addi	sp,sp,-128
    80005d00:	fc86                	sd	ra,120(sp)
    80005d02:	f8a2                	sd	s0,112(sp)
    80005d04:	f4a6                	sd	s1,104(sp)
    80005d06:	f0ca                	sd	s2,96(sp)
    80005d08:	ecce                	sd	s3,88(sp)
    80005d0a:	e8d2                	sd	s4,80(sp)
    80005d0c:	e4d6                	sd	s5,72(sp)
    80005d0e:	e0da                	sd	s6,64(sp)
    80005d10:	fc5e                	sd	s7,56(sp)
    80005d12:	f862                	sd	s8,48(sp)
    80005d14:	f466                	sd	s9,40(sp)
    80005d16:	f06a                	sd	s10,32(sp)
    80005d18:	0100                	addi	s0,sp,128
    80005d1a:	892a                	mv	s2,a0
    80005d1c:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005d1e:	00c52c83          	lw	s9,12(a0)
    80005d22:	001c9c9b          	slliw	s9,s9,0x1
    80005d26:	1c82                	slli	s9,s9,0x20
    80005d28:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005d2c:	0001f517          	auipc	a0,0x1f
    80005d30:	37c50513          	addi	a0,a0,892 # 800250a8 <disk+0x20a8>
    80005d34:	ffffb097          	auipc	ra,0xffffb
    80005d38:	d9e080e7          	jalr	-610(ra) # 80000ad2 <acquire>
  for(int i = 0; i < 3; i++){
    80005d3c:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005d3e:	4c21                	li	s8,8
      disk.free[i] = 0;
    80005d40:	0001db97          	auipc	s7,0x1d
    80005d44:	2c0b8b93          	addi	s7,s7,704 # 80023000 <disk>
    80005d48:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005d4a:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005d4c:	8a4e                	mv	s4,s3
    80005d4e:	a051                	j	80005dd2 <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    80005d50:	00fb86b3          	add	a3,s7,a5
    80005d54:	96da                	add	a3,a3,s6
    80005d56:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005d5a:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005d5c:	0207c563          	bltz	a5,80005d86 <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005d60:	2485                	addiw	s1,s1,1
    80005d62:	0711                	addi	a4,a4,4
    80005d64:	1b548863          	beq	s1,s5,80005f14 <virtio_disk_rw+0x216>
    idx[i] = alloc_desc();
    80005d68:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    80005d6a:	0001f697          	auipc	a3,0x1f
    80005d6e:	2ae68693          	addi	a3,a3,686 # 80025018 <disk+0x2018>
    80005d72:	87d2                	mv	a5,s4
    if(disk.free[i]){
    80005d74:	0006c583          	lbu	a1,0(a3)
    80005d78:	fde1                	bnez	a1,80005d50 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005d7a:	2785                	addiw	a5,a5,1
    80005d7c:	0685                	addi	a3,a3,1
    80005d7e:	ff879be3          	bne	a5,s8,80005d74 <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005d82:	57fd                	li	a5,-1
    80005d84:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    80005d86:	02905a63          	blez	s1,80005dba <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005d8a:	f9042503          	lw	a0,-112(s0)
    80005d8e:	00000097          	auipc	ra,0x0
    80005d92:	daa080e7          	jalr	-598(ra) # 80005b38 <free_desc>
      for(int j = 0; j < i; j++)
    80005d96:	4785                	li	a5,1
    80005d98:	0297d163          	bge	a5,s1,80005dba <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005d9c:	f9442503          	lw	a0,-108(s0)
    80005da0:	00000097          	auipc	ra,0x0
    80005da4:	d98080e7          	jalr	-616(ra) # 80005b38 <free_desc>
      for(int j = 0; j < i; j++)
    80005da8:	4789                	li	a5,2
    80005daa:	0097d863          	bge	a5,s1,80005dba <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005dae:	f9842503          	lw	a0,-104(s0)
    80005db2:	00000097          	auipc	ra,0x0
    80005db6:	d86080e7          	jalr	-634(ra) # 80005b38 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005dba:	0001f597          	auipc	a1,0x1f
    80005dbe:	2ee58593          	addi	a1,a1,750 # 800250a8 <disk+0x20a8>
    80005dc2:	0001f517          	auipc	a0,0x1f
    80005dc6:	25650513          	addi	a0,a0,598 # 80025018 <disk+0x2018>
    80005dca:	ffffc097          	auipc	ra,0xffffc
    80005dce:	35c080e7          	jalr	860(ra) # 80002126 <sleep>
  for(int i = 0; i < 3; i++){
    80005dd2:	f9040713          	addi	a4,s0,-112
    80005dd6:	84ce                	mv	s1,s3
    80005dd8:	bf41                	j	80005d68 <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005dda:	0001f717          	auipc	a4,0x1f
    80005dde:	22673703          	ld	a4,550(a4) # 80025000 <disk+0x2000>
    80005de2:	973e                	add	a4,a4,a5
    80005de4:	00071623          	sh	zero,12(a4)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005de8:	0001d517          	auipc	a0,0x1d
    80005dec:	21850513          	addi	a0,a0,536 # 80023000 <disk>
    80005df0:	0001f717          	auipc	a4,0x1f
    80005df4:	21070713          	addi	a4,a4,528 # 80025000 <disk+0x2000>
    80005df8:	6310                	ld	a2,0(a4)
    80005dfa:	963e                	add	a2,a2,a5
    80005dfc:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80005e00:	0015e593          	ori	a1,a1,1
    80005e04:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005e08:	f9842683          	lw	a3,-104(s0)
    80005e0c:	6310                	ld	a2,0(a4)
    80005e0e:	97b2                	add	a5,a5,a2
    80005e10:	00d79723          	sh	a3,14(a5)

  disk.info[idx[0]].status = 0;
    80005e14:	20048613          	addi	a2,s1,512 # 10001200 <_entry-0x6fffee00>
    80005e18:	0612                	slli	a2,a2,0x4
    80005e1a:	962a                	add	a2,a2,a0
    80005e1c:	02060823          	sb	zero,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005e20:	00469793          	slli	a5,a3,0x4
    80005e24:	630c                	ld	a1,0(a4)
    80005e26:	95be                	add	a1,a1,a5
    80005e28:	6689                	lui	a3,0x2
    80005e2a:	03068693          	addi	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005e2e:	96ce                	add	a3,a3,s3
    80005e30:	96aa                	add	a3,a3,a0
    80005e32:	e194                	sd	a3,0(a1)
  disk.desc[idx[2]].len = 1;
    80005e34:	6314                	ld	a3,0(a4)
    80005e36:	96be                	add	a3,a3,a5
    80005e38:	4585                	li	a1,1
    80005e3a:	c68c                	sw	a1,8(a3)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005e3c:	6314                	ld	a3,0(a4)
    80005e3e:	96be                	add	a3,a3,a5
    80005e40:	4509                	li	a0,2
    80005e42:	00a69623          	sh	a0,12(a3)
  disk.desc[idx[2]].next = 0;
    80005e46:	6314                	ld	a3,0(a4)
    80005e48:	97b6                	add	a5,a5,a3
    80005e4a:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005e4e:	00b92223          	sw	a1,4(s2)
  disk.info[idx[0]].b = b;
    80005e52:	03263423          	sd	s2,40(a2)

  // avail[0] is flags
  // avail[1] tells the device how far to look in avail[2...].
  // avail[2...] are desc[] indices the device should process.
  // we only tell device the first index in our chain of descriptors.
  disk.avail[2 + (disk.avail[1] % NUM)] = idx[0];
    80005e56:	6714                	ld	a3,8(a4)
    80005e58:	0026d783          	lhu	a5,2(a3)
    80005e5c:	8b9d                	andi	a5,a5,7
    80005e5e:	2789                	addiw	a5,a5,2
    80005e60:	0786                	slli	a5,a5,0x1
    80005e62:	97b6                	add	a5,a5,a3
    80005e64:	00979023          	sh	s1,0(a5)
  __sync_synchronize();
    80005e68:	0ff0000f          	fence
  disk.avail[1] = disk.avail[1] + 1;
    80005e6c:	6718                	ld	a4,8(a4)
    80005e6e:	00275783          	lhu	a5,2(a4)
    80005e72:	2785                	addiw	a5,a5,1
    80005e74:	00f71123          	sh	a5,2(a4)

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005e78:	100017b7          	lui	a5,0x10001
    80005e7c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005e80:	00492783          	lw	a5,4(s2)
    80005e84:	02b79163          	bne	a5,a1,80005ea6 <virtio_disk_rw+0x1a8>
    sleep(b, &disk.vdisk_lock);
    80005e88:	0001f997          	auipc	s3,0x1f
    80005e8c:	22098993          	addi	s3,s3,544 # 800250a8 <disk+0x20a8>
  while(b->disk == 1) {
    80005e90:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005e92:	85ce                	mv	a1,s3
    80005e94:	854a                	mv	a0,s2
    80005e96:	ffffc097          	auipc	ra,0xffffc
    80005e9a:	290080e7          	jalr	656(ra) # 80002126 <sleep>
  while(b->disk == 1) {
    80005e9e:	00492783          	lw	a5,4(s2)
    80005ea2:	fe9788e3          	beq	a5,s1,80005e92 <virtio_disk_rw+0x194>
  }

  disk.info[idx[0]].b = 0;
    80005ea6:	f9042483          	lw	s1,-112(s0)
    80005eaa:	20048793          	addi	a5,s1,512
    80005eae:	00479713          	slli	a4,a5,0x4
    80005eb2:	0001d797          	auipc	a5,0x1d
    80005eb6:	14e78793          	addi	a5,a5,334 # 80023000 <disk>
    80005eba:	97ba                	add	a5,a5,a4
    80005ebc:	0207b423          	sd	zero,40(a5)
    if(disk.desc[i].flags & VRING_DESC_F_NEXT)
    80005ec0:	0001f917          	auipc	s2,0x1f
    80005ec4:	14090913          	addi	s2,s2,320 # 80025000 <disk+0x2000>
    free_desc(i);
    80005ec8:	8526                	mv	a0,s1
    80005eca:	00000097          	auipc	ra,0x0
    80005ece:	c6e080e7          	jalr	-914(ra) # 80005b38 <free_desc>
    if(disk.desc[i].flags & VRING_DESC_F_NEXT)
    80005ed2:	0492                	slli	s1,s1,0x4
    80005ed4:	00093783          	ld	a5,0(s2)
    80005ed8:	94be                	add	s1,s1,a5
    80005eda:	00c4d783          	lhu	a5,12(s1)
    80005ede:	8b85                	andi	a5,a5,1
    80005ee0:	c781                	beqz	a5,80005ee8 <virtio_disk_rw+0x1ea>
      i = disk.desc[i].next;
    80005ee2:	00e4d483          	lhu	s1,14(s1)
    free_desc(i);
    80005ee6:	b7cd                	j	80005ec8 <virtio_disk_rw+0x1ca>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005ee8:	0001f517          	auipc	a0,0x1f
    80005eec:	1c050513          	addi	a0,a0,448 # 800250a8 <disk+0x20a8>
    80005ef0:	ffffb097          	auipc	ra,0xffffb
    80005ef4:	c36080e7          	jalr	-970(ra) # 80000b26 <release>
}
    80005ef8:	70e6                	ld	ra,120(sp)
    80005efa:	7446                	ld	s0,112(sp)
    80005efc:	74a6                	ld	s1,104(sp)
    80005efe:	7906                	ld	s2,96(sp)
    80005f00:	69e6                	ld	s3,88(sp)
    80005f02:	6a46                	ld	s4,80(sp)
    80005f04:	6aa6                	ld	s5,72(sp)
    80005f06:	6b06                	ld	s6,64(sp)
    80005f08:	7be2                	ld	s7,56(sp)
    80005f0a:	7c42                	ld	s8,48(sp)
    80005f0c:	7ca2                	ld	s9,40(sp)
    80005f0e:	7d02                	ld	s10,32(sp)
    80005f10:	6109                	addi	sp,sp,128
    80005f12:	8082                	ret
  if(write)
    80005f14:	01a037b3          	snez	a5,s10
    80005f18:	f8f42023          	sw	a5,-128(s0)
  buf0.reserved = 0;
    80005f1c:	f8042223          	sw	zero,-124(s0)
  buf0.sector = sector;
    80005f20:	f9943423          	sd	s9,-120(s0)
  disk.desc[idx[0]].addr = (uint64) kvmpa((uint64) &buf0);
    80005f24:	f9042483          	lw	s1,-112(s0)
    80005f28:	00449993          	slli	s3,s1,0x4
    80005f2c:	0001fa17          	auipc	s4,0x1f
    80005f30:	0d4a0a13          	addi	s4,s4,212 # 80025000 <disk+0x2000>
    80005f34:	000a3a83          	ld	s5,0(s4)
    80005f38:	9ace                	add	s5,s5,s3
    80005f3a:	f8040513          	addi	a0,s0,-128
    80005f3e:	ffffb097          	auipc	ra,0xffffb
    80005f42:	1ae080e7          	jalr	430(ra) # 800010ec <kvmpa>
    80005f46:	00aab023          	sd	a0,0(s5)
  disk.desc[idx[0]].len = sizeof(buf0);
    80005f4a:	000a3783          	ld	a5,0(s4)
    80005f4e:	97ce                	add	a5,a5,s3
    80005f50:	4741                	li	a4,16
    80005f52:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005f54:	000a3783          	ld	a5,0(s4)
    80005f58:	97ce                	add	a5,a5,s3
    80005f5a:	4705                	li	a4,1
    80005f5c:	00e79623          	sh	a4,12(a5)
  disk.desc[idx[0]].next = idx[1];
    80005f60:	f9442783          	lw	a5,-108(s0)
    80005f64:	000a3703          	ld	a4,0(s4)
    80005f68:	974e                	add	a4,a4,s3
    80005f6a:	00f71723          	sh	a5,14(a4)
  disk.desc[idx[1]].addr = (uint64) b->data;
    80005f6e:	0792                	slli	a5,a5,0x4
    80005f70:	000a3703          	ld	a4,0(s4)
    80005f74:	973e                	add	a4,a4,a5
    80005f76:	06090693          	addi	a3,s2,96
    80005f7a:	e314                	sd	a3,0(a4)
  disk.desc[idx[1]].len = BSIZE;
    80005f7c:	000a3703          	ld	a4,0(s4)
    80005f80:	973e                	add	a4,a4,a5
    80005f82:	40000693          	li	a3,1024
    80005f86:	c714                	sw	a3,8(a4)
  if(write)
    80005f88:	e40d19e3          	bnez	s10,80005dda <virtio_disk_rw+0xdc>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005f8c:	0001f717          	auipc	a4,0x1f
    80005f90:	07473703          	ld	a4,116(a4) # 80025000 <disk+0x2000>
    80005f94:	973e                	add	a4,a4,a5
    80005f96:	4689                	li	a3,2
    80005f98:	00d71623          	sh	a3,12(a4)
    80005f9c:	b5b1                	j	80005de8 <virtio_disk_rw+0xea>

0000000080005f9e <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005f9e:	1101                	addi	sp,sp,-32
    80005fa0:	ec06                	sd	ra,24(sp)
    80005fa2:	e822                	sd	s0,16(sp)
    80005fa4:	e426                	sd	s1,8(sp)
    80005fa6:	e04a                	sd	s2,0(sp)
    80005fa8:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005faa:	0001f517          	auipc	a0,0x1f
    80005fae:	0fe50513          	addi	a0,a0,254 # 800250a8 <disk+0x20a8>
    80005fb2:	ffffb097          	auipc	ra,0xffffb
    80005fb6:	b20080e7          	jalr	-1248(ra) # 80000ad2 <acquire>

  while((disk.used_idx % NUM) != (disk.used->id % NUM)){
    80005fba:	0001f717          	auipc	a4,0x1f
    80005fbe:	04670713          	addi	a4,a4,70 # 80025000 <disk+0x2000>
    80005fc2:	02075783          	lhu	a5,32(a4)
    80005fc6:	6b18                	ld	a4,16(a4)
    80005fc8:	00275683          	lhu	a3,2(a4)
    80005fcc:	8ebd                	xor	a3,a3,a5
    80005fce:	8a9d                	andi	a3,a3,7
    80005fd0:	cab9                	beqz	a3,80006026 <virtio_disk_intr+0x88>
    int id = disk.used->elems[disk.used_idx].id;

    if(disk.info[id].status != 0)
    80005fd2:	0001d917          	auipc	s2,0x1d
    80005fd6:	02e90913          	addi	s2,s2,46 # 80023000 <disk>
      panic("virtio_disk_intr status");
    
    disk.info[id].b->disk = 0;   // disk is done with buf
    wakeup(disk.info[id].b);

    disk.used_idx = (disk.used_idx + 1) % NUM;
    80005fda:	0001f497          	auipc	s1,0x1f
    80005fde:	02648493          	addi	s1,s1,38 # 80025000 <disk+0x2000>
    int id = disk.used->elems[disk.used_idx].id;
    80005fe2:	078e                	slli	a5,a5,0x3
    80005fe4:	97ba                	add	a5,a5,a4
    80005fe6:	43dc                	lw	a5,4(a5)
    if(disk.info[id].status != 0)
    80005fe8:	20078713          	addi	a4,a5,512
    80005fec:	0712                	slli	a4,a4,0x4
    80005fee:	974a                	add	a4,a4,s2
    80005ff0:	03074703          	lbu	a4,48(a4)
    80005ff4:	e739                	bnez	a4,80006042 <virtio_disk_intr+0xa4>
    disk.info[id].b->disk = 0;   // disk is done with buf
    80005ff6:	20078793          	addi	a5,a5,512
    80005ffa:	0792                	slli	a5,a5,0x4
    80005ffc:	97ca                	add	a5,a5,s2
    80005ffe:	7798                	ld	a4,40(a5)
    80006000:	00072223          	sw	zero,4(a4)
    wakeup(disk.info[id].b);
    80006004:	7788                	ld	a0,40(a5)
    80006006:	ffffc097          	auipc	ra,0xffffc
    8000600a:	2a6080e7          	jalr	678(ra) # 800022ac <wakeup>
    disk.used_idx = (disk.used_idx + 1) % NUM;
    8000600e:	0204d783          	lhu	a5,32(s1)
    80006012:	2785                	addiw	a5,a5,1
    80006014:	8b9d                	andi	a5,a5,7
    80006016:	02f49023          	sh	a5,32(s1)
  while((disk.used_idx % NUM) != (disk.used->id % NUM)){
    8000601a:	6898                	ld	a4,16(s1)
    8000601c:	00275683          	lhu	a3,2(a4)
    80006020:	8a9d                	andi	a3,a3,7
    80006022:	fcf690e3          	bne	a3,a5,80005fe2 <virtio_disk_intr+0x44>
  }

  release(&disk.vdisk_lock);
    80006026:	0001f517          	auipc	a0,0x1f
    8000602a:	08250513          	addi	a0,a0,130 # 800250a8 <disk+0x20a8>
    8000602e:	ffffb097          	auipc	ra,0xffffb
    80006032:	af8080e7          	jalr	-1288(ra) # 80000b26 <release>
}
    80006036:	60e2                	ld	ra,24(sp)
    80006038:	6442                	ld	s0,16(sp)
    8000603a:	64a2                	ld	s1,8(sp)
    8000603c:	6902                	ld	s2,0(sp)
    8000603e:	6105                	addi	sp,sp,32
    80006040:	8082                	ret
      panic("virtio_disk_intr status");
    80006042:	00002517          	auipc	a0,0x2
    80006046:	b2e50513          	addi	a0,a0,-1234 # 80007b70 <userret+0xae0>
    8000604a:	ffffa097          	auipc	ra,0xffffa
    8000604e:	504080e7          	jalr	1284(ra) # 8000054e <panic>
	...

0000000080007000 <trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
