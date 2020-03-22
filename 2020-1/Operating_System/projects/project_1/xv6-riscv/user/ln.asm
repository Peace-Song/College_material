
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00000597          	auipc	a1,0x0
  14:	77858593          	addi	a1,a1,1912 # 788 <malloc+0xec>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	594080e7          	jalr	1428(ra) # 5ae <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	240080e7          	jalr	576(ra) # 264 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	292080e7          	jalr	658(ra) # 2c4 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	224080e7          	jalr	548(ra) # 264 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00000597          	auipc	a1,0x0
  50:	75458593          	addi	a1,a1,1876 # 7a0 <malloc+0x104>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	558080e7          	jalr	1368(ra) # 5ae <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
    ;
  return os;
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf91                	beqz	a5,a2 <strcmp+0x26>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71b63          	bne	a4,a5,a2 <strcmp+0x26>
    p++, q++;
  90:	0505                	addi	a0,a0,1
  92:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	c789                	beqz	a5,a2 <strcmp+0x26>
  9a:	0005c703          	lbu	a4,0(a1)
  9e:	fef709e3          	beq	a4,a5,90 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cf91                	beqz	a5,d6 <strlen+0x26>
  bc:	0505                	addi	a0,a0,1
  be:	87aa                	mv	a5,a0
  c0:	4685                	li	a3,1
  c2:	9e89                	subw	a3,a3,a0
    ;
  c4:	00f6853b          	addw	a0,a3,a5
  c8:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  ca:	fff7c703          	lbu	a4,-1(a5)
  ce:	fb7d                	bnez	a4,c4 <strlen+0x14>
  return n;
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	addi	sp,sp,16
  d4:	8082                	ret
  for(n = 0; s[n]; n++)
  d6:	4501                	li	a0,0
  d8:	bfe5                	j	d0 <strlen+0x20>

00000000000000da <memset>:

void*
memset(void *dst, int c, uint n)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e0:	ce09                	beqz	a2,fa <memset+0x20>
  e2:	87aa                	mv	a5,a0
  e4:	fff6071b          	addiw	a4,a2,-1
  e8:	1702                	slli	a4,a4,0x20
  ea:	9301                	srli	a4,a4,0x20
  ec:	0705                	addi	a4,a4,1
  ee:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f0:	00b78023          	sb	a1,0(a5)
  f4:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
  f6:	fee79de3          	bne	a5,a4,f0 <memset+0x16>
  }
  return dst;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret

0000000000000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	1141                	addi	sp,sp,-16
 102:	e422                	sd	s0,8(sp)
 104:	0800                	addi	s0,sp,16
  for(; *s; s++)
 106:	00054783          	lbu	a5,0(a0)
 10a:	cf91                	beqz	a5,126 <strchr+0x26>
    if(*s == c)
 10c:	00f58a63          	beq	a1,a5,120 <strchr+0x20>
  for(; *s; s++)
 110:	0505                	addi	a0,a0,1
 112:	00054783          	lbu	a5,0(a0)
 116:	c781                	beqz	a5,11e <strchr+0x1e>
    if(*s == c)
 118:	feb79ce3          	bne	a5,a1,110 <strchr+0x10>
 11c:	a011                	j	120 <strchr+0x20>
      return (char*)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfe5                	j	120 <strchr+0x20>

