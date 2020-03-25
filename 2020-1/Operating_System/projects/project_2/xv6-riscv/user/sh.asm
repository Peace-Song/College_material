
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	2a058593          	addi	a1,a1,672 # 12b0 <malloc+0x11a>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	08e080e7          	jalr	142(ra) # 10a8 <fprintf>
  memset(buf, 0, nbuf);
      22:	864a                	mv	a2,s2
      24:	4581                	li	a1,0
      26:	8526                	mv	a0,s1
      28:	00001097          	auipc	ra,0x1
      2c:	bac080e7          	jalr	-1108(ra) # bd4 <memset>
  gets(buf, nbuf);
      30:	85ca                	mv	a1,s2
      32:	8526                	mv	a0,s1
      34:	00001097          	auipc	ra,0x1
      38:	bf0080e7          	jalr	-1040(ra) # c24 <gets>
  if(buf[0] == 0) // EOF
      3c:	0004c503          	lbu	a0,0(s1)
      40:	00153513          	seqz	a0,a0
      44:	40a0053b          	negw	a0,a0
    return -1;
  return 0;
}
      48:	2501                	sext.w	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
  exit(0);
}

void
panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
  fprintf(2, "%s\n", s);
      5e:	862a                	mv	a2,a0
      60:	00001597          	auipc	a1,0x1
      64:	25858593          	addi	a1,a1,600 # 12b8 <malloc+0x122>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	03e080e7          	jalr	62(ra) # 10a8 <fprintf>
  exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	cea080e7          	jalr	-790(ra) # d5e <exit>

000000000000007c <fork1>:
}

