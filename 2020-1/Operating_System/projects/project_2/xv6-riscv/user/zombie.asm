
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	21e080e7          	jalr	542(ra) # 226 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	218080e7          	jalr	536(ra) # 22e <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	29e080e7          	jalr	670(ra) # 2be <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  30:	87aa                	mv	a5,a0
  32:	0585                	addi	a1,a1,1
  34:	0785                	addi	a5,a5,1
  36:	fff5c703          	lbu	a4,-1(a1)
  3a:	fee78fa3          	sb	a4,-1(a5)
  3e:	fb75                	bnez	a4,32 <strcpy+0x8>
    ;
  return os;
}
  40:	6422                	ld	s0,8(sp)
  42:	0141                	addi	sp,sp,16
  44:	8082                	ret

0000000000000046 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  46:	1141                	addi	sp,sp,-16
  48:	e422                	sd	s0,8(sp)
  4a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  4c:	00054783          	lbu	a5,0(a0)
  50:	cf91                	beqz	a5,6c <strcmp+0x26>
  52:	0005c703          	lbu	a4,0(a1)
  56:	00f71b63          	bne	a4,a5,6c <strcmp+0x26>
    p++, q++;
  5a:	0505                	addi	a0,a0,1
  5c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  5e:	00054783          	lbu	a5,0(a0)
  62:	c789                	beqz	a5,6c <strcmp+0x26>
  64:	0005c703          	lbu	a4,0(a1)
  68:	fef709e3          	beq	a4,a5,5a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  6c:	0005c503          	lbu	a0,0(a1)
}
  70:	40a7853b          	subw	a0,a5,a0
  74:	6422                	ld	s0,8(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint
strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  80:	00054783          	lbu	a5,0(a0)
  84:	cf91                	beqz	a5,a0 <strlen+0x26>
  86:	0505                	addi	a0,a0,1
  88:	87aa                	mv	a5,a0
  8a:	4685                	li	a3,1
  8c:	9e89                	subw	a3,a3,a0
    ;
  8e:	00f6853b          	addw	a0,a3,a5
  92:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  94:	fff7c703          	lbu	a4,-1(a5)
  98:	fb7d                	bnez	a4,8e <strlen+0x14>
  return n;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret
  for(n = 0; s[n]; n++)
  a0:	4501                	li	a0,0
  a2:	bfe5                	j	9a <strlen+0x20>

00000000000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  aa:	ce09                	beqz	a2,c4 <memset+0x20>
  ac:	87aa                	mv	a5,a0
  ae:	fff6071b          	addiw	a4,a2,-1
  b2:	1702                	slli	a4,a4,0x20
  b4:	9301                	srli	a4,a4,0x20
  b6:	0705                	addi	a4,a4,1
  b8:	972a                	add	a4,a4,a0
    cdst[i] = c;
  ba:	00b78023          	sb	a1,0(a5)
  be:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
  c0:	fee79de3          	bne	a5,a4,ba <memset+0x16>
  }
  return dst;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strchr>:

char*
strchr(const char *s, char c)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf91                	beqz	a5,f0 <strchr+0x26>
    if(*s == c)
  d6:	00f58a63          	beq	a1,a5,ea <strchr+0x20>
  for(; *s; s++)
  da:	0505                	addi	a0,a0,1
  dc:	00054783          	lbu	a5,0(a0)
  e0:	c781                	beqz	a5,e8 <strchr+0x1e>
    if(*s == c)
  e2:	feb79ce3          	bne	a5,a1,da <strchr+0x10>
  e6:	a011                	j	ea <strchr+0x20>
      return (char*)s;
  return 0;
  e8:	4501                	li	a0,0
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  return 0;
  f0:	4501                	li	a0,0
  f2:	bfe5                	j	ea <strchr+0x20>

