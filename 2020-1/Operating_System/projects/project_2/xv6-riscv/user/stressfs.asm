
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	84a78793          	addi	a5,a5,-1974 # 860 <malloc+0x118>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	80450513          	addi	a0,a0,-2044 # 830 <malloc+0xe8>
  34:	00000097          	auipc	ra,0x0
  38:	654080e7          	jalr	1620(ra) # 688 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	13e080e7          	jalr	318(ra) # 186 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	2b4080e7          	jalr	692(ra) # 308 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00000517          	auipc	a0,0x0
  6c:	7e050513          	addi	a0,a0,2016 # 848 <malloc+0x100>
  70:	00000097          	auipc	ra,0x0
  74:	618080e7          	jalr	1560(ra) # 688 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	2c6080e7          	jalr	710(ra) # 350 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	290080e7          	jalr	656(ra) # 330 <write>
  a8:	34fd                	addiw	s1,s1,-1
  for(i = 0; i < 20; i++)
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	28a080e7          	jalr	650(ra) # 338 <close>

  printf("read\n");
  b6:	00000517          	auipc	a0,0x0
  ba:	7a250513          	addi	a0,a0,1954 # 858 <malloc+0x110>
  be:	00000097          	auipc	ra,0x0
  c2:	5ca080e7          	jalr	1482(ra) # 688 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	284080e7          	jalr	644(ra) # 350 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	246080e7          	jalr	582(ra) # 328 <read>
  ea:	34fd                	addiw	s1,s1,-1
  for (i = 0; i < 20; i++)
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	248080e7          	jalr	584(ra) # 338 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	21e080e7          	jalr	542(ra) # 318 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	20c080e7          	jalr	524(ra) # 310 <exit>

000000000000010c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 112:	87aa                	mv	a5,a0
 114:	0585                	addi	a1,a1,1
 116:	0785                	addi	a5,a5,1
 118:	fff5c703          	lbu	a4,-1(a1)
 11c:	fee78fa3          	sb	a4,-1(a5)
 120:	fb75                	bnez	a4,114 <strcpy+0x8>
    ;
  return os;
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e422                	sd	s0,8(sp)
 12c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 12e:	00054783          	lbu	a5,0(a0)
 132:	cf91                	beqz	a5,14e <strcmp+0x26>
 134:	0005c703          	lbu	a4,0(a1)
 138:	00f71b63          	bne	a4,a5,14e <strcmp+0x26>
    p++, q++;
 13c:	0505                	addi	a0,a0,1
 13e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	c789                	beqz	a5,14e <strcmp+0x26>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	fef709e3          	beq	a4,a5,13c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 14e:	0005c503          	lbu	a0,0(a1)
}
 152:	40a7853b          	subw	a0,a5,a0
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret

000000000000015c <strlen>:

uint
strlen(const char *s)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cf91                	beqz	a5,182 <strlen+0x26>
 168:	0505                	addi	a0,a0,1
 16a:	87aa                	mv	a5,a0
 16c:	4685                	li	a3,1
 16e:	9e89                	subw	a3,a3,a0
    ;
 170:	00f6853b          	addw	a0,a3,a5
 174:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 176:	fff7c703          	lbu	a4,-1(a5)
 17a:	fb7d                	bnez	a4,170 <strlen+0x14>
  return n;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for(n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strlen+0x20>

0000000000000186 <memset>:

void*
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18c:	ce09                	beqz	a2,1a6 <memset+0x20>
 18e:	87aa                	mv	a5,a0
 190:	fff6071b          	addiw	a4,a2,-1
 194:	1702                	slli	a4,a4,0x20
 196:	9301                	srli	a4,a4,0x20
 198:	0705                	addi	a4,a4,1
 19a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 19c:	00b78023          	sb	a1,0(a5)
 1a0:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1a2:	fee79de3          	bne	a5,a4,19c <memset+0x16>
  }
  return dst;
}
 1a6:	6422                	ld	s0,8(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e422                	sd	s0,8(sp)
 1b0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	cf91                	beqz	a5,1d2 <strchr+0x26>
    if(*s == c)
 1b8:	00f58a63          	beq	a1,a5,1cc <strchr+0x20>
  for(; *s; s++)
 1bc:	0505                	addi	a0,a0,1
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	c781                	beqz	a5,1ca <strchr+0x1e>
    if(*s == c)
 1c4:	feb79ce3          	bne	a5,a1,1bc <strchr+0x10>
 1c8:	a011                	j	1cc <strchr+0x20>
      return (char*)s;
  return 0;
 1ca:	4501                	li	a0,0
}
 1cc:	6422                	ld	s0,8(sp)
 1ce:	0141                	addi	sp,sp,16
 1d0:	8082                	ret
  return 0;
 1d2:	4501                	li	a0,0
 1d4:	bfe5                	j	1cc <strchr+0x20>