int
fork1(void)
{
      7c:	1141                	addi	sp,sp,-16
      7e:	e406                	sd	ra,8(sp)
      80:	e022                	sd	s0,0(sp)
      82:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	cd2080e7          	jalr	-814(ra) # d56 <fork>
  if(pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
    panic("fork");
  return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	addi	sp,sp,16
      98:	8082                	ret
    panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	22650513          	addi	a0,a0,550 # 12c0 <malloc+0x12a>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f406                	sd	ra,40(sp)
      ae:	f022                	sd	s0,32(sp)
      b0:	ec26                	sd	s1,24(sp)
      b2:	1800                	addi	s0,sp,48
  if(cmd == 0)
      b4:	c10d                	beqz	a0,d6 <runcmd+0x2c>
      b6:	84aa                	mv	s1,a0
  switch(cmd->type){
      b8:	4118                	lw	a4,0(a0)
      ba:	4795                	li	a5,5
      bc:	02e7e263          	bltu	a5,a4,e0 <runcmd+0x36>
      c0:	00056783          	lwu	a5,0(a0)
      c4:	078a                	slli	a5,a5,0x2
      c6:	00001717          	auipc	a4,0x1
      ca:	1ba70713          	addi	a4,a4,442 # 1280 <malloc+0xea>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	c86080e7          	jalr	-890(ra) # d5e <exit>
    panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	1e850513          	addi	a0,a0,488 # 12c8 <malloc+0x132>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	c9e080e7          	jalr	-866(ra) # d96 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	1ce58593          	addi	a1,a1,462 # 12d0 <malloc+0x13a>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	f9c080e7          	jalr	-100(ra) # 10a8 <fprintf>
  exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	c48080e7          	jalr	-952(ra) # d5e <exit>
      exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	c3e080e7          	jalr	-962(ra) # d5e <exit>
    close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	c5c080e7          	jalr	-932(ra) # d86 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	c68080e7          	jalr	-920(ra) # d9e <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
    runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	19258593          	addi	a1,a1,402 # 12e0 <malloc+0x14a>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	f50080e7          	jalr	-176(ra) # 10a8 <fprintf>
      exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	bfc080e7          	jalr	-1028(ra) # d5e <exit>
    if(fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f12080e7          	jalr	-238(ra) # 7c <fork1>
     172:	c919                	beqz	a0,188 <runcmd+0xde>
    wait(0);
     174:	4501                	li	a0,0
     176:	00001097          	auipc	ra,0x1
     17a:	bf0080e7          	jalr	-1040(ra) # d66 <wait>
    runcmd(lcmd->right);
     17e:	6888                	ld	a0,16(s1)
     180:	00000097          	auipc	ra,0x0
     184:	f2a080e7          	jalr	-214(ra) # aa <runcmd>
      runcmd(lcmd->left);
     188:	6488                	ld	a0,8(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
    if(pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	bd8080e7          	jalr	-1064(ra) # d6e <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
    if(fork1() == 0){
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	c529                	beqz	a0,1f4 <runcmd+0x14a>
    if(fork1() == 0){
     1ac:	00000097          	auipc	ra,0x0
     1b0:	ed0080e7          	jalr	-304(ra) # 7c <fork1>
     1b4:	cd25                	beqz	a0,22c <runcmd+0x182>
    close(p[0]);
     1b6:	fd842503          	lw	a0,-40(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	bcc080e7          	jalr	-1076(ra) # d86 <close>
    close(p[1]);
     1c2:	fdc42503          	lw	a0,-36(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	bc0080e7          	jalr	-1088(ra) # d86 <close>
    wait(0);
     1ce:	4501                	li	a0,0
     1d0:	00001097          	auipc	ra,0x1
     1d4:	b96080e7          	jalr	-1130(ra) # d66 <wait>
    wait(0);
     1d8:	4501                	li	a0,0
     1da:	00001097          	auipc	ra,0x1
     1de:	b8c080e7          	jalr	-1140(ra) # d66 <wait>
    break;
     1e2:	bf0d                	j	114 <runcmd+0x6a>
      panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	10c50513          	addi	a0,a0,268 # 12f0 <malloc+0x15a>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
      close(1);
     1f4:	4505                	li	a0,1
     1f6:	00001097          	auipc	ra,0x1
     1fa:	b90080e7          	jalr	-1136(ra) # d86 <close>
      dup(p[1]);
     1fe:	fdc42503          	lw	a0,-36(s0)
     202:	00001097          	auipc	ra,0x1
     206:	bd4080e7          	jalr	-1068(ra) # dd6 <dup>
      close(p[0]);
     20a:	fd842503          	lw	a0,-40(s0)
     20e:	00001097          	auipc	ra,0x1
     212:	b78080e7          	jalr	-1160(ra) # d86 <close>
      close(p[1]);
     216:	fdc42503          	lw	a0,-36(s0)
     21a:	00001097          	auipc	ra,0x1
     21e:	b6c080e7          	jalr	-1172(ra) # d86 <close>
      runcmd(pcmd->left);
     222:	6488                	ld	a0,8(s1)
     224:	00000097          	auipc	ra,0x0
     228:	e86080e7          	jalr	-378(ra) # aa <runcmd>
      close(0);
     22c:	00001097          	auipc	ra,0x1
     230:	b5a080e7          	jalr	-1190(ra) # d86 <close>
      dup(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	b9e080e7          	jalr	-1122(ra) # dd6 <dup>
      close(p[0]);
     240:	fd842503          	lw	a0,-40(s0)
     244:	00001097          	auipc	ra,0x1
     248:	b42080e7          	jalr	-1214(ra) # d86 <close>
      close(p[1]);
     24c:	fdc42503          	lw	a0,-36(s0)
     250:	00001097          	auipc	ra,0x1
     254:	b36080e7          	jalr	-1226(ra) # d86 <close>
      runcmd(pcmd->right);
     258:	6888                	ld	a0,16(s1)
     25a:	00000097          	auipc	ra,0x0
     25e:	e50080e7          	jalr	-432(ra) # aa <runcmd>
    if(fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e1a080e7          	jalr	-486(ra) # 7c <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6a>
      runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e3a080e7          	jalr	-454(ra) # aa <runcmd>

0000000000000278 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     278:	1101                	addi	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	f10080e7          	jalr	-240(ra) # 1196 <malloc>
     28e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	93e080e7          	jalr	-1730(ra) # bd4 <memset>
  cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	addi	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	addi	s0,sp,64
     2c2:	8b2a                	mv	s6,a0
     2c4:	8aae                	mv	s5,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	89b6                	mv	s3,a3
     2ca:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	ec6080e7          	jalr	-314(ra) # 1196 <malloc>
     2d8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	8f4080e7          	jalr	-1804(ra) # bd4 <memset>
  cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2ec:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2f0:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     2f8:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     2fc:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	addi	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	addi	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	addi	s0,sp,48
     324:	89aa                	mv	s3,a0
     326:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	e6c080e7          	jalr	-404(ra) # 1196 <malloc>
     332:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	89c080e7          	jalr	-1892(ra) # bd4 <memset>
  cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     344:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     348:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	addi	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	addi	s0,sp,48
     36a:	89aa                	mv	s3,a0
     36c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	e26080e7          	jalr	-474(ra) # 1196 <malloc>
     378:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	856080e7          	jalr	-1962(ra) # bd4 <memset>
  cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     38a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     38e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	de4080e7          	jalr	-540(ra) # 1196 <malloc>
     3ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	814080e7          	jalr	-2028(ra) # bd4 <memset>
  cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	addi	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	addi	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     3fa:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     3fc:	00001997          	auipc	s3,0x1
     400:	fec98993          	addi	s3,s3,-20 # 13e8 <whitespace>
     404:	00b4fd63          	bleu	a1,s1,41e <gettoken+0x40>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00000097          	auipc	ra,0x0
     412:	7ec080e7          	jalr	2028(ra) # bfa <strchr>
     416:	c501                	beqz	a0,41e <gettoken+0x40>
    s++;
     418:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
  if(q)
     41e:	000a8463          	beqz	s5,426 <gettoken+0x48>
    *q = s;
     422:	009ab023          	sd	s1,0(s5)
  ret = *s;
     426:	0004c783          	lbu	a5,0(s1)
     42a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     42e:	02900713          	li	a4,41
     432:	08f76f63          	bltu	a4,a5,4d0 <gettoken+0xf2>
     436:	02800713          	li	a4,40
     43a:	0ae7f863          	bleu	a4,a5,4ea <gettoken+0x10c>
     43e:	e3b9                	bnez	a5,484 <gettoken+0xa6>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     440:	000b0463          	beqz	s6,448 <gettoken+0x6a>
    *eq = s;
     444:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     448:	00001997          	auipc	s3,0x1
     44c:	fa098993          	addi	s3,s3,-96 # 13e8 <whitespace>
     450:	0124fd63          	bleu	s2,s1,46a <gettoken+0x8c>
     454:	0004c583          	lbu	a1,0(s1)
     458:	854e                	mv	a0,s3
     45a:	00000097          	auipc	ra,0x0
     45e:	7a0080e7          	jalr	1952(ra) # bfa <strchr>
     462:	c501                	beqz	a0,46a <gettoken+0x8c>
    s++;
     464:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     466:	fe9917e3          	bne	s2,s1,454 <gettoken+0x76>
  *ps = s;
     46a:	009a3023          	sd	s1,0(s4)
  return ret;
}
     46e:	8556                	mv	a0,s5
     470:	70e2                	ld	ra,56(sp)
     472:	7442                	ld	s0,48(sp)
     474:	74a2                	ld	s1,40(sp)
     476:	7902                	ld	s2,32(sp)
     478:	69e2                	ld	s3,24(sp)
     47a:	6a42                	ld	s4,16(sp)
     47c:	6aa2                	ld	s5,8(sp)
     47e:	6b02                	ld	s6,0(sp)
     480:	6121                	addi	sp,sp,64
     482:	8082                	ret
  switch(*s){
     484:	02600713          	li	a4,38
     488:	06e78163          	beq	a5,a4,4ea <gettoken+0x10c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     48c:	00001997          	auipc	s3,0x1
     490:	f5c98993          	addi	s3,s3,-164 # 13e8 <whitespace>
     494:	00001a97          	auipc	s5,0x1
     498:	f4ca8a93          	addi	s5,s5,-180 # 13e0 <symbols>
     49c:	0324f563          	bleu	s2,s1,4c6 <gettoken+0xe8>
     4a0:	0004c583          	lbu	a1,0(s1)
     4a4:	854e                	mv	a0,s3
     4a6:	00000097          	auipc	ra,0x0
     4aa:	754080e7          	jalr	1876(ra) # bfa <strchr>
     4ae:	e53d                	bnez	a0,51c <gettoken+0x13e>
     4b0:	0004c583          	lbu	a1,0(s1)
     4b4:	8556                	mv	a0,s5
     4b6:	00000097          	auipc	ra,0x0
     4ba:	744080e7          	jalr	1860(ra) # bfa <strchr>
     4be:	ed21                	bnez	a0,516 <gettoken+0x138>
      s++;
     4c0:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4c2:	fc991fe3          	bne	s2,s1,4a0 <gettoken+0xc2>
  if(eq)
     4c6:	06100a93          	li	s5,97
     4ca:	f60b1de3          	bnez	s6,444 <gettoken+0x66>
     4ce:	bf71                	j	46a <gettoken+0x8c>
  switch(*s){
     4d0:	03e00713          	li	a4,62
     4d4:	02e78263          	beq	a5,a4,4f8 <gettoken+0x11a>
     4d8:	00f76b63          	bltu	a4,a5,4ee <gettoken+0x110>
     4dc:	fc57879b          	addiw	a5,a5,-59
     4e0:	0ff7f793          	andi	a5,a5,255
     4e4:	4705                	li	a4,1
     4e6:	faf763e3          	bltu	a4,a5,48c <gettoken+0xae>
    s++;
     4ea:	0485                	addi	s1,s1,1
    break;
     4ec:	bf91                	j	440 <gettoken+0x62>
  switch(*s){
     4ee:	07c00713          	li	a4,124
     4f2:	fee78ce3          	beq	a5,a4,4ea <gettoken+0x10c>
     4f6:	bf59                	j	48c <gettoken+0xae>
    s++;
     4f8:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     4fc:	0014c703          	lbu	a4,1(s1)
     500:	03e00793          	li	a5,62
      s++;
     504:	0489                	addi	s1,s1,2
      ret = '+';
     506:	02b00a93          	li	s5,43
    if(*s == '>'){
     50a:	f2f70be3          	beq	a4,a5,440 <gettoken+0x62>
    s++;
     50e:	84b6                	mv	s1,a3
  ret = *s;
     510:	03e00a93          	li	s5,62
     514:	b735                	j	440 <gettoken+0x62>
    ret = 'a';
     516:	06100a93          	li	s5,97
     51a:	b71d                	j	440 <gettoken+0x62>
     51c:	06100a93          	li	s5,97
     520:	b705                	j	440 <gettoken+0x62>

0000000000000522 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     522:	7139                	addi	sp,sp,-64
     524:	fc06                	sd	ra,56(sp)
     526:	f822                	sd	s0,48(sp)
     528:	f426                	sd	s1,40(sp)
     52a:	f04a                	sd	s2,32(sp)
     52c:	ec4e                	sd	s3,24(sp)
     52e:	e852                	sd	s4,16(sp)
     530:	e456                	sd	s5,8(sp)
     532:	0080                	addi	s0,sp,64
     534:	8a2a                	mv	s4,a0
     536:	892e                	mv	s2,a1
     538:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     53a:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     53c:	00001997          	auipc	s3,0x1
     540:	eac98993          	addi	s3,s3,-340 # 13e8 <whitespace>
     544:	00b4fd63          	bleu	a1,s1,55e <peek+0x3c>
     548:	0004c583          	lbu	a1,0(s1)
     54c:	854e                	mv	a0,s3
     54e:	00000097          	auipc	ra,0x0
     552:	6ac080e7          	jalr	1708(ra) # bfa <strchr>
     556:	c501                	beqz	a0,55e <peek+0x3c>
    s++;
     558:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     55a:	fe9917e3          	bne	s2,s1,548 <peek+0x26>
  *ps = s;
     55e:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     562:	0004c583          	lbu	a1,0(s1)
     566:	4501                	li	a0,0
     568:	e991                	bnez	a1,57c <peek+0x5a>
}
     56a:	70e2                	ld	ra,56(sp)
     56c:	7442                	ld	s0,48(sp)
     56e:	74a2                	ld	s1,40(sp)
     570:	7902                	ld	s2,32(sp)
     572:	69e2                	ld	s3,24(sp)
     574:	6a42                	ld	s4,16(sp)
     576:	6aa2                	ld	s5,8(sp)
     578:	6121                	addi	sp,sp,64
     57a:	8082                	ret
  return *s && strchr(toks, *s);
     57c:	8556                	mv	a0,s5
     57e:	00000097          	auipc	ra,0x0
     582:	67c080e7          	jalr	1660(ra) # bfa <strchr>
     586:	00a03533          	snez	a0,a0
     58a:	b7c5                	j	56a <peek+0x48>

000000000000058c <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     58c:	7159                	addi	sp,sp,-112
     58e:	f486                	sd	ra,104(sp)
     590:	f0a2                	sd	s0,96(sp)
     592:	eca6                	sd	s1,88(sp)
     594:	e8ca                	sd	s2,80(sp)
     596:	e4ce                	sd	s3,72(sp)
     598:	e0d2                	sd	s4,64(sp)
     59a:	fc56                	sd	s5,56(sp)
     59c:	f85a                	sd	s6,48(sp)
     59e:	f45e                	sd	s7,40(sp)
     5a0:	f062                	sd	s8,32(sp)
     5a2:	ec66                	sd	s9,24(sp)
     5a4:	1880                	addi	s0,sp,112
     5a6:	8b2a                	mv	s6,a0
     5a8:	89ae                	mv	s3,a1
     5aa:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5ac:	00001b97          	auipc	s7,0x1
     5b0:	d6cb8b93          	addi	s7,s7,-660 # 1318 <malloc+0x182>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5b4:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5b8:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5bc:	a02d                	j	5e6 <parseredirs+0x5a>
      panic("missing file for redirection");
     5be:	00001517          	auipc	a0,0x1
     5c2:	d3a50513          	addi	a0,a0,-710 # 12f8 <malloc+0x162>
     5c6:	00000097          	auipc	ra,0x0
     5ca:	a90080e7          	jalr	-1392(ra) # 56 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5ce:	4701                	li	a4,0
     5d0:	4681                	li	a3,0
     5d2:	f9043603          	ld	a2,-112(s0)
     5d6:	f9843583          	ld	a1,-104(s0)
     5da:	855a                	mv	a0,s6
     5dc:	00000097          	auipc	ra,0x0
     5e0:	cd2080e7          	jalr	-814(ra) # 2ae <redircmd>
     5e4:	8b2a                	mv	s6,a0
    switch(tok){
     5e6:	03e00a93          	li	s5,62
     5ea:	02b00a13          	li	s4,43
  while(peek(ps, es, "<>")){
     5ee:	865e                	mv	a2,s7
     5f0:	85ca                	mv	a1,s2
     5f2:	854e                	mv	a0,s3
     5f4:	00000097          	auipc	ra,0x0
     5f8:	f2e080e7          	jalr	-210(ra) # 522 <peek>
     5fc:	c925                	beqz	a0,66c <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     5fe:	4681                	li	a3,0
     600:	4601                	li	a2,0
     602:	85ca                	mv	a1,s2
     604:	854e                	mv	a0,s3
     606:	00000097          	auipc	ra,0x0
     60a:	dd8080e7          	jalr	-552(ra) # 3de <gettoken>
     60e:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     610:	f9040693          	addi	a3,s0,-112
     614:	f9840613          	addi	a2,s0,-104
     618:	85ca                	mv	a1,s2
     61a:	854e                	mv	a0,s3
     61c:	00000097          	auipc	ra,0x0
     620:	dc2080e7          	jalr	-574(ra) # 3de <gettoken>
     624:	f9851de3          	bne	a0,s8,5be <parseredirs+0x32>
    switch(tok){
     628:	fb9483e3          	beq	s1,s9,5ce <parseredirs+0x42>
     62c:	03548263          	beq	s1,s5,650 <parseredirs+0xc4>
     630:	fb449fe3          	bne	s1,s4,5ee <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     634:	4705                	li	a4,1
     636:	20100693          	li	a3,513
     63a:	f9043603          	ld	a2,-112(s0)
     63e:	f9843583          	ld	a1,-104(s0)
     642:	855a                	mv	a0,s6
     644:	00000097          	auipc	ra,0x0
     648:	c6a080e7          	jalr	-918(ra) # 2ae <redircmd>
     64c:	8b2a                	mv	s6,a0
      break;
     64e:	bf61                	j	5e6 <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     650:	4705                	li	a4,1
     652:	20100693          	li	a3,513
     656:	f9043603          	ld	a2,-112(s0)
     65a:	f9843583          	ld	a1,-104(s0)
     65e:	855a                	mv	a0,s6
     660:	00000097          	auipc	ra,0x0
     664:	c4e080e7          	jalr	-946(ra) # 2ae <redircmd>
     668:	8b2a                	mv	s6,a0
      break;
     66a:	bfb5                	j	5e6 <parseredirs+0x5a>
    }
  }
  return cmd;
}
     66c:	855a                	mv	a0,s6
     66e:	70a6                	ld	ra,104(sp)
     670:	7406                	ld	s0,96(sp)
     672:	64e6                	ld	s1,88(sp)
     674:	6946                	ld	s2,80(sp)
     676:	69a6                	ld	s3,72(sp)
     678:	6a06                	ld	s4,64(sp)
     67a:	7ae2                	ld	s5,56(sp)
     67c:	7b42                	ld	s6,48(sp)
     67e:	7ba2                	ld	s7,40(sp)
     680:	7c02                	ld	s8,32(sp)
     682:	6ce2                	ld	s9,24(sp)
     684:	6165                	addi	sp,sp,112
     686:	8082                	ret

0000000000000688 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     688:	7159                	addi	sp,sp,-112
     68a:	f486                	sd	ra,104(sp)
     68c:	f0a2                	sd	s0,96(sp)
     68e:	eca6                	sd	s1,88(sp)
     690:	e8ca                	sd	s2,80(sp)
     692:	e4ce                	sd	s3,72(sp)
     694:	e0d2                	sd	s4,64(sp)
     696:	fc56                	sd	s5,56(sp)
     698:	f85a                	sd	s6,48(sp)
     69a:	f45e                	sd	s7,40(sp)
     69c:	f062                	sd	s8,32(sp)
     69e:	ec66                	sd	s9,24(sp)
     6a0:	1880                	addi	s0,sp,112
     6a2:	89aa                	mv	s3,a0
     6a4:	8a2e                	mv	s4,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6a6:	00001617          	auipc	a2,0x1
     6aa:	c7a60613          	addi	a2,a2,-902 # 1320 <malloc+0x18a>
     6ae:	00000097          	auipc	ra,0x0
     6b2:	e74080e7          	jalr	-396(ra) # 522 <peek>
     6b6:	e905                	bnez	a0,6e6 <parseexec+0x5e>
     6b8:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     6ba:	00000097          	auipc	ra,0x0
     6be:	bbe080e7          	jalr	-1090(ra) # 278 <execcmd>
     6c2:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6c4:	8652                	mv	a2,s4
     6c6:	85ce                	mv	a1,s3
     6c8:	00000097          	auipc	ra,0x0
     6cc:	ec4080e7          	jalr	-316(ra) # 58c <parseredirs>
     6d0:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     6d2:	008c0493          	addi	s1,s8,8
     6d6:	00001b17          	auipc	s6,0x1
     6da:	c6ab0b13          	addi	s6,s6,-918 # 1340 <malloc+0x1aa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6de:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6e2:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6e4:	a0b1                	j	730 <parseexec+0xa8>
    return parseblock(ps, es);
     6e6:	85d2                	mv	a1,s4
     6e8:	854e                	mv	a0,s3
     6ea:	00000097          	auipc	ra,0x0
     6ee:	1b8080e7          	jalr	440(ra) # 8a2 <parseblock>
     6f2:	8aaa                	mv	s5,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6f4:	8556                	mv	a0,s5
     6f6:	70a6                	ld	ra,104(sp)
     6f8:	7406                	ld	s0,96(sp)
     6fa:	64e6                	ld	s1,88(sp)
     6fc:	6946                	ld	s2,80(sp)
     6fe:	69a6                	ld	s3,72(sp)
     700:	6a06                	ld	s4,64(sp)
     702:	7ae2                	ld	s5,56(sp)
     704:	7b42                	ld	s6,48(sp)
     706:	7ba2                	ld	s7,40(sp)
     708:	7c02                	ld	s8,32(sp)
     70a:	6ce2                	ld	s9,24(sp)
     70c:	6165                	addi	sp,sp,112
     70e:	8082                	ret
      panic("syntax");
     710:	00001517          	auipc	a0,0x1
     714:	c1850513          	addi	a0,a0,-1000 # 1328 <malloc+0x192>
     718:	00000097          	auipc	ra,0x0
     71c:	93e080e7          	jalr	-1730(ra) # 56 <panic>
    ret = parseredirs(ret, ps, es);
     720:	8652                	mv	a2,s4
     722:	85ce                	mv	a1,s3
     724:	8556                	mv	a0,s5
     726:	00000097          	auipc	ra,0x0
     72a:	e66080e7          	jalr	-410(ra) # 58c <parseredirs>
     72e:	8aaa                	mv	s5,a0
  while(!peek(ps, es, "|)&;")){
     730:	865a                	mv	a2,s6
     732:	85d2                	mv	a1,s4
     734:	854e                	mv	a0,s3
     736:	00000097          	auipc	ra,0x0
     73a:	dec080e7          	jalr	-532(ra) # 522 <peek>
     73e:	e121                	bnez	a0,77e <parseexec+0xf6>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     740:	f9040693          	addi	a3,s0,-112
     744:	f9840613          	addi	a2,s0,-104
     748:	85d2                	mv	a1,s4
     74a:	854e                	mv	a0,s3
     74c:	00000097          	auipc	ra,0x0
     750:	c92080e7          	jalr	-878(ra) # 3de <gettoken>
     754:	c50d                	beqz	a0,77e <parseexec+0xf6>
    if(tok != 'a')
     756:	fb951de3          	bne	a0,s9,710 <parseexec+0x88>
    cmd->argv[argc] = q;
     75a:	f9843783          	ld	a5,-104(s0)
     75e:	e09c                	sd	a5,0(s1)
    cmd->eargv[argc] = eq;
     760:	f9043783          	ld	a5,-112(s0)
     764:	e8bc                	sd	a5,80(s1)
    argc++;
     766:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     768:	04a1                	addi	s1,s1,8
     76a:	fb791be3          	bne	s2,s7,720 <parseexec+0x98>
      panic("too many args");
     76e:	00001517          	auipc	a0,0x1
     772:	bc250513          	addi	a0,a0,-1086 # 1330 <malloc+0x19a>
     776:	00000097          	auipc	ra,0x0
     77a:	8e0080e7          	jalr	-1824(ra) # 56 <panic>
  cmd->argv[argc] = 0;
     77e:	090e                	slli	s2,s2,0x3
     780:	9962                	add	s2,s2,s8
     782:	00093423          	sd	zero,8(s2)
  cmd->eargv[argc] = 0;
     786:	04093c23          	sd	zero,88(s2)
  return ret;
     78a:	b7ad                	j	6f4 <parseexec+0x6c>

000000000000078c <parsepipe>:
{
     78c:	7179                	addi	sp,sp,-48
     78e:	f406                	sd	ra,40(sp)
     790:	f022                	sd	s0,32(sp)
     792:	ec26                	sd	s1,24(sp)
     794:	e84a                	sd	s2,16(sp)
     796:	e44e                	sd	s3,8(sp)
     798:	1800                	addi	s0,sp,48
     79a:	892a                	mv	s2,a0
     79c:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     79e:	00000097          	auipc	ra,0x0
     7a2:	eea080e7          	jalr	-278(ra) # 688 <parseexec>
     7a6:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7a8:	00001617          	auipc	a2,0x1
     7ac:	ba060613          	addi	a2,a2,-1120 # 1348 <malloc+0x1b2>
     7b0:	85ce                	mv	a1,s3
     7b2:	854a                	mv	a0,s2
     7b4:	00000097          	auipc	ra,0x0
     7b8:	d6e080e7          	jalr	-658(ra) # 522 <peek>
     7bc:	e909                	bnez	a0,7ce <parsepipe+0x42>
}
     7be:	8526                	mv	a0,s1
     7c0:	70a2                	ld	ra,40(sp)
     7c2:	7402                	ld	s0,32(sp)
     7c4:	64e2                	ld	s1,24(sp)
     7c6:	6942                	ld	s2,16(sp)
     7c8:	69a2                	ld	s3,8(sp)
     7ca:	6145                	addi	sp,sp,48
     7cc:	8082                	ret
    gettoken(ps, es, 0, 0);
     7ce:	4681                	li	a3,0
     7d0:	4601                	li	a2,0
     7d2:	85ce                	mv	a1,s3
     7d4:	854a                	mv	a0,s2
     7d6:	00000097          	auipc	ra,0x0
     7da:	c08080e7          	jalr	-1016(ra) # 3de <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7de:	85ce                	mv	a1,s3
     7e0:	854a                	mv	a0,s2
     7e2:	00000097          	auipc	ra,0x0
     7e6:	faa080e7          	jalr	-86(ra) # 78c <parsepipe>
     7ea:	85aa                	mv	a1,a0
     7ec:	8526                	mv	a0,s1
     7ee:	00000097          	auipc	ra,0x0
     7f2:	b28080e7          	jalr	-1240(ra) # 316 <pipecmd>
     7f6:	84aa                	mv	s1,a0
  return cmd;
     7f8:	b7d9                	j	7be <parsepipe+0x32>

00000000000007fa <parseline>:
{
     7fa:	7179                	addi	sp,sp,-48
     7fc:	f406                	sd	ra,40(sp)
     7fe:	f022                	sd	s0,32(sp)
     800:	ec26                	sd	s1,24(sp)
     802:	e84a                	sd	s2,16(sp)
     804:	e44e                	sd	s3,8(sp)
     806:	e052                	sd	s4,0(sp)
     808:	1800                	addi	s0,sp,48
     80a:	84aa                	mv	s1,a0
     80c:	892e                	mv	s2,a1
  cmd = parsepipe(ps, es);
     80e:	00000097          	auipc	ra,0x0
     812:	f7e080e7          	jalr	-130(ra) # 78c <parsepipe>
     816:	89aa                	mv	s3,a0
  while(peek(ps, es, "&")){
     818:	00001a17          	auipc	s4,0x1
     81c:	b38a0a13          	addi	s4,s4,-1224 # 1350 <malloc+0x1ba>
     820:	8652                	mv	a2,s4
     822:	85ca                	mv	a1,s2
     824:	8526                	mv	a0,s1
     826:	00000097          	auipc	ra,0x0
     82a:	cfc080e7          	jalr	-772(ra) # 522 <peek>
     82e:	c105                	beqz	a0,84e <parseline+0x54>
    gettoken(ps, es, 0, 0);
     830:	4681                	li	a3,0
     832:	4601                	li	a2,0
     834:	85ca                	mv	a1,s2
     836:	8526                	mv	a0,s1
     838:	00000097          	auipc	ra,0x0
     83c:	ba6080e7          	jalr	-1114(ra) # 3de <gettoken>
    cmd = backcmd(cmd);
     840:	854e                	mv	a0,s3
     842:	00000097          	auipc	ra,0x0
     846:	b60080e7          	jalr	-1184(ra) # 3a2 <backcmd>
     84a:	89aa                	mv	s3,a0
     84c:	bfd1                	j	820 <parseline+0x26>
  if(peek(ps, es, ";")){
     84e:	00001617          	auipc	a2,0x1
     852:	b0a60613          	addi	a2,a2,-1270 # 1358 <malloc+0x1c2>
     856:	85ca                	mv	a1,s2
     858:	8526                	mv	a0,s1
     85a:	00000097          	auipc	ra,0x0
     85e:	cc8080e7          	jalr	-824(ra) # 522 <peek>
     862:	e911                	bnez	a0,876 <parseline+0x7c>
}
     864:	854e                	mv	a0,s3
     866:	70a2                	ld	ra,40(sp)
     868:	7402                	ld	s0,32(sp)
     86a:	64e2                	ld	s1,24(sp)
     86c:	6942                	ld	s2,16(sp)
     86e:	69a2                	ld	s3,8(sp)
     870:	6a02                	ld	s4,0(sp)
     872:	6145                	addi	sp,sp,48
     874:	8082                	ret
    gettoken(ps, es, 0, 0);
     876:	4681                	li	a3,0
     878:	4601                	li	a2,0
     87a:	85ca                	mv	a1,s2
     87c:	8526                	mv	a0,s1
     87e:	00000097          	auipc	ra,0x0
     882:	b60080e7          	jalr	-1184(ra) # 3de <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     886:	85ca                	mv	a1,s2
     888:	8526                	mv	a0,s1
     88a:	00000097          	auipc	ra,0x0
     88e:	f70080e7          	jalr	-144(ra) # 7fa <parseline>
     892:	85aa                	mv	a1,a0
     894:	854e                	mv	a0,s3
     896:	00000097          	auipc	ra,0x0
     89a:	ac6080e7          	jalr	-1338(ra) # 35c <listcmd>
     89e:	89aa                	mv	s3,a0
  return cmd;
     8a0:	b7d1                	j	864 <parseline+0x6a>

00000000000008a2 <parseblock>:
{
     8a2:	7179                	addi	sp,sp,-48
     8a4:	f406                	sd	ra,40(sp)
     8a6:	f022                	sd	s0,32(sp)
     8a8:	ec26                	sd	s1,24(sp)
     8aa:	e84a                	sd	s2,16(sp)
     8ac:	e44e                	sd	s3,8(sp)
     8ae:	1800                	addi	s0,sp,48
     8b0:	84aa                	mv	s1,a0
     8b2:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8b4:	00001617          	auipc	a2,0x1
     8b8:	a6c60613          	addi	a2,a2,-1428 # 1320 <malloc+0x18a>
     8bc:	00000097          	auipc	ra,0x0
     8c0:	c66080e7          	jalr	-922(ra) # 522 <peek>
     8c4:	c12d                	beqz	a0,926 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8c6:	4681                	li	a3,0
     8c8:	4601                	li	a2,0
     8ca:	85ca                	mv	a1,s2
     8cc:	8526                	mv	a0,s1
     8ce:	00000097          	auipc	ra,0x0
     8d2:	b10080e7          	jalr	-1264(ra) # 3de <gettoken>
  cmd = parseline(ps, es);
     8d6:	85ca                	mv	a1,s2
     8d8:	8526                	mv	a0,s1
     8da:	00000097          	auipc	ra,0x0
     8de:	f20080e7          	jalr	-224(ra) # 7fa <parseline>
     8e2:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8e4:	00001617          	auipc	a2,0x1
     8e8:	a8c60613          	addi	a2,a2,-1396 # 1370 <malloc+0x1da>
     8ec:	85ca                	mv	a1,s2
     8ee:	8526                	mv	a0,s1
     8f0:	00000097          	auipc	ra,0x0
     8f4:	c32080e7          	jalr	-974(ra) # 522 <peek>
     8f8:	cd1d                	beqz	a0,936 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     8fa:	4681                	li	a3,0
     8fc:	4601                	li	a2,0
     8fe:	85ca                	mv	a1,s2
     900:	8526                	mv	a0,s1
     902:	00000097          	auipc	ra,0x0
     906:	adc080e7          	jalr	-1316(ra) # 3de <gettoken>
  cmd = parseredirs(cmd, ps, es);
     90a:	864a                	mv	a2,s2
     90c:	85a6                	mv	a1,s1
     90e:	854e                	mv	a0,s3
     910:	00000097          	auipc	ra,0x0
     914:	c7c080e7          	jalr	-900(ra) # 58c <parseredirs>
}
     918:	70a2                	ld	ra,40(sp)
     91a:	7402                	ld	s0,32(sp)
     91c:	64e2                	ld	s1,24(sp)
     91e:	6942                	ld	s2,16(sp)
     920:	69a2                	ld	s3,8(sp)
     922:	6145                	addi	sp,sp,48
     924:	8082                	ret
    panic("parseblock");
     926:	00001517          	auipc	a0,0x1
     92a:	a3a50513          	addi	a0,a0,-1478 # 1360 <malloc+0x1ca>
     92e:	fffff097          	auipc	ra,0xfffff
     932:	728080e7          	jalr	1832(ra) # 56 <panic>
    panic("syntax - missing )");
     936:	00001517          	auipc	a0,0x1
     93a:	a4250513          	addi	a0,a0,-1470 # 1378 <malloc+0x1e2>
     93e:	fffff097          	auipc	ra,0xfffff
     942:	718080e7          	jalr	1816(ra) # 56 <panic>

0000000000000946 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     946:	1101                	addi	sp,sp,-32
     948:	ec06                	sd	ra,24(sp)
     94a:	e822                	sd	s0,16(sp)
     94c:	e426                	sd	s1,8(sp)
     94e:	1000                	addi	s0,sp,32
     950:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     952:	c521                	beqz	a0,99a <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     954:	4118                	lw	a4,0(a0)
     956:	4795                	li	a5,5
     958:	04e7e163          	bltu	a5,a4,99a <nulterminate+0x54>
     95c:	00056783          	lwu	a5,0(a0)
     960:	078a                	slli	a5,a5,0x2
     962:	00001717          	auipc	a4,0x1
     966:	93670713          	addi	a4,a4,-1738 # 1298 <malloc+0x102>
     96a:	97ba                	add	a5,a5,a4
     96c:	439c                	lw	a5,0(a5)
     96e:	97ba                	add	a5,a5,a4
     970:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     972:	651c                	ld	a5,8(a0)
     974:	c39d                	beqz	a5,99a <nulterminate+0x54>
     976:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     97a:	67b8                	ld	a4,72(a5)
     97c:	00070023          	sb	zero,0(a4)
     980:	07a1                	addi	a5,a5,8
    for(i=0; ecmd->argv[i]; i++)
     982:	ff87b703          	ld	a4,-8(a5)
     986:	fb75                	bnez	a4,97a <nulterminate+0x34>
     988:	a809                	j	99a <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     98a:	6508                	ld	a0,8(a0)
     98c:	00000097          	auipc	ra,0x0
     990:	fba080e7          	jalr	-70(ra) # 946 <nulterminate>
    *rcmd->efile = 0;
     994:	6c9c                	ld	a5,24(s1)
     996:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     99a:	8526                	mv	a0,s1
     99c:	60e2                	ld	ra,24(sp)
     99e:	6442                	ld	s0,16(sp)
     9a0:	64a2                	ld	s1,8(sp)
     9a2:	6105                	addi	sp,sp,32
     9a4:	8082                	ret
    nulterminate(pcmd->left);
     9a6:	6508                	ld	a0,8(a0)
     9a8:	00000097          	auipc	ra,0x0
     9ac:	f9e080e7          	jalr	-98(ra) # 946 <nulterminate>
    nulterminate(pcmd->right);
     9b0:	6888                	ld	a0,16(s1)
     9b2:	00000097          	auipc	ra,0x0
     9b6:	f94080e7          	jalr	-108(ra) # 946 <nulterminate>
    break;
     9ba:	b7c5                	j	99a <nulterminate+0x54>
    nulterminate(lcmd->left);
     9bc:	6508                	ld	a0,8(a0)
     9be:	00000097          	auipc	ra,0x0
     9c2:	f88080e7          	jalr	-120(ra) # 946 <nulterminate>
    nulterminate(lcmd->right);
     9c6:	6888                	ld	a0,16(s1)
     9c8:	00000097          	auipc	ra,0x0
     9cc:	f7e080e7          	jalr	-130(ra) # 946 <nulterminate>
    break;
     9d0:	b7e9                	j	99a <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9d2:	6508                	ld	a0,8(a0)
     9d4:	00000097          	auipc	ra,0x0
     9d8:	f72080e7          	jalr	-142(ra) # 946 <nulterminate>
    break;
     9dc:	bf7d                	j	99a <nulterminate+0x54>

00000000000009de <parsecmd>:
{
     9de:	7179                	addi	sp,sp,-48
     9e0:	f406                	sd	ra,40(sp)
     9e2:	f022                	sd	s0,32(sp)
     9e4:	ec26                	sd	s1,24(sp)
     9e6:	e84a                	sd	s2,16(sp)
     9e8:	1800                	addi	s0,sp,48
     9ea:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9ee:	84aa                	mv	s1,a0
     9f0:	00000097          	auipc	ra,0x0
     9f4:	1ba080e7          	jalr	442(ra) # baa <strlen>
     9f8:	1502                	slli	a0,a0,0x20
     9fa:	9101                	srli	a0,a0,0x20
     9fc:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     9fe:	85a6                	mv	a1,s1
     a00:	fd840513          	addi	a0,s0,-40
     a04:	00000097          	auipc	ra,0x0
     a08:	df6080e7          	jalr	-522(ra) # 7fa <parseline>
     a0c:	892a                	mv	s2,a0
  peek(&s, es, "");
     a0e:	00001617          	auipc	a2,0x1
     a12:	98260613          	addi	a2,a2,-1662 # 1390 <malloc+0x1fa>
     a16:	85a6                	mv	a1,s1
     a18:	fd840513          	addi	a0,s0,-40
     a1c:	00000097          	auipc	ra,0x0
     a20:	b06080e7          	jalr	-1274(ra) # 522 <peek>
  if(s != es){
     a24:	fd843603          	ld	a2,-40(s0)
     a28:	00961e63          	bne	a2,s1,a44 <parsecmd+0x66>
  nulterminate(cmd);
     a2c:	854a                	mv	a0,s2
     a2e:	00000097          	auipc	ra,0x0
     a32:	f18080e7          	jalr	-232(ra) # 946 <nulterminate>
}
     a36:	854a                	mv	a0,s2
     a38:	70a2                	ld	ra,40(sp)
     a3a:	7402                	ld	s0,32(sp)
     a3c:	64e2                	ld	s1,24(sp)
     a3e:	6942                	ld	s2,16(sp)
     a40:	6145                	addi	sp,sp,48
     a42:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a44:	00001597          	auipc	a1,0x1
     a48:	95458593          	addi	a1,a1,-1708 # 1398 <malloc+0x202>
     a4c:	4509                	li	a0,2
     a4e:	00000097          	auipc	ra,0x0
     a52:	65a080e7          	jalr	1626(ra) # 10a8 <fprintf>
    panic("syntax");
     a56:	00001517          	auipc	a0,0x1
     a5a:	8d250513          	addi	a0,a0,-1838 # 1328 <malloc+0x192>
     a5e:	fffff097          	auipc	ra,0xfffff
     a62:	5f8080e7          	jalr	1528(ra) # 56 <panic>

0000000000000a66 <main>:
{
     a66:	7139                	addi	sp,sp,-64
     a68:	fc06                	sd	ra,56(sp)
     a6a:	f822                	sd	s0,48(sp)
     a6c:	f426                	sd	s1,40(sp)
     a6e:	f04a                	sd	s2,32(sp)
     a70:	ec4e                	sd	s3,24(sp)
     a72:	e852                	sd	s4,16(sp)
     a74:	e456                	sd	s5,8(sp)
     a76:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     a78:	00001497          	auipc	s1,0x1
     a7c:	93048493          	addi	s1,s1,-1744 # 13a8 <malloc+0x212>
     a80:	4589                	li	a1,2
     a82:	8526                	mv	a0,s1
     a84:	00000097          	auipc	ra,0x0
     a88:	31a080e7          	jalr	794(ra) # d9e <open>
     a8c:	00054963          	bltz	a0,a9e <main+0x38>
    if(fd >= 3){
     a90:	4789                	li	a5,2
     a92:	fea7d7e3          	ble	a0,a5,a80 <main+0x1a>
      close(fd);
     a96:	00000097          	auipc	ra,0x0
     a9a:	2f0080e7          	jalr	752(ra) # d86 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     a9e:	00001497          	auipc	s1,0x1
     aa2:	95a48493          	addi	s1,s1,-1702 # 13f8 <buf.1145>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     aa6:	06300913          	li	s2,99
     aaa:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     aae:	00001a17          	auipc	s4,0x1
     ab2:	94da0a13          	addi	s4,s4,-1715 # 13fb <buf.1145+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     ab6:	00001a97          	auipc	s5,0x1
     aba:	8faa8a93          	addi	s5,s5,-1798 # 13b0 <malloc+0x21a>
     abe:	a819                	j	ad4 <main+0x6e>
    if(fork1() == 0)
     ac0:	fffff097          	auipc	ra,0xfffff
     ac4:	5bc080e7          	jalr	1468(ra) # 7c <fork1>
     ac8:	c925                	beqz	a0,b38 <main+0xd2>
    wait(0);
     aca:	4501                	li	a0,0
     acc:	00000097          	auipc	ra,0x0
     ad0:	29a080e7          	jalr	666(ra) # d66 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ad4:	06400593          	li	a1,100
     ad8:	8526                	mv	a0,s1
     ada:	fffff097          	auipc	ra,0xfffff
     ade:	526080e7          	jalr	1318(ra) # 0 <getcmd>
     ae2:	06054763          	bltz	a0,b50 <main+0xea>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ae6:	0004c783          	lbu	a5,0(s1)
     aea:	fd279be3          	bne	a5,s2,ac0 <main+0x5a>
     aee:	0014c703          	lbu	a4,1(s1)
     af2:	06400793          	li	a5,100
     af6:	fcf715e3          	bne	a4,a5,ac0 <main+0x5a>
     afa:	0024c783          	lbu	a5,2(s1)
     afe:	fd3791e3          	bne	a5,s3,ac0 <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
     b02:	8526                	mv	a0,s1
     b04:	00000097          	auipc	ra,0x0
     b08:	0a6080e7          	jalr	166(ra) # baa <strlen>
     b0c:	fff5079b          	addiw	a5,a0,-1
     b10:	1782                	slli	a5,a5,0x20
     b12:	9381                	srli	a5,a5,0x20
     b14:	97a6                	add	a5,a5,s1
     b16:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b1a:	8552                	mv	a0,s4
     b1c:	00000097          	auipc	ra,0x0
     b20:	2b2080e7          	jalr	690(ra) # dce <chdir>
     b24:	fa0558e3          	bgez	a0,ad4 <main+0x6e>
        fprintf(2, "cannot cd %s\n", buf+3);
     b28:	8652                	mv	a2,s4
     b2a:	85d6                	mv	a1,s5
     b2c:	4509                	li	a0,2
     b2e:	00000097          	auipc	ra,0x0
     b32:	57a080e7          	jalr	1402(ra) # 10a8 <fprintf>
     b36:	bf79                	j	ad4 <main+0x6e>
      runcmd(parsecmd(buf));
     b38:	00001517          	auipc	a0,0x1
     b3c:	8c050513          	addi	a0,a0,-1856 # 13f8 <buf.1145>
     b40:	00000097          	auipc	ra,0x0
     b44:	e9e080e7          	jalr	-354(ra) # 9de <parsecmd>
     b48:	fffff097          	auipc	ra,0xfffff
     b4c:	562080e7          	jalr	1378(ra) # aa <runcmd>
  exit(0);
     b50:	4501                	li	a0,0
     b52:	00000097          	auipc	ra,0x0
     b56:	20c080e7          	jalr	524(ra) # d5e <exit>

0000000000000b5a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b5a:	1141                	addi	sp,sp,-16
     b5c:	e422                	sd	s0,8(sp)
     b5e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b60:	87aa                	mv	a5,a0
     b62:	0585                	addi	a1,a1,1
     b64:	0785                	addi	a5,a5,1
     b66:	fff5c703          	lbu	a4,-1(a1)
     b6a:	fee78fa3          	sb	a4,-1(a5)
     b6e:	fb75                	bnez	a4,b62 <strcpy+0x8>
    ;
  return os;
}
     b70:	6422                	ld	s0,8(sp)
     b72:	0141                	addi	sp,sp,16
     b74:	8082                	ret

0000000000000b76 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b76:	1141                	addi	sp,sp,-16
     b78:	e422                	sd	s0,8(sp)
     b7a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     b7c:	00054783          	lbu	a5,0(a0)
     b80:	cf91                	beqz	a5,b9c <strcmp+0x26>
     b82:	0005c703          	lbu	a4,0(a1)
     b86:	00f71b63          	bne	a4,a5,b9c <strcmp+0x26>
    p++, q++;
     b8a:	0505                	addi	a0,a0,1
     b8c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     b8e:	00054783          	lbu	a5,0(a0)
     b92:	c789                	beqz	a5,b9c <strcmp+0x26>
     b94:	0005c703          	lbu	a4,0(a1)
     b98:	fef709e3          	beq	a4,a5,b8a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     b9c:	0005c503          	lbu	a0,0(a1)
}
     ba0:	40a7853b          	subw	a0,a5,a0
     ba4:	6422                	ld	s0,8(sp)
     ba6:	0141                	addi	sp,sp,16
     ba8:	8082                	ret

0000000000000baa <strlen>:

uint
strlen(const char *s)
{
     baa:	1141                	addi	sp,sp,-16
     bac:	e422                	sd	s0,8(sp)
     bae:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bb0:	00054783          	lbu	a5,0(a0)
     bb4:	cf91                	beqz	a5,bd0 <strlen+0x26>
     bb6:	0505                	addi	a0,a0,1
     bb8:	87aa                	mv	a5,a0
     bba:	4685                	li	a3,1
     bbc:	9e89                	subw	a3,a3,a0
    ;
     bbe:	00f6853b          	addw	a0,a3,a5
     bc2:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
     bc4:	fff7c703          	lbu	a4,-1(a5)
     bc8:	fb7d                	bnez	a4,bbe <strlen+0x14>
  return n;
}
     bca:	6422                	ld	s0,8(sp)
     bcc:	0141                	addi	sp,sp,16
     bce:	8082                	ret
  for(n = 0; s[n]; n++)
     bd0:	4501                	li	a0,0
     bd2:	bfe5                	j	bca <strlen+0x20>

0000000000000bd4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bd4:	1141                	addi	sp,sp,-16
     bd6:	e422                	sd	s0,8(sp)
     bd8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     bda:	ce09                	beqz	a2,bf4 <memset+0x20>
     bdc:	87aa                	mv	a5,a0
     bde:	fff6071b          	addiw	a4,a2,-1
     be2:	1702                	slli	a4,a4,0x20
     be4:	9301                	srli	a4,a4,0x20
     be6:	0705                	addi	a4,a4,1
     be8:	972a                	add	a4,a4,a0
    cdst[i] = c;
     bea:	00b78023          	sb	a1,0(a5)
     bee:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
     bf0:	fee79de3          	bne	a5,a4,bea <memset+0x16>
  }
  return dst;
}
     bf4:	6422                	ld	s0,8(sp)
     bf6:	0141                	addi	sp,sp,16
     bf8:	8082                	ret

0000000000000bfa <strchr>:

char*
strchr(const char *s, char c)
{
     bfa:	1141                	addi	sp,sp,-16
     bfc:	e422                	sd	s0,8(sp)
     bfe:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c00:	00054783          	lbu	a5,0(a0)
     c04:	cf91                	beqz	a5,c20 <strchr+0x26>
    if(*s == c)
     c06:	00f58a63          	beq	a1,a5,c1a <strchr+0x20>
  for(; *s; s++)
     c0a:	0505                	addi	a0,a0,1
     c0c:	00054783          	lbu	a5,0(a0)
     c10:	c781                	beqz	a5,c18 <strchr+0x1e>
    if(*s == c)
     c12:	feb79ce3          	bne	a5,a1,c0a <strchr+0x10>
     c16:	a011                	j	c1a <strchr+0x20>
      return (char*)s;
  return 0;
     c18:	4501                	li	a0,0
}
     c1a:	6422                	ld	s0,8(sp)
     c1c:	0141                	addi	sp,sp,16
     c1e:	8082                	ret
  return 0;
     c20:	4501                	li	a0,0
     c22:	bfe5                	j	c1a <strchr+0x20>

0000000000000c24 <gets>:

char*
gets(char *buf, int max)
{
     c24:	711d                	addi	sp,sp,-96
     c26:	ec86                	sd	ra,88(sp)
     c28:	e8a2                	sd	s0,80(sp)
     c2a:	e4a6                	sd	s1,72(sp)
     c2c:	e0ca                	sd	s2,64(sp)
     c2e:	fc4e                	sd	s3,56(sp)
     c30:	f852                	sd	s4,48(sp)
     c32:	f456                	sd	s5,40(sp)
     c34:	f05a                	sd	s6,32(sp)
     c36:	ec5e                	sd	s7,24(sp)
     c38:	1080                	addi	s0,sp,96
     c3a:	8baa                	mv	s7,a0
     c3c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c3e:	892a                	mv	s2,a0
     c40:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c42:	4aa9                	li	s5,10
     c44:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c46:	0019849b          	addiw	s1,s3,1
     c4a:	0344d863          	ble	s4,s1,c7a <gets+0x56>
    cc = read(0, &c, 1);
     c4e:	4605                	li	a2,1
     c50:	faf40593          	addi	a1,s0,-81
     c54:	4501                	li	a0,0
     c56:	00000097          	auipc	ra,0x0
     c5a:	120080e7          	jalr	288(ra) # d76 <read>
    if(cc < 1)
     c5e:	00a05e63          	blez	a0,c7a <gets+0x56>
    buf[i++] = c;
     c62:	faf44783          	lbu	a5,-81(s0)
     c66:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c6a:	01578763          	beq	a5,s5,c78 <gets+0x54>
     c6e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
     c70:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
     c72:	fd679ae3          	bne	a5,s6,c46 <gets+0x22>
     c76:	a011                	j	c7a <gets+0x56>
  for(i=0; i+1 < max; ){
     c78:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     c7a:	99de                	add	s3,s3,s7
     c7c:	00098023          	sb	zero,0(s3)
  return buf;
}
     c80:	855e                	mv	a0,s7
     c82:	60e6                	ld	ra,88(sp)
     c84:	6446                	ld	s0,80(sp)
     c86:	64a6                	ld	s1,72(sp)
     c88:	6906                	ld	s2,64(sp)
     c8a:	79e2                	ld	s3,56(sp)
     c8c:	7a42                	ld	s4,48(sp)
     c8e:	7aa2                	ld	s5,40(sp)
     c90:	7b02                	ld	s6,32(sp)
     c92:	6be2                	ld	s7,24(sp)
     c94:	6125                	addi	sp,sp,96
     c96:	8082                	ret

0000000000000c98 <stat>:

int
stat(const char *n, struct stat *st)
{
     c98:	1101                	addi	sp,sp,-32
     c9a:	ec06                	sd	ra,24(sp)
     c9c:	e822                	sd	s0,16(sp)
     c9e:	e426                	sd	s1,8(sp)
     ca0:	e04a                	sd	s2,0(sp)
     ca2:	1000                	addi	s0,sp,32
     ca4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ca6:	4581                	li	a1,0
     ca8:	00000097          	auipc	ra,0x0
     cac:	0f6080e7          	jalr	246(ra) # d9e <open>
  if(fd < 0)
     cb0:	02054563          	bltz	a0,cda <stat+0x42>
     cb4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     cb6:	85ca                	mv	a1,s2
     cb8:	00000097          	auipc	ra,0x0
     cbc:	0fe080e7          	jalr	254(ra) # db6 <fstat>
     cc0:	892a                	mv	s2,a0
  close(fd);
     cc2:	8526                	mv	a0,s1
     cc4:	00000097          	auipc	ra,0x0
     cc8:	0c2080e7          	jalr	194(ra) # d86 <close>
  return r;
}
     ccc:	854a                	mv	a0,s2
     cce:	60e2                	ld	ra,24(sp)
     cd0:	6442                	ld	s0,16(sp)
     cd2:	64a2                	ld	s1,8(sp)
     cd4:	6902                	ld	s2,0(sp)
     cd6:	6105                	addi	sp,sp,32
     cd8:	8082                	ret
    return -1;
     cda:	597d                	li	s2,-1
     cdc:	bfc5                	j	ccc <stat+0x34>

0000000000000cde <atoi>:

int
atoi(const char *s)
{
     cde:	1141                	addi	sp,sp,-16
     ce0:	e422                	sd	s0,8(sp)
     ce2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ce4:	00054683          	lbu	a3,0(a0)
     ce8:	fd06879b          	addiw	a5,a3,-48
     cec:	0ff7f793          	andi	a5,a5,255
     cf0:	4725                	li	a4,9
     cf2:	02f76963          	bltu	a4,a5,d24 <atoi+0x46>
     cf6:	862a                	mv	a2,a0
  n = 0;
     cf8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     cfa:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     cfc:	0605                	addi	a2,a2,1
     cfe:	0025179b          	slliw	a5,a0,0x2
     d02:	9fa9                	addw	a5,a5,a0
     d04:	0017979b          	slliw	a5,a5,0x1
     d08:	9fb5                	addw	a5,a5,a3
     d0a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d0e:	00064683          	lbu	a3,0(a2)
     d12:	fd06871b          	addiw	a4,a3,-48
     d16:	0ff77713          	andi	a4,a4,255
     d1a:	fee5f1e3          	bleu	a4,a1,cfc <atoi+0x1e>
  return n;
}
     d1e:	6422                	ld	s0,8(sp)
     d20:	0141                	addi	sp,sp,16
     d22:	8082                	ret
  n = 0;
     d24:	4501                	li	a0,0
     d26:	bfe5                	j	d1e <atoi+0x40>

0000000000000d28 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d28:	1141                	addi	sp,sp,-16
     d2a:	e422                	sd	s0,8(sp)
     d2c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d2e:	02c05163          	blez	a2,d50 <memmove+0x28>
     d32:	fff6071b          	addiw	a4,a2,-1
     d36:	1702                	slli	a4,a4,0x20
     d38:	9301                	srli	a4,a4,0x20
     d3a:	0705                	addi	a4,a4,1
     d3c:	972a                	add	a4,a4,a0
  dst = vdst;
     d3e:	87aa                	mv	a5,a0
    *dst++ = *src++;
     d40:	0585                	addi	a1,a1,1
     d42:	0785                	addi	a5,a5,1
     d44:	fff5c683          	lbu	a3,-1(a1)
     d48:	fed78fa3          	sb	a3,-1(a5)
  while(n-- > 0)
     d4c:	fee79ae3          	bne	a5,a4,d40 <memmove+0x18>
  return vdst;
}
     d50:	6422                	ld	s0,8(sp)
     d52:	0141                	addi	sp,sp,16
     d54:	8082                	ret

0000000000000d56 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d56:	4885                	li	a7,1
 ecall
     d58:	00000073          	ecall
 ret
     d5c:	8082                	ret

0000000000000d5e <exit>:
.global exit
exit:
 li a7, SYS_exit
     d5e:	4889                	li	a7,2
 ecall
     d60:	00000073          	ecall
 ret
     d64:	8082                	ret

0000000000000d66 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d66:	488d                	li	a7,3
 ecall
     d68:	00000073          	ecall
 ret
     d6c:	8082                	ret

0000000000000d6e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d6e:	4891                	li	a7,4
 ecall
     d70:	00000073          	ecall
 ret
     d74:	8082                	ret

0000000000000d76 <read>:
.global read
read:
 li a7, SYS_read
     d76:	4895                	li	a7,5
 ecall
     d78:	00000073          	ecall
 ret
     d7c:	8082                	ret

0000000000000d7e <write>:
.global write
write:
 li a7, SYS_write
     d7e:	48c1                	li	a7,16
 ecall
     d80:	00000073          	ecall
 ret
     d84:	8082                	ret

0000000000000d86 <close>:
.global close
close:
 li a7, SYS_close
     d86:	48d5                	li	a7,21
 ecall
     d88:	00000073          	ecall
 ret
     d8c:	8082                	ret

0000000000000d8e <kill>:
.global kill
kill:
 li a7, SYS_kill
     d8e:	4899                	li	a7,6
 ecall
     d90:	00000073          	ecall
 ret
     d94:	8082                	ret

0000000000000d96 <exec>:
.global exec
exec:
 li a7, SYS_exec
     d96:	489d                	li	a7,7
 ecall
     d98:	00000073          	ecall
 ret
     d9c:	8082                	ret

0000000000000d9e <open>:
.global open
open:
 li a7, SYS_open
     d9e:	48bd                	li	a7,15
 ecall
     da0:	00000073          	ecall
 ret
     da4:	8082                	ret

0000000000000da6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     da6:	48c5                	li	a7,17
 ecall
     da8:	00000073          	ecall
 ret
     dac:	8082                	ret

0000000000000dae <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     dae:	48c9                	li	a7,18
 ecall
     db0:	00000073          	ecall
 ret
     db4:	8082                	ret

0000000000000db6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     db6:	48a1                	li	a7,8
 ecall
     db8:	00000073          	ecall
 ret
     dbc:	8082                	ret

0000000000000dbe <link>:
.global link
link:
 li a7, SYS_link
     dbe:	48cd                	li	a7,19
 ecall
     dc0:	00000073          	ecall
 ret
     dc4:	8082                	ret

0000000000000dc6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     dc6:	48d1                	li	a7,20
 ecall
     dc8:	00000073          	ecall
 ret
     dcc:	8082                	ret

0000000000000dce <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     dce:	48a5                	li	a7,9
 ecall
     dd0:	00000073          	ecall
 ret
     dd4:	8082                	ret

0000000000000dd6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     dd6:	48a9                	li	a7,10
 ecall
     dd8:	00000073          	ecall
 ret
     ddc:	8082                	ret

0000000000000dde <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     dde:	48ad                	li	a7,11
 ecall
     de0:	00000073          	ecall
 ret
     de4:	8082                	ret

0000000000000de6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     de6:	48b1                	li	a7,12
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     dee:	48b5                	li	a7,13
 ecall
     df0:	00000073          	ecall
 ret
     df4:	8082                	ret

0000000000000df6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     df6:	48b9                	li	a7,14
 ecall
     df8:	00000073          	ecall
 ret
     dfc:	8082                	ret

0000000000000dfe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     dfe:	1101                	addi	sp,sp,-32
     e00:	ec06                	sd	ra,24(sp)
     e02:	e822                	sd	s0,16(sp)
     e04:	1000                	addi	s0,sp,32
     e06:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e0a:	4605                	li	a2,1
     e0c:	fef40593          	addi	a1,s0,-17
     e10:	00000097          	auipc	ra,0x0
     e14:	f6e080e7          	jalr	-146(ra) # d7e <write>
}
     e18:	60e2                	ld	ra,24(sp)
     e1a:	6442                	ld	s0,16(sp)
     e1c:	6105                	addi	sp,sp,32
     e1e:	8082                	ret

0000000000000e20 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     e20:	7139                	addi	sp,sp,-64
     e22:	fc06                	sd	ra,56(sp)
     e24:	f822                	sd	s0,48(sp)
     e26:	f426                	sd	s1,40(sp)
     e28:	f04a                	sd	s2,32(sp)
     e2a:	ec4e                	sd	s3,24(sp)
     e2c:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e2e:	c299                	beqz	a3,e34 <printint+0x14>
     e30:	0005cd63          	bltz	a1,e4a <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     e34:	2581                	sext.w	a1,a1
  neg = 0;
     e36:	4301                	li	t1,0
     e38:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
     e3c:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
     e3e:	2601                	sext.w	a2,a2
     e40:	00000897          	auipc	a7,0x0
     e44:	58088893          	addi	a7,a7,1408 # 13c0 <digits>
     e48:	a801                	j	e58 <printint+0x38>
    x = -xx;
     e4a:	40b005bb          	negw	a1,a1
     e4e:	2581                	sext.w	a1,a1
    neg = 1;
     e50:	4305                	li	t1,1
    x = -xx;
     e52:	b7dd                	j	e38 <printint+0x18>
  }while((x /= base) != 0);
     e54:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
     e56:	8836                	mv	a6,a3
     e58:	0018069b          	addiw	a3,a6,1
     e5c:	02c5f7bb          	remuw	a5,a1,a2
     e60:	1782                	slli	a5,a5,0x20
     e62:	9381                	srli	a5,a5,0x20
     e64:	97c6                	add	a5,a5,a7
     e66:	0007c783          	lbu	a5,0(a5)
     e6a:	00f70023          	sb	a5,0(a4)
     e6e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
     e70:	02c5d7bb          	divuw	a5,a1,a2
     e74:	fec5f0e3          	bleu	a2,a1,e54 <printint+0x34>
  if(neg)
     e78:	00030b63          	beqz	t1,e8e <printint+0x6e>
    buf[i++] = '-';
     e7c:	fd040793          	addi	a5,s0,-48
     e80:	96be                	add	a3,a3,a5
     e82:	02d00793          	li	a5,45
     e86:	fef68823          	sb	a5,-16(a3)
     e8a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
     e8e:	02d05963          	blez	a3,ec0 <printint+0xa0>
     e92:	89aa                	mv	s3,a0
     e94:	fc040793          	addi	a5,s0,-64
     e98:	00d784b3          	add	s1,a5,a3
     e9c:	fff78913          	addi	s2,a5,-1
     ea0:	9936                	add	s2,s2,a3
     ea2:	36fd                	addiw	a3,a3,-1
     ea4:	1682                	slli	a3,a3,0x20
     ea6:	9281                	srli	a3,a3,0x20
     ea8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
     eac:	fff4c583          	lbu	a1,-1(s1)
     eb0:	854e                	mv	a0,s3
     eb2:	00000097          	auipc	ra,0x0
     eb6:	f4c080e7          	jalr	-180(ra) # dfe <putc>
     eba:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
     ebc:	ff2498e3          	bne	s1,s2,eac <printint+0x8c>
}
     ec0:	70e2                	ld	ra,56(sp)
     ec2:	7442                	ld	s0,48(sp)
     ec4:	74a2                	ld	s1,40(sp)
     ec6:	7902                	ld	s2,32(sp)
     ec8:	69e2                	ld	s3,24(sp)
     eca:	6121                	addi	sp,sp,64
     ecc:	8082                	ret

0000000000000ece <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     ece:	7119                	addi	sp,sp,-128
     ed0:	fc86                	sd	ra,120(sp)
     ed2:	f8a2                	sd	s0,112(sp)
     ed4:	f4a6                	sd	s1,104(sp)
     ed6:	f0ca                	sd	s2,96(sp)
     ed8:	ecce                	sd	s3,88(sp)
     eda:	e8d2                	sd	s4,80(sp)
     edc:	e4d6                	sd	s5,72(sp)
     ede:	e0da                	sd	s6,64(sp)
     ee0:	fc5e                	sd	s7,56(sp)
     ee2:	f862                	sd	s8,48(sp)
     ee4:	f466                	sd	s9,40(sp)
     ee6:	f06a                	sd	s10,32(sp)
     ee8:	ec6e                	sd	s11,24(sp)
     eea:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     eec:	0005c483          	lbu	s1,0(a1)
     ef0:	18048d63          	beqz	s1,108a <vprintf+0x1bc>
     ef4:	8aaa                	mv	s5,a0
     ef6:	8b32                	mv	s6,a2
     ef8:	00158913          	addi	s2,a1,1
  state = 0;
     efc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     efe:	02500a13          	li	s4,37
      if(c == 'd'){
     f02:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
     f06:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
     f0a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
     f0e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f12:	00000b97          	auipc	s7,0x0
     f16:	4aeb8b93          	addi	s7,s7,1198 # 13c0 <digits>
     f1a:	a839                	j	f38 <vprintf+0x6a>
        putc(fd, c);
     f1c:	85a6                	mv	a1,s1
     f1e:	8556                	mv	a0,s5
     f20:	00000097          	auipc	ra,0x0
     f24:	ede080e7          	jalr	-290(ra) # dfe <putc>
     f28:	a019                	j	f2e <vprintf+0x60>
    } else if(state == '%'){
     f2a:	01498f63          	beq	s3,s4,f48 <vprintf+0x7a>
     f2e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
     f30:	fff94483          	lbu	s1,-1(s2)
     f34:	14048b63          	beqz	s1,108a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
     f38:	0004879b          	sext.w	a5,s1
    if(state == 0){
     f3c:	fe0997e3          	bnez	s3,f2a <vprintf+0x5c>
      if(c == '%'){
     f40:	fd479ee3          	bne	a5,s4,f1c <vprintf+0x4e>
        state = '%';
     f44:	89be                	mv	s3,a5
     f46:	b7e5                	j	f2e <vprintf+0x60>
      if(c == 'd'){
     f48:	05878063          	beq	a5,s8,f88 <vprintf+0xba>
      } else if(c == 'l') {
     f4c:	05978c63          	beq	a5,s9,fa4 <vprintf+0xd6>
      } else if(c == 'x') {
     f50:	07a78863          	beq	a5,s10,fc0 <vprintf+0xf2>
      } else if(c == 'p') {
     f54:	09b78463          	beq	a5,s11,fdc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
     f58:	07300713          	li	a4,115
     f5c:	0ce78563          	beq	a5,a4,1026 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f60:	06300713          	li	a4,99
     f64:	0ee78c63          	beq	a5,a4,105c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
     f68:	11478663          	beq	a5,s4,1074 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     f6c:	85d2                	mv	a1,s4
     f6e:	8556                	mv	a0,s5
     f70:	00000097          	auipc	ra,0x0
     f74:	e8e080e7          	jalr	-370(ra) # dfe <putc>
        putc(fd, c);
     f78:	85a6                	mv	a1,s1
     f7a:	8556                	mv	a0,s5
     f7c:	00000097          	auipc	ra,0x0
     f80:	e82080e7          	jalr	-382(ra) # dfe <putc>
      }
      state = 0;
     f84:	4981                	li	s3,0
     f86:	b765                	j	f2e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
     f88:	008b0493          	addi	s1,s6,8
     f8c:	4685                	li	a3,1
     f8e:	4629                	li	a2,10
     f90:	000b2583          	lw	a1,0(s6)
     f94:	8556                	mv	a0,s5
     f96:	00000097          	auipc	ra,0x0
     f9a:	e8a080e7          	jalr	-374(ra) # e20 <printint>
     f9e:	8b26                	mv	s6,s1
      state = 0;
     fa0:	4981                	li	s3,0
     fa2:	b771                	j	f2e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fa4:	008b0493          	addi	s1,s6,8
     fa8:	4681                	li	a3,0
     faa:	4629                	li	a2,10
     fac:	000b2583          	lw	a1,0(s6)
     fb0:	8556                	mv	a0,s5
     fb2:	00000097          	auipc	ra,0x0
     fb6:	e6e080e7          	jalr	-402(ra) # e20 <printint>
     fba:	8b26                	mv	s6,s1
      state = 0;
     fbc:	4981                	li	s3,0
     fbe:	bf85                	j	f2e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
     fc0:	008b0493          	addi	s1,s6,8
     fc4:	4681                	li	a3,0
     fc6:	4641                	li	a2,16
     fc8:	000b2583          	lw	a1,0(s6)
     fcc:	8556                	mv	a0,s5
     fce:	00000097          	auipc	ra,0x0
     fd2:	e52080e7          	jalr	-430(ra) # e20 <printint>
     fd6:	8b26                	mv	s6,s1
      state = 0;
     fd8:	4981                	li	s3,0
     fda:	bf91                	j	f2e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
     fdc:	008b0793          	addi	a5,s6,8
     fe0:	f8f43423          	sd	a5,-120(s0)
     fe4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
     fe8:	03000593          	li	a1,48
     fec:	8556                	mv	a0,s5
     fee:	00000097          	auipc	ra,0x0
     ff2:	e10080e7          	jalr	-496(ra) # dfe <putc>
  putc(fd, 'x');
     ff6:	85ea                	mv	a1,s10
     ff8:	8556                	mv	a0,s5
     ffa:	00000097          	auipc	ra,0x0
     ffe:	e04080e7          	jalr	-508(ra) # dfe <putc>
    1002:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1004:	03c9d793          	srli	a5,s3,0x3c
    1008:	97de                	add	a5,a5,s7
    100a:	0007c583          	lbu	a1,0(a5)
    100e:	8556                	mv	a0,s5
    1010:	00000097          	auipc	ra,0x0
    1014:	dee080e7          	jalr	-530(ra) # dfe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1018:	0992                	slli	s3,s3,0x4
    101a:	34fd                	addiw	s1,s1,-1
    101c:	f4e5                	bnez	s1,1004 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    101e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1022:	4981                	li	s3,0
    1024:	b729                	j	f2e <vprintf+0x60>
        s = va_arg(ap, char*);
    1026:	008b0993          	addi	s3,s6,8
    102a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    102e:	c085                	beqz	s1,104e <vprintf+0x180>
        while(*s != 0){
    1030:	0004c583          	lbu	a1,0(s1)
    1034:	c9a1                	beqz	a1,1084 <vprintf+0x1b6>
          putc(fd, *s);
    1036:	8556                	mv	a0,s5
    1038:	00000097          	auipc	ra,0x0
    103c:	dc6080e7          	jalr	-570(ra) # dfe <putc>
          s++;
    1040:	0485                	addi	s1,s1,1
        while(*s != 0){
    1042:	0004c583          	lbu	a1,0(s1)
    1046:	f9e5                	bnez	a1,1036 <vprintf+0x168>
        s = va_arg(ap, char*);
    1048:	8b4e                	mv	s6,s3
      state = 0;
    104a:	4981                	li	s3,0
    104c:	b5cd                	j	f2e <vprintf+0x60>
          s = "(null)";
    104e:	00000497          	auipc	s1,0x0
    1052:	38a48493          	addi	s1,s1,906 # 13d8 <digits+0x18>
        while(*s != 0){
    1056:	02800593          	li	a1,40
    105a:	bff1                	j	1036 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    105c:	008b0493          	addi	s1,s6,8
    1060:	000b4583          	lbu	a1,0(s6)
    1064:	8556                	mv	a0,s5
    1066:	00000097          	auipc	ra,0x0
    106a:	d98080e7          	jalr	-616(ra) # dfe <putc>
    106e:	8b26                	mv	s6,s1
      state = 0;
    1070:	4981                	li	s3,0
    1072:	bd75                	j	f2e <vprintf+0x60>
        putc(fd, c);
    1074:	85d2                	mv	a1,s4
    1076:	8556                	mv	a0,s5
    1078:	00000097          	auipc	ra,0x0
    107c:	d86080e7          	jalr	-634(ra) # dfe <putc>
      state = 0;
    1080:	4981                	li	s3,0
    1082:	b575                	j	f2e <vprintf+0x60>
        s = va_arg(ap, char*);
    1084:	8b4e                	mv	s6,s3
      state = 0;
    1086:	4981                	li	s3,0
    1088:	b55d                	j	f2e <vprintf+0x60>
    }
  }
}
    108a:	70e6                	ld	ra,120(sp)
    108c:	7446                	ld	s0,112(sp)
    108e:	74a6                	ld	s1,104(sp)
    1090:	7906                	ld	s2,96(sp)
    1092:	69e6                	ld	s3,88(sp)
    1094:	6a46                	ld	s4,80(sp)
    1096:	6aa6                	ld	s5,72(sp)
    1098:	6b06                	ld	s6,64(sp)
    109a:	7be2                	ld	s7,56(sp)
    109c:	7c42                	ld	s8,48(sp)
    109e:	7ca2                	ld	s9,40(sp)
    10a0:	7d02                	ld	s10,32(sp)
    10a2:	6de2                	ld	s11,24(sp)
    10a4:	6109                	addi	sp,sp,128
    10a6:	8082                	ret

00000000000010a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10a8:	715d                	addi	sp,sp,-80
    10aa:	ec06                	sd	ra,24(sp)
    10ac:	e822                	sd	s0,16(sp)
    10ae:	1000                	addi	s0,sp,32
    10b0:	e010                	sd	a2,0(s0)
    10b2:	e414                	sd	a3,8(s0)
    10b4:	e818                	sd	a4,16(s0)
    10b6:	ec1c                	sd	a5,24(s0)
    10b8:	03043023          	sd	a6,32(s0)
    10bc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10c4:	8622                	mv	a2,s0
    10c6:	00000097          	auipc	ra,0x0
    10ca:	e08080e7          	jalr	-504(ra) # ece <vprintf>
}
    10ce:	60e2                	ld	ra,24(sp)
    10d0:	6442                	ld	s0,16(sp)
    10d2:	6161                	addi	sp,sp,80
    10d4:	8082                	ret

00000000000010d6 <printf>:

void
printf(const char *fmt, ...)
{
    10d6:	711d                	addi	sp,sp,-96
    10d8:	ec06                	sd	ra,24(sp)
    10da:	e822                	sd	s0,16(sp)
    10dc:	1000                	addi	s0,sp,32
    10de:	e40c                	sd	a1,8(s0)
    10e0:	e810                	sd	a2,16(s0)
    10e2:	ec14                	sd	a3,24(s0)
    10e4:	f018                	sd	a4,32(s0)
    10e6:	f41c                	sd	a5,40(s0)
    10e8:	03043823          	sd	a6,48(s0)
    10ec:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10f0:	00840613          	addi	a2,s0,8
    10f4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    10f8:	85aa                	mv	a1,a0
    10fa:	4505                	li	a0,1
    10fc:	00000097          	auipc	ra,0x0
    1100:	dd2080e7          	jalr	-558(ra) # ece <vprintf>
}
    1104:	60e2                	ld	ra,24(sp)
    1106:	6442                	ld	s0,16(sp)
    1108:	6125                	addi	sp,sp,96
    110a:	8082                	ret

000000000000110c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    110c:	1141                	addi	sp,sp,-16
    110e:	e422                	sd	s0,8(sp)
    1110:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1112:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1116:	00000797          	auipc	a5,0x0
    111a:	2da78793          	addi	a5,a5,730 # 13f0 <freep>
    111e:	639c                	ld	a5,0(a5)
    1120:	a805                	j	1150 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1122:	4618                	lw	a4,8(a2)
    1124:	9db9                	addw	a1,a1,a4
    1126:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    112a:	6398                	ld	a4,0(a5)
    112c:	6318                	ld	a4,0(a4)
    112e:	fee53823          	sd	a4,-16(a0)
    1132:	a091                	j	1176 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1134:	ff852703          	lw	a4,-8(a0)
    1138:	9e39                	addw	a2,a2,a4
    113a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    113c:	ff053703          	ld	a4,-16(a0)
    1140:	e398                	sd	a4,0(a5)
    1142:	a099                	j	1188 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1144:	6398                	ld	a4,0(a5)
    1146:	00e7e463          	bltu	a5,a4,114e <free+0x42>
    114a:	00e6ea63          	bltu	a3,a4,115e <free+0x52>
{
    114e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1150:	fed7fae3          	bleu	a3,a5,1144 <free+0x38>
    1154:	6398                	ld	a4,0(a5)
    1156:	00e6e463          	bltu	a3,a4,115e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    115a:	fee7eae3          	bltu	a5,a4,114e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    115e:	ff852583          	lw	a1,-8(a0)
    1162:	6390                	ld	a2,0(a5)
    1164:	02059713          	slli	a4,a1,0x20
    1168:	9301                	srli	a4,a4,0x20
    116a:	0712                	slli	a4,a4,0x4
    116c:	9736                	add	a4,a4,a3
    116e:	fae60ae3          	beq	a2,a4,1122 <free+0x16>
    bp->s.ptr = p->s.ptr;
    1172:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1176:	4790                	lw	a2,8(a5)
    1178:	02061713          	slli	a4,a2,0x20
    117c:	9301                	srli	a4,a4,0x20
    117e:	0712                	slli	a4,a4,0x4
    1180:	973e                	add	a4,a4,a5
    1182:	fae689e3          	beq	a3,a4,1134 <free+0x28>
  } else
    p->s.ptr = bp;
    1186:	e394                	sd	a3,0(a5)
  freep = p;
    1188:	00000717          	auipc	a4,0x0
    118c:	26f73423          	sd	a5,616(a4) # 13f0 <freep>
}
    1190:	6422                	ld	s0,8(sp)
    1192:	0141                	addi	sp,sp,16
    1194:	8082                	ret

0000000000001196 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1196:	7139                	addi	sp,sp,-64
    1198:	fc06                	sd	ra,56(sp)
    119a:	f822                	sd	s0,48(sp)
    119c:	f426                	sd	s1,40(sp)
    119e:	f04a                	sd	s2,32(sp)
    11a0:	ec4e                	sd	s3,24(sp)
    11a2:	e852                	sd	s4,16(sp)
    11a4:	e456                	sd	s5,8(sp)
    11a6:	e05a                	sd	s6,0(sp)
    11a8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11aa:	02051993          	slli	s3,a0,0x20
    11ae:	0209d993          	srli	s3,s3,0x20
    11b2:	09bd                	addi	s3,s3,15
    11b4:	0049d993          	srli	s3,s3,0x4
    11b8:	2985                	addiw	s3,s3,1
    11ba:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    11be:	00000797          	auipc	a5,0x0
    11c2:	23278793          	addi	a5,a5,562 # 13f0 <freep>
    11c6:	6388                	ld	a0,0(a5)
    11c8:	c515                	beqz	a0,11f4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11cc:	4798                	lw	a4,8(a5)
    11ce:	03277f63          	bleu	s2,a4,120c <malloc+0x76>
    11d2:	8a4e                	mv	s4,s3
    11d4:	0009871b          	sext.w	a4,s3
    11d8:	6685                	lui	a3,0x1
    11da:	00d77363          	bleu	a3,a4,11e0 <malloc+0x4a>
    11de:	6a05                	lui	s4,0x1
    11e0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    11e4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11e8:	00000497          	auipc	s1,0x0
    11ec:	20848493          	addi	s1,s1,520 # 13f0 <freep>
  if(p == (char*)-1)
    11f0:	5b7d                	li	s6,-1
    11f2:	a885                	j	1262 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    11f4:	00000797          	auipc	a5,0x0
    11f8:	26c78793          	addi	a5,a5,620 # 1460 <base>
    11fc:	00000717          	auipc	a4,0x0
    1200:	1ef73a23          	sd	a5,500(a4) # 13f0 <freep>
    1204:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1206:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    120a:	b7e1                	j	11d2 <malloc+0x3c>
      if(p->s.size == nunits)
    120c:	02e90b63          	beq	s2,a4,1242 <malloc+0xac>
        p->s.size -= nunits;
    1210:	4137073b          	subw	a4,a4,s3
    1214:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1216:	1702                	slli	a4,a4,0x20
    1218:	9301                	srli	a4,a4,0x20
    121a:	0712                	slli	a4,a4,0x4
    121c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    121e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1222:	00000717          	auipc	a4,0x0
    1226:	1ca73723          	sd	a0,462(a4) # 13f0 <freep>
      return (void*)(p + 1);
    122a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    122e:	70e2                	ld	ra,56(sp)
    1230:	7442                	ld	s0,48(sp)
    1232:	74a2                	ld	s1,40(sp)
    1234:	7902                	ld	s2,32(sp)
    1236:	69e2                	ld	s3,24(sp)
    1238:	6a42                	ld	s4,16(sp)
    123a:	6aa2                	ld	s5,8(sp)
    123c:	6b02                	ld	s6,0(sp)
    123e:	6121                	addi	sp,sp,64
    1240:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1242:	6398                	ld	a4,0(a5)
    1244:	e118                	sd	a4,0(a0)
    1246:	bff1                	j	1222 <malloc+0x8c>
  hp->s.size = nu;
    1248:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    124c:	0541                	addi	a0,a0,16
    124e:	00000097          	auipc	ra,0x0
    1252:	ebe080e7          	jalr	-322(ra) # 110c <free>
  return freep;
    1256:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    1258:	d979                	beqz	a0,122e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    125a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    125c:	4798                	lw	a4,8(a5)
    125e:	fb2777e3          	bleu	s2,a4,120c <malloc+0x76>
    if(p == freep)
    1262:	6098                	ld	a4,0(s1)
    1264:	853e                	mv	a0,a5
    1266:	fef71ae3          	bne	a4,a5,125a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    126a:	8552                	mv	a0,s4
    126c:	00000097          	auipc	ra,0x0
    1270:	b7a080e7          	jalr	-1158(ra) # de6 <sbrk>
  if(p == (char*)-1)
    1274:	fd651ae3          	bne	a0,s6,1248 <malloc+0xb2>
        return 0;
    1278:	4501                	li	a0,0
    127a:	bf55                	j	122e <malloc+0x98>