00000000000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	711d                	addi	sp,sp,-96
  f6:	ec86                	sd	ra,88(sp)
  f8:	e8a2                	sd	s0,80(sp)
  fa:	e4a6                	sd	s1,72(sp)
  fc:	e0ca                	sd	s2,64(sp)
  fe:	fc4e                	sd	s3,56(sp)
 100:	f852                	sd	s4,48(sp)
 102:	f456                	sd	s5,40(sp)
 104:	f05a                	sd	s6,32(sp)
 106:	ec5e                	sd	s7,24(sp)
 108:	1080                	addi	s0,sp,96
 10a:	8baa                	mv	s7,a0
 10c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 10e:	892a                	mv	s2,a0
 110:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 112:	4aa9                	li	s5,10
 114:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 116:	0019849b          	addiw	s1,s3,1
 11a:	0344d863          	ble	s4,s1,14a <gets+0x56>
    cc = read(0, &c, 1);
 11e:	4605                	li	a2,1
 120:	faf40593          	addi	a1,s0,-81
 124:	4501                	li	a0,0
 126:	00000097          	auipc	ra,0x0
 12a:	120080e7          	jalr	288(ra) # 246 <read>
    if(cc < 1)
 12e:	00a05e63          	blez	a0,14a <gets+0x56>
    buf[i++] = c;
 132:	faf44783          	lbu	a5,-81(s0)
 136:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 13a:	01578763          	beq	a5,s5,148 <gets+0x54>
 13e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 140:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 142:	fd679ae3          	bne	a5,s6,116 <gets+0x22>
 146:	a011                	j	14a <gets+0x56>
  for(i=0; i+1 < max; ){
 148:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 14a:	99de                	add	s3,s3,s7
 14c:	00098023          	sb	zero,0(s3)
  return buf;
}
 150:	855e                	mv	a0,s7
 152:	60e6                	ld	ra,88(sp)
 154:	6446                	ld	s0,80(sp)
 156:	64a6                	ld	s1,72(sp)
 158:	6906                	ld	s2,64(sp)
 15a:	79e2                	ld	s3,56(sp)
 15c:	7a42                	ld	s4,48(sp)
 15e:	7aa2                	ld	s5,40(sp)
 160:	7b02                	ld	s6,32(sp)
 162:	6be2                	ld	s7,24(sp)
 164:	6125                	addi	sp,sp,96
 166:	8082                	ret

0000000000000168 <stat>:

int
stat(const char *n, struct stat *st)
{
 168:	1101                	addi	sp,sp,-32
 16a:	ec06                	sd	ra,24(sp)
 16c:	e822                	sd	s0,16(sp)
 16e:	e426                	sd	s1,8(sp)
 170:	e04a                	sd	s2,0(sp)
 172:	1000                	addi	s0,sp,32
 174:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 176:	4581                	li	a1,0
 178:	00000097          	auipc	ra,0x0
 17c:	0f6080e7          	jalr	246(ra) # 26e <open>
  if(fd < 0)
 180:	02054563          	bltz	a0,1aa <stat+0x42>
 184:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 186:	85ca                	mv	a1,s2
 188:	00000097          	auipc	ra,0x0
 18c:	0fe080e7          	jalr	254(ra) # 286 <fstat>
 190:	892a                	mv	s2,a0
  close(fd);
 192:	8526                	mv	a0,s1
 194:	00000097          	auipc	ra,0x0
 198:	0c2080e7          	jalr	194(ra) # 256 <close>
  return r;
}
 19c:	854a                	mv	a0,s2
 19e:	60e2                	ld	ra,24(sp)
 1a0:	6442                	ld	s0,16(sp)
 1a2:	64a2                	ld	s1,8(sp)
 1a4:	6902                	ld	s2,0(sp)
 1a6:	6105                	addi	sp,sp,32
 1a8:	8082                	ret
    return -1;
 1aa:	597d                	li	s2,-1
 1ac:	bfc5                	j	19c <stat+0x34>

00000000000001ae <atoi>:

int
atoi(const char *s)
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b4:	00054683          	lbu	a3,0(a0)
 1b8:	fd06879b          	addiw	a5,a3,-48
 1bc:	0ff7f793          	andi	a5,a5,255
 1c0:	4725                	li	a4,9
 1c2:	02f76963          	bltu	a4,a5,1f4 <atoi+0x46>
 1c6:	862a                	mv	a2,a0
  n = 0;
 1c8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1ca:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1cc:	0605                	addi	a2,a2,1
 1ce:	0025179b          	slliw	a5,a0,0x2
 1d2:	9fa9                	addw	a5,a5,a0
 1d4:	0017979b          	slliw	a5,a5,0x1
 1d8:	9fb5                	addw	a5,a5,a3
 1da:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1de:	00064683          	lbu	a3,0(a2)
 1e2:	fd06871b          	addiw	a4,a3,-48
 1e6:	0ff77713          	andi	a4,a4,255
 1ea:	fee5f1e3          	bleu	a4,a1,1cc <atoi+0x1e>
  return n;
}
 1ee:	6422                	ld	s0,8(sp)
 1f0:	0141                	addi	sp,sp,16
 1f2:	8082                	ret
  n = 0;
 1f4:	4501                	li	a0,0
 1f6:	bfe5                	j	1ee <atoi+0x40>

