
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	e06a                	sd	s10,0(sp)
 134:	1080                	addi	s0,sp,96
 136:	89aa                	mv	s3,a0
 138:	8c2e                	mv	s8,a1
  m = 0;
 13a:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13c:	3ff00b93          	li	s7,1023
 140:	00001b17          	auipc	s6,0x1
 144:	8f0b0b13          	addi	s6,s6,-1808 # a30 <buf>
    p = buf;
 148:	8d5a                	mv	s10,s6
        *q = '\n';
 14a:	4aa9                	li	s5,10
    p = buf;
 14c:	8cda                	mv	s9,s6
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14e:	a099                	j	194 <grep+0x7a>
        *q = '\n';
 150:	01548023          	sb	s5,0(s1)
        write(1, p, q+1 - p);
 154:	00148613          	addi	a2,s1,1
 158:	4126063b          	subw	a2,a2,s2
 15c:	85ca                	mv	a1,s2
 15e:	4505                	li	a0,1
 160:	00000097          	auipc	ra,0x0
 164:	36e080e7          	jalr	878(ra) # 4ce <write>
      p = q+1;
 168:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 16c:	45a9                	li	a1,10
 16e:	854a                	mv	a0,s2
 170:	00000097          	auipc	ra,0x0
 174:	1da080e7          	jalr	474(ra) # 34a <strchr>
 178:	84aa                	mv	s1,a0
 17a:	c919                	beqz	a0,190 <grep+0x76>
      *q = 0;
 17c:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 180:	85ca                	mv	a1,s2
 182:	854e                	mv	a0,s3
 184:	00000097          	auipc	ra,0x0
 188:	f48080e7          	jalr	-184(ra) # cc <match>
 18c:	dd71                	beqz	a0,168 <grep+0x4e>
 18e:	b7c9                	j	150 <grep+0x36>
    if(m > 0){
 190:	03404563          	bgtz	s4,1ba <grep+0xa0>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 194:	414b863b          	subw	a2,s7,s4
 198:	014b05b3          	add	a1,s6,s4
 19c:	8562                	mv	a0,s8
 19e:	00000097          	auipc	ra,0x0
 1a2:	328080e7          	jalr	808(ra) # 4c6 <read>
 1a6:	02a05663          	blez	a0,1d2 <grep+0xb8>
    m += n;
 1aa:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1ae:	014b07b3          	add	a5,s6,s4
 1b2:	00078023          	sb	zero,0(a5)
    p = buf;
 1b6:	8966                	mv	s2,s9
    while((q = strchr(p, '\n')) != 0){
 1b8:	bf55                	j	16c <grep+0x52>
      m -= p - buf;
 1ba:	416907b3          	sub	a5,s2,s6
 1be:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1c2:	8652                	mv	a2,s4
 1c4:	85ca                	mv	a1,s2
 1c6:	856a                	mv	a0,s10
 1c8:	00000097          	auipc	ra,0x0
 1cc:	2b0080e7          	jalr	688(ra) # 478 <memmove>
 1d0:	b7d1                	j	194 <grep+0x7a>
}
 1d2:	60e6                	ld	ra,88(sp)
 1d4:	6446                	ld	s0,80(sp)
 1d6:	64a6                	ld	s1,72(sp)
 1d8:	6906                	ld	s2,64(sp)
 1da:	79e2                	ld	s3,56(sp)
 1dc:	7a42                	ld	s4,48(sp)
 1de:	7aa2                	ld	s5,40(sp)
 1e0:	7b02                	ld	s6,32(sp)
 1e2:	6be2                	ld	s7,24(sp)
 1e4:	6c42                	ld	s8,16(sp)
 1e6:	6ca2                	ld	s9,8(sp)
 1e8:	6d02                	ld	s10,0(sp)
 1ea:	6125                	addi	sp,sp,96
 1ec:	8082                	ret

00000000000001ee <main>:
{
 1ee:	7139                	addi	sp,sp,-64
 1f0:	fc06                	sd	ra,56(sp)
 1f2:	f822                	sd	s0,48(sp)
 1f4:	f426                	sd	s1,40(sp)
 1f6:	f04a                	sd	s2,32(sp)
 1f8:	ec4e                	sd	s3,24(sp)
 1fa:	e852                	sd	s4,16(sp)
 1fc:	e456                	sd	s5,8(sp)
 1fe:	0080                	addi	s0,sp,64
  if(argc <= 1){
 200:	4785                	li	a5,1
 202:	04a7dd63          	ble	a0,a5,25c <main+0x6e>
  pattern = argv[1];
 206:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 20a:	4789                	li	a5,2
 20c:	06a7d663          	ble	a0,a5,278 <main+0x8a>
 210:	01058493          	addi	s1,a1,16
 214:	ffd5099b          	addiw	s3,a0,-3
 218:	1982                	slli	s3,s3,0x20
 21a:	0209d993          	srli	s3,s3,0x20
 21e:	098e                	slli	s3,s3,0x3
 220:	05e1                	addi	a1,a1,24
 222:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 224:	4581                	li	a1,0
 226:	6088                	ld	a0,0(s1)
 228:	00000097          	auipc	ra,0x0
 22c:	2c6080e7          	jalr	710(ra) # 4ee <open>
 230:	892a                	mv	s2,a0
 232:	04054e63          	bltz	a0,28e <main+0xa0>
    grep(pattern, fd);
 236:	85aa                	mv	a1,a0
 238:	8552                	mv	a0,s4
 23a:	00000097          	auipc	ra,0x0
 23e:	ee0080e7          	jalr	-288(ra) # 11a <grep>
    close(fd);
 242:	854a                	mv	a0,s2
 244:	00000097          	auipc	ra,0x0
 248:	292080e7          	jalr	658(ra) # 4d6 <close>
 24c:	04a1                	addi	s1,s1,8
  for(i = 2; i < argc; i++){
 24e:	fd349be3          	bne	s1,s3,224 <main+0x36>
  exit(0);
 252:	4501                	li	a0,0
 254:	00000097          	auipc	ra,0x0
 258:	25a080e7          	jalr	602(ra) # 4ae <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25c:	00000597          	auipc	a1,0x0
 260:	77458593          	addi	a1,a1,1908 # 9d0 <malloc+0xea>
 264:	4509                	li	a0,2
 266:	00000097          	auipc	ra,0x0
 26a:	592080e7          	jalr	1426(ra) # 7f8 <fprintf>
    exit(1);
 26e:	4505                	li	a0,1
 270:	00000097          	auipc	ra,0x0
 274:	23e080e7          	jalr	574(ra) # 4ae <exit>
    grep(pattern, 0);
 278:	4581                	li	a1,0
 27a:	8552                	mv	a0,s4
 27c:	00000097          	auipc	ra,0x0
 280:	e9e080e7          	jalr	-354(ra) # 11a <grep>
    exit(0);
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	228080e7          	jalr	552(ra) # 4ae <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28e:	608c                	ld	a1,0(s1)
 290:	00000517          	auipc	a0,0x0
 294:	76050513          	addi	a0,a0,1888 # 9f0 <malloc+0x10a>
 298:	00000097          	auipc	ra,0x0
 29c:	58e080e7          	jalr	1422(ra) # 826 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	20c080e7          	jalr	524(ra) # 4ae <exit>

00000000000002aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b0:	87aa                	mv	a5,a0
 2b2:	0585                	addi	a1,a1,1
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcpy+0x8>
    ;
  return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf91                	beqz	a5,2ec <strcmp+0x26>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71b63          	bne	a4,a5,2ec <strcmp+0x26>
    p++, q++;
 2da:	0505                	addi	a0,a0,1
 2dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	c789                	beqz	a5,2ec <strcmp+0x26>
 2e4:	0005c703          	lbu	a4,0(a1)
 2e8:	fef709e3          	beq	a4,a5,2da <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 2ec:	0005c503          	lbu	a0,0(a1)
}
 2f0:	40a7853b          	subw	a0,a5,a0
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strlen>:

uint
strlen(const char *s)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 300:	00054783          	lbu	a5,0(a0)
 304:	cf91                	beqz	a5,320 <strlen+0x26>
 306:	0505                	addi	a0,a0,1
 308:	87aa                	mv	a5,a0
 30a:	4685                	li	a3,1
 30c:	9e89                	subw	a3,a3,a0
    ;
 30e:	00f6853b          	addw	a0,a3,a5
 312:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 314:	fff7c703          	lbu	a4,-1(a5)
 318:	fb7d                	bnez	a4,30e <strlen+0x14>
  return n;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  for(n = 0; s[n]; n++)
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strlen+0x20>

0000000000000324 <memset>:

void*
memset(void *dst, int c, uint n)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 32a:	ce09                	beqz	a2,344 <memset+0x20>
 32c:	87aa                	mv	a5,a0
 32e:	fff6071b          	addiw	a4,a2,-1
 332:	1702                	slli	a4,a4,0x20
 334:	9301                	srli	a4,a4,0x20
 336:	0705                	addi	a4,a4,1
 338:	972a                	add	a4,a4,a0
    cdst[i] = c;
 33a:	00b78023          	sb	a1,0(a5)
 33e:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 340:	fee79de3          	bne	a5,a4,33a <memset+0x16>
  }
  return dst;
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <strchr>:

char*
strchr(const char *s, char c)
{
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 350:	00054783          	lbu	a5,0(a0)
 354:	cf91                	beqz	a5,370 <strchr+0x26>
    if(*s == c)
 356:	00f58a63          	beq	a1,a5,36a <strchr+0x20>
  for(; *s; s++)
 35a:	0505                	addi	a0,a0,1
 35c:	00054783          	lbu	a5,0(a0)
 360:	c781                	beqz	a5,368 <strchr+0x1e>
    if(*s == c)
 362:	feb79ce3          	bne	a5,a1,35a <strchr+0x10>
 366:	a011                	j	36a <strchr+0x20>
      return (char*)s;
  return 0;
 368:	4501                	li	a0,0
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <strchr+0x20>

0000000000000374 <gets>:

char*
gets(char *buf, int max)
{
 374:	711d                	addi	sp,sp,-96
 376:	ec86                	sd	ra,88(sp)
 378:	e8a2                	sd	s0,80(sp)
 37a:	e4a6                	sd	s1,72(sp)
 37c:	e0ca                	sd	s2,64(sp)
 37e:	fc4e                	sd	s3,56(sp)
 380:	f852                	sd	s4,48(sp)
 382:	f456                	sd	s5,40(sp)
 384:	f05a                	sd	s6,32(sp)
 386:	ec5e                	sd	s7,24(sp)
 388:	1080                	addi	s0,sp,96
 38a:	8baa                	mv	s7,a0
 38c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38e:	892a                	mv	s2,a0
 390:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 392:	4aa9                	li	s5,10
 394:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 396:	0019849b          	addiw	s1,s3,1
 39a:	0344d863          	ble	s4,s1,3ca <gets+0x56>
    cc = read(0, &c, 1);
 39e:	4605                	li	a2,1
 3a0:	faf40593          	addi	a1,s0,-81
 3a4:	4501                	li	a0,0
 3a6:	00000097          	auipc	ra,0x0
 3aa:	120080e7          	jalr	288(ra) # 4c6 <read>
    if(cc < 1)
 3ae:	00a05e63          	blez	a0,3ca <gets+0x56>
    buf[i++] = c;
 3b2:	faf44783          	lbu	a5,-81(s0)
 3b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ba:	01578763          	beq	a5,s5,3c8 <gets+0x54>
 3be:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3c0:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3c2:	fd679ae3          	bne	a5,s6,396 <gets+0x22>
 3c6:	a011                	j	3ca <gets+0x56>
  for(i=0; i+1 < max; ){
 3c8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ca:	99de                	add	s3,s3,s7
 3cc:	00098023          	sb	zero,0(s3)
  return buf;
}
 3d0:	855e                	mv	a0,s7
 3d2:	60e6                	ld	ra,88(sp)
 3d4:	6446                	ld	s0,80(sp)
 3d6:	64a6                	ld	s1,72(sp)
 3d8:	6906                	ld	s2,64(sp)
 3da:	79e2                	ld	s3,56(sp)
 3dc:	7a42                	ld	s4,48(sp)
 3de:	7aa2                	ld	s5,40(sp)
 3e0:	7b02                	ld	s6,32(sp)
 3e2:	6be2                	ld	s7,24(sp)
 3e4:	6125                	addi	sp,sp,96
 3e6:	8082                	ret

00000000000003e8 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e8:	1101                	addi	sp,sp,-32
 3ea:	ec06                	sd	ra,24(sp)
 3ec:	e822                	sd	s0,16(sp)
 3ee:	e426                	sd	s1,8(sp)
 3f0:	e04a                	sd	s2,0(sp)
 3f2:	1000                	addi	s0,sp,32
 3f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f6:	4581                	li	a1,0
 3f8:	00000097          	auipc	ra,0x0
 3fc:	0f6080e7          	jalr	246(ra) # 4ee <open>
  if(fd < 0)
 400:	02054563          	bltz	a0,42a <stat+0x42>
 404:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 406:	85ca                	mv	a1,s2
 408:	00000097          	auipc	ra,0x0
 40c:	0fe080e7          	jalr	254(ra) # 506 <fstat>
 410:	892a                	mv	s2,a0
  close(fd);
 412:	8526                	mv	a0,s1
 414:	00000097          	auipc	ra,0x0
 418:	0c2080e7          	jalr	194(ra) # 4d6 <close>
  return r;
}
 41c:	854a                	mv	a0,s2
 41e:	60e2                	ld	ra,24(sp)
 420:	6442                	ld	s0,16(sp)
 422:	64a2                	ld	s1,8(sp)
 424:	6902                	ld	s2,0(sp)
 426:	6105                	addi	sp,sp,32
 428:	8082                	ret
    return -1;
 42a:	597d                	li	s2,-1
 42c:	bfc5                	j	41c <stat+0x34>

000000000000042e <atoi>:

int
atoi(const char *s)
{
 42e:	1141                	addi	sp,sp,-16
 430:	e422                	sd	s0,8(sp)
 432:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 434:	00054683          	lbu	a3,0(a0)
 438:	fd06879b          	addiw	a5,a3,-48
 43c:	0ff7f793          	andi	a5,a5,255
 440:	4725                	li	a4,9
 442:	02f76963          	bltu	a4,a5,474 <atoi+0x46>
 446:	862a                	mv	a2,a0
  n = 0;
 448:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 44a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 44c:	0605                	addi	a2,a2,1
 44e:	0025179b          	slliw	a5,a0,0x2
 452:	9fa9                	addw	a5,a5,a0
 454:	0017979b          	slliw	a5,a5,0x1
 458:	9fb5                	addw	a5,a5,a3
 45a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 45e:	00064683          	lbu	a3,0(a2)
 462:	fd06871b          	addiw	a4,a3,-48
 466:	0ff77713          	andi	a4,a4,255
 46a:	fee5f1e3          	bleu	a4,a1,44c <atoi+0x1e>
  return n;
}
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret
  n = 0;
 474:	4501                	li	a0,0
 476:	bfe5                	j	46e <atoi+0x40>

0000000000000478 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 478:	1141                	addi	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	02c05163          	blez	a2,4a0 <memmove+0x28>
 482:	fff6071b          	addiw	a4,a2,-1
 486:	1702                	slli	a4,a4,0x20
 488:	9301                	srli	a4,a4,0x20
 48a:	0705                	addi	a4,a4,1
 48c:	972a                	add	a4,a4,a0
  dst = vdst;
 48e:	87aa                	mv	a5,a0
    *dst++ = *src++;
 490:	0585                	addi	a1,a1,1
 492:	0785                	addi	a5,a5,1
 494:	fff5c683          	lbu	a3,-1(a1)
 498:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
 49c:	fee79ae3          	bne	a5,a4,490 <memmove+0x18>
  return vdst;
}
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret

00000000000004a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4a6:	4885                	li	a7,1
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ae:	4889                	li	a7,2
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4b6:	488d                	li	a7,3
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4be:	4891                	li	a7,4
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <read>:
.global read
read:
 li a7, SYS_read
 4c6:	4895                	li	a7,5
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <write>:
.global write
write:
 li a7, SYS_write
 4ce:	48c1                	li	a7,16
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <close>:
.global close
close:
 li a7, SYS_close
 4d6:	48d5                	li	a7,21
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <kill>:
.global kill
kill:
 li a7, SYS_kill
 4de:	4899                	li	a7,6
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4e6:	489d                	li	a7,7
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <open>:
.global open
open:
 li a7, SYS_open
 4ee:	48bd                	li	a7,15
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4f6:	48c5                	li	a7,17
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4fe:	48c9                	li	a7,18
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 506:	48a1                	li	a7,8
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <link>:
.global link
link:
 li a7, SYS_link
 50e:	48cd                	li	a7,19
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 516:	48d1                	li	a7,20
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 51e:	48a5                	li	a7,9
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <dup>:
.global dup
dup:
 li a7, SYS_dup
 526:	48a9                	li	a7,10
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 52e:	48ad                	li	a7,11
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 536:	48b1                	li	a7,12
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 53e:	48b5                	li	a7,13
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 546:	48b9                	li	a7,14
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 54e:	1101                	addi	sp,sp,-32
 550:	ec06                	sd	ra,24(sp)
 552:	e822                	sd	s0,16(sp)
 554:	1000                	addi	s0,sp,32
 556:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 55a:	4605                	li	a2,1
 55c:	fef40593          	addi	a1,s0,-17
 560:	00000097          	auipc	ra,0x0
 564:	f6e080e7          	jalr	-146(ra) # 4ce <write>
}
 568:	60e2                	ld	ra,24(sp)
 56a:	6442                	ld	s0,16(sp)
 56c:	6105                	addi	sp,sp,32
 56e:	8082                	ret

0000000000000570 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 570:	7139                	addi	sp,sp,-64
 572:	fc06                	sd	ra,56(sp)
 574:	f822                	sd	s0,48(sp)
 576:	f426                	sd	s1,40(sp)
 578:	f04a                	sd	s2,32(sp)
 57a:	ec4e                	sd	s3,24(sp)
 57c:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57e:	c299                	beqz	a3,584 <printint+0x14>
 580:	0005cd63          	bltz	a1,59a <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 584:	2581                	sext.w	a1,a1
  neg = 0;
 586:	4301                	li	t1,0
 588:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 58c:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 58e:	2601                	sext.w	a2,a2
 590:	00000897          	auipc	a7,0x0
 594:	47888893          	addi	a7,a7,1144 # a08 <digits>
 598:	a801                	j	5a8 <printint+0x38>
    x = -xx;
 59a:	40b005bb          	negw	a1,a1
 59e:	2581                	sext.w	a1,a1
    neg = 1;
 5a0:	4305                	li	t1,1
    x = -xx;
 5a2:	b7dd                	j	588 <printint+0x18>
  }while((x /= base) != 0);
 5a4:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5a6:	8836                	mv	a6,a3
 5a8:	0018069b          	addiw	a3,a6,1
 5ac:	02c5f7bb          	remuw	a5,a1,a2
 5b0:	1782                	slli	a5,a5,0x20
 5b2:	9381                	srli	a5,a5,0x20
 5b4:	97c6                	add	a5,a5,a7
 5b6:	0007c783          	lbu	a5,0(a5)
 5ba:	00f70023          	sb	a5,0(a4)
 5be:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 5c0:	02c5d7bb          	divuw	a5,a1,a2
 5c4:	fec5f0e3          	bleu	a2,a1,5a4 <printint+0x34>
  if(neg)
 5c8:	00030b63          	beqz	t1,5de <printint+0x6e>
    buf[i++] = '-';
 5cc:	fd040793          	addi	a5,s0,-48
 5d0:	96be                	add	a3,a3,a5
 5d2:	02d00793          	li	a5,45
 5d6:	fef68823          	sb	a5,-16(a3)
 5da:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 5de:	02d05963          	blez	a3,610 <printint+0xa0>
 5e2:	89aa                	mv	s3,a0
 5e4:	fc040793          	addi	a5,s0,-64
 5e8:	00d784b3          	add	s1,a5,a3
 5ec:	fff78913          	addi	s2,a5,-1
 5f0:	9936                	add	s2,s2,a3
 5f2:	36fd                	addiw	a3,a3,-1
 5f4:	1682                	slli	a3,a3,0x20
 5f6:	9281                	srli	a3,a3,0x20
 5f8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 5fc:	fff4c583          	lbu	a1,-1(s1)
 600:	854e                	mv	a0,s3
 602:	00000097          	auipc	ra,0x0
 606:	f4c080e7          	jalr	-180(ra) # 54e <putc>
 60a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 60c:	ff2498e3          	bne	s1,s2,5fc <printint+0x8c>
}
 610:	70e2                	ld	ra,56(sp)
 612:	7442                	ld	s0,48(sp)
 614:	74a2                	ld	s1,40(sp)
 616:	7902                	ld	s2,32(sp)
 618:	69e2                	ld	s3,24(sp)
 61a:	6121                	addi	sp,sp,64
 61c:	8082                	ret

