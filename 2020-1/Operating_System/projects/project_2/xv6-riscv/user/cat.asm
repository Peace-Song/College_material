
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	89890913          	addi	s2,s2,-1896 # 8a8 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	310080e7          	jalr	784(ra) # 330 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05863          	blez	a0,5a <cat+0x5a>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	304080e7          	jalr	772(ra) # 338 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      printf("cat: write error\n");
  40:	00000517          	auipc	a0,0x0
  44:	7f850513          	addi	a0,a0,2040 # 838 <malloc+0xe8>
  48:	00000097          	auipc	ra,0x0
  4c:	648080e7          	jalr	1608(ra) # 690 <printf>
      exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	2c6080e7          	jalr	710(ra) # 318 <exit>
    }
  }
  if(n < 0){
  5a:	00054963          	bltz	a0,6c <cat+0x6c>
    printf("cat: read error\n");
    exit(1);
  }
}
  5e:	70a2                	ld	ra,40(sp)
  60:	7402                	ld	s0,32(sp)
  62:	64e2                	ld	s1,24(sp)
  64:	6942                	ld	s2,16(sp)
  66:	69a2                	ld	s3,8(sp)
  68:	6145                	addi	sp,sp,48
  6a:	8082                	ret
    printf("cat: read error\n");
  6c:	00000517          	auipc	a0,0x0
  70:	7e450513          	addi	a0,a0,2020 # 850 <malloc+0x100>
  74:	00000097          	auipc	ra,0x0
  78:	61c080e7          	jalr	1564(ra) # 690 <printf>
    exit(1);
  7c:	4505                	li	a0,1
  7e:	00000097          	auipc	ra,0x0
  82:	29a080e7          	jalr	666(ra) # 318 <exit>

0000000000000086 <main>:

int
main(int argc, char *argv[])
{
  86:	7179                	addi	sp,sp,-48
  88:	f406                	sd	ra,40(sp)
  8a:	f022                	sd	s0,32(sp)
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	e052                	sd	s4,0(sp)
  94:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  96:	4785                	li	a5,1
  98:	04a7d663          	ble	a0,a5,e4 <main+0x5e>
  9c:	00858493          	addi	s1,a1,8
  a0:	ffe5099b          	addiw	s3,a0,-2
  a4:	1982                	slli	s3,s3,0x20
  a6:	0209d993          	srli	s3,s3,0x20
  aa:	098e                	slli	s3,s3,0x3
  ac:	05c1                	addi	a1,a1,16
  ae:	99ae                	add	s3,s3,a1
    cat(0);
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b0:	4581                	li	a1,0
  b2:	6088                	ld	a0,0(s1)
  b4:	00000097          	auipc	ra,0x0
  b8:	2a4080e7          	jalr	676(ra) # 358 <open>
  bc:	892a                	mv	s2,a0
  be:	02054d63          	bltz	a0,f8 <main+0x72>
      printf("cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c2:	00000097          	auipc	ra,0x0
  c6:	f3e080e7          	jalr	-194(ra) # 0 <cat>
    close(fd);
  ca:	854a                	mv	a0,s2
  cc:	00000097          	auipc	ra,0x0
  d0:	274080e7          	jalr	628(ra) # 340 <close>
  d4:	04a1                	addi	s1,s1,8
  for(i = 1; i < argc; i++){
  d6:	fd349de3          	bne	s1,s3,b0 <main+0x2a>
  }
  exit(0);
  da:	4501                	li	a0,0
  dc:	00000097          	auipc	ra,0x0
  e0:	23c080e7          	jalr	572(ra) # 318 <exit>
    cat(0);
  e4:	4501                	li	a0,0
  e6:	00000097          	auipc	ra,0x0
  ea:	f1a080e7          	jalr	-230(ra) # 0 <cat>
    exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	228080e7          	jalr	552(ra) # 318 <exit>
      printf("cat: cannot open %s\n", argv[i]);
  f8:	608c                	ld	a1,0(s1)
  fa:	00000517          	auipc	a0,0x0
  fe:	76e50513          	addi	a0,a0,1902 # 868 <malloc+0x118>
 102:	00000097          	auipc	ra,0x0
 106:	58e080e7          	jalr	1422(ra) # 690 <printf>
      exit(1);
 10a:	4505                	li	a0,1
 10c:	00000097          	auipc	ra,0x0
 110:	20c080e7          	jalr	524(ra) # 318 <exit>

0000000000000114 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strcmp+0x26>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71b63          	bne	a4,a5,156 <strcmp+0x26>
    p++, q++;
 144:	0505                	addi	a0,a0,1
 146:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	c789                	beqz	a5,156 <strcmp+0x26>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	fef709e3          	beq	a4,a5,144 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 156:	0005c503          	lbu	a0,0(a1)
}
 15a:	40a7853b          	subw	a0,a5,a0
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strlen>:

uint
strlen(const char *s)
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	cf91                	beqz	a5,18a <strlen+0x26>
 170:	0505                	addi	a0,a0,1
 172:	87aa                	mv	a5,a0
 174:	4685                	li	a3,1
 176:	9e89                	subw	a3,a3,a0
    ;
 178:	00f6853b          	addw	a0,a3,a5
 17c:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 17e:	fff7c703          	lbu	a4,-1(a5)
 182:	fb7d                	bnez	a4,178 <strlen+0x14>
  return n;
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret
  for(n = 0; s[n]; n++)
 18a:	4501                	li	a0,0
 18c:	bfe5                	j	184 <strlen+0x20>

000000000000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e422                	sd	s0,8(sp)
 192:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 194:	ce09                	beqz	a2,1ae <memset+0x20>
 196:	87aa                	mv	a5,a0
 198:	fff6071b          	addiw	a4,a2,-1
 19c:	1702                	slli	a4,a4,0x20
 19e:	9301                	srli	a4,a4,0x20
 1a0:	0705                	addi	a4,a4,1
 1a2:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a4:	00b78023          	sb	a1,0(a5)
 1a8:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1aa:	fee79de3          	bne	a5,a4,1a4 <memset+0x16>
  }
  return dst;
}
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strchr>:

char*
strchr(const char *s, char c)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	cf91                	beqz	a5,1da <strchr+0x26>
    if(*s == c)
 1c0:	00f58a63          	beq	a1,a5,1d4 <strchr+0x20>
  for(; *s; s++)
 1c4:	0505                	addi	a0,a0,1
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	c781                	beqz	a5,1d2 <strchr+0x1e>
    if(*s == c)
 1cc:	feb79ce3          	bne	a5,a1,1c4 <strchr+0x10>
 1d0:	a011                	j	1d4 <strchr+0x20>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x20>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	0019849b          	addiw	s1,s3,1
 204:	0344d863          	ble	s4,s1,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	120080e7          	jalr	288(ra) # 330 <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 22c:	fd679ae3          	bne	a5,s6,200 <gets+0x22>
 230:	a011                	j	234 <gets+0x56>
  for(i=0; i+1 < max; ){
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	0f6080e7          	jalr	246(ra) # 358 <open>
  if(fd < 0)
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	0fe080e7          	jalr	254(ra) # 370 <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	0c2080e7          	jalr	194(ra) # 340 <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054683          	lbu	a3,0(a0)
 2a2:	fd06879b          	addiw	a5,a3,-48
 2a6:	0ff7f793          	andi	a5,a5,255
 2aa:	4725                	li	a4,9
 2ac:	02f76963          	bltu	a4,a5,2de <atoi+0x46>
 2b0:	862a                	mv	a2,a0
  n = 0;
 2b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b6:	0605                	addi	a2,a2,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb5                	addw	a5,a5,a3
 2c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c8:	00064683          	lbu	a3,0(a2)
 2cc:	fd06871b          	addiw	a4,a3,-48
 2d0:	0ff77713          	andi	a4,a4,255
 2d4:	fee5f1e3          	bleu	a4,a1,2b6 <atoi+0x1e>
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  n = 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <atoi+0x40>

00000000000002e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2e8:	02c05163          	blez	a2,30a <memmove+0x28>
 2ec:	fff6071b          	addiw	a4,a2,-1
 2f0:	1702                	slli	a4,a4,0x20
 2f2:	9301                	srli	a4,a4,0x20
 2f4:	0705                	addi	a4,a4,1
 2f6:	972a                	add	a4,a4,a0
  dst = vdst;
 2f8:	87aa                	mv	a5,a0
    *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0785                	addi	a5,a5,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x18>
  return vdst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 310:	4885                	li	a7,1
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <exit>:
.global exit
exit:
 li a7, SYS_exit
 318:	4889                	li	a7,2
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <wait>:
.global wait
wait:
 li a7, SYS_wait
 320:	488d                	li	a7,3
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 328:	4891                	li	a7,4
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <read>:
.global read
read:
 li a7, SYS_read
 330:	4895                	li	a7,5
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <write>:
.global write
write:
 li a7, SYS_write
 338:	48c1                	li	a7,16
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <close>:
.global close
close:
 li a7, SYS_close
 340:	48d5                	li	a7,21
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <kill>:
.global kill
kill:
 li a7, SYS_kill
 348:	4899                	li	a7,6
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <exec>:
.global exec
exec:
 li a7, SYS_exec
 350:	489d                	li	a7,7
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <open>:
.global open
open:
 li a7, SYS_open
 358:	48bd                	li	a7,15
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 360:	48c5                	li	a7,17
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 368:	48c9                	li	a7,18
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 370:	48a1                	li	a7,8
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <link>:
.global link
link:
 li a7, SYS_link
 378:	48cd                	li	a7,19
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 380:	48d1                	li	a7,20
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 388:	48a5                	li	a7,9
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <dup>:
.global dup
dup:
 li a7, SYS_dup
 390:	48a9                	li	a7,10
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 398:	48ad                	li	a7,11
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a0:	48b1                	li	a7,12
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a8:	48b5                	li	a7,13
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b0:	48b9                	li	a7,14
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b8:	1101                	addi	sp,sp,-32
 3ba:	ec06                	sd	ra,24(sp)
 3bc:	e822                	sd	s0,16(sp)
 3be:	1000                	addi	s0,sp,32
 3c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3c4:	4605                	li	a2,1
 3c6:	fef40593          	addi	a1,s0,-17
 3ca:	00000097          	auipc	ra,0x0
 3ce:	f6e080e7          	jalr	-146(ra) # 338 <write>
}
 3d2:	60e2                	ld	ra,24(sp)
 3d4:	6442                	ld	s0,16(sp)
 3d6:	6105                	addi	sp,sp,32
 3d8:	8082                	ret