00000000000001f8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1f8:	1141                	addi	sp,sp,-16
 1fa:	e422                	sd	s0,8(sp)
 1fc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fe:	02c05163          	blez	a2,220 <memmove+0x28>
 202:	fff6071b          	addiw	a4,a2,-1
 206:	1702                	slli	a4,a4,0x20
 208:	9301                	srli	a4,a4,0x20
 20a:	0705                	addi	a4,a4,1
 20c:	972a                	add	a4,a4,a0
  dst = vdst;
 20e:	87aa                	mv	a5,a0
    *dst++ = *src++;
 210:	0585                	addi	a1,a1,1
 212:	0785                	addi	a5,a5,1
 214:	fff5c683          	lbu	a3,-1(a1)
 218:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 21c:	fee79ae3          	bne	a5,a4,210 <memmove+0x18>
  return vdst;
}
 220:	6422                	ld	s0,8(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret

0000000000000226 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 226:	4885                	li	a7,1
 ecall
 228:	00000073          	ecall
 ret
 22c:	8082                	ret

000000000000022e <exit>:
.global exit
exit:
 li a7, SYS_exit
 22e:	4889                	li	a7,2
 ecall
 230:	00000073          	ecall
 ret
 234:	8082                	ret

0000000000000236 <wait>:
.global wait
wait:
 li a7, SYS_wait
 236:	488d                	li	a7,3
 ecall
 238:	00000073          	ecall
 ret
 23c:	8082                	ret

000000000000023e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 23e:	4891                	li	a7,4
 ecall
 240:	00000073          	ecall
 ret
 244:	8082                	ret

0000000000000246 <read>:
.global read
read:
 li a7, SYS_read
 246:	4895                	li	a7,5
 ecall
 248:	00000073          	ecall
 ret
 24c:	8082                	ret

000000000000024e <write>:
.global write
write:
 li a7, SYS_write
 24e:	48c1                	li	a7,16
 ecall
 250:	00000073          	ecall
 ret
 254:	8082                	ret

0000000000000256 <close>:
.global close
close:
 li a7, SYS_close
 256:	48d5                	li	a7,21
 ecall
 258:	00000073          	ecall
 ret
 25c:	8082                	ret

000000000000025e <kill>:
.global kill
kill:
 li a7, SYS_kill
 25e:	4899                	li	a7,6
 ecall
 260:	00000073          	ecall
 ret
 264:	8082                	ret

0000000000000266 <exec>:
.global exec
exec:
 li a7, SYS_exec
 266:	489d                	li	a7,7
 ecall
 268:	00000073          	ecall
 ret
 26c:	8082                	ret

000000000000026e <open>:
.global open
open:
 li a7, SYS_open
 26e:	48bd                	li	a7,15
 ecall
 270:	00000073          	ecall
 ret
 274:	8082                	ret

0000000000000276 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 276:	48c5                	li	a7,17
 ecall
 278:	00000073          	ecall
 ret
 27c:	8082                	ret

000000000000027e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 27e:	48c9                	li	a7,18
 ecall
 280:	00000073          	ecall
 ret
 284:	8082                	ret

0000000000000286 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 286:	48a1                	li	a7,8
 ecall
 288:	00000073          	ecall
 ret
 28c:	8082                	ret

000000000000028e <link>:
.global link
link:
 li a7, SYS_link
 28e:	48cd                	li	a7,19
 ecall
 290:	00000073          	ecall
 ret
 294:	8082                	ret

0000000000000296 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 296:	48d1                	li	a7,20
 ecall
 298:	00000073          	ecall
 ret
 29c:	8082                	ret

000000000000029e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 29e:	48a5                	li	a7,9
 ecall
 2a0:	00000073          	ecall
 ret
 2a4:	8082                	ret

00000000000002a6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 2a6:	48a9                	li	a7,10
 ecall
 2a8:	00000073          	ecall
 ret
 2ac:	8082                	ret

00000000000002ae <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 2ae:	48ad                	li	a7,11
 ecall
 2b0:	00000073          	ecall
 ret
 2b4:	8082                	ret

00000000000002b6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 2b6:	48b1                	li	a7,12
 ecall
 2b8:	00000073          	ecall
 ret
 2bc:	8082                	ret

00000000000002be <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 2be:	48b5                	li	a7,13
 ecall
 2c0:	00000073          	ecall
 ret
 2c4:	8082                	ret

00000000000002c6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 2c6:	48b9                	li	a7,14
 ecall
 2c8:	00000073          	ecall
 ret
 2cc:	8082                	ret

00000000000002ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 2ce:	1101                	addi	sp,sp,-32
 2d0:	ec06                	sd	ra,24(sp)
 2d2:	e822                	sd	s0,16(sp)
 2d4:	1000                	addi	s0,sp,32
 2d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 2da:	4605                	li	a2,1
 2dc:	fef40593          	addi	a1,s0,-17
 2e0:	00000097          	auipc	ra,0x0
 2e4:	f6e080e7          	jalr	-146(ra) # 24e <write>
}
 2e8:	60e2                	ld	ra,24(sp)
 2ea:	6442                	ld	s0,16(sp)
 2ec:	6105                	addi	sp,sp,32
 2ee:	8082                	ret