000000000000061e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 61e:	7119                	addi	sp,sp,-128
 620:	fc86                	sd	ra,120(sp)
 622:	f8a2                	sd	s0,112(sp)
 624:	f4a6                	sd	s1,104(sp)
 626:	f0ca                	sd	s2,96(sp)
 628:	ecce                	sd	s3,88(sp)
 62a:	e8d2                	sd	s4,80(sp)
 62c:	e4d6                	sd	s5,72(sp)
 62e:	e0da                	sd	s6,64(sp)
 630:	fc5e                	sd	s7,56(sp)
 632:	f862                	sd	s8,48(sp)
 634:	f466                	sd	s9,40(sp)
 636:	f06a                	sd	s10,32(sp)
 638:	ec6e                	sd	s11,24(sp)
 63a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63c:	0005c483          	lbu	s1,0(a1)
 640:	18048d63          	beqz	s1,7da <vprintf+0x1bc>
 644:	8aaa                	mv	s5,a0
 646:	8b32                	mv	s6,a2
 648:	00158913          	addi	s2,a1,1
  state = 0;
 64c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 64e:	02500a13          	li	s4,37
      if(c == 'd'){
 652:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 656:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 65a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 65e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 662:	00000b97          	auipc	s7,0x0
 666:	3a6b8b93          	addi	s7,s7,934 # a08 <digits>
 66a:	a839                	j	688 <vprintf+0x6a>
        putc(fd, c);
 66c:	85a6                	mv	a1,s1
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	ede080e7          	jalr	-290(ra) # 54e <putc>
 678:	a019                	j	67e <vprintf+0x60>
    } else if(state == '%'){
 67a:	01498f63          	beq	s3,s4,698 <vprintf+0x7a>
 67e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 680:	fff94483          	lbu	s1,-1(s2)
 684:	14048b63          	beqz	s1,7da <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 688:	0004879b          	sext.w	a5,s1
    if(state == 0){
 68c:	fe0997e3          	bnez	s3,67a <vprintf+0x5c>
      if(c == '%'){
 690:	fd479ee3          	bne	a5,s4,66c <vprintf+0x4e>
        state = '%';
 694:	89be                	mv	s3,a5
 696:	b7e5                	j	67e <vprintf+0x60>
      if(c == 'd'){
 698:	05878063          	beq	a5,s8,6d8 <vprintf+0xba>
      } else if(c == 'l') {
 69c:	05978c63          	beq	a5,s9,6f4 <vprintf+0xd6>
      } else if(c == 'x') {
 6a0:	07a78863          	beq	a5,s10,710 <vprintf+0xf2>
      } else if(c == 'p') {
 6a4:	09b78463          	beq	a5,s11,72c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6a8:	07300713          	li	a4,115
 6ac:	0ce78563          	beq	a5,a4,776 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b0:	06300713          	li	a4,99
 6b4:	0ee78c63          	beq	a5,a4,7ac <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6b8:	11478663          	beq	a5,s4,7c4 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6bc:	85d2                	mv	a1,s4
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	e8e080e7          	jalr	-370(ra) # 54e <putc>
        putc(fd, c);
 6c8:	85a6                	mv	a1,s1
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e82080e7          	jalr	-382(ra) # 54e <putc>
      }
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b765                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6d8:	008b0493          	addi	s1,s6,8
 6dc:	4685                	li	a3,1
 6de:	4629                	li	a2,10
 6e0:	000b2583          	lw	a1,0(s6)
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e8a080e7          	jalr	-374(ra) # 570 <printint>
 6ee:	8b26                	mv	s6,s1
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	b771                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f4:	008b0493          	addi	s1,s6,8
 6f8:	4681                	li	a3,0
 6fa:	4629                	li	a2,10
 6fc:	000b2583          	lw	a1,0(s6)
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	e6e080e7          	jalr	-402(ra) # 570 <printint>
 70a:	8b26                	mv	s6,s1
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bf85                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 710:	008b0493          	addi	s1,s6,8
 714:	4681                	li	a3,0
 716:	4641                	li	a2,16
 718:	000b2583          	lw	a1,0(s6)
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	e52080e7          	jalr	-430(ra) # 570 <printint>
 726:	8b26                	mv	s6,s1
      state = 0;
 728:	4981                	li	s3,0
 72a:	bf91                	j	67e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 72c:	008b0793          	addi	a5,s6,8
 730:	f8f43423          	sd	a5,-120(s0)
 734:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 738:	03000593          	li	a1,48
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e10080e7          	jalr	-496(ra) # 54e <putc>
  putc(fd, 'x');
 746:	85ea                	mv	a1,s10
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e04080e7          	jalr	-508(ra) # 54e <putc>
 752:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 754:	03c9d793          	srli	a5,s3,0x3c
 758:	97de                	add	a5,a5,s7
 75a:	0007c583          	lbu	a1,0(a5)
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	dee080e7          	jalr	-530(ra) # 54e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 768:	0992                	slli	s3,s3,0x4
 76a:	34fd                	addiw	s1,s1,-1
 76c:	f4e5                	bnez	s1,754 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 76e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 772:	4981                	li	s3,0
 774:	b729                	j	67e <vprintf+0x60>
        s = va_arg(ap, char*);
 776:	008b0993          	addi	s3,s6,8
 77a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 77e:	c085                	beqz	s1,79e <vprintf+0x180>
        while(*s != 0){
 780:	0004c583          	lbu	a1,0(s1)
 784:	c9a1                	beqz	a1,7d4 <vprintf+0x1b6>
          putc(fd, *s);
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	dc6080e7          	jalr	-570(ra) # 54e <putc>
          s++;
 790:	0485                	addi	s1,s1,1
        while(*s != 0){
 792:	0004c583          	lbu	a1,0(s1)
 796:	f9e5                	bnez	a1,786 <vprintf+0x168>
        s = va_arg(ap, char*);
 798:	8b4e                	mv	s6,s3
      state = 0;
 79a:	4981                	li	s3,0
 79c:	b5cd                	j	67e <vprintf+0x60>
          s = "(null)";
 79e:	00000497          	auipc	s1,0x0
 7a2:	28248493          	addi	s1,s1,642 # a20 <digits+0x18>
        while(*s != 0){
 7a6:	02800593          	li	a1,40
 7aa:	bff1                	j	786 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7ac:	008b0493          	addi	s1,s6,8
 7b0:	000b4583          	lbu	a1,0(s6)
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	d98080e7          	jalr	-616(ra) # 54e <putc>
 7be:	8b26                	mv	s6,s1
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	bd75                	j	67e <vprintf+0x60>
        putc(fd, c);
 7c4:	85d2                	mv	a1,s4
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	d86080e7          	jalr	-634(ra) # 54e <putc>
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	b575                	j	67e <vprintf+0x60>
        s = va_arg(ap, char*);
 7d4:	8b4e                	mv	s6,s3
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	b55d                	j	67e <vprintf+0x60>
    }
  }
}
 7da:	70e6                	ld	ra,120(sp)
 7dc:	7446                	ld	s0,112(sp)
 7de:	74a6                	ld	s1,104(sp)
 7e0:	7906                	ld	s2,96(sp)
 7e2:	69e6                	ld	s3,88(sp)
 7e4:	6a46                	ld	s4,80(sp)
 7e6:	6aa6                	ld	s5,72(sp)
 7e8:	6b06                	ld	s6,64(sp)
 7ea:	7be2                	ld	s7,56(sp)
 7ec:	7c42                	ld	s8,48(sp)
 7ee:	7ca2                	ld	s9,40(sp)
 7f0:	7d02                	ld	s10,32(sp)
 7f2:	6de2                	ld	s11,24(sp)
 7f4:	6109                	addi	sp,sp,128
 7f6:	8082                	ret

00000000000007f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f8:	715d                	addi	sp,sp,-80
 7fa:	ec06                	sd	ra,24(sp)
 7fc:	e822                	sd	s0,16(sp)
 7fe:	1000                	addi	s0,sp,32
 800:	e010                	sd	a2,0(s0)
 802:	e414                	sd	a3,8(s0)
 804:	e818                	sd	a4,16(s0)
 806:	ec1c                	sd	a5,24(s0)
 808:	03043023          	sd	a6,32(s0)
 80c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 810:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 814:	8622                	mv	a2,s0
 816:	00000097          	auipc	ra,0x0
 81a:	e08080e7          	jalr	-504(ra) # 61e <vprintf>
}
 81e:	60e2                	ld	ra,24(sp)
 820:	6442                	ld	s0,16(sp)
 822:	6161                	addi	sp,sp,80
 824:	8082                	ret

0000000000000826 <printf>:

void
printf(const char *fmt, ...)
{
 826:	711d                	addi	sp,sp,-96
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	e40c                	sd	a1,8(s0)
 830:	e810                	sd	a2,16(s0)
 832:	ec14                	sd	a3,24(s0)
 834:	f018                	sd	a4,32(s0)
 836:	f41c                	sd	a5,40(s0)
 838:	03043823          	sd	a6,48(s0)
 83c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 840:	00840613          	addi	a2,s0,8
 844:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 848:	85aa                	mv	a1,a0
 84a:	4505                	li	a0,1
 84c:	00000097          	auipc	ra,0x0
 850:	dd2080e7          	jalr	-558(ra) # 61e <vprintf>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6125                	addi	sp,sp,96
 85a:	8082                	ret

000000000000085c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85c:	1141                	addi	sp,sp,-16
 85e:	e422                	sd	s0,8(sp)
 860:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 862:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 866:	00000797          	auipc	a5,0x0
 86a:	1c278793          	addi	a5,a5,450 # a28 <__bss_start>
 86e:	639c                	ld	a5,0(a5)
 870:	a805                	j	8a0 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 872:	4618                	lw	a4,8(a2)
 874:	9db9                	addw	a1,a1,a4
 876:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87a:	6398                	ld	a4,0(a5)
 87c:	6318                	ld	a4,0(a4)
 87e:	fee53823          	sd	a4,-16(a0)
 882:	a091                	j	8c6 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 884:	ff852703          	lw	a4,-8(a0)
 888:	9e39                	addw	a2,a2,a4
 88a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 88c:	ff053703          	ld	a4,-16(a0)
 890:	e398                	sd	a4,0(a5)
 892:	a099                	j	8d8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 894:	6398                	ld	a4,0(a5)
 896:	00e7e463          	bltu	a5,a4,89e <free+0x42>
 89a:	00e6ea63          	bltu	a3,a4,8ae <free+0x52>
{
 89e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a0:	fed7fae3          	bleu	a3,a5,894 <free+0x38>
 8a4:	6398                	ld	a4,0(a5)
 8a6:	00e6e463          	bltu	a3,a4,8ae <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8aa:	fee7eae3          	bltu	a5,a4,89e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8ae:	ff852583          	lw	a1,-8(a0)
 8b2:	6390                	ld	a2,0(a5)
 8b4:	02059713          	slli	a4,a1,0x20
 8b8:	9301                	srli	a4,a4,0x20
 8ba:	0712                	slli	a4,a4,0x4
 8bc:	9736                	add	a4,a4,a3
 8be:	fae60ae3          	beq	a2,a4,872 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c6:	4790                	lw	a2,8(a5)
 8c8:	02061713          	slli	a4,a2,0x20
 8cc:	9301                	srli	a4,a4,0x20
 8ce:	0712                	slli	a4,a4,0x4
 8d0:	973e                	add	a4,a4,a5
 8d2:	fae689e3          	beq	a3,a4,884 <free+0x28>
  } else
    p->s.ptr = bp;
 8d6:	e394                	sd	a3,0(a5)
  freep = p;
 8d8:	00000717          	auipc	a4,0x0
 8dc:	14f73823          	sd	a5,336(a4) # a28 <__bss_start>
}
 8e0:	6422                	ld	s0,8(sp)
 8e2:	0141                	addi	sp,sp,16
 8e4:	8082                	ret

00000000000008e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e6:	7139                	addi	sp,sp,-64
 8e8:	fc06                	sd	ra,56(sp)
 8ea:	f822                	sd	s0,48(sp)
 8ec:	f426                	sd	s1,40(sp)
 8ee:	f04a                	sd	s2,32(sp)
 8f0:	ec4e                	sd	s3,24(sp)
 8f2:	e852                	sd	s4,16(sp)
 8f4:	e456                	sd	s5,8(sp)
 8f6:	e05a                	sd	s6,0(sp)
 8f8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fa:	02051993          	slli	s3,a0,0x20
 8fe:	0209d993          	srli	s3,s3,0x20
 902:	09bd                	addi	s3,s3,15
 904:	0049d993          	srli	s3,s3,0x4
 908:	2985                	addiw	s3,s3,1
 90a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 90e:	00000797          	auipc	a5,0x0
 912:	11a78793          	addi	a5,a5,282 # a28 <__bss_start>
 916:	6388                	ld	a0,0(a5)
 918:	c515                	beqz	a0,944 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91c:	4798                	lw	a4,8(a5)
 91e:	03277f63          	bleu	s2,a4,95c <malloc+0x76>
 922:	8a4e                	mv	s4,s3
 924:	0009871b          	sext.w	a4,s3
 928:	6685                	lui	a3,0x1
 92a:	00d77363          	bleu	a3,a4,930 <malloc+0x4a>
 92e:	6a05                	lui	s4,0x1
 930:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 934:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 938:	00000497          	auipc	s1,0x0
 93c:	0f048493          	addi	s1,s1,240 # a28 <__bss_start>
  if(p == (char*)-1)
 940:	5b7d                	li	s6,-1
 942:	a885                	j	9b2 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 944:	00000797          	auipc	a5,0x0
 948:	4ec78793          	addi	a5,a5,1260 # e30 <base>
 94c:	00000717          	auipc	a4,0x0
 950:	0cf73e23          	sd	a5,220(a4) # a28 <__bss_start>
 954:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 956:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 95a:	b7e1                	j	922 <malloc+0x3c>
      if(p->s.size == nunits)
 95c:	02e90b63          	beq	s2,a4,992 <malloc+0xac>
        p->s.size -= nunits;
 960:	4137073b          	subw	a4,a4,s3
 964:	c798                	sw	a4,8(a5)
        p += p->s.size;
 966:	1702                	slli	a4,a4,0x20
 968:	9301                	srli	a4,a4,0x20
 96a:	0712                	slli	a4,a4,0x4
 96c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 972:	00000717          	auipc	a4,0x0
 976:	0aa73b23          	sd	a0,182(a4) # a28 <__bss_start>
      return (void*)(p + 1);
 97a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97e:	70e2                	ld	ra,56(sp)
 980:	7442                	ld	s0,48(sp)
 982:	74a2                	ld	s1,40(sp)
 984:	7902                	ld	s2,32(sp)
 986:	69e2                	ld	s3,24(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	6121                	addi	sp,sp,64
 990:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	e118                	sd	a4,0(a0)
 996:	bff1                	j	972 <malloc+0x8c>
  hp->s.size = nu;
 998:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 99c:	0541                	addi	a0,a0,16
 99e:	00000097          	auipc	ra,0x0
 9a2:	ebe080e7          	jalr	-322(ra) # 85c <free>
  return freep;
 9a6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9a8:	d979                	beqz	a0,97e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ac:	4798                	lw	a4,8(a5)
 9ae:	fb2777e3          	bleu	s2,a4,95c <malloc+0x76>
    if(p == freep)
 9b2:	6098                	ld	a4,0(s1)
 9b4:	853e                	mv	a0,a5
 9b6:	fef71ae3          	bne	a4,a5,9aa <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9ba:	8552                	mv	a0,s4
 9bc:	00000097          	auipc	ra,0x0
 9c0:	b7a080e7          	jalr	-1158(ra) # 536 <sbrk>
  if(p == (char*)-1)
 9c4:	fd651ae3          	bne	a0,s6,998 <malloc+0xb2>
        return 0;
 9c8:	4501                	li	a0,0
 9ca:	bf55                	j	97e <malloc+0x98>
