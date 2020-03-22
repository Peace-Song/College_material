
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	ble	a0,a5,48 <main+0x48>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	1902                	slli	s2,s2,0x20
  1c:	02095913          	srli	s2,s2,0x20
  20:	090e                	slli	s2,s2,0x3
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	1c0080e7          	jalr	448(ra) # 1e8 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	268080e7          	jalr	616(ra) # 298 <kill>
  38:	04a1                	addi	s1,s1,8
  for(i=1; i<argc; i++)
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	228080e7          	jalr	552(ra) # 268 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00000597          	auipc	a1,0x0
  4c:	74058593          	addi	a1,a1,1856 # 788 <malloc+0xe8>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	560080e7          	jalr	1376(ra) # 5b2 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	20c080e7          	jalr	524(ra) # 268 <exit>

0000000000000064 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cf91                	beqz	a5,a6 <strcmp+0x26>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71b63          	bne	a4,a5,a6 <strcmp+0x26>
    p++, q++;
  94:	0505                	addi	a0,a0,1
  96:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	c789                	beqz	a5,a6 <strcmp+0x26>
  9e:	0005c703          	lbu	a4,0(a1)
  a2:	fef709e3          	beq	a4,a5,94 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	6422                	ld	s0,8(sp)
  b0:	0141                	addi	sp,sp,16
  b2:	8082                	ret

00000000000000b4 <strlen>:

uint
strlen(const char *s)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf91                	beqz	a5,da <strlen+0x26>
  c0:	0505                	addi	a0,a0,1
  c2:	87aa                	mv	a5,a0
  c4:	4685                	li	a3,1
  c6:	9e89                	subw	a3,a3,a0
    ;
  c8:	00f6853b          	addw	a0,a3,a5
  cc:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  ce:	fff7c703          	lbu	a4,-1(a5)
  d2:	fb7d                	bnez	a4,c8 <strlen+0x14>
  return n;
}
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret
  for(n = 0; s[n]; n++)
  da:	4501                	li	a0,0
  dc:	bfe5                	j	d4 <strlen+0x20>

00000000000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e4:	ce09                	beqz	a2,fe <memset+0x20>
  e6:	87aa                	mv	a5,a0
  e8:	fff6071b          	addiw	a4,a2,-1
  ec:	1702                	slli	a4,a4,0x20
  ee:	9301                	srli	a4,a4,0x20
  f0:	0705                	addi	a4,a4,1
  f2:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f4:	00b78023          	sb	a1,0(a5)
  f8:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
  fa:	fee79de3          	bne	a5,a4,f4 <memset+0x16>
  }
  return dst;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cf91                	beqz	a5,12a <strchr+0x26>
    if(*s == c)
 110:	00f58a63          	beq	a1,a5,124 <strchr+0x20>
  for(; *s; s++)
 114:	0505                	addi	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	c781                	beqz	a5,122 <strchr+0x1e>
    if(*s == c)
 11c:	feb79ce3          	bne	a5,a1,114 <strchr+0x10>
 120:	a011                	j	124 <strchr+0x20>
      return (char*)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfe5                	j	124 <strchr+0x20>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	711d                	addi	sp,sp,-96
 130:	ec86                	sd	ra,88(sp)
 132:	e8a2                	sd	s0,80(sp)
 134:	e4a6                	sd	s1,72(sp)
 136:	e0ca                	sd	s2,64(sp)
 138:	fc4e                	sd	s3,56(sp)
 13a:	f852                	sd	s4,48(sp)
 13c:	f456                	sd	s5,40(sp)
 13e:	f05a                	sd	s6,32(sp)
 140:	ec5e                	sd	s7,24(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14c:	4aa9                	li	s5,10
 14e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 150:	0019849b          	addiw	s1,s3,1
 154:	0344d863          	ble	s4,s1,184 <gets+0x56>
    cc = read(0, &c, 1);
 158:	4605                	li	a2,1
 15a:	faf40593          	addi	a1,s0,-81
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	120080e7          	jalr	288(ra) # 280 <read>
    if(cc < 1)
 168:	00a05e63          	blez	a0,184 <gets+0x56>
    buf[i++] = c;
 16c:	faf44783          	lbu	a5,-81(s0)
 170:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 174:	01578763          	beq	a5,s5,182 <gets+0x54>
 178:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 17c:	fd679ae3          	bne	a5,s6,150 <gets+0x22>
 180:	a011                	j	184 <gets+0x56>
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 184:	99de                	add	s3,s3,s7
 186:	00098023          	sb	zero,0(s3)
  return buf;
}
 18a:	855e                	mv	a0,s7
 18c:	60e6                	ld	ra,88(sp)
 18e:	6446                	ld	s0,80(sp)
 190:	64a6                	ld	s1,72(sp)
 192:	6906                	ld	s2,64(sp)
 194:	79e2                	ld	s3,56(sp)
 196:	7a42                	ld	s4,48(sp)
 198:	7aa2                	ld	s5,40(sp)
 19a:	7b02                	ld	s6,32(sp)
 19c:	6be2                	ld	s7,24(sp)
 19e:	6125                	addi	sp,sp,96
 1a0:	8082                	ret