00000000000003da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3da:	7139                	addi	sp,sp,-64
 3dc:	fc06                	sd	ra,56(sp)
 3de:	f822                	sd	s0,48(sp)
 3e0:	f426                	sd	s1,40(sp)
 3e2:	f04a                	sd	s2,32(sp)
 3e4:	ec4e                	sd	s3,24(sp)
 3e6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3e8:	c299                	beqz	a3,3ee <printint+0x14>
 3ea:	0005cd63          	bltz	a1,404 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ee:	2581                	sext.w	a1,a1
  neg = 0;
 3f0:	4301                	li	t1,0
 3f2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 3f6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 3f8:	2601                	sext.w	a2,a2
 3fa:	00000897          	auipc	a7,0x0
 3fe:	48688893          	addi	a7,a7,1158 # 880 <digits>
 402:	a801                	j	412 <printint+0x38>
    x = -xx;
 404:	40b005bb          	negw	a1,a1
 408:	2581                	sext.w	a1,a1
    neg = 1;
 40a:	4305                	li	t1,1
    x = -xx;
 40c:	b7dd                	j	3f2 <printint+0x18>
  }while((x /= base) != 0);
 40e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 410:	8836                	mv	a6,a3
 412:	0018069b          	addiw	a3,a6,1
 416:	02c5f7bb          	remuw	a5,a1,a2
 41a:	1782                	slli	a5,a5,0x20
 41c:	9381                	srli	a5,a5,0x20
 41e:	97c6                	add	a5,a5,a7
 420:	0007c783          	lbu	a5,0(a5)
 424:	00f70023          	sb	a5,0(a4)
 428:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 42a:	02c5d7bb          	divuw	a5,a1,a2
 42e:	fec5f0e3          	bleu	a2,a1,40e <printint+0x34>
  if(neg)
 432:	00030b63          	beqz	t1,448 <printint+0x6e>
    buf[i++] = '-';
 436:	fd040793          	addi	a5,s0,-48
 43a:	96be                	add	a3,a3,a5
 43c:	02d00793          	li	a5,45
 440:	fef68823          	sb	a5,-16(a3)
 444:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 448:	02d05963          	blez	a3,47a <printint+0xa0>
 44c:	89aa                	mv	s3,a0
 44e:	fc040793          	addi	a5,s0,-64
 452:	00d784b3          	add	s1,a5,a3
 456:	fff78913          	addi	s2,a5,-1
 45a:	9936                	add	s2,s2,a3
 45c:	36fd                	addiw	a3,a3,-1
 45e:	1682                	slli	a3,a3,0x20
 460:	9281                	srli	a3,a3,0x20
 462:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 466:	fff4c583          	lbu	a1,-1(s1)
 46a:	854e                	mv	a0,s3
 46c:	00000097          	auipc	ra,0x0
 470:	f4c080e7          	jalr	-180(ra) # 3b8 <putc>
 474:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 476:	ff2498e3          	bne	s1,s2,466 <printint+0x8c>
}
 47a:	70e2                	ld	ra,56(sp)
 47c:	7442                	ld	s0,48(sp)
 47e:	74a2                	ld	s1,40(sp)
 480:	7902                	ld	s2,32(sp)
 482:	69e2                	ld	s3,24(sp)
 484:	6121                	addi	sp,sp,64
 486:	8082                	ret

