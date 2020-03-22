
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d763          	ble	a0,a5,3e <main+0x3e>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	1902                	slli	s2,s2,0x20
  1e:	02095913          	srli	s2,s2,0x20
  22:	090e                	slli	s2,s2,0x3
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  28:	6088                	ld	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	2ba080e7          	jalr	698(ra) # 2e4 <mkdir>
  32:	02054463          	bltz	a0,5a <main+0x5a>
  36:	04a1                	addi	s1,s1,8
  for(i = 1; i < argc; i++){
  38:	ff2498e3          	bne	s1,s2,28 <main+0x28>
  3c:	a80d                	j	6e <main+0x6e>
    fprintf(2, "Usage: mkdir files...\n");
  3e:	00000597          	auipc	a1,0x0
  42:	76258593          	addi	a1,a1,1890 # 7a0 <malloc+0xec>
  46:	4509                	li	a0,2
  48:	00000097          	auipc	ra,0x0
  4c:	57e080e7          	jalr	1406(ra) # 5c6 <fprintf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	22a080e7          	jalr	554(ra) # 27c <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	6090                	ld	a2,0(s1)
  5c:	00000597          	auipc	a1,0x0
  60:	75c58593          	addi	a1,a1,1884 # 7b8 <malloc+0x104>
  64:	4509                	li	a0,2
  66:	00000097          	auipc	ra,0x0
  6a:	560080e7          	jalr	1376(ra) # 5c6 <fprintf>
      break;
    }
  }

  exit(0);
  6e:	4501                	li	a0,0
  70:	00000097          	auipc	ra,0x0
  74:	20c080e7          	jalr	524(ra) # 27c <exit>

0000000000000078 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	87aa                	mv	a5,a0
  80:	0585                	addi	a1,a1,1
  82:	0785                	addi	a5,a5,1
  84:	fff5c703          	lbu	a4,-1(a1)
  88:	fee78fa3          	sb	a4,-1(a5)
  8c:	fb75                	bnez	a4,80 <strcpy+0x8>
    ;
  return os;
}
  8e:	6422                	ld	s0,8(sp)
  90:	0141                	addi	sp,sp,16
  92:	8082                	ret

0000000000000094 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  94:	1141                	addi	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	cf91                	beqz	a5,ba <strcmp+0x26>
  a0:	0005c703          	lbu	a4,0(a1)
  a4:	00f71b63          	bne	a4,a5,ba <strcmp+0x26>
    p++, q++;
  a8:	0505                	addi	a0,a0,1
  aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	c789                	beqz	a5,ba <strcmp+0x26>
  b2:	0005c703          	lbu	a4,0(a1)
  b6:	fef709e3          	beq	a4,a5,a8 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ba:	0005c503          	lbu	a0,0(a1)
}
  be:	40a7853b          	subw	a0,a5,a0
  c2:	6422                	ld	s0,8(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e422                	sd	s0,8(sp)
  cc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ce:	00054783          	lbu	a5,0(a0)
  d2:	cf91                	beqz	a5,ee <strlen+0x26>
  d4:	0505                	addi	a0,a0,1
  d6:	87aa                	mv	a5,a0
  d8:	4685                	li	a3,1
  da:	9e89                	subw	a3,a3,a0
    ;
  dc:	00f6853b          	addw	a0,a3,a5
  e0:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  e2:	fff7c703          	lbu	a4,-1(a5)
  e6:	fb7d                	bnez	a4,dc <strlen+0x14>
  return n;
}
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret
  for(n = 0; s[n]; n++)
  ee:	4501                	li	a0,0
  f0:	bfe5                	j	e8 <strlen+0x20>

00000000000000f2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f8:	ce09                	beqz	a2,112 <memset+0x20>
  fa:	87aa                	mv	a5,a0
  fc:	fff6071b          	addiw	a4,a2,-1
 100:	1702                	slli	a4,a4,0x20
 102:	9301                	srli	a4,a4,0x20
 104:	0705                	addi	a4,a4,1
 106:	972a                	add	a4,a4,a0
    cdst[i] = c;
 108:	00b78023          	sb	a1,0(a5)
 10c:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 10e:	fee79de3          	bne	a5,a4,108 <memset+0x16>
  }
  return dst;
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret

0000000000000118 <strchr>:

char*
strchr(const char *s, char c)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 11e:	00054783          	lbu	a5,0(a0)
 122:	cf91                	beqz	a5,13e <strchr+0x26>
    if(*s == c)
 124:	00f58a63          	beq	a1,a5,138 <strchr+0x20>
  for(; *s; s++)
 128:	0505                	addi	a0,a0,1
 12a:	00054783          	lbu	a5,0(a0)
 12e:	c781                	beqz	a5,136 <strchr+0x1e>
    if(*s == c)
 130:	feb79ce3          	bne	a5,a1,128 <strchr+0x10>
 134:	a011                	j	138 <strchr+0x20>
      return (char*)s;
  return 0;
 136:	4501                	li	a0,0
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret
  return 0;
 13e:	4501                	li	a0,0
 140:	bfe5                	j	138 <strchr+0x20>

0000000000000142 <gets>:

char*
gets(char *buf, int max)
{
 142:	711d                	addi	sp,sp,-96
 144:	ec86                	sd	ra,88(sp)
 146:	e8a2                	sd	s0,80(sp)
 148:	e4a6                	sd	s1,72(sp)
 14a:	e0ca                	sd	s2,64(sp)
 14c:	fc4e                	sd	s3,56(sp)
 14e:	f852                	sd	s4,48(sp)
 150:	f456                	sd	s5,40(sp)
 152:	f05a                	sd	s6,32(sp)
 154:	ec5e                	sd	s7,24(sp)
 156:	1080                	addi	s0,sp,96
 158:	8baa                	mv	s7,a0
 15a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15c:	892a                	mv	s2,a0
 15e:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 160:	4aa9                	li	s5,10
 162:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 164:	0019849b          	addiw	s1,s3,1
 168:	0344d863          	ble	s4,s1,198 <gets+0x56>
    cc = read(0, &c, 1);
 16c:	4605                	li	a2,1
 16e:	faf40593          	addi	a1,s0,-81
 172:	4501                	li	a0,0
 174:	00000097          	auipc	ra,0x0
 178:	120080e7          	jalr	288(ra) # 294 <read>
    if(cc < 1)
 17c:	00a05e63          	blez	a0,198 <gets+0x56>
    buf[i++] = c;
 180:	faf44783          	lbu	a5,-81(s0)
 184:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 188:	01578763          	beq	a5,s5,196 <gets+0x54>
 18c:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 18e:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 190:	fd679ae3          	bne	a5,s6,164 <gets+0x22>
 194:	a011                	j	198 <gets+0x56>
  for(i=0; i+1 < max; ){
 196:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 198:	99de                	add	s3,s3,s7
 19a:	00098023          	sb	zero,0(s3)
  return buf;
}
 19e:	855e                	mv	a0,s7
 1a0:	60e6                	ld	ra,88(sp)
 1a2:	6446                	ld	s0,80(sp)
 1a4:	64a6                	ld	s1,72(sp)
 1a6:	6906                	ld	s2,64(sp)
 1a8:	79e2                	ld	s3,56(sp)
 1aa:	7a42                	ld	s4,48(sp)
 1ac:	7aa2                	ld	s5,40(sp)
 1ae:	7b02                	ld	s6,32(sp)
 1b0:	6be2                	ld	s7,24(sp)
 1b2:	6125                	addi	sp,sp,96
 1b4:	8082                	ret

00000000000001b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b6:	1101                	addi	sp,sp,-32
 1b8:	ec06                	sd	ra,24(sp)
 1ba:	e822                	sd	s0,16(sp)
 1bc:	e426                	sd	s1,8(sp)
 1be:	e04a                	sd	s2,0(sp)
 1c0:	1000                	addi	s0,sp,32
 1c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c4:	4581                	li	a1,0
 1c6:	00000097          	auipc	ra,0x0
 1ca:	0f6080e7          	jalr	246(ra) # 2bc <open>
  if(fd < 0)
 1ce:	02054563          	bltz	a0,1f8 <stat+0x42>
 1d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d4:	85ca                	mv	a1,s2
 1d6:	00000097          	auipc	ra,0x0
 1da:	0fe080e7          	jalr	254(ra) # 2d4 <fstat>
 1de:	892a                	mv	s2,a0
  close(fd);
 1e0:	8526                	mv	a0,s1
 1e2:	00000097          	auipc	ra,0x0
 1e6:	0c2080e7          	jalr	194(ra) # 2a4 <close>
  return r;
}
 1ea:	854a                	mv	a0,s2
 1ec:	60e2                	ld	ra,24(sp)
 1ee:	6442                	ld	s0,16(sp)
 1f0:	64a2                	ld	s1,8(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    return -1;
 1f8:	597d                	li	s2,-1
 1fa:	bfc5                	j	1ea <stat+0x34>

00000000000001fc <atoi>:

int
atoi(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 202:	00054683          	lbu	a3,0(a0)
 206:	fd06879b          	addiw	a5,a3,-48
 20a:	0ff7f793          	andi	a5,a5,255
 20e:	4725                	li	a4,9
 210:	02f76963          	bltu	a4,a5,242 <atoi+0x46>
 214:	862a                	mv	a2,a0
  n = 0;
 216:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 218:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 21a:	0605                	addi	a2,a2,1
 21c:	0025179b          	slliw	a5,a0,0x2
 220:	9fa9                	addw	a5,a5,a0
 222:	0017979b          	slliw	a5,a5,0x1
 226:	9fb5                	addw	a5,a5,a3
 228:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22c:	00064683          	lbu	a3,0(a2)
 230:	fd06871b          	addiw	a4,a3,-48
 234:	0ff77713          	andi	a4,a4,255
 238:	fee5f1e3          	bleu	a4,a1,21a <atoi+0x1e>
  return n;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  n = 0;
 242:	4501                	li	a0,0
 244:	bfe5                	j	23c <atoi+0x40>

0000000000000246 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24c:	02c05163          	blez	a2,26e <memmove+0x28>
 250:	fff6071b          	addiw	a4,a2,-1
 254:	1702                	slli	a4,a4,0x20
 256:	9301                	srli	a4,a4,0x20
 258:	0705                	addi	a4,a4,1
 25a:	972a                	add	a4,a4,a0
  dst = vdst;
 25c:	87aa                	mv	a5,a0
    *dst++ = *src++;
 25e:	0585                	addi	a1,a1,1
 260:	0785                	addi	a5,a5,1
 262:	fff5c683          	lbu	a3,-1(a1)
 266:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 26a:	fee79ae3          	bne	a5,a4,25e <memmove+0x18>
  return vdst;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret

0000000000000274 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 274:	4885                	li	a7,1
 ecall
 276:	00000073          	ecall
 ret
 27a:	8082                	ret

000000000000027c <exit>:
.global exit
exit:
 li a7, SYS_exit
 27c:	4889                	li	a7,2
 ecall
 27e:	00000073          	ecall
 ret
 282:	8082                	ret

0000000000000284 <wait>:
.global wait
wait:
 li a7, SYS_wait
 284:	488d                	li	a7,3
 ecall
 286:	00000073          	ecall
 ret
 28a:	8082                	ret

000000000000028c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 28c:	4891                	li	a7,4
 ecall
 28e:	00000073          	ecall
 ret
 292:	8082                	ret

0000000000000294 <read>:
.global read
read:
 li a7, SYS_read
 294:	4895                	li	a7,5
 ecall
 296:	00000073          	ecall
 ret
 29a:	8082                	ret

000000000000029c <write>:
.global write
write:
 li a7, SYS_write
 29c:	48c1                	li	a7,16
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <close>:
.global close
close:
 li a7, SYS_close
 2a4:	48d5                	li	a7,21
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 2ac:	4899                	li	a7,6
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2b4:	489d                	li	a7,7
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <open>:
.global open
open:
 li a7, SYS_open
 2bc:	48bd                	li	a7,15
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2c4:	48c5                	li	a7,17
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2cc:	48c9                	li	a7,18
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2d4:	48a1                	li	a7,8
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <link>:
.global link
link:
 li a7, SYS_link
 2dc:	48cd                	li	a7,19
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2e4:	48d1                	li	a7,20
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2ec:	48a5                	li	a7,9
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 2f4:	48a9                	li	a7,10
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 2fc:	48ad                	li	a7,11
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 304:	48b1                	li	a7,12
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 30c:	48b5                	li	a7,13
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 314:	48b9                	li	a7,14
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 31c:	1101                	addi	sp,sp,-32
 31e:	ec06                	sd	ra,24(sp)
 320:	e822                	sd	s0,16(sp)
 322:	1000                	addi	s0,sp,32
 324:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 328:	4605                	li	a2,1
 32a:	fef40593          	addi	a1,s0,-17
 32e:	00000097          	auipc	ra,0x0
 332:	f6e080e7          	jalr	-146(ra) # 29c <write>
}
 336:	60e2                	ld	ra,24(sp)
 338:	6442                	ld	s0,16(sp)
 33a:	6105                	addi	sp,sp,32
 33c:	8082                	ret

000000000000033e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 33e:	7139                	addi	sp,sp,-64
 340:	fc06                	sd	ra,56(sp)
 342:	f822                	sd	s0,48(sp)
 344:	f426                	sd	s1,40(sp)
 346:	f04a                	sd	s2,32(sp)
 348:	ec4e                	sd	s3,24(sp)
 34a:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34c:	c299                	beqz	a3,352 <printint+0x14>
 34e:	0005cd63          	bltz	a1,368 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 352:	2581                	sext.w	a1,a1
  neg = 0;
 354:	4301                	li	t1,0
 356:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 35a:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 35c:	2601                	sext.w	a2,a2
 35e:	00000897          	auipc	a7,0x0
 362:	47a88893          	addi	a7,a7,1146 # 7d8 <digits>
 366:	a801                	j	376 <printint+0x38>
    x = -xx;
 368:	40b005bb          	negw	a1,a1
 36c:	2581                	sext.w	a1,a1
    neg = 1;
 36e:	4305                	li	t1,1
    x = -xx;
 370:	b7dd                	j	356 <printint+0x18>
  }while((x /= base) != 0);
 372:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 374:	8836                	mv	a6,a3
 376:	0018069b          	addiw	a3,a6,1
 37a:	02c5f7bb          	remuw	a5,a1,a2
 37e:	1782                	slli	a5,a5,0x20
 380:	9381                	srli	a5,a5,0x20
 382:	97c6                	add	a5,a5,a7
 384:	0007c783          	lbu	a5,0(a5)
 388:	00f70023          	sb	a5,0(a4)
 38c:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 38e:	02c5d7bb          	divuw	a5,a1,a2
 392:	fec5f0e3          	bleu	a2,a1,372 <printint+0x34>
  if(neg)
 396:	00030b63          	beqz	t1,3ac <printint+0x6e>
    buf[i++] = '-';
 39a:	fd040793          	addi	a5,s0,-48
 39e:	96be                	add	a3,a3,a5
 3a0:	02d00793          	li	a5,45
 3a4:	fef68823          	sb	a5,-16(a3)
 3a8:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 3ac:	02d05963          	blez	a3,3de <printint+0xa0>
 3b0:	89aa                	mv	s3,a0
 3b2:	fc040793          	addi	a5,s0,-64
 3b6:	00d784b3          	add	s1,a5,a3
 3ba:	fff78913          	addi	s2,a5,-1
 3be:	9936                	add	s2,s2,a3
 3c0:	36fd                	addiw	a3,a3,-1
 3c2:	1682                	slli	a3,a3,0x20
 3c4:	9281                	srli	a3,a3,0x20
 3c6:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 3ca:	fff4c583          	lbu	a1,-1(s1)
 3ce:	854e                	mv	a0,s3
 3d0:	00000097          	auipc	ra,0x0
 3d4:	f4c080e7          	jalr	-180(ra) # 31c <putc>
 3d8:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 3da:	ff2498e3          	bne	s1,s2,3ca <printint+0x8c>
}
 3de:	70e2                	ld	ra,56(sp)
 3e0:	7442                	ld	s0,48(sp)
 3e2:	74a2                	ld	s1,40(sp)
 3e4:	7902                	ld	s2,32(sp)
 3e6:	69e2                	ld	s3,24(sp)
 3e8:	6121                	addi	sp,sp,64
 3ea:	8082                	ret