00000000000001a2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a2:	1101                	addi	sp,sp,-32
 1a4:	ec06                	sd	ra,24(sp)
 1a6:	e822                	sd	s0,16(sp)
 1a8:	e426                	sd	s1,8(sp)
 1aa:	e04a                	sd	s2,0(sp)
 1ac:	1000                	addi	s0,sp,32
 1ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b0:	4581                	li	a1,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	0f6080e7          	jalr	246(ra) # 2a8 <open>
  if(fd < 0)
 1ba:	02054563          	bltz	a0,1e4 <stat+0x42>
 1be:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c0:	85ca                	mv	a1,s2
 1c2:	00000097          	auipc	ra,0x0
 1c6:	0fe080e7          	jalr	254(ra) # 2c0 <fstat>
 1ca:	892a                	mv	s2,a0
  close(fd);
 1cc:	8526                	mv	a0,s1
 1ce:	00000097          	auipc	ra,0x0
 1d2:	0c2080e7          	jalr	194(ra) # 290 <close>
  return r;
}
 1d6:	854a                	mv	a0,s2
 1d8:	60e2                	ld	ra,24(sp)
 1da:	6442                	ld	s0,16(sp)
 1dc:	64a2                	ld	s1,8(sp)
 1de:	6902                	ld	s2,0(sp)
 1e0:	6105                	addi	sp,sp,32
 1e2:	8082                	ret
    return -1;
 1e4:	597d                	li	s2,-1
 1e6:	bfc5                	j	1d6 <stat+0x34>

00000000000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ee:	00054683          	lbu	a3,0(a0)
 1f2:	fd06879b          	addiw	a5,a3,-48
 1f6:	0ff7f793          	andi	a5,a5,255
 1fa:	4725                	li	a4,9
 1fc:	02f76963          	bltu	a4,a5,22e <atoi+0x46>
 200:	862a                	mv	a2,a0
  n = 0;
 202:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 204:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 206:	0605                	addi	a2,a2,1
 208:	0025179b          	slliw	a5,a0,0x2
 20c:	9fa9                	addw	a5,a5,a0
 20e:	0017979b          	slliw	a5,a5,0x1
 212:	9fb5                	addw	a5,a5,a3
 214:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 218:	00064683          	lbu	a3,0(a2)
 21c:	fd06871b          	addiw	a4,a3,-48
 220:	0ff77713          	andi	a4,a4,255
 224:	fee5f1e3          	bleu	a4,a1,206 <atoi+0x1e>
  return n;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
  n = 0;
 22e:	4501                	li	a0,0
 230:	bfe5                	j	228 <atoi+0x40>

0000000000000232 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 232:	1141                	addi	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 238:	02c05163          	blez	a2,25a <memmove+0x28>
 23c:	fff6071b          	addiw	a4,a2,-1
 240:	1702                	slli	a4,a4,0x20
 242:	9301                	srli	a4,a4,0x20
 244:	0705                	addi	a4,a4,1
 246:	972a                	add	a4,a4,a0
  dst = vdst;
 248:	87aa                	mv	a5,a0
    *dst++ = *src++;
 24a:	0585                	addi	a1,a1,1
 24c:	0785                	addi	a5,a5,1
 24e:	fff5c683          	lbu	a3,-1(a1)
 252:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 256:	fee79ae3          	bne	a5,a4,24a <memmove+0x18>
  return vdst;
}
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret

0000000000000260 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 260:	4885                	li	a7,1
 ecall
 262:	00000073          	ecall
 ret
 266:	8082                	ret

0000000000000268 <exit>:
.global exit
exit:
 li a7, SYS_exit
 268:	4889                	li	a7,2
 ecall
 26a:	00000073          	ecall
 ret
 26e:	8082                	ret

0000000000000270 <wait>:
.global wait
wait:
 li a7, SYS_wait
 270:	488d                	li	a7,3
 ecall
 272:	00000073          	ecall
 ret
 276:	8082                	ret

0000000000000278 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 278:	4891                	li	a7,4
 ecall
 27a:	00000073          	ecall
 ret
 27e:	8082                	ret

0000000000000280 <read>:
.global read
read:
 li a7, SYS_read
 280:	4895                	li	a7,5
 ecall
 282:	00000073          	ecall
 ret
 286:	8082                	ret

0000000000000288 <write>:
.global write
write:
 li a7, SYS_write
 288:	48c1                	li	a7,16
 ecall
 28a:	00000073          	ecall
 ret
 28e:	8082                	ret

0000000000000290 <close>:
.global close
close:
 li a7, SYS_close
 290:	48d5                	li	a7,21
 ecall
 292:	00000073          	ecall
 ret
 296:	8082                	ret

0000000000000298 <kill>:
.global kill
kill:
 li a7, SYS_kill
 298:	4899                	li	a7,6
 ecall
 29a:	00000073          	ecall
 ret
 29e:	8082                	ret

00000000000002a0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2a0:	489d                	li	a7,7
 ecall
 2a2:	00000073          	ecall
 ret
 2a6:	8082                	ret

00000000000002a8 <open>:
.global open
open:
 li a7, SYS_open
 2a8:	48bd                	li	a7,15
 ecall
 2aa:	00000073          	ecall
 ret
 2ae:	8082                	ret

00000000000002b0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2b0:	48c5                	li	a7,17
 ecall
 2b2:	00000073          	ecall
 ret
 2b6:	8082                	ret

00000000000002b8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2b8:	48c9                	li	a7,18
 ecall
 2ba:	00000073          	ecall
 ret
 2be:	8082                	ret

00000000000002c0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2c0:	48a1                	li	a7,8
 ecall
 2c2:	00000073          	ecall
 ret
 2c6:	8082                	ret

00000000000002c8 <link>:
.global link
link:
 li a7, SYS_link
 2c8:	48cd                	li	a7,19
 ecall
 2ca:	00000073          	ecall
 ret
 2ce:	8082                	ret

00000000000002d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2d0:	48d1                	li	a7,20
 ecall
 2d2:	00000073          	ecall
 ret
 2d6:	8082                	ret

00000000000002d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2d8:	48a5                	li	a7,9
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 2e0:	48a9                	li	a7,10
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 2e8:	48ad                	li	a7,11
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 2f0:	48b1                	li	a7,12
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 2f8:	48b5                	li	a7,13
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 300:	48b9                	li	a7,14
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	1000                	addi	s0,sp,32
 310:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 314:	4605                	li	a2,1
 316:	fef40593          	addi	a1,s0,-17
 31a:	00000097          	auipc	ra,0x0
 31e:	f6e080e7          	jalr	-146(ra) # 288 <write>
}
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	6105                	addi	sp,sp,32
 328:	8082                	ret