00000000000001d6 <gets>:

char*
gets(char *buf, int max)
{
 1d6:	711d                	addi	sp,sp,-96
 1d8:	ec86                	sd	ra,88(sp)
 1da:	e8a2                	sd	s0,80(sp)
 1dc:	e4a6                	sd	s1,72(sp)
 1de:	e0ca                	sd	s2,64(sp)
 1e0:	fc4e                	sd	s3,56(sp)
 1e2:	f852                	sd	s4,48(sp)
 1e4:	f456                	sd	s5,40(sp)
 1e6:	f05a                	sd	s6,32(sp)
 1e8:	ec5e                	sd	s7,24(sp)
 1ea:	1080                	addi	s0,sp,96
 1ec:	8baa                	mv	s7,a0
 1ee:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f0:	892a                	mv	s2,a0
 1f2:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f4:	4aa9                	li	s5,10
 1f6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1f8:	0019849b          	addiw	s1,s3,1
 1fc:	0344d863          	ble	s4,s1,22c <gets+0x56>
    cc = read(0, &c, 1);
 200:	4605                	li	a2,1
 202:	faf40593          	addi	a1,s0,-81
 206:	4501                	li	a0,0
 208:	00000097          	auipc	ra,0x0
 20c:	120080e7          	jalr	288(ra) # 328 <read>
    if(cc < 1)
 210:	00a05e63          	blez	a0,22c <gets+0x56>
    buf[i++] = c;
 214:	faf44783          	lbu	a5,-81(s0)
 218:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21c:	01578763          	beq	a5,s5,22a <gets+0x54>
 220:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 222:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 224:	fd679ae3          	bne	a5,s6,1f8 <gets+0x22>
 228:	a011                	j	22c <gets+0x56>
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22c:	99de                	add	s3,s3,s7
 22e:	00098023          	sb	zero,0(s3)
  return buf;
}
 232:	855e                	mv	a0,s7
 234:	60e6                	ld	ra,88(sp)
 236:	6446                	ld	s0,80(sp)
 238:	64a6                	ld	s1,72(sp)
 23a:	6906                	ld	s2,64(sp)
 23c:	79e2                	ld	s3,56(sp)
 23e:	7a42                	ld	s4,48(sp)
 240:	7aa2                	ld	s5,40(sp)
 242:	7b02                	ld	s6,32(sp)
 244:	6be2                	ld	s7,24(sp)
 246:	6125                	addi	sp,sp,96
 248:	8082                	ret

000000000000024a <stat>:

int
stat(const char *n, struct stat *st)
{
 24a:	1101                	addi	sp,sp,-32
 24c:	ec06                	sd	ra,24(sp)
 24e:	e822                	sd	s0,16(sp)
 250:	e426                	sd	s1,8(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	addi	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	00000097          	auipc	ra,0x0
 25e:	0f6080e7          	jalr	246(ra) # 350 <open>
  if(fd < 0)
 262:	02054563          	bltz	a0,28c <stat+0x42>
 266:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 268:	85ca                	mv	a1,s2
 26a:	00000097          	auipc	ra,0x0
 26e:	0fe080e7          	jalr	254(ra) # 368 <fstat>
 272:	892a                	mv	s2,a0
  close(fd);
 274:	8526                	mv	a0,s1
 276:	00000097          	auipc	ra,0x0
 27a:	0c2080e7          	jalr	194(ra) # 338 <close>
  return r;
}
 27e:	854a                	mv	a0,s2
 280:	60e2                	ld	ra,24(sp)
 282:	6442                	ld	s0,16(sp)
 284:	64a2                	ld	s1,8(sp)
 286:	6902                	ld	s2,0(sp)
 288:	6105                	addi	sp,sp,32
 28a:	8082                	ret
    return -1;
 28c:	597d                	li	s2,-1
 28e:	bfc5                	j	27e <stat+0x34>

0000000000000290 <atoi>:

int
atoi(const char *s)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 296:	00054683          	lbu	a3,0(a0)
 29a:	fd06879b          	addiw	a5,a3,-48
 29e:	0ff7f793          	andi	a5,a5,255
 2a2:	4725                	li	a4,9
 2a4:	02f76963          	bltu	a4,a5,2d6 <atoi+0x46>
 2a8:	862a                	mv	a2,a0
  n = 0;
 2aa:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2ac:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2ae:	0605                	addi	a2,a2,1
 2b0:	0025179b          	slliw	a5,a0,0x2
 2b4:	9fa9                	addw	a5,a5,a0
 2b6:	0017979b          	slliw	a5,a5,0x1
 2ba:	9fb5                	addw	a5,a5,a3
 2bc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c0:	00064683          	lbu	a3,0(a2)
 2c4:	fd06871b          	addiw	a4,a3,-48
 2c8:	0ff77713          	andi	a4,a4,255
 2cc:	fee5f1e3          	bleu	a4,a1,2ae <atoi+0x1e>
  return n;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
  n = 0;
 2d6:	4501                	li	a0,0
 2d8:	bfe5                	j	2d0 <atoi+0x40>

00000000000002da <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2e0:	02c05163          	blez	a2,302 <memmove+0x28>
 2e4:	fff6071b          	addiw	a4,a2,-1
 2e8:	1702                	slli	a4,a4,0x20
 2ea:	9301                	srli	a4,a4,0x20
 2ec:	0705                	addi	a4,a4,1
 2ee:	972a                	add	a4,a4,a0
  dst = vdst;
 2f0:	87aa                	mv	a5,a0
    *dst++ = *src++;
 2f2:	0585                	addi	a1,a1,1
 2f4:	0785                	addi	a5,a5,1
 2f6:	fff5c683          	lbu	a3,-1(a1)
 2fa:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 2fe:	fee79ae3          	bne	a5,a4,2f2 <memmove+0x18>
  return vdst;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 308:	4885                	li	a7,1
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <exit>:
.global exit
exit:
 li a7, SYS_exit
 310:	4889                	li	a7,2
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <wait>:
.global wait
wait:
 li a7, SYS_wait
 318:	488d                	li	a7,3
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 320:	4891                	li	a7,4
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <read>:
.global read
read:
 li a7, SYS_read
 328:	4895                	li	a7,5
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <write>:
.global write
write:
 li a7, SYS_write
 330:	48c1                	li	a7,16
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <close>:
.global close
close:
 li a7, SYS_close
 338:	48d5                	li	a7,21
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <kill>:
.global kill
kill:
 li a7, SYS_kill
 340:	4899                	li	a7,6
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <exec>:
.global exec
exec:
 li a7, SYS_exec
 348:	489d                	li	a7,7
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <open>:
.global open
open:
 li a7, SYS_open
 350:	48bd                	li	a7,15
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 358:	48c5                	li	a7,17
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 360:	48c9                	li	a7,18
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 368:	48a1                	li	a7,8
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <link>:
.global link
link:
 li a7, SYS_link
 370:	48cd                	li	a7,19
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 378:	48d1                	li	a7,20
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 380:	48a5                	li	a7,9
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <dup>:
.global dup
dup:
 li a7, SYS_dup
 388:	48a9                	li	a7,10
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 390:	48ad                	li	a7,11
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 398:	48b1                	li	a7,12
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a0:	48b5                	li	a7,13
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a8:	48b9                	li	a7,14
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3bc:	4605                	li	a2,1
 3be:	fef40593          	addi	a1,s0,-17
 3c2:	00000097          	auipc	ra,0x0
 3c6:	f6e080e7          	jalr	-146(ra) # 330 <write>
}
 3ca:	60e2                	ld	ra,24(sp)
 3cc:	6442                	ld	s0,16(sp)
 3ce:	6105                	addi	sp,sp,32
 3d0:	8082                	ret