00000000000003ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3ec:	7119                	addi	sp,sp,-128
 3ee:	fc86                	sd	ra,120(sp)
 3f0:	f8a2                	sd	s0,112(sp)
 3f2:	f4a6                	sd	s1,104(sp)
 3f4:	f0ca                	sd	s2,96(sp)
 3f6:	ecce                	sd	s3,88(sp)
 3f8:	e8d2                	sd	s4,80(sp)
 3fa:	e4d6                	sd	s5,72(sp)
 3fc:	e0da                	sd	s6,64(sp)
 3fe:	fc5e                	sd	s7,56(sp)
 400:	f862                	sd	s8,48(sp)
 402:	f466                	sd	s9,40(sp)
 404:	f06a                	sd	s10,32(sp)
 406:	ec6e                	sd	s11,24(sp)
 408:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 40a:	0005c483          	lbu	s1,0(a1)
 40e:	18048d63          	beqz	s1,5a8 <vprintf+0x1bc>
 412:	8aaa                	mv	s5,a0
 414:	8b32                	mv	s6,a2
 416:	00158913          	addi	s2,a1,1
  state = 0;
 41a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 41c:	02500a13          	li	s4,37
      if(c == 'd'){
 420:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 424:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 428:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 42c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 430:	00000b97          	auipc	s7,0x0
 434:	3a8b8b93          	addi	s7,s7,936 # 7d8 <digits>
 438:	a839                	j	456 <vprintf+0x6a>
        putc(fd, c);
 43a:	85a6                	mv	a1,s1
 43c:	8556                	mv	a0,s5
 43e:	00000097          	auipc	ra,0x0
 442:	ede080e7          	jalr	-290(ra) # 31c <putc>
 446:	a019                	j	44c <vprintf+0x60>
    } else if(state == '%'){
 448:	01498f63          	beq	s3,s4,466 <vprintf+0x7a>
 44c:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 44e:	fff94483          	lbu	s1,-1(s2)
 452:	14048b63          	beqz	s1,5a8 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 456:	0004879b          	sext.w	a5,s1
    if(state == 0){
 45a:	fe0997e3          	bnez	s3,448 <vprintf+0x5c>
      if(c == '%'){
 45e:	fd479ee3          	bne	a5,s4,43a <vprintf+0x4e>
        state = '%';
 462:	89be                	mv	s3,a5
 464:	b7e5                	j	44c <vprintf+0x60>
      if(c == 'd'){
 466:	05878063          	beq	a5,s8,4a6 <vprintf+0xba>
      } else if(c == 'l') {
 46a:	05978c63          	beq	a5,s9,4c2 <vprintf+0xd6>
      } else if(c == 'x') {
 46e:	07a78863          	beq	a5,s10,4de <vprintf+0xf2>
      } else if(c == 'p') {
 472:	09b78463          	beq	a5,s11,4fa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 476:	07300713          	li	a4,115
 47a:	0ce78563          	beq	a5,a4,544 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 47e:	06300713          	li	a4,99
 482:	0ee78c63          	beq	a5,a4,57a <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 486:	11478663          	beq	a5,s4,592 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 48a:	85d2                	mv	a1,s4
 48c:	8556                	mv	a0,s5
 48e:	00000097          	auipc	ra,0x0
 492:	e8e080e7          	jalr	-370(ra) # 31c <putc>
        putc(fd, c);
 496:	85a6                	mv	a1,s1
 498:	8556                	mv	a0,s5
 49a:	00000097          	auipc	ra,0x0
 49e:	e82080e7          	jalr	-382(ra) # 31c <putc>
      }
      state = 0;
 4a2:	4981                	li	s3,0
 4a4:	b765                	j	44c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4a6:	008b0493          	addi	s1,s6,8
 4aa:	4685                	li	a3,1
 4ac:	4629                	li	a2,10
 4ae:	000b2583          	lw	a1,0(s6)
 4b2:	8556                	mv	a0,s5
 4b4:	00000097          	auipc	ra,0x0
 4b8:	e8a080e7          	jalr	-374(ra) # 33e <printint>
 4bc:	8b26                	mv	s6,s1
      state = 0;
 4be:	4981                	li	s3,0
 4c0:	b771                	j	44c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4c2:	008b0493          	addi	s1,s6,8
 4c6:	4681                	li	a3,0
 4c8:	4629                	li	a2,10
 4ca:	000b2583          	lw	a1,0(s6)
 4ce:	8556                	mv	a0,s5
 4d0:	00000097          	auipc	ra,0x0
 4d4:	e6e080e7          	jalr	-402(ra) # 33e <printint>
 4d8:	8b26                	mv	s6,s1
      state = 0;
 4da:	4981                	li	s3,0
 4dc:	bf85                	j	44c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 4de:	008b0493          	addi	s1,s6,8
 4e2:	4681                	li	a3,0
 4e4:	4641                	li	a2,16
 4e6:	000b2583          	lw	a1,0(s6)
 4ea:	8556                	mv	a0,s5
 4ec:	00000097          	auipc	ra,0x0
 4f0:	e52080e7          	jalr	-430(ra) # 33e <printint>
 4f4:	8b26                	mv	s6,s1
      state = 0;
 4f6:	4981                	li	s3,0
 4f8:	bf91                	j	44c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 4fa:	008b0793          	addi	a5,s6,8
 4fe:	f8f43423          	sd	a5,-120(s0)
 502:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 506:	03000593          	li	a1,48
 50a:	8556                	mv	a0,s5
 50c:	00000097          	auipc	ra,0x0
 510:	e10080e7          	jalr	-496(ra) # 31c <putc>
  putc(fd, 'x');
 514:	85ea                	mv	a1,s10
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	e04080e7          	jalr	-508(ra) # 31c <putc>
 520:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 522:	03c9d793          	srli	a5,s3,0x3c
 526:	97de                	add	a5,a5,s7
 528:	0007c583          	lbu	a1,0(a5)
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	dee080e7          	jalr	-530(ra) # 31c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 536:	0992                	slli	s3,s3,0x4
 538:	34fd                	addiw	s1,s1,-1
 53a:	f4e5                	bnez	s1,522 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 53c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 540:	4981                	li	s3,0
 542:	b729                	j	44c <vprintf+0x60>
        s = va_arg(ap, char*);
 544:	008b0993          	addi	s3,s6,8
 548:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 54c:	c085                	beqz	s1,56c <vprintf+0x180>
        while(*s != 0){
 54e:	0004c583          	lbu	a1,0(s1)
 552:	c9a1                	beqz	a1,5a2 <vprintf+0x1b6>
          putc(fd, *s);
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	dc6080e7          	jalr	-570(ra) # 31c <putc>
          s++;
 55e:	0485                	addi	s1,s1,1
        while(*s != 0){
 560:	0004c583          	lbu	a1,0(s1)
 564:	f9e5                	bnez	a1,554 <vprintf+0x168>
        s = va_arg(ap, char*);
 566:	8b4e                	mv	s6,s3
      state = 0;
 568:	4981                	li	s3,0
 56a:	b5cd                	j	44c <vprintf+0x60>
          s = "(null)";
 56c:	00000497          	auipc	s1,0x0
 570:	28448493          	addi	s1,s1,644 # 7f0 <digits+0x18>
        while(*s != 0){
 574:	02800593          	li	a1,40
 578:	bff1                	j	554 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 57a:	008b0493          	addi	s1,s6,8
 57e:	000b4583          	lbu	a1,0(s6)
 582:	8556                	mv	a0,s5
 584:	00000097          	auipc	ra,0x0
 588:	d98080e7          	jalr	-616(ra) # 31c <putc>
 58c:	8b26                	mv	s6,s1
      state = 0;
 58e:	4981                	li	s3,0
 590:	bd75                	j	44c <vprintf+0x60>
        putc(fd, c);
 592:	85d2                	mv	a1,s4
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	d86080e7          	jalr	-634(ra) # 31c <putc>
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	b575                	j	44c <vprintf+0x60>
        s = va_arg(ap, char*);
 5a2:	8b4e                	mv	s6,s3
      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	b55d                	j	44c <vprintf+0x60>
    }
  }
}
 5a8:	70e6                	ld	ra,120(sp)
 5aa:	7446                	ld	s0,112(sp)
 5ac:	74a6                	ld	s1,104(sp)
 5ae:	7906                	ld	s2,96(sp)
 5b0:	69e6                	ld	s3,88(sp)
 5b2:	6a46                	ld	s4,80(sp)
 5b4:	6aa6                	ld	s5,72(sp)
 5b6:	6b06                	ld	s6,64(sp)
 5b8:	7be2                	ld	s7,56(sp)
 5ba:	7c42                	ld	s8,48(sp)
 5bc:	7ca2                	ld	s9,40(sp)
 5be:	7d02                	ld	s10,32(sp)
 5c0:	6de2                	ld	s11,24(sp)
 5c2:	6109                	addi	sp,sp,128
 5c4:	8082                	ret

00000000000005c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5c6:	715d                	addi	sp,sp,-80
 5c8:	ec06                	sd	ra,24(sp)
 5ca:	e822                	sd	s0,16(sp)
 5cc:	1000                	addi	s0,sp,32
 5ce:	e010                	sd	a2,0(s0)
 5d0:	e414                	sd	a3,8(s0)
 5d2:	e818                	sd	a4,16(s0)
 5d4:	ec1c                	sd	a5,24(s0)
 5d6:	03043023          	sd	a6,32(s0)
 5da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 5de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 5e2:	8622                	mv	a2,s0
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e08080e7          	jalr	-504(ra) # 3ec <vprintf>
}
 5ec:	60e2                	ld	ra,24(sp)
 5ee:	6442                	ld	s0,16(sp)
 5f0:	6161                	addi	sp,sp,80
 5f2:	8082                	ret

00000000000005f4 <printf>:

void
printf(const char *fmt, ...)
{
 5f4:	711d                	addi	sp,sp,-96
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	1000                	addi	s0,sp,32
 5fc:	e40c                	sd	a1,8(s0)
 5fe:	e810                	sd	a2,16(s0)
 600:	ec14                	sd	a3,24(s0)
 602:	f018                	sd	a4,32(s0)
 604:	f41c                	sd	a5,40(s0)
 606:	03043823          	sd	a6,48(s0)
 60a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 60e:	00840613          	addi	a2,s0,8
 612:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 616:	85aa                	mv	a1,a0
 618:	4505                	li	a0,1
 61a:	00000097          	auipc	ra,0x0
 61e:	dd2080e7          	jalr	-558(ra) # 3ec <vprintf>
}
 622:	60e2                	ld	ra,24(sp)
 624:	6442                	ld	s0,16(sp)
 626:	6125                	addi	sp,sp,96
 628:	8082                	ret

000000000000062a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 62a:	1141                	addi	sp,sp,-16
 62c:	e422                	sd	s0,8(sp)
 62e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 630:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 634:	00000797          	auipc	a5,0x0
 638:	1c478793          	addi	a5,a5,452 # 7f8 <__bss_start>
 63c:	639c                	ld	a5,0(a5)
 63e:	a805                	j	66e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 640:	4618                	lw	a4,8(a2)
 642:	9db9                	addw	a1,a1,a4
 644:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 648:	6398                	ld	a4,0(a5)
 64a:	6318                	ld	a4,0(a4)
 64c:	fee53823          	sd	a4,-16(a0)
 650:	a091                	j	694 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 652:	ff852703          	lw	a4,-8(a0)
 656:	9e39                	addw	a2,a2,a4
 658:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 65a:	ff053703          	ld	a4,-16(a0)
 65e:	e398                	sd	a4,0(a5)
 660:	a099                	j	6a6 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	6398                	ld	a4,0(a5)
 664:	00e7e463          	bltu	a5,a4,66c <free+0x42>
 668:	00e6ea63          	bltu	a3,a4,67c <free+0x52>
{
 66c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66e:	fed7fae3          	bleu	a3,a5,662 <free+0x38>
 672:	6398                	ld	a4,0(a5)
 674:	00e6e463          	bltu	a3,a4,67c <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	fee7eae3          	bltu	a5,a4,66c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 67c:	ff852583          	lw	a1,-8(a0)
 680:	6390                	ld	a2,0(a5)
 682:	02059713          	slli	a4,a1,0x20
 686:	9301                	srli	a4,a4,0x20
 688:	0712                	slli	a4,a4,0x4
 68a:	9736                	add	a4,a4,a3
 68c:	fae60ae3          	beq	a2,a4,640 <free+0x16>
    bp->s.ptr = p->s.ptr;
 690:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 694:	4790                	lw	a2,8(a5)
 696:	02061713          	slli	a4,a2,0x20
 69a:	9301                	srli	a4,a4,0x20
 69c:	0712                	slli	a4,a4,0x4
 69e:	973e                	add	a4,a4,a5
 6a0:	fae689e3          	beq	a3,a4,652 <free+0x28>
  } else
    p->s.ptr = bp;
 6a4:	e394                	sd	a3,0(a5)
  freep = p;
 6a6:	00000717          	auipc	a4,0x0
 6aa:	14f73923          	sd	a5,338(a4) # 7f8 <__bss_start>
}
 6ae:	6422                	ld	s0,8(sp)
 6b0:	0141                	addi	sp,sp,16
 6b2:	8082                	ret

00000000000006b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b4:	7139                	addi	sp,sp,-64
 6b6:	fc06                	sd	ra,56(sp)
 6b8:	f822                	sd	s0,48(sp)
 6ba:	f426                	sd	s1,40(sp)
 6bc:	f04a                	sd	s2,32(sp)
 6be:	ec4e                	sd	s3,24(sp)
 6c0:	e852                	sd	s4,16(sp)
 6c2:	e456                	sd	s5,8(sp)
 6c4:	e05a                	sd	s6,0(sp)
 6c6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c8:	02051993          	slli	s3,a0,0x20
 6cc:	0209d993          	srli	s3,s3,0x20
 6d0:	09bd                	addi	s3,s3,15
 6d2:	0049d993          	srli	s3,s3,0x4
 6d6:	2985                	addiw	s3,s3,1
 6d8:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 6dc:	00000797          	auipc	a5,0x0
 6e0:	11c78793          	addi	a5,a5,284 # 7f8 <__bss_start>
 6e4:	6388                	ld	a0,0(a5)
 6e6:	c515                	beqz	a0,712 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 6ea:	4798                	lw	a4,8(a5)
 6ec:	03277f63          	bleu	s2,a4,72a <malloc+0x76>
 6f0:	8a4e                	mv	s4,s3
 6f2:	0009871b          	sext.w	a4,s3
 6f6:	6685                	lui	a3,0x1
 6f8:	00d77363          	bleu	a3,a4,6fe <malloc+0x4a>
 6fc:	6a05                	lui	s4,0x1
 6fe:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 702:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 706:	00000497          	auipc	s1,0x0
 70a:	0f248493          	addi	s1,s1,242 # 7f8 <__bss_start>
  if(p == (char*)-1)
 70e:	5b7d                	li	s6,-1
 710:	a885                	j	780 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 712:	00000797          	auipc	a5,0x0
 716:	0ee78793          	addi	a5,a5,238 # 800 <base>
 71a:	00000717          	auipc	a4,0x0
 71e:	0cf73f23          	sd	a5,222(a4) # 7f8 <__bss_start>
 722:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 724:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 728:	b7e1                	j	6f0 <malloc+0x3c>
      if(p->s.size == nunits)
 72a:	02e90b63          	beq	s2,a4,760 <malloc+0xac>
        p->s.size -= nunits;
 72e:	4137073b          	subw	a4,a4,s3
 732:	c798                	sw	a4,8(a5)
        p += p->s.size;
 734:	1702                	slli	a4,a4,0x20
 736:	9301                	srli	a4,a4,0x20
 738:	0712                	slli	a4,a4,0x4
 73a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 73c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 740:	00000717          	auipc	a4,0x0
 744:	0aa73c23          	sd	a0,184(a4) # 7f8 <__bss_start>
      return (void*)(p + 1);
 748:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 74c:	70e2                	ld	ra,56(sp)
 74e:	7442                	ld	s0,48(sp)
 750:	74a2                	ld	s1,40(sp)
 752:	7902                	ld	s2,32(sp)
 754:	69e2                	ld	s3,24(sp)
 756:	6a42                	ld	s4,16(sp)
 758:	6aa2                	ld	s5,8(sp)
 75a:	6b02                	ld	s6,0(sp)
 75c:	6121                	addi	sp,sp,64
 75e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 760:	6398                	ld	a4,0(a5)
 762:	e118                	sd	a4,0(a0)
 764:	bff1                	j	740 <malloc+0x8c>
  hp->s.size = nu;
 766:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 76a:	0541                	addi	a0,a0,16
 76c:	00000097          	auipc	ra,0x0
 770:	ebe080e7          	jalr	-322(ra) # 62a <free>
  return freep;
 774:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 776:	d979                	beqz	a0,74c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 77a:	4798                	lw	a4,8(a5)
 77c:	fb2777e3          	bleu	s2,a4,72a <malloc+0x76>
    if(p == freep)
 780:	6098                	ld	a4,0(s1)
 782:	853e                	mv	a0,a5
 784:	fef71ae3          	bne	a4,a5,778 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 788:	8552                	mv	a0,s4
 78a:	00000097          	auipc	ra,0x0
 78e:	b7a080e7          	jalr	-1158(ra) # 304 <sbrk>
  if(p == (char*)-1)
 792:	fd651ae3          	bne	a0,s6,766 <malloc+0xb2>
        return 0;
 796:	4501                	li	a0,0
 798:	bf55                	j	74c <malloc+0x98>