0000000000000488 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 488:	7119                	addi	sp,sp,-128
 48a:	fc86                	sd	ra,120(sp)
 48c:	f8a2                	sd	s0,112(sp)
 48e:	f4a6                	sd	s1,104(sp)
 490:	f0ca                	sd	s2,96(sp)
 492:	ecce                	sd	s3,88(sp)
 494:	e8d2                	sd	s4,80(sp)
 496:	e4d6                	sd	s5,72(sp)
 498:	e0da                	sd	s6,64(sp)
 49a:	fc5e                	sd	s7,56(sp)
 49c:	f862                	sd	s8,48(sp)
 49e:	f466                	sd	s9,40(sp)
 4a0:	f06a                	sd	s10,32(sp)
 4a2:	ec6e                	sd	s11,24(sp)
 4a4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a6:	0005c483          	lbu	s1,0(a1)
 4aa:	18048d63          	beqz	s1,644 <vprintf+0x1bc>
 4ae:	8aaa                	mv	s5,a0
 4b0:	8b32                	mv	s6,a2
 4b2:	00158913          	addi	s2,a1,1
  state = 0;
 4b6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b8:	02500a13          	li	s4,37
      if(c == 'd'){
 4bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4c0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4c4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4c8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4cc:	00000b97          	auipc	s7,0x0
 4d0:	3b4b8b93          	addi	s7,s7,948 # 880 <digits>
 4d4:	a839                	j	4f2 <vprintf+0x6a>
        putc(fd, c);
 4d6:	85a6                	mv	a1,s1
 4d8:	8556                	mv	a0,s5
 4da:	00000097          	auipc	ra,0x0
 4de:	ede080e7          	jalr	-290(ra) # 3b8 <putc>
 4e2:	a019                	j	4e8 <vprintf+0x60>
    } else if(state == '%'){
 4e4:	01498f63          	beq	s3,s4,502 <vprintf+0x7a>
 4e8:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 4ea:	fff94483          	lbu	s1,-1(s2)
 4ee:	14048b63          	beqz	s1,644 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 4f2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4f6:	fe0997e3          	bnez	s3,4e4 <vprintf+0x5c>
      if(c == '%'){
 4fa:	fd479ee3          	bne	a5,s4,4d6 <vprintf+0x4e>
        state = '%';
 4fe:	89be                	mv	s3,a5
 500:	b7e5                	j	4e8 <vprintf+0x60>
      if(c == 'd'){
 502:	05878063          	beq	a5,s8,542 <vprintf+0xba>
      } else if(c == 'l') {
 506:	05978c63          	beq	a5,s9,55e <vprintf+0xd6>
      } else if(c == 'x') {
 50a:	07a78863          	beq	a5,s10,57a <vprintf+0xf2>
      } else if(c == 'p') {
 50e:	09b78463          	beq	a5,s11,596 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 512:	07300713          	li	a4,115
 516:	0ce78563          	beq	a5,a4,5e0 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51a:	06300713          	li	a4,99
 51e:	0ee78c63          	beq	a5,a4,616 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 522:	11478663          	beq	a5,s4,62e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 526:	85d2                	mv	a1,s4
 528:	8556                	mv	a0,s5
 52a:	00000097          	auipc	ra,0x0
 52e:	e8e080e7          	jalr	-370(ra) # 3b8 <putc>
        putc(fd, c);
 532:	85a6                	mv	a1,s1
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	e82080e7          	jalr	-382(ra) # 3b8 <putc>
      }
      state = 0;
 53e:	4981                	li	s3,0
 540:	b765                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 542:	008b0493          	addi	s1,s6,8
 546:	4685                	li	a3,1
 548:	4629                	li	a2,10
 54a:	000b2583          	lw	a1,0(s6)
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	e8a080e7          	jalr	-374(ra) # 3da <printint>
 558:	8b26                	mv	s6,s1
      state = 0;
 55a:	4981                	li	s3,0
 55c:	b771                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 55e:	008b0493          	addi	s1,s6,8
 562:	4681                	li	a3,0
 564:	4629                	li	a2,10
 566:	000b2583          	lw	a1,0(s6)
 56a:	8556                	mv	a0,s5
 56c:	00000097          	auipc	ra,0x0
 570:	e6e080e7          	jalr	-402(ra) # 3da <printint>
 574:	8b26                	mv	s6,s1
      state = 0;
 576:	4981                	li	s3,0
 578:	bf85                	j	4e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 57a:	008b0493          	addi	s1,s6,8
 57e:	4681                	li	a3,0
 580:	4641                	li	a2,16
 582:	000b2583          	lw	a1,0(s6)
 586:	8556                	mv	a0,s5
 588:	00000097          	auipc	ra,0x0
 58c:	e52080e7          	jalr	-430(ra) # 3da <printint>
 590:	8b26                	mv	s6,s1
      state = 0;
 592:	4981                	li	s3,0
 594:	bf91                	j	4e8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 596:	008b0793          	addi	a5,s6,8
 59a:	f8f43423          	sd	a5,-120(s0)
 59e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5a2:	03000593          	li	a1,48
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	e10080e7          	jalr	-496(ra) # 3b8 <putc>
  putc(fd, 'x');
 5b0:	85ea                	mv	a1,s10
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e04080e7          	jalr	-508(ra) # 3b8 <putc>
 5bc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5be:	03c9d793          	srli	a5,s3,0x3c
 5c2:	97de                	add	a5,a5,s7
 5c4:	0007c583          	lbu	a1,0(a5)
 5c8:	8556                	mv	a0,s5
 5ca:	00000097          	auipc	ra,0x0
 5ce:	dee080e7          	jalr	-530(ra) # 3b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5d2:	0992                	slli	s3,s3,0x4
 5d4:	34fd                	addiw	s1,s1,-1
 5d6:	f4e5                	bnez	s1,5be <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5d8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5dc:	4981                	li	s3,0
 5de:	b729                	j	4e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 5e0:	008b0993          	addi	s3,s6,8
 5e4:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 5e8:	c085                	beqz	s1,608 <vprintf+0x180>
        while(*s != 0){
 5ea:	0004c583          	lbu	a1,0(s1)
 5ee:	c9a1                	beqz	a1,63e <vprintf+0x1b6>
          putc(fd, *s);
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	dc6080e7          	jalr	-570(ra) # 3b8 <putc>
          s++;
 5fa:	0485                	addi	s1,s1,1
        while(*s != 0){
 5fc:	0004c583          	lbu	a1,0(s1)
 600:	f9e5                	bnez	a1,5f0 <vprintf+0x168>
        s = va_arg(ap, char*);
 602:	8b4e                	mv	s6,s3
      state = 0;
 604:	4981                	li	s3,0
 606:	b5cd                	j	4e8 <vprintf+0x60>
          s = "(null)";
 608:	00000497          	auipc	s1,0x0
 60c:	29048493          	addi	s1,s1,656 # 898 <digits+0x18>
        while(*s != 0){
 610:	02800593          	li	a1,40
 614:	bff1                	j	5f0 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 616:	008b0493          	addi	s1,s6,8
 61a:	000b4583          	lbu	a1,0(s6)
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	d98080e7          	jalr	-616(ra) # 3b8 <putc>
 628:	8b26                	mv	s6,s1
      state = 0;
 62a:	4981                	li	s3,0
 62c:	bd75                	j	4e8 <vprintf+0x60>
        putc(fd, c);
 62e:	85d2                	mv	a1,s4
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	d86080e7          	jalr	-634(ra) # 3b8 <putc>
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b575                	j	4e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 63e:	8b4e                	mv	s6,s3
      state = 0;
 640:	4981                	li	s3,0
 642:	b55d                	j	4e8 <vprintf+0x60>
    }
  }
}
 644:	70e6                	ld	ra,120(sp)
 646:	7446                	ld	s0,112(sp)
 648:	74a6                	ld	s1,104(sp)
 64a:	7906                	ld	s2,96(sp)
 64c:	69e6                	ld	s3,88(sp)
 64e:	6a46                	ld	s4,80(sp)
 650:	6aa6                	ld	s5,72(sp)
 652:	6b06                	ld	s6,64(sp)
 654:	7be2                	ld	s7,56(sp)
 656:	7c42                	ld	s8,48(sp)
 658:	7ca2                	ld	s9,40(sp)
 65a:	7d02                	ld	s10,32(sp)
 65c:	6de2                	ld	s11,24(sp)
 65e:	6109                	addi	sp,sp,128
 660:	8082                	ret

0000000000000662 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 662:	715d                	addi	sp,sp,-80
 664:	ec06                	sd	ra,24(sp)
 666:	e822                	sd	s0,16(sp)
 668:	1000                	addi	s0,sp,32
 66a:	e010                	sd	a2,0(s0)
 66c:	e414                	sd	a3,8(s0)
 66e:	e818                	sd	a4,16(s0)
 670:	ec1c                	sd	a5,24(s0)
 672:	03043023          	sd	a6,32(s0)
 676:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 67a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 67e:	8622                	mv	a2,s0
 680:	00000097          	auipc	ra,0x0
 684:	e08080e7          	jalr	-504(ra) # 488 <vprintf>
}
 688:	60e2                	ld	ra,24(sp)
 68a:	6442                	ld	s0,16(sp)
 68c:	6161                	addi	sp,sp,80
 68e:	8082                	ret

0000000000000690 <printf>:

void
printf(const char *fmt, ...)
{
 690:	711d                	addi	sp,sp,-96
 692:	ec06                	sd	ra,24(sp)
 694:	e822                	sd	s0,16(sp)
 696:	1000                	addi	s0,sp,32
 698:	e40c                	sd	a1,8(s0)
 69a:	e810                	sd	a2,16(s0)
 69c:	ec14                	sd	a3,24(s0)
 69e:	f018                	sd	a4,32(s0)
 6a0:	f41c                	sd	a5,40(s0)
 6a2:	03043823          	sd	a6,48(s0)
 6a6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6aa:	00840613          	addi	a2,s0,8
 6ae:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6b2:	85aa                	mv	a1,a0
 6b4:	4505                	li	a0,1
 6b6:	00000097          	auipc	ra,0x0
 6ba:	dd2080e7          	jalr	-558(ra) # 488 <vprintf>
}
 6be:	60e2                	ld	ra,24(sp)
 6c0:	6442                	ld	s0,16(sp)
 6c2:	6125                	addi	sp,sp,96
 6c4:	8082                	ret

00000000000006c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	1141                	addi	sp,sp,-16
 6c8:	e422                	sd	s0,8(sp)
 6ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d0:	00000797          	auipc	a5,0x0
 6d4:	1d078793          	addi	a5,a5,464 # 8a0 <__bss_start>
 6d8:	639c                	ld	a5,0(a5)
 6da:	a805                	j	70a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6dc:	4618                	lw	a4,8(a2)
 6de:	9db9                	addw	a1,a1,a4
 6e0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e4:	6398                	ld	a4,0(a5)
 6e6:	6318                	ld	a4,0(a4)
 6e8:	fee53823          	sd	a4,-16(a0)
 6ec:	a091                	j	730 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6ee:	ff852703          	lw	a4,-8(a0)
 6f2:	9e39                	addw	a2,a2,a4
 6f4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6f6:	ff053703          	ld	a4,-16(a0)
 6fa:	e398                	sd	a4,0(a5)
 6fc:	a099                	j	742 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fe:	6398                	ld	a4,0(a5)
 700:	00e7e463          	bltu	a5,a4,708 <free+0x42>
 704:	00e6ea63          	bltu	a3,a4,718 <free+0x52>
{
 708:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70a:	fed7fae3          	bleu	a3,a5,6fe <free+0x38>
 70e:	6398                	ld	a4,0(a5)
 710:	00e6e463          	bltu	a3,a4,718 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	fee7eae3          	bltu	a5,a4,708 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 718:	ff852583          	lw	a1,-8(a0)
 71c:	6390                	ld	a2,0(a5)
 71e:	02059713          	slli	a4,a1,0x20
 722:	9301                	srli	a4,a4,0x20
 724:	0712                	slli	a4,a4,0x4
 726:	9736                	add	a4,a4,a3
 728:	fae60ae3          	beq	a2,a4,6dc <free+0x16>
    bp->s.ptr = p->s.ptr;
 72c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 730:	4790                	lw	a2,8(a5)
 732:	02061713          	slli	a4,a2,0x20
 736:	9301                	srli	a4,a4,0x20
 738:	0712                	slli	a4,a4,0x4
 73a:	973e                	add	a4,a4,a5
 73c:	fae689e3          	beq	a3,a4,6ee <free+0x28>
  } else
    p->s.ptr = bp;
 740:	e394                	sd	a3,0(a5)
  freep = p;
 742:	00000717          	auipc	a4,0x0
 746:	14f73f23          	sd	a5,350(a4) # 8a0 <__bss_start>
}
 74a:	6422                	ld	s0,8(sp)
 74c:	0141                	addi	sp,sp,16
 74e:	8082                	ret