000000000000032a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 32a:	7139                	addi	sp,sp,-64
 32c:	fc06                	sd	ra,56(sp)
 32e:	f822                	sd	s0,48(sp)
 330:	f426                	sd	s1,40(sp)
 332:	f04a                	sd	s2,32(sp)
 334:	ec4e                	sd	s3,24(sp)
 336:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 338:	c299                	beqz	a3,33e <printint+0x14>
 33a:	0005cd63          	bltz	a1,354 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 33e:	2581                	sext.w	a1,a1
  neg = 0;
 340:	4301                	li	t1,0
 342:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 346:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 348:	2601                	sext.w	a2,a2
 34a:	00000897          	auipc	a7,0x0
 34e:	45688893          	addi	a7,a7,1110 # 7a0 <digits>
 352:	a801                	j	362 <printint+0x38>
    x = -xx;
 354:	40b005bb          	negw	a1,a1
 358:	2581                	sext.w	a1,a1
    neg = 1;
 35a:	4305                	li	t1,1
    x = -xx;
 35c:	b7dd                	j	342 <printint+0x18>
  }while((x /= base) != 0);
 35e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 360:	8836                	mv	a6,a3
 362:	0018069b          	addiw	a3,a6,1
 366:	02c5f7bb          	remuw	a5,a1,a2
 36a:	1782                	slli	a5,a5,0x20
 36c:	9381                	srli	a5,a5,0x20
 36e:	97c6                	add	a5,a5,a7
 370:	0007c783          	lbu	a5,0(a5)
 374:	00f70023          	sb	a5,0(a4)
 378:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 37a:	02c5d7bb          	divuw	a5,a1,a2
 37e:	fec5f0e3          	bleu	a2,a1,35e <printint+0x34>
  if(neg)
 382:	00030b63          	beqz	t1,398 <printint+0x6e>
    buf[i++] = '-';
 386:	fd040793          	addi	a5,s0,-48
 38a:	96be                	add	a3,a3,a5
 38c:	02d00793          	li	a5,45
 390:	fef68823          	sb	a5,-16(a3)
 394:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 398:	02d05963          	blez	a3,3ca <printint+0xa0>
 39c:	89aa                	mv	s3,a0
 39e:	fc040793          	addi	a5,s0,-64
 3a2:	00d784b3          	add	s1,a5,a3
 3a6:	fff78913          	addi	s2,a5,-1
 3aa:	9936                	add	s2,s2,a3
 3ac:	36fd                	addiw	a3,a3,-1
 3ae:	1682                	slli	a3,a3,0x20
 3b0:	9281                	srli	a3,a3,0x20
 3b2:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 3b6:	fff4c583          	lbu	a1,-1(s1)
 3ba:	854e                	mv	a0,s3
 3bc:	00000097          	auipc	ra,0x0
 3c0:	f4c080e7          	jalr	-180(ra) # 308 <putc>
 3c4:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 3c6:	ff2498e3          	bne	s1,s2,3b6 <printint+0x8c>
}
 3ca:	70e2                	ld	ra,56(sp)
 3cc:	7442                	ld	s0,48(sp)
 3ce:	74a2                	ld	s1,40(sp)
 3d0:	7902                	ld	s2,32(sp)
 3d2:	69e2                	ld	s3,24(sp)
 3d4:	6121                	addi	sp,sp,64
 3d6:	8082                	ret