00000000000003d2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d2:	7139                	addi	sp,sp,-64
 3d4:	fc06                	sd	ra,56(sp)
 3d6:	f822                	sd	s0,48(sp)
 3d8:	f426                	sd	s1,40(sp)
 3da:	f04a                	sd	s2,32(sp)
 3dc:	ec4e                	sd	s3,24(sp)
 3de:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3e0:	c299                	beqz	a3,3e6 <printint+0x14>
 3e2:	0005cd63          	bltz	a1,3fc <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e6:	2581                	sext.w	a1,a1
  neg = 0;
 3e8:	4301                	li	t1,0
 3ea:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 3ee:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 3f0:	2601                	sext.w	a2,a2
 3f2:	00000897          	auipc	a7,0x0
 3f6:	47e88893          	addi	a7,a7,1150 # 870 <digits>
 3fa:	a801                	j	40a <printint+0x38>
    x = -xx;
 3fc:	40b005bb          	negw	a1,a1
 400:	2581                	sext.w	a1,a1
    neg = 1;
 402:	4305                	li	t1,1
    x = -xx;
 404:	b7dd                	j	3ea <printint+0x18>
  }while((x /= base) != 0);
 406:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 408:	8836                	mv	a6,a3
 40a:	0018069b          	addiw	a3,a6,1
 40e:	02c5f7bb          	remuw	a5,a1,a2
 412:	1782                	slli	a5,a5,0x20
 414:	9381                	srli	a5,a5,0x20
 416:	97c6                	add	a5,a5,a7
 418:	0007c783          	lbu	a5,0(a5)
 41c:	00f70023          	sb	a5,0(a4)
 420:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 422:	02c5d7bb          	divuw	a5,a1,a2
 426:	fec5f0e3          	bleu	a2,a1,406 <printint+0x34>
  if(neg)
 42a:	00030b63          	beqz	t1,440 <printint+0x6e>
    buf[i++] = '-';
 42e:	fd040793          	addi	a5,s0,-48
 432:	96be                	add	a3,a3,a5
 434:	02d00793          	li	a5,45
 438:	fef68823          	sb	a5,-16(a3)
 43c:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 440:	02d05963          	blez	a3,472 <printint+0xa0>
 444:	89aa                	mv	s3,a0
 446:	fc040793          	addi	a5,s0,-64
 44a:	00d784b3          	add	s1,a5,a3
 44e:	fff78913          	addi	s2,a5,-1
 452:	9936                	add	s2,s2,a3
 454:	36fd                	addiw	a3,a3,-1
 456:	1682                	slli	a3,a3,0x20
 458:	9281                	srli	a3,a3,0x20
 45a:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 45e:	fff4c583          	lbu	a1,-1(s1)
 462:	854e                	mv	a0,s3
 464:	00000097          	auipc	ra,0x0
 468:	f4c080e7          	jalr	-180(ra) # 3b0 <putc>
 46c:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 46e:	ff2498e3          	bne	s1,s2,45e <printint+0x8c>
}
 472:	70e2                	ld	ra,56(sp)
 474:	7442                	ld	s0,48(sp)
 476:	74a2                	ld	s1,40(sp)
 478:	7902                	ld	s2,32(sp)
 47a:	69e2                	ld	s3,24(sp)
 47c:	6121                	addi	sp,sp,64
 47e:	8082                	ret