000000000000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	711d                	addi	sp,sp,-96
 12c:	ec86                	sd	ra,88(sp)
 12e:	e8a2                	sd	s0,80(sp)
 130:	e4a6                	sd	s1,72(sp)
 132:	e0ca                	sd	s2,64(sp)
 134:	fc4e                	sd	s3,56(sp)
 136:	f852                	sd	s4,48(sp)
 138:	f456                	sd	s5,40(sp)
 13a:	f05a                	sd	s6,32(sp)
 13c:	ec5e                	sd	s7,24(sp)
 13e:	1080                	addi	s0,sp,96
 140:	8baa                	mv	s7,a0
 142:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	892a                	mv	s2,a0
 146:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 148:	4aa9                	li	s5,10
 14a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14c:	0019849b          	addiw	s1,s3,1
 150:	0344d863          	ble	s4,s1,180 <gets+0x56>
    cc = read(0, &c, 1);
 154:	4605                	li	a2,1
 156:	faf40593          	addi	a1,s0,-81
 15a:	4501                	li	a0,0
 15c:	00000097          	auipc	ra,0x0
 160:	120080e7          	jalr	288(ra) # 27c <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x56>
    buf[i++] = c;
 168:	faf44783          	lbu	a5,-81(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01578763          	beq	a5,s5,17e <gets+0x54>
 174:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 176:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 178:	fd679ae3          	bne	a5,s6,14c <gets+0x22>
 17c:	a011                	j	180 <gets+0x56>
  for(i=0; i+1 < max; ){
 17e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 180:	99de                	add	s3,s3,s7
 182:	00098023          	sb	zero,0(s3)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6125                	addi	sp,sp,96
 19c:	8082                	ret

000000000000019e <stat>:

int
stat(const char *n, struct stat *st)
{
 19e:	1101                	addi	sp,sp,-32
 1a0:	ec06                	sd	ra,24(sp)
 1a2:	e822                	sd	s0,16(sp)
 1a4:	e426                	sd	s1,8(sp)
 1a6:	e04a                	sd	s2,0(sp)
 1a8:	1000                	addi	s0,sp,32
 1aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	4581                	li	a1,0
 1ae:	00000097          	auipc	ra,0x0
 1b2:	0f6080e7          	jalr	246(ra) # 2a4 <open>
  if(fd < 0)
 1b6:	02054563          	bltz	a0,1e0 <stat+0x42>
 1ba:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1bc:	85ca                	mv	a1,s2
 1be:	00000097          	auipc	ra,0x0
 1c2:	0fe080e7          	jalr	254(ra) # 2bc <fstat>
 1c6:	892a                	mv	s2,a0
  close(fd);
 1c8:	8526                	mv	a0,s1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	0c2080e7          	jalr	194(ra) # 28c <close>
  return r;
}
 1d2:	854a                	mv	a0,s2
 1d4:	60e2                	ld	ra,24(sp)
 1d6:	6442                	ld	s0,16(sp)
 1d8:	64a2                	ld	s1,8(sp)
 1da:	6902                	ld	s2,0(sp)
 1dc:	6105                	addi	sp,sp,32
 1de:	8082                	ret
    return -1;
 1e0:	597d                	li	s2,-1
 1e2:	bfc5                	j	1d2 <stat+0x34>

00000000000001e4 <atoi>:

int
atoi(const char *s)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ea:	00054683          	lbu	a3,0(a0)
 1ee:	fd06879b          	addiw	a5,a3,-48
 1f2:	0ff7f793          	andi	a5,a5,255
 1f6:	4725                	li	a4,9
 1f8:	02f76963          	bltu	a4,a5,22a <atoi+0x46>
 1fc:	862a                	mv	a2,a0
  n = 0;
 1fe:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 200:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 202:	0605                	addi	a2,a2,1
 204:	0025179b          	slliw	a5,a0,0x2
 208:	9fa9                	addw	a5,a5,a0
 20a:	0017979b          	slliw	a5,a5,0x1
 20e:	9fb5                	addw	a5,a5,a3
 210:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 214:	00064683          	lbu	a3,0(a2)
 218:	fd06871b          	addiw	a4,a3,-48
 21c:	0ff77713          	andi	a4,a4,255
 220:	fee5f1e3          	bleu	a4,a1,202 <atoi+0x1e>
  return n;
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  n = 0;
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <atoi+0x40>

000000000000022e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 234:	02c05163          	blez	a2,256 <memmove+0x28>
 238:	fff6071b          	addiw	a4,a2,-1
 23c:	1702                	slli	a4,a4,0x20
 23e:	9301                	srli	a4,a4,0x20
 240:	0705                	addi	a4,a4,1
 242:	972a                	add	a4,a4,a0
  dst = vdst;
 244:	87aa                	mv	a5,a0
    *dst++ = *src++;
 246:	0585                	addi	a1,a1,1
 248:	0785                	addi	a5,a5,1
 24a:	fff5c683          	lbu	a3,-1(a1)
 24e:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 252:	fee79ae3          	bne	a5,a4,246 <memmove+0x18>
  return vdst;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 25c:	4885                	li	a7,1
 ecall
 25e:	00000073          	ecall
 ret
 262:	8082                	ret

0000000000000264 <exit>:
.global exit
exit:
 li a7, SYS_exit
 264:	4889                	li	a7,2
 ecall
 266:	00000073          	ecall
 ret
 26a:	8082                	ret

000000000000026c <wait>:
.global wait
wait:
 li a7, SYS_wait
 26c:	488d                	li	a7,3
 ecall
 26e:	00000073          	ecall
 ret
 272:	8082                	ret

0000000000000274 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 274:	4891                	li	a7,4
 ecall
 276:	00000073          	ecall
 ret
 27a:	8082                	ret

000000000000027c <read>:
.global read
read:
 li a7, SYS_read
 27c:	4895                	li	a7,5
 ecall
 27e:	00000073          	ecall
 ret
 282:	8082                	ret

0000000000000284 <write>:
.global write
write:
 li a7, SYS_write
 284:	48c1                	li	a7,16
 ecall
 286:	00000073          	ecall
 ret
 28a:	8082                	ret

000000000000028c <close>:
.global close
close:
 li a7, SYS_close
 28c:	48d5                	li	a7,21
 ecall
 28e:	00000073          	ecall
 ret
 292:	8082                	ret

0000000000000294 <kill>:
.global kill
kill:
 li a7, SYS_kill
 294:	4899                	li	a7,6
 ecall
 296:	00000073          	ecall
 ret
 29a:	8082                	ret

000000000000029c <exec>:
.global exec
exec:
 li a7, SYS_exec
 29c:	489d                	li	a7,7
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <open>:
.global open
open:
 li a7, SYS_open
 2a4:	48bd                	li	a7,15
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2ac:	48c5                	li	a7,17
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2b4:	48c9                	li	a7,18
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2bc:	48a1                	li	a7,8
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <link>:
.global link
link:
 li a7, SYS_link
 2c4:	48cd                	li	a7,19
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2cc:	48d1                	li	a7,20
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2d4:	48a5                	li	a7,9
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 2dc:	48a9                	li	a7,10
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 2e4:	48ad                	li	a7,11
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 2ec:	48b1                	li	a7,12
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 2f4:	48b5                	li	a7,13
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 2fc:	48b9                	li	a7,14
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 304:	1101                	addi	sp,sp,-32
 306:	ec06                	sd	ra,24(sp)
 308:	e822                	sd	s0,16(sp)
 30a:	1000                	addi	s0,sp,32
 30c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 310:	4605                	li	a2,1
 312:	fef40593          	addi	a1,s0,-17
 316:	00000097          	auipc	ra,0x0
 31a:	f6e080e7          	jalr	-146(ra) # 284 <write>
}
 31e:	60e2                	ld	ra,24(sp)
 320:	6442                	ld	s0,16(sp)
 322:	6105                	addi	sp,sp,32
 324:	8082                	ret

0000000000000326 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 326:	7139                	addi	sp,sp,-64
 328:	fc06                	sd	ra,56(sp)
 32a:	f822                	sd	s0,48(sp)
 32c:	f426                	sd	s1,40(sp)
 32e:	f04a                	sd	s2,32(sp)
 330:	ec4e                	sd	s3,24(sp)
 332:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 334:	c299                	beqz	a3,33a <printint+0x14>
 336:	0005cd63          	bltz	a1,350 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 33a:	2581                	sext.w	a1,a1
  neg = 0;
 33c:	4301                	li	t1,0
 33e:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 342:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 344:	2601                	sext.w	a2,a2
 346:	00000897          	auipc	a7,0x0
 34a:	47288893          	addi	a7,a7,1138 # 7b8 <digits>
 34e:	a801                	j	35e <printint+0x38>
    x = -xx;
 350:	40b005bb          	negw	a1,a1
 354:	2581                	sext.w	a1,a1
    neg = 1;
 356:	4305                	li	t1,1
    x = -xx;
 358:	b7dd                	j	33e <printint+0x18>
  }while((x /= base) != 0);
 35a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 35c:	8836                	mv	a6,a3
 35e:	0018069b          	addiw	a3,a6,1
 362:	02c5f7bb          	remuw	a5,a1,a2
 366:	1782                	slli	a5,a5,0x20
 368:	9381                	srli	a5,a5,0x20
 36a:	97c6                	add	a5,a5,a7
 36c:	0007c783          	lbu	a5,0(a5)
 370:	00f70023          	sb	a5,0(a4)
 374:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 376:	02c5d7bb          	divuw	a5,a1,a2
 37a:	fec5f0e3          	bleu	a2,a1,35a <printint+0x34>
  if(neg)
 37e:	00030b63          	beqz	t1,394 <printint+0x6e>
    buf[i++] = '-';
 382:	fd040793          	addi	a5,s0,-48
 386:	96be                	add	a3,a3,a5
 388:	02d00793          	li	a5,45
 38c:	fef68823          	sb	a5,-16(a3)
 390:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 394:	02d05963          	blez	a3,3c6 <printint+0xa0>
 398:	89aa                	mv	s3,a0
 39a:	fc040793          	addi	a5,s0,-64
 39e:	00d784b3          	add	s1,a5,a3
 3a2:	fff78913          	addi	s2,a5,-1
 3a6:	9936                	add	s2,s2,a3
 3a8:	36fd                	addiw	a3,a3,-1
 3aa:	1682                	slli	a3,a3,0x20
 3ac:	9281                	srli	a3,a3,0x20
 3ae:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 3b2:	fff4c583          	lbu	a1,-1(s1)
 3b6:	854e                	mv	a0,s3
 3b8:	00000097          	auipc	ra,0x0
 3bc:	f4c080e7          	jalr	-180(ra) # 304 <putc>
 3c0:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 3c2:	ff2498e3          	bne	s1,s2,3b2 <printint+0x8c>
}
 3c6:	70e2                	ld	ra,56(sp)
 3c8:	7442                	ld	s0,48(sp)
 3ca:	74a2                	ld	s1,40(sp)
 3cc:	7902                	ld	s2,32(sp)
 3ce:	69e2                	ld	s3,24(sp)
 3d0:	6121                	addi	sp,sp,64
 3d2:	8082                	ret

