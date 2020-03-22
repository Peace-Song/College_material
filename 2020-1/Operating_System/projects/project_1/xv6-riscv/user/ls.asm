
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	31c080e7          	jalr	796(ra) # 32c <strlen>
  18:	1502                	slli	a0,a0,0x20
  1a:	9101                	srli	a0,a0,0x20
  1c:	9526                	add	a0,a0,s1
  1e:	02956163          	bltu	a0,s1,40 <fmtname+0x40>
  22:	00054703          	lbu	a4,0(a0)
  26:	02f00793          	li	a5,47
  2a:	00f70b63          	beq	a4,a5,40 <fmtname+0x40>
  2e:	02f00713          	li	a4,47
  32:	157d                	addi	a0,a0,-1
  34:	00956663          	bltu	a0,s1,40 <fmtname+0x40>
  38:	00054783          	lbu	a5,0(a0)
  3c:	fee79be3          	bne	a5,a4,32 <fmtname+0x32>
    ;
  p++;
  40:	00150493          	addi	s1,a0,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  44:	8526                	mv	a0,s1
  46:	00000097          	auipc	ra,0x0
  4a:	2e6080e7          	jalr	742(ra) # 32c <strlen>
  4e:	2501                	sext.w	a0,a0
  50:	47b5                	li	a5,13
  52:	00a7fa63          	bleu	a0,a5,66 <fmtname+0x66>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  56:	8526                	mv	a0,s1
  58:	70a2                	ld	ra,40(sp)
  5a:	7402                	ld	s0,32(sp)
  5c:	64e2                	ld	s1,24(sp)
  5e:	6942                	ld	s2,16(sp)
  60:	69a2                	ld	s3,8(sp)
  62:	6145                	addi	sp,sp,48
  64:	8082                	ret
  memmove(buf, p, strlen(p));
  66:	8526                	mv	a0,s1
  68:	00000097          	auipc	ra,0x0
  6c:	2c4080e7          	jalr	708(ra) # 32c <strlen>
  70:	00001917          	auipc	s2,0x1
  74:	a2890913          	addi	s2,s2,-1496 # a98 <buf.1119>
  78:	0005061b          	sext.w	a2,a0
  7c:	85a6                	mv	a1,s1
  7e:	854a                	mv	a0,s2
  80:	00000097          	auipc	ra,0x0
  84:	42a080e7          	jalr	1066(ra) # 4aa <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	2a2080e7          	jalr	674(ra) # 32c <strlen>
  92:	0005099b          	sext.w	s3,a0
  96:	8526                	mv	a0,s1
  98:	00000097          	auipc	ra,0x0
  9c:	294080e7          	jalr	660(ra) # 32c <strlen>
  a0:	1982                	slli	s3,s3,0x20
  a2:	0209d993          	srli	s3,s3,0x20
  a6:	4639                	li	a2,14
  a8:	9e09                	subw	a2,a2,a0
  aa:	02000593          	li	a1,32
  ae:	01390533          	add	a0,s2,s3
  b2:	00000097          	auipc	ra,0x0
  b6:	2a4080e7          	jalr	676(ra) # 356 <memset>
  return buf;
  ba:	84ca                	mv	s1,s2
  bc:	bf69                	j	56 <fmtname+0x56>

00000000000000be <ls>:

void
ls(char *path)
{
  be:	d9010113          	addi	sp,sp,-624
  c2:	26113423          	sd	ra,616(sp)
  c6:	26813023          	sd	s0,608(sp)
  ca:	24913c23          	sd	s1,600(sp)
  ce:	25213823          	sd	s2,592(sp)
  d2:	25313423          	sd	s3,584(sp)
  d6:	25413023          	sd	s4,576(sp)
  da:	23513c23          	sd	s5,568(sp)
  de:	1c80                	addi	s0,sp,624
  e0:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  e2:	4581                	li	a1,0
  e4:	00000097          	auipc	ra,0x0
  e8:	43c080e7          	jalr	1084(ra) # 520 <open>
  ec:	06054f63          	bltz	a0,16a <ls+0xac>
  f0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  f2:	d9840593          	addi	a1,s0,-616
  f6:	00000097          	auipc	ra,0x0
  fa:	442080e7          	jalr	1090(ra) # 538 <fstat>
  fe:	08054163          	bltz	a0,180 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 102:	da041783          	lh	a5,-608(s0)
 106:	0007869b          	sext.w	a3,a5
 10a:	4705                	li	a4,1
 10c:	08e68a63          	beq	a3,a4,1a0 <ls+0xe2>
 110:	4709                	li	a4,2
 112:	02e69663          	bne	a3,a4,13e <ls+0x80>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 116:	854a                	mv	a0,s2
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <fmtname>
 120:	da843703          	ld	a4,-600(s0)
 124:	d9c42683          	lw	a3,-612(s0)
 128:	da041603          	lh	a2,-608(s0)
 12c:	85aa                	mv	a1,a0
 12e:	00001517          	auipc	a0,0x1
 132:	90250513          	addi	a0,a0,-1790 # a30 <malloc+0x118>
 136:	00000097          	auipc	ra,0x0
 13a:	722080e7          	jalr	1826(ra) # 858 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 13e:	8526                	mv	a0,s1
 140:	00000097          	auipc	ra,0x0
 144:	3c8080e7          	jalr	968(ra) # 508 <close>
}
 148:	26813083          	ld	ra,616(sp)
 14c:	26013403          	ld	s0,608(sp)
 150:	25813483          	ld	s1,600(sp)
 154:	25013903          	ld	s2,592(sp)
 158:	24813983          	ld	s3,584(sp)
 15c:	24013a03          	ld	s4,576(sp)
 160:	23813a83          	ld	s5,568(sp)
 164:	27010113          	addi	sp,sp,624
 168:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 16a:	864a                	mv	a2,s2
 16c:	00001597          	auipc	a1,0x1
 170:	89458593          	addi	a1,a1,-1900 # a00 <malloc+0xe8>
 174:	4509                	li	a0,2
 176:	00000097          	auipc	ra,0x0
 17a:	6b4080e7          	jalr	1716(ra) # 82a <fprintf>
    return;
 17e:	b7e9                	j	148 <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 180:	864a                	mv	a2,s2
 182:	00001597          	auipc	a1,0x1
 186:	89658593          	addi	a1,a1,-1898 # a18 <malloc+0x100>
 18a:	4509                	li	a0,2
 18c:	00000097          	auipc	ra,0x0
 190:	69e080e7          	jalr	1694(ra) # 82a <fprintf>
    close(fd);
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	372080e7          	jalr	882(ra) # 508 <close>
    return;
 19e:	b76d                	j	148 <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	854a                	mv	a0,s2
 1a2:	00000097          	auipc	ra,0x0
 1a6:	18a080e7          	jalr	394(ra) # 32c <strlen>
 1aa:	2541                	addiw	a0,a0,16
 1ac:	20000793          	li	a5,512
 1b0:	00a7fb63          	bleu	a0,a5,1c6 <ls+0x108>
      printf("ls: path too long\n");
 1b4:	00001517          	auipc	a0,0x1
 1b8:	88c50513          	addi	a0,a0,-1908 # a40 <malloc+0x128>
 1bc:	00000097          	auipc	ra,0x0
 1c0:	69c080e7          	jalr	1692(ra) # 858 <printf>
      break;
 1c4:	bfad                	j	13e <ls+0x80>
    strcpy(buf, path);
 1c6:	85ca                	mv	a1,s2
 1c8:	dc040513          	addi	a0,s0,-576
 1cc:	00000097          	auipc	ra,0x0
 1d0:	110080e7          	jalr	272(ra) # 2dc <strcpy>
    p = buf+strlen(buf);
 1d4:	dc040513          	addi	a0,s0,-576
 1d8:	00000097          	auipc	ra,0x0
 1dc:	154080e7          	jalr	340(ra) # 32c <strlen>
 1e0:	1502                	slli	a0,a0,0x20
 1e2:	9101                	srli	a0,a0,0x20
 1e4:	dc040793          	addi	a5,s0,-576
 1e8:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1ec:	00190993          	addi	s3,s2,1
 1f0:	02f00793          	li	a5,47
 1f4:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1f8:	00001a17          	auipc	s4,0x1
 1fc:	860a0a13          	addi	s4,s4,-1952 # a58 <malloc+0x140>
        printf("ls: cannot stat %s\n", buf);
 200:	00001a97          	auipc	s5,0x1
 204:	818a8a93          	addi	s5,s5,-2024 # a18 <malloc+0x100>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 208:	a01d                	j	22e <ls+0x170>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 20a:	dc040513          	addi	a0,s0,-576
 20e:	00000097          	auipc	ra,0x0
 212:	df2080e7          	jalr	-526(ra) # 0 <fmtname>
 216:	da843703          	ld	a4,-600(s0)
 21a:	d9c42683          	lw	a3,-612(s0)
 21e:	da041603          	lh	a2,-608(s0)
 222:	85aa                	mv	a1,a0
 224:	8552                	mv	a0,s4
 226:	00000097          	auipc	ra,0x0
 22a:	632080e7          	jalr	1586(ra) # 858 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 22e:	4641                	li	a2,16
 230:	db040593          	addi	a1,s0,-592
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	2c2080e7          	jalr	706(ra) # 4f8 <read>
 23e:	47c1                	li	a5,16
 240:	eef51fe3          	bne	a0,a5,13e <ls+0x80>
      if(de.inum == 0)
 244:	db045783          	lhu	a5,-592(s0)
 248:	d3fd                	beqz	a5,22e <ls+0x170>
      memmove(p, de.name, DIRSIZ);
 24a:	4639                	li	a2,14
 24c:	db240593          	addi	a1,s0,-590
 250:	854e                	mv	a0,s3
 252:	00000097          	auipc	ra,0x0
 256:	258080e7          	jalr	600(ra) # 4aa <memmove>
      p[DIRSIZ] = 0;
 25a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 25e:	d9840593          	addi	a1,s0,-616
 262:	dc040513          	addi	a0,s0,-576
 266:	00000097          	auipc	ra,0x0
 26a:	1b4080e7          	jalr	436(ra) # 41a <stat>
 26e:	f8055ee3          	bgez	a0,20a <ls+0x14c>
        printf("ls: cannot stat %s\n", buf);
 272:	dc040593          	addi	a1,s0,-576
 276:	8556                	mv	a0,s5
 278:	00000097          	auipc	ra,0x0
 27c:	5e0080e7          	jalr	1504(ra) # 858 <printf>
        continue;
 280:	b77d                	j	22e <ls+0x170>

0000000000000282 <main>:

int
main(int argc, char *argv[])
{
 282:	1101                	addi	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 28e:	4785                	li	a5,1
 290:	02a7d963          	ble	a0,a5,2c2 <main+0x40>
 294:	00858493          	addi	s1,a1,8
 298:	ffe5091b          	addiw	s2,a0,-2
 29c:	1902                	slli	s2,s2,0x20
 29e:	02095913          	srli	s2,s2,0x20
 2a2:	090e                	slli	s2,s2,0x3
 2a4:	05c1                	addi	a1,a1,16
 2a6:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a8:	6088                	ld	a0,0(s1)
 2aa:	00000097          	auipc	ra,0x0
 2ae:	e14080e7          	jalr	-492(ra) # be <ls>
 2b2:	04a1                	addi	s1,s1,8
  for(i=1; i<argc; i++)
 2b4:	ff249ae3          	bne	s1,s2,2a8 <main+0x26>
  exit(0);
 2b8:	4501                	li	a0,0
 2ba:	00000097          	auipc	ra,0x0
 2be:	226080e7          	jalr	550(ra) # 4e0 <exit>
    ls(".");
 2c2:	00000517          	auipc	a0,0x0
 2c6:	7a650513          	addi	a0,a0,1958 # a68 <malloc+0x150>
 2ca:	00000097          	auipc	ra,0x0
 2ce:	df4080e7          	jalr	-524(ra) # be <ls>
    exit(0);
 2d2:	4501                	li	a0,0
 2d4:	00000097          	auipc	ra,0x0
 2d8:	20c080e7          	jalr	524(ra) # 4e0 <exit>

00000000000002dc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e2:	87aa                	mv	a5,a0
 2e4:	0585                	addi	a1,a1,1
 2e6:	0785                	addi	a5,a5,1
 2e8:	fff5c703          	lbu	a4,-1(a1)
 2ec:	fee78fa3          	sb	a4,-1(a5)
 2f0:	fb75                	bnez	a4,2e4 <strcpy+0x8>
    ;
  return os;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	cf91                	beqz	a5,31e <strcmp+0x26>
 304:	0005c703          	lbu	a4,0(a1)
 308:	00f71b63          	bne	a4,a5,31e <strcmp+0x26>
    p++, q++;
 30c:	0505                	addi	a0,a0,1
 30e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 310:	00054783          	lbu	a5,0(a0)
 314:	c789                	beqz	a5,31e <strcmp+0x26>
 316:	0005c703          	lbu	a4,0(a1)
 31a:	fef709e3          	beq	a4,a5,30c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 31e:	0005c503          	lbu	a0,0(a1)
}
 322:	40a7853b          	subw	a0,a5,a0
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <strlen>:

uint
strlen(const char *s)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 332:	00054783          	lbu	a5,0(a0)
 336:	cf91                	beqz	a5,352 <strlen+0x26>
 338:	0505                	addi	a0,a0,1
 33a:	87aa                	mv	a5,a0
 33c:	4685                	li	a3,1
 33e:	9e89                	subw	a3,a3,a0
    ;
 340:	00f6853b          	addw	a0,a3,a5
 344:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 346:	fff7c703          	lbu	a4,-1(a5)
 34a:	fb7d                	bnez	a4,340 <strlen+0x14>
  return n;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
  for(n = 0; s[n]; n++)
 352:	4501                	li	a0,0
 354:	bfe5                	j	34c <strlen+0x20>

0000000000000356 <memset>:

void*
memset(void *dst, int c, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 35c:	ce09                	beqz	a2,376 <memset+0x20>
 35e:	87aa                	mv	a5,a0
 360:	fff6071b          	addiw	a4,a2,-1
 364:	1702                	slli	a4,a4,0x20
 366:	9301                	srli	a4,a4,0x20
 368:	0705                	addi	a4,a4,1
 36a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 36c:	00b78023          	sb	a1,0(a5)
 370:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 372:	fee79de3          	bne	a5,a4,36c <memset+0x16>
  }
  return dst;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <strchr>:

char*
strchr(const char *s, char c)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  for(; *s; s++)
 382:	00054783          	lbu	a5,0(a0)
 386:	cf91                	beqz	a5,3a2 <strchr+0x26>
    if(*s == c)
 388:	00f58a63          	beq	a1,a5,39c <strchr+0x20>
  for(; *s; s++)
 38c:	0505                	addi	a0,a0,1
 38e:	00054783          	lbu	a5,0(a0)
 392:	c781                	beqz	a5,39a <strchr+0x1e>
    if(*s == c)
 394:	feb79ce3          	bne	a5,a1,38c <strchr+0x10>
 398:	a011                	j	39c <strchr+0x20>
      return (char*)s;
  return 0;
 39a:	4501                	li	a0,0
}
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
  return 0;
 3a2:	4501                	li	a0,0
 3a4:	bfe5                	j	39c <strchr+0x20>

00000000000003a6 <gets>:

char*
gets(char *buf, int max)
{
 3a6:	711d                	addi	sp,sp,-96
 3a8:	ec86                	sd	ra,88(sp)
 3aa:	e8a2                	sd	s0,80(sp)
 3ac:	e4a6                	sd	s1,72(sp)
 3ae:	e0ca                	sd	s2,64(sp)
 3b0:	fc4e                	sd	s3,56(sp)
 3b2:	f852                	sd	s4,48(sp)
 3b4:	f456                	sd	s5,40(sp)
 3b6:	f05a                	sd	s6,32(sp)
 3b8:	ec5e                	sd	s7,24(sp)
 3ba:	1080                	addi	s0,sp,96
 3bc:	8baa                	mv	s7,a0
 3be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c0:	892a                	mv	s2,a0
 3c2:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c4:	4aa9                	li	s5,10
 3c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3c8:	0019849b          	addiw	s1,s3,1
 3cc:	0344d863          	ble	s4,s1,3fc <gets+0x56>
    cc = read(0, &c, 1);
 3d0:	4605                	li	a2,1
 3d2:	faf40593          	addi	a1,s0,-81
 3d6:	4501                	li	a0,0
 3d8:	00000097          	auipc	ra,0x0
 3dc:	120080e7          	jalr	288(ra) # 4f8 <read>
    if(cc < 1)
 3e0:	00a05e63          	blez	a0,3fc <gets+0x56>
    buf[i++] = c;
 3e4:	faf44783          	lbu	a5,-81(s0)
 3e8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ec:	01578763          	beq	a5,s5,3fa <gets+0x54>
 3f0:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3f2:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3f4:	fd679ae3          	bne	a5,s6,3c8 <gets+0x22>
 3f8:	a011                	j	3fc <gets+0x56>
  for(i=0; i+1 < max; ){
 3fa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3fc:	99de                	add	s3,s3,s7
 3fe:	00098023          	sb	zero,0(s3)
  return buf;
}
 402:	855e                	mv	a0,s7
 404:	60e6                	ld	ra,88(sp)
 406:	6446                	ld	s0,80(sp)
 408:	64a6                	ld	s1,72(sp)
 40a:	6906                	ld	s2,64(sp)
 40c:	79e2                	ld	s3,56(sp)
 40e:	7a42                	ld	s4,48(sp)
 410:	7aa2                	ld	s5,40(sp)
 412:	7b02                	ld	s6,32(sp)
 414:	6be2                	ld	s7,24(sp)
 416:	6125                	addi	sp,sp,96
 418:	8082                	ret

000000000000041a <stat>:

int
stat(const char *n, struct stat *st)
{
 41a:	1101                	addi	sp,sp,-32
 41c:	ec06                	sd	ra,24(sp)
 41e:	e822                	sd	s0,16(sp)
 420:	e426                	sd	s1,8(sp)
 422:	e04a                	sd	s2,0(sp)
 424:	1000                	addi	s0,sp,32
 426:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 428:	4581                	li	a1,0
 42a:	00000097          	auipc	ra,0x0
 42e:	0f6080e7          	jalr	246(ra) # 520 <open>
  if(fd < 0)
 432:	02054563          	bltz	a0,45c <stat+0x42>
 436:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 438:	85ca                	mv	a1,s2
 43a:	00000097          	auipc	ra,0x0
 43e:	0fe080e7          	jalr	254(ra) # 538 <fstat>
 442:	892a                	mv	s2,a0
  close(fd);
 444:	8526                	mv	a0,s1
 446:	00000097          	auipc	ra,0x0
 44a:	0c2080e7          	jalr	194(ra) # 508 <close>
  return r;
}
 44e:	854a                	mv	a0,s2
 450:	60e2                	ld	ra,24(sp)
 452:	6442                	ld	s0,16(sp)
 454:	64a2                	ld	s1,8(sp)
 456:	6902                	ld	s2,0(sp)
 458:	6105                	addi	sp,sp,32
 45a:	8082                	ret
    return -1;
 45c:	597d                	li	s2,-1
 45e:	bfc5                	j	44e <stat+0x34>

0000000000000460 <atoi>:

int
atoi(const char *s)
{
 460:	1141                	addi	sp,sp,-16
 462:	e422                	sd	s0,8(sp)
 464:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 466:	00054683          	lbu	a3,0(a0)
 46a:	fd06879b          	addiw	a5,a3,-48
 46e:	0ff7f793          	andi	a5,a5,255
 472:	4725                	li	a4,9
 474:	02f76963          	bltu	a4,a5,4a6 <atoi+0x46>
 478:	862a                	mv	a2,a0
  n = 0;
 47a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 47c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 47e:	0605                	addi	a2,a2,1
 480:	0025179b          	slliw	a5,a0,0x2
 484:	9fa9                	addw	a5,a5,a0
 486:	0017979b          	slliw	a5,a5,0x1
 48a:	9fb5                	addw	a5,a5,a3
 48c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 490:	00064683          	lbu	a3,0(a2)
 494:	fd06871b          	addiw	a4,a3,-48
 498:	0ff77713          	andi	a4,a4,255
 49c:	fee5f1e3          	bleu	a4,a1,47e <atoi+0x1e>
  return n;
}
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret
  n = 0;
 4a6:	4501                	li	a0,0
 4a8:	bfe5                	j	4a0 <atoi+0x40>

00000000000004aa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4b0:	02c05163          	blez	a2,4d2 <memmove+0x28>
 4b4:	fff6071b          	addiw	a4,a2,-1
 4b8:	1702                	slli	a4,a4,0x20
 4ba:	9301                	srli	a4,a4,0x20
 4bc:	0705                	addi	a4,a4,1
 4be:	972a                	add	a4,a4,a0
  dst = vdst;
 4c0:	87aa                	mv	a5,a0
    *dst++ = *src++;
 4c2:	0585                	addi	a1,a1,1
 4c4:	0785                	addi	a5,a5,1
 4c6:	fff5c683          	lbu	a3,-1(a1)
 4ca:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 4ce:	fee79ae3          	bne	a5,a4,4c2 <memmove+0x18>
  return vdst;
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4d8:	4885                	li	a7,1
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e0:	4889                	li	a7,2
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4e8:	488d                	li	a7,3
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f0:	4891                	li	a7,4
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <read>:
.global read
read:
 li a7, SYS_read
 4f8:	4895                	li	a7,5
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <write>:
.global write
write:
 li a7, SYS_write
 500:	48c1                	li	a7,16
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <close>:
.global close
close:
 li a7, SYS_close
 508:	48d5                	li	a7,21
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <kill>:
.global kill
kill:
 li a7, SYS_kill
 510:	4899                	li	a7,6
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <exec>:
.global exec
exec:
 li a7, SYS_exec
 518:	489d                	li	a7,7
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <open>:
.global open
open:
 li a7, SYS_open
 520:	48bd                	li	a7,15
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 528:	48c5                	li	a7,17
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 530:	48c9                	li	a7,18
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 538:	48a1                	li	a7,8
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <link>:
.global link
link:
 li a7, SYS_link
 540:	48cd                	li	a7,19
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 548:	48d1                	li	a7,20
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 550:	48a5                	li	a7,9
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <dup>:
.global dup
dup:
 li a7, SYS_dup
 558:	48a9                	li	a7,10
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 560:	48ad                	li	a7,11
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 568:	48b1                	li	a7,12
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 570:	48b5                	li	a7,13
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 578:	48b9                	li	a7,14
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 580:	1101                	addi	sp,sp,-32
 582:	ec06                	sd	ra,24(sp)
 584:	e822                	sd	s0,16(sp)
 586:	1000                	addi	s0,sp,32
 588:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 58c:	4605                	li	a2,1
 58e:	fef40593          	addi	a1,s0,-17
 592:	00000097          	auipc	ra,0x0
 596:	f6e080e7          	jalr	-146(ra) # 500 <write>
}
 59a:	60e2                	ld	ra,24(sp)
 59c:	6442                	ld	s0,16(sp)
 59e:	6105                	addi	sp,sp,32
 5a0:	8082                	ret

