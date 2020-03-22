
user/_echo:     file format elf64-littleriscv


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
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	ble	a0,a5,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00000a17          	auipc	s4,0x0
  2e:	77ea0a13          	addi	s4,s4,1918 # 7a8 <malloc+0xe8>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	09c080e7          	jalr	156(ra) # d4 <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	260080e7          	jalr	608(ra) # 2a8 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	24c080e7          	jalr	588(ra) # 2a8 <write>
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00000597          	auipc	a1,0x0
  6c:	74858593          	addi	a1,a1,1864 # 7b0 <malloc+0xf0>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	236080e7          	jalr	566(ra) # 2a8 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	20c080e7          	jalr	524(ra) # 288 <exit>

0000000000000084 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	87aa                	mv	a5,a0
  8c:	0585                	addi	a1,a1,1
  8e:	0785                	addi	a5,a5,1
  90:	fff5c703          	lbu	a4,-1(a1)
  94:	fee78fa3          	sb	a4,-1(a5)
  98:	fb75                	bnez	a4,8c <strcpy+0x8>
    ;
  return os;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret

00000000000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a6:	00054783          	lbu	a5,0(a0)
  aa:	cf91                	beqz	a5,c6 <strcmp+0x26>
  ac:	0005c703          	lbu	a4,0(a1)
  b0:	00f71b63          	bne	a4,a5,c6 <strcmp+0x26>
    p++, q++;
  b4:	0505                	addi	a0,a0,1
  b6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	c789                	beqz	a5,c6 <strcmp+0x26>
  be:	0005c703          	lbu	a4,0(a1)
  c2:	fef709e3          	beq	a4,a5,b4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  c6:	0005c503          	lbu	a0,0(a1)
}
  ca:	40a7853b          	subw	a0,a5,a0
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf91                	beqz	a5,fa <strlen+0x26>
  e0:	0505                	addi	a0,a0,1
  e2:	87aa                	mv	a5,a0
  e4:	4685                	li	a3,1
  e6:	9e89                	subw	a3,a3,a0
    ;
  e8:	00f6853b          	addw	a0,a3,a5
  ec:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  ee:	fff7c703          	lbu	a4,-1(a5)
  f2:	fb7d                	bnez	a4,e8 <strlen+0x14>
  return n;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  for(n = 0; s[n]; n++)
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strlen+0x20>

00000000000000fe <memset>:

void*
memset(void *dst, int c, uint n)
{
  fe:	1141                	addi	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 104:	ce09                	beqz	a2,11e <memset+0x20>
 106:	87aa                	mv	a5,a0
 108:	fff6071b          	addiw	a4,a2,-1
 10c:	1702                	slli	a4,a4,0x20
 10e:	9301                	srli	a4,a4,0x20
 110:	0705                	addi	a4,a4,1
 112:	972a                	add	a4,a4,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
 118:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x16>
  }
  return dst;
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	1141                	addi	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	addi	s0,sp,16
  for(; *s; s++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cf91                	beqz	a5,14a <strchr+0x26>
    if(*s == c)
 130:	00f58a63          	beq	a1,a5,144 <strchr+0x20>
  for(; *s; s++)
 134:	0505                	addi	a0,a0,1
 136:	00054783          	lbu	a5,0(a0)
 13a:	c781                	beqz	a5,142 <strchr+0x1e>
    if(*s == c)
 13c:	feb79ce3          	bne	a5,a1,134 <strchr+0x10>
 140:	a011                	j	144 <strchr+0x20>
      return (char*)s;
  return 0;
 142:	4501                	li	a0,0
}
 144:	6422                	ld	s0,8(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret
  return 0;
 14a:	4501                	li	a0,0
 14c:	bfe5                	j	144 <strchr+0x20>

000000000000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	711d                	addi	sp,sp,-96
 150:	ec86                	sd	ra,88(sp)
 152:	e8a2                	sd	s0,80(sp)
 154:	e4a6                	sd	s1,72(sp)
 156:	e0ca                	sd	s2,64(sp)
 158:	fc4e                	sd	s3,56(sp)
 15a:	f852                	sd	s4,48(sp)
 15c:	f456                	sd	s5,40(sp)
 15e:	f05a                	sd	s6,32(sp)
 160:	ec5e                	sd	s7,24(sp)
 162:	1080                	addi	s0,sp,96
 164:	8baa                	mv	s7,a0
 166:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 168:	892a                	mv	s2,a0
 16a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16c:	4aa9                	li	s5,10
 16e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 170:	0019849b          	addiw	s1,s3,1
 174:	0344d863          	ble	s4,s1,1a4 <gets+0x56>
    cc = read(0, &c, 1);
 178:	4605                	li	a2,1
 17a:	faf40593          	addi	a1,s0,-81
 17e:	4501                	li	a0,0
 180:	00000097          	auipc	ra,0x0
 184:	120080e7          	jalr	288(ra) # 2a0 <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x56>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x54>
 198:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 19a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 19c:	fd679ae3          	bne	a5,s6,170 <gets+0x22>
 1a0:	a011                	j	1a4 <gets+0x56>
  for(i=0; i+1 < max; ){
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e426                	sd	s1,8(sp)
 1ca:	e04a                	sd	s2,0(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d0:	4581                	li	a1,0
 1d2:	00000097          	auipc	ra,0x0
 1d6:	0f6080e7          	jalr	246(ra) # 2c8 <open>
  if(fd < 0)
 1da:	02054563          	bltz	a0,204 <stat+0x42>
 1de:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e0:	85ca                	mv	a1,s2
 1e2:	00000097          	auipc	ra,0x0
 1e6:	0fe080e7          	jalr	254(ra) # 2e0 <fstat>
 1ea:	892a                	mv	s2,a0
  close(fd);
 1ec:	8526                	mv	a0,s1
 1ee:	00000097          	auipc	ra,0x0
 1f2:	0c2080e7          	jalr	194(ra) # 2b0 <close>
  return r;
}
 1f6:	854a                	mv	a0,s2
 1f8:	60e2                	ld	ra,24(sp)
 1fa:	6442                	ld	s0,16(sp)
 1fc:	64a2                	ld	s1,8(sp)
 1fe:	6902                	ld	s2,0(sp)
 200:	6105                	addi	sp,sp,32
 202:	8082                	ret
    return -1;
 204:	597d                	li	s2,-1
 206:	bfc5                	j	1f6 <stat+0x34>

0000000000000208 <atoi>:

int
atoi(const char *s)
{
 208:	1141                	addi	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20e:	00054683          	lbu	a3,0(a0)
 212:	fd06879b          	addiw	a5,a3,-48
 216:	0ff7f793          	andi	a5,a5,255
 21a:	4725                	li	a4,9
 21c:	02f76963          	bltu	a4,a5,24e <atoi+0x46>
 220:	862a                	mv	a2,a0
  n = 0;
 222:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 224:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 226:	0605                	addi	a2,a2,1
 228:	0025179b          	slliw	a5,a0,0x2
 22c:	9fa9                	addw	a5,a5,a0
 22e:	0017979b          	slliw	a5,a5,0x1
 232:	9fb5                	addw	a5,a5,a3
 234:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 238:	00064683          	lbu	a3,0(a2)
 23c:	fd06871b          	addiw	a4,a3,-48
 240:	0ff77713          	andi	a4,a4,255
 244:	fee5f1e3          	bleu	a4,a1,226 <atoi+0x1e>
  return n;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
  n = 0;
 24e:	4501                	li	a0,0
 250:	bfe5                	j	248 <atoi+0x40>

0000000000000252 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 258:	02c05163          	blez	a2,27a <memmove+0x28>
 25c:	fff6071b          	addiw	a4,a2,-1
 260:	1702                	slli	a4,a4,0x20
 262:	9301                	srli	a4,a4,0x20
 264:	0705                	addi	a4,a4,1
 266:	972a                	add	a4,a4,a0
  dst = vdst;
 268:	87aa                	mv	a5,a0
    *dst++ = *src++;
 26a:	0585                	addi	a1,a1,1
 26c:	0785                	addi	a5,a5,1
 26e:	fff5c683          	lbu	a3,-1(a1)
 272:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 276:	fee79ae3          	bne	a5,a4,26a <memmove+0x18>
  return vdst;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret

0000000000000280 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 280:	4885                	li	a7,1
 ecall
 282:	00000073          	ecall
 ret
 286:	8082                	ret

0000000000000288 <exit>:
.global exit
exit:
 li a7, SYS_exit
 288:	4889                	li	a7,2
 ecall
 28a:	00000073          	ecall
 ret
 28e:	8082                	ret

0000000000000290 <wait>:
.global wait
wait:
 li a7, SYS_wait
 290:	488d                	li	a7,3
 ecall
 292:	00000073          	ecall
 ret
 296:	8082                	ret

0000000000000298 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 298:	4891                	li	a7,4
 ecall
 29a:	00000073          	ecall
 ret
 29e:	8082                	ret

00000000000002a0 <read>:
.global read
read:
 li a7, SYS_read
 2a0:	4895                	li	a7,5
 ecall
 2a2:	00000073          	ecall
 ret
 2a6:	8082                	ret

00000000000002a8 <write>:
.global write
write:
 li a7, SYS_write
 2a8:	48c1                	li	a7,16
 ecall
 2aa:	00000073          	ecall
 ret
 2ae:	8082                	ret

00000000000002b0 <close>:
.global close
close:
 li a7, SYS_close
 2b0:	48d5                	li	a7,21
 ecall
 2b2:	00000073          	ecall
 ret
 2b6:	8082                	ret

00000000000002b8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2b8:	4899                	li	a7,6
 ecall
 2ba:	00000073          	ecall
 ret
 2be:	8082                	ret

00000000000002c0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2c0:	489d                	li	a7,7
 ecall
 2c2:	00000073          	ecall
 ret
 2c6:	8082                	ret

00000000000002c8 <open>:
.global open
open:
 li a7, SYS_open
 2c8:	48bd                	li	a7,15
 ecall
 2ca:	00000073          	ecall
 ret
 2ce:	8082                	ret

00000000000002d0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2d0:	48c5                	li	a7,17
 ecall
 2d2:	00000073          	ecall
 ret
 2d6:	8082                	ret

00000000000002d8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2d8:	48c9                	li	a7,18
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2e0:	48a1                	li	a7,8
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <link>:
.global link
link:
 li a7, SYS_link
 2e8:	48cd                	li	a7,19
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2f0:	48d1                	li	a7,20
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2f8:	48a5                	li	a7,9
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <dup>:
.global dup
dup:
 li a7, SYS_dup
 300:	48a9                	li	a7,10
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 308:	48ad                	li	a7,11
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 310:	48b1                	li	a7,12
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 318:	48b5                	li	a7,13
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 320:	48b9                	li	a7,14
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 328:	1101                	addi	sp,sp,-32
 32a:	ec06                	sd	ra,24(sp)
 32c:	e822                	sd	s0,16(sp)
 32e:	1000                	addi	s0,sp,32
 330:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 334:	4605                	li	a2,1
 336:	fef40593          	addi	a1,s0,-17
 33a:	00000097          	auipc	ra,0x0
 33e:	f6e080e7          	jalr	-146(ra) # 2a8 <write>
}
 342:	60e2                	ld	ra,24(sp)
 344:	6442                	ld	s0,16(sp)
 346:	6105                	addi	sp,sp,32
 348:	8082                	ret

000000000000034a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 34a:	7139                	addi	sp,sp,-64
 34c:	fc06                	sd	ra,56(sp)
 34e:	f822                	sd	s0,48(sp)
 350:	f426                	sd	s1,40(sp)
 352:	f04a                	sd	s2,32(sp)
 354:	ec4e                	sd	s3,24(sp)
 356:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 358:	c299                	beqz	a3,35e <printint+0x14>
 35a:	0005cd63          	bltz	a1,374 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 35e:	2581                	sext.w	a1,a1
  neg = 0;
 360:	4301                	li	t1,0
 362:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 366:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 368:	2601                	sext.w	a2,a2
 36a:	00000897          	auipc	a7,0x0
 36e:	44e88893          	addi	a7,a7,1102 # 7b8 <digits>
 372:	a801                	j	382 <printint+0x38>
    x = -xx;
 374:	40b005bb          	negw	a1,a1
 378:	2581                	sext.w	a1,a1
    neg = 1;
 37a:	4305                	li	t1,1
    x = -xx;
 37c:	b7dd                	j	362 <printint+0x18>
  }while((x /= base) != 0);
 37e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 380:	8836                	mv	a6,a3
 382:	0018069b          	addiw	a3,a6,1
 386:	02c5f7bb          	remuw	a5,a1,a2
 38a:	1782                	slli	a5,a5,0x20
 38c:	9381                	srli	a5,a5,0x20
 38e:	97c6                	add	a5,a5,a7
 390:	0007c783          	lbu	a5,0(a5)
 394:	00f70023          	sb	a5,0(a4)
 398:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 39a:	02c5d7bb          	divuw	a5,a1,a2
 39e:	fec5f0e3          	bleu	a2,a1,37e <printint+0x34>
  if(neg)
 3a2:	00030b63          	beqz	t1,3b8 <printint+0x6e>
    buf[i++] = '-';
 3a6:	fd040793          	addi	a5,s0,-48
 3aa:	96be                	add	a3,a3,a5
 3ac:	02d00793          	li	a5,45
 3b0:	fef68823          	sb	a5,-16(a3)
 3b4:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 3b8:	02d05963          	blez	a3,3ea <printint+0xa0>
 3bc:	89aa                	mv	s3,a0
 3be:	fc040793          	addi	a5,s0,-64
 3c2:	00d784b3          	add	s1,a5,a3
 3c6:	fff78913          	addi	s2,a5,-1
 3ca:	9936                	add	s2,s2,a3
 3cc:	36fd                	addiw	a3,a3,-1
 3ce:	1682                	slli	a3,a3,0x20
 3d0:	9281                	srli	a3,a3,0x20
 3d2:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 3d6:	fff4c583          	lbu	a1,-1(s1)
 3da:	854e                	mv	a0,s3
 3dc:	00000097          	auipc	ra,0x0
 3e0:	f4c080e7          	jalr	-180(ra) # 328 <putc>
 3e4:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 3e6:	ff2498e3          	bne	s1,s2,3d6 <printint+0x8c>
}
 3ea:	70e2                	ld	ra,56(sp)
 3ec:	7442                	ld	s0,48(sp)
 3ee:	74a2                	ld	s1,40(sp)
 3f0:	7902                	ld	s2,32(sp)
 3f2:	69e2                	ld	s3,24(sp)
 3f4:	6121                	addi	sp,sp,64
 3f6:	8082                	ret