00000000000003d4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3d4:	7119                	addi	sp,sp,-128
 3d6:	fc86                	sd	ra,120(sp)
 3d8:	f8a2                	sd	s0,112(sp)
 3da:	f4a6                	sd	s1,104(sp)
 3dc:	f0ca                	sd	s2,96(sp)
 3de:	ecce                	sd	s3,88(sp)
 3e0:	e8d2                	sd	s4,80(sp)
 3e2:	e4d6                	sd	s5,72(sp)
 3e4:	e0da                	sd	s6,64(sp)
 3e6:	fc5e                	sd	s7,56(sp)
 3e8:	f862                	sd	s8,48(sp)
 3ea:	f466                	sd	s9,40(sp)
 3ec:	f06a                	sd	s10,32(sp)
 3ee:	ec6e                	sd	s11,24(sp)
 3f0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 3f2:	0005c483          	lbu	s1,0(a1)
 3f6:	18048d63          	beqz	s1,590 <vprintf+0x1bc>
 3fa:	8aaa                	mv	s5,a0
 3fc:	8b32                	mv	s6,a2
 3fe:	00158913          	addi	s2,a1,1
  state = 0;
 402:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 404:	02500a13          	li	s4,37
      if(c == 'd'){
 408:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 40c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 410:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 414:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 418:	00000b97          	auipc	s7,0x0
 41c:	3a0b8b93          	addi	s7,s7,928 # 7b8 <digits>
 420:	a839                	j	43e <vprintf+0x6a>
        putc(fd, c);
 422:	85a6                	mv	a1,s1
 424:	8556                	mv	a0,s5
 426:	00000097          	auipc	ra,0x0
 42a:	ede080e7          	jalr	-290(ra) # 304 <putc>
 42e:	a019                	j	434 <vprintf+0x60>
    } else if(state == '%'){
 430:	01498f63          	beq	s3,s4,44e <vprintf+0x7a>
 434:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 436:	fff94483          	lbu	s1,-1(s2)
 43a:	14048b63          	beqz	s1,590 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 43e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 442:	fe0997e3          	bnez	s3,430 <vprintf+0x5c>
      if(c == '%'){
 446:	fd479ee3          	bne	a5,s4,422 <vprintf+0x4e>
        state = '%';
 44a:	89be                	mv	s3,a5
 44c:	b7e5                	j	434 <vprintf+0x60>
      if(c == 'd'){
 44e:	05878063          	beq	a5,s8,48e <vprintf+0xba>
      } else if(c == 'l') {
 452:	05978c63          	beq	a5,s9,4aa <vprintf+0xd6>
      } else if(c == 'x') {
 456:	07a78863          	beq	a5,s10,4c6 <vprintf+0xf2>
      } else if(c == 'p') {
 45a:	09b78463          	beq	a5,s11,4e2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 45e:	07300713          	li	a4,115
 462:	0ce78563          	beq	a5,a4,52c <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 466:	06300713          	li	a4,99
 46a:	0ee78c63          	beq	a5,a4,562 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 46e:	11478663          	beq	a5,s4,57a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 472:	85d2                	mv	a1,s4
 474:	8556                	mv	a0,s5
 476:	00000097          	auipc	ra,0x0
 47a:	e8e080e7          	jalr	-370(ra) # 304 <putc>
        putc(fd, c);
 47e:	85a6                	mv	a1,s1
 480:	8556                	mv	a0,s5
 482:	00000097          	auipc	ra,0x0
 486:	e82080e7          	jalr	-382(ra) # 304 <putc>
      }
      state = 0;
 48a:	4981                	li	s3,0
 48c:	b765                	j	434 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 48e:	008b0493          	addi	s1,s6,8
 492:	4685                	li	a3,1
 494:	4629                	li	a2,10
 496:	000b2583          	lw	a1,0(s6)
 49a:	8556                	mv	a0,s5
 49c:	00000097          	auipc	ra,0x0
 4a0:	e8a080e7          	jalr	-374(ra) # 326 <printint>
 4a4:	8b26                	mv	s6,s1
      state = 0;
 4a6:	4981                	li	s3,0
 4a8:	b771                	j	434 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4aa:	008b0493          	addi	s1,s6,8
 4ae:	4681                	li	a3,0
 4b0:	4629                	li	a2,10
 4b2:	000b2583          	lw	a1,0(s6)
 4b6:	8556                	mv	a0,s5
 4b8:	00000097          	auipc	ra,0x0
 4bc:	e6e080e7          	jalr	-402(ra) # 326 <printint>
 4c0:	8b26                	mv	s6,s1
      state = 0;
 4c2:	4981                	li	s3,0
 4c4:	bf85                	j	434 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 4c6:	008b0493          	addi	s1,s6,8
 4ca:	4681                	li	a3,0
 4cc:	4641                	li	a2,16
 4ce:	000b2583          	lw	a1,0(s6)
 4d2:	8556                	mv	a0,s5
 4d4:	00000097          	auipc	ra,0x0
 4d8:	e52080e7          	jalr	-430(ra) # 326 <printint>
 4dc:	8b26                	mv	s6,s1
      state = 0;
 4de:	4981                	li	s3,0
 4e0:	bf91                	j	434 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 4e2:	008b0793          	addi	a5,s6,8
 4e6:	f8f43423          	sd	a5,-120(s0)
 4ea:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 4ee:	03000593          	li	a1,48
 4f2:	8556                	mv	a0,s5
 4f4:	00000097          	auipc	ra,0x0
 4f8:	e10080e7          	jalr	-496(ra) # 304 <putc>
  putc(fd, 'x');
 4fc:	85ea                	mv	a1,s10
 4fe:	8556                	mv	a0,s5
 500:	00000097          	auipc	ra,0x0
 504:	e04080e7          	jalr	-508(ra) # 304 <putc>
 508:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50a:	03c9d793          	srli	a5,s3,0x3c
 50e:	97de                	add	a5,a5,s7
 510:	0007c583          	lbu	a1,0(a5)
 514:	8556                	mv	a0,s5
 516:	00000097          	auipc	ra,0x0
 51a:	dee080e7          	jalr	-530(ra) # 304 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 51e:	0992                	slli	s3,s3,0x4
 520:	34fd                	addiw	s1,s1,-1
 522:	f4e5                	bnez	s1,50a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 524:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 528:	4981                	li	s3,0
 52a:	b729                	j	434 <vprintf+0x60>
        s = va_arg(ap, char*);
 52c:	008b0993          	addi	s3,s6,8
 530:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 534:	c085                	beqz	s1,554 <vprintf+0x180>
        while(*s != 0){
 536:	0004c583          	lbu	a1,0(s1)
 53a:	c9a1                	beqz	a1,58a <vprintf+0x1b6>
          putc(fd, *s);
 53c:	8556                	mv	a0,s5
 53e:	00000097          	auipc	ra,0x0
 542:	dc6080e7          	jalr	-570(ra) # 304 <putc>
          s++;
 546:	0485                	addi	s1,s1,1
        while(*s != 0){
 548:	0004c583          	lbu	a1,0(s1)
 54c:	f9e5                	bnez	a1,53c <vprintf+0x168>
        s = va_arg(ap, char*);
 54e:	8b4e                	mv	s6,s3
      state = 0;
 550:	4981                	li	s3,0
 552:	b5cd                	j	434 <vprintf+0x60>
          s = "(null)";
 554:	00000497          	auipc	s1,0x0
 558:	27c48493          	addi	s1,s1,636 # 7d0 <digits+0x18>
        while(*s != 0){
 55c:	02800593          	li	a1,40
 560:	bff1                	j	53c <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 562:	008b0493          	addi	s1,s6,8
 566:	000b4583          	lbu	a1,0(s6)
 56a:	8556                	mv	a0,s5
 56c:	00000097          	auipc	ra,0x0
 570:	d98080e7          	jalr	-616(ra) # 304 <putc>
 574:	8b26                	mv	s6,s1
      state = 0;
 576:	4981                	li	s3,0
 578:	bd75                	j	434 <vprintf+0x60>
        putc(fd, c);
 57a:	85d2                	mv	a1,s4
 57c:	8556                	mv	a0,s5
 57e:	00000097          	auipc	ra,0x0
 582:	d86080e7          	jalr	-634(ra) # 304 <putc>
      state = 0;
 586:	4981                	li	s3,0
 588:	b575                	j	434 <vprintf+0x60>
        s = va_arg(ap, char*);
 58a:	8b4e                	mv	s6,s3
      state = 0;
 58c:	4981                	li	s3,0
 58e:	b55d                	j	434 <vprintf+0x60>
    }
  }
}
 590:	70e6                	ld	ra,120(sp)
 592:	7446                	ld	s0,112(sp)
 594:	74a6                	ld	s1,104(sp)
 596:	7906                	ld	s2,96(sp)
 598:	69e6                	ld	s3,88(sp)
 59a:	6a46                	ld	s4,80(sp)
 59c:	6aa6                	ld	s5,72(sp)
 59e:	6b06                	ld	s6,64(sp)
 5a0:	7be2                	ld	s7,56(sp)
 5a2:	7c42                	ld	s8,48(sp)
 5a4:	7ca2                	ld	s9,40(sp)
 5a6:	7d02                	ld	s10,32(sp)
 5a8:	6de2                	ld	s11,24(sp)
 5aa:	6109                	addi	sp,sp,128
 5ac:	8082                	ret

00000000000005ae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5ae:	715d                	addi	sp,sp,-80
 5b0:	ec06                	sd	ra,24(sp)
 5b2:	e822                	sd	s0,16(sp)
 5b4:	1000                	addi	s0,sp,32
 5b6:	e010                	sd	a2,0(s0)
 5b8:	e414                	sd	a3,8(s0)
 5ba:	e818                	sd	a4,16(s0)
 5bc:	ec1c                	sd	a5,24(s0)
 5be:	03043023          	sd	a6,32(s0)
 5c2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 5c6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 5ca:	8622                	mv	a2,s0
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e08080e7          	jalr	-504(ra) # 3d4 <vprintf>
}
 5d4:	60e2                	ld	ra,24(sp)
 5d6:	6442                	ld	s0,16(sp)
 5d8:	6161                	addi	sp,sp,80
 5da:	8082                	ret

00000000000005dc <printf>:

void
printf(const char *fmt, ...)
{
 5dc:	711d                	addi	sp,sp,-96
 5de:	ec06                	sd	ra,24(sp)
 5e0:	e822                	sd	s0,16(sp)
 5e2:	1000                	addi	s0,sp,32
 5e4:	e40c                	sd	a1,8(s0)
 5e6:	e810                	sd	a2,16(s0)
 5e8:	ec14                	sd	a3,24(s0)
 5ea:	f018                	sd	a4,32(s0)
 5ec:	f41c                	sd	a5,40(s0)
 5ee:	03043823          	sd	a6,48(s0)
 5f2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 5f6:	00840613          	addi	a2,s0,8
 5fa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 5fe:	85aa                	mv	a1,a0
 600:	4505                	li	a0,1
 602:	00000097          	auipc	ra,0x0
 606:	dd2080e7          	jalr	-558(ra) # 3d4 <vprintf>
}
 60a:	60e2                	ld	ra,24(sp)
 60c:	6442                	ld	s0,16(sp)
 60e:	6125                	addi	sp,sp,96
 610:	8082                	ret

0000000000000612 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 612:	1141                	addi	sp,sp,-16
 614:	e422                	sd	s0,8(sp)
 616:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 618:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61c:	00000797          	auipc	a5,0x0
 620:	1bc78793          	addi	a5,a5,444 # 7d8 <__bss_start>
 624:	639c                	ld	a5,0(a5)
 626:	a805                	j	656 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 628:	4618                	lw	a4,8(a2)
 62a:	9db9                	addw	a1,a1,a4
 62c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 630:	6398                	ld	a4,0(a5)
 632:	6318                	ld	a4,0(a4)
 634:	fee53823          	sd	a4,-16(a0)
 638:	a091                	j	67c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 63a:	ff852703          	lw	a4,-8(a0)
 63e:	9e39                	addw	a2,a2,a4
 640:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 642:	ff053703          	ld	a4,-16(a0)
 646:	e398                	sd	a4,0(a5)
 648:	a099                	j	68e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64a:	6398                	ld	a4,0(a5)
 64c:	00e7e463          	bltu	a5,a4,654 <free+0x42>
 650:	00e6ea63          	bltu	a3,a4,664 <free+0x52>
{
 654:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 656:	fed7fae3          	bleu	a3,a5,64a <free+0x38>
 65a:	6398                	ld	a4,0(a5)
 65c:	00e6e463          	bltu	a3,a4,664 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	fee7eae3          	bltu	a5,a4,654 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 664:	ff852583          	lw	a1,-8(a0)
 668:	6390                	ld	a2,0(a5)
 66a:	02059713          	slli	a4,a1,0x20
 66e:	9301                	srli	a4,a4,0x20
 670:	0712                	slli	a4,a4,0x4
 672:	9736                	add	a4,a4,a3
 674:	fae60ae3          	beq	a2,a4,628 <free+0x16>
    bp->s.ptr = p->s.ptr;
 678:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 67c:	4790                	lw	a2,8(a5)
 67e:	02061713          	slli	a4,a2,0x20
 682:	9301                	srli	a4,a4,0x20
 684:	0712                	slli	a4,a4,0x4
 686:	973e                	add	a4,a4,a5
 688:	fae689e3          	beq	a3,a4,63a <free+0x28>
  } else
    p->s.ptr = bp;
 68c:	e394                	sd	a3,0(a5)
  freep = p;
 68e:	00000717          	auipc	a4,0x0
 692:	14f73523          	sd	a5,330(a4) # 7d8 <__bss_start>
}
 696:	6422                	ld	s0,8(sp)
 698:	0141                	addi	sp,sp,16
 69a:	8082                	ret