00000000000005a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a2:	7139                	addi	sp,sp,-64
 5a4:	fc06                	sd	ra,56(sp)
 5a6:	f822                	sd	s0,48(sp)
 5a8:	f426                	sd	s1,40(sp)
 5aa:	f04a                	sd	s2,32(sp)
 5ac:	ec4e                	sd	s3,24(sp)
 5ae:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b0:	c299                	beqz	a3,5b6 <printint+0x14>
 5b2:	0005cd63          	bltz	a1,5cc <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b6:	2581                	sext.w	a1,a1
  neg = 0;
 5b8:	4301                	li	t1,0
 5ba:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 5be:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 5c0:	2601                	sext.w	a2,a2
 5c2:	00000897          	auipc	a7,0x0
 5c6:	4ae88893          	addi	a7,a7,1198 # a70 <digits>
 5ca:	a801                	j	5da <printint+0x38>
    x = -xx;
 5cc:	40b005bb          	negw	a1,a1
 5d0:	2581                	sext.w	a1,a1
    neg = 1;
 5d2:	4305                	li	t1,1
    x = -xx;
 5d4:	b7dd                	j	5ba <printint+0x18>
  }while((x /= base) != 0);
 5d6:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5d8:	8836                	mv	a6,a3
 5da:	0018069b          	addiw	a3,a6,1
 5de:	02c5f7bb          	remuw	a5,a1,a2
 5e2:	1782                	slli	a5,a5,0x20
 5e4:	9381                	srli	a5,a5,0x20
 5e6:	97c6                	add	a5,a5,a7
 5e8:	0007c783          	lbu	a5,0(a5)
 5ec:	00f70023          	sb	a5,0(a4)
 5f0:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 5f2:	02c5d7bb          	divuw	a5,a1,a2
 5f6:	fec5f0e3          	bleu	a2,a1,5d6 <printint+0x34>
  if(neg)
 5fa:	00030b63          	beqz	t1,610 <printint+0x6e>
    buf[i++] = '-';
 5fe:	fd040793          	addi	a5,s0,-48
 602:	96be                	add	a3,a3,a5
 604:	02d00793          	li	a5,45
 608:	fef68823          	sb	a5,-16(a3)
 60c:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 610:	02d05963          	blez	a3,642 <printint+0xa0>
 614:	89aa                	mv	s3,a0
 616:	fc040793          	addi	a5,s0,-64
 61a:	00d784b3          	add	s1,a5,a3
 61e:	fff78913          	addi	s2,a5,-1
 622:	9936                	add	s2,s2,a3
 624:	36fd                	addiw	a3,a3,-1
 626:	1682                	slli	a3,a3,0x20
 628:	9281                	srli	a3,a3,0x20
 62a:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 62e:	fff4c583          	lbu	a1,-1(s1)
 632:	854e                	mv	a0,s3
 634:	00000097          	auipc	ra,0x0
 638:	f4c080e7          	jalr	-180(ra) # 580 <putc>
 63c:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 63e:	ff2498e3          	bne	s1,s2,62e <printint+0x8c>
}
 642:	70e2                	ld	ra,56(sp)
 644:	7442                	ld	s0,48(sp)
 646:	74a2                	ld	s1,40(sp)
 648:	7902                	ld	s2,32(sp)
 64a:	69e2                	ld	s3,24(sp)
 64c:	6121                	addi	sp,sp,64
 64e:	8082                	ret