0000000000000480 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 480:	7119                	addi	sp,sp,-128
 482:	fc86                	sd	ra,120(sp)
 484:	f8a2                	sd	s0,112(sp)
 486:	f4a6                	sd	s1,104(sp)
 488:	f0ca                	sd	s2,96(sp)
 48a:	ecce                	sd	s3,88(sp)
 48c:	e8d2                	sd	s4,80(sp)
 48e:	e4d6                	sd	s5,72(sp)
 490:	e0da                	sd	s6,64(sp)
 492:	fc5e                	sd	s7,56(sp)
 494:	f862                	sd	s8,48(sp)
 496:	f466                	sd	s9,40(sp)
 498:	f06a                	sd	s10,32(sp)
 49a:	ec6e                	sd	s11,24(sp)
 49c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 49e:	0005c483          	lbu	s1,0(a1)
 4a2:	18048d63          	beqz	s1,63c <vprintf+0x1bc>
 4a6:	8aaa                	mv	s5,a0
 4a8:	8b32                	mv	s6,a2
 4aa:	00158913          	addi	s2,a1,1
  state = 0;
 4ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b0:	02500a13          	li	s4,37
      if(c == 'd'){
 4b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4b8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4bc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4c0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4c4:	00000b97          	auipc	s7,0x0
 4c8:	3acb8b93          	addi	s7,s7,940 # 870 <digits>
 4cc:	a839                	j	4ea <vprintf+0x6a>
        putc(fd, c);
 4ce:	85a6                	mv	a1,s1
 4d0:	8556                	mv	a0,s5
 4d2:	00000097          	auipc	ra,0x0
 4d6:	ede080e7          	jalr	-290(ra) # 3b0 <putc>
 4da:	a019                	j	4e0 <vprintf+0x60>
    } else if(state == '%'){
 4dc:	01498f63          	beq	s3,s4,4fa <vprintf+0x7a>
 4e0:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 4e2:	fff94483          	lbu	s1,-1(s2)
 4e6:	14048b63          	beqz	s1,63c <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 4ea:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4ee:	fe0997e3          	bnez	s3,4dc <vprintf+0x5c>
      if(c == '%'){
 4f2:	fd479ee3          	bne	a5,s4,4ce <vprintf+0x4e>
        state = '%';
 4f6:	89be                	mv	s3,a5
 4f8:	b7e5                	j	4e0 <vprintf+0x60>
      if(c == 'd'){
 4fa:	05878063          	beq	a5,s8,53a <vprintf+0xba>
      } else if(c == 'l') {
 4fe:	05978c63          	beq	a5,s9,556 <vprintf+0xd6>
      } else if(c == 'x') {
 502:	07a78863          	beq	a5,s10,572 <vprintf+0xf2>
      } else if(c == 'p') {
 506:	09b78463          	beq	a5,s11,58e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 50a:	07300713          	li	a4,115
 50e:	0ce78563          	beq	a5,a4,5d8 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 512:	06300713          	li	a4,99
 516:	0ee78c63          	beq	a5,a4,60e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 51a:	11478663          	beq	a5,s4,626 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 51e:	85d2                	mv	a1,s4
 520:	8556                	mv	a0,s5
 522:	00000097          	auipc	ra,0x0
 526:	e8e080e7          	jalr	-370(ra) # 3b0 <putc>
        putc(fd, c);
 52a:	85a6                	mv	a1,s1
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	e82080e7          	jalr	-382(ra) # 3b0 <putc>
      }
      state = 0;
 536:	4981                	li	s3,0
 538:	b765                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 53a:	008b0493          	addi	s1,s6,8
 53e:	4685                	li	a3,1
 540:	4629                	li	a2,10
 542:	000b2583          	lw	a1,0(s6)
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	e8a080e7          	jalr	-374(ra) # 3d2 <printint>
 550:	8b26                	mv	s6,s1
      state = 0;
 552:	4981                	li	s3,0
 554:	b771                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 556:	008b0493          	addi	s1,s6,8
 55a:	4681                	li	a3,0
 55c:	4629                	li	a2,10
 55e:	000b2583          	lw	a1,0(s6)
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	e6e080e7          	jalr	-402(ra) # 3d2 <printint>
 56c:	8b26                	mv	s6,s1
      state = 0;
 56e:	4981                	li	s3,0
 570:	bf85                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 572:	008b0493          	addi	s1,s6,8
 576:	4681                	li	a3,0
 578:	4641                	li	a2,16
 57a:	000b2583          	lw	a1,0(s6)
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e52080e7          	jalr	-430(ra) # 3d2 <printint>
 588:	8b26                	mv	s6,s1
      state = 0;
 58a:	4981                	li	s3,0
 58c:	bf91                	j	4e0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 58e:	008b0793          	addi	a5,s6,8
 592:	f8f43423          	sd	a5,-120(s0)
 596:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 59a:	03000593          	li	a1,48
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	e10080e7          	jalr	-496(ra) # 3b0 <putc>
  putc(fd, 'x');
 5a8:	85ea                	mv	a1,s10
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e04080e7          	jalr	-508(ra) # 3b0 <putc>
 5b4:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5b6:	03c9d793          	srli	a5,s3,0x3c
 5ba:	97de                	add	a5,a5,s7
 5bc:	0007c583          	lbu	a1,0(a5)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	dee080e7          	jalr	-530(ra) # 3b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ca:	0992                	slli	s3,s3,0x4
 5cc:	34fd                	addiw	s1,s1,-1
 5ce:	f4e5                	bnez	s1,5b6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5d0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b729                	j	4e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 5d8:	008b0993          	addi	s3,s6,8
 5dc:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 5e0:	c085                	beqz	s1,600 <vprintf+0x180>
        while(*s != 0){
 5e2:	0004c583          	lbu	a1,0(s1)
 5e6:	c9a1                	beqz	a1,636 <vprintf+0x1b6>
          putc(fd, *s);
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	dc6080e7          	jalr	-570(ra) # 3b0 <putc>
          s++;
 5f2:	0485                	addi	s1,s1,1
        while(*s != 0){
 5f4:	0004c583          	lbu	a1,0(s1)
 5f8:	f9e5                	bnez	a1,5e8 <vprintf+0x168>
        s = va_arg(ap, char*);
 5fa:	8b4e                	mv	s6,s3
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b5cd                	j	4e0 <vprintf+0x60>
          s = "(null)";
 600:	00000497          	auipc	s1,0x0
 604:	28848493          	addi	s1,s1,648 # 888 <digits+0x18>
        while(*s != 0){
 608:	02800593          	li	a1,40
 60c:	bff1                	j	5e8 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 60e:	008b0493          	addi	s1,s6,8
 612:	000b4583          	lbu	a1,0(s6)
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	d98080e7          	jalr	-616(ra) # 3b0 <putc>
 620:	8b26                	mv	s6,s1
      state = 0;
 622:	4981                	li	s3,0
 624:	bd75                	j	4e0 <vprintf+0x60>
        putc(fd, c);
 626:	85d2                	mv	a1,s4
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	d86080e7          	jalr	-634(ra) # 3b0 <putc>
      state = 0;
 632:	4981                	li	s3,0
 634:	b575                	j	4e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 636:	8b4e                	mv	s6,s3
      state = 0;
 638:	4981                	li	s3,0
 63a:	b55d                	j	4e0 <vprintf+0x60>
    }
  }
}
 63c:	70e6                	ld	ra,120(sp)
 63e:	7446                	ld	s0,112(sp)
 640:	74a6                	ld	s1,104(sp)
 642:	7906                	ld	s2,96(sp)
 644:	69e6                	ld	s3,88(sp)
 646:	6a46                	ld	s4,80(sp)
 648:	6aa6                	ld	s5,72(sp)
 64a:	6b06                	ld	s6,64(sp)
 64c:	7be2                	ld	s7,56(sp)
 64e:	7c42                	ld	s8,48(sp)
 650:	7ca2                	ld	s9,40(sp)
 652:	7d02                	ld	s10,32(sp)
 654:	6de2                	ld	s11,24(sp)
 656:	6109                	addi	sp,sp,128
 658:	8082                	ret

000000000000065a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 65a:	715d                	addi	sp,sp,-80
 65c:	ec06                	sd	ra,24(sp)
 65e:	e822                	sd	s0,16(sp)
 660:	1000                	addi	s0,sp,32
 662:	e010                	sd	a2,0(s0)
 664:	e414                	sd	a3,8(s0)
 666:	e818                	sd	a4,16(s0)
 668:	ec1c                	sd	a5,24(s0)
 66a:	03043023          	sd	a6,32(s0)
 66e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 672:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 676:	8622                	mv	a2,s0
 678:	00000097          	auipc	ra,0x0
 67c:	e08080e7          	jalr	-504(ra) # 480 <vprintf>
}
 680:	60e2                	ld	ra,24(sp)
 682:	6442                	ld	s0,16(sp)
 684:	6161                	addi	sp,sp,80
 686:	8082                	ret

0000000000000688 <printf>:

void
printf(const char *fmt, ...)
{
 688:	711d                	addi	sp,sp,-96
 68a:	ec06                	sd	ra,24(sp)
 68c:	e822                	sd	s0,16(sp)
 68e:	1000                	addi	s0,sp,32
 690:	e40c                	sd	a1,8(s0)
 692:	e810                	sd	a2,16(s0)
 694:	ec14                	sd	a3,24(s0)
 696:	f018                	sd	a4,32(s0)
 698:	f41c                	sd	a5,40(s0)
 69a:	03043823          	sd	a6,48(s0)
 69e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6a2:	00840613          	addi	a2,s0,8
 6a6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6aa:	85aa                	mv	a1,a0
 6ac:	4505                	li	a0,1
 6ae:	00000097          	auipc	ra,0x0
 6b2:	dd2080e7          	jalr	-558(ra) # 480 <vprintf>
}
 6b6:	60e2                	ld	ra,24(sp)
 6b8:	6442                	ld	s0,16(sp)
 6ba:	6125                	addi	sp,sp,96
 6bc:	8082                	ret

00000000000006be <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6be:	1141                	addi	sp,sp,-16
 6c0:	e422                	sd	s0,8(sp)
 6c2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c8:	00000797          	auipc	a5,0x0
 6cc:	1c878793          	addi	a5,a5,456 # 890 <__bss_start>
 6d0:	639c                	ld	a5,0(a5)
 6d2:	a805                	j	702 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6d4:	4618                	lw	a4,8(a2)
 6d6:	9db9                	addw	a1,a1,a4
 6d8:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6dc:	6398                	ld	a4,0(a5)
 6de:	6318                	ld	a4,0(a4)
 6e0:	fee53823          	sd	a4,-16(a0)
 6e4:	a091                	j	728 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e6:	ff852703          	lw	a4,-8(a0)
 6ea:	9e39                	addw	a2,a2,a4
 6ec:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6ee:	ff053703          	ld	a4,-16(a0)
 6f2:	e398                	sd	a4,0(a5)
 6f4:	a099                	j	73a <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f6:	6398                	ld	a4,0(a5)
 6f8:	00e7e463          	bltu	a5,a4,700 <free+0x42>
 6fc:	00e6ea63          	bltu	a3,a4,710 <free+0x52>
{
 700:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 702:	fed7fae3          	bleu	a3,a5,6f6 <free+0x38>
 706:	6398                	ld	a4,0(a5)
 708:	00e6e463          	bltu	a3,a4,710 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	fee7eae3          	bltu	a5,a4,700 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 710:	ff852583          	lw	a1,-8(a0)
 714:	6390                	ld	a2,0(a5)
 716:	02059713          	slli	a4,a1,0x20
 71a:	9301                	srli	a4,a4,0x20
 71c:	0712                	slli	a4,a4,0x4
 71e:	9736                	add	a4,a4,a3
 720:	fae60ae3          	beq	a2,a4,6d4 <free+0x16>
    bp->s.ptr = p->s.ptr;
 724:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 728:	4790                	lw	a2,8(a5)
 72a:	02061713          	slli	a4,a2,0x20
 72e:	9301                	srli	a4,a4,0x20
 730:	0712                	slli	a4,a4,0x4
 732:	973e                	add	a4,a4,a5
 734:	fae689e3          	beq	a3,a4,6e6 <free+0x28>
  } else
    p->s.ptr = bp;
 738:	e394                	sd	a3,0(a5)
  freep = p;
 73a:	00000717          	auipc	a4,0x0
 73e:	14f73b23          	sd	a5,342(a4) # 890 <__bss_start>
}
 742:	6422                	ld	s0,8(sp)
 744:	0141                	addi	sp,sp,16
 746:	8082                	ret