00000000000002f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2f0:	7139                	addi	sp,sp,-64
 2f2:	fc06                	sd	ra,56(sp)
 2f4:	f822                	sd	s0,48(sp)
 2f6:	f426                	sd	s1,40(sp)
 2f8:	f04a                	sd	s2,32(sp)
 2fa:	ec4e                	sd	s3,24(sp)
 2fc:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2fe:	c299                	beqz	a3,304 <printint+0x14>
 300:	0005cd63          	bltz	a1,31a <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 304:	2581                	sext.w	a1,a1
  neg = 0;
 306:	4301                	li	t1,0
 308:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 30c:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 30e:	2601                	sext.w	a2,a2
 310:	00000897          	auipc	a7,0x0
 314:	44088893          	addi	a7,a7,1088 # 750 <digits>
 318:	a801                	j	328 <printint+0x38>
    x = -xx;
 31a:	40b005bb          	negw	a1,a1
 31e:	2581                	sext.w	a1,a1
    neg = 1;
 320:	4305                	li	t1,1
    x = -xx;
 322:	b7dd                	j	308 <printint+0x18>
  }while((x /= base) != 0);
 324:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 326:	8836                	mv	a6,a3
 328:	0018069b          	addiw	a3,a6,1
 32c:	02c5f7bb          	remuw	a5,a1,a2
 330:	1782                	slli	a5,a5,0x20
 332:	9381                	srli	a5,a5,0x20
 334:	97c6                	add	a5,a5,a7
 336:	0007c783          	lbu	a5,0(a5)
 33a:	00f70023          	sb	a5,0(a4)
 33e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 340:	02c5d7bb          	divuw	a5,a1,a2
 344:	fec5f0e3          	bleu	a2,a1,324 <printint+0x34>
  if(neg)
 348:	00030b63          	beqz	t1,35e <printint+0x6e>
    buf[i++] = '-';
 34c:	fd040793          	addi	a5,s0,-48
 350:	96be                	add	a3,a3,a5
 352:	02d00793          	li	a5,45
 356:	fef68823          	sb	a5,-16(a3)
 35a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 35e:	02d05963          	blez	a3,390 <printint+0xa0>
 362:	89aa                	mv	s3,a0
 364:	fc040793          	addi	a5,s0,-64
 368:	00d784b3          	add	s1,a5,a3
 36c:	fff78913          	addi	s2,a5,-1
 370:	9936                	add	s2,s2,a3
 372:	36fd                	addiw	a3,a3,-1
 374:	1682                	slli	a3,a3,0x20
 376:	9281                	srli	a3,a3,0x20
 378:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 37c:	fff4c583          	lbu	a1,-1(s1)
 380:	854e                	mv	a0,s3
 382:	00000097          	auipc	ra,0x0
 386:	f4c080e7          	jalr	-180(ra) # 2ce <putc>
 38a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 38c:	ff2498e3          	bne	s1,s2,37c <printint+0x8c>
}
 390:	70e2                	ld	ra,56(sp)
 392:	7442                	ld	s0,48(sp)
 394:	74a2                	ld	s1,40(sp)
 396:	7902                	ld	s2,32(sp)
 398:	69e2                	ld	s3,24(sp)
 39a:	6121                	addi	sp,sp,64
 39c:	8082                	ret