0000000000000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	7139                	addi	sp,sp,-64
 752:	fc06                	sd	ra,56(sp)
 754:	f822                	sd	s0,48(sp)
 756:	f426                	sd	s1,40(sp)
 758:	f04a                	sd	s2,32(sp)
 75a:	ec4e                	sd	s3,24(sp)
 75c:	e852                	sd	s4,16(sp)
 75e:	e456                	sd	s5,8(sp)
 760:	e05a                	sd	s6,0(sp)
 762:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 764:	02051993          	slli	s3,a0,0x20
 768:	0209d993          	srli	s3,s3,0x20
 76c:	09bd                	addi	s3,s3,15
 76e:	0049d993          	srli	s3,s3,0x4
 772:	2985                	addiw	s3,s3,1
 774:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 778:	00000797          	auipc	a5,0x0
 77c:	12878793          	addi	a5,a5,296 # 8a0 <__bss_start>
 780:	6388                	ld	a0,0(a5)
 782:	c515                	beqz	a0,7ae <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 784:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 786:	4798                	lw	a4,8(a5)
 788:	03277f63          	bleu	s2,a4,7c6 <malloc+0x76>
 78c:	8a4e                	mv	s4,s3
 78e:	0009871b          	sext.w	a4,s3
 792:	6685                	lui	a3,0x1
 794:	00d77363          	bleu	a3,a4,79a <malloc+0x4a>
 798:	6a05                	lui	s4,0x1
 79a:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 79e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a2:	00000497          	auipc	s1,0x0
 7a6:	0fe48493          	addi	s1,s1,254 # 8a0 <__bss_start>
  if(p == (char*)-1)
 7aa:	5b7d                	li	s6,-1
 7ac:	a885                	j	81c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7ae:	00000797          	auipc	a5,0x0
 7b2:	2fa78793          	addi	a5,a5,762 # aa8 <base>
 7b6:	00000717          	auipc	a4,0x0
 7ba:	0ef73523          	sd	a5,234(a4) # 8a0 <__bss_start>
 7be:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7c4:	b7e1                	j	78c <malloc+0x3c>
      if(p->s.size == nunits)
 7c6:	02e90b63          	beq	s2,a4,7fc <malloc+0xac>
        p->s.size -= nunits;
 7ca:	4137073b          	subw	a4,a4,s3
 7ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d0:	1702                	slli	a4,a4,0x20
 7d2:	9301                	srli	a4,a4,0x20
 7d4:	0712                	slli	a4,a4,0x4
 7d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7dc:	00000717          	auipc	a4,0x0
 7e0:	0ca73223          	sd	a0,196(a4) # 8a0 <__bss_start>
      return (void*)(p + 1);
 7e4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e8:	70e2                	ld	ra,56(sp)
 7ea:	7442                	ld	s0,48(sp)
 7ec:	74a2                	ld	s1,40(sp)
 7ee:	7902                	ld	s2,32(sp)
 7f0:	69e2                	ld	s3,24(sp)
 7f2:	6a42                	ld	s4,16(sp)
 7f4:	6aa2                	ld	s5,8(sp)
 7f6:	6b02                	ld	s6,0(sp)
 7f8:	6121                	addi	sp,sp,64
 7fa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7fc:	6398                	ld	a4,0(a5)
 7fe:	e118                	sd	a4,0(a0)
 800:	bff1                	j	7dc <malloc+0x8c>
  hp->s.size = nu;
 802:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 806:	0541                	addi	a0,a0,16
 808:	00000097          	auipc	ra,0x0
 80c:	ebe080e7          	jalr	-322(ra) # 6c6 <free>
  return freep;
 810:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 812:	d979                	beqz	a0,7e8 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 814:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 816:	4798                	lw	a4,8(a5)
 818:	fb2777e3          	bleu	s2,a4,7c6 <malloc+0x76>
    if(p == freep)
 81c:	6098                	ld	a4,0(s1)
 81e:	853e                	mv	a0,a5
 820:	fef71ae3          	bne	a4,a5,814 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 824:	8552                	mv	a0,s4
 826:	00000097          	auipc	ra,0x0
 82a:	b7a080e7          	jalr	-1158(ra) # 3a0 <sbrk>
  if(p == (char*)-1)
 82e:	fd651ae3          	bne	a0,s6,802 <malloc+0xb2>
        return 0;
 832:	4501                	li	a0,0
 834:	bf55                	j	7e8 <malloc+0x98>