0000000000000650 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 650:	7119                	addi	sp,sp,-128
 652:	fc86                	sd	ra,120(sp)
 654:	f8a2                	sd	s0,112(sp)
 656:	f4a6                	sd	s1,104(sp)
 658:	f0ca                	sd	s2,96(sp)
 65a:	ecce                	sd	s3,88(sp)
 65c:	e8d2                	sd	s4,80(sp)
 65e:	e4d6                	sd	s5,72(sp)
 660:	e0da                	sd	s6,64(sp)
 662:	fc5e                	sd	s7,56(sp)
 664:	f862                	sd	s8,48(sp)
 666:	f466                	sd	s9,40(sp)
 668:	f06a                	sd	s10,32(sp)
 66a:	ec6e                	sd	s11,24(sp)
 66c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 66e:	0005c483          	lbu	s1,0(a1)
 672:	18048d63          	beqz	s1,80c <vprintf+0x1bc>
 676:	8aaa                	mv	s5,a0
 678:	8b32                	mv	s6,a2
 67a:	00158913          	addi	s2,a1,1
  state = 0;
 67e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 680:	02500a13          	li	s4,37
      if(c == 'd'){
 684:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 688:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 68c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 690:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 694:	00000b97          	auipc	s7,0x0
 698:	3dcb8b93          	addi	s7,s7,988 # a70 <digits>
 69c:	a839                	j	6ba <vprintf+0x6a>
        putc(fd, c);
 69e:	85a6                	mv	a1,s1
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	ede080e7          	jalr	-290(ra) # 580 <putc>
 6aa:	a019                	j	6b0 <vprintf+0x60>
    } else if(state == '%'){
 6ac:	01498f63          	beq	s3,s4,6ca <vprintf+0x7a>
 6b0:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 6b2:	fff94483          	lbu	s1,-1(s2)
 6b6:	14048b63          	beqz	s1,80c <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 6ba:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6be:	fe0997e3          	bnez	s3,6ac <vprintf+0x5c>
      if(c == '%'){
 6c2:	fd479ee3          	bne	a5,s4,69e <vprintf+0x4e>
        state = '%';
 6c6:	89be                	mv	s3,a5
 6c8:	b7e5                	j	6b0 <vprintf+0x60>
      if(c == 'd'){
 6ca:	05878063          	beq	a5,s8,70a <vprintf+0xba>
      } else if(c == 'l') {
 6ce:	05978c63          	beq	a5,s9,726 <vprintf+0xd6>
      } else if(c == 'x') {
 6d2:	07a78863          	beq	a5,s10,742 <vprintf+0xf2>
      } else if(c == 'p') {
 6d6:	09b78463          	beq	a5,s11,75e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6da:	07300713          	li	a4,115
 6de:	0ce78563          	beq	a5,a4,7a8 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e2:	06300713          	li	a4,99
 6e6:	0ee78c63          	beq	a5,a4,7de <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ea:	11478663          	beq	a5,s4,7f6 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ee:	85d2                	mv	a1,s4
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e8e080e7          	jalr	-370(ra) # 580 <putc>
        putc(fd, c);
 6fa:	85a6                	mv	a1,s1
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e82080e7          	jalr	-382(ra) # 580 <putc>
      }
      state = 0;
 706:	4981                	li	s3,0
 708:	b765                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 70a:	008b0493          	addi	s1,s6,8
 70e:	4685                	li	a3,1
 710:	4629                	li	a2,10
 712:	000b2583          	lw	a1,0(s6)
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	e8a080e7          	jalr	-374(ra) # 5a2 <printint>
 720:	8b26                	mv	s6,s1
      state = 0;
 722:	4981                	li	s3,0
 724:	b771                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 726:	008b0493          	addi	s1,s6,8
 72a:	4681                	li	a3,0
 72c:	4629                	li	a2,10
 72e:	000b2583          	lw	a1,0(s6)
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	e6e080e7          	jalr	-402(ra) # 5a2 <printint>
 73c:	8b26                	mv	s6,s1
      state = 0;
 73e:	4981                	li	s3,0
 740:	bf85                	j	6b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 742:	008b0493          	addi	s1,s6,8
 746:	4681                	li	a3,0
 748:	4641                	li	a2,16
 74a:	000b2583          	lw	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	e52080e7          	jalr	-430(ra) # 5a2 <printint>
 758:	8b26                	mv	s6,s1
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bf91                	j	6b0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 75e:	008b0793          	addi	a5,s6,8
 762:	f8f43423          	sd	a5,-120(s0)
 766:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 76a:	03000593          	li	a1,48
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e10080e7          	jalr	-496(ra) # 580 <putc>
  putc(fd, 'x');
 778:	85ea                	mv	a1,s10
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e04080e7          	jalr	-508(ra) # 580 <putc>
 784:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 786:	03c9d793          	srli	a5,s3,0x3c
 78a:	97de                	add	a5,a5,s7
 78c:	0007c583          	lbu	a1,0(a5)
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	dee080e7          	jalr	-530(ra) # 580 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79a:	0992                	slli	s3,s3,0x4
 79c:	34fd                	addiw	s1,s1,-1
 79e:	f4e5                	bnez	s1,786 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7a0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	b729                	j	6b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7a8:	008b0993          	addi	s3,s6,8
 7ac:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 7b0:	c085                	beqz	s1,7d0 <vprintf+0x180>
        while(*s != 0){
 7b2:	0004c583          	lbu	a1,0(s1)
 7b6:	c9a1                	beqz	a1,806 <vprintf+0x1b6>
          putc(fd, *s);
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	dc6080e7          	jalr	-570(ra) # 580 <putc>
          s++;
 7c2:	0485                	addi	s1,s1,1
        while(*s != 0){
 7c4:	0004c583          	lbu	a1,0(s1)
 7c8:	f9e5                	bnez	a1,7b8 <vprintf+0x168>
        s = va_arg(ap, char*);
 7ca:	8b4e                	mv	s6,s3
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b5cd                	j	6b0 <vprintf+0x60>
          s = "(null)";
 7d0:	00000497          	auipc	s1,0x0
 7d4:	2b848493          	addi	s1,s1,696 # a88 <digits+0x18>
        while(*s != 0){
 7d8:	02800593          	li	a1,40
 7dc:	bff1                	j	7b8 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7de:	008b0493          	addi	s1,s6,8
 7e2:	000b4583          	lbu	a1,0(s6)
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	d98080e7          	jalr	-616(ra) # 580 <putc>
 7f0:	8b26                	mv	s6,s1
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	bd75                	j	6b0 <vprintf+0x60>
        putc(fd, c);
 7f6:	85d2                	mv	a1,s4
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	d86080e7          	jalr	-634(ra) # 580 <putc>
      state = 0;
 802:	4981                	li	s3,0
 804:	b575                	j	6b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 806:	8b4e                	mv	s6,s3
      state = 0;
 808:	4981                	li	s3,0
 80a:	b55d                	j	6b0 <vprintf+0x60>
    }
  }
}
 80c:	70e6                	ld	ra,120(sp)
 80e:	7446                	ld	s0,112(sp)
 810:	74a6                	ld	s1,104(sp)
 812:	7906                	ld	s2,96(sp)
 814:	69e6                	ld	s3,88(sp)
 816:	6a46                	ld	s4,80(sp)
 818:	6aa6                	ld	s5,72(sp)
 81a:	6b06                	ld	s6,64(sp)
 81c:	7be2                	ld	s7,56(sp)
 81e:	7c42                	ld	s8,48(sp)
 820:	7ca2                	ld	s9,40(sp)
 822:	7d02                	ld	s10,32(sp)
 824:	6de2                	ld	s11,24(sp)
 826:	6109                	addi	sp,sp,128
 828:	8082                	ret

000000000000082a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82a:	715d                	addi	sp,sp,-80
 82c:	ec06                	sd	ra,24(sp)
 82e:	e822                	sd	s0,16(sp)
 830:	1000                	addi	s0,sp,32
 832:	e010                	sd	a2,0(s0)
 834:	e414                	sd	a3,8(s0)
 836:	e818                	sd	a4,16(s0)
 838:	ec1c                	sd	a5,24(s0)
 83a:	03043023          	sd	a6,32(s0)
 83e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 842:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 846:	8622                	mv	a2,s0
 848:	00000097          	auipc	ra,0x0
 84c:	e08080e7          	jalr	-504(ra) # 650 <vprintf>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6161                	addi	sp,sp,80
 856:	8082                	ret

0000000000000858 <printf>:

void
printf(const char *fmt, ...)
{
 858:	711d                	addi	sp,sp,-96
 85a:	ec06                	sd	ra,24(sp)
 85c:	e822                	sd	s0,16(sp)
 85e:	1000                	addi	s0,sp,32
 860:	e40c                	sd	a1,8(s0)
 862:	e810                	sd	a2,16(s0)
 864:	ec14                	sd	a3,24(s0)
 866:	f018                	sd	a4,32(s0)
 868:	f41c                	sd	a5,40(s0)
 86a:	03043823          	sd	a6,48(s0)
 86e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 872:	00840613          	addi	a2,s0,8
 876:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87a:	85aa                	mv	a1,a0
 87c:	4505                	li	a0,1
 87e:	00000097          	auipc	ra,0x0
 882:	dd2080e7          	jalr	-558(ra) # 650 <vprintf>
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	6125                	addi	sp,sp,96
 88c:	8082                	ret

000000000000088e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88e:	1141                	addi	sp,sp,-16
 890:	e422                	sd	s0,8(sp)
 892:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 894:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 898:	00000797          	auipc	a5,0x0
 89c:	1f878793          	addi	a5,a5,504 # a90 <__bss_start>
 8a0:	639c                	ld	a5,0(a5)
 8a2:	a805                	j	8d2 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a4:	4618                	lw	a4,8(a2)
 8a6:	9db9                	addw	a1,a1,a4
 8a8:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ac:	6398                	ld	a4,0(a5)
 8ae:	6318                	ld	a4,0(a4)
 8b0:	fee53823          	sd	a4,-16(a0)
 8b4:	a091                	j	8f8 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b6:	ff852703          	lw	a4,-8(a0)
 8ba:	9e39                	addw	a2,a2,a4
 8bc:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8be:	ff053703          	ld	a4,-16(a0)
 8c2:	e398                	sd	a4,0(a5)
 8c4:	a099                	j	90a <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c6:	6398                	ld	a4,0(a5)
 8c8:	00e7e463          	bltu	a5,a4,8d0 <free+0x42>
 8cc:	00e6ea63          	bltu	a3,a4,8e0 <free+0x52>
{
 8d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d2:	fed7fae3          	bleu	a3,a5,8c6 <free+0x38>
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e6e463          	bltu	a3,a4,8e0 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dc:	fee7eae3          	bltu	a5,a4,8d0 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8e0:	ff852583          	lw	a1,-8(a0)
 8e4:	6390                	ld	a2,0(a5)
 8e6:	02059713          	slli	a4,a1,0x20
 8ea:	9301                	srli	a4,a4,0x20
 8ec:	0712                	slli	a4,a4,0x4
 8ee:	9736                	add	a4,a4,a3
 8f0:	fae60ae3          	beq	a2,a4,8a4 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f8:	4790                	lw	a2,8(a5)
 8fa:	02061713          	slli	a4,a2,0x20
 8fe:	9301                	srli	a4,a4,0x20
 900:	0712                	slli	a4,a4,0x4
 902:	973e                	add	a4,a4,a5
 904:	fae689e3          	beq	a3,a4,8b6 <free+0x28>
  } else
    p->s.ptr = bp;
 908:	e394                	sd	a3,0(a5)
  freep = p;
 90a:	00000717          	auipc	a4,0x0
 90e:	18f73323          	sd	a5,390(a4) # a90 <__bss_start>
}
 912:	6422                	ld	s0,8(sp)
 914:	0141                	addi	sp,sp,16
 916:	8082                	ret

0000000000000918 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 918:	7139                	addi	sp,sp,-64
 91a:	fc06                	sd	ra,56(sp)
 91c:	f822                	sd	s0,48(sp)
 91e:	f426                	sd	s1,40(sp)
 920:	f04a                	sd	s2,32(sp)
 922:	ec4e                	sd	s3,24(sp)
 924:	e852                	sd	s4,16(sp)
 926:	e456                	sd	s5,8(sp)
 928:	e05a                	sd	s6,0(sp)
 92a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 92c:	02051993          	slli	s3,a0,0x20
 930:	0209d993          	srli	s3,s3,0x20
 934:	09bd                	addi	s3,s3,15
 936:	0049d993          	srli	s3,s3,0x4
 93a:	2985                	addiw	s3,s3,1
 93c:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 940:	00000797          	auipc	a5,0x0
 944:	15078793          	addi	a5,a5,336 # a90 <__bss_start>
 948:	6388                	ld	a0,0(a5)
 94a:	c515                	beqz	a0,976 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 94c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94e:	4798                	lw	a4,8(a5)
 950:	03277f63          	bleu	s2,a4,98e <malloc+0x76>
 954:	8a4e                	mv	s4,s3
 956:	0009871b          	sext.w	a4,s3
 95a:	6685                	lui	a3,0x1
 95c:	00d77363          	bleu	a3,a4,962 <malloc+0x4a>
 960:	6a05                	lui	s4,0x1
 962:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 966:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 96a:	00000497          	auipc	s1,0x0
 96e:	12648493          	addi	s1,s1,294 # a90 <__bss_start>
  if(p == (char*)-1)
 972:	5b7d                	li	s6,-1
 974:	a885                	j	9e4 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 976:	00000797          	auipc	a5,0x0
 97a:	13278793          	addi	a5,a5,306 # aa8 <base>
 97e:	00000717          	auipc	a4,0x0
 982:	10f73923          	sd	a5,274(a4) # a90 <__bss_start>
 986:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 988:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 98c:	b7e1                	j	954 <malloc+0x3c>
      if(p->s.size == nunits)
 98e:	02e90b63          	beq	s2,a4,9c4 <malloc+0xac>
        p->s.size -= nunits;
 992:	4137073b          	subw	a4,a4,s3
 996:	c798                	sw	a4,8(a5)
        p += p->s.size;
 998:	1702                	slli	a4,a4,0x20
 99a:	9301                	srli	a4,a4,0x20
 99c:	0712                	slli	a4,a4,0x4
 99e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	0ea73623          	sd	a0,236(a4) # a90 <__bss_start>
      return (void*)(p + 1);
 9ac:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b0:	70e2                	ld	ra,56(sp)
 9b2:	7442                	ld	s0,48(sp)
 9b4:	74a2                	ld	s1,40(sp)
 9b6:	7902                	ld	s2,32(sp)
 9b8:	69e2                	ld	s3,24(sp)
 9ba:	6a42                	ld	s4,16(sp)
 9bc:	6aa2                	ld	s5,8(sp)
 9be:	6b02                	ld	s6,0(sp)
 9c0:	6121                	addi	sp,sp,64
 9c2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9c4:	6398                	ld	a4,0(a5)
 9c6:	e118                	sd	a4,0(a0)
 9c8:	bff1                	j	9a4 <malloc+0x8c>
  hp->s.size = nu;
 9ca:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 9ce:	0541                	addi	a0,a0,16
 9d0:	00000097          	auipc	ra,0x0
 9d4:	ebe080e7          	jalr	-322(ra) # 88e <free>
  return freep;
 9d8:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9da:	d979                	beqz	a0,9b0 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9de:	4798                	lw	a4,8(a5)
 9e0:	fb2777e3          	bleu	s2,a4,98e <malloc+0x76>
    if(p == freep)
 9e4:	6098                	ld	a4,0(s1)
 9e6:	853e                	mv	a0,a5
 9e8:	fef71ae3          	bne	a4,a5,9dc <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9ec:	8552                	mv	a0,s4
 9ee:	00000097          	auipc	ra,0x0
 9f2:	b7a080e7          	jalr	-1158(ra) # 568 <sbrk>
  if(p == (char*)-1)
 9f6:	fd651ae3          	bne	a0,s6,9ca <malloc+0xb2>
        return 0;
 9fa:	4501                	li	a0,0
 9fc:	bf55                	j	9b0 <malloc+0x98>