000000000000069c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 69c:	7139                	addi	sp,sp,-64
 69e:	fc06                	sd	ra,56(sp)
 6a0:	f822                	sd	s0,48(sp)
 6a2:	f426                	sd	s1,40(sp)
 6a4:	f04a                	sd	s2,32(sp)
 6a6:	ec4e                	sd	s3,24(sp)
 6a8:	e852                	sd	s4,16(sp)
 6aa:	e456                	sd	s5,8(sp)
 6ac:	e05a                	sd	s6,0(sp)
 6ae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b0:	02051993          	slli	s3,a0,0x20
 6b4:	0209d993          	srli	s3,s3,0x20
 6b8:	09bd                	addi	s3,s3,15
 6ba:	0049d993          	srli	s3,s3,0x4
 6be:	2985                	addiw	s3,s3,1
 6c0:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 6c4:	00000797          	auipc	a5,0x0
 6c8:	11478793          	addi	a5,a5,276 # 7d8 <__bss_start>
 6cc:	6388                	ld	a0,0(a5)
 6ce:	c515                	beqz	a0,6fa <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 6d2:	4798                	lw	a4,8(a5)
 6d4:	03277f63          	bleu	s2,a4,712 <malloc+0x76>
 6d8:	8a4e                	mv	s4,s3
 6da:	0009871b          	sext.w	a4,s3
 6de:	6685                	lui	a3,0x1
 6e0:	00d77363          	bleu	a3,a4,6e6 <malloc+0x4a>
 6e4:	6a05                	lui	s4,0x1
 6e6:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 6ea:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6ee:	00000497          	auipc	s1,0x0
 6f2:	0ea48493          	addi	s1,s1,234 # 7d8 <__bss_start>
  if(p == (char*)-1)
 6f6:	5b7d                	li	s6,-1
 6f8:	a885                	j	768 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 6fa:	00000797          	auipc	a5,0x0
 6fe:	0e678793          	addi	a5,a5,230 # 7e0 <base>
 702:	00000717          	auipc	a4,0x0
 706:	0cf73b23          	sd	a5,214(a4) # 7d8 <__bss_start>
 70a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 70c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 710:	b7e1                	j	6d8 <malloc+0x3c>
      if(p->s.size == nunits)
 712:	02e90b63          	beq	s2,a4,748 <malloc+0xac>
        p->s.size -= nunits;
 716:	4137073b          	subw	a4,a4,s3
 71a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 71c:	1702                	slli	a4,a4,0x20
 71e:	9301                	srli	a4,a4,0x20
 720:	0712                	slli	a4,a4,0x4
 722:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 724:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 728:	00000717          	auipc	a4,0x0
 72c:	0aa73823          	sd	a0,176(a4) # 7d8 <__bss_start>
      return (void*)(p + 1);
 730:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 734:	70e2                	ld	ra,56(sp)
 736:	7442                	ld	s0,48(sp)
 738:	74a2                	ld	s1,40(sp)
 73a:	7902                	ld	s2,32(sp)
 73c:	69e2                	ld	s3,24(sp)
 73e:	6a42                	ld	s4,16(sp)
 740:	6aa2                	ld	s5,8(sp)
 742:	6b02                	ld	s6,0(sp)
 744:	6121                	addi	sp,sp,64
 746:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 748:	6398                	ld	a4,0(a5)
 74a:	e118                	sd	a4,0(a0)
 74c:	bff1                	j	728 <malloc+0x8c>
  hp->s.size = nu;
 74e:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 752:	0541                	addi	a0,a0,16
 754:	00000097          	auipc	ra,0x0
 758:	ebe080e7          	jalr	-322(ra) # 612 <free>
  return freep;
 75c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 75e:	d979                	beqz	a0,734 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 762:	4798                	lw	a4,8(a5)
 764:	fb2777e3          	bleu	s2,a4,712 <malloc+0x76>
    if(p == freep)
 768:	6098                	ld	a4,0(s1)
 76a:	853e                	mv	a0,a5
 76c:	fef71ae3          	bne	a4,a5,760 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 770:	8552                	mv	a0,s4
 772:	00000097          	auipc	ra,0x0
 776:	b7a080e7          	jalr	-1158(ra) # 2ec <sbrk>
  if(p == (char*)-1)
 77a:	fd651ae3          	bne	a0,s6,74e <malloc+0xb2>
        return 0;
 77e:	4501                	li	a0,0
 780:	bf55                	j	734 <malloc+0x98>