000000000000039e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 39e:	7119                	addi	sp,sp,-128
 3a0:	fc86                	sd	ra,120(sp)
 3a2:	f8a2                	sd	s0,112(sp)
 3a4:	f4a6                	sd	s1,104(sp)
 3a6:	f0ca                	sd	s2,96(sp)
 3a8:	ecce                	sd	s3,88(sp)
 3aa:	e8d2                	sd	s4,80(sp)
 3ac:	e4d6                	sd	s5,72(sp)
 3ae:	e0da                	sd	s6,64(sp)
 3b0:	fc5e                	sd	s7,56(sp)
 3b2:	f862                	sd	s8,48(sp)
 3b4:	f466                	sd	s9,40(sp)
 3b6:	f06a                	sd	s10,32(sp)
 3b8:	ec6e                	sd	s11,24(sp)
 3ba:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 3bc:	0005c483          	lbu	s1,0(a1)
 3c0:	18048d63          	beqz	s1,55a <vprintf+0x1bc>
 3c4:	8aaa                	mv	s5,a0
 3c6:	8b32                	mv	s6,a2
 3c8:	00158913          	addi	s2,a1,1
  state = 0;
 3cc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3ce:	02500a13          	li	s4,37
      if(c == 'd'){
 3d2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 3d6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 3da:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 3de:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 3e2:	00000b97          	auipc	s7,0x0
 3e6:	36eb8b93          	addi	s7,s7,878 # 750 <digits>
 3ea:	a839                	j	408 <vprintf+0x6a>
        putc(fd, c);
 3ec:	85a6                	mv	a1,s1
 3ee:	8556                	mv	a0,s5
 3f0:	00000097          	auipc	ra,0x0
 3f4:	ede080e7          	jalr	-290(ra) # 2ce <putc>
 3f8:	a019                	j	3fe <vprintf+0x60>
    } else if(state == '%'){
 3fa:	01498f63          	beq	s3,s4,418 <vprintf+0x7a>
 3fe:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 400:	fff94483          	lbu	s1,-1(s2)
 404:	14048b63          	beqz	s1,55a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 408:	0004879b          	sext.w	a5,s1
    if(state == 0){
 40c:	fe0997e3          	bnez	s3,3fa <vprintf+0x5c>
      if(c == '%'){
 410:	fd479ee3          	bne	a5,s4,3ec <vprintf+0x4e>
        state = '%';
 414:	89be                	mv	s3,a5
 416:	b7e5                	j	3fe <vprintf+0x60>
      if(c == 'd'){
 418:	05878063          	beq	a5,s8,458 <vprintf+0xba>
      } else if(c == 'l') {
 41c:	05978c63          	beq	a5,s9,474 <vprintf+0xd6>
      } else if(c == 'x') {
 420:	07a78863          	beq	a5,s10,490 <vprintf+0xf2>
      } else if(c == 'p') {
 424:	09b78463          	beq	a5,s11,4ac <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 428:	07300713          	li	a4,115
 42c:	0ce78563          	beq	a5,a4,4f6 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 430:	06300713          	li	a4,99
 434:	0ee78c63          	beq	a5,a4,52c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 438:	11478663          	beq	a5,s4,544 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 43c:	85d2                	mv	a1,s4
 43e:	8556                	mv	a0,s5
 440:	00000097          	auipc	ra,0x0
 444:	e8e080e7          	jalr	-370(ra) # 2ce <putc>
        putc(fd, c);
 448:	85a6                	mv	a1,s1
 44a:	8556                	mv	a0,s5
 44c:	00000097          	auipc	ra,0x0
 450:	e82080e7          	jalr	-382(ra) # 2ce <putc>
      }
      state = 0;
 454:	4981                	li	s3,0
 456:	b765                	j	3fe <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 458:	008b0493          	addi	s1,s6,8
 45c:	4685                	li	a3,1
 45e:	4629                	li	a2,10
 460:	000b2583          	lw	a1,0(s6)
 464:	8556                	mv	a0,s5
 466:	00000097          	auipc	ra,0x0
 46a:	e8a080e7          	jalr	-374(ra) # 2f0 <printint>
 46e:	8b26                	mv	s6,s1
      state = 0;
 470:	4981                	li	s3,0
 472:	b771                	j	3fe <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 474:	008b0493          	addi	s1,s6,8
 478:	4681                	li	a3,0
 47a:	4629                	li	a2,10
 47c:	000b2583          	lw	a1,0(s6)
 480:	8556                	mv	a0,s5
 482:	00000097          	auipc	ra,0x0
 486:	e6e080e7          	jalr	-402(ra) # 2f0 <printint>
 48a:	8b26                	mv	s6,s1
      state = 0;
 48c:	4981                	li	s3,0
 48e:	bf85                	j	3fe <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 490:	008b0493          	addi	s1,s6,8
 494:	4681                	li	a3,0
 496:	4641                	li	a2,16
 498:	000b2583          	lw	a1,0(s6)
 49c:	8556                	mv	a0,s5
 49e:	00000097          	auipc	ra,0x0
 4a2:	e52080e7          	jalr	-430(ra) # 2f0 <printint>
 4a6:	8b26                	mv	s6,s1
      state = 0;
 4a8:	4981                	li	s3,0
 4aa:	bf91                	j	3fe <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 4ac:	008b0793          	addi	a5,s6,8
 4b0:	f8f43423          	sd	a5,-120(s0)
 4b4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 4b8:	03000593          	li	a1,48
 4bc:	8556                	mv	a0,s5
 4be:	00000097          	auipc	ra,0x0
 4c2:	e10080e7          	jalr	-496(ra) # 2ce <putc>
  putc(fd, 'x');
 4c6:	85ea                	mv	a1,s10
 4c8:	8556                	mv	a0,s5
 4ca:	00000097          	auipc	ra,0x0
 4ce:	e04080e7          	jalr	-508(ra) # 2ce <putc>
 4d2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4d4:	03c9d793          	srli	a5,s3,0x3c
 4d8:	97de                	add	a5,a5,s7
 4da:	0007c583          	lbu	a1,0(a5)
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	dee080e7          	jalr	-530(ra) # 2ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 4e8:	0992                	slli	s3,s3,0x4
 4ea:	34fd                	addiw	s1,s1,-1
 4ec:	f4e5                	bnez	s1,4d4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 4ee:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 4f2:	4981                	li	s3,0
 4f4:	b729                	j	3fe <vprintf+0x60>
        s = va_arg(ap, char*);
 4f6:	008b0993          	addi	s3,s6,8
 4fa:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 4fe:	c085                	beqz	s1,51e <vprintf+0x180>
        while(*s != 0){
 500:	0004c583          	lbu	a1,0(s1)
 504:	c9a1                	beqz	a1,554 <vprintf+0x1b6>
          putc(fd, *s);
 506:	8556                	mv	a0,s5
 508:	00000097          	auipc	ra,0x0
 50c:	dc6080e7          	jalr	-570(ra) # 2ce <putc>
          s++;
 510:	0485                	addi	s1,s1,1
        while(*s != 0){
 512:	0004c583          	lbu	a1,0(s1)
 516:	f9e5                	bnez	a1,506 <vprintf+0x168>
        s = va_arg(ap, char*);
 518:	8b4e                	mv	s6,s3
      state = 0;
 51a:	4981                	li	s3,0
 51c:	b5cd                	j	3fe <vprintf+0x60>
          s = "(null)";
 51e:	00000497          	auipc	s1,0x0
 522:	24a48493          	addi	s1,s1,586 # 768 <digits+0x18>
        while(*s != 0){
 526:	02800593          	li	a1,40
 52a:	bff1                	j	506 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 52c:	008b0493          	addi	s1,s6,8
 530:	000b4583          	lbu	a1,0(s6)
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	d98080e7          	jalr	-616(ra) # 2ce <putc>
 53e:	8b26                	mv	s6,s1
      state = 0;
 540:	4981                	li	s3,0
 542:	bd75                	j	3fe <vprintf+0x60>
        putc(fd, c);
 544:	85d2                	mv	a1,s4
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	d86080e7          	jalr	-634(ra) # 2ce <putc>
      state = 0;
 550:	4981                	li	s3,0
 552:	b575                	j	3fe <vprintf+0x60>
        s = va_arg(ap, char*);
 554:	8b4e                	mv	s6,s3
      state = 0;
 556:	4981                	li	s3,0
 558:	b55d                	j	3fe <vprintf+0x60>
    }
  }
}
 55a:	70e6                	ld	ra,120(sp)
 55c:	7446                	ld	s0,112(sp)
 55e:	74a6                	ld	s1,104(sp)
 560:	7906                	ld	s2,96(sp)
 562:	69e6                	ld	s3,88(sp)
 564:	6a46                	ld	s4,80(sp)
 566:	6aa6                	ld	s5,72(sp)
 568:	6b06                	ld	s6,64(sp)
 56a:	7be2                	ld	s7,56(sp)
 56c:	7c42                	ld	s8,48(sp)
 56e:	7ca2                	ld	s9,40(sp)
 570:	7d02                	ld	s10,32(sp)
 572:	6de2                	ld	s11,24(sp)
 574:	6109                	addi	sp,sp,128
 576:	8082                	ret

0000000000000578 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 578:	715d                	addi	sp,sp,-80
 57a:	ec06                	sd	ra,24(sp)
 57c:	e822                	sd	s0,16(sp)
 57e:	1000                	addi	s0,sp,32
 580:	e010                	sd	a2,0(s0)
 582:	e414                	sd	a3,8(s0)
 584:	e818                	sd	a4,16(s0)
 586:	ec1c                	sd	a5,24(s0)
 588:	03043023          	sd	a6,32(s0)
 58c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 590:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 594:	8622                	mv	a2,s0
 596:	00000097          	auipc	ra,0x0
 59a:	e08080e7          	jalr	-504(ra) # 39e <vprintf>
}
 59e:	60e2                	ld	ra,24(sp)
 5a0:	6442                	ld	s0,16(sp)
 5a2:	6161                	addi	sp,sp,80
 5a4:	8082                	ret

00000000000005a6 <printf>:

void
printf(const char *fmt, ...)
{
 5a6:	711d                	addi	sp,sp,-96
 5a8:	ec06                	sd	ra,24(sp)
 5aa:	e822                	sd	s0,16(sp)
 5ac:	1000                	addi	s0,sp,32
 5ae:	e40c                	sd	a1,8(s0)
 5b0:	e810                	sd	a2,16(s0)
 5b2:	ec14                	sd	a3,24(s0)
 5b4:	f018                	sd	a4,32(s0)
 5b6:	f41c                	sd	a5,40(s0)
 5b8:	03043823          	sd	a6,48(s0)
 5bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 5c0:	00840613          	addi	a2,s0,8
 5c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 5c8:	85aa                	mv	a1,a0
 5ca:	4505                	li	a0,1
 5cc:	00000097          	auipc	ra,0x0
 5d0:	dd2080e7          	jalr	-558(ra) # 39e <vprintf>
}
 5d4:	60e2                	ld	ra,24(sp)
 5d6:	6442                	ld	s0,16(sp)
 5d8:	6125                	addi	sp,sp,96
 5da:	8082                	ret

00000000000005dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e6:	00000797          	auipc	a5,0x0
 5ea:	18a78793          	addi	a5,a5,394 # 770 <__bss_start>
 5ee:	639c                	ld	a5,0(a5)
 5f0:	a805                	j	620 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5f2:	4618                	lw	a4,8(a2)
 5f4:	9db9                	addw	a1,a1,a4
 5f6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 5fa:	6398                	ld	a4,0(a5)
 5fc:	6318                	ld	a4,0(a4)
 5fe:	fee53823          	sd	a4,-16(a0)
 602:	a091                	j	646 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 604:	ff852703          	lw	a4,-8(a0)
 608:	9e39                	addw	a2,a2,a4
 60a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 60c:	ff053703          	ld	a4,-16(a0)
 610:	e398                	sd	a4,0(a5)
 612:	a099                	j	658 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	6398                	ld	a4,0(a5)
 616:	00e7e463          	bltu	a5,a4,61e <free+0x42>
 61a:	00e6ea63          	bltu	a3,a4,62e <free+0x52>
{
 61e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 620:	fed7fae3          	bleu	a3,a5,614 <free+0x38>
 624:	6398                	ld	a4,0(a5)
 626:	00e6e463          	bltu	a3,a4,62e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62a:	fee7eae3          	bltu	a5,a4,61e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 62e:	ff852583          	lw	a1,-8(a0)
 632:	6390                	ld	a2,0(a5)
 634:	02059713          	slli	a4,a1,0x20
 638:	9301                	srli	a4,a4,0x20
 63a:	0712                	slli	a4,a4,0x4
 63c:	9736                	add	a4,a4,a3
 63e:	fae60ae3          	beq	a2,a4,5f2 <free+0x16>
    bp->s.ptr = p->s.ptr;
 642:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 646:	4790                	lw	a2,8(a5)
 648:	02061713          	slli	a4,a2,0x20
 64c:	9301                	srli	a4,a4,0x20
 64e:	0712                	slli	a4,a4,0x4
 650:	973e                	add	a4,a4,a5
 652:	fae689e3          	beq	a3,a4,604 <free+0x28>
  } else
    p->s.ptr = bp;
 656:	e394                	sd	a3,0(a5)
  freep = p;
 658:	00000717          	auipc	a4,0x0
 65c:	10f73c23          	sd	a5,280(a4) # 770 <__bss_start>
}
 660:	6422                	ld	s0,8(sp)
 662:	0141                	addi	sp,sp,16
 664:	8082                	ret

0000000000000666 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 666:	7139                	addi	sp,sp,-64
 668:	fc06                	sd	ra,56(sp)
 66a:	f822                	sd	s0,48(sp)
 66c:	f426                	sd	s1,40(sp)
 66e:	f04a                	sd	s2,32(sp)
 670:	ec4e                	sd	s3,24(sp)
 672:	e852                	sd	s4,16(sp)
 674:	e456                	sd	s5,8(sp)
 676:	e05a                	sd	s6,0(sp)
 678:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 67a:	02051993          	slli	s3,a0,0x20
 67e:	0209d993          	srli	s3,s3,0x20
 682:	09bd                	addi	s3,s3,15
 684:	0049d993          	srli	s3,s3,0x4
 688:	2985                	addiw	s3,s3,1
 68a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 68e:	00000797          	auipc	a5,0x0
 692:	0e278793          	addi	a5,a5,226 # 770 <__bss_start>
 696:	6388                	ld	a0,0(a5)
 698:	c515                	beqz	a0,6c4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 69a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 69c:	4798                	lw	a4,8(a5)
 69e:	03277f63          	bleu	s2,a4,6dc <malloc+0x76>
 6a2:	8a4e                	mv	s4,s3
 6a4:	0009871b          	sext.w	a4,s3
 6a8:	6685                	lui	a3,0x1
 6aa:	00d77363          	bleu	a3,a4,6b0 <malloc+0x4a>
 6ae:	6a05                	lui	s4,0x1
 6b0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 6b4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b8:	00000497          	auipc	s1,0x0
 6bc:	0b848493          	addi	s1,s1,184 # 770 <__bss_start>
  if(p == (char*)-1)
 6c0:	5b7d                	li	s6,-1
 6c2:	a885                	j	732 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 6c4:	00000797          	auipc	a5,0x0
 6c8:	0b478793          	addi	a5,a5,180 # 778 <base>
 6cc:	00000717          	auipc	a4,0x0
 6d0:	0af73223          	sd	a5,164(a4) # 770 <__bss_start>
 6d4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 6d6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 6da:	b7e1                	j	6a2 <malloc+0x3c>
      if(p->s.size == nunits)
 6dc:	02e90b63          	beq	s2,a4,712 <malloc+0xac>
        p->s.size -= nunits;
 6e0:	4137073b          	subw	a4,a4,s3
 6e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 6e6:	1702                	slli	a4,a4,0x20
 6e8:	9301                	srli	a4,a4,0x20
 6ea:	0712                	slli	a4,a4,0x4
 6ec:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 6ee:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 6f2:	00000717          	auipc	a4,0x0
 6f6:	06a73f23          	sd	a0,126(a4) # 770 <__bss_start>
      return (void*)(p + 1);
 6fa:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6fe:	70e2                	ld	ra,56(sp)
 700:	7442                	ld	s0,48(sp)
 702:	74a2                	ld	s1,40(sp)
 704:	7902                	ld	s2,32(sp)
 706:	69e2                	ld	s3,24(sp)
 708:	6a42                	ld	s4,16(sp)
 70a:	6aa2                	ld	s5,8(sp)
 70c:	6b02                	ld	s6,0(sp)
 70e:	6121                	addi	sp,sp,64
 710:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 712:	6398                	ld	a4,0(a5)
 714:	e118                	sd	a4,0(a0)
 716:	bff1                	j	6f2 <malloc+0x8c>
  hp->s.size = nu;
 718:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 71c:	0541                	addi	a0,a0,16
 71e:	00000097          	auipc	ra,0x0
 722:	ebe080e7          	jalr	-322(ra) # 5dc <free>
  return freep;
 726:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 728:	d979                	beqz	a0,6fe <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 72a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 72c:	4798                	lw	a4,8(a5)
 72e:	fb2777e3          	bleu	s2,a4,6dc <malloc+0x76>
    if(p == freep)
 732:	6098                	ld	a4,0(s1)
 734:	853e                	mv	a0,a5
 736:	fef71ae3          	bne	a4,a5,72a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 73a:	8552                	mv	a0,s4
 73c:	00000097          	auipc	ra,0x0
 740:	b7a080e7          	jalr	-1158(ra) # 2b6 <sbrk>
  if(p == (char*)-1)
 744:	fd651ae3          	bne	a0,s6,718 <malloc+0xb2>
        return 0;
 748:	4501                	li	a0,0
 74a:	bf55                	j	6fe <malloc+0x98>