0000000000000748 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 748:	7139                	addi	sp,sp,-64
 74a:	fc06                	sd	ra,56(sp)
 74c:	f822                	sd	s0,48(sp)
 74e:	f426                	sd	s1,40(sp)
 750:	f04a                	sd	s2,32(sp)
 752:	ec4e                	sd	s3,24(sp)
 754:	e852                	sd	s4,16(sp)
 756:	e456                	sd	s5,8(sp)
 758:	e05a                	sd	s6,0(sp)
 75a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75c:	02051993          	slli	s3,a0,0x20
 760:	0209d993          	srli	s3,s3,0x20
 764:	09bd                	addi	s3,s3,15
 766:	0049d993          	srli	s3,s3,0x4
 76a:	2985                	addiw	s3,s3,1
 76c:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 770:	00000797          	auipc	a5,0x0
 774:	12078793          	addi	a5,a5,288 # 890 <__bss_start>
 778:	6388                	ld	a0,0(a5)
 77a:	c515                	beqz	a0,7a6 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 77e:	4798                	lw	a4,8(a5)
 780:	03277f63          	bleu	s2,a4,7be <malloc+0x76>
 784:	8a4e                	mv	s4,s3
 786:	0009871b          	sext.w	a4,s3
 78a:	6685                	lui	a3,0x1
 78c:	00d77363          	bleu	a3,a4,792 <malloc+0x4a>
 790:	6a05                	lui	s4,0x1
 792:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 796:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 79a:	00000497          	auipc	s1,0x0
 79e:	0f648493          	addi	s1,s1,246 # 890 <__bss_start>
  if(p == (char*)-1)
 7a2:	5b7d                	li	s6,-1
 7a4:	a885                	j	814 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7a6:	00000797          	auipc	a5,0x0
 7aa:	0f278793          	addi	a5,a5,242 # 898 <base>
 7ae:	00000717          	auipc	a4,0x0
 7b2:	0ef73123          	sd	a5,226(a4) # 890 <__bss_start>
 7b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7bc:	b7e1                	j	784 <malloc+0x3c>
      if(p->s.size == nunits)
 7be:	02e90b63          	beq	s2,a4,7f4 <malloc+0xac>
        p->s.size -= nunits;
 7c2:	4137073b          	subw	a4,a4,s3
 7c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7c8:	1702                	slli	a4,a4,0x20
 7ca:	9301                	srli	a4,a4,0x20
 7cc:	0712                	slli	a4,a4,0x4
 7ce:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7d0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7d4:	00000717          	auipc	a4,0x0
 7d8:	0aa73e23          	sd	a0,188(a4) # 890 <__bss_start>
      return (void*)(p + 1);
 7dc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e0:	70e2                	ld	ra,56(sp)
 7e2:	7442                	ld	s0,48(sp)
 7e4:	74a2                	ld	s1,40(sp)
 7e6:	7902                	ld	s2,32(sp)
 7e8:	69e2                	ld	s3,24(sp)
 7ea:	6a42                	ld	s4,16(sp)
 7ec:	6aa2                	ld	s5,8(sp)
 7ee:	6b02                	ld	s6,0(sp)
 7f0:	6121                	addi	sp,sp,64
 7f2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7f4:	6398                	ld	a4,0(a5)
 7f6:	e118                	sd	a4,0(a0)
 7f8:	bff1                	j	7d4 <malloc+0x8c>
  hp->s.size = nu;
 7fa:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 7fe:	0541                	addi	a0,a0,16
 800:	00000097          	auipc	ra,0x0
 804:	ebe080e7          	jalr	-322(ra) # 6be <free>
  return freep;
 808:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 80a:	d979                	beqz	a0,7e0 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80e:	4798                	lw	a4,8(a5)
 810:	fb2777e3          	bleu	s2,a4,7be <malloc+0x76>
    if(p == freep)
 814:	6098                	ld	a4,0(s1)
 816:	853e                	mv	a0,a5
 818:	fef71ae3          	bne	a4,a5,80c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 81c:	8552                	mv	a0,s4
 81e:	00000097          	auipc	ra,0x0
 822:	b7a080e7          	jalr	-1158(ra) # 398 <sbrk>
  if(p == (char*)-1)
 826:	fd651ae3          	bne	a0,s6,7fa <malloc+0xb2>
        return 0;
 82a:	4501                	li	a0,0
 82c:	bf55                	j	7e0 <malloc+0x98>