00000000000003d8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3d8:	7119                	addi	sp,sp,-128
 3da:	fc86                	sd	ra,120(sp)
 3dc:	f8a2                	sd	s0,112(sp)
 3de:	f4a6                	sd	s1,104(sp)
 3e0:	f0ca                	sd	s2,96(sp)
 3e2:	ecce                	sd	s3,88(sp)
 3e4:	e8d2                	sd	s4,80(sp)
 3e6:	e4d6                	sd	s5,72(sp)
 3e8:	e0da                	sd	s6,64(sp)
 3ea:	fc5e                	sd	s7,56(sp)
 3ec:	f862                	sd	s8,48(sp)
 3ee:	f466                	sd	s9,40(sp)
 3f0:	f06a                	sd	s10,32(sp)
 3f2:	ec6e                	sd	s11,24(sp)
 3f4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 3f6:	0005c483          	lbu	s1,0(a1)
 3fa:	18048d63          	beqz	s1,594 <vprintf+0x1bc>
 3fe:	8aaa                	mv	s5,a0
 400:	8b32                	mv	s6,a2
 402:	00158913          	addi	s2,a1,1
  state = 0;
 406:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 408:	02500a13          	li	s4,37
      if(c == 'd'){
 40c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 410:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 414:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 418:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 41c:	00000b97          	auipc	s7,0x0
 420:	384b8b93          	addi	s7,s7,900 # 7a0 <digits>
 424:	a839                	j	442 <vprintf+0x6a>
        putc(fd, c);
 426:	85a6                	mv	a1,s1
 428:	8556                	mv	a0,s5
 42a:	00000097          	auipc	ra,0x0
 42e:	ede080e7          	jalr	-290(ra) # 308 <putc>
 432:	a019                	j	438 <vprintf+0x60>
    } else if(state == '%'){
 434:	01498f63          	beq	s3,s4,452 <vprintf+0x7a>
 438:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 43a:	fff94483          	lbu	s1,-1(s2)
 43e:	14048b63          	beqz	s1,594 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 442:	0004879b          	sext.w	a5,s1
    if(state == 0){
 446:	fe0997e3          	bnez	s3,434 <vprintf+0x5c>
      if(c == '%'){
 44a:	fd479ee3          	bne	a5,s4,426 <vprintf+0x4e>
        state = '%';
 44e:	89be                	mv	s3,a5
 450:	b7e5                	j	438 <vprintf+0x60>
      if(c == 'd'){
 452:	05878063          	beq	a5,s8,492 <vprintf+0xba>
      } else if(c == 'l') {
 456:	05978c63          	beq	a5,s9,4ae <vprintf+0xd6>
      } else if(c == 'x') {
 45a:	07a78863          	beq	a5,s10,4ca <vprintf+0xf2>
      } else if(c == 'p') {
 45e:	09b78463          	beq	a5,s11,4e6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 462:	07300713          	li	a4,115
 466:	0ce78563          	beq	a5,a4,530 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 46a:	06300713          	li	a4,99
 46e:	0ee78c63          	beq	a5,a4,566 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 472:	11478663          	beq	a5,s4,57e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 476:	85d2                	mv	a1,s4
 478:	8556                	mv	a0,s5
 47a:	00000097          	auipc	ra,0x0
 47e:	e8e080e7          	jalr	-370(ra) # 308 <putc>
        putc(fd, c);
 482:	85a6                	mv	a1,s1
 484:	8556                	mv	a0,s5
 486:	00000097          	auipc	ra,0x0
 48a:	e82080e7          	jalr	-382(ra) # 308 <putc>
      }
      state = 0;
 48e:	4981                	li	s3,0
 490:	b765                	j	438 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 492:	008b0493          	addi	s1,s6,8
 496:	4685                	li	a3,1
 498:	4629                	li	a2,10
 49a:	000b2583          	lw	a1,0(s6)
 49e:	8556                	mv	a0,s5
 4a0:	00000097          	auipc	ra,0x0
 4a4:	e8a080e7          	jalr	-374(ra) # 32a <printint>
 4a8:	8b26                	mv	s6,s1
      state = 0;
 4aa:	4981                	li	s3,0
 4ac:	b771                	j	438 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ae:	008b0493          	addi	s1,s6,8
 4b2:	4681                	li	a3,0
 4b4:	4629                	li	a2,10
 4b6:	000b2583          	lw	a1,0(s6)
 4ba:	8556                	mv	a0,s5
 4bc:	00000097          	auipc	ra,0x0
 4c0:	e6e080e7          	jalr	-402(ra) # 32a <printint>
 4c4:	8b26                	mv	s6,s1
      state = 0;
 4c6:	4981                	li	s3,0
 4c8:	bf85                	j	438 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 4ca:	008b0493          	addi	s1,s6,8
 4ce:	4681                	li	a3,0
 4d0:	4641                	li	a2,16
 4d2:	000b2583          	lw	a1,0(s6)
 4d6:	8556                	mv	a0,s5
 4d8:	00000097          	auipc	ra,0x0
 4dc:	e52080e7          	jalr	-430(ra) # 32a <printint>
 4e0:	8b26                	mv	s6,s1
      state = 0;
 4e2:	4981                	li	s3,0
 4e4:	bf91                	j	438 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 4e6:	008b0793          	addi	a5,s6,8
 4ea:	f8f43423          	sd	a5,-120(s0)
 4ee:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 4f2:	03000593          	li	a1,48
 4f6:	8556                	mv	a0,s5
 4f8:	00000097          	auipc	ra,0x0
 4fc:	e10080e7          	jalr	-496(ra) # 308 <putc>
  putc(fd, 'x');
 500:	85ea                	mv	a1,s10
 502:	8556                	mv	a0,s5
 504:	00000097          	auipc	ra,0x0
 508:	e04080e7          	jalr	-508(ra) # 308 <putc>
 50c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50e:	03c9d793          	srli	a5,s3,0x3c
 512:	97de                	add	a5,a5,s7
 514:	0007c583          	lbu	a1,0(a5)
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	dee080e7          	jalr	-530(ra) # 308 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 522:	0992                	slli	s3,s3,0x4
 524:	34fd                	addiw	s1,s1,-1
 526:	f4e5                	bnez	s1,50e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 528:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 52c:	4981                	li	s3,0
 52e:	b729                	j	438 <vprintf+0x60>
        s = va_arg(ap, char*);
 530:	008b0993          	addi	s3,s6,8
 534:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 538:	c085                	beqz	s1,558 <vprintf+0x180>
        while(*s != 0){
 53a:	0004c583          	lbu	a1,0(s1)
 53e:	c9a1                	beqz	a1,58e <vprintf+0x1b6>
          putc(fd, *s);
 540:	8556                	mv	a0,s5
 542:	00000097          	auipc	ra,0x0
 546:	dc6080e7          	jalr	-570(ra) # 308 <putc>
          s++;
 54a:	0485                	addi	s1,s1,1
        while(*s != 0){
 54c:	0004c583          	lbu	a1,0(s1)
 550:	f9e5                	bnez	a1,540 <vprintf+0x168>
        s = va_arg(ap, char*);
 552:	8b4e                	mv	s6,s3
      state = 0;
 554:	4981                	li	s3,0
 556:	b5cd                	j	438 <vprintf+0x60>
          s = "(null)";
 558:	00000497          	auipc	s1,0x0
 55c:	26048493          	addi	s1,s1,608 # 7b8 <digits+0x18>
        while(*s != 0){
 560:	02800593          	li	a1,40
 564:	bff1                	j	540 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 566:	008b0493          	addi	s1,s6,8
 56a:	000b4583          	lbu	a1,0(s6)
 56e:	8556                	mv	a0,s5
 570:	00000097          	auipc	ra,0x0
 574:	d98080e7          	jalr	-616(ra) # 308 <putc>
 578:	8b26                	mv	s6,s1
      state = 0;
 57a:	4981                	li	s3,0
 57c:	bd75                	j	438 <vprintf+0x60>
        putc(fd, c);
 57e:	85d2                	mv	a1,s4
 580:	8556                	mv	a0,s5
 582:	00000097          	auipc	ra,0x0
 586:	d86080e7          	jalr	-634(ra) # 308 <putc>
      state = 0;
 58a:	4981                	li	s3,0
 58c:	b575                	j	438 <vprintf+0x60>
        s = va_arg(ap, char*);
 58e:	8b4e                	mv	s6,s3
      state = 0;
 590:	4981                	li	s3,0
 592:	b55d                	j	438 <vprintf+0x60>
    }
  }
}
 594:	70e6                	ld	ra,120(sp)
 596:	7446                	ld	s0,112(sp)
 598:	74a6                	ld	s1,104(sp)
 59a:	7906                	ld	s2,96(sp)
 59c:	69e6                	ld	s3,88(sp)
 59e:	6a46                	ld	s4,80(sp)
 5a0:	6aa6                	ld	s5,72(sp)
 5a2:	6b06                	ld	s6,64(sp)
 5a4:	7be2                	ld	s7,56(sp)
 5a6:	7c42                	ld	s8,48(sp)
 5a8:	7ca2                	ld	s9,40(sp)
 5aa:	7d02                	ld	s10,32(sp)
 5ac:	6de2                	ld	s11,24(sp)
 5ae:	6109                	addi	sp,sp,128
 5b0:	8082                	ret

00000000000005b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5b2:	715d                	addi	sp,sp,-80
 5b4:	ec06                	sd	ra,24(sp)
 5b6:	e822                	sd	s0,16(sp)
 5b8:	1000                	addi	s0,sp,32
 5ba:	e010                	sd	a2,0(s0)
 5bc:	e414                	sd	a3,8(s0)
 5be:	e818                	sd	a4,16(s0)
 5c0:	ec1c                	sd	a5,24(s0)
 5c2:	03043023          	sd	a6,32(s0)
 5c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 5ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 5ce:	8622                	mv	a2,s0
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e08080e7          	jalr	-504(ra) # 3d8 <vprintf>
}
 5d8:	60e2                	ld	ra,24(sp)
 5da:	6442                	ld	s0,16(sp)
 5dc:	6161                	addi	sp,sp,80
 5de:	8082                	ret

00000000000005e0 <printf>:

void
printf(const char *fmt, ...)
{
 5e0:	711d                	addi	sp,sp,-96
 5e2:	ec06                	sd	ra,24(sp)
 5e4:	e822                	sd	s0,16(sp)
 5e6:	1000                	addi	s0,sp,32
 5e8:	e40c                	sd	a1,8(s0)
 5ea:	e810                	sd	a2,16(s0)
 5ec:	ec14                	sd	a3,24(s0)
 5ee:	f018                	sd	a4,32(s0)
 5f0:	f41c                	sd	a5,40(s0)
 5f2:	03043823          	sd	a6,48(s0)
 5f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 5fa:	00840613          	addi	a2,s0,8
 5fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 602:	85aa                	mv	a1,a0
 604:	4505                	li	a0,1
 606:	00000097          	auipc	ra,0x0
 60a:	dd2080e7          	jalr	-558(ra) # 3d8 <vprintf>
}
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	6125                	addi	sp,sp,96
 614:	8082                	ret

0000000000000616 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 616:	1141                	addi	sp,sp,-16
 618:	e422                	sd	s0,8(sp)
 61a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 61c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 620:	00000797          	auipc	a5,0x0
 624:	1a078793          	addi	a5,a5,416 # 7c0 <__bss_start>
 628:	639c                	ld	a5,0(a5)
 62a:	a805                	j	65a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 62c:	4618                	lw	a4,8(a2)
 62e:	9db9                	addw	a1,a1,a4
 630:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 634:	6398                	ld	a4,0(a5)
 636:	6318                	ld	a4,0(a4)
 638:	fee53823          	sd	a4,-16(a0)
 63c:	a091                	j	680 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 63e:	ff852703          	lw	a4,-8(a0)
 642:	9e39                	addw	a2,a2,a4
 644:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 646:	ff053703          	ld	a4,-16(a0)
 64a:	e398                	sd	a4,0(a5)
 64c:	a099                	j	692 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64e:	6398                	ld	a4,0(a5)
 650:	00e7e463          	bltu	a5,a4,658 <free+0x42>
 654:	00e6ea63          	bltu	a3,a4,668 <free+0x52>
{
 658:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65a:	fed7fae3          	bleu	a3,a5,64e <free+0x38>
 65e:	6398                	ld	a4,0(a5)
 660:	00e6e463          	bltu	a3,a4,668 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 664:	fee7eae3          	bltu	a5,a4,658 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 668:	ff852583          	lw	a1,-8(a0)
 66c:	6390                	ld	a2,0(a5)
 66e:	02059713          	slli	a4,a1,0x20
 672:	9301                	srli	a4,a4,0x20
 674:	0712                	slli	a4,a4,0x4
 676:	9736                	add	a4,a4,a3
 678:	fae60ae3          	beq	a2,a4,62c <free+0x16>
    bp->s.ptr = p->s.ptr;
 67c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 680:	4790                	lw	a2,8(a5)
 682:	02061713          	slli	a4,a2,0x20
 686:	9301                	srli	a4,a4,0x20
 688:	0712                	slli	a4,a4,0x4
 68a:	973e                	add	a4,a4,a5
 68c:	fae689e3          	beq	a3,a4,63e <free+0x28>
  } else
    p->s.ptr = bp;
 690:	e394                	sd	a3,0(a5)
  freep = p;
 692:	00000717          	auipc	a4,0x0
 696:	12f73723          	sd	a5,302(a4) # 7c0 <__bss_start>
}
 69a:	6422                	ld	s0,8(sp)
 69c:	0141                	addi	sp,sp,16
 69e:	8082                	ret

00000000000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	7139                	addi	sp,sp,-64
 6a2:	fc06                	sd	ra,56(sp)
 6a4:	f822                	sd	s0,48(sp)
 6a6:	f426                	sd	s1,40(sp)
 6a8:	f04a                	sd	s2,32(sp)
 6aa:	ec4e                	sd	s3,24(sp)
 6ac:	e852                	sd	s4,16(sp)
 6ae:	e456                	sd	s5,8(sp)
 6b0:	e05a                	sd	s6,0(sp)
 6b2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b4:	02051993          	slli	s3,a0,0x20
 6b8:	0209d993          	srli	s3,s3,0x20
 6bc:	09bd                	addi	s3,s3,15
 6be:	0049d993          	srli	s3,s3,0x4
 6c2:	2985                	addiw	s3,s3,1
 6c4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 6c8:	00000797          	auipc	a5,0x0
 6cc:	0f878793          	addi	a5,a5,248 # 7c0 <__bss_start>
 6d0:	6388                	ld	a0,0(a5)
 6d2:	c515                	beqz	a0,6fe <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 6d6:	4798                	lw	a4,8(a5)
 6d8:	03277f63          	bleu	s2,a4,716 <malloc+0x76>
 6dc:	8a4e                	mv	s4,s3
 6de:	0009871b          	sext.w	a4,s3
 6e2:	6685                	lui	a3,0x1
 6e4:	00d77363          	bleu	a3,a4,6ea <malloc+0x4a>
 6e8:	6a05                	lui	s4,0x1
 6ea:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 6ee:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f2:	00000497          	auipc	s1,0x0
 6f6:	0ce48493          	addi	s1,s1,206 # 7c0 <__bss_start>
  if(p == (char*)-1)
 6fa:	5b7d                	li	s6,-1
 6fc:	a885                	j	76c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 6fe:	00000797          	auipc	a5,0x0
 702:	0ca78793          	addi	a5,a5,202 # 7c8 <base>
 706:	00000717          	auipc	a4,0x0
 70a:	0af73d23          	sd	a5,186(a4) # 7c0 <__bss_start>
 70e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 710:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 714:	b7e1                	j	6dc <malloc+0x3c>
      if(p->s.size == nunits)
 716:	02e90b63          	beq	s2,a4,74c <malloc+0xac>
        p->s.size -= nunits;
 71a:	4137073b          	subw	a4,a4,s3
 71e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 720:	1702                	slli	a4,a4,0x20
 722:	9301                	srli	a4,a4,0x20
 724:	0712                	slli	a4,a4,0x4
 726:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 728:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 72c:	00000717          	auipc	a4,0x0
 730:	08a73a23          	sd	a0,148(a4) # 7c0 <__bss_start>
      return (void*)(p + 1);
 734:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 738:	70e2                	ld	ra,56(sp)
 73a:	7442                	ld	s0,48(sp)
 73c:	74a2                	ld	s1,40(sp)
 73e:	7902                	ld	s2,32(sp)
 740:	69e2                	ld	s3,24(sp)
 742:	6a42                	ld	s4,16(sp)
 744:	6aa2                	ld	s5,8(sp)
 746:	6b02                	ld	s6,0(sp)
 748:	6121                	addi	sp,sp,64
 74a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 74c:	6398                	ld	a4,0(a5)
 74e:	e118                	sd	a4,0(a0)
 750:	bff1                	j	72c <malloc+0x8c>
  hp->s.size = nu;
 752:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 756:	0541                	addi	a0,a0,16
 758:	00000097          	auipc	ra,0x0
 75c:	ebe080e7          	jalr	-322(ra) # 616 <free>
  return freep;
 760:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 762:	d979                	beqz	a0,738 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 764:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 766:	4798                	lw	a4,8(a5)
 768:	fb2777e3          	bleu	s2,a4,716 <malloc+0x76>
    if(p == freep)
 76c:	6098                	ld	a4,0(s1)
 76e:	853e                	mv	a0,a5
 770:	fef71ae3          	bne	a4,a5,764 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 774:	8552                	mv	a0,s4
 776:	00000097          	auipc	ra,0x0
 77a:	b7a080e7          	jalr	-1158(ra) # 2f0 <sbrk>
  if(p == (char*)-1)
 77e:	fd651ae3          	bne	a0,s6,752 <malloc+0xb2>
        return 0;
 782:	4501                	li	a0,0
 784:	bf55                	j	738 <malloc+0x98>