00000000000003f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3f8:	7119                	addi	sp,sp,-128
 3fa:	fc86                	sd	ra,120(sp)
 3fc:	f8a2                	sd	s0,112(sp)
 3fe:	f4a6                	sd	s1,104(sp)
 400:	f0ca                	sd	s2,96(sp)
 402:	ecce                	sd	s3,88(sp)
 404:	e8d2                	sd	s4,80(sp)
 406:	e4d6                	sd	s5,72(sp)
 408:	e0da                	sd	s6,64(sp)
 40a:	fc5e                	sd	s7,56(sp)
 40c:	f862                	sd	s8,48(sp)
 40e:	f466                	sd	s9,40(sp)
 410:	f06a                	sd	s10,32(sp)
 412:	ec6e                	sd	s11,24(sp)
 414:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 416:	0005c483          	lbu	s1,0(a1)
 41a:	18048d63          	beqz	s1,5b4 <vprintf+0x1bc>
 41e:	8aaa                	mv	s5,a0
 420:	8b32                	mv	s6,a2
 422:	00158913          	addi	s2,a1,1
  state = 0;
 426:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 428:	02500a13          	li	s4,37
      if(c == 'd'){
 42c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 430:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 434:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 438:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 43c:	00000b97          	auipc	s7,0x0
 440:	37cb8b93          	addi	s7,s7,892 # 7b8 <digits>
 444:	a839                	j	462 <vprintf+0x6a>
        putc(fd, c);
 446:	85a6                	mv	a1,s1
 448:	8556                	mv	a0,s5
 44a:	00000097          	auipc	ra,0x0
 44e:	ede080e7          	jalr	-290(ra) # 328 <putc>
 452:	a019                	j	458 <vprintf+0x60>
    } else if(state == '%'){
 454:	01498f63          	beq	s3,s4,472 <vprintf+0x7a>
 458:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 45a:	fff94483          	lbu	s1,-1(s2)
 45e:	14048b63          	beqz	s1,5b4 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 462:	0004879b          	sext.w	a5,s1
    if(state == 0){
 466:	fe0997e3          	bnez	s3,454 <vprintf+0x5c>
      if(c == '%'){
 46a:	fd479ee3          	bne	a5,s4,446 <vprintf+0x4e>
        state = '%';
 46e:	89be                	mv	s3,a5
 470:	b7e5                	j	458 <vprintf+0x60>
      if(c == 'd'){
 472:	05878063          	beq	a5,s8,4b2 <vprintf+0xba>
      } else if(c == 'l') {
 476:	05978c63          	beq	a5,s9,4ce <vprintf+0xd6>
      } else if(c == 'x') {
 47a:	07a78863          	beq	a5,s10,4ea <vprintf+0xf2>
      } else if(c == 'p') {
 47e:	09b78463          	beq	a5,s11,506 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 482:	07300713          	li	a4,115
 486:	0ce78563          	beq	a5,a4,550 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48a:	06300713          	li	a4,99
 48e:	0ee78c63          	beq	a5,a4,586 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 492:	11478663          	beq	a5,s4,59e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 496:	85d2                	mv	a1,s4
 498:	8556                	mv	a0,s5
 49a:	00000097          	auipc	ra,0x0
 49e:	e8e080e7          	jalr	-370(ra) # 328 <putc>
        putc(fd, c);
 4a2:	85a6                	mv	a1,s1
 4a4:	8556                	mv	a0,s5
 4a6:	00000097          	auipc	ra,0x0
 4aa:	e82080e7          	jalr	-382(ra) # 328 <putc>
      }
      state = 0;
 4ae:	4981                	li	s3,0
 4b0:	b765                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4b2:	008b0493          	addi	s1,s6,8
 4b6:	4685                	li	a3,1
 4b8:	4629                	li	a2,10
 4ba:	000b2583          	lw	a1,0(s6)
 4be:	8556                	mv	a0,s5
 4c0:	00000097          	auipc	ra,0x0
 4c4:	e8a080e7          	jalr	-374(ra) # 34a <printint>
 4c8:	8b26                	mv	s6,s1
      state = 0;
 4ca:	4981                	li	s3,0
 4cc:	b771                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ce:	008b0493          	addi	s1,s6,8
 4d2:	4681                	li	a3,0
 4d4:	4629                	li	a2,10
 4d6:	000b2583          	lw	a1,0(s6)
 4da:	8556                	mv	a0,s5
 4dc:	00000097          	auipc	ra,0x0
 4e0:	e6e080e7          	jalr	-402(ra) # 34a <printint>
 4e4:	8b26                	mv	s6,s1
      state = 0;
 4e6:	4981                	li	s3,0
 4e8:	bf85                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 4ea:	008b0493          	addi	s1,s6,8
 4ee:	4681                	li	a3,0
 4f0:	4641                	li	a2,16
 4f2:	000b2583          	lw	a1,0(s6)
 4f6:	8556                	mv	a0,s5
 4f8:	00000097          	auipc	ra,0x0
 4fc:	e52080e7          	jalr	-430(ra) # 34a <printint>
 500:	8b26                	mv	s6,s1
      state = 0;
 502:	4981                	li	s3,0
 504:	bf91                	j	458 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 506:	008b0793          	addi	a5,s6,8
 50a:	f8f43423          	sd	a5,-120(s0)
 50e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 512:	03000593          	li	a1,48
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	e10080e7          	jalr	-496(ra) # 328 <putc>
  putc(fd, 'x');
 520:	85ea                	mv	a1,s10
 522:	8556                	mv	a0,s5
 524:	00000097          	auipc	ra,0x0
 528:	e04080e7          	jalr	-508(ra) # 328 <putc>
 52c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 52e:	03c9d793          	srli	a5,s3,0x3c
 532:	97de                	add	a5,a5,s7
 534:	0007c583          	lbu	a1,0(a5)
 538:	8556                	mv	a0,s5
 53a:	00000097          	auipc	ra,0x0
 53e:	dee080e7          	jalr	-530(ra) # 328 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 542:	0992                	slli	s3,s3,0x4
 544:	34fd                	addiw	s1,s1,-1
 546:	f4e5                	bnez	s1,52e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 548:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 54c:	4981                	li	s3,0
 54e:	b729                	j	458 <vprintf+0x60>
        s = va_arg(ap, char*);
 550:	008b0993          	addi	s3,s6,8
 554:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 558:	c085                	beqz	s1,578 <vprintf+0x180>
        while(*s != 0){
 55a:	0004c583          	lbu	a1,0(s1)
 55e:	c9a1                	beqz	a1,5ae <vprintf+0x1b6>
          putc(fd, *s);
 560:	8556                	mv	a0,s5
 562:	00000097          	auipc	ra,0x0
 566:	dc6080e7          	jalr	-570(ra) # 328 <putc>
          s++;
 56a:	0485                	addi	s1,s1,1
        while(*s != 0){
 56c:	0004c583          	lbu	a1,0(s1)
 570:	f9e5                	bnez	a1,560 <vprintf+0x168>
        s = va_arg(ap, char*);
 572:	8b4e                	mv	s6,s3
      state = 0;
 574:	4981                	li	s3,0
 576:	b5cd                	j	458 <vprintf+0x60>
          s = "(null)";
 578:	00000497          	auipc	s1,0x0
 57c:	25848493          	addi	s1,s1,600 # 7d0 <digits+0x18>
        while(*s != 0){
 580:	02800593          	li	a1,40
 584:	bff1                	j	560 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 586:	008b0493          	addi	s1,s6,8
 58a:	000b4583          	lbu	a1,0(s6)
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	d98080e7          	jalr	-616(ra) # 328 <putc>
 598:	8b26                	mv	s6,s1
      state = 0;
 59a:	4981                	li	s3,0
 59c:	bd75                	j	458 <vprintf+0x60>
        putc(fd, c);
 59e:	85d2                	mv	a1,s4
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	d86080e7          	jalr	-634(ra) # 328 <putc>
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	b575                	j	458 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ae:	8b4e                	mv	s6,s3
      state = 0;
 5b0:	4981                	li	s3,0
 5b2:	b55d                	j	458 <vprintf+0x60>
    }
  }
}
 5b4:	70e6                	ld	ra,120(sp)
 5b6:	7446                	ld	s0,112(sp)
 5b8:	74a6                	ld	s1,104(sp)
 5ba:	7906                	ld	s2,96(sp)
 5bc:	69e6                	ld	s3,88(sp)
 5be:	6a46                	ld	s4,80(sp)
 5c0:	6aa6                	ld	s5,72(sp)
 5c2:	6b06                	ld	s6,64(sp)
 5c4:	7be2                	ld	s7,56(sp)
 5c6:	7c42                	ld	s8,48(sp)
 5c8:	7ca2                	ld	s9,40(sp)
 5ca:	7d02                	ld	s10,32(sp)
 5cc:	6de2                	ld	s11,24(sp)
 5ce:	6109                	addi	sp,sp,128
 5d0:	8082                	ret

00000000000005d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5d2:	715d                	addi	sp,sp,-80
 5d4:	ec06                	sd	ra,24(sp)
 5d6:	e822                	sd	s0,16(sp)
 5d8:	1000                	addi	s0,sp,32
 5da:	e010                	sd	a2,0(s0)
 5dc:	e414                	sd	a3,8(s0)
 5de:	e818                	sd	a4,16(s0)
 5e0:	ec1c                	sd	a5,24(s0)
 5e2:	03043023          	sd	a6,32(s0)
 5e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 5ea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 5ee:	8622                	mv	a2,s0
 5f0:	00000097          	auipc	ra,0x0
 5f4:	e08080e7          	jalr	-504(ra) # 3f8 <vprintf>
}
 5f8:	60e2                	ld	ra,24(sp)
 5fa:	6442                	ld	s0,16(sp)
 5fc:	6161                	addi	sp,sp,80
 5fe:	8082                	ret

0000000000000600 <printf>:

void
printf(const char *fmt, ...)
{
 600:	711d                	addi	sp,sp,-96
 602:	ec06                	sd	ra,24(sp)
 604:	e822                	sd	s0,16(sp)
 606:	1000                	addi	s0,sp,32
 608:	e40c                	sd	a1,8(s0)
 60a:	e810                	sd	a2,16(s0)
 60c:	ec14                	sd	a3,24(s0)
 60e:	f018                	sd	a4,32(s0)
 610:	f41c                	sd	a5,40(s0)
 612:	03043823          	sd	a6,48(s0)
 616:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 61a:	00840613          	addi	a2,s0,8
 61e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 622:	85aa                	mv	a1,a0
 624:	4505                	li	a0,1
 626:	00000097          	auipc	ra,0x0
 62a:	dd2080e7          	jalr	-558(ra) # 3f8 <vprintf>
}
 62e:	60e2                	ld	ra,24(sp)
 630:	6442                	ld	s0,16(sp)
 632:	6125                	addi	sp,sp,96
 634:	8082                	ret

0000000000000636 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 636:	1141                	addi	sp,sp,-16
 638:	e422                	sd	s0,8(sp)
 63a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 640:	00000797          	auipc	a5,0x0
 644:	19878793          	addi	a5,a5,408 # 7d8 <__bss_start>
 648:	639c                	ld	a5,0(a5)
 64a:	a805                	j	67a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 64c:	4618                	lw	a4,8(a2)
 64e:	9db9                	addw	a1,a1,a4
 650:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 654:	6398                	ld	a4,0(a5)
 656:	6318                	ld	a4,0(a4)
 658:	fee53823          	sd	a4,-16(a0)
 65c:	a091                	j	6a0 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 65e:	ff852703          	lw	a4,-8(a0)
 662:	9e39                	addw	a2,a2,a4
 664:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 666:	ff053703          	ld	a4,-16(a0)
 66a:	e398                	sd	a4,0(a5)
 66c:	a099                	j	6b2 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	6398                	ld	a4,0(a5)
 670:	00e7e463          	bltu	a5,a4,678 <free+0x42>
 674:	00e6ea63          	bltu	a3,a4,688 <free+0x52>
{
 678:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67a:	fed7fae3          	bleu	a3,a5,66e <free+0x38>
 67e:	6398                	ld	a4,0(a5)
 680:	00e6e463          	bltu	a3,a4,688 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	fee7eae3          	bltu	a5,a4,678 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 688:	ff852583          	lw	a1,-8(a0)
 68c:	6390                	ld	a2,0(a5)
 68e:	02059713          	slli	a4,a1,0x20
 692:	9301                	srli	a4,a4,0x20
 694:	0712                	slli	a4,a4,0x4
 696:	9736                	add	a4,a4,a3
 698:	fae60ae3          	beq	a2,a4,64c <free+0x16>
    bp->s.ptr = p->s.ptr;
 69c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6a0:	4790                	lw	a2,8(a5)
 6a2:	02061713          	slli	a4,a2,0x20
 6a6:	9301                	srli	a4,a4,0x20
 6a8:	0712                	slli	a4,a4,0x4
 6aa:	973e                	add	a4,a4,a5
 6ac:	fae689e3          	beq	a3,a4,65e <free+0x28>
  } else
    p->s.ptr = bp;
 6b0:	e394                	sd	a3,0(a5)
  freep = p;
 6b2:	00000717          	auipc	a4,0x0
 6b6:	12f73323          	sd	a5,294(a4) # 7d8 <__bss_start>
}
 6ba:	6422                	ld	s0,8(sp)
 6bc:	0141                	addi	sp,sp,16
 6be:	8082                	ret

00000000000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	7139                	addi	sp,sp,-64
 6c2:	fc06                	sd	ra,56(sp)
 6c4:	f822                	sd	s0,48(sp)
 6c6:	f426                	sd	s1,40(sp)
 6c8:	f04a                	sd	s2,32(sp)
 6ca:	ec4e                	sd	s3,24(sp)
 6cc:	e852                	sd	s4,16(sp)
 6ce:	e456                	sd	s5,8(sp)
 6d0:	e05a                	sd	s6,0(sp)
 6d2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d4:	02051993          	slli	s3,a0,0x20
 6d8:	0209d993          	srli	s3,s3,0x20
 6dc:	09bd                	addi	s3,s3,15
 6de:	0049d993          	srli	s3,s3,0x4
 6e2:	2985                	addiw	s3,s3,1
 6e4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 6e8:	00000797          	auipc	a5,0x0
 6ec:	0f078793          	addi	a5,a5,240 # 7d8 <__bss_start>
 6f0:	6388                	ld	a0,0(a5)
 6f2:	c515                	beqz	a0,71e <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 6f6:	4798                	lw	a4,8(a5)
 6f8:	03277f63          	bleu	s2,a4,736 <malloc+0x76>
 6fc:	8a4e                	mv	s4,s3
 6fe:	0009871b          	sext.w	a4,s3
 702:	6685                	lui	a3,0x1
 704:	00d77363          	bleu	a3,a4,70a <malloc+0x4a>
 708:	6a05                	lui	s4,0x1
 70a:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 70e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 712:	00000497          	auipc	s1,0x0
 716:	0c648493          	addi	s1,s1,198 # 7d8 <__bss_start>
  if(p == (char*)-1)
 71a:	5b7d                	li	s6,-1
 71c:	a885                	j	78c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 71e:	00000797          	auipc	a5,0x0
 722:	0c278793          	addi	a5,a5,194 # 7e0 <base>
 726:	00000717          	auipc	a4,0x0
 72a:	0af73923          	sd	a5,178(a4) # 7d8 <__bss_start>
 72e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 730:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 734:	b7e1                	j	6fc <malloc+0x3c>
      if(p->s.size == nunits)
 736:	02e90b63          	beq	s2,a4,76c <malloc+0xac>
        p->s.size -= nunits;
 73a:	4137073b          	subw	a4,a4,s3
 73e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 740:	1702                	slli	a4,a4,0x20
 742:	9301                	srli	a4,a4,0x20
 744:	0712                	slli	a4,a4,0x4
 746:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 748:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 74c:	00000717          	auipc	a4,0x0
 750:	08a73623          	sd	a0,140(a4) # 7d8 <__bss_start>
      return (void*)(p + 1);
 754:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 758:	70e2                	ld	ra,56(sp)
 75a:	7442                	ld	s0,48(sp)
 75c:	74a2                	ld	s1,40(sp)
 75e:	7902                	ld	s2,32(sp)
 760:	69e2                	ld	s3,24(sp)
 762:	6a42                	ld	s4,16(sp)
 764:	6aa2                	ld	s5,8(sp)
 766:	6b02                	ld	s6,0(sp)
 768:	6121                	addi	sp,sp,64
 76a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 76c:	6398                	ld	a4,0(a5)
 76e:	e118                	sd	a4,0(a0)
 770:	bff1                	j	74c <malloc+0x8c>
  hp->s.size = nu;
 772:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 776:	0541                	addi	a0,a0,16
 778:	00000097          	auipc	ra,0x0
 77c:	ebe080e7          	jalr	-322(ra) # 636 <free>
  return freep;
 780:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 782:	d979                	beqz	a0,758 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 784:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 786:	4798                	lw	a4,8(a5)
 788:	fb2777e3          	bleu	s2,a4,736 <malloc+0x76>
    if(p == freep)
 78c:	6098                	ld	a4,0(s1)
 78e:	853e                	mv	a0,a5
 790:	fef71ae3          	bne	a4,a5,784 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 794:	8552                	mv	a0,s4
 796:	00000097          	auipc	ra,0x0
 79a:	b7a080e7          	jalr	-1158(ra) # 310 <sbrk>
  if(p == (char*)-1)
 79e:	fd651ae3          	bne	a0,s6,772 <malloc+0xb2>
        return 0;
 7a2:	4501                	li	a0,0
 7a4:	bf55                	j	758 <malloc+0x98>
