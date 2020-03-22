
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	80010113          	addi	sp,sp,-2048 # 80009800 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	072000ef          	jal	ra,80000088 <start>

000000008000001a <junk>:
    8000001a:	a001                	j	8000001a <junk>

000000008000001c <timerinit>:
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
    80000022:	f14027f3          	csrr	a5,mhartid
    80000026:	2781                	sext.w	a5,a5
    80000028:	0037969b          	slliw	a3,a5,0x3
    8000002c:	02004737          	lui	a4,0x2004
    80000030:	96ba                	add	a3,a3,a4
    80000032:	0200c737          	lui	a4,0x200c
    80000036:	ff873603          	ld	a2,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003a:	000f4737          	lui	a4,0xf4
    8000003e:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80000042:	963a                	add	a2,a2,a4
    80000044:	e290                	sd	a2,0(a3)
    80000046:	0057979b          	slliw	a5,a5,0x5
    8000004a:	078e                	slli	a5,a5,0x3
    8000004c:	00009617          	auipc	a2,0x9
    80000050:	fb460613          	addi	a2,a2,-76 # 80009000 <mscratch0>
    80000054:	97b2                	add	a5,a5,a2
    80000056:	f394                	sd	a3,32(a5)
    80000058:	f798                	sd	a4,40(a5)
    8000005a:	34079073          	csrw	mscratch,a5
    8000005e:	00006797          	auipc	a5,0x6
    80000062:	b8278793          	addi	a5,a5,-1150 # 80005be0 <timervec>
    80000066:	30579073          	csrw	mtvec,a5
    8000006a:	300027f3          	csrr	a5,mstatus
    8000006e:	0087e793          	ori	a5,a5,8
    80000072:	30079073          	csrw	mstatus,a5
    80000076:	304027f3          	csrr	a5,mie
    8000007a:	0807e793          	ori	a5,a5,128
    8000007e:	30479073          	csrw	mie,a5
    80000082:	6422                	ld	s0,8(sp)
    80000084:	0141                	addi	sp,sp,16
    80000086:	8082                	ret

0000000080000088 <start>:
    80000088:	1141                	addi	sp,sp,-16
    8000008a:	e406                	sd	ra,8(sp)
    8000008c:	e022                	sd	s0,0(sp)
    8000008e:	0800                	addi	s0,sp,16
    80000090:	300027f3          	csrr	a5,mstatus
    80000094:	7779                	lui	a4,0xffffe
    80000096:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd87e3>
    8000009a:	8ff9                	and	a5,a5,a4
    8000009c:	6705                	lui	a4,0x1
    8000009e:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a2:	8fd9                	or	a5,a5,a4
    800000a4:	30079073          	csrw	mstatus,a5
    800000a8:	00001797          	auipc	a5,0x1
    800000ac:	cc678793          	addi	a5,a5,-826 # 80000d6e <main>
    800000b0:	34179073          	csrw	mepc,a5
    800000b4:	4781                	li	a5,0
    800000b6:	18079073          	csrw	satp,a5
    800000ba:	67c1                	lui	a5,0x10
    800000bc:	17fd                	addi	a5,a5,-1
    800000be:	30279073          	csrw	medeleg,a5
    800000c2:	30379073          	csrw	mideleg,a5
    800000c6:	00000097          	auipc	ra,0x0
    800000ca:	f56080e7          	jalr	-170(ra) # 8000001c <timerinit>
    800000ce:	f14027f3          	csrr	a5,mhartid
    800000d2:	2781                	sext.w	a5,a5
    800000d4:	823e                	mv	tp,a5
    800000d6:	30200073          	mret
    800000da:	60a2                	ld	ra,8(sp)
    800000dc:	6402                	ld	s0,0(sp)
    800000de:	0141                	addi	sp,sp,16
    800000e0:	8082                	ret

00000000800000e2 <consoleread>:
    800000e2:	7119                	addi	sp,sp,-128
    800000e4:	fc86                	sd	ra,120(sp)
    800000e6:	f8a2                	sd	s0,112(sp)
    800000e8:	f4a6                	sd	s1,104(sp)
    800000ea:	f0ca                	sd	s2,96(sp)
    800000ec:	ecce                	sd	s3,88(sp)
    800000ee:	e8d2                	sd	s4,80(sp)
    800000f0:	e4d6                	sd	s5,72(sp)
    800000f2:	e0da                	sd	s6,64(sp)
    800000f4:	fc5e                	sd	s7,56(sp)
    800000f6:	f862                	sd	s8,48(sp)
    800000f8:	f466                	sd	s9,40(sp)
    800000fa:	f06a                	sd	s10,32(sp)
    800000fc:	ec6e                	sd	s11,24(sp)
    800000fe:	0100                	addi	s0,sp,128
    80000100:	8caa                	mv	s9,a0
    80000102:	8aae                	mv	s5,a1
    80000104:	8a32                	mv	s4,a2
    80000106:	00060b1b          	sext.w	s6,a2
    8000010a:	00011517          	auipc	a0,0x11
    8000010e:	6f650513          	addi	a0,a0,1782 # 80011800 <cons>
    80000112:	00001097          	auipc	ra,0x1
    80000116:	9ec080e7          	jalr	-1556(ra) # 80000afe <acquire>
    8000011a:	09405663          	blez	s4,800001a6 <consoleread+0xc4>
    8000011e:	00011497          	auipc	s1,0x11
    80000122:	6e248493          	addi	s1,s1,1762 # 80011800 <cons>
    80000126:	89a6                	mv	s3,s1
    80000128:	00011917          	auipc	s2,0x11
    8000012c:	77090913          	addi	s2,s2,1904 # 80011898 <cons+0x98>
    80000130:	4c11                	li	s8,4
    80000132:	5d7d                	li	s10,-1
    80000134:	4da9                	li	s11,10
    80000136:	0984a783          	lw	a5,152(s1)
    8000013a:	09c4a703          	lw	a4,156(s1)
    8000013e:	02f71463          	bne	a4,a5,80000166 <consoleread+0x84>
    80000142:	00002097          	auipc	ra,0x2
    80000146:	8dc080e7          	jalr	-1828(ra) # 80001a1e <myproc>
    8000014a:	591c                	lw	a5,48(a0)
    8000014c:	eba5                	bnez	a5,800001bc <consoleread+0xda>
    8000014e:	85ce                	mv	a1,s3
    80000150:	854a                	mv	a0,s2
    80000152:	00002097          	auipc	ra,0x2
    80000156:	078080e7          	jalr	120(ra) # 800021ca <sleep>
    8000015a:	0984a783          	lw	a5,152(s1)
    8000015e:	09c4a703          	lw	a4,156(s1)
    80000162:	fef700e3          	beq	a4,a5,80000142 <consoleread+0x60>
    80000166:	0017871b          	addiw	a4,a5,1
    8000016a:	08e4ac23          	sw	a4,152(s1)
    8000016e:	07f7f713          	andi	a4,a5,127
    80000172:	9726                	add	a4,a4,s1
    80000174:	01874703          	lbu	a4,24(a4)
    80000178:	00070b9b          	sext.w	s7,a4
    8000017c:	078b8863          	beq	s7,s8,800001ec <consoleread+0x10a>
    80000180:	f8e407a3          	sb	a4,-113(s0)
    80000184:	4685                	li	a3,1
    80000186:	f8f40613          	addi	a2,s0,-113
    8000018a:	85d6                	mv	a1,s5
    8000018c:	8566                	mv	a0,s9
    8000018e:	00002097          	auipc	ra,0x2
    80000192:	29e080e7          	jalr	670(ra) # 8000242c <either_copyout>
    80000196:	01a50863          	beq	a0,s10,800001a6 <consoleread+0xc4>
    8000019a:	0a85                	addi	s5,s5,1
    8000019c:	3a7d                	addiw	s4,s4,-1
    8000019e:	01bb8463          	beq	s7,s11,800001a6 <consoleread+0xc4>
    800001a2:	f80a1ae3          	bnez	s4,80000136 <consoleread+0x54>
    800001a6:	00011517          	auipc	a0,0x11
    800001aa:	65a50513          	addi	a0,a0,1626 # 80011800 <cons>
    800001ae:	00001097          	auipc	ra,0x1
    800001b2:	9a4080e7          	jalr	-1628(ra) # 80000b52 <release>
    800001b6:	414b053b          	subw	a0,s6,s4
    800001ba:	a811                	j	800001ce <consoleread+0xec>
    800001bc:	00011517          	auipc	a0,0x11
    800001c0:	64450513          	addi	a0,a0,1604 # 80011800 <cons>
    800001c4:	00001097          	auipc	ra,0x1
    800001c8:	98e080e7          	jalr	-1650(ra) # 80000b52 <release>
    800001cc:	557d                	li	a0,-1
    800001ce:	70e6                	ld	ra,120(sp)
    800001d0:	7446                	ld	s0,112(sp)
    800001d2:	74a6                	ld	s1,104(sp)
    800001d4:	7906                	ld	s2,96(sp)
    800001d6:	69e6                	ld	s3,88(sp)
    800001d8:	6a46                	ld	s4,80(sp)
    800001da:	6aa6                	ld	s5,72(sp)
    800001dc:	6b06                	ld	s6,64(sp)
    800001de:	7be2                	ld	s7,56(sp)
    800001e0:	7c42                	ld	s8,48(sp)
    800001e2:	7ca2                	ld	s9,40(sp)
    800001e4:	7d02                	ld	s10,32(sp)
    800001e6:	6de2                	ld	s11,24(sp)
    800001e8:	6109                	addi	sp,sp,128
    800001ea:	8082                	ret
    800001ec:	000a071b          	sext.w	a4,s4
    800001f0:	fb677be3          	bleu	s6,a4,800001a6 <consoleread+0xc4>
    800001f4:	00011717          	auipc	a4,0x11
    800001f8:	6af72223          	sw	a5,1700(a4) # 80011898 <cons+0x98>
    800001fc:	b76d                	j	800001a6 <consoleread+0xc4>

00000000800001fe <consputc>:
    800001fe:	00026797          	auipc	a5,0x26
    80000202:	e0278793          	addi	a5,a5,-510 # 80026000 <panicked>
    80000206:	439c                	lw	a5,0(a5)
    80000208:	2781                	sext.w	a5,a5
    8000020a:	c391                	beqz	a5,8000020e <consputc+0x10>
    8000020c:	a001                	j	8000020c <consputc+0xe>
    8000020e:	1141                	addi	sp,sp,-16
    80000210:	e406                	sd	ra,8(sp)
    80000212:	e022                	sd	s0,0(sp)
    80000214:	0800                	addi	s0,sp,16
    80000216:	10000793          	li	a5,256
    8000021a:	00f50a63          	beq	a0,a5,8000022e <consputc+0x30>
    8000021e:	00000097          	auipc	ra,0x0
    80000222:	5f8080e7          	jalr	1528(ra) # 80000816 <uartputc>
    80000226:	60a2                	ld	ra,8(sp)
    80000228:	6402                	ld	s0,0(sp)
    8000022a:	0141                	addi	sp,sp,16
    8000022c:	8082                	ret
    8000022e:	4521                	li	a0,8
    80000230:	00000097          	auipc	ra,0x0
    80000234:	5e6080e7          	jalr	1510(ra) # 80000816 <uartputc>
    80000238:	02000513          	li	a0,32
    8000023c:	00000097          	auipc	ra,0x0
    80000240:	5da080e7          	jalr	1498(ra) # 80000816 <uartputc>
    80000244:	4521                	li	a0,8
    80000246:	00000097          	auipc	ra,0x0
    8000024a:	5d0080e7          	jalr	1488(ra) # 80000816 <uartputc>
    8000024e:	bfe1                	j	80000226 <consputc+0x28>

0000000080000250 <consolewrite>:
    80000250:	715d                	addi	sp,sp,-80
    80000252:	e486                	sd	ra,72(sp)
    80000254:	e0a2                	sd	s0,64(sp)
    80000256:	fc26                	sd	s1,56(sp)
    80000258:	f84a                	sd	s2,48(sp)
    8000025a:	f44e                	sd	s3,40(sp)
    8000025c:	f052                	sd	s4,32(sp)
    8000025e:	ec56                	sd	s5,24(sp)
    80000260:	0880                	addi	s0,sp,80
    80000262:	89aa                	mv	s3,a0
    80000264:	84ae                	mv	s1,a1
    80000266:	8ab2                	mv	s5,a2
    80000268:	00011517          	auipc	a0,0x11
    8000026c:	59850513          	addi	a0,a0,1432 # 80011800 <cons>
    80000270:	00001097          	auipc	ra,0x1
    80000274:	88e080e7          	jalr	-1906(ra) # 80000afe <acquire>
    80000278:	03505e63          	blez	s5,800002b4 <consolewrite+0x64>
    8000027c:	00148913          	addi	s2,s1,1
    80000280:	fffa879b          	addiw	a5,s5,-1
    80000284:	1782                	slli	a5,a5,0x20
    80000286:	9381                	srli	a5,a5,0x20
    80000288:	993e                	add	s2,s2,a5
    8000028a:	5a7d                	li	s4,-1
    8000028c:	4685                	li	a3,1
    8000028e:	8626                	mv	a2,s1
    80000290:	85ce                	mv	a1,s3
    80000292:	fbf40513          	addi	a0,s0,-65
    80000296:	00002097          	auipc	ra,0x2
    8000029a:	1ec080e7          	jalr	492(ra) # 80002482 <either_copyin>
    8000029e:	01450b63          	beq	a0,s4,800002b4 <consolewrite+0x64>
    800002a2:	fbf44503          	lbu	a0,-65(s0)
    800002a6:	00000097          	auipc	ra,0x0
    800002aa:	f58080e7          	jalr	-168(ra) # 800001fe <consputc>
    800002ae:	0485                	addi	s1,s1,1
    800002b0:	fd249ee3          	bne	s1,s2,8000028c <consolewrite+0x3c>
    800002b4:	00011517          	auipc	a0,0x11
    800002b8:	54c50513          	addi	a0,a0,1356 # 80011800 <cons>
    800002bc:	00001097          	auipc	ra,0x1
    800002c0:	896080e7          	jalr	-1898(ra) # 80000b52 <release>
    800002c4:	8556                	mv	a0,s5
    800002c6:	60a6                	ld	ra,72(sp)
    800002c8:	6406                	ld	s0,64(sp)
    800002ca:	74e2                	ld	s1,56(sp)
    800002cc:	7942                	ld	s2,48(sp)
    800002ce:	79a2                	ld	s3,40(sp)
    800002d0:	7a02                	ld	s4,32(sp)
    800002d2:	6ae2                	ld	s5,24(sp)
    800002d4:	6161                	addi	sp,sp,80
    800002d6:	8082                	ret

00000000800002d8 <consoleintr>:
    800002d8:	1101                	addi	sp,sp,-32
    800002da:	ec06                	sd	ra,24(sp)
    800002dc:	e822                	sd	s0,16(sp)
    800002de:	e426                	sd	s1,8(sp)
    800002e0:	e04a                	sd	s2,0(sp)
    800002e2:	1000                	addi	s0,sp,32
    800002e4:	84aa                	mv	s1,a0
    800002e6:	00011517          	auipc	a0,0x11
    800002ea:	51a50513          	addi	a0,a0,1306 # 80011800 <cons>
    800002ee:	00001097          	auipc	ra,0x1
    800002f2:	810080e7          	jalr	-2032(ra) # 80000afe <acquire>
    800002f6:	47c1                	li	a5,16
    800002f8:	12f48463          	beq	s1,a5,80000420 <consoleintr+0x148>
    800002fc:	0297df63          	ble	s1,a5,8000033a <consoleintr+0x62>
    80000300:	47d5                	li	a5,21
    80000302:	0af48863          	beq	s1,a5,800003b2 <consoleintr+0xda>
    80000306:	07f00793          	li	a5,127
    8000030a:	02f49b63          	bne	s1,a5,80000340 <consoleintr+0x68>
    8000030e:	00011717          	auipc	a4,0x11
    80000312:	4f270713          	addi	a4,a4,1266 # 80011800 <cons>
    80000316:	0a072783          	lw	a5,160(a4)
    8000031a:	09c72703          	lw	a4,156(a4)
    8000031e:	10f70563          	beq	a4,a5,80000428 <consoleintr+0x150>
    80000322:	37fd                	addiw	a5,a5,-1
    80000324:	00011717          	auipc	a4,0x11
    80000328:	56f72e23          	sw	a5,1404(a4) # 800118a0 <cons+0xa0>
    8000032c:	10000513          	li	a0,256
    80000330:	00000097          	auipc	ra,0x0
    80000334:	ece080e7          	jalr	-306(ra) # 800001fe <consputc>
    80000338:	a8c5                	j	80000428 <consoleintr+0x150>
    8000033a:	47a1                	li	a5,8
    8000033c:	fcf489e3          	beq	s1,a5,8000030e <consoleintr+0x36>
    80000340:	c4e5                	beqz	s1,80000428 <consoleintr+0x150>
    80000342:	00011717          	auipc	a4,0x11
    80000346:	4be70713          	addi	a4,a4,1214 # 80011800 <cons>
    8000034a:	0a072783          	lw	a5,160(a4)
    8000034e:	09872703          	lw	a4,152(a4)
    80000352:	9f99                	subw	a5,a5,a4
    80000354:	07f00713          	li	a4,127
    80000358:	0cf76863          	bltu	a4,a5,80000428 <consoleintr+0x150>
    8000035c:	47b5                	li	a5,13
    8000035e:	0ef48363          	beq	s1,a5,80000444 <consoleintr+0x16c>
    80000362:	8526                	mv	a0,s1
    80000364:	00000097          	auipc	ra,0x0
    80000368:	e9a080e7          	jalr	-358(ra) # 800001fe <consputc>
    8000036c:	00011797          	auipc	a5,0x11
    80000370:	49478793          	addi	a5,a5,1172 # 80011800 <cons>
    80000374:	0a07a703          	lw	a4,160(a5)
    80000378:	0017069b          	addiw	a3,a4,1
    8000037c:	0006861b          	sext.w	a2,a3
    80000380:	0ad7a023          	sw	a3,160(a5)
    80000384:	07f77713          	andi	a4,a4,127
    80000388:	97ba                	add	a5,a5,a4
    8000038a:	00978c23          	sb	s1,24(a5)
    8000038e:	47a9                	li	a5,10
    80000390:	0ef48163          	beq	s1,a5,80000472 <consoleintr+0x19a>
    80000394:	4791                	li	a5,4
    80000396:	0cf48e63          	beq	s1,a5,80000472 <consoleintr+0x19a>
    8000039a:	00011797          	auipc	a5,0x11
    8000039e:	46678793          	addi	a5,a5,1126 # 80011800 <cons>
    800003a2:	0987a783          	lw	a5,152(a5)
    800003a6:	0807879b          	addiw	a5,a5,128
    800003aa:	06f61f63          	bne	a2,a5,80000428 <consoleintr+0x150>
    800003ae:	863e                	mv	a2,a5
    800003b0:	a0c9                	j	80000472 <consoleintr+0x19a>
    800003b2:	00011717          	auipc	a4,0x11
    800003b6:	44e70713          	addi	a4,a4,1102 # 80011800 <cons>
    800003ba:	0a072783          	lw	a5,160(a4)
    800003be:	09c72703          	lw	a4,156(a4)
    800003c2:	06f70363          	beq	a4,a5,80000428 <consoleintr+0x150>
    800003c6:	37fd                	addiw	a5,a5,-1
    800003c8:	0007871b          	sext.w	a4,a5
    800003cc:	07f7f793          	andi	a5,a5,127
    800003d0:	00011697          	auipc	a3,0x11
    800003d4:	43068693          	addi	a3,a3,1072 # 80011800 <cons>
    800003d8:	97b6                	add	a5,a5,a3
    800003da:	0187c683          	lbu	a3,24(a5)
    800003de:	47a9                	li	a5,10
    800003e0:	00011497          	auipc	s1,0x11
    800003e4:	42048493          	addi	s1,s1,1056 # 80011800 <cons>
    800003e8:	4929                	li	s2,10
    800003ea:	02f68f63          	beq	a3,a5,80000428 <consoleintr+0x150>
    800003ee:	0ae4a023          	sw	a4,160(s1)
    800003f2:	10000513          	li	a0,256
    800003f6:	00000097          	auipc	ra,0x0
    800003fa:	e08080e7          	jalr	-504(ra) # 800001fe <consputc>
    800003fe:	0a04a783          	lw	a5,160(s1)
    80000402:	09c4a703          	lw	a4,156(s1)
    80000406:	02f70163          	beq	a4,a5,80000428 <consoleintr+0x150>
    8000040a:	37fd                	addiw	a5,a5,-1
    8000040c:	0007871b          	sext.w	a4,a5
    80000410:	07f7f793          	andi	a5,a5,127
    80000414:	97a6                	add	a5,a5,s1
    80000416:	0187c783          	lbu	a5,24(a5)
    8000041a:	fd279ae3          	bne	a5,s2,800003ee <consoleintr+0x116>
    8000041e:	a029                	j	80000428 <consoleintr+0x150>
    80000420:	00002097          	auipc	ra,0x2
    80000424:	0b8080e7          	jalr	184(ra) # 800024d8 <procdump>
    80000428:	00011517          	auipc	a0,0x11
    8000042c:	3d850513          	addi	a0,a0,984 # 80011800 <cons>
    80000430:	00000097          	auipc	ra,0x0
    80000434:	722080e7          	jalr	1826(ra) # 80000b52 <release>
    80000438:	60e2                	ld	ra,24(sp)
    8000043a:	6442                	ld	s0,16(sp)
    8000043c:	64a2                	ld	s1,8(sp)
    8000043e:	6902                	ld	s2,0(sp)
    80000440:	6105                	addi	sp,sp,32
    80000442:	8082                	ret
    80000444:	4529                	li	a0,10
    80000446:	00000097          	auipc	ra,0x0
    8000044a:	db8080e7          	jalr	-584(ra) # 800001fe <consputc>
    8000044e:	00011797          	auipc	a5,0x11
    80000452:	3b278793          	addi	a5,a5,946 # 80011800 <cons>
    80000456:	0a07a703          	lw	a4,160(a5)
    8000045a:	0017069b          	addiw	a3,a4,1
    8000045e:	0006861b          	sext.w	a2,a3
    80000462:	0ad7a023          	sw	a3,160(a5)
    80000466:	07f77713          	andi	a4,a4,127
    8000046a:	97ba                	add	a5,a5,a4
    8000046c:	4729                	li	a4,10
    8000046e:	00e78c23          	sb	a4,24(a5)
    80000472:	00011797          	auipc	a5,0x11
    80000476:	42c7a523          	sw	a2,1066(a5) # 8001189c <cons+0x9c>
    8000047a:	00011517          	auipc	a0,0x11
    8000047e:	41e50513          	addi	a0,a0,1054 # 80011898 <cons+0x98>
    80000482:	00002097          	auipc	ra,0x2
    80000486:	ece080e7          	jalr	-306(ra) # 80002350 <wakeup>
    8000048a:	bf79                	j	80000428 <consoleintr+0x150>

000000008000048c <consoleinit>:
    8000048c:	1141                	addi	sp,sp,-16
    8000048e:	e406                	sd	ra,8(sp)
    80000490:	e022                	sd	s0,0(sp)
    80000492:	0800                	addi	s0,sp,16
    80000494:	00007597          	auipc	a1,0x7
    80000498:	c8458593          	addi	a1,a1,-892 # 80007118 <userret+0x88>
    8000049c:	00011517          	auipc	a0,0x11
    800004a0:	36450513          	addi	a0,a0,868 # 80011800 <cons>
    800004a4:	00000097          	auipc	ra,0x0
    800004a8:	54c080e7          	jalr	1356(ra) # 800009f0 <initlock>
    800004ac:	00000097          	auipc	ra,0x0
    800004b0:	334080e7          	jalr	820(ra) # 800007e0 <uartinit>
    800004b4:	00021797          	auipc	a5,0x21
    800004b8:	58c78793          	addi	a5,a5,1420 # 80021a40 <devsw>
    800004bc:	00000717          	auipc	a4,0x0
    800004c0:	c2670713          	addi	a4,a4,-986 # 800000e2 <consoleread>
    800004c4:	eb98                	sd	a4,16(a5)
    800004c6:	00000717          	auipc	a4,0x0
    800004ca:	d8a70713          	addi	a4,a4,-630 # 80000250 <consolewrite>
    800004ce:	ef98                	sd	a4,24(a5)
    800004d0:	60a2                	ld	ra,8(sp)
    800004d2:	6402                	ld	s0,0(sp)
    800004d4:	0141                	addi	sp,sp,16
    800004d6:	8082                	ret

00000000800004d8 <printint>:
    800004d8:	7179                	addi	sp,sp,-48
    800004da:	f406                	sd	ra,40(sp)
    800004dc:	f022                	sd	s0,32(sp)
    800004de:	ec26                	sd	s1,24(sp)
    800004e0:	e84a                	sd	s2,16(sp)
    800004e2:	1800                	addi	s0,sp,48
    800004e4:	c219                	beqz	a2,800004ea <printint+0x12>
    800004e6:	00054d63          	bltz	a0,80000500 <printint+0x28>
    800004ea:	2501                	sext.w	a0,a0
    800004ec:	4881                	li	a7,0
    800004ee:	fd040713          	addi	a4,s0,-48
    800004f2:	4601                	li	a2,0
    800004f4:	2581                	sext.w	a1,a1
    800004f6:	00007817          	auipc	a6,0x7
    800004fa:	69280813          	addi	a6,a6,1682 # 80007b88 <digits>
    800004fe:	a801                	j	8000050e <printint+0x36>
    80000500:	40a0053b          	negw	a0,a0
    80000504:	2501                	sext.w	a0,a0
    80000506:	4885                	li	a7,1
    80000508:	b7dd                	j	800004ee <printint+0x16>
    8000050a:	853e                	mv	a0,a5
    8000050c:	8636                	mv	a2,a3
    8000050e:	0016069b          	addiw	a3,a2,1
    80000512:	02b577bb          	remuw	a5,a0,a1
    80000516:	1782                	slli	a5,a5,0x20
    80000518:	9381                	srli	a5,a5,0x20
    8000051a:	97c2                	add	a5,a5,a6
    8000051c:	0007c783          	lbu	a5,0(a5)
    80000520:	00f70023          	sb	a5,0(a4)
    80000524:	0705                	addi	a4,a4,1
    80000526:	02b557bb          	divuw	a5,a0,a1
    8000052a:	feb570e3          	bleu	a1,a0,8000050a <printint+0x32>
    8000052e:	00088b63          	beqz	a7,80000544 <printint+0x6c>
    80000532:	fe040793          	addi	a5,s0,-32
    80000536:	96be                	add	a3,a3,a5
    80000538:	02d00793          	li	a5,45
    8000053c:	fef68823          	sb	a5,-16(a3)
    80000540:	0026069b          	addiw	a3,a2,2
    80000544:	02d05763          	blez	a3,80000572 <printint+0x9a>
    80000548:	fd040793          	addi	a5,s0,-48
    8000054c:	00d784b3          	add	s1,a5,a3
    80000550:	fff78913          	addi	s2,a5,-1
    80000554:	9936                	add	s2,s2,a3
    80000556:	36fd                	addiw	a3,a3,-1
    80000558:	1682                	slli	a3,a3,0x20
    8000055a:	9281                	srli	a3,a3,0x20
    8000055c:	40d90933          	sub	s2,s2,a3
    80000560:	fff4c503          	lbu	a0,-1(s1)
    80000564:	00000097          	auipc	ra,0x0
    80000568:	c9a080e7          	jalr	-870(ra) # 800001fe <consputc>
    8000056c:	14fd                	addi	s1,s1,-1
    8000056e:	ff2499e3          	bne	s1,s2,80000560 <printint+0x88>
    80000572:	70a2                	ld	ra,40(sp)
    80000574:	7402                	ld	s0,32(sp)
    80000576:	64e2                	ld	s1,24(sp)
    80000578:	6942                	ld	s2,16(sp)
    8000057a:	6145                	addi	sp,sp,48
    8000057c:	8082                	ret

000000008000057e <panic>:
    8000057e:	1101                	addi	sp,sp,-32
    80000580:	ec06                	sd	ra,24(sp)
    80000582:	e822                	sd	s0,16(sp)
    80000584:	e426                	sd	s1,8(sp)
    80000586:	1000                	addi	s0,sp,32
    80000588:	84aa                	mv	s1,a0
    8000058a:	00011797          	auipc	a5,0x11
    8000058e:	3207ab23          	sw	zero,822(a5) # 800118c0 <pr+0x18>
    80000592:	00007517          	auipc	a0,0x7
    80000596:	b8e50513          	addi	a0,a0,-1138 # 80007120 <userret+0x90>
    8000059a:	00000097          	auipc	ra,0x0
    8000059e:	02e080e7          	jalr	46(ra) # 800005c8 <printf>
    800005a2:	8526                	mv	a0,s1
    800005a4:	00000097          	auipc	ra,0x0
    800005a8:	024080e7          	jalr	36(ra) # 800005c8 <printf>
    800005ac:	00007517          	auipc	a0,0x7
    800005b0:	f7c50513          	addi	a0,a0,-132 # 80007528 <userret+0x498>
    800005b4:	00000097          	auipc	ra,0x0
    800005b8:	014080e7          	jalr	20(ra) # 800005c8 <printf>
    800005bc:	4785                	li	a5,1
    800005be:	00026717          	auipc	a4,0x26
    800005c2:	a4f72123          	sw	a5,-1470(a4) # 80026000 <panicked>
    800005c6:	a001                	j	800005c6 <panic+0x48>

00000000800005c8 <printf>:
    800005c8:	7131                	addi	sp,sp,-192
    800005ca:	fc86                	sd	ra,120(sp)
    800005cc:	f8a2                	sd	s0,112(sp)
    800005ce:	f4a6                	sd	s1,104(sp)
    800005d0:	f0ca                	sd	s2,96(sp)
    800005d2:	ecce                	sd	s3,88(sp)
    800005d4:	e8d2                	sd	s4,80(sp)
    800005d6:	e4d6                	sd	s5,72(sp)
    800005d8:	e0da                	sd	s6,64(sp)
    800005da:	fc5e                	sd	s7,56(sp)
    800005dc:	f862                	sd	s8,48(sp)
    800005de:	f466                	sd	s9,40(sp)
    800005e0:	f06a                	sd	s10,32(sp)
    800005e2:	ec6e                	sd	s11,24(sp)
    800005e4:	0100                	addi	s0,sp,128
    800005e6:	8aaa                	mv	s5,a0
    800005e8:	e40c                	sd	a1,8(s0)
    800005ea:	e810                	sd	a2,16(s0)
    800005ec:	ec14                	sd	a3,24(s0)
    800005ee:	f018                	sd	a4,32(s0)
    800005f0:	f41c                	sd	a5,40(s0)
    800005f2:	03043823          	sd	a6,48(s0)
    800005f6:	03143c23          	sd	a7,56(s0)
    800005fa:	00011797          	auipc	a5,0x11
    800005fe:	2ae78793          	addi	a5,a5,686 # 800118a8 <pr>
    80000602:	0187ad83          	lw	s11,24(a5)
    80000606:	020d9b63          	bnez	s11,8000063c <printf+0x74>
    8000060a:	020a8f63          	beqz	s5,80000648 <printf+0x80>
    8000060e:	00840793          	addi	a5,s0,8
    80000612:	f8f43423          	sd	a5,-120(s0)
    80000616:	000ac503          	lbu	a0,0(s5)
    8000061a:	16050063          	beqz	a0,8000077a <printf+0x1b2>
    8000061e:	4481                	li	s1,0
    80000620:	02500a13          	li	s4,37
    80000624:	07000b13          	li	s6,112
    80000628:	4d41                	li	s10,16
    8000062a:	00007b97          	auipc	s7,0x7
    8000062e:	55eb8b93          	addi	s7,s7,1374 # 80007b88 <digits>
    80000632:	07300c93          	li	s9,115
    80000636:	06400c13          	li	s8,100
    8000063a:	a815                	j	8000066e <printf+0xa6>
    8000063c:	853e                	mv	a0,a5
    8000063e:	00000097          	auipc	ra,0x0
    80000642:	4c0080e7          	jalr	1216(ra) # 80000afe <acquire>
    80000646:	b7d1                	j	8000060a <printf+0x42>
    80000648:	00007517          	auipc	a0,0x7
    8000064c:	ae850513          	addi	a0,a0,-1304 # 80007130 <userret+0xa0>
    80000650:	00000097          	auipc	ra,0x0
    80000654:	f2e080e7          	jalr	-210(ra) # 8000057e <panic>
    80000658:	00000097          	auipc	ra,0x0
    8000065c:	ba6080e7          	jalr	-1114(ra) # 800001fe <consputc>
    80000660:	2485                	addiw	s1,s1,1
    80000662:	009a87b3          	add	a5,s5,s1
    80000666:	0007c503          	lbu	a0,0(a5)
    8000066a:	10050863          	beqz	a0,8000077a <printf+0x1b2>
    8000066e:	ff4515e3          	bne	a0,s4,80000658 <printf+0x90>
    80000672:	2485                	addiw	s1,s1,1
    80000674:	009a87b3          	add	a5,s5,s1
    80000678:	0007c783          	lbu	a5,0(a5)
    8000067c:	0007891b          	sext.w	s2,a5
    80000680:	0e090d63          	beqz	s2,8000077a <printf+0x1b2>
    80000684:	05678a63          	beq	a5,s6,800006d8 <printf+0x110>
    80000688:	02fb7663          	bleu	a5,s6,800006b4 <printf+0xec>
    8000068c:	09978963          	beq	a5,s9,8000071e <printf+0x156>
    80000690:	07800713          	li	a4,120
    80000694:	0ce79863          	bne	a5,a4,80000764 <printf+0x19c>
    80000698:	f8843783          	ld	a5,-120(s0)
    8000069c:	00878713          	addi	a4,a5,8
    800006a0:	f8e43423          	sd	a4,-120(s0)
    800006a4:	4605                	li	a2,1
    800006a6:	85ea                	mv	a1,s10
    800006a8:	4388                	lw	a0,0(a5)
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	e2e080e7          	jalr	-466(ra) # 800004d8 <printint>
    800006b2:	b77d                	j	80000660 <printf+0x98>
    800006b4:	0b478263          	beq	a5,s4,80000758 <printf+0x190>
    800006b8:	0b879663          	bne	a5,s8,80000764 <printf+0x19c>
    800006bc:	f8843783          	ld	a5,-120(s0)
    800006c0:	00878713          	addi	a4,a5,8
    800006c4:	f8e43423          	sd	a4,-120(s0)
    800006c8:	4605                	li	a2,1
    800006ca:	45a9                	li	a1,10
    800006cc:	4388                	lw	a0,0(a5)
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	e0a080e7          	jalr	-502(ra) # 800004d8 <printint>
    800006d6:	b769                	j	80000660 <printf+0x98>
    800006d8:	f8843783          	ld	a5,-120(s0)
    800006dc:	00878713          	addi	a4,a5,8
    800006e0:	f8e43423          	sd	a4,-120(s0)
    800006e4:	0007b983          	ld	s3,0(a5)
    800006e8:	03000513          	li	a0,48
    800006ec:	00000097          	auipc	ra,0x0
    800006f0:	b12080e7          	jalr	-1262(ra) # 800001fe <consputc>
    800006f4:	07800513          	li	a0,120
    800006f8:	00000097          	auipc	ra,0x0
    800006fc:	b06080e7          	jalr	-1274(ra) # 800001fe <consputc>
    80000700:	896a                	mv	s2,s10
    80000702:	03c9d793          	srli	a5,s3,0x3c
    80000706:	97de                	add	a5,a5,s7
    80000708:	0007c503          	lbu	a0,0(a5)
    8000070c:	00000097          	auipc	ra,0x0
    80000710:	af2080e7          	jalr	-1294(ra) # 800001fe <consputc>
    80000714:	0992                	slli	s3,s3,0x4
    80000716:	397d                	addiw	s2,s2,-1
    80000718:	fe0915e3          	bnez	s2,80000702 <printf+0x13a>
    8000071c:	b791                	j	80000660 <printf+0x98>
    8000071e:	f8843783          	ld	a5,-120(s0)
    80000722:	00878713          	addi	a4,a5,8
    80000726:	f8e43423          	sd	a4,-120(s0)
    8000072a:	0007b903          	ld	s2,0(a5)
    8000072e:	00090e63          	beqz	s2,8000074a <printf+0x182>
    80000732:	00094503          	lbu	a0,0(s2)
    80000736:	d50d                	beqz	a0,80000660 <printf+0x98>
    80000738:	00000097          	auipc	ra,0x0
    8000073c:	ac6080e7          	jalr	-1338(ra) # 800001fe <consputc>
    80000740:	0905                	addi	s2,s2,1
    80000742:	00094503          	lbu	a0,0(s2)
    80000746:	f96d                	bnez	a0,80000738 <printf+0x170>
    80000748:	bf21                	j	80000660 <printf+0x98>
    8000074a:	00007917          	auipc	s2,0x7
    8000074e:	9de90913          	addi	s2,s2,-1570 # 80007128 <userret+0x98>
    80000752:	02800513          	li	a0,40
    80000756:	b7cd                	j	80000738 <printf+0x170>
    80000758:	8552                	mv	a0,s4
    8000075a:	00000097          	auipc	ra,0x0
    8000075e:	aa4080e7          	jalr	-1372(ra) # 800001fe <consputc>
    80000762:	bdfd                	j	80000660 <printf+0x98>
    80000764:	8552                	mv	a0,s4
    80000766:	00000097          	auipc	ra,0x0
    8000076a:	a98080e7          	jalr	-1384(ra) # 800001fe <consputc>
    8000076e:	854a                	mv	a0,s2
    80000770:	00000097          	auipc	ra,0x0
    80000774:	a8e080e7          	jalr	-1394(ra) # 800001fe <consputc>
    80000778:	b5e5                	j	80000660 <printf+0x98>
    8000077a:	020d9163          	bnez	s11,8000079c <printf+0x1d4>
    8000077e:	70e6                	ld	ra,120(sp)
    80000780:	7446                	ld	s0,112(sp)
    80000782:	74a6                	ld	s1,104(sp)
    80000784:	7906                	ld	s2,96(sp)
    80000786:	69e6                	ld	s3,88(sp)
    80000788:	6a46                	ld	s4,80(sp)
    8000078a:	6aa6                	ld	s5,72(sp)
    8000078c:	6b06                	ld	s6,64(sp)
    8000078e:	7be2                	ld	s7,56(sp)
    80000790:	7c42                	ld	s8,48(sp)
    80000792:	7ca2                	ld	s9,40(sp)
    80000794:	7d02                	ld	s10,32(sp)
    80000796:	6de2                	ld	s11,24(sp)
    80000798:	6129                	addi	sp,sp,192
    8000079a:	8082                	ret
    8000079c:	00011517          	auipc	a0,0x11
    800007a0:	10c50513          	addi	a0,a0,268 # 800118a8 <pr>
    800007a4:	00000097          	auipc	ra,0x0
    800007a8:	3ae080e7          	jalr	942(ra) # 80000b52 <release>
    800007ac:	bfc9                	j	8000077e <printf+0x1b6>

00000000800007ae <printfinit>:
    800007ae:	1101                	addi	sp,sp,-32
    800007b0:	ec06                	sd	ra,24(sp)
    800007b2:	e822                	sd	s0,16(sp)
    800007b4:	e426                	sd	s1,8(sp)
    800007b6:	1000                	addi	s0,sp,32
    800007b8:	00011497          	auipc	s1,0x11
    800007bc:	0f048493          	addi	s1,s1,240 # 800118a8 <pr>
    800007c0:	00007597          	auipc	a1,0x7
    800007c4:	98058593          	addi	a1,a1,-1664 # 80007140 <userret+0xb0>
    800007c8:	8526                	mv	a0,s1
    800007ca:	00000097          	auipc	ra,0x0
    800007ce:	226080e7          	jalr	550(ra) # 800009f0 <initlock>
    800007d2:	4785                	li	a5,1
    800007d4:	cc9c                	sw	a5,24(s1)
    800007d6:	60e2                	ld	ra,24(sp)
    800007d8:	6442                	ld	s0,16(sp)
    800007da:	64a2                	ld	s1,8(sp)
    800007dc:	6105                	addi	sp,sp,32
    800007de:	8082                	ret

00000000800007e0 <uartinit>:
    800007e0:	1141                	addi	sp,sp,-16
    800007e2:	e422                	sd	s0,8(sp)
    800007e4:	0800                	addi	s0,sp,16
    800007e6:	100007b7          	lui	a5,0x10000
    800007ea:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800007ee:	f8000713          	li	a4,-128
    800007f2:	00e781a3          	sb	a4,3(a5)
    800007f6:	470d                	li	a4,3
    800007f8:	00e78023          	sb	a4,0(a5)
    800007fc:	000780a3          	sb	zero,1(a5)
    80000800:	00e781a3          	sb	a4,3(a5)
    80000804:	471d                	li	a4,7
    80000806:	00e78123          	sb	a4,2(a5)
    8000080a:	4705                	li	a4,1
    8000080c:	00e780a3          	sb	a4,1(a5)
    80000810:	6422                	ld	s0,8(sp)
    80000812:	0141                	addi	sp,sp,16
    80000814:	8082                	ret

0000000080000816 <uartputc>:
    80000816:	1141                	addi	sp,sp,-16
    80000818:	e422                	sd	s0,8(sp)
    8000081a:	0800                	addi	s0,sp,16
    8000081c:	10000737          	lui	a4,0x10000
    80000820:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000824:	0ff7f793          	andi	a5,a5,255
    80000828:	0207f793          	andi	a5,a5,32
    8000082c:	dbf5                	beqz	a5,80000820 <uartputc+0xa>
    8000082e:	0ff57513          	andi	a0,a0,255
    80000832:	100007b7          	lui	a5,0x10000
    80000836:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000083a:	6422                	ld	s0,8(sp)
    8000083c:	0141                	addi	sp,sp,16
    8000083e:	8082                	ret

0000000080000840 <uartgetc>:
    80000840:	1141                	addi	sp,sp,-16
    80000842:	e422                	sd	s0,8(sp)
    80000844:	0800                	addi	s0,sp,16
    80000846:	100007b7          	lui	a5,0x10000
    8000084a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000084e:	8b85                	andi	a5,a5,1
    80000850:	cb81                	beqz	a5,80000860 <uartgetc+0x20>
    80000852:	100007b7          	lui	a5,0x10000
    80000856:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000085a:	6422                	ld	s0,8(sp)
    8000085c:	0141                	addi	sp,sp,16
    8000085e:	8082                	ret
    80000860:	557d                	li	a0,-1
    80000862:	bfe5                	j	8000085a <uartgetc+0x1a>

0000000080000864 <uartintr>:
    80000864:	1101                	addi	sp,sp,-32
    80000866:	ec06                	sd	ra,24(sp)
    80000868:	e822                	sd	s0,16(sp)
    8000086a:	e426                	sd	s1,8(sp)
    8000086c:	1000                	addi	s0,sp,32
    8000086e:	54fd                	li	s1,-1
    80000870:	00000097          	auipc	ra,0x0
    80000874:	fd0080e7          	jalr	-48(ra) # 80000840 <uartgetc>
    80000878:	00950763          	beq	a0,s1,80000886 <uartintr+0x22>
    8000087c:	00000097          	auipc	ra,0x0
    80000880:	a5c080e7          	jalr	-1444(ra) # 800002d8 <consoleintr>
    80000884:	b7f5                	j	80000870 <uartintr+0xc>
    80000886:	60e2                	ld	ra,24(sp)
    80000888:	6442                	ld	s0,16(sp)
    8000088a:	64a2                	ld	s1,8(sp)
    8000088c:	6105                	addi	sp,sp,32
    8000088e:	8082                	ret

0000000080000890 <kfree>:
    80000890:	1101                	addi	sp,sp,-32
    80000892:	ec06                	sd	ra,24(sp)
    80000894:	e822                	sd	s0,16(sp)
    80000896:	e426                	sd	s1,8(sp)
    80000898:	e04a                	sd	s2,0(sp)
    8000089a:	1000                	addi	s0,sp,32
    8000089c:	6785                	lui	a5,0x1
    8000089e:	17fd                	addi	a5,a5,-1
    800008a0:	8fe9                	and	a5,a5,a0
    800008a2:	ebb9                	bnez	a5,800008f8 <kfree+0x68>
    800008a4:	84aa                	mv	s1,a0
    800008a6:	00025797          	auipc	a5,0x25
    800008aa:	77678793          	addi	a5,a5,1910 # 8002601c <end>
    800008ae:	04f56563          	bltu	a0,a5,800008f8 <kfree+0x68>
    800008b2:	47c5                	li	a5,17
    800008b4:	07ee                	slli	a5,a5,0x1b
    800008b6:	04f57163          	bleu	a5,a0,800008f8 <kfree+0x68>
    800008ba:	6605                	lui	a2,0x1
    800008bc:	4585                	li	a1,1
    800008be:	00000097          	auipc	ra,0x0
    800008c2:	2dc080e7          	jalr	732(ra) # 80000b9a <memset>
    800008c6:	00011917          	auipc	s2,0x11
    800008ca:	00290913          	addi	s2,s2,2 # 800118c8 <kmem>
    800008ce:	854a                	mv	a0,s2
    800008d0:	00000097          	auipc	ra,0x0
    800008d4:	22e080e7          	jalr	558(ra) # 80000afe <acquire>
    800008d8:	01893783          	ld	a5,24(s2)
    800008dc:	e09c                	sd	a5,0(s1)
    800008de:	00993c23          	sd	s1,24(s2)
    800008e2:	854a                	mv	a0,s2
    800008e4:	00000097          	auipc	ra,0x0
    800008e8:	26e080e7          	jalr	622(ra) # 80000b52 <release>
    800008ec:	60e2                	ld	ra,24(sp)
    800008ee:	6442                	ld	s0,16(sp)
    800008f0:	64a2                	ld	s1,8(sp)
    800008f2:	6902                	ld	s2,0(sp)
    800008f4:	6105                	addi	sp,sp,32
    800008f6:	8082                	ret
    800008f8:	00007517          	auipc	a0,0x7
    800008fc:	85050513          	addi	a0,a0,-1968 # 80007148 <userret+0xb8>
    80000900:	00000097          	auipc	ra,0x0
    80000904:	c7e080e7          	jalr	-898(ra) # 8000057e <panic>

0000000080000908 <freerange>:
    80000908:	7179                	addi	sp,sp,-48
    8000090a:	f406                	sd	ra,40(sp)
    8000090c:	f022                	sd	s0,32(sp)
    8000090e:	ec26                	sd	s1,24(sp)
    80000910:	e84a                	sd	s2,16(sp)
    80000912:	e44e                	sd	s3,8(sp)
    80000914:	e052                	sd	s4,0(sp)
    80000916:	1800                	addi	s0,sp,48
    80000918:	6705                	lui	a4,0x1
    8000091a:	fff70793          	addi	a5,a4,-1 # fff <_entry-0x7ffff001>
    8000091e:	00f504b3          	add	s1,a0,a5
    80000922:	77fd                	lui	a5,0xfffff
    80000924:	8cfd                	and	s1,s1,a5
    80000926:	94ba                	add	s1,s1,a4
    80000928:	0095ee63          	bltu	a1,s1,80000944 <freerange+0x3c>
    8000092c:	892e                	mv	s2,a1
    8000092e:	7a7d                	lui	s4,0xfffff
    80000930:	6985                	lui	s3,0x1
    80000932:	01448533          	add	a0,s1,s4
    80000936:	00000097          	auipc	ra,0x0
    8000093a:	f5a080e7          	jalr	-166(ra) # 80000890 <kfree>
    8000093e:	94ce                	add	s1,s1,s3
    80000940:	fe9979e3          	bleu	s1,s2,80000932 <freerange+0x2a>
    80000944:	70a2                	ld	ra,40(sp)
    80000946:	7402                	ld	s0,32(sp)
    80000948:	64e2                	ld	s1,24(sp)
    8000094a:	6942                	ld	s2,16(sp)
    8000094c:	69a2                	ld	s3,8(sp)
    8000094e:	6a02                	ld	s4,0(sp)
    80000950:	6145                	addi	sp,sp,48
    80000952:	8082                	ret

0000000080000954 <kinit>:
    80000954:	1141                	addi	sp,sp,-16
    80000956:	e406                	sd	ra,8(sp)
    80000958:	e022                	sd	s0,0(sp)
    8000095a:	0800                	addi	s0,sp,16
    8000095c:	00006597          	auipc	a1,0x6
    80000960:	7f458593          	addi	a1,a1,2036 # 80007150 <userret+0xc0>
    80000964:	00011517          	auipc	a0,0x11
    80000968:	f6450513          	addi	a0,a0,-156 # 800118c8 <kmem>
    8000096c:	00000097          	auipc	ra,0x0
    80000970:	084080e7          	jalr	132(ra) # 800009f0 <initlock>
    80000974:	45c5                	li	a1,17
    80000976:	05ee                	slli	a1,a1,0x1b
    80000978:	00025517          	auipc	a0,0x25
    8000097c:	6a450513          	addi	a0,a0,1700 # 8002601c <end>
    80000980:	00000097          	auipc	ra,0x0
    80000984:	f88080e7          	jalr	-120(ra) # 80000908 <freerange>
    80000988:	60a2                	ld	ra,8(sp)
    8000098a:	6402                	ld	s0,0(sp)
    8000098c:	0141                	addi	sp,sp,16
    8000098e:	8082                	ret

0000000080000990 <kalloc>:
    80000990:	1101                	addi	sp,sp,-32
    80000992:	ec06                	sd	ra,24(sp)
    80000994:	e822                	sd	s0,16(sp)
    80000996:	e426                	sd	s1,8(sp)
    80000998:	1000                	addi	s0,sp,32
    8000099a:	00011497          	auipc	s1,0x11
    8000099e:	f2e48493          	addi	s1,s1,-210 # 800118c8 <kmem>
    800009a2:	8526                	mv	a0,s1
    800009a4:	00000097          	auipc	ra,0x0
    800009a8:	15a080e7          	jalr	346(ra) # 80000afe <acquire>
    800009ac:	6c84                	ld	s1,24(s1)
    800009ae:	c885                	beqz	s1,800009de <kalloc+0x4e>
    800009b0:	609c                	ld	a5,0(s1)
    800009b2:	00011517          	auipc	a0,0x11
    800009b6:	f1650513          	addi	a0,a0,-234 # 800118c8 <kmem>
    800009ba:	ed1c                	sd	a5,24(a0)
    800009bc:	00000097          	auipc	ra,0x0
    800009c0:	196080e7          	jalr	406(ra) # 80000b52 <release>
    800009c4:	6605                	lui	a2,0x1
    800009c6:	4595                	li	a1,5
    800009c8:	8526                	mv	a0,s1
    800009ca:	00000097          	auipc	ra,0x0
    800009ce:	1d0080e7          	jalr	464(ra) # 80000b9a <memset>
    800009d2:	8526                	mv	a0,s1
    800009d4:	60e2                	ld	ra,24(sp)
    800009d6:	6442                	ld	s0,16(sp)
    800009d8:	64a2                	ld	s1,8(sp)
    800009da:	6105                	addi	sp,sp,32
    800009dc:	8082                	ret
    800009de:	00011517          	auipc	a0,0x11
    800009e2:	eea50513          	addi	a0,a0,-278 # 800118c8 <kmem>
    800009e6:	00000097          	auipc	ra,0x0
    800009ea:	16c080e7          	jalr	364(ra) # 80000b52 <release>
    800009ee:	b7d5                	j	800009d2 <kalloc+0x42>

00000000800009f0 <initlock>:
    800009f0:	1141                	addi	sp,sp,-16
    800009f2:	e422                	sd	s0,8(sp)
    800009f4:	0800                	addi	s0,sp,16
    800009f6:	e50c                	sd	a1,8(a0)
    800009f8:	00052023          	sw	zero,0(a0)
    800009fc:	00053823          	sd	zero,16(a0)
    80000a00:	6422                	ld	s0,8(sp)
    80000a02:	0141                	addi	sp,sp,16
    80000a04:	8082                	ret

0000000080000a06 <push_off>:
    80000a06:	1101                	addi	sp,sp,-32
    80000a08:	ec06                	sd	ra,24(sp)
    80000a0a:	e822                	sd	s0,16(sp)
    80000a0c:	e426                	sd	s1,8(sp)
    80000a0e:	1000                	addi	s0,sp,32
    80000a10:	100024f3          	csrr	s1,sstatus
    80000a14:	100027f3          	csrr	a5,sstatus
    80000a18:	9bf5                	andi	a5,a5,-3
    80000a1a:	10079073          	csrw	sstatus,a5
    80000a1e:	00001097          	auipc	ra,0x1
    80000a22:	fe4080e7          	jalr	-28(ra) # 80001a02 <mycpu>
    80000a26:	5d3c                	lw	a5,120(a0)
    80000a28:	cf89                	beqz	a5,80000a42 <push_off+0x3c>
    80000a2a:	00001097          	auipc	ra,0x1
    80000a2e:	fd8080e7          	jalr	-40(ra) # 80001a02 <mycpu>
    80000a32:	5d3c                	lw	a5,120(a0)
    80000a34:	2785                	addiw	a5,a5,1
    80000a36:	dd3c                	sw	a5,120(a0)
    80000a38:	60e2                	ld	ra,24(sp)
    80000a3a:	6442                	ld	s0,16(sp)
    80000a3c:	64a2                	ld	s1,8(sp)
    80000a3e:	6105                	addi	sp,sp,32
    80000a40:	8082                	ret
    80000a42:	00001097          	auipc	ra,0x1
    80000a46:	fc0080e7          	jalr	-64(ra) # 80001a02 <mycpu>
    80000a4a:	8085                	srli	s1,s1,0x1
    80000a4c:	8885                	andi	s1,s1,1
    80000a4e:	dd64                	sw	s1,124(a0)
    80000a50:	bfe9                	j	80000a2a <push_off+0x24>

0000000080000a52 <pop_off>:
    80000a52:	1141                	addi	sp,sp,-16
    80000a54:	e406                	sd	ra,8(sp)
    80000a56:	e022                	sd	s0,0(sp)
    80000a58:	0800                	addi	s0,sp,16
    80000a5a:	00001097          	auipc	ra,0x1
    80000a5e:	fa8080e7          	jalr	-88(ra) # 80001a02 <mycpu>
    80000a62:	100027f3          	csrr	a5,sstatus
    80000a66:	8b89                	andi	a5,a5,2
    80000a68:	eb9d                	bnez	a5,80000a9e <pop_off+0x4c>
    80000a6a:	5d3c                	lw	a5,120(a0)
    80000a6c:	37fd                	addiw	a5,a5,-1
    80000a6e:	0007871b          	sext.w	a4,a5
    80000a72:	dd3c                	sw	a5,120(a0)
    80000a74:	02074d63          	bltz	a4,80000aae <pop_off+0x5c>
    80000a78:	ef19                	bnez	a4,80000a96 <pop_off+0x44>
    80000a7a:	5d7c                	lw	a5,124(a0)
    80000a7c:	cf89                	beqz	a5,80000a96 <pop_off+0x44>
    80000a7e:	104027f3          	csrr	a5,sie
    80000a82:	2227e793          	ori	a5,a5,546
    80000a86:	10479073          	csrw	sie,a5
    80000a8a:	100027f3          	csrr	a5,sstatus
    80000a8e:	0027e793          	ori	a5,a5,2
    80000a92:	10079073          	csrw	sstatus,a5
    80000a96:	60a2                	ld	ra,8(sp)
    80000a98:	6402                	ld	s0,0(sp)
    80000a9a:	0141                	addi	sp,sp,16
    80000a9c:	8082                	ret
    80000a9e:	00006517          	auipc	a0,0x6
    80000aa2:	6ba50513          	addi	a0,a0,1722 # 80007158 <userret+0xc8>
    80000aa6:	00000097          	auipc	ra,0x0
    80000aaa:	ad8080e7          	jalr	-1320(ra) # 8000057e <panic>
    80000aae:	00006517          	auipc	a0,0x6
    80000ab2:	6c250513          	addi	a0,a0,1730 # 80007170 <userret+0xe0>
    80000ab6:	00000097          	auipc	ra,0x0
    80000aba:	ac8080e7          	jalr	-1336(ra) # 8000057e <panic>

0000000080000abe <holding>:
    80000abe:	1101                	addi	sp,sp,-32
    80000ac0:	ec06                	sd	ra,24(sp)
    80000ac2:	e822                	sd	s0,16(sp)
    80000ac4:	e426                	sd	s1,8(sp)
    80000ac6:	1000                	addi	s0,sp,32
    80000ac8:	84aa                	mv	s1,a0
    80000aca:	00000097          	auipc	ra,0x0
    80000ace:	f3c080e7          	jalr	-196(ra) # 80000a06 <push_off>
    80000ad2:	409c                	lw	a5,0(s1)
    80000ad4:	ef81                	bnez	a5,80000aec <holding+0x2e>
    80000ad6:	4481                	li	s1,0
    80000ad8:	00000097          	auipc	ra,0x0
    80000adc:	f7a080e7          	jalr	-134(ra) # 80000a52 <pop_off>
    80000ae0:	8526                	mv	a0,s1
    80000ae2:	60e2                	ld	ra,24(sp)
    80000ae4:	6442                	ld	s0,16(sp)
    80000ae6:	64a2                	ld	s1,8(sp)
    80000ae8:	6105                	addi	sp,sp,32
    80000aea:	8082                	ret
    80000aec:	6884                	ld	s1,16(s1)
    80000aee:	00001097          	auipc	ra,0x1
    80000af2:	f14080e7          	jalr	-236(ra) # 80001a02 <mycpu>
    80000af6:	8c89                	sub	s1,s1,a0
    80000af8:	0014b493          	seqz	s1,s1
    80000afc:	bff1                	j	80000ad8 <holding+0x1a>

0000000080000afe <acquire>:
    80000afe:	1101                	addi	sp,sp,-32
    80000b00:	ec06                	sd	ra,24(sp)
    80000b02:	e822                	sd	s0,16(sp)
    80000b04:	e426                	sd	s1,8(sp)
    80000b06:	1000                	addi	s0,sp,32
    80000b08:	84aa                	mv	s1,a0
    80000b0a:	00000097          	auipc	ra,0x0
    80000b0e:	efc080e7          	jalr	-260(ra) # 80000a06 <push_off>
    80000b12:	8526                	mv	a0,s1
    80000b14:	00000097          	auipc	ra,0x0
    80000b18:	faa080e7          	jalr	-86(ra) # 80000abe <holding>
    80000b1c:	4705                	li	a4,1
    80000b1e:	e115                	bnez	a0,80000b42 <acquire+0x44>
    80000b20:	87ba                	mv	a5,a4
    80000b22:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000b26:	2781                	sext.w	a5,a5
    80000b28:	ffe5                	bnez	a5,80000b20 <acquire+0x22>
    80000b2a:	0ff0000f          	fence
    80000b2e:	00001097          	auipc	ra,0x1
    80000b32:	ed4080e7          	jalr	-300(ra) # 80001a02 <mycpu>
    80000b36:	e888                	sd	a0,16(s1)
    80000b38:	60e2                	ld	ra,24(sp)
    80000b3a:	6442                	ld	s0,16(sp)
    80000b3c:	64a2                	ld	s1,8(sp)
    80000b3e:	6105                	addi	sp,sp,32
    80000b40:	8082                	ret
    80000b42:	00006517          	auipc	a0,0x6
    80000b46:	63650513          	addi	a0,a0,1590 # 80007178 <userret+0xe8>
    80000b4a:	00000097          	auipc	ra,0x0
    80000b4e:	a34080e7          	jalr	-1484(ra) # 8000057e <panic>

0000000080000b52 <release>:
    80000b52:	1101                	addi	sp,sp,-32
    80000b54:	ec06                	sd	ra,24(sp)
    80000b56:	e822                	sd	s0,16(sp)
    80000b58:	e426                	sd	s1,8(sp)
    80000b5a:	1000                	addi	s0,sp,32
    80000b5c:	84aa                	mv	s1,a0
    80000b5e:	00000097          	auipc	ra,0x0
    80000b62:	f60080e7          	jalr	-160(ra) # 80000abe <holding>
    80000b66:	c115                	beqz	a0,80000b8a <release+0x38>
    80000b68:	0004b823          	sd	zero,16(s1)
    80000b6c:	0ff0000f          	fence
    80000b70:	0f50000f          	fence	iorw,ow
    80000b74:	0804a02f          	amoswap.w	zero,zero,(s1)
    80000b78:	00000097          	auipc	ra,0x0
    80000b7c:	eda080e7          	jalr	-294(ra) # 80000a52 <pop_off>
    80000b80:	60e2                	ld	ra,24(sp)
    80000b82:	6442                	ld	s0,16(sp)
    80000b84:	64a2                	ld	s1,8(sp)
    80000b86:	6105                	addi	sp,sp,32
    80000b88:	8082                	ret
    80000b8a:	00006517          	auipc	a0,0x6
    80000b8e:	5f650513          	addi	a0,a0,1526 # 80007180 <userret+0xf0>
    80000b92:	00000097          	auipc	ra,0x0
    80000b96:	9ec080e7          	jalr	-1556(ra) # 8000057e <panic>

0000000080000b9a <memset>:
    80000b9a:	1141                	addi	sp,sp,-16
    80000b9c:	e422                	sd	s0,8(sp)
    80000b9e:	0800                	addi	s0,sp,16
    80000ba0:	ce09                	beqz	a2,80000bba <memset+0x20>
    80000ba2:	87aa                	mv	a5,a0
    80000ba4:	fff6071b          	addiw	a4,a2,-1
    80000ba8:	1702                	slli	a4,a4,0x20
    80000baa:	9301                	srli	a4,a4,0x20
    80000bac:	0705                	addi	a4,a4,1
    80000bae:	972a                	add	a4,a4,a0
    80000bb0:	00b78023          	sb	a1,0(a5) # fffffffffffff000 <end+0xffffffff7ffd8fe4>
    80000bb4:	0785                	addi	a5,a5,1
    80000bb6:	fee79de3          	bne	a5,a4,80000bb0 <memset+0x16>
    80000bba:	6422                	ld	s0,8(sp)
    80000bbc:	0141                	addi	sp,sp,16
    80000bbe:	8082                	ret

0000000080000bc0 <memcmp>:
    80000bc0:	1141                	addi	sp,sp,-16
    80000bc2:	e422                	sd	s0,8(sp)
    80000bc4:	0800                	addi	s0,sp,16
    80000bc6:	ce15                	beqz	a2,80000c02 <memcmp+0x42>
    80000bc8:	fff6069b          	addiw	a3,a2,-1
    80000bcc:	00054783          	lbu	a5,0(a0)
    80000bd0:	0005c703          	lbu	a4,0(a1)
    80000bd4:	02e79063          	bne	a5,a4,80000bf4 <memcmp+0x34>
    80000bd8:	1682                	slli	a3,a3,0x20
    80000bda:	9281                	srli	a3,a3,0x20
    80000bdc:	0685                	addi	a3,a3,1
    80000bde:	96aa                	add	a3,a3,a0
    80000be0:	0505                	addi	a0,a0,1
    80000be2:	0585                	addi	a1,a1,1
    80000be4:	00d50d63          	beq	a0,a3,80000bfe <memcmp+0x3e>
    80000be8:	00054783          	lbu	a5,0(a0)
    80000bec:	0005c703          	lbu	a4,0(a1)
    80000bf0:	fee788e3          	beq	a5,a4,80000be0 <memcmp+0x20>
    80000bf4:	40e7853b          	subw	a0,a5,a4
    80000bf8:	6422                	ld	s0,8(sp)
    80000bfa:	0141                	addi	sp,sp,16
    80000bfc:	8082                	ret
    80000bfe:	4501                	li	a0,0
    80000c00:	bfe5                	j	80000bf8 <memcmp+0x38>
    80000c02:	4501                	li	a0,0
    80000c04:	bfd5                	j	80000bf8 <memcmp+0x38>

0000000080000c06 <memmove>:
    80000c06:	1141                	addi	sp,sp,-16
    80000c08:	e422                	sd	s0,8(sp)
    80000c0a:	0800                	addi	s0,sp,16
    80000c0c:	00a5f963          	bleu	a0,a1,80000c1e <memmove+0x18>
    80000c10:	02061713          	slli	a4,a2,0x20
    80000c14:	9301                	srli	a4,a4,0x20
    80000c16:	00e587b3          	add	a5,a1,a4
    80000c1a:	02f56563          	bltu	a0,a5,80000c44 <memmove+0x3e>
    80000c1e:	fff6069b          	addiw	a3,a2,-1
    80000c22:	ce11                	beqz	a2,80000c3e <memmove+0x38>
    80000c24:	1682                	slli	a3,a3,0x20
    80000c26:	9281                	srli	a3,a3,0x20
    80000c28:	0685                	addi	a3,a3,1
    80000c2a:	96ae                	add	a3,a3,a1
    80000c2c:	87aa                	mv	a5,a0
    80000c2e:	0585                	addi	a1,a1,1
    80000c30:	0785                	addi	a5,a5,1
    80000c32:	fff5c703          	lbu	a4,-1(a1)
    80000c36:	fee78fa3          	sb	a4,-1(a5)
    80000c3a:	fed59ae3          	bne	a1,a3,80000c2e <memmove+0x28>
    80000c3e:	6422                	ld	s0,8(sp)
    80000c40:	0141                	addi	sp,sp,16
    80000c42:	8082                	ret
    80000c44:	972a                	add	a4,a4,a0
    80000c46:	fff6069b          	addiw	a3,a2,-1
    80000c4a:	da75                	beqz	a2,80000c3e <memmove+0x38>
    80000c4c:	02069613          	slli	a2,a3,0x20
    80000c50:	9201                	srli	a2,a2,0x20
    80000c52:	fff64613          	not	a2,a2
    80000c56:	963e                	add	a2,a2,a5
    80000c58:	17fd                	addi	a5,a5,-1
    80000c5a:	177d                	addi	a4,a4,-1
    80000c5c:	0007c683          	lbu	a3,0(a5)
    80000c60:	00d70023          	sb	a3,0(a4)
    80000c64:	fef61ae3          	bne	a2,a5,80000c58 <memmove+0x52>
    80000c68:	bfd9                	j	80000c3e <memmove+0x38>

0000000080000c6a <memcpy>:
    80000c6a:	1141                	addi	sp,sp,-16
    80000c6c:	e406                	sd	ra,8(sp)
    80000c6e:	e022                	sd	s0,0(sp)
    80000c70:	0800                	addi	s0,sp,16
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	f94080e7          	jalr	-108(ra) # 80000c06 <memmove>
    80000c7a:	60a2                	ld	ra,8(sp)
    80000c7c:	6402                	ld	s0,0(sp)
    80000c7e:	0141                	addi	sp,sp,16
    80000c80:	8082                	ret

0000000080000c82 <strncmp>:
    80000c82:	1141                	addi	sp,sp,-16
    80000c84:	e422                	sd	s0,8(sp)
    80000c86:	0800                	addi	s0,sp,16
    80000c88:	c229                	beqz	a2,80000cca <strncmp+0x48>
    80000c8a:	00054783          	lbu	a5,0(a0)
    80000c8e:	c795                	beqz	a5,80000cba <strncmp+0x38>
    80000c90:	0005c703          	lbu	a4,0(a1)
    80000c94:	02f71363          	bne	a4,a5,80000cba <strncmp+0x38>
    80000c98:	fff6071b          	addiw	a4,a2,-1
    80000c9c:	1702                	slli	a4,a4,0x20
    80000c9e:	9301                	srli	a4,a4,0x20
    80000ca0:	0705                	addi	a4,a4,1
    80000ca2:	972a                	add	a4,a4,a0
    80000ca4:	0505                	addi	a0,a0,1
    80000ca6:	0585                	addi	a1,a1,1
    80000ca8:	02e50363          	beq	a0,a4,80000cce <strncmp+0x4c>
    80000cac:	00054783          	lbu	a5,0(a0)
    80000cb0:	c789                	beqz	a5,80000cba <strncmp+0x38>
    80000cb2:	0005c683          	lbu	a3,0(a1)
    80000cb6:	fef687e3          	beq	a3,a5,80000ca4 <strncmp+0x22>
    80000cba:	00054503          	lbu	a0,0(a0)
    80000cbe:	0005c783          	lbu	a5,0(a1)
    80000cc2:	9d1d                	subw	a0,a0,a5
    80000cc4:	6422                	ld	s0,8(sp)
    80000cc6:	0141                	addi	sp,sp,16
    80000cc8:	8082                	ret
    80000cca:	4501                	li	a0,0
    80000ccc:	bfe5                	j	80000cc4 <strncmp+0x42>
    80000cce:	4501                	li	a0,0
    80000cd0:	bfd5                	j	80000cc4 <strncmp+0x42>

0000000080000cd2 <strncpy>:
    80000cd2:	1141                	addi	sp,sp,-16
    80000cd4:	e422                	sd	s0,8(sp)
    80000cd6:	0800                	addi	s0,sp,16
    80000cd8:	872a                	mv	a4,a0
    80000cda:	a011                	j	80000cde <strncpy+0xc>
    80000cdc:	8636                	mv	a2,a3
    80000cde:	fff6069b          	addiw	a3,a2,-1
    80000ce2:	00c05963          	blez	a2,80000cf4 <strncpy+0x22>
    80000ce6:	0705                	addi	a4,a4,1
    80000ce8:	0005c783          	lbu	a5,0(a1)
    80000cec:	fef70fa3          	sb	a5,-1(a4)
    80000cf0:	0585                	addi	a1,a1,1
    80000cf2:	f7ed                	bnez	a5,80000cdc <strncpy+0xa>
    80000cf4:	00d05c63          	blez	a3,80000d0c <strncpy+0x3a>
    80000cf8:	86ba                	mv	a3,a4
    80000cfa:	0685                	addi	a3,a3,1
    80000cfc:	fe068fa3          	sb	zero,-1(a3)
    80000d00:	fff6c793          	not	a5,a3
    80000d04:	9fb9                	addw	a5,a5,a4
    80000d06:	9fb1                	addw	a5,a5,a2
    80000d08:	fef049e3          	bgtz	a5,80000cfa <strncpy+0x28>
    80000d0c:	6422                	ld	s0,8(sp)
    80000d0e:	0141                	addi	sp,sp,16
    80000d10:	8082                	ret

0000000080000d12 <safestrcpy>:
    80000d12:	1141                	addi	sp,sp,-16
    80000d14:	e422                	sd	s0,8(sp)
    80000d16:	0800                	addi	s0,sp,16
    80000d18:	02c05363          	blez	a2,80000d3e <safestrcpy+0x2c>
    80000d1c:	fff6069b          	addiw	a3,a2,-1
    80000d20:	1682                	slli	a3,a3,0x20
    80000d22:	9281                	srli	a3,a3,0x20
    80000d24:	96ae                	add	a3,a3,a1
    80000d26:	87aa                	mv	a5,a0
    80000d28:	00d58963          	beq	a1,a3,80000d3a <safestrcpy+0x28>
    80000d2c:	0585                	addi	a1,a1,1
    80000d2e:	0785                	addi	a5,a5,1
    80000d30:	fff5c703          	lbu	a4,-1(a1)
    80000d34:	fee78fa3          	sb	a4,-1(a5)
    80000d38:	fb65                	bnez	a4,80000d28 <safestrcpy+0x16>
    80000d3a:	00078023          	sb	zero,0(a5)
    80000d3e:	6422                	ld	s0,8(sp)
    80000d40:	0141                	addi	sp,sp,16
    80000d42:	8082                	ret

0000000080000d44 <strlen>:
    80000d44:	1141                	addi	sp,sp,-16
    80000d46:	e422                	sd	s0,8(sp)
    80000d48:	0800                	addi	s0,sp,16
    80000d4a:	00054783          	lbu	a5,0(a0)
    80000d4e:	cf91                	beqz	a5,80000d6a <strlen+0x26>
    80000d50:	0505                	addi	a0,a0,1
    80000d52:	87aa                	mv	a5,a0
    80000d54:	4685                	li	a3,1
    80000d56:	9e89                	subw	a3,a3,a0
    80000d58:	00f6853b          	addw	a0,a3,a5
    80000d5c:	0785                	addi	a5,a5,1
    80000d5e:	fff7c703          	lbu	a4,-1(a5)
    80000d62:	fb7d                	bnez	a4,80000d58 <strlen+0x14>
    80000d64:	6422                	ld	s0,8(sp)
    80000d66:	0141                	addi	sp,sp,16
    80000d68:	8082                	ret
    80000d6a:	4501                	li	a0,0
    80000d6c:	bfe5                	j	80000d64 <strlen+0x20>

0000000080000d6e <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000d6e:	1141                	addi	sp,sp,-16
    80000d70:	e406                	sd	ra,8(sp)
    80000d72:	e022                	sd	s0,0(sp)
    80000d74:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000d76:	00001097          	auipc	ra,0x1
    80000d7a:	c7c080e7          	jalr	-900(ra) # 800019f2 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000d7e:	00025717          	auipc	a4,0x25
    80000d82:	28670713          	addi	a4,a4,646 # 80026004 <started>
  if(cpuid() == 0){
    80000d86:	c139                	beqz	a0,80000dcc <main+0x5e>
    while(started == 0)
    80000d88:	431c                	lw	a5,0(a4)
    80000d8a:	2781                	sext.w	a5,a5
    80000d8c:	dff5                	beqz	a5,80000d88 <main+0x1a>
      ;
    __sync_synchronize();
    80000d8e:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000d92:	00001097          	auipc	ra,0x1
    80000d96:	c60080e7          	jalr	-928(ra) # 800019f2 <cpuid>
    80000d9a:	85aa                	mv	a1,a0
    80000d9c:	00006517          	auipc	a0,0x6
    80000da0:	77c50513          	addi	a0,a0,1916 # 80007518 <userret+0x488>
    80000da4:	00000097          	auipc	ra,0x0
    80000da8:	824080e7          	jalr	-2012(ra) # 800005c8 <printf>
    kvminithart();    // turn on paging
    80000dac:	00000097          	auipc	ra,0x0
    80000db0:	358080e7          	jalr	856(ra) # 80001104 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000db4:	00002097          	auipc	ra,0x2
    80000db8:	866080e7          	jalr	-1946(ra) # 8000261a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000dbc:	00005097          	auipc	ra,0x5
    80000dc0:	e64080e7          	jalr	-412(ra) # 80005c20 <plicinithart>
  }

  scheduler();        
    80000dc4:	00001097          	auipc	ra,0x1
    80000dc8:	13a080e7          	jalr	314(ra) # 80001efe <scheduler>
    consoleinit();
    80000dcc:	fffff097          	auipc	ra,0xfffff
    80000dd0:	6c0080e7          	jalr	1728(ra) # 8000048c <consoleinit>
    printfinit();
    80000dd4:	00000097          	auipc	ra,0x0
    80000dd8:	9da080e7          	jalr	-1574(ra) # 800007ae <printfinit>
    printf("\n");
    80000ddc:	00006517          	auipc	a0,0x6
    80000de0:	74c50513          	addi	a0,a0,1868 # 80007528 <userret+0x498>
    80000de4:	fffff097          	auipc	ra,0xfffff
    80000de8:	7e4080e7          	jalr	2020(ra) # 800005c8 <printf>
    printf("xv6 kernel is booting\n");
    80000dec:	00006517          	auipc	a0,0x6
    80000df0:	39c50513          	addi	a0,a0,924 # 80007188 <userret+0xf8>
    80000df4:	fffff097          	auipc	ra,0xfffff
    80000df8:	7d4080e7          	jalr	2004(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RED);
    80000dfc:	00006517          	auipc	a0,0x6
    80000e00:	3a450513          	addi	a0,a0,932 # 800071a0 <userret+0x110>
    80000e04:	fffff097          	auipc	ra,0xfffff
    80000e08:	7c4080e7          	jalr	1988(ra) # 800005c8 <printf>
    printf("\n");
    80000e0c:	00006517          	auipc	a0,0x6
    80000e10:	71c50513          	addi	a0,a0,1820 # 80007528 <userret+0x498>
    80000e14:	fffff097          	auipc	ra,0xfffff
    80000e18:	7b4080e7          	jalr	1972(ra) # 800005c8 <printf>
    printf("\n");
    80000e1c:	00006517          	auipc	a0,0x6
    80000e20:	70c50513          	addi	a0,a0,1804 # 80007528 <userret+0x498>
    80000e24:	fffff097          	auipc	ra,0xfffff
    80000e28:	7a4080e7          	jalr	1956(ra) # 800005c8 <printf>
    printf("경애하는 ");
    80000e2c:	00006517          	auipc	a0,0x6
    80000e30:	37c50513          	addi	a0,a0,892 # 800071a8 <userret+0x118>
    80000e34:	fffff097          	auipc	ra,0xfffff
    80000e38:	794080e7          	jalr	1940(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    80000e3c:	00006517          	auipc	a0,0x6
    80000e40:	37c50513          	addi	a0,a0,892 # 800071b8 <userret+0x128>
    80000e44:	fffff097          	auipc	ra,0xfffff
    80000e48:	784080e7          	jalr	1924(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RED" 교원 동지의 지도를 받아 제작된 -\n\n");
    80000e4c:	00006517          	auipc	a0,0x6
    80000e50:	38450513          	addi	a0,a0,900 # 800071d0 <userret+0x140>
    80000e54:	fffff097          	auipc	ra,0xfffff
    80000e58:	774080e7          	jalr	1908(ra) # 800005c8 <printf>
    printf("\
    80000e5c:	00006517          	auipc	a0,0x6
    80000e60:	3ac50513          	addi	a0,a0,940 # 80007208 <userret+0x178>
    80000e64:	fffff097          	auipc	ra,0xfffff
    80000e68:	764080e7          	jalr	1892(ra) # 800005c8 <printf>
    printf("\n\n");
    80000e6c:	00006517          	auipc	a0,0x6
    80000e70:	53450513          	addi	a0,a0,1332 # 800073a0 <userret+0x310>
    80000e74:	fffff097          	auipc	ra,0xfffff
    80000e78:	754080e7          	jalr	1876(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_BOLD_RED);
    80000e7c:	00006517          	auipc	a0,0x6
    80000e80:	52c50513          	addi	a0,a0,1324 # 800073a8 <userret+0x318>
    80000e84:	fffff097          	auipc	ra,0xfffff
    80000e88:	744080e7          	jalr	1860(ra) # 800005c8 <printf>
    printf("\
    80000e8c:	00006517          	auipc	a0,0x6
    80000e90:	52c50513          	addi	a0,a0,1324 # 800073b8 <userret+0x328>
    80000e94:	fffff097          	auipc	ra,0xfffff
    80000e98:	734080e7          	jalr	1844(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RESET);
    80000e9c:	00006517          	auipc	a0,0x6
    80000ea0:	54450513          	addi	a0,a0,1348 # 800073e0 <userret+0x350>
    80000ea4:	fffff097          	auipc	ra,0xfffff
    80000ea8:	724080e7          	jalr	1828(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RED);
    80000eac:	00006517          	auipc	a0,0x6
    80000eb0:	2f450513          	addi	a0,a0,756 # 800071a0 <userret+0x110>
    80000eb4:	fffff097          	auipc	ra,0xfffff
    80000eb8:	714080e7          	jalr	1812(ra) # 800005c8 <printf>
    printf("\n\
    80000ebc:	00006517          	auipc	a0,0x6
    80000ec0:	52c50513          	addi	a0,a0,1324 # 800073e8 <userret+0x358>
    80000ec4:	fffff097          	auipc	ra,0xfffff
    80000ec8:	704080e7          	jalr	1796(ra) # 800005c8 <printf>
    printf("\n");
    80000ecc:	00006517          	auipc	a0,0x6
    80000ed0:	65c50513          	addi	a0,a0,1628 # 80007528 <userret+0x498>
    80000ed4:	fffff097          	auipc	ra,0xfffff
    80000ed8:	6f4080e7          	jalr	1780(ra) # 800005c8 <printf>
    printf("본 조작체계는 운영체제 수업의 교원이신 ");
    80000edc:	00006517          	auipc	a0,0x6
    80000ee0:	53c50513          	addi	a0,a0,1340 # 80007418 <userret+0x388>
    80000ee4:	fffff097          	auipc	ra,0xfffff
    80000ee8:	6e4080e7          	jalr	1764(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_BOLD_RED"김진수"ANSI_COLOR_RESET);
    80000eec:	00006517          	auipc	a0,0x6
    80000ef0:	2cc50513          	addi	a0,a0,716 # 800071b8 <userret+0x128>
    80000ef4:	fffff097          	auipc	ra,0xfffff
    80000ef8:	6d4080e7          	jalr	1748(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RED" 교원 동지의 개교 104년(2020년) 3월 19일 학생들에게 하달하신 교시에 의하여 제작되었다.\n\n");
    80000efc:	00006517          	auipc	a0,0x6
    80000f00:	55c50513          	addi	a0,a0,1372 # 80007458 <userret+0x3c8>
    80000f04:	fffff097          	auipc	ra,0xfffff
    80000f08:	6c4080e7          	jalr	1732(ra) # 800005c8 <printf>
    printf("만든 학생: 송화평\n");
    80000f0c:	00006517          	auipc	a0,0x6
    80000f10:	5cc50513          	addi	a0,a0,1484 # 800074d8 <userret+0x448>
    80000f14:	fffff097          	auipc	ra,0xfffff
    80000f18:	6b4080e7          	jalr	1716(ra) # 800005c8 <printf>
    printf("학     번: 2014-15703\n");
    80000f1c:	00006517          	auipc	a0,0x6
    80000f20:	5dc50513          	addi	a0,a0,1500 # 800074f8 <userret+0x468>
    80000f24:	fffff097          	auipc	ra,0xfffff
    80000f28:	6a4080e7          	jalr	1700(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RESET);
    80000f2c:	00006517          	auipc	a0,0x6
    80000f30:	4b450513          	addi	a0,a0,1204 # 800073e0 <userret+0x350>
    80000f34:	fffff097          	auipc	ra,0xfffff
    80000f38:	694080e7          	jalr	1684(ra) # 800005c8 <printf>
    printf("\n");
    80000f3c:	00006517          	auipc	a0,0x6
    80000f40:	5ec50513          	addi	a0,a0,1516 # 80007528 <userret+0x498>
    80000f44:	fffff097          	auipc	ra,0xfffff
    80000f48:	684080e7          	jalr	1668(ra) # 800005c8 <printf>
    printf("\n");
    80000f4c:	00006517          	auipc	a0,0x6
    80000f50:	5dc50513          	addi	a0,a0,1500 # 80007528 <userret+0x498>
    80000f54:	fffff097          	auipc	ra,0xfffff
    80000f58:	674080e7          	jalr	1652(ra) # 800005c8 <printf>
    printf(ANSI_COLOR_RESET);
    80000f5c:	00006517          	auipc	a0,0x6
    80000f60:	48450513          	addi	a0,a0,1156 # 800073e0 <userret+0x350>
    80000f64:	fffff097          	auipc	ra,0xfffff
    80000f68:	664080e7          	jalr	1636(ra) # 800005c8 <printf>
    printf("\n");
    80000f6c:	00006517          	auipc	a0,0x6
    80000f70:	5bc50513          	addi	a0,a0,1468 # 80007528 <userret+0x498>
    80000f74:	fffff097          	auipc	ra,0xfffff
    80000f78:	654080e7          	jalr	1620(ra) # 800005c8 <printf>
    kinit();         // physical page allocator
    80000f7c:	00000097          	auipc	ra,0x0
    80000f80:	9d8080e7          	jalr	-1576(ra) # 80000954 <kinit>
    kvminit();       // create kernel page table
    80000f84:	00000097          	auipc	ra,0x0
    80000f88:	310080e7          	jalr	784(ra) # 80001294 <kvminit>
    kvminithart();   // turn on paging
    80000f8c:	00000097          	auipc	ra,0x0
    80000f90:	178080e7          	jalr	376(ra) # 80001104 <kvminithart>
    procinit();      // process table
    80000f94:	00001097          	auipc	ra,0x1
    80000f98:	98e080e7          	jalr	-1650(ra) # 80001922 <procinit>
    trapinit();      // trap vectors
    80000f9c:	00001097          	auipc	ra,0x1
    80000fa0:	656080e7          	jalr	1622(ra) # 800025f2 <trapinit>
    trapinithart();  // install kernel trap vector
    80000fa4:	00001097          	auipc	ra,0x1
    80000fa8:	676080e7          	jalr	1654(ra) # 8000261a <trapinithart>
    plicinit();      // set up interrupt controller
    80000fac:	00005097          	auipc	ra,0x5
    80000fb0:	c5e080e7          	jalr	-930(ra) # 80005c0a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000fb4:	00005097          	auipc	ra,0x5
    80000fb8:	c6c080e7          	jalr	-916(ra) # 80005c20 <plicinithart>
    binit();         // buffer cache
    80000fbc:	00002097          	auipc	ra,0x2
    80000fc0:	da4080e7          	jalr	-604(ra) # 80002d60 <binit>
    iinit();         // inode cache
    80000fc4:	00002097          	auipc	ra,0x2
    80000fc8:	476080e7          	jalr	1142(ra) # 8000343a <iinit>
    fileinit();      // file table
    80000fcc:	00003097          	auipc	ra,0x3
    80000fd0:	416080e7          	jalr	1046(ra) # 800043e2 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000fd4:	00005097          	auipc	ra,0x5
    80000fd8:	d68080e7          	jalr	-664(ra) # 80005d3c <virtio_disk_init>
    userinit();      // first user process
    80000fdc:	00001097          	auipc	ra,0x1
    80000fe0:	cb8080e7          	jalr	-840(ra) # 80001c94 <userinit>
    __sync_synchronize();
    80000fe4:	0ff0000f          	fence
    started = 1;
    80000fe8:	4785                	li	a5,1
    80000fea:	00025717          	auipc	a4,0x25
    80000fee:	00f72d23          	sw	a5,26(a4) # 80026004 <started>
    80000ff2:	bbc9                	j	80000dc4 <main+0x56>

0000000080000ff4 <walk>:
    80000ff4:	7139                	addi	sp,sp,-64
    80000ff6:	fc06                	sd	ra,56(sp)
    80000ff8:	f822                	sd	s0,48(sp)
    80000ffa:	f426                	sd	s1,40(sp)
    80000ffc:	f04a                	sd	s2,32(sp)
    80000ffe:	ec4e                	sd	s3,24(sp)
    80001000:	e852                	sd	s4,16(sp)
    80001002:	e456                	sd	s5,8(sp)
    80001004:	e05a                	sd	s6,0(sp)
    80001006:	0080                	addi	s0,sp,64
    80001008:	84aa                	mv	s1,a0
    8000100a:	89ae                	mv	s3,a1
    8000100c:	8b32                	mv	s6,a2
    8000100e:	57fd                	li	a5,-1
    80001010:	83e9                	srli	a5,a5,0x1a
    80001012:	4a79                	li	s4,30
    80001014:	4ab1                	li	s5,12
    80001016:	04b7f263          	bleu	a1,a5,8000105a <walk+0x66>
    8000101a:	00006517          	auipc	a0,0x6
    8000101e:	51650513          	addi	a0,a0,1302 # 80007530 <userret+0x4a0>
    80001022:	fffff097          	auipc	ra,0xfffff
    80001026:	55c080e7          	jalr	1372(ra) # 8000057e <panic>
    8000102a:	060b0663          	beqz	s6,80001096 <walk+0xa2>
    8000102e:	00000097          	auipc	ra,0x0
    80001032:	962080e7          	jalr	-1694(ra) # 80000990 <kalloc>
    80001036:	84aa                	mv	s1,a0
    80001038:	c529                	beqz	a0,80001082 <walk+0x8e>
    8000103a:	6605                	lui	a2,0x1
    8000103c:	4581                	li	a1,0
    8000103e:	00000097          	auipc	ra,0x0
    80001042:	b5c080e7          	jalr	-1188(ra) # 80000b9a <memset>
    80001046:	00c4d793          	srli	a5,s1,0xc
    8000104a:	07aa                	slli	a5,a5,0xa
    8000104c:	0017e793          	ori	a5,a5,1
    80001050:	00f93023          	sd	a5,0(s2)
    80001054:	3a5d                	addiw	s4,s4,-9
    80001056:	035a0063          	beq	s4,s5,80001076 <walk+0x82>
    8000105a:	0149d933          	srl	s2,s3,s4
    8000105e:	1ff97913          	andi	s2,s2,511
    80001062:	090e                	slli	s2,s2,0x3
    80001064:	9926                	add	s2,s2,s1
    80001066:	00093483          	ld	s1,0(s2)
    8000106a:	0014f793          	andi	a5,s1,1
    8000106e:	dfd5                	beqz	a5,8000102a <walk+0x36>
    80001070:	80a9                	srli	s1,s1,0xa
    80001072:	04b2                	slli	s1,s1,0xc
    80001074:	b7c5                	j	80001054 <walk+0x60>
    80001076:	00c9d513          	srli	a0,s3,0xc
    8000107a:	1ff57513          	andi	a0,a0,511
    8000107e:	050e                	slli	a0,a0,0x3
    80001080:	9526                	add	a0,a0,s1
    80001082:	70e2                	ld	ra,56(sp)
    80001084:	7442                	ld	s0,48(sp)
    80001086:	74a2                	ld	s1,40(sp)
    80001088:	7902                	ld	s2,32(sp)
    8000108a:	69e2                	ld	s3,24(sp)
    8000108c:	6a42                	ld	s4,16(sp)
    8000108e:	6aa2                	ld	s5,8(sp)
    80001090:	6b02                	ld	s6,0(sp)
    80001092:	6121                	addi	sp,sp,64
    80001094:	8082                	ret
    80001096:	4501                	li	a0,0
    80001098:	b7ed                	j	80001082 <walk+0x8e>

000000008000109a <freewalk>:
    8000109a:	7179                	addi	sp,sp,-48
    8000109c:	f406                	sd	ra,40(sp)
    8000109e:	f022                	sd	s0,32(sp)
    800010a0:	ec26                	sd	s1,24(sp)
    800010a2:	e84a                	sd	s2,16(sp)
    800010a4:	e44e                	sd	s3,8(sp)
    800010a6:	e052                	sd	s4,0(sp)
    800010a8:	1800                	addi	s0,sp,48
    800010aa:	8a2a                	mv	s4,a0
    800010ac:	84aa                	mv	s1,a0
    800010ae:	6905                	lui	s2,0x1
    800010b0:	992a                	add	s2,s2,a0
    800010b2:	4985                	li	s3,1
    800010b4:	a821                	j	800010cc <freewalk+0x32>
    800010b6:	8129                	srli	a0,a0,0xa
    800010b8:	0532                	slli	a0,a0,0xc
    800010ba:	00000097          	auipc	ra,0x0
    800010be:	fe0080e7          	jalr	-32(ra) # 8000109a <freewalk>
    800010c2:	0004b023          	sd	zero,0(s1)
    800010c6:	04a1                	addi	s1,s1,8
    800010c8:	03248163          	beq	s1,s2,800010ea <freewalk+0x50>
    800010cc:	6088                	ld	a0,0(s1)
    800010ce:	00f57793          	andi	a5,a0,15
    800010d2:	ff3782e3          	beq	a5,s3,800010b6 <freewalk+0x1c>
    800010d6:	8905                	andi	a0,a0,1
    800010d8:	d57d                	beqz	a0,800010c6 <freewalk+0x2c>
    800010da:	00006517          	auipc	a0,0x6
    800010de:	45e50513          	addi	a0,a0,1118 # 80007538 <userret+0x4a8>
    800010e2:	fffff097          	auipc	ra,0xfffff
    800010e6:	49c080e7          	jalr	1180(ra) # 8000057e <panic>
    800010ea:	8552                	mv	a0,s4
    800010ec:	fffff097          	auipc	ra,0xfffff
    800010f0:	7a4080e7          	jalr	1956(ra) # 80000890 <kfree>
    800010f4:	70a2                	ld	ra,40(sp)
    800010f6:	7402                	ld	s0,32(sp)
    800010f8:	64e2                	ld	s1,24(sp)
    800010fa:	6942                	ld	s2,16(sp)
    800010fc:	69a2                	ld	s3,8(sp)
    800010fe:	6a02                	ld	s4,0(sp)
    80001100:	6145                	addi	sp,sp,48
    80001102:	8082                	ret

0000000080001104 <kvminithart>:
    80001104:	1141                	addi	sp,sp,-16
    80001106:	e422                	sd	s0,8(sp)
    80001108:	0800                	addi	s0,sp,16
    8000110a:	00025797          	auipc	a5,0x25
    8000110e:	efe78793          	addi	a5,a5,-258 # 80026008 <kernel_pagetable>
    80001112:	639c                	ld	a5,0(a5)
    80001114:	83b1                	srli	a5,a5,0xc
    80001116:	577d                	li	a4,-1
    80001118:	177e                	slli	a4,a4,0x3f
    8000111a:	8fd9                	or	a5,a5,a4
    8000111c:	18079073          	csrw	satp,a5
    80001120:	12000073          	sfence.vma
    80001124:	6422                	ld	s0,8(sp)
    80001126:	0141                	addi	sp,sp,16
    80001128:	8082                	ret

000000008000112a <walkaddr>:
    8000112a:	57fd                	li	a5,-1
    8000112c:	83e9                	srli	a5,a5,0x1a
    8000112e:	00b7f463          	bleu	a1,a5,80001136 <walkaddr+0xc>
    80001132:	4501                	li	a0,0
    80001134:	8082                	ret
    80001136:	1141                	addi	sp,sp,-16
    80001138:	e406                	sd	ra,8(sp)
    8000113a:	e022                	sd	s0,0(sp)
    8000113c:	0800                	addi	s0,sp,16
    8000113e:	4601                	li	a2,0
    80001140:	00000097          	auipc	ra,0x0
    80001144:	eb4080e7          	jalr	-332(ra) # 80000ff4 <walk>
    80001148:	c105                	beqz	a0,80001168 <walkaddr+0x3e>
    8000114a:	611c                	ld	a5,0(a0)
    8000114c:	0117f693          	andi	a3,a5,17
    80001150:	4745                	li	a4,17
    80001152:	4501                	li	a0,0
    80001154:	00e68663          	beq	a3,a4,80001160 <walkaddr+0x36>
    80001158:	60a2                	ld	ra,8(sp)
    8000115a:	6402                	ld	s0,0(sp)
    8000115c:	0141                	addi	sp,sp,16
    8000115e:	8082                	ret
    80001160:	00a7d513          	srli	a0,a5,0xa
    80001164:	0532                	slli	a0,a0,0xc
    80001166:	bfcd                	j	80001158 <walkaddr+0x2e>
    80001168:	4501                	li	a0,0
    8000116a:	b7fd                	j	80001158 <walkaddr+0x2e>

000000008000116c <kvmpa>:
    8000116c:	1101                	addi	sp,sp,-32
    8000116e:	ec06                	sd	ra,24(sp)
    80001170:	e822                	sd	s0,16(sp)
    80001172:	e426                	sd	s1,8(sp)
    80001174:	1000                	addi	s0,sp,32
    80001176:	85aa                	mv	a1,a0
    80001178:	6785                	lui	a5,0x1
    8000117a:	17fd                	addi	a5,a5,-1
    8000117c:	00f574b3          	and	s1,a0,a5
    80001180:	4601                	li	a2,0
    80001182:	00025797          	auipc	a5,0x25
    80001186:	e8678793          	addi	a5,a5,-378 # 80026008 <kernel_pagetable>
    8000118a:	6388                	ld	a0,0(a5)
    8000118c:	00000097          	auipc	ra,0x0
    80001190:	e68080e7          	jalr	-408(ra) # 80000ff4 <walk>
    80001194:	cd09                	beqz	a0,800011ae <kvmpa+0x42>
    80001196:	6108                	ld	a0,0(a0)
    80001198:	00157793          	andi	a5,a0,1
    8000119c:	c38d                	beqz	a5,800011be <kvmpa+0x52>
    8000119e:	8129                	srli	a0,a0,0xa
    800011a0:	0532                	slli	a0,a0,0xc
    800011a2:	9526                	add	a0,a0,s1
    800011a4:	60e2                	ld	ra,24(sp)
    800011a6:	6442                	ld	s0,16(sp)
    800011a8:	64a2                	ld	s1,8(sp)
    800011aa:	6105                	addi	sp,sp,32
    800011ac:	8082                	ret
    800011ae:	00006517          	auipc	a0,0x6
    800011b2:	39a50513          	addi	a0,a0,922 # 80007548 <userret+0x4b8>
    800011b6:	fffff097          	auipc	ra,0xfffff
    800011ba:	3c8080e7          	jalr	968(ra) # 8000057e <panic>
    800011be:	00006517          	auipc	a0,0x6
    800011c2:	38a50513          	addi	a0,a0,906 # 80007548 <userret+0x4b8>
    800011c6:	fffff097          	auipc	ra,0xfffff
    800011ca:	3b8080e7          	jalr	952(ra) # 8000057e <panic>

00000000800011ce <mappages>:
    800011ce:	715d                	addi	sp,sp,-80
    800011d0:	e486                	sd	ra,72(sp)
    800011d2:	e0a2                	sd	s0,64(sp)
    800011d4:	fc26                	sd	s1,56(sp)
    800011d6:	f84a                	sd	s2,48(sp)
    800011d8:	f44e                	sd	s3,40(sp)
    800011da:	f052                	sd	s4,32(sp)
    800011dc:	ec56                	sd	s5,24(sp)
    800011de:	e85a                	sd	s6,16(sp)
    800011e0:	e45e                	sd	s7,8(sp)
    800011e2:	0880                	addi	s0,sp,80
    800011e4:	8aaa                	mv	s5,a0
    800011e6:	8b3a                	mv	s6,a4
    800011e8:	79fd                	lui	s3,0xfffff
    800011ea:	0135fa33          	and	s4,a1,s3
    800011ee:	167d                	addi	a2,a2,-1
    800011f0:	962e                	add	a2,a2,a1
    800011f2:	013679b3          	and	s3,a2,s3
    800011f6:	8952                	mv	s2,s4
    800011f8:	41468a33          	sub	s4,a3,s4
    800011fc:	6b85                	lui	s7,0x1
    800011fe:	a811                	j	80001212 <mappages+0x44>
    80001200:	00006517          	auipc	a0,0x6
    80001204:	35050513          	addi	a0,a0,848 # 80007550 <userret+0x4c0>
    80001208:	fffff097          	auipc	ra,0xfffff
    8000120c:	376080e7          	jalr	886(ra) # 8000057e <panic>
    80001210:	995e                	add	s2,s2,s7
    80001212:	012a04b3          	add	s1,s4,s2
    80001216:	4605                	li	a2,1
    80001218:	85ca                	mv	a1,s2
    8000121a:	8556                	mv	a0,s5
    8000121c:	00000097          	auipc	ra,0x0
    80001220:	dd8080e7          	jalr	-552(ra) # 80000ff4 <walk>
    80001224:	cd19                	beqz	a0,80001242 <mappages+0x74>
    80001226:	611c                	ld	a5,0(a0)
    80001228:	8b85                	andi	a5,a5,1
    8000122a:	fbf9                	bnez	a5,80001200 <mappages+0x32>
    8000122c:	80b1                	srli	s1,s1,0xc
    8000122e:	04aa                	slli	s1,s1,0xa
    80001230:	0164e4b3          	or	s1,s1,s6
    80001234:	0014e493          	ori	s1,s1,1
    80001238:	e104                	sd	s1,0(a0)
    8000123a:	fd391be3          	bne	s2,s3,80001210 <mappages+0x42>
    8000123e:	4501                	li	a0,0
    80001240:	a011                	j	80001244 <mappages+0x76>
    80001242:	557d                	li	a0,-1
    80001244:	60a6                	ld	ra,72(sp)
    80001246:	6406                	ld	s0,64(sp)
    80001248:	74e2                	ld	s1,56(sp)
    8000124a:	7942                	ld	s2,48(sp)
    8000124c:	79a2                	ld	s3,40(sp)
    8000124e:	7a02                	ld	s4,32(sp)
    80001250:	6ae2                	ld	s5,24(sp)
    80001252:	6b42                	ld	s6,16(sp)
    80001254:	6ba2                	ld	s7,8(sp)
    80001256:	6161                	addi	sp,sp,80
    80001258:	8082                	ret

000000008000125a <kvmmap>:
    8000125a:	1141                	addi	sp,sp,-16
    8000125c:	e406                	sd	ra,8(sp)
    8000125e:	e022                	sd	s0,0(sp)
    80001260:	0800                	addi	s0,sp,16
    80001262:	8736                	mv	a4,a3
    80001264:	86ae                	mv	a3,a1
    80001266:	85aa                	mv	a1,a0
    80001268:	00025797          	auipc	a5,0x25
    8000126c:	da078793          	addi	a5,a5,-608 # 80026008 <kernel_pagetable>
    80001270:	6388                	ld	a0,0(a5)
    80001272:	00000097          	auipc	ra,0x0
    80001276:	f5c080e7          	jalr	-164(ra) # 800011ce <mappages>
    8000127a:	e509                	bnez	a0,80001284 <kvmmap+0x2a>
    8000127c:	60a2                	ld	ra,8(sp)
    8000127e:	6402                	ld	s0,0(sp)
    80001280:	0141                	addi	sp,sp,16
    80001282:	8082                	ret
    80001284:	00006517          	auipc	a0,0x6
    80001288:	2d450513          	addi	a0,a0,724 # 80007558 <userret+0x4c8>
    8000128c:	fffff097          	auipc	ra,0xfffff
    80001290:	2f2080e7          	jalr	754(ra) # 8000057e <panic>

0000000080001294 <kvminit>:
    80001294:	1101                	addi	sp,sp,-32
    80001296:	ec06                	sd	ra,24(sp)
    80001298:	e822                	sd	s0,16(sp)
    8000129a:	e426                	sd	s1,8(sp)
    8000129c:	1000                	addi	s0,sp,32
    8000129e:	fffff097          	auipc	ra,0xfffff
    800012a2:	6f2080e7          	jalr	1778(ra) # 80000990 <kalloc>
    800012a6:	00025797          	auipc	a5,0x25
    800012aa:	d6a7b123          	sd	a0,-670(a5) # 80026008 <kernel_pagetable>
    800012ae:	6605                	lui	a2,0x1
    800012b0:	4581                	li	a1,0
    800012b2:	00000097          	auipc	ra,0x0
    800012b6:	8e8080e7          	jalr	-1816(ra) # 80000b9a <memset>
    800012ba:	4699                	li	a3,6
    800012bc:	6605                	lui	a2,0x1
    800012be:	100005b7          	lui	a1,0x10000
    800012c2:	10000537          	lui	a0,0x10000
    800012c6:	00000097          	auipc	ra,0x0
    800012ca:	f94080e7          	jalr	-108(ra) # 8000125a <kvmmap>
    800012ce:	4699                	li	a3,6
    800012d0:	6605                	lui	a2,0x1
    800012d2:	100015b7          	lui	a1,0x10001
    800012d6:	10001537          	lui	a0,0x10001
    800012da:	00000097          	auipc	ra,0x0
    800012de:	f80080e7          	jalr	-128(ra) # 8000125a <kvmmap>
    800012e2:	4699                	li	a3,6
    800012e4:	6641                	lui	a2,0x10
    800012e6:	020005b7          	lui	a1,0x2000
    800012ea:	02000537          	lui	a0,0x2000
    800012ee:	00000097          	auipc	ra,0x0
    800012f2:	f6c080e7          	jalr	-148(ra) # 8000125a <kvmmap>
    800012f6:	4699                	li	a3,6
    800012f8:	00400637          	lui	a2,0x400
    800012fc:	0c0005b7          	lui	a1,0xc000
    80001300:	0c000537          	lui	a0,0xc000
    80001304:	00000097          	auipc	ra,0x0
    80001308:	f56080e7          	jalr	-170(ra) # 8000125a <kvmmap>
    8000130c:	00007497          	auipc	s1,0x7
    80001310:	cf448493          	addi	s1,s1,-780 # 80008000 <initcode>
    80001314:	46a9                	li	a3,10
    80001316:	80007617          	auipc	a2,0x80007
    8000131a:	cea60613          	addi	a2,a2,-790 # 8000 <_entry-0x7fff8000>
    8000131e:	4585                	li	a1,1
    80001320:	05fe                	slli	a1,a1,0x1f
    80001322:	852e                	mv	a0,a1
    80001324:	00000097          	auipc	ra,0x0
    80001328:	f36080e7          	jalr	-202(ra) # 8000125a <kvmmap>
    8000132c:	4699                	li	a3,6
    8000132e:	4645                	li	a2,17
    80001330:	066e                	slli	a2,a2,0x1b
    80001332:	8e05                	sub	a2,a2,s1
    80001334:	85a6                	mv	a1,s1
    80001336:	8526                	mv	a0,s1
    80001338:	00000097          	auipc	ra,0x0
    8000133c:	f22080e7          	jalr	-222(ra) # 8000125a <kvmmap>
    80001340:	46a9                	li	a3,10
    80001342:	6605                	lui	a2,0x1
    80001344:	00006597          	auipc	a1,0x6
    80001348:	cbc58593          	addi	a1,a1,-836 # 80007000 <trampoline>
    8000134c:	04000537          	lui	a0,0x4000
    80001350:	157d                	addi	a0,a0,-1
    80001352:	0532                	slli	a0,a0,0xc
    80001354:	00000097          	auipc	ra,0x0
    80001358:	f06080e7          	jalr	-250(ra) # 8000125a <kvmmap>
    8000135c:	60e2                	ld	ra,24(sp)
    8000135e:	6442                	ld	s0,16(sp)
    80001360:	64a2                	ld	s1,8(sp)
    80001362:	6105                	addi	sp,sp,32
    80001364:	8082                	ret

0000000080001366 <uvmunmap>:
    80001366:	715d                	addi	sp,sp,-80
    80001368:	e486                	sd	ra,72(sp)
    8000136a:	e0a2                	sd	s0,64(sp)
    8000136c:	fc26                	sd	s1,56(sp)
    8000136e:	f84a                	sd	s2,48(sp)
    80001370:	f44e                	sd	s3,40(sp)
    80001372:	f052                	sd	s4,32(sp)
    80001374:	ec56                	sd	s5,24(sp)
    80001376:	e85a                	sd	s6,16(sp)
    80001378:	e45e                	sd	s7,8(sp)
    8000137a:	0880                	addi	s0,sp,80
    8000137c:	8a2a                	mv	s4,a0
    8000137e:	8ab6                	mv	s5,a3
    80001380:	79fd                	lui	s3,0xfffff
    80001382:	0135f933          	and	s2,a1,s3
    80001386:	167d                	addi	a2,a2,-1
    80001388:	962e                	add	a2,a2,a1
    8000138a:	013679b3          	and	s3,a2,s3
    8000138e:	4b05                	li	s6,1
    80001390:	6b85                	lui	s7,0x1
    80001392:	a8b1                	j	800013ee <uvmunmap+0x88>
    80001394:	00006517          	auipc	a0,0x6
    80001398:	1cc50513          	addi	a0,a0,460 # 80007560 <userret+0x4d0>
    8000139c:	fffff097          	auipc	ra,0xfffff
    800013a0:	1e2080e7          	jalr	482(ra) # 8000057e <panic>
    800013a4:	862a                	mv	a2,a0
    800013a6:	85ca                	mv	a1,s2
    800013a8:	00006517          	auipc	a0,0x6
    800013ac:	1c850513          	addi	a0,a0,456 # 80007570 <userret+0x4e0>
    800013b0:	fffff097          	auipc	ra,0xfffff
    800013b4:	218080e7          	jalr	536(ra) # 800005c8 <printf>
    800013b8:	00006517          	auipc	a0,0x6
    800013bc:	1c850513          	addi	a0,a0,456 # 80007580 <userret+0x4f0>
    800013c0:	fffff097          	auipc	ra,0xfffff
    800013c4:	1be080e7          	jalr	446(ra) # 8000057e <panic>
    800013c8:	00006517          	auipc	a0,0x6
    800013cc:	1d050513          	addi	a0,a0,464 # 80007598 <userret+0x508>
    800013d0:	fffff097          	auipc	ra,0xfffff
    800013d4:	1ae080e7          	jalr	430(ra) # 8000057e <panic>
    800013d8:	8129                	srli	a0,a0,0xa
    800013da:	0532                	slli	a0,a0,0xc
    800013dc:	fffff097          	auipc	ra,0xfffff
    800013e0:	4b4080e7          	jalr	1204(ra) # 80000890 <kfree>
    800013e4:	0004b023          	sd	zero,0(s1)
    800013e8:	03390763          	beq	s2,s3,80001416 <uvmunmap+0xb0>
    800013ec:	995e                	add	s2,s2,s7
    800013ee:	4601                	li	a2,0
    800013f0:	85ca                	mv	a1,s2
    800013f2:	8552                	mv	a0,s4
    800013f4:	00000097          	auipc	ra,0x0
    800013f8:	c00080e7          	jalr	-1024(ra) # 80000ff4 <walk>
    800013fc:	84aa                	mv	s1,a0
    800013fe:	d959                	beqz	a0,80001394 <uvmunmap+0x2e>
    80001400:	6108                	ld	a0,0(a0)
    80001402:	00157793          	andi	a5,a0,1
    80001406:	dfd9                	beqz	a5,800013a4 <uvmunmap+0x3e>
    80001408:	3ff57793          	andi	a5,a0,1023
    8000140c:	fb678ee3          	beq	a5,s6,800013c8 <uvmunmap+0x62>
    80001410:	fc0a8ae3          	beqz	s5,800013e4 <uvmunmap+0x7e>
    80001414:	b7d1                	j	800013d8 <uvmunmap+0x72>
    80001416:	60a6                	ld	ra,72(sp)
    80001418:	6406                	ld	s0,64(sp)
    8000141a:	74e2                	ld	s1,56(sp)
    8000141c:	7942                	ld	s2,48(sp)
    8000141e:	79a2                	ld	s3,40(sp)
    80001420:	7a02                	ld	s4,32(sp)
    80001422:	6ae2                	ld	s5,24(sp)
    80001424:	6b42                	ld	s6,16(sp)
    80001426:	6ba2                	ld	s7,8(sp)
    80001428:	6161                	addi	sp,sp,80
    8000142a:	8082                	ret

000000008000142c <uvmcreate>:
    8000142c:	1101                	addi	sp,sp,-32
    8000142e:	ec06                	sd	ra,24(sp)
    80001430:	e822                	sd	s0,16(sp)
    80001432:	e426                	sd	s1,8(sp)
    80001434:	1000                	addi	s0,sp,32
    80001436:	fffff097          	auipc	ra,0xfffff
    8000143a:	55a080e7          	jalr	1370(ra) # 80000990 <kalloc>
    8000143e:	cd11                	beqz	a0,8000145a <uvmcreate+0x2e>
    80001440:	84aa                	mv	s1,a0
    80001442:	6605                	lui	a2,0x1
    80001444:	4581                	li	a1,0
    80001446:	fffff097          	auipc	ra,0xfffff
    8000144a:	754080e7          	jalr	1876(ra) # 80000b9a <memset>
    8000144e:	8526                	mv	a0,s1
    80001450:	60e2                	ld	ra,24(sp)
    80001452:	6442                	ld	s0,16(sp)
    80001454:	64a2                	ld	s1,8(sp)
    80001456:	6105                	addi	sp,sp,32
    80001458:	8082                	ret
    8000145a:	00006517          	auipc	a0,0x6
    8000145e:	15650513          	addi	a0,a0,342 # 800075b0 <userret+0x520>
    80001462:	fffff097          	auipc	ra,0xfffff
    80001466:	11c080e7          	jalr	284(ra) # 8000057e <panic>

000000008000146a <uvminit>:
    8000146a:	7179                	addi	sp,sp,-48
    8000146c:	f406                	sd	ra,40(sp)
    8000146e:	f022                	sd	s0,32(sp)
    80001470:	ec26                	sd	s1,24(sp)
    80001472:	e84a                	sd	s2,16(sp)
    80001474:	e44e                	sd	s3,8(sp)
    80001476:	e052                	sd	s4,0(sp)
    80001478:	1800                	addi	s0,sp,48
    8000147a:	6785                	lui	a5,0x1
    8000147c:	04f67863          	bleu	a5,a2,800014cc <uvminit+0x62>
    80001480:	8a2a                	mv	s4,a0
    80001482:	89ae                	mv	s3,a1
    80001484:	84b2                	mv	s1,a2
    80001486:	fffff097          	auipc	ra,0xfffff
    8000148a:	50a080e7          	jalr	1290(ra) # 80000990 <kalloc>
    8000148e:	892a                	mv	s2,a0
    80001490:	6605                	lui	a2,0x1
    80001492:	4581                	li	a1,0
    80001494:	fffff097          	auipc	ra,0xfffff
    80001498:	706080e7          	jalr	1798(ra) # 80000b9a <memset>
    8000149c:	4779                	li	a4,30
    8000149e:	86ca                	mv	a3,s2
    800014a0:	6605                	lui	a2,0x1
    800014a2:	4581                	li	a1,0
    800014a4:	8552                	mv	a0,s4
    800014a6:	00000097          	auipc	ra,0x0
    800014aa:	d28080e7          	jalr	-728(ra) # 800011ce <mappages>
    800014ae:	8626                	mv	a2,s1
    800014b0:	85ce                	mv	a1,s3
    800014b2:	854a                	mv	a0,s2
    800014b4:	fffff097          	auipc	ra,0xfffff
    800014b8:	752080e7          	jalr	1874(ra) # 80000c06 <memmove>
    800014bc:	70a2                	ld	ra,40(sp)
    800014be:	7402                	ld	s0,32(sp)
    800014c0:	64e2                	ld	s1,24(sp)
    800014c2:	6942                	ld	s2,16(sp)
    800014c4:	69a2                	ld	s3,8(sp)
    800014c6:	6a02                	ld	s4,0(sp)
    800014c8:	6145                	addi	sp,sp,48
    800014ca:	8082                	ret
    800014cc:	00006517          	auipc	a0,0x6
    800014d0:	10450513          	addi	a0,a0,260 # 800075d0 <userret+0x540>
    800014d4:	fffff097          	auipc	ra,0xfffff
    800014d8:	0aa080e7          	jalr	170(ra) # 8000057e <panic>

00000000800014dc <uvmdealloc>:
    800014dc:	1101                	addi	sp,sp,-32
    800014de:	ec06                	sd	ra,24(sp)
    800014e0:	e822                	sd	s0,16(sp)
    800014e2:	e426                	sd	s1,8(sp)
    800014e4:	1000                	addi	s0,sp,32
    800014e6:	84ae                	mv	s1,a1
    800014e8:	00b67d63          	bleu	a1,a2,80001502 <uvmdealloc+0x26>
    800014ec:	84b2                	mv	s1,a2
    800014ee:	6785                	lui	a5,0x1
    800014f0:	17fd                	addi	a5,a5,-1
    800014f2:	00f60733          	add	a4,a2,a5
    800014f6:	76fd                	lui	a3,0xfffff
    800014f8:	8f75                	and	a4,a4,a3
    800014fa:	97ae                	add	a5,a5,a1
    800014fc:	8ff5                	and	a5,a5,a3
    800014fe:	00f76863          	bltu	a4,a5,8000150e <uvmdealloc+0x32>
    80001502:	8526                	mv	a0,s1
    80001504:	60e2                	ld	ra,24(sp)
    80001506:	6442                	ld	s0,16(sp)
    80001508:	64a2                	ld	s1,8(sp)
    8000150a:	6105                	addi	sp,sp,32
    8000150c:	8082                	ret
    8000150e:	4685                	li	a3,1
    80001510:	40e58633          	sub	a2,a1,a4
    80001514:	85ba                	mv	a1,a4
    80001516:	00000097          	auipc	ra,0x0
    8000151a:	e50080e7          	jalr	-432(ra) # 80001366 <uvmunmap>
    8000151e:	b7d5                	j	80001502 <uvmdealloc+0x26>

0000000080001520 <uvmalloc>:
    80001520:	0ab66163          	bltu	a2,a1,800015c2 <uvmalloc+0xa2>
    80001524:	7139                	addi	sp,sp,-64
    80001526:	fc06                	sd	ra,56(sp)
    80001528:	f822                	sd	s0,48(sp)
    8000152a:	f426                	sd	s1,40(sp)
    8000152c:	f04a                	sd	s2,32(sp)
    8000152e:	ec4e                	sd	s3,24(sp)
    80001530:	e852                	sd	s4,16(sp)
    80001532:	e456                	sd	s5,8(sp)
    80001534:	0080                	addi	s0,sp,64
    80001536:	6a05                	lui	s4,0x1
    80001538:	1a7d                	addi	s4,s4,-1
    8000153a:	95d2                	add	a1,a1,s4
    8000153c:	7a7d                	lui	s4,0xfffff
    8000153e:	0145fa33          	and	s4,a1,s4
    80001542:	08ca7263          	bleu	a2,s4,800015c6 <uvmalloc+0xa6>
    80001546:	89b2                	mv	s3,a2
    80001548:	8aaa                	mv	s5,a0
    8000154a:	8952                	mv	s2,s4
    8000154c:	fffff097          	auipc	ra,0xfffff
    80001550:	444080e7          	jalr	1092(ra) # 80000990 <kalloc>
    80001554:	84aa                	mv	s1,a0
    80001556:	c51d                	beqz	a0,80001584 <uvmalloc+0x64>
    80001558:	6605                	lui	a2,0x1
    8000155a:	4581                	li	a1,0
    8000155c:	fffff097          	auipc	ra,0xfffff
    80001560:	63e080e7          	jalr	1598(ra) # 80000b9a <memset>
    80001564:	4779                	li	a4,30
    80001566:	86a6                	mv	a3,s1
    80001568:	6605                	lui	a2,0x1
    8000156a:	85ca                	mv	a1,s2
    8000156c:	8556                	mv	a0,s5
    8000156e:	00000097          	auipc	ra,0x0
    80001572:	c60080e7          	jalr	-928(ra) # 800011ce <mappages>
    80001576:	e905                	bnez	a0,800015a6 <uvmalloc+0x86>
    80001578:	6785                	lui	a5,0x1
    8000157a:	993e                	add	s2,s2,a5
    8000157c:	fd3968e3          	bltu	s2,s3,8000154c <uvmalloc+0x2c>
    80001580:	854e                	mv	a0,s3
    80001582:	a809                	j	80001594 <uvmalloc+0x74>
    80001584:	8652                	mv	a2,s4
    80001586:	85ca                	mv	a1,s2
    80001588:	8556                	mv	a0,s5
    8000158a:	00000097          	auipc	ra,0x0
    8000158e:	f52080e7          	jalr	-174(ra) # 800014dc <uvmdealloc>
    80001592:	4501                	li	a0,0
    80001594:	70e2                	ld	ra,56(sp)
    80001596:	7442                	ld	s0,48(sp)
    80001598:	74a2                	ld	s1,40(sp)
    8000159a:	7902                	ld	s2,32(sp)
    8000159c:	69e2                	ld	s3,24(sp)
    8000159e:	6a42                	ld	s4,16(sp)
    800015a0:	6aa2                	ld	s5,8(sp)
    800015a2:	6121                	addi	sp,sp,64
    800015a4:	8082                	ret
    800015a6:	8526                	mv	a0,s1
    800015a8:	fffff097          	auipc	ra,0xfffff
    800015ac:	2e8080e7          	jalr	744(ra) # 80000890 <kfree>
    800015b0:	8652                	mv	a2,s4
    800015b2:	85ca                	mv	a1,s2
    800015b4:	8556                	mv	a0,s5
    800015b6:	00000097          	auipc	ra,0x0
    800015ba:	f26080e7          	jalr	-218(ra) # 800014dc <uvmdealloc>
    800015be:	4501                	li	a0,0
    800015c0:	bfd1                	j	80001594 <uvmalloc+0x74>
    800015c2:	852e                	mv	a0,a1
    800015c4:	8082                	ret
    800015c6:	8532                	mv	a0,a2
    800015c8:	b7f1                	j	80001594 <uvmalloc+0x74>

00000000800015ca <uvmfree>:
    800015ca:	1101                	addi	sp,sp,-32
    800015cc:	ec06                	sd	ra,24(sp)
    800015ce:	e822                	sd	s0,16(sp)
    800015d0:	e426                	sd	s1,8(sp)
    800015d2:	1000                	addi	s0,sp,32
    800015d4:	84aa                	mv	s1,a0
    800015d6:	4685                	li	a3,1
    800015d8:	862e                	mv	a2,a1
    800015da:	4581                	li	a1,0
    800015dc:	00000097          	auipc	ra,0x0
    800015e0:	d8a080e7          	jalr	-630(ra) # 80001366 <uvmunmap>
    800015e4:	8526                	mv	a0,s1
    800015e6:	00000097          	auipc	ra,0x0
    800015ea:	ab4080e7          	jalr	-1356(ra) # 8000109a <freewalk>
    800015ee:	60e2                	ld	ra,24(sp)
    800015f0:	6442                	ld	s0,16(sp)
    800015f2:	64a2                	ld	s1,8(sp)
    800015f4:	6105                	addi	sp,sp,32
    800015f6:	8082                	ret

00000000800015f8 <uvmcopy>:
    800015f8:	c671                	beqz	a2,800016c4 <uvmcopy+0xcc>
    800015fa:	715d                	addi	sp,sp,-80
    800015fc:	e486                	sd	ra,72(sp)
    800015fe:	e0a2                	sd	s0,64(sp)
    80001600:	fc26                	sd	s1,56(sp)
    80001602:	f84a                	sd	s2,48(sp)
    80001604:	f44e                	sd	s3,40(sp)
    80001606:	f052                	sd	s4,32(sp)
    80001608:	ec56                	sd	s5,24(sp)
    8000160a:	e85a                	sd	s6,16(sp)
    8000160c:	e45e                	sd	s7,8(sp)
    8000160e:	0880                	addi	s0,sp,80
    80001610:	8ab2                	mv	s5,a2
    80001612:	8b2e                	mv	s6,a1
    80001614:	8baa                	mv	s7,a0
    80001616:	4901                	li	s2,0
    80001618:	4601                	li	a2,0
    8000161a:	85ca                	mv	a1,s2
    8000161c:	855e                	mv	a0,s7
    8000161e:	00000097          	auipc	ra,0x0
    80001622:	9d6080e7          	jalr	-1578(ra) # 80000ff4 <walk>
    80001626:	c531                	beqz	a0,80001672 <uvmcopy+0x7a>
    80001628:	6118                	ld	a4,0(a0)
    8000162a:	00177793          	andi	a5,a4,1
    8000162e:	cbb1                	beqz	a5,80001682 <uvmcopy+0x8a>
    80001630:	00a75593          	srli	a1,a4,0xa
    80001634:	00c59993          	slli	s3,a1,0xc
    80001638:	3ff77493          	andi	s1,a4,1023
    8000163c:	fffff097          	auipc	ra,0xfffff
    80001640:	354080e7          	jalr	852(ra) # 80000990 <kalloc>
    80001644:	8a2a                	mv	s4,a0
    80001646:	c939                	beqz	a0,8000169c <uvmcopy+0xa4>
    80001648:	6605                	lui	a2,0x1
    8000164a:	85ce                	mv	a1,s3
    8000164c:	fffff097          	auipc	ra,0xfffff
    80001650:	5ba080e7          	jalr	1466(ra) # 80000c06 <memmove>
    80001654:	8726                	mv	a4,s1
    80001656:	86d2                	mv	a3,s4
    80001658:	6605                	lui	a2,0x1
    8000165a:	85ca                	mv	a1,s2
    8000165c:	855a                	mv	a0,s6
    8000165e:	00000097          	auipc	ra,0x0
    80001662:	b70080e7          	jalr	-1168(ra) # 800011ce <mappages>
    80001666:	e515                	bnez	a0,80001692 <uvmcopy+0x9a>
    80001668:	6785                	lui	a5,0x1
    8000166a:	993e                	add	s2,s2,a5
    8000166c:	fb5966e3          	bltu	s2,s5,80001618 <uvmcopy+0x20>
    80001670:	a83d                	j	800016ae <uvmcopy+0xb6>
    80001672:	00006517          	auipc	a0,0x6
    80001676:	f7e50513          	addi	a0,a0,-130 # 800075f0 <userret+0x560>
    8000167a:	fffff097          	auipc	ra,0xfffff
    8000167e:	f04080e7          	jalr	-252(ra) # 8000057e <panic>
    80001682:	00006517          	auipc	a0,0x6
    80001686:	f8e50513          	addi	a0,a0,-114 # 80007610 <userret+0x580>
    8000168a:	fffff097          	auipc	ra,0xfffff
    8000168e:	ef4080e7          	jalr	-268(ra) # 8000057e <panic>
    80001692:	8552                	mv	a0,s4
    80001694:	fffff097          	auipc	ra,0xfffff
    80001698:	1fc080e7          	jalr	508(ra) # 80000890 <kfree>
    8000169c:	4685                	li	a3,1
    8000169e:	864a                	mv	a2,s2
    800016a0:	4581                	li	a1,0
    800016a2:	855a                	mv	a0,s6
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	cc2080e7          	jalr	-830(ra) # 80001366 <uvmunmap>
    800016ac:	557d                	li	a0,-1
    800016ae:	60a6                	ld	ra,72(sp)
    800016b0:	6406                	ld	s0,64(sp)
    800016b2:	74e2                	ld	s1,56(sp)
    800016b4:	7942                	ld	s2,48(sp)
    800016b6:	79a2                	ld	s3,40(sp)
    800016b8:	7a02                	ld	s4,32(sp)
    800016ba:	6ae2                	ld	s5,24(sp)
    800016bc:	6b42                	ld	s6,16(sp)
    800016be:	6ba2                	ld	s7,8(sp)
    800016c0:	6161                	addi	sp,sp,80
    800016c2:	8082                	ret
    800016c4:	4501                	li	a0,0
    800016c6:	8082                	ret

00000000800016c8 <uvmclear>:
    800016c8:	1141                	addi	sp,sp,-16
    800016ca:	e406                	sd	ra,8(sp)
    800016cc:	e022                	sd	s0,0(sp)
    800016ce:	0800                	addi	s0,sp,16
    800016d0:	4601                	li	a2,0
    800016d2:	00000097          	auipc	ra,0x0
    800016d6:	922080e7          	jalr	-1758(ra) # 80000ff4 <walk>
    800016da:	c901                	beqz	a0,800016ea <uvmclear+0x22>
    800016dc:	611c                	ld	a5,0(a0)
    800016de:	9bbd                	andi	a5,a5,-17
    800016e0:	e11c                	sd	a5,0(a0)
    800016e2:	60a2                	ld	ra,8(sp)
    800016e4:	6402                	ld	s0,0(sp)
    800016e6:	0141                	addi	sp,sp,16
    800016e8:	8082                	ret
    800016ea:	00006517          	auipc	a0,0x6
    800016ee:	f4650513          	addi	a0,a0,-186 # 80007630 <userret+0x5a0>
    800016f2:	fffff097          	auipc	ra,0xfffff
    800016f6:	e8c080e7          	jalr	-372(ra) # 8000057e <panic>

00000000800016fa <copyout>:
    800016fa:	c6bd                	beqz	a3,80001768 <copyout+0x6e>
    800016fc:	715d                	addi	sp,sp,-80
    800016fe:	e486                	sd	ra,72(sp)
    80001700:	e0a2                	sd	s0,64(sp)
    80001702:	fc26                	sd	s1,56(sp)
    80001704:	f84a                	sd	s2,48(sp)
    80001706:	f44e                	sd	s3,40(sp)
    80001708:	f052                	sd	s4,32(sp)
    8000170a:	ec56                	sd	s5,24(sp)
    8000170c:	e85a                	sd	s6,16(sp)
    8000170e:	e45e                	sd	s7,8(sp)
    80001710:	e062                	sd	s8,0(sp)
    80001712:	0880                	addi	s0,sp,80
    80001714:	8baa                	mv	s7,a0
    80001716:	8a2e                	mv	s4,a1
    80001718:	8ab2                	mv	s5,a2
    8000171a:	89b6                	mv	s3,a3
    8000171c:	7c7d                	lui	s8,0xfffff
    8000171e:	6b05                	lui	s6,0x1
    80001720:	a015                	j	80001744 <copyout+0x4a>
    80001722:	9552                	add	a0,a0,s4
    80001724:	0004861b          	sext.w	a2,s1
    80001728:	85d6                	mv	a1,s5
    8000172a:	41250533          	sub	a0,a0,s2
    8000172e:	fffff097          	auipc	ra,0xfffff
    80001732:	4d8080e7          	jalr	1240(ra) # 80000c06 <memmove>
    80001736:	409989b3          	sub	s3,s3,s1
    8000173a:	9aa6                	add	s5,s5,s1
    8000173c:	01690a33          	add	s4,s2,s6
    80001740:	02098263          	beqz	s3,80001764 <copyout+0x6a>
    80001744:	018a7933          	and	s2,s4,s8
    80001748:	85ca                	mv	a1,s2
    8000174a:	855e                	mv	a0,s7
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	9de080e7          	jalr	-1570(ra) # 8000112a <walkaddr>
    80001754:	cd01                	beqz	a0,8000176c <copyout+0x72>
    80001756:	414904b3          	sub	s1,s2,s4
    8000175a:	94da                	add	s1,s1,s6
    8000175c:	fc99f3e3          	bleu	s1,s3,80001722 <copyout+0x28>
    80001760:	84ce                	mv	s1,s3
    80001762:	b7c1                	j	80001722 <copyout+0x28>
    80001764:	4501                	li	a0,0
    80001766:	a021                	j	8000176e <copyout+0x74>
    80001768:	4501                	li	a0,0
    8000176a:	8082                	ret
    8000176c:	557d                	li	a0,-1
    8000176e:	60a6                	ld	ra,72(sp)
    80001770:	6406                	ld	s0,64(sp)
    80001772:	74e2                	ld	s1,56(sp)
    80001774:	7942                	ld	s2,48(sp)
    80001776:	79a2                	ld	s3,40(sp)
    80001778:	7a02                	ld	s4,32(sp)
    8000177a:	6ae2                	ld	s5,24(sp)
    8000177c:	6b42                	ld	s6,16(sp)
    8000177e:	6ba2                	ld	s7,8(sp)
    80001780:	6c02                	ld	s8,0(sp)
    80001782:	6161                	addi	sp,sp,80
    80001784:	8082                	ret

0000000080001786 <copyin>:
    80001786:	caa5                	beqz	a3,800017f6 <copyin+0x70>
    80001788:	715d                	addi	sp,sp,-80
    8000178a:	e486                	sd	ra,72(sp)
    8000178c:	e0a2                	sd	s0,64(sp)
    8000178e:	fc26                	sd	s1,56(sp)
    80001790:	f84a                	sd	s2,48(sp)
    80001792:	f44e                	sd	s3,40(sp)
    80001794:	f052                	sd	s4,32(sp)
    80001796:	ec56                	sd	s5,24(sp)
    80001798:	e85a                	sd	s6,16(sp)
    8000179a:	e45e                	sd	s7,8(sp)
    8000179c:	e062                	sd	s8,0(sp)
    8000179e:	0880                	addi	s0,sp,80
    800017a0:	8baa                	mv	s7,a0
    800017a2:	8aae                	mv	s5,a1
    800017a4:	8a32                	mv	s4,a2
    800017a6:	89b6                	mv	s3,a3
    800017a8:	7c7d                	lui	s8,0xfffff
    800017aa:	6b05                	lui	s6,0x1
    800017ac:	a01d                	j	800017d2 <copyin+0x4c>
    800017ae:	014505b3          	add	a1,a0,s4
    800017b2:	0004861b          	sext.w	a2,s1
    800017b6:	412585b3          	sub	a1,a1,s2
    800017ba:	8556                	mv	a0,s5
    800017bc:	fffff097          	auipc	ra,0xfffff
    800017c0:	44a080e7          	jalr	1098(ra) # 80000c06 <memmove>
    800017c4:	409989b3          	sub	s3,s3,s1
    800017c8:	9aa6                	add	s5,s5,s1
    800017ca:	01690a33          	add	s4,s2,s6
    800017ce:	02098263          	beqz	s3,800017f2 <copyin+0x6c>
    800017d2:	018a7933          	and	s2,s4,s8
    800017d6:	85ca                	mv	a1,s2
    800017d8:	855e                	mv	a0,s7
    800017da:	00000097          	auipc	ra,0x0
    800017de:	950080e7          	jalr	-1712(ra) # 8000112a <walkaddr>
    800017e2:	cd01                	beqz	a0,800017fa <copyin+0x74>
    800017e4:	414904b3          	sub	s1,s2,s4
    800017e8:	94da                	add	s1,s1,s6
    800017ea:	fc99f2e3          	bleu	s1,s3,800017ae <copyin+0x28>
    800017ee:	84ce                	mv	s1,s3
    800017f0:	bf7d                	j	800017ae <copyin+0x28>
    800017f2:	4501                	li	a0,0
    800017f4:	a021                	j	800017fc <copyin+0x76>
    800017f6:	4501                	li	a0,0
    800017f8:	8082                	ret
    800017fa:	557d                	li	a0,-1
    800017fc:	60a6                	ld	ra,72(sp)
    800017fe:	6406                	ld	s0,64(sp)
    80001800:	74e2                	ld	s1,56(sp)
    80001802:	7942                	ld	s2,48(sp)
    80001804:	79a2                	ld	s3,40(sp)
    80001806:	7a02                	ld	s4,32(sp)
    80001808:	6ae2                	ld	s5,24(sp)
    8000180a:	6b42                	ld	s6,16(sp)
    8000180c:	6ba2                	ld	s7,8(sp)
    8000180e:	6c02                	ld	s8,0(sp)
    80001810:	6161                	addi	sp,sp,80
    80001812:	8082                	ret

0000000080001814 <copyinstr>:
    80001814:	ced5                	beqz	a3,800018d0 <copyinstr+0xbc>
    80001816:	715d                	addi	sp,sp,-80
    80001818:	e486                	sd	ra,72(sp)
    8000181a:	e0a2                	sd	s0,64(sp)
    8000181c:	fc26                	sd	s1,56(sp)
    8000181e:	f84a                	sd	s2,48(sp)
    80001820:	f44e                	sd	s3,40(sp)
    80001822:	f052                	sd	s4,32(sp)
    80001824:	ec56                	sd	s5,24(sp)
    80001826:	e85a                	sd	s6,16(sp)
    80001828:	e45e                	sd	s7,8(sp)
    8000182a:	e062                	sd	s8,0(sp)
    8000182c:	0880                	addi	s0,sp,80
    8000182e:	8aaa                	mv	s5,a0
    80001830:	84ae                	mv	s1,a1
    80001832:	8c32                	mv	s8,a2
    80001834:	8bb6                	mv	s7,a3
    80001836:	7a7d                	lui	s4,0xfffff
    80001838:	6985                	lui	s3,0x1
    8000183a:	4b05                	li	s6,1
    8000183c:	a801                	j	8000184c <copyinstr+0x38>
    8000183e:	87a6                	mv	a5,s1
    80001840:	a085                	j	800018a0 <copyinstr+0x8c>
    80001842:	84b2                	mv	s1,a2
    80001844:	01390c33          	add	s8,s2,s3
    80001848:	080b8063          	beqz	s7,800018c8 <copyinstr+0xb4>
    8000184c:	014c7933          	and	s2,s8,s4
    80001850:	85ca                	mv	a1,s2
    80001852:	8556                	mv	a0,s5
    80001854:	00000097          	auipc	ra,0x0
    80001858:	8d6080e7          	jalr	-1834(ra) # 8000112a <walkaddr>
    8000185c:	c925                	beqz	a0,800018cc <copyinstr+0xb8>
    8000185e:	41890633          	sub	a2,s2,s8
    80001862:	964e                	add	a2,a2,s3
    80001864:	00cbf363          	bleu	a2,s7,8000186a <copyinstr+0x56>
    80001868:	865e                	mv	a2,s7
    8000186a:	9562                	add	a0,a0,s8
    8000186c:	41250533          	sub	a0,a0,s2
    80001870:	da71                	beqz	a2,80001844 <copyinstr+0x30>
    80001872:	00054703          	lbu	a4,0(a0)
    80001876:	d761                	beqz	a4,8000183e <copyinstr+0x2a>
    80001878:	9626                	add	a2,a2,s1
    8000187a:	87a6                	mv	a5,s1
    8000187c:	1bfd                	addi	s7,s7,-1
    8000187e:	009b86b3          	add	a3,s7,s1
    80001882:	409b04b3          	sub	s1,s6,s1
    80001886:	94aa                	add	s1,s1,a0
    80001888:	00e78023          	sb	a4,0(a5) # 1000 <_entry-0x7ffff000>
    8000188c:	40f68bb3          	sub	s7,a3,a5
    80001890:	00f48733          	add	a4,s1,a5
    80001894:	0785                	addi	a5,a5,1
    80001896:	faf606e3          	beq	a2,a5,80001842 <copyinstr+0x2e>
    8000189a:	00074703          	lbu	a4,0(a4)
    8000189e:	f76d                	bnez	a4,80001888 <copyinstr+0x74>
    800018a0:	00078023          	sb	zero,0(a5)
    800018a4:	4785                	li	a5,1
    800018a6:	0017b513          	seqz	a0,a5
    800018aa:	40a0053b          	negw	a0,a0
    800018ae:	2501                	sext.w	a0,a0
    800018b0:	60a6                	ld	ra,72(sp)
    800018b2:	6406                	ld	s0,64(sp)
    800018b4:	74e2                	ld	s1,56(sp)
    800018b6:	7942                	ld	s2,48(sp)
    800018b8:	79a2                	ld	s3,40(sp)
    800018ba:	7a02                	ld	s4,32(sp)
    800018bc:	6ae2                	ld	s5,24(sp)
    800018be:	6b42                	ld	s6,16(sp)
    800018c0:	6ba2                	ld	s7,8(sp)
    800018c2:	6c02                	ld	s8,0(sp)
    800018c4:	6161                	addi	sp,sp,80
    800018c6:	8082                	ret
    800018c8:	4781                	li	a5,0
    800018ca:	bff1                	j	800018a6 <copyinstr+0x92>
    800018cc:	557d                	li	a0,-1
    800018ce:	b7cd                	j	800018b0 <copyinstr+0x9c>
    800018d0:	4781                	li	a5,0
    800018d2:	0017b513          	seqz	a0,a5
    800018d6:	40a0053b          	negw	a0,a0
    800018da:	2501                	sext.w	a0,a0
    800018dc:	8082                	ret

00000000800018de <wakeup1>:
    800018de:	1101                	addi	sp,sp,-32
    800018e0:	ec06                	sd	ra,24(sp)
    800018e2:	e822                	sd	s0,16(sp)
    800018e4:	e426                	sd	s1,8(sp)
    800018e6:	1000                	addi	s0,sp,32
    800018e8:	84aa                	mv	s1,a0
    800018ea:	fffff097          	auipc	ra,0xfffff
    800018ee:	1d4080e7          	jalr	468(ra) # 80000abe <holding>
    800018f2:	c909                	beqz	a0,80001904 <wakeup1+0x26>
    800018f4:	749c                	ld	a5,40(s1)
    800018f6:	00978f63          	beq	a5,s1,80001914 <wakeup1+0x36>
    800018fa:	60e2                	ld	ra,24(sp)
    800018fc:	6442                	ld	s0,16(sp)
    800018fe:	64a2                	ld	s1,8(sp)
    80001900:	6105                	addi	sp,sp,32
    80001902:	8082                	ret
    80001904:	00006517          	auipc	a0,0x6
    80001908:	d3c50513          	addi	a0,a0,-708 # 80007640 <userret+0x5b0>
    8000190c:	fffff097          	auipc	ra,0xfffff
    80001910:	c72080e7          	jalr	-910(ra) # 8000057e <panic>
    80001914:	4c98                	lw	a4,24(s1)
    80001916:	4785                	li	a5,1
    80001918:	fef711e3          	bne	a4,a5,800018fa <wakeup1+0x1c>
    8000191c:	4789                	li	a5,2
    8000191e:	cc9c                	sw	a5,24(s1)
    80001920:	bfe9                	j	800018fa <wakeup1+0x1c>

0000000080001922 <procinit>:
    80001922:	715d                	addi	sp,sp,-80
    80001924:	e486                	sd	ra,72(sp)
    80001926:	e0a2                	sd	s0,64(sp)
    80001928:	fc26                	sd	s1,56(sp)
    8000192a:	f84a                	sd	s2,48(sp)
    8000192c:	f44e                	sd	s3,40(sp)
    8000192e:	f052                	sd	s4,32(sp)
    80001930:	ec56                	sd	s5,24(sp)
    80001932:	e85a                	sd	s6,16(sp)
    80001934:	e45e                	sd	s7,8(sp)
    80001936:	0880                	addi	s0,sp,80
    80001938:	00006597          	auipc	a1,0x6
    8000193c:	d1058593          	addi	a1,a1,-752 # 80007648 <userret+0x5b8>
    80001940:	00010517          	auipc	a0,0x10
    80001944:	fa850513          	addi	a0,a0,-88 # 800118e8 <pid_lock>
    80001948:	fffff097          	auipc	ra,0xfffff
    8000194c:	0a8080e7          	jalr	168(ra) # 800009f0 <initlock>
    80001950:	00010917          	auipc	s2,0x10
    80001954:	3b090913          	addi	s2,s2,944 # 80011d00 <proc>
    80001958:	00006b97          	auipc	s7,0x6
    8000195c:	cf8b8b93          	addi	s7,s7,-776 # 80007650 <userret+0x5c0>
    80001960:	8b4a                	mv	s6,s2
    80001962:	00006a97          	auipc	s5,0x6
    80001966:	32ea8a93          	addi	s5,s5,814 # 80007c90 <syscalls+0xb0>
    8000196a:	040009b7          	lui	s3,0x4000
    8000196e:	19fd                	addi	s3,s3,-1
    80001970:	09b2                	slli	s3,s3,0xc
    80001972:	00016a17          	auipc	s4,0x16
    80001976:	d8ea0a13          	addi	s4,s4,-626 # 80017700 <tickslock>
    8000197a:	85de                	mv	a1,s7
    8000197c:	854a                	mv	a0,s2
    8000197e:	fffff097          	auipc	ra,0xfffff
    80001982:	072080e7          	jalr	114(ra) # 800009f0 <initlock>
    80001986:	fffff097          	auipc	ra,0xfffff
    8000198a:	00a080e7          	jalr	10(ra) # 80000990 <kalloc>
    8000198e:	85aa                	mv	a1,a0
    80001990:	c929                	beqz	a0,800019e2 <procinit+0xc0>
    80001992:	416904b3          	sub	s1,s2,s6
    80001996:	848d                	srai	s1,s1,0x3
    80001998:	000ab783          	ld	a5,0(s5)
    8000199c:	02f484b3          	mul	s1,s1,a5
    800019a0:	2485                	addiw	s1,s1,1
    800019a2:	00d4949b          	slliw	s1,s1,0xd
    800019a6:	409984b3          	sub	s1,s3,s1
    800019aa:	4699                	li	a3,6
    800019ac:	6605                	lui	a2,0x1
    800019ae:	8526                	mv	a0,s1
    800019b0:	00000097          	auipc	ra,0x0
    800019b4:	8aa080e7          	jalr	-1878(ra) # 8000125a <kvmmap>
    800019b8:	04993023          	sd	s1,64(s2)
    800019bc:	16890913          	addi	s2,s2,360
    800019c0:	fb491de3          	bne	s2,s4,8000197a <procinit+0x58>
    800019c4:	fffff097          	auipc	ra,0xfffff
    800019c8:	740080e7          	jalr	1856(ra) # 80001104 <kvminithart>
    800019cc:	60a6                	ld	ra,72(sp)
    800019ce:	6406                	ld	s0,64(sp)
    800019d0:	74e2                	ld	s1,56(sp)
    800019d2:	7942                	ld	s2,48(sp)
    800019d4:	79a2                	ld	s3,40(sp)
    800019d6:	7a02                	ld	s4,32(sp)
    800019d8:	6ae2                	ld	s5,24(sp)
    800019da:	6b42                	ld	s6,16(sp)
    800019dc:	6ba2                	ld	s7,8(sp)
    800019de:	6161                	addi	sp,sp,80
    800019e0:	8082                	ret
    800019e2:	00006517          	auipc	a0,0x6
    800019e6:	c7650513          	addi	a0,a0,-906 # 80007658 <userret+0x5c8>
    800019ea:	fffff097          	auipc	ra,0xfffff
    800019ee:	b94080e7          	jalr	-1132(ra) # 8000057e <panic>

00000000800019f2 <cpuid>:
    800019f2:	1141                	addi	sp,sp,-16
    800019f4:	e422                	sd	s0,8(sp)
    800019f6:	0800                	addi	s0,sp,16
    800019f8:	8512                	mv	a0,tp
    800019fa:	2501                	sext.w	a0,a0
    800019fc:	6422                	ld	s0,8(sp)
    800019fe:	0141                	addi	sp,sp,16
    80001a00:	8082                	ret

0000000080001a02 <mycpu>:
    80001a02:	1141                	addi	sp,sp,-16
    80001a04:	e422                	sd	s0,8(sp)
    80001a06:	0800                	addi	s0,sp,16
    80001a08:	8792                	mv	a5,tp
    80001a0a:	2781                	sext.w	a5,a5
    80001a0c:	079e                	slli	a5,a5,0x7
    80001a0e:	00010517          	auipc	a0,0x10
    80001a12:	ef250513          	addi	a0,a0,-270 # 80011900 <cpus>
    80001a16:	953e                	add	a0,a0,a5
    80001a18:	6422                	ld	s0,8(sp)
    80001a1a:	0141                	addi	sp,sp,16
    80001a1c:	8082                	ret

0000000080001a1e <myproc>:
    80001a1e:	1101                	addi	sp,sp,-32
    80001a20:	ec06                	sd	ra,24(sp)
    80001a22:	e822                	sd	s0,16(sp)
    80001a24:	e426                	sd	s1,8(sp)
    80001a26:	1000                	addi	s0,sp,32
    80001a28:	fffff097          	auipc	ra,0xfffff
    80001a2c:	fde080e7          	jalr	-34(ra) # 80000a06 <push_off>
    80001a30:	8792                	mv	a5,tp
    80001a32:	2781                	sext.w	a5,a5
    80001a34:	079e                	slli	a5,a5,0x7
    80001a36:	00010717          	auipc	a4,0x10
    80001a3a:	eb270713          	addi	a4,a4,-334 # 800118e8 <pid_lock>
    80001a3e:	97ba                	add	a5,a5,a4
    80001a40:	6f84                	ld	s1,24(a5)
    80001a42:	fffff097          	auipc	ra,0xfffff
    80001a46:	010080e7          	jalr	16(ra) # 80000a52 <pop_off>
    80001a4a:	8526                	mv	a0,s1
    80001a4c:	60e2                	ld	ra,24(sp)
    80001a4e:	6442                	ld	s0,16(sp)
    80001a50:	64a2                	ld	s1,8(sp)
    80001a52:	6105                	addi	sp,sp,32
    80001a54:	8082                	ret

0000000080001a56 <forkret>:
    80001a56:	1141                	addi	sp,sp,-16
    80001a58:	e406                	sd	ra,8(sp)
    80001a5a:	e022                	sd	s0,0(sp)
    80001a5c:	0800                	addi	s0,sp,16
    80001a5e:	00000097          	auipc	ra,0x0
    80001a62:	fc0080e7          	jalr	-64(ra) # 80001a1e <myproc>
    80001a66:	fffff097          	auipc	ra,0xfffff
    80001a6a:	0ec080e7          	jalr	236(ra) # 80000b52 <release>
    80001a6e:	00006797          	auipc	a5,0x6
    80001a72:	5c678793          	addi	a5,a5,1478 # 80008034 <first.1673>
    80001a76:	439c                	lw	a5,0(a5)
    80001a78:	eb89                	bnez	a5,80001a8a <forkret+0x34>
    80001a7a:	00001097          	auipc	ra,0x1
    80001a7e:	bb8080e7          	jalr	-1096(ra) # 80002632 <usertrapret>
    80001a82:	60a2                	ld	ra,8(sp)
    80001a84:	6402                	ld	s0,0(sp)
    80001a86:	0141                	addi	sp,sp,16
    80001a88:	8082                	ret
    80001a8a:	00006797          	auipc	a5,0x6
    80001a8e:	5a07a523          	sw	zero,1450(a5) # 80008034 <first.1673>
    80001a92:	4505                	li	a0,1
    80001a94:	00002097          	auipc	ra,0x2
    80001a98:	928080e7          	jalr	-1752(ra) # 800033bc <fsinit>
    80001a9c:	bff9                	j	80001a7a <forkret+0x24>

0000000080001a9e <allocpid>:
    80001a9e:	1101                	addi	sp,sp,-32
    80001aa0:	ec06                	sd	ra,24(sp)
    80001aa2:	e822                	sd	s0,16(sp)
    80001aa4:	e426                	sd	s1,8(sp)
    80001aa6:	e04a                	sd	s2,0(sp)
    80001aa8:	1000                	addi	s0,sp,32
    80001aaa:	00010917          	auipc	s2,0x10
    80001aae:	e3e90913          	addi	s2,s2,-450 # 800118e8 <pid_lock>
    80001ab2:	854a                	mv	a0,s2
    80001ab4:	fffff097          	auipc	ra,0xfffff
    80001ab8:	04a080e7          	jalr	74(ra) # 80000afe <acquire>
    80001abc:	00006797          	auipc	a5,0x6
    80001ac0:	57c78793          	addi	a5,a5,1404 # 80008038 <nextpid>
    80001ac4:	4384                	lw	s1,0(a5)
    80001ac6:	0014871b          	addiw	a4,s1,1
    80001aca:	c398                	sw	a4,0(a5)
    80001acc:	854a                	mv	a0,s2
    80001ace:	fffff097          	auipc	ra,0xfffff
    80001ad2:	084080e7          	jalr	132(ra) # 80000b52 <release>
    80001ad6:	8526                	mv	a0,s1
    80001ad8:	60e2                	ld	ra,24(sp)
    80001ada:	6442                	ld	s0,16(sp)
    80001adc:	64a2                	ld	s1,8(sp)
    80001ade:	6902                	ld	s2,0(sp)
    80001ae0:	6105                	addi	sp,sp,32
    80001ae2:	8082                	ret

0000000080001ae4 <proc_pagetable>:
    80001ae4:	1101                	addi	sp,sp,-32
    80001ae6:	ec06                	sd	ra,24(sp)
    80001ae8:	e822                	sd	s0,16(sp)
    80001aea:	e426                	sd	s1,8(sp)
    80001aec:	e04a                	sd	s2,0(sp)
    80001aee:	1000                	addi	s0,sp,32
    80001af0:	892a                	mv	s2,a0
    80001af2:	00000097          	auipc	ra,0x0
    80001af6:	93a080e7          	jalr	-1734(ra) # 8000142c <uvmcreate>
    80001afa:	84aa                	mv	s1,a0
    80001afc:	4729                	li	a4,10
    80001afe:	00005697          	auipc	a3,0x5
    80001b02:	50268693          	addi	a3,a3,1282 # 80007000 <trampoline>
    80001b06:	6605                	lui	a2,0x1
    80001b08:	040005b7          	lui	a1,0x4000
    80001b0c:	15fd                	addi	a1,a1,-1
    80001b0e:	05b2                	slli	a1,a1,0xc
    80001b10:	fffff097          	auipc	ra,0xfffff
    80001b14:	6be080e7          	jalr	1726(ra) # 800011ce <mappages>
    80001b18:	4719                	li	a4,6
    80001b1a:	05893683          	ld	a3,88(s2)
    80001b1e:	6605                	lui	a2,0x1
    80001b20:	020005b7          	lui	a1,0x2000
    80001b24:	15fd                	addi	a1,a1,-1
    80001b26:	05b6                	slli	a1,a1,0xd
    80001b28:	8526                	mv	a0,s1
    80001b2a:	fffff097          	auipc	ra,0xfffff
    80001b2e:	6a4080e7          	jalr	1700(ra) # 800011ce <mappages>
    80001b32:	8526                	mv	a0,s1
    80001b34:	60e2                	ld	ra,24(sp)
    80001b36:	6442                	ld	s0,16(sp)
    80001b38:	64a2                	ld	s1,8(sp)
    80001b3a:	6902                	ld	s2,0(sp)
    80001b3c:	6105                	addi	sp,sp,32
    80001b3e:	8082                	ret

0000000080001b40 <allocproc>:
    80001b40:	1101                	addi	sp,sp,-32
    80001b42:	ec06                	sd	ra,24(sp)
    80001b44:	e822                	sd	s0,16(sp)
    80001b46:	e426                	sd	s1,8(sp)
    80001b48:	e04a                	sd	s2,0(sp)
    80001b4a:	1000                	addi	s0,sp,32
    80001b4c:	00010497          	auipc	s1,0x10
    80001b50:	1b448493          	addi	s1,s1,436 # 80011d00 <proc>
    80001b54:	00016917          	auipc	s2,0x16
    80001b58:	bac90913          	addi	s2,s2,-1108 # 80017700 <tickslock>
    80001b5c:	8526                	mv	a0,s1
    80001b5e:	fffff097          	auipc	ra,0xfffff
    80001b62:	fa0080e7          	jalr	-96(ra) # 80000afe <acquire>
    80001b66:	4c9c                	lw	a5,24(s1)
    80001b68:	cf81                	beqz	a5,80001b80 <allocproc+0x40>
    80001b6a:	8526                	mv	a0,s1
    80001b6c:	fffff097          	auipc	ra,0xfffff
    80001b70:	fe6080e7          	jalr	-26(ra) # 80000b52 <release>
    80001b74:	16848493          	addi	s1,s1,360
    80001b78:	ff2492e3          	bne	s1,s2,80001b5c <allocproc+0x1c>
    80001b7c:	4481                	li	s1,0
    80001b7e:	a0a9                	j	80001bc8 <allocproc+0x88>
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	f1e080e7          	jalr	-226(ra) # 80001a9e <allocpid>
    80001b88:	dc88                	sw	a0,56(s1)
    80001b8a:	fffff097          	auipc	ra,0xfffff
    80001b8e:	e06080e7          	jalr	-506(ra) # 80000990 <kalloc>
    80001b92:	892a                	mv	s2,a0
    80001b94:	eca8                	sd	a0,88(s1)
    80001b96:	c121                	beqz	a0,80001bd6 <allocproc+0x96>
    80001b98:	8526                	mv	a0,s1
    80001b9a:	00000097          	auipc	ra,0x0
    80001b9e:	f4a080e7          	jalr	-182(ra) # 80001ae4 <proc_pagetable>
    80001ba2:	e8a8                	sd	a0,80(s1)
    80001ba4:	07000613          	li	a2,112
    80001ba8:	4581                	li	a1,0
    80001baa:	06048513          	addi	a0,s1,96
    80001bae:	fffff097          	auipc	ra,0xfffff
    80001bb2:	fec080e7          	jalr	-20(ra) # 80000b9a <memset>
    80001bb6:	00000797          	auipc	a5,0x0
    80001bba:	ea078793          	addi	a5,a5,-352 # 80001a56 <forkret>
    80001bbe:	f0bc                	sd	a5,96(s1)
    80001bc0:	60bc                	ld	a5,64(s1)
    80001bc2:	6705                	lui	a4,0x1
    80001bc4:	97ba                	add	a5,a5,a4
    80001bc6:	f4bc                	sd	a5,104(s1)
    80001bc8:	8526                	mv	a0,s1
    80001bca:	60e2                	ld	ra,24(sp)
    80001bcc:	6442                	ld	s0,16(sp)
    80001bce:	64a2                	ld	s1,8(sp)
    80001bd0:	6902                	ld	s2,0(sp)
    80001bd2:	6105                	addi	sp,sp,32
    80001bd4:	8082                	ret
    80001bd6:	8526                	mv	a0,s1
    80001bd8:	fffff097          	auipc	ra,0xfffff
    80001bdc:	f7a080e7          	jalr	-134(ra) # 80000b52 <release>
    80001be0:	84ca                	mv	s1,s2
    80001be2:	b7dd                	j	80001bc8 <allocproc+0x88>

0000000080001be4 <proc_freepagetable>:
    80001be4:	1101                	addi	sp,sp,-32
    80001be6:	ec06                	sd	ra,24(sp)
    80001be8:	e822                	sd	s0,16(sp)
    80001bea:	e426                	sd	s1,8(sp)
    80001bec:	e04a                	sd	s2,0(sp)
    80001bee:	1000                	addi	s0,sp,32
    80001bf0:	84aa                	mv	s1,a0
    80001bf2:	892e                	mv	s2,a1
    80001bf4:	4681                	li	a3,0
    80001bf6:	6605                	lui	a2,0x1
    80001bf8:	040005b7          	lui	a1,0x4000
    80001bfc:	15fd                	addi	a1,a1,-1
    80001bfe:	05b2                	slli	a1,a1,0xc
    80001c00:	fffff097          	auipc	ra,0xfffff
    80001c04:	766080e7          	jalr	1894(ra) # 80001366 <uvmunmap>
    80001c08:	4681                	li	a3,0
    80001c0a:	6605                	lui	a2,0x1
    80001c0c:	020005b7          	lui	a1,0x2000
    80001c10:	15fd                	addi	a1,a1,-1
    80001c12:	05b6                	slli	a1,a1,0xd
    80001c14:	8526                	mv	a0,s1
    80001c16:	fffff097          	auipc	ra,0xfffff
    80001c1a:	750080e7          	jalr	1872(ra) # 80001366 <uvmunmap>
    80001c1e:	00091863          	bnez	s2,80001c2e <proc_freepagetable+0x4a>
    80001c22:	60e2                	ld	ra,24(sp)
    80001c24:	6442                	ld	s0,16(sp)
    80001c26:	64a2                	ld	s1,8(sp)
    80001c28:	6902                	ld	s2,0(sp)
    80001c2a:	6105                	addi	sp,sp,32
    80001c2c:	8082                	ret
    80001c2e:	85ca                	mv	a1,s2
    80001c30:	8526                	mv	a0,s1
    80001c32:	00000097          	auipc	ra,0x0
    80001c36:	998080e7          	jalr	-1640(ra) # 800015ca <uvmfree>
    80001c3a:	b7e5                	j	80001c22 <proc_freepagetable+0x3e>

0000000080001c3c <freeproc>:
    80001c3c:	1101                	addi	sp,sp,-32
    80001c3e:	ec06                	sd	ra,24(sp)
    80001c40:	e822                	sd	s0,16(sp)
    80001c42:	e426                	sd	s1,8(sp)
    80001c44:	1000                	addi	s0,sp,32
    80001c46:	84aa                	mv	s1,a0
    80001c48:	6d28                	ld	a0,88(a0)
    80001c4a:	c509                	beqz	a0,80001c54 <freeproc+0x18>
    80001c4c:	fffff097          	auipc	ra,0xfffff
    80001c50:	c44080e7          	jalr	-956(ra) # 80000890 <kfree>
    80001c54:	0404bc23          	sd	zero,88(s1)
    80001c58:	68a8                	ld	a0,80(s1)
    80001c5a:	c511                	beqz	a0,80001c66 <freeproc+0x2a>
    80001c5c:	64ac                	ld	a1,72(s1)
    80001c5e:	00000097          	auipc	ra,0x0
    80001c62:	f86080e7          	jalr	-122(ra) # 80001be4 <proc_freepagetable>
    80001c66:	0404b823          	sd	zero,80(s1)
    80001c6a:	0404b423          	sd	zero,72(s1)
    80001c6e:	0204ac23          	sw	zero,56(s1)
    80001c72:	0204b023          	sd	zero,32(s1)
    80001c76:	14048c23          	sb	zero,344(s1)
    80001c7a:	0204b423          	sd	zero,40(s1)
    80001c7e:	0204a823          	sw	zero,48(s1)
    80001c82:	0204aa23          	sw	zero,52(s1)
    80001c86:	0004ac23          	sw	zero,24(s1)
    80001c8a:	60e2                	ld	ra,24(sp)
    80001c8c:	6442                	ld	s0,16(sp)
    80001c8e:	64a2                	ld	s1,8(sp)
    80001c90:	6105                	addi	sp,sp,32
    80001c92:	8082                	ret

0000000080001c94 <userinit>:
    80001c94:	1101                	addi	sp,sp,-32
    80001c96:	ec06                	sd	ra,24(sp)
    80001c98:	e822                	sd	s0,16(sp)
    80001c9a:	e426                	sd	s1,8(sp)
    80001c9c:	1000                	addi	s0,sp,32
    80001c9e:	00000097          	auipc	ra,0x0
    80001ca2:	ea2080e7          	jalr	-350(ra) # 80001b40 <allocproc>
    80001ca6:	84aa                	mv	s1,a0
    80001ca8:	00024797          	auipc	a5,0x24
    80001cac:	36a7b423          	sd	a0,872(a5) # 80026010 <initproc>
    80001cb0:	03300613          	li	a2,51
    80001cb4:	00006597          	auipc	a1,0x6
    80001cb8:	34c58593          	addi	a1,a1,844 # 80008000 <initcode>
    80001cbc:	6928                	ld	a0,80(a0)
    80001cbe:	fffff097          	auipc	ra,0xfffff
    80001cc2:	7ac080e7          	jalr	1964(ra) # 8000146a <uvminit>
    80001cc6:	6785                	lui	a5,0x1
    80001cc8:	e4bc                	sd	a5,72(s1)
    80001cca:	6cb8                	ld	a4,88(s1)
    80001ccc:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
    80001cd0:	6cb8                	ld	a4,88(s1)
    80001cd2:	fb1c                	sd	a5,48(a4)
    80001cd4:	4641                	li	a2,16
    80001cd6:	00006597          	auipc	a1,0x6
    80001cda:	98a58593          	addi	a1,a1,-1654 # 80007660 <userret+0x5d0>
    80001cde:	15848513          	addi	a0,s1,344
    80001ce2:	fffff097          	auipc	ra,0xfffff
    80001ce6:	030080e7          	jalr	48(ra) # 80000d12 <safestrcpy>
    80001cea:	00006517          	auipc	a0,0x6
    80001cee:	98650513          	addi	a0,a0,-1658 # 80007670 <userret+0x5e0>
    80001cf2:	00002097          	auipc	ra,0x2
    80001cf6:	0d8080e7          	jalr	216(ra) # 80003dca <namei>
    80001cfa:	14a4b823          	sd	a0,336(s1)
    80001cfe:	4789                	li	a5,2
    80001d00:	cc9c                	sw	a5,24(s1)
    80001d02:	8526                	mv	a0,s1
    80001d04:	fffff097          	auipc	ra,0xfffff
    80001d08:	e4e080e7          	jalr	-434(ra) # 80000b52 <release>
    80001d0c:	60e2                	ld	ra,24(sp)
    80001d0e:	6442                	ld	s0,16(sp)
    80001d10:	64a2                	ld	s1,8(sp)
    80001d12:	6105                	addi	sp,sp,32
    80001d14:	8082                	ret

0000000080001d16 <growproc>:
    80001d16:	1101                	addi	sp,sp,-32
    80001d18:	ec06                	sd	ra,24(sp)
    80001d1a:	e822                	sd	s0,16(sp)
    80001d1c:	e426                	sd	s1,8(sp)
    80001d1e:	e04a                	sd	s2,0(sp)
    80001d20:	1000                	addi	s0,sp,32
    80001d22:	84aa                	mv	s1,a0
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	cfa080e7          	jalr	-774(ra) # 80001a1e <myproc>
    80001d2c:	892a                	mv	s2,a0
    80001d2e:	652c                	ld	a1,72(a0)
    80001d30:	0005851b          	sext.w	a0,a1
    80001d34:	00904f63          	bgtz	s1,80001d52 <growproc+0x3c>
    80001d38:	0204cd63          	bltz	s1,80001d72 <growproc+0x5c>
    80001d3c:	1502                	slli	a0,a0,0x20
    80001d3e:	9101                	srli	a0,a0,0x20
    80001d40:	04a93423          	sd	a0,72(s2)
    80001d44:	4501                	li	a0,0
    80001d46:	60e2                	ld	ra,24(sp)
    80001d48:	6442                	ld	s0,16(sp)
    80001d4a:	64a2                	ld	s1,8(sp)
    80001d4c:	6902                	ld	s2,0(sp)
    80001d4e:	6105                	addi	sp,sp,32
    80001d50:	8082                	ret
    80001d52:	00a4863b          	addw	a2,s1,a0
    80001d56:	1602                	slli	a2,a2,0x20
    80001d58:	9201                	srli	a2,a2,0x20
    80001d5a:	1582                	slli	a1,a1,0x20
    80001d5c:	9181                	srli	a1,a1,0x20
    80001d5e:	05093503          	ld	a0,80(s2)
    80001d62:	fffff097          	auipc	ra,0xfffff
    80001d66:	7be080e7          	jalr	1982(ra) # 80001520 <uvmalloc>
    80001d6a:	2501                	sext.w	a0,a0
    80001d6c:	f961                	bnez	a0,80001d3c <growproc+0x26>
    80001d6e:	557d                	li	a0,-1
    80001d70:	bfd9                	j	80001d46 <growproc+0x30>
    80001d72:	00a4863b          	addw	a2,s1,a0
    80001d76:	1602                	slli	a2,a2,0x20
    80001d78:	9201                	srli	a2,a2,0x20
    80001d7a:	1582                	slli	a1,a1,0x20
    80001d7c:	9181                	srli	a1,a1,0x20
    80001d7e:	05093503          	ld	a0,80(s2)
    80001d82:	fffff097          	auipc	ra,0xfffff
    80001d86:	75a080e7          	jalr	1882(ra) # 800014dc <uvmdealloc>
    80001d8a:	2501                	sext.w	a0,a0
    80001d8c:	bf45                	j	80001d3c <growproc+0x26>

0000000080001d8e <fork>:
    80001d8e:	7179                	addi	sp,sp,-48
    80001d90:	f406                	sd	ra,40(sp)
    80001d92:	f022                	sd	s0,32(sp)
    80001d94:	ec26                	sd	s1,24(sp)
    80001d96:	e84a                	sd	s2,16(sp)
    80001d98:	e44e                	sd	s3,8(sp)
    80001d9a:	e052                	sd	s4,0(sp)
    80001d9c:	1800                	addi	s0,sp,48
    80001d9e:	00000097          	auipc	ra,0x0
    80001da2:	c80080e7          	jalr	-896(ra) # 80001a1e <myproc>
    80001da6:	892a                	mv	s2,a0
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	d98080e7          	jalr	-616(ra) # 80001b40 <allocproc>
    80001db0:	c175                	beqz	a0,80001e94 <fork+0x106>
    80001db2:	89aa                	mv	s3,a0
    80001db4:	04893603          	ld	a2,72(s2)
    80001db8:	692c                	ld	a1,80(a0)
    80001dba:	05093503          	ld	a0,80(s2)
    80001dbe:	00000097          	auipc	ra,0x0
    80001dc2:	83a080e7          	jalr	-1990(ra) # 800015f8 <uvmcopy>
    80001dc6:	04054863          	bltz	a0,80001e16 <fork+0x88>
    80001dca:	04893783          	ld	a5,72(s2)
    80001dce:	04f9b423          	sd	a5,72(s3) # 4000048 <_entry-0x7bffffb8>
    80001dd2:	0329b023          	sd	s2,32(s3)
    80001dd6:	05893683          	ld	a3,88(s2)
    80001dda:	87b6                	mv	a5,a3
    80001ddc:	0589b703          	ld	a4,88(s3)
    80001de0:	12068693          	addi	a3,a3,288
    80001de4:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001de8:	6788                	ld	a0,8(a5)
    80001dea:	6b8c                	ld	a1,16(a5)
    80001dec:	6f90                	ld	a2,24(a5)
    80001dee:	01073023          	sd	a6,0(a4)
    80001df2:	e708                	sd	a0,8(a4)
    80001df4:	eb0c                	sd	a1,16(a4)
    80001df6:	ef10                	sd	a2,24(a4)
    80001df8:	02078793          	addi	a5,a5,32
    80001dfc:	02070713          	addi	a4,a4,32
    80001e00:	fed792e3          	bne	a5,a3,80001de4 <fork+0x56>
    80001e04:	0589b783          	ld	a5,88(s3)
    80001e08:	0607b823          	sd	zero,112(a5)
    80001e0c:	0d000493          	li	s1,208
    80001e10:	15000a13          	li	s4,336
    80001e14:	a03d                	j	80001e42 <fork+0xb4>
    80001e16:	854e                	mv	a0,s3
    80001e18:	00000097          	auipc	ra,0x0
    80001e1c:	e24080e7          	jalr	-476(ra) # 80001c3c <freeproc>
    80001e20:	854e                	mv	a0,s3
    80001e22:	fffff097          	auipc	ra,0xfffff
    80001e26:	d30080e7          	jalr	-720(ra) # 80000b52 <release>
    80001e2a:	54fd                	li	s1,-1
    80001e2c:	a899                	j	80001e82 <fork+0xf4>
    80001e2e:	00002097          	auipc	ra,0x2
    80001e32:	65a080e7          	jalr	1626(ra) # 80004488 <filedup>
    80001e36:	009987b3          	add	a5,s3,s1
    80001e3a:	e388                	sd	a0,0(a5)
    80001e3c:	04a1                	addi	s1,s1,8
    80001e3e:	01448763          	beq	s1,s4,80001e4c <fork+0xbe>
    80001e42:	009907b3          	add	a5,s2,s1
    80001e46:	6388                	ld	a0,0(a5)
    80001e48:	f17d                	bnez	a0,80001e2e <fork+0xa0>
    80001e4a:	bfcd                	j	80001e3c <fork+0xae>
    80001e4c:	15093503          	ld	a0,336(s2)
    80001e50:	00001097          	auipc	ra,0x1
    80001e54:	7a8080e7          	jalr	1960(ra) # 800035f8 <idup>
    80001e58:	14a9b823          	sd	a0,336(s3)
    80001e5c:	4641                	li	a2,16
    80001e5e:	15890593          	addi	a1,s2,344
    80001e62:	15898513          	addi	a0,s3,344
    80001e66:	fffff097          	auipc	ra,0xfffff
    80001e6a:	eac080e7          	jalr	-340(ra) # 80000d12 <safestrcpy>
    80001e6e:	0389a483          	lw	s1,56(s3)
    80001e72:	4789                	li	a5,2
    80001e74:	00f9ac23          	sw	a5,24(s3)
    80001e78:	854e                	mv	a0,s3
    80001e7a:	fffff097          	auipc	ra,0xfffff
    80001e7e:	cd8080e7          	jalr	-808(ra) # 80000b52 <release>
    80001e82:	8526                	mv	a0,s1
    80001e84:	70a2                	ld	ra,40(sp)
    80001e86:	7402                	ld	s0,32(sp)
    80001e88:	64e2                	ld	s1,24(sp)
    80001e8a:	6942                	ld	s2,16(sp)
    80001e8c:	69a2                	ld	s3,8(sp)
    80001e8e:	6a02                	ld	s4,0(sp)
    80001e90:	6145                	addi	sp,sp,48
    80001e92:	8082                	ret
    80001e94:	54fd                	li	s1,-1
    80001e96:	b7f5                	j	80001e82 <fork+0xf4>

0000000080001e98 <reparent>:
    80001e98:	7179                	addi	sp,sp,-48
    80001e9a:	f406                	sd	ra,40(sp)
    80001e9c:	f022                	sd	s0,32(sp)
    80001e9e:	ec26                	sd	s1,24(sp)
    80001ea0:	e84a                	sd	s2,16(sp)
    80001ea2:	e44e                	sd	s3,8(sp)
    80001ea4:	e052                	sd	s4,0(sp)
    80001ea6:	1800                	addi	s0,sp,48
    80001ea8:	89aa                	mv	s3,a0
    80001eaa:	00010497          	auipc	s1,0x10
    80001eae:	e5648493          	addi	s1,s1,-426 # 80011d00 <proc>
    80001eb2:	00024a17          	auipc	s4,0x24
    80001eb6:	15ea0a13          	addi	s4,s4,350 # 80026010 <initproc>
    80001eba:	00016917          	auipc	s2,0x16
    80001ebe:	84690913          	addi	s2,s2,-1978 # 80017700 <tickslock>
    80001ec2:	a029                	j	80001ecc <reparent+0x34>
    80001ec4:	16848493          	addi	s1,s1,360
    80001ec8:	03248363          	beq	s1,s2,80001eee <reparent+0x56>
    80001ecc:	709c                	ld	a5,32(s1)
    80001ece:	ff379be3          	bne	a5,s3,80001ec4 <reparent+0x2c>
    80001ed2:	8526                	mv	a0,s1
    80001ed4:	fffff097          	auipc	ra,0xfffff
    80001ed8:	c2a080e7          	jalr	-982(ra) # 80000afe <acquire>
    80001edc:	000a3783          	ld	a5,0(s4)
    80001ee0:	f09c                	sd	a5,32(s1)
    80001ee2:	8526                	mv	a0,s1
    80001ee4:	fffff097          	auipc	ra,0xfffff
    80001ee8:	c6e080e7          	jalr	-914(ra) # 80000b52 <release>
    80001eec:	bfe1                	j	80001ec4 <reparent+0x2c>
    80001eee:	70a2                	ld	ra,40(sp)
    80001ef0:	7402                	ld	s0,32(sp)
    80001ef2:	64e2                	ld	s1,24(sp)
    80001ef4:	6942                	ld	s2,16(sp)
    80001ef6:	69a2                	ld	s3,8(sp)
    80001ef8:	6a02                	ld	s4,0(sp)
    80001efa:	6145                	addi	sp,sp,48
    80001efc:	8082                	ret

0000000080001efe <scheduler>:
    80001efe:	7139                	addi	sp,sp,-64
    80001f00:	fc06                	sd	ra,56(sp)
    80001f02:	f822                	sd	s0,48(sp)
    80001f04:	f426                	sd	s1,40(sp)
    80001f06:	f04a                	sd	s2,32(sp)
    80001f08:	ec4e                	sd	s3,24(sp)
    80001f0a:	e852                	sd	s4,16(sp)
    80001f0c:	e456                	sd	s5,8(sp)
    80001f0e:	e05a                	sd	s6,0(sp)
    80001f10:	0080                	addi	s0,sp,64
    80001f12:	8792                	mv	a5,tp
    80001f14:	2781                	sext.w	a5,a5
    80001f16:	00779a93          	slli	s5,a5,0x7
    80001f1a:	00010717          	auipc	a4,0x10
    80001f1e:	9ce70713          	addi	a4,a4,-1586 # 800118e8 <pid_lock>
    80001f22:	9756                	add	a4,a4,s5
    80001f24:	00073c23          	sd	zero,24(a4)
    80001f28:	00010717          	auipc	a4,0x10
    80001f2c:	9e070713          	addi	a4,a4,-1568 # 80011908 <cpus+0x8>
    80001f30:	9aba                	add	s5,s5,a4
    80001f32:	4989                	li	s3,2
    80001f34:	4b0d                	li	s6,3
    80001f36:	079e                	slli	a5,a5,0x7
    80001f38:	00010a17          	auipc	s4,0x10
    80001f3c:	9b0a0a13          	addi	s4,s4,-1616 # 800118e8 <pid_lock>
    80001f40:	9a3e                	add	s4,s4,a5
    80001f42:	00015917          	auipc	s2,0x15
    80001f46:	7be90913          	addi	s2,s2,1982 # 80017700 <tickslock>
    80001f4a:	104027f3          	csrr	a5,sie
    80001f4e:	2227e793          	ori	a5,a5,546
    80001f52:	10479073          	csrw	sie,a5
    80001f56:	100027f3          	csrr	a5,sstatus
    80001f5a:	0027e793          	ori	a5,a5,2
    80001f5e:	10079073          	csrw	sstatus,a5
    80001f62:	00010497          	auipc	s1,0x10
    80001f66:	d9e48493          	addi	s1,s1,-610 # 80011d00 <proc>
    80001f6a:	a03d                	j	80001f98 <scheduler+0x9a>
    80001f6c:	0164ac23          	sw	s6,24(s1)
    80001f70:	009a3c23          	sd	s1,24(s4)
    80001f74:	06048593          	addi	a1,s1,96
    80001f78:	8556                	mv	a0,s5
    80001f7a:	00000097          	auipc	ra,0x0
    80001f7e:	60e080e7          	jalr	1550(ra) # 80002588 <swtch>
    80001f82:	000a3c23          	sd	zero,24(s4)
    80001f86:	8526                	mv	a0,s1
    80001f88:	fffff097          	auipc	ra,0xfffff
    80001f8c:	bca080e7          	jalr	-1078(ra) # 80000b52 <release>
    80001f90:	16848493          	addi	s1,s1,360
    80001f94:	fb248be3          	beq	s1,s2,80001f4a <scheduler+0x4c>
    80001f98:	8526                	mv	a0,s1
    80001f9a:	fffff097          	auipc	ra,0xfffff
    80001f9e:	b64080e7          	jalr	-1180(ra) # 80000afe <acquire>
    80001fa2:	4c9c                	lw	a5,24(s1)
    80001fa4:	ff3791e3          	bne	a5,s3,80001f86 <scheduler+0x88>
    80001fa8:	b7d1                	j	80001f6c <scheduler+0x6e>

0000000080001faa <sched>:
    80001faa:	7179                	addi	sp,sp,-48
    80001fac:	f406                	sd	ra,40(sp)
    80001fae:	f022                	sd	s0,32(sp)
    80001fb0:	ec26                	sd	s1,24(sp)
    80001fb2:	e84a                	sd	s2,16(sp)
    80001fb4:	e44e                	sd	s3,8(sp)
    80001fb6:	1800                	addi	s0,sp,48
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	a66080e7          	jalr	-1434(ra) # 80001a1e <myproc>
    80001fc0:	892a                	mv	s2,a0
    80001fc2:	fffff097          	auipc	ra,0xfffff
    80001fc6:	afc080e7          	jalr	-1284(ra) # 80000abe <holding>
    80001fca:	cd25                	beqz	a0,80002042 <sched+0x98>
    80001fcc:	8792                	mv	a5,tp
    80001fce:	2781                	sext.w	a5,a5
    80001fd0:	079e                	slli	a5,a5,0x7
    80001fd2:	00010717          	auipc	a4,0x10
    80001fd6:	91670713          	addi	a4,a4,-1770 # 800118e8 <pid_lock>
    80001fda:	97ba                	add	a5,a5,a4
    80001fdc:	0907a703          	lw	a4,144(a5)
    80001fe0:	4785                	li	a5,1
    80001fe2:	06f71863          	bne	a4,a5,80002052 <sched+0xa8>
    80001fe6:	01892703          	lw	a4,24(s2)
    80001fea:	478d                	li	a5,3
    80001fec:	06f70b63          	beq	a4,a5,80002062 <sched+0xb8>
    80001ff0:	100027f3          	csrr	a5,sstatus
    80001ff4:	8b89                	andi	a5,a5,2
    80001ff6:	efb5                	bnez	a5,80002072 <sched+0xc8>
    80001ff8:	8792                	mv	a5,tp
    80001ffa:	00010497          	auipc	s1,0x10
    80001ffe:	8ee48493          	addi	s1,s1,-1810 # 800118e8 <pid_lock>
    80002002:	2781                	sext.w	a5,a5
    80002004:	079e                	slli	a5,a5,0x7
    80002006:	97a6                	add	a5,a5,s1
    80002008:	0947a983          	lw	s3,148(a5)
    8000200c:	8792                	mv	a5,tp
    8000200e:	2781                	sext.w	a5,a5
    80002010:	079e                	slli	a5,a5,0x7
    80002012:	00010597          	auipc	a1,0x10
    80002016:	8f658593          	addi	a1,a1,-1802 # 80011908 <cpus+0x8>
    8000201a:	95be                	add	a1,a1,a5
    8000201c:	06090513          	addi	a0,s2,96
    80002020:	00000097          	auipc	ra,0x0
    80002024:	568080e7          	jalr	1384(ra) # 80002588 <swtch>
    80002028:	8792                	mv	a5,tp
    8000202a:	2781                	sext.w	a5,a5
    8000202c:	079e                	slli	a5,a5,0x7
    8000202e:	97a6                	add	a5,a5,s1
    80002030:	0937aa23          	sw	s3,148(a5)
    80002034:	70a2                	ld	ra,40(sp)
    80002036:	7402                	ld	s0,32(sp)
    80002038:	64e2                	ld	s1,24(sp)
    8000203a:	6942                	ld	s2,16(sp)
    8000203c:	69a2                	ld	s3,8(sp)
    8000203e:	6145                	addi	sp,sp,48
    80002040:	8082                	ret
    80002042:	00005517          	auipc	a0,0x5
    80002046:	63650513          	addi	a0,a0,1590 # 80007678 <userret+0x5e8>
    8000204a:	ffffe097          	auipc	ra,0xffffe
    8000204e:	534080e7          	jalr	1332(ra) # 8000057e <panic>
    80002052:	00005517          	auipc	a0,0x5
    80002056:	63650513          	addi	a0,a0,1590 # 80007688 <userret+0x5f8>
    8000205a:	ffffe097          	auipc	ra,0xffffe
    8000205e:	524080e7          	jalr	1316(ra) # 8000057e <panic>
    80002062:	00005517          	auipc	a0,0x5
    80002066:	63650513          	addi	a0,a0,1590 # 80007698 <userret+0x608>
    8000206a:	ffffe097          	auipc	ra,0xffffe
    8000206e:	514080e7          	jalr	1300(ra) # 8000057e <panic>
    80002072:	00005517          	auipc	a0,0x5
    80002076:	63650513          	addi	a0,a0,1590 # 800076a8 <userret+0x618>
    8000207a:	ffffe097          	auipc	ra,0xffffe
    8000207e:	504080e7          	jalr	1284(ra) # 8000057e <panic>

0000000080002082 <exit>:
    80002082:	7179                	addi	sp,sp,-48
    80002084:	f406                	sd	ra,40(sp)
    80002086:	f022                	sd	s0,32(sp)
    80002088:	ec26                	sd	s1,24(sp)
    8000208a:	e84a                	sd	s2,16(sp)
    8000208c:	e44e                	sd	s3,8(sp)
    8000208e:	e052                	sd	s4,0(sp)
    80002090:	1800                	addi	s0,sp,48
    80002092:	8a2a                	mv	s4,a0
    80002094:	00000097          	auipc	ra,0x0
    80002098:	98a080e7          	jalr	-1654(ra) # 80001a1e <myproc>
    8000209c:	89aa                	mv	s3,a0
    8000209e:	00024797          	auipc	a5,0x24
    800020a2:	f7278793          	addi	a5,a5,-142 # 80026010 <initproc>
    800020a6:	639c                	ld	a5,0(a5)
    800020a8:	0d050493          	addi	s1,a0,208
    800020ac:	15050913          	addi	s2,a0,336
    800020b0:	02a79363          	bne	a5,a0,800020d6 <exit+0x54>
    800020b4:	00005517          	auipc	a0,0x5
    800020b8:	60c50513          	addi	a0,a0,1548 # 800076c0 <userret+0x630>
    800020bc:	ffffe097          	auipc	ra,0xffffe
    800020c0:	4c2080e7          	jalr	1218(ra) # 8000057e <panic>
    800020c4:	00002097          	auipc	ra,0x2
    800020c8:	416080e7          	jalr	1046(ra) # 800044da <fileclose>
    800020cc:	0004b023          	sd	zero,0(s1)
    800020d0:	04a1                	addi	s1,s1,8
    800020d2:	01248563          	beq	s1,s2,800020dc <exit+0x5a>
    800020d6:	6088                	ld	a0,0(s1)
    800020d8:	f575                	bnez	a0,800020c4 <exit+0x42>
    800020da:	bfdd                	j	800020d0 <exit+0x4e>
    800020dc:	00002097          	auipc	ra,0x2
    800020e0:	efc080e7          	jalr	-260(ra) # 80003fd8 <begin_op>
    800020e4:	1509b503          	ld	a0,336(s3)
    800020e8:	00001097          	auipc	ra,0x1
    800020ec:	65e080e7          	jalr	1630(ra) # 80003746 <iput>
    800020f0:	00002097          	auipc	ra,0x2
    800020f4:	f68080e7          	jalr	-152(ra) # 80004058 <end_op>
    800020f8:	1409b823          	sd	zero,336(s3)
    800020fc:	00024497          	auipc	s1,0x24
    80002100:	f1448493          	addi	s1,s1,-236 # 80026010 <initproc>
    80002104:	6088                	ld	a0,0(s1)
    80002106:	fffff097          	auipc	ra,0xfffff
    8000210a:	9f8080e7          	jalr	-1544(ra) # 80000afe <acquire>
    8000210e:	6088                	ld	a0,0(s1)
    80002110:	fffff097          	auipc	ra,0xfffff
    80002114:	7ce080e7          	jalr	1998(ra) # 800018de <wakeup1>
    80002118:	6088                	ld	a0,0(s1)
    8000211a:	fffff097          	auipc	ra,0xfffff
    8000211e:	a38080e7          	jalr	-1480(ra) # 80000b52 <release>
    80002122:	854e                	mv	a0,s3
    80002124:	fffff097          	auipc	ra,0xfffff
    80002128:	9da080e7          	jalr	-1574(ra) # 80000afe <acquire>
    8000212c:	0209b483          	ld	s1,32(s3)
    80002130:	854e                	mv	a0,s3
    80002132:	fffff097          	auipc	ra,0xfffff
    80002136:	a20080e7          	jalr	-1504(ra) # 80000b52 <release>
    8000213a:	8526                	mv	a0,s1
    8000213c:	fffff097          	auipc	ra,0xfffff
    80002140:	9c2080e7          	jalr	-1598(ra) # 80000afe <acquire>
    80002144:	854e                	mv	a0,s3
    80002146:	fffff097          	auipc	ra,0xfffff
    8000214a:	9b8080e7          	jalr	-1608(ra) # 80000afe <acquire>
    8000214e:	854e                	mv	a0,s3
    80002150:	00000097          	auipc	ra,0x0
    80002154:	d48080e7          	jalr	-696(ra) # 80001e98 <reparent>
    80002158:	8526                	mv	a0,s1
    8000215a:	fffff097          	auipc	ra,0xfffff
    8000215e:	784080e7          	jalr	1924(ra) # 800018de <wakeup1>
    80002162:	0349aa23          	sw	s4,52(s3)
    80002166:	4791                	li	a5,4
    80002168:	00f9ac23          	sw	a5,24(s3)
    8000216c:	8526                	mv	a0,s1
    8000216e:	fffff097          	auipc	ra,0xfffff
    80002172:	9e4080e7          	jalr	-1564(ra) # 80000b52 <release>
    80002176:	00000097          	auipc	ra,0x0
    8000217a:	e34080e7          	jalr	-460(ra) # 80001faa <sched>
    8000217e:	00005517          	auipc	a0,0x5
    80002182:	55250513          	addi	a0,a0,1362 # 800076d0 <userret+0x640>
    80002186:	ffffe097          	auipc	ra,0xffffe
    8000218a:	3f8080e7          	jalr	1016(ra) # 8000057e <panic>

000000008000218e <yield>:
    8000218e:	1101                	addi	sp,sp,-32
    80002190:	ec06                	sd	ra,24(sp)
    80002192:	e822                	sd	s0,16(sp)
    80002194:	e426                	sd	s1,8(sp)
    80002196:	1000                	addi	s0,sp,32
    80002198:	00000097          	auipc	ra,0x0
    8000219c:	886080e7          	jalr	-1914(ra) # 80001a1e <myproc>
    800021a0:	84aa                	mv	s1,a0
    800021a2:	fffff097          	auipc	ra,0xfffff
    800021a6:	95c080e7          	jalr	-1700(ra) # 80000afe <acquire>
    800021aa:	4789                	li	a5,2
    800021ac:	cc9c                	sw	a5,24(s1)
    800021ae:	00000097          	auipc	ra,0x0
    800021b2:	dfc080e7          	jalr	-516(ra) # 80001faa <sched>
    800021b6:	8526                	mv	a0,s1
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	99a080e7          	jalr	-1638(ra) # 80000b52 <release>
    800021c0:	60e2                	ld	ra,24(sp)
    800021c2:	6442                	ld	s0,16(sp)
    800021c4:	64a2                	ld	s1,8(sp)
    800021c6:	6105                	addi	sp,sp,32
    800021c8:	8082                	ret

00000000800021ca <sleep>:
    800021ca:	7179                	addi	sp,sp,-48
    800021cc:	f406                	sd	ra,40(sp)
    800021ce:	f022                	sd	s0,32(sp)
    800021d0:	ec26                	sd	s1,24(sp)
    800021d2:	e84a                	sd	s2,16(sp)
    800021d4:	e44e                	sd	s3,8(sp)
    800021d6:	1800                	addi	s0,sp,48
    800021d8:	89aa                	mv	s3,a0
    800021da:	892e                	mv	s2,a1
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	842080e7          	jalr	-1982(ra) # 80001a1e <myproc>
    800021e4:	84aa                	mv	s1,a0
    800021e6:	05250663          	beq	a0,s2,80002232 <sleep+0x68>
    800021ea:	fffff097          	auipc	ra,0xfffff
    800021ee:	914080e7          	jalr	-1772(ra) # 80000afe <acquire>
    800021f2:	854a                	mv	a0,s2
    800021f4:	fffff097          	auipc	ra,0xfffff
    800021f8:	95e080e7          	jalr	-1698(ra) # 80000b52 <release>
    800021fc:	0334b423          	sd	s3,40(s1)
    80002200:	4785                	li	a5,1
    80002202:	cc9c                	sw	a5,24(s1)
    80002204:	00000097          	auipc	ra,0x0
    80002208:	da6080e7          	jalr	-602(ra) # 80001faa <sched>
    8000220c:	0204b423          	sd	zero,40(s1)
    80002210:	8526                	mv	a0,s1
    80002212:	fffff097          	auipc	ra,0xfffff
    80002216:	940080e7          	jalr	-1728(ra) # 80000b52 <release>
    8000221a:	854a                	mv	a0,s2
    8000221c:	fffff097          	auipc	ra,0xfffff
    80002220:	8e2080e7          	jalr	-1822(ra) # 80000afe <acquire>
    80002224:	70a2                	ld	ra,40(sp)
    80002226:	7402                	ld	s0,32(sp)
    80002228:	64e2                	ld	s1,24(sp)
    8000222a:	6942                	ld	s2,16(sp)
    8000222c:	69a2                	ld	s3,8(sp)
    8000222e:	6145                	addi	sp,sp,48
    80002230:	8082                	ret
    80002232:	03353423          	sd	s3,40(a0)
    80002236:	4785                	li	a5,1
    80002238:	cd1c                	sw	a5,24(a0)
    8000223a:	00000097          	auipc	ra,0x0
    8000223e:	d70080e7          	jalr	-656(ra) # 80001faa <sched>
    80002242:	0204b423          	sd	zero,40(s1)
    80002246:	bff9                	j	80002224 <sleep+0x5a>

0000000080002248 <wait>:
    80002248:	715d                	addi	sp,sp,-80
    8000224a:	e486                	sd	ra,72(sp)
    8000224c:	e0a2                	sd	s0,64(sp)
    8000224e:	fc26                	sd	s1,56(sp)
    80002250:	f84a                	sd	s2,48(sp)
    80002252:	f44e                	sd	s3,40(sp)
    80002254:	f052                	sd	s4,32(sp)
    80002256:	ec56                	sd	s5,24(sp)
    80002258:	e85a                	sd	s6,16(sp)
    8000225a:	e45e                	sd	s7,8(sp)
    8000225c:	e062                	sd	s8,0(sp)
    8000225e:	0880                	addi	s0,sp,80
    80002260:	8baa                	mv	s7,a0
    80002262:	fffff097          	auipc	ra,0xfffff
    80002266:	7bc080e7          	jalr	1980(ra) # 80001a1e <myproc>
    8000226a:	892a                	mv	s2,a0
    8000226c:	8c2a                	mv	s8,a0
    8000226e:	fffff097          	auipc	ra,0xfffff
    80002272:	890080e7          	jalr	-1904(ra) # 80000afe <acquire>
    80002276:	4b01                	li	s6,0
    80002278:	4a11                	li	s4,4
    8000227a:	00015997          	auipc	s3,0x15
    8000227e:	48698993          	addi	s3,s3,1158 # 80017700 <tickslock>
    80002282:	4a85                	li	s5,1
    80002284:	875a                	mv	a4,s6
    80002286:	00010497          	auipc	s1,0x10
    8000228a:	a7a48493          	addi	s1,s1,-1414 # 80011d00 <proc>
    8000228e:	a08d                	j	800022f0 <wait+0xa8>
    80002290:	0384a983          	lw	s3,56(s1)
    80002294:	000b8e63          	beqz	s7,800022b0 <wait+0x68>
    80002298:	4691                	li	a3,4
    8000229a:	03448613          	addi	a2,s1,52
    8000229e:	85de                	mv	a1,s7
    800022a0:	05093503          	ld	a0,80(s2)
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	456080e7          	jalr	1110(ra) # 800016fa <copyout>
    800022ac:	02054263          	bltz	a0,800022d0 <wait+0x88>
    800022b0:	8526                	mv	a0,s1
    800022b2:	00000097          	auipc	ra,0x0
    800022b6:	98a080e7          	jalr	-1654(ra) # 80001c3c <freeproc>
    800022ba:	8526                	mv	a0,s1
    800022bc:	fffff097          	auipc	ra,0xfffff
    800022c0:	896080e7          	jalr	-1898(ra) # 80000b52 <release>
    800022c4:	854a                	mv	a0,s2
    800022c6:	fffff097          	auipc	ra,0xfffff
    800022ca:	88c080e7          	jalr	-1908(ra) # 80000b52 <release>
    800022ce:	a8a9                	j	80002328 <wait+0xe0>
    800022d0:	8526                	mv	a0,s1
    800022d2:	fffff097          	auipc	ra,0xfffff
    800022d6:	880080e7          	jalr	-1920(ra) # 80000b52 <release>
    800022da:	854a                	mv	a0,s2
    800022dc:	fffff097          	auipc	ra,0xfffff
    800022e0:	876080e7          	jalr	-1930(ra) # 80000b52 <release>
    800022e4:	59fd                	li	s3,-1
    800022e6:	a089                	j	80002328 <wait+0xe0>
    800022e8:	16848493          	addi	s1,s1,360
    800022ec:	03348463          	beq	s1,s3,80002314 <wait+0xcc>
    800022f0:	709c                	ld	a5,32(s1)
    800022f2:	ff279be3          	bne	a5,s2,800022e8 <wait+0xa0>
    800022f6:	8526                	mv	a0,s1
    800022f8:	fffff097          	auipc	ra,0xfffff
    800022fc:	806080e7          	jalr	-2042(ra) # 80000afe <acquire>
    80002300:	4c9c                	lw	a5,24(s1)
    80002302:	f94787e3          	beq	a5,s4,80002290 <wait+0x48>
    80002306:	8526                	mv	a0,s1
    80002308:	fffff097          	auipc	ra,0xfffff
    8000230c:	84a080e7          	jalr	-1974(ra) # 80000b52 <release>
    80002310:	8756                	mv	a4,s5
    80002312:	bfd9                	j	800022e8 <wait+0xa0>
    80002314:	c701                	beqz	a4,8000231c <wait+0xd4>
    80002316:	03092783          	lw	a5,48(s2)
    8000231a:	c785                	beqz	a5,80002342 <wait+0xfa>
    8000231c:	854a                	mv	a0,s2
    8000231e:	fffff097          	auipc	ra,0xfffff
    80002322:	834080e7          	jalr	-1996(ra) # 80000b52 <release>
    80002326:	59fd                	li	s3,-1
    80002328:	854e                	mv	a0,s3
    8000232a:	60a6                	ld	ra,72(sp)
    8000232c:	6406                	ld	s0,64(sp)
    8000232e:	74e2                	ld	s1,56(sp)
    80002330:	7942                	ld	s2,48(sp)
    80002332:	79a2                	ld	s3,40(sp)
    80002334:	7a02                	ld	s4,32(sp)
    80002336:	6ae2                	ld	s5,24(sp)
    80002338:	6b42                	ld	s6,16(sp)
    8000233a:	6ba2                	ld	s7,8(sp)
    8000233c:	6c02                	ld	s8,0(sp)
    8000233e:	6161                	addi	sp,sp,80
    80002340:	8082                	ret
    80002342:	85e2                	mv	a1,s8
    80002344:	854a                	mv	a0,s2
    80002346:	00000097          	auipc	ra,0x0
    8000234a:	e84080e7          	jalr	-380(ra) # 800021ca <sleep>
    8000234e:	bf1d                	j	80002284 <wait+0x3c>

0000000080002350 <wakeup>:
    80002350:	7139                	addi	sp,sp,-64
    80002352:	fc06                	sd	ra,56(sp)
    80002354:	f822                	sd	s0,48(sp)
    80002356:	f426                	sd	s1,40(sp)
    80002358:	f04a                	sd	s2,32(sp)
    8000235a:	ec4e                	sd	s3,24(sp)
    8000235c:	e852                	sd	s4,16(sp)
    8000235e:	e456                	sd	s5,8(sp)
    80002360:	0080                	addi	s0,sp,64
    80002362:	8a2a                	mv	s4,a0
    80002364:	00010497          	auipc	s1,0x10
    80002368:	99c48493          	addi	s1,s1,-1636 # 80011d00 <proc>
    8000236c:	4985                	li	s3,1
    8000236e:	4a89                	li	s5,2
    80002370:	00015917          	auipc	s2,0x15
    80002374:	39090913          	addi	s2,s2,912 # 80017700 <tickslock>
    80002378:	a821                	j	80002390 <wakeup+0x40>
    8000237a:	0154ac23          	sw	s5,24(s1)
    8000237e:	8526                	mv	a0,s1
    80002380:	ffffe097          	auipc	ra,0xffffe
    80002384:	7d2080e7          	jalr	2002(ra) # 80000b52 <release>
    80002388:	16848493          	addi	s1,s1,360
    8000238c:	01248e63          	beq	s1,s2,800023a8 <wakeup+0x58>
    80002390:	8526                	mv	a0,s1
    80002392:	ffffe097          	auipc	ra,0xffffe
    80002396:	76c080e7          	jalr	1900(ra) # 80000afe <acquire>
    8000239a:	4c9c                	lw	a5,24(s1)
    8000239c:	ff3791e3          	bne	a5,s3,8000237e <wakeup+0x2e>
    800023a0:	749c                	ld	a5,40(s1)
    800023a2:	fd479ee3          	bne	a5,s4,8000237e <wakeup+0x2e>
    800023a6:	bfd1                	j	8000237a <wakeup+0x2a>
    800023a8:	70e2                	ld	ra,56(sp)
    800023aa:	7442                	ld	s0,48(sp)
    800023ac:	74a2                	ld	s1,40(sp)
    800023ae:	7902                	ld	s2,32(sp)
    800023b0:	69e2                	ld	s3,24(sp)
    800023b2:	6a42                	ld	s4,16(sp)
    800023b4:	6aa2                	ld	s5,8(sp)
    800023b6:	6121                	addi	sp,sp,64
    800023b8:	8082                	ret

00000000800023ba <kill>:
    800023ba:	7179                	addi	sp,sp,-48
    800023bc:	f406                	sd	ra,40(sp)
    800023be:	f022                	sd	s0,32(sp)
    800023c0:	ec26                	sd	s1,24(sp)
    800023c2:	e84a                	sd	s2,16(sp)
    800023c4:	e44e                	sd	s3,8(sp)
    800023c6:	1800                	addi	s0,sp,48
    800023c8:	892a                	mv	s2,a0
    800023ca:	00010497          	auipc	s1,0x10
    800023ce:	93648493          	addi	s1,s1,-1738 # 80011d00 <proc>
    800023d2:	00015997          	auipc	s3,0x15
    800023d6:	32e98993          	addi	s3,s3,814 # 80017700 <tickslock>
    800023da:	8526                	mv	a0,s1
    800023dc:	ffffe097          	auipc	ra,0xffffe
    800023e0:	722080e7          	jalr	1826(ra) # 80000afe <acquire>
    800023e4:	5c9c                	lw	a5,56(s1)
    800023e6:	01278d63          	beq	a5,s2,80002400 <kill+0x46>
    800023ea:	8526                	mv	a0,s1
    800023ec:	ffffe097          	auipc	ra,0xffffe
    800023f0:	766080e7          	jalr	1894(ra) # 80000b52 <release>
    800023f4:	16848493          	addi	s1,s1,360
    800023f8:	ff3491e3          	bne	s1,s3,800023da <kill+0x20>
    800023fc:	557d                	li	a0,-1
    800023fe:	a829                	j	80002418 <kill+0x5e>
    80002400:	4785                	li	a5,1
    80002402:	d89c                	sw	a5,48(s1)
    80002404:	4c98                	lw	a4,24(s1)
    80002406:	4785                	li	a5,1
    80002408:	00f70f63          	beq	a4,a5,80002426 <kill+0x6c>
    8000240c:	8526                	mv	a0,s1
    8000240e:	ffffe097          	auipc	ra,0xffffe
    80002412:	744080e7          	jalr	1860(ra) # 80000b52 <release>
    80002416:	4501                	li	a0,0
    80002418:	70a2                	ld	ra,40(sp)
    8000241a:	7402                	ld	s0,32(sp)
    8000241c:	64e2                	ld	s1,24(sp)
    8000241e:	6942                	ld	s2,16(sp)
    80002420:	69a2                	ld	s3,8(sp)
    80002422:	6145                	addi	sp,sp,48
    80002424:	8082                	ret
    80002426:	4789                	li	a5,2
    80002428:	cc9c                	sw	a5,24(s1)
    8000242a:	b7cd                	j	8000240c <kill+0x52>

000000008000242c <either_copyout>:
    8000242c:	7179                	addi	sp,sp,-48
    8000242e:	f406                	sd	ra,40(sp)
    80002430:	f022                	sd	s0,32(sp)
    80002432:	ec26                	sd	s1,24(sp)
    80002434:	e84a                	sd	s2,16(sp)
    80002436:	e44e                	sd	s3,8(sp)
    80002438:	e052                	sd	s4,0(sp)
    8000243a:	1800                	addi	s0,sp,48
    8000243c:	84aa                	mv	s1,a0
    8000243e:	892e                	mv	s2,a1
    80002440:	89b2                	mv	s3,a2
    80002442:	8a36                	mv	s4,a3
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	5da080e7          	jalr	1498(ra) # 80001a1e <myproc>
    8000244c:	c08d                	beqz	s1,8000246e <either_copyout+0x42>
    8000244e:	86d2                	mv	a3,s4
    80002450:	864e                	mv	a2,s3
    80002452:	85ca                	mv	a1,s2
    80002454:	6928                	ld	a0,80(a0)
    80002456:	fffff097          	auipc	ra,0xfffff
    8000245a:	2a4080e7          	jalr	676(ra) # 800016fa <copyout>
    8000245e:	70a2                	ld	ra,40(sp)
    80002460:	7402                	ld	s0,32(sp)
    80002462:	64e2                	ld	s1,24(sp)
    80002464:	6942                	ld	s2,16(sp)
    80002466:	69a2                	ld	s3,8(sp)
    80002468:	6a02                	ld	s4,0(sp)
    8000246a:	6145                	addi	sp,sp,48
    8000246c:	8082                	ret
    8000246e:	000a061b          	sext.w	a2,s4
    80002472:	85ce                	mv	a1,s3
    80002474:	854a                	mv	a0,s2
    80002476:	ffffe097          	auipc	ra,0xffffe
    8000247a:	790080e7          	jalr	1936(ra) # 80000c06 <memmove>
    8000247e:	8526                	mv	a0,s1
    80002480:	bff9                	j	8000245e <either_copyout+0x32>

0000000080002482 <either_copyin>:
    80002482:	7179                	addi	sp,sp,-48
    80002484:	f406                	sd	ra,40(sp)
    80002486:	f022                	sd	s0,32(sp)
    80002488:	ec26                	sd	s1,24(sp)
    8000248a:	e84a                	sd	s2,16(sp)
    8000248c:	e44e                	sd	s3,8(sp)
    8000248e:	e052                	sd	s4,0(sp)
    80002490:	1800                	addi	s0,sp,48
    80002492:	892a                	mv	s2,a0
    80002494:	84ae                	mv	s1,a1
    80002496:	89b2                	mv	s3,a2
    80002498:	8a36                	mv	s4,a3
    8000249a:	fffff097          	auipc	ra,0xfffff
    8000249e:	584080e7          	jalr	1412(ra) # 80001a1e <myproc>
    800024a2:	c08d                	beqz	s1,800024c4 <either_copyin+0x42>
    800024a4:	86d2                	mv	a3,s4
    800024a6:	864e                	mv	a2,s3
    800024a8:	85ca                	mv	a1,s2
    800024aa:	6928                	ld	a0,80(a0)
    800024ac:	fffff097          	auipc	ra,0xfffff
    800024b0:	2da080e7          	jalr	730(ra) # 80001786 <copyin>
    800024b4:	70a2                	ld	ra,40(sp)
    800024b6:	7402                	ld	s0,32(sp)
    800024b8:	64e2                	ld	s1,24(sp)
    800024ba:	6942                	ld	s2,16(sp)
    800024bc:	69a2                	ld	s3,8(sp)
    800024be:	6a02                	ld	s4,0(sp)
    800024c0:	6145                	addi	sp,sp,48
    800024c2:	8082                	ret
    800024c4:	000a061b          	sext.w	a2,s4
    800024c8:	85ce                	mv	a1,s3
    800024ca:	854a                	mv	a0,s2
    800024cc:	ffffe097          	auipc	ra,0xffffe
    800024d0:	73a080e7          	jalr	1850(ra) # 80000c06 <memmove>
    800024d4:	8526                	mv	a0,s1
    800024d6:	bff9                	j	800024b4 <either_copyin+0x32>

00000000800024d8 <procdump>:
    800024d8:	715d                	addi	sp,sp,-80
    800024da:	e486                	sd	ra,72(sp)
    800024dc:	e0a2                	sd	s0,64(sp)
    800024de:	fc26                	sd	s1,56(sp)
    800024e0:	f84a                	sd	s2,48(sp)
    800024e2:	f44e                	sd	s3,40(sp)
    800024e4:	f052                	sd	s4,32(sp)
    800024e6:	ec56                	sd	s5,24(sp)
    800024e8:	e85a                	sd	s6,16(sp)
    800024ea:	e45e                	sd	s7,8(sp)
    800024ec:	0880                	addi	s0,sp,80
    800024ee:	00005517          	auipc	a0,0x5
    800024f2:	03a50513          	addi	a0,a0,58 # 80007528 <userret+0x498>
    800024f6:	ffffe097          	auipc	ra,0xffffe
    800024fa:	0d2080e7          	jalr	210(ra) # 800005c8 <printf>
    800024fe:	00010497          	auipc	s1,0x10
    80002502:	95a48493          	addi	s1,s1,-1702 # 80011e58 <proc+0x158>
    80002506:	00015917          	auipc	s2,0x15
    8000250a:	35290913          	addi	s2,s2,850 # 80017858 <bcache+0x140>
    8000250e:	4b11                	li	s6,4
    80002510:	00005997          	auipc	s3,0x5
    80002514:	1d098993          	addi	s3,s3,464 # 800076e0 <userret+0x650>
    80002518:	00005a97          	auipc	s5,0x5
    8000251c:	1d0a8a93          	addi	s5,s5,464 # 800076e8 <userret+0x658>
    80002520:	00005a17          	auipc	s4,0x5
    80002524:	008a0a13          	addi	s4,s4,8 # 80007528 <userret+0x498>
    80002528:	00005b97          	auipc	s7,0x5
    8000252c:	678b8b93          	addi	s7,s7,1656 # 80007ba0 <states.1713>
    80002530:	a015                	j	80002554 <procdump+0x7c>
    80002532:	86ba                	mv	a3,a4
    80002534:	ee072583          	lw	a1,-288(a4)
    80002538:	8556                	mv	a0,s5
    8000253a:	ffffe097          	auipc	ra,0xffffe
    8000253e:	08e080e7          	jalr	142(ra) # 800005c8 <printf>
    80002542:	8552                	mv	a0,s4
    80002544:	ffffe097          	auipc	ra,0xffffe
    80002548:	084080e7          	jalr	132(ra) # 800005c8 <printf>
    8000254c:	16848493          	addi	s1,s1,360
    80002550:	03248163          	beq	s1,s2,80002572 <procdump+0x9a>
    80002554:	8726                	mv	a4,s1
    80002556:	ec04a783          	lw	a5,-320(s1)
    8000255a:	dbed                	beqz	a5,8000254c <procdump+0x74>
    8000255c:	864e                	mv	a2,s3
    8000255e:	fcfb6ae3          	bltu	s6,a5,80002532 <procdump+0x5a>
    80002562:	1782                	slli	a5,a5,0x20
    80002564:	9381                	srli	a5,a5,0x20
    80002566:	078e                	slli	a5,a5,0x3
    80002568:	97de                	add	a5,a5,s7
    8000256a:	6390                	ld	a2,0(a5)
    8000256c:	f279                	bnez	a2,80002532 <procdump+0x5a>
    8000256e:	864e                	mv	a2,s3
    80002570:	b7c9                	j	80002532 <procdump+0x5a>
    80002572:	60a6                	ld	ra,72(sp)
    80002574:	6406                	ld	s0,64(sp)
    80002576:	74e2                	ld	s1,56(sp)
    80002578:	7942                	ld	s2,48(sp)
    8000257a:	79a2                	ld	s3,40(sp)
    8000257c:	7a02                	ld	s4,32(sp)
    8000257e:	6ae2                	ld	s5,24(sp)
    80002580:	6b42                	ld	s6,16(sp)
    80002582:	6ba2                	ld	s7,8(sp)
    80002584:	6161                	addi	sp,sp,80
    80002586:	8082                	ret

0000000080002588 <swtch>:
    80002588:	00153023          	sd	ra,0(a0)
    8000258c:	00253423          	sd	sp,8(a0)
    80002590:	e900                	sd	s0,16(a0)
    80002592:	ed04                	sd	s1,24(a0)
    80002594:	03253023          	sd	s2,32(a0)
    80002598:	03353423          	sd	s3,40(a0)
    8000259c:	03453823          	sd	s4,48(a0)
    800025a0:	03553c23          	sd	s5,56(a0)
    800025a4:	05653023          	sd	s6,64(a0)
    800025a8:	05753423          	sd	s7,72(a0)
    800025ac:	05853823          	sd	s8,80(a0)
    800025b0:	05953c23          	sd	s9,88(a0)
    800025b4:	07a53023          	sd	s10,96(a0)
    800025b8:	07b53423          	sd	s11,104(a0)
    800025bc:	0005b083          	ld	ra,0(a1)
    800025c0:	0085b103          	ld	sp,8(a1)
    800025c4:	6980                	ld	s0,16(a1)
    800025c6:	6d84                	ld	s1,24(a1)
    800025c8:	0205b903          	ld	s2,32(a1)
    800025cc:	0285b983          	ld	s3,40(a1)
    800025d0:	0305ba03          	ld	s4,48(a1)
    800025d4:	0385ba83          	ld	s5,56(a1)
    800025d8:	0405bb03          	ld	s6,64(a1)
    800025dc:	0485bb83          	ld	s7,72(a1)
    800025e0:	0505bc03          	ld	s8,80(a1)
    800025e4:	0585bc83          	ld	s9,88(a1)
    800025e8:	0605bd03          	ld	s10,96(a1)
    800025ec:	0685bd83          	ld	s11,104(a1)
    800025f0:	8082                	ret

00000000800025f2 <trapinit>:
    800025f2:	1141                	addi	sp,sp,-16
    800025f4:	e406                	sd	ra,8(sp)
    800025f6:	e022                	sd	s0,0(sp)
    800025f8:	0800                	addi	s0,sp,16
    800025fa:	00005597          	auipc	a1,0x5
    800025fe:	12658593          	addi	a1,a1,294 # 80007720 <userret+0x690>
    80002602:	00015517          	auipc	a0,0x15
    80002606:	0fe50513          	addi	a0,a0,254 # 80017700 <tickslock>
    8000260a:	ffffe097          	auipc	ra,0xffffe
    8000260e:	3e6080e7          	jalr	998(ra) # 800009f0 <initlock>
    80002612:	60a2                	ld	ra,8(sp)
    80002614:	6402                	ld	s0,0(sp)
    80002616:	0141                	addi	sp,sp,16
    80002618:	8082                	ret

000000008000261a <trapinithart>:
    8000261a:	1141                	addi	sp,sp,-16
    8000261c:	e422                	sd	s0,8(sp)
    8000261e:	0800                	addi	s0,sp,16
    80002620:	00003797          	auipc	a5,0x3
    80002624:	53078793          	addi	a5,a5,1328 # 80005b50 <kernelvec>
    80002628:	10579073          	csrw	stvec,a5
    8000262c:	6422                	ld	s0,8(sp)
    8000262e:	0141                	addi	sp,sp,16
    80002630:	8082                	ret

0000000080002632 <usertrapret>:
    80002632:	1141                	addi	sp,sp,-16
    80002634:	e406                	sd	ra,8(sp)
    80002636:	e022                	sd	s0,0(sp)
    80002638:	0800                	addi	s0,sp,16
    8000263a:	fffff097          	auipc	ra,0xfffff
    8000263e:	3e4080e7          	jalr	996(ra) # 80001a1e <myproc>
    80002642:	100027f3          	csrr	a5,sstatus
    80002646:	9bf5                	andi	a5,a5,-3
    80002648:	10079073          	csrw	sstatus,a5
    8000264c:	00005617          	auipc	a2,0x5
    80002650:	9b460613          	addi	a2,a2,-1612 # 80007000 <trampoline>
    80002654:	00005697          	auipc	a3,0x5
    80002658:	9ac68693          	addi	a3,a3,-1620 # 80007000 <trampoline>
    8000265c:	8e91                	sub	a3,a3,a2
    8000265e:	040007b7          	lui	a5,0x4000
    80002662:	17fd                	addi	a5,a5,-1
    80002664:	07b2                	slli	a5,a5,0xc
    80002666:	96be                	add	a3,a3,a5
    80002668:	10569073          	csrw	stvec,a3
    8000266c:	6d38                	ld	a4,88(a0)
    8000266e:	180026f3          	csrr	a3,satp
    80002672:	e314                	sd	a3,0(a4)
    80002674:	6d38                	ld	a4,88(a0)
    80002676:	6134                	ld	a3,64(a0)
    80002678:	6585                	lui	a1,0x1
    8000267a:	96ae                	add	a3,a3,a1
    8000267c:	e714                	sd	a3,8(a4)
    8000267e:	6d38                	ld	a4,88(a0)
    80002680:	00000697          	auipc	a3,0x0
    80002684:	12268693          	addi	a3,a3,290 # 800027a2 <usertrap>
    80002688:	eb14                	sd	a3,16(a4)
    8000268a:	6d38                	ld	a4,88(a0)
    8000268c:	8692                	mv	a3,tp
    8000268e:	f314                	sd	a3,32(a4)
    80002690:	100026f3          	csrr	a3,sstatus
    80002694:	eff6f693          	andi	a3,a3,-257
    80002698:	0206e693          	ori	a3,a3,32
    8000269c:	10069073          	csrw	sstatus,a3
    800026a0:	6d38                	ld	a4,88(a0)
    800026a2:	6f18                	ld	a4,24(a4)
    800026a4:	14171073          	csrw	sepc,a4
    800026a8:	692c                	ld	a1,80(a0)
    800026aa:	81b1                	srli	a1,a1,0xc
    800026ac:	00005717          	auipc	a4,0x5
    800026b0:	9e470713          	addi	a4,a4,-1564 # 80007090 <userret>
    800026b4:	8f11                	sub	a4,a4,a2
    800026b6:	97ba                	add	a5,a5,a4
    800026b8:	577d                	li	a4,-1
    800026ba:	177e                	slli	a4,a4,0x3f
    800026bc:	8dd9                	or	a1,a1,a4
    800026be:	02000537          	lui	a0,0x2000
    800026c2:	157d                	addi	a0,a0,-1
    800026c4:	0536                	slli	a0,a0,0xd
    800026c6:	9782                	jalr	a5
    800026c8:	60a2                	ld	ra,8(sp)
    800026ca:	6402                	ld	s0,0(sp)
    800026cc:	0141                	addi	sp,sp,16
    800026ce:	8082                	ret

00000000800026d0 <clockintr>:
    800026d0:	1101                	addi	sp,sp,-32
    800026d2:	ec06                	sd	ra,24(sp)
    800026d4:	e822                	sd	s0,16(sp)
    800026d6:	e426                	sd	s1,8(sp)
    800026d8:	1000                	addi	s0,sp,32
    800026da:	00015497          	auipc	s1,0x15
    800026de:	02648493          	addi	s1,s1,38 # 80017700 <tickslock>
    800026e2:	8526                	mv	a0,s1
    800026e4:	ffffe097          	auipc	ra,0xffffe
    800026e8:	41a080e7          	jalr	1050(ra) # 80000afe <acquire>
    800026ec:	00024517          	auipc	a0,0x24
    800026f0:	92c50513          	addi	a0,a0,-1748 # 80026018 <ticks>
    800026f4:	411c                	lw	a5,0(a0)
    800026f6:	2785                	addiw	a5,a5,1
    800026f8:	c11c                	sw	a5,0(a0)
    800026fa:	00000097          	auipc	ra,0x0
    800026fe:	c56080e7          	jalr	-938(ra) # 80002350 <wakeup>
    80002702:	8526                	mv	a0,s1
    80002704:	ffffe097          	auipc	ra,0xffffe
    80002708:	44e080e7          	jalr	1102(ra) # 80000b52 <release>
    8000270c:	60e2                	ld	ra,24(sp)
    8000270e:	6442                	ld	s0,16(sp)
    80002710:	64a2                	ld	s1,8(sp)
    80002712:	6105                	addi	sp,sp,32
    80002714:	8082                	ret

0000000080002716 <devintr>:
    80002716:	1101                	addi	sp,sp,-32
    80002718:	ec06                	sd	ra,24(sp)
    8000271a:	e822                	sd	s0,16(sp)
    8000271c:	e426                	sd	s1,8(sp)
    8000271e:	1000                	addi	s0,sp,32
    80002720:	14202773          	csrr	a4,scause
    80002724:	00074d63          	bltz	a4,8000273e <devintr+0x28>
    80002728:	57fd                	li	a5,-1
    8000272a:	17fe                	slli	a5,a5,0x3f
    8000272c:	0785                	addi	a5,a5,1
    8000272e:	4501                	li	a0,0
    80002730:	04f70863          	beq	a4,a5,80002780 <devintr+0x6a>
    80002734:	60e2                	ld	ra,24(sp)
    80002736:	6442                	ld	s0,16(sp)
    80002738:	64a2                	ld	s1,8(sp)
    8000273a:	6105                	addi	sp,sp,32
    8000273c:	8082                	ret
    8000273e:	0ff77793          	andi	a5,a4,255
    80002742:	46a5                	li	a3,9
    80002744:	fed792e3          	bne	a5,a3,80002728 <devintr+0x12>
    80002748:	00003097          	auipc	ra,0x3
    8000274c:	522080e7          	jalr	1314(ra) # 80005c6a <plic_claim>
    80002750:	84aa                	mv	s1,a0
    80002752:	47a9                	li	a5,10
    80002754:	00f50c63          	beq	a0,a5,8000276c <devintr+0x56>
    80002758:	4785                	li	a5,1
    8000275a:	00f50e63          	beq	a0,a5,80002776 <devintr+0x60>
    8000275e:	8526                	mv	a0,s1
    80002760:	00003097          	auipc	ra,0x3
    80002764:	52e080e7          	jalr	1326(ra) # 80005c8e <plic_complete>
    80002768:	4505                	li	a0,1
    8000276a:	b7e9                	j	80002734 <devintr+0x1e>
    8000276c:	ffffe097          	auipc	ra,0xffffe
    80002770:	0f8080e7          	jalr	248(ra) # 80000864 <uartintr>
    80002774:	b7ed                	j	8000275e <devintr+0x48>
    80002776:	00004097          	auipc	ra,0x4
    8000277a:	9c4080e7          	jalr	-1596(ra) # 8000613a <virtio_disk_intr>
    8000277e:	b7c5                	j	8000275e <devintr+0x48>
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	272080e7          	jalr	626(ra) # 800019f2 <cpuid>
    80002788:	c901                	beqz	a0,80002798 <devintr+0x82>
    8000278a:	144027f3          	csrr	a5,sip
    8000278e:	9bf5                	andi	a5,a5,-3
    80002790:	14479073          	csrw	sip,a5
    80002794:	4509                	li	a0,2
    80002796:	bf79                	j	80002734 <devintr+0x1e>
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	f38080e7          	jalr	-200(ra) # 800026d0 <clockintr>
    800027a0:	b7ed                	j	8000278a <devintr+0x74>

00000000800027a2 <usertrap>:
    800027a2:	1101                	addi	sp,sp,-32
    800027a4:	ec06                	sd	ra,24(sp)
    800027a6:	e822                	sd	s0,16(sp)
    800027a8:	e426                	sd	s1,8(sp)
    800027aa:	e04a                	sd	s2,0(sp)
    800027ac:	1000                	addi	s0,sp,32
    800027ae:	100027f3          	csrr	a5,sstatus
    800027b2:	1007f793          	andi	a5,a5,256
    800027b6:	e7bd                	bnez	a5,80002824 <usertrap+0x82>
    800027b8:	00003797          	auipc	a5,0x3
    800027bc:	39878793          	addi	a5,a5,920 # 80005b50 <kernelvec>
    800027c0:	10579073          	csrw	stvec,a5
    800027c4:	fffff097          	auipc	ra,0xfffff
    800027c8:	25a080e7          	jalr	602(ra) # 80001a1e <myproc>
    800027cc:	84aa                	mv	s1,a0
    800027ce:	6d3c                	ld	a5,88(a0)
    800027d0:	14102773          	csrr	a4,sepc
    800027d4:	ef98                	sd	a4,24(a5)
    800027d6:	14202773          	csrr	a4,scause
    800027da:	47a1                	li	a5,8
    800027dc:	06f71263          	bne	a4,a5,80002840 <usertrap+0x9e>
    800027e0:	591c                	lw	a5,48(a0)
    800027e2:	eba9                	bnez	a5,80002834 <usertrap+0x92>
    800027e4:	6cb8                	ld	a4,88(s1)
    800027e6:	6f1c                	ld	a5,24(a4)
    800027e8:	0791                	addi	a5,a5,4
    800027ea:	ef1c                	sd	a5,24(a4)
    800027ec:	104027f3          	csrr	a5,sie
    800027f0:	2227e793          	ori	a5,a5,546
    800027f4:	10479073          	csrw	sie,a5
    800027f8:	100027f3          	csrr	a5,sstatus
    800027fc:	0027e793          	ori	a5,a5,2
    80002800:	10079073          	csrw	sstatus,a5
    80002804:	00000097          	auipc	ra,0x0
    80002808:	2e6080e7          	jalr	742(ra) # 80002aea <syscall>
    8000280c:	589c                	lw	a5,48(s1)
    8000280e:	ebc1                	bnez	a5,8000289e <usertrap+0xfc>
    80002810:	00000097          	auipc	ra,0x0
    80002814:	e22080e7          	jalr	-478(ra) # 80002632 <usertrapret>
    80002818:	60e2                	ld	ra,24(sp)
    8000281a:	6442                	ld	s0,16(sp)
    8000281c:	64a2                	ld	s1,8(sp)
    8000281e:	6902                	ld	s2,0(sp)
    80002820:	6105                	addi	sp,sp,32
    80002822:	8082                	ret
    80002824:	00005517          	auipc	a0,0x5
    80002828:	f0450513          	addi	a0,a0,-252 # 80007728 <userret+0x698>
    8000282c:	ffffe097          	auipc	ra,0xffffe
    80002830:	d52080e7          	jalr	-686(ra) # 8000057e <panic>
    80002834:	557d                	li	a0,-1
    80002836:	00000097          	auipc	ra,0x0
    8000283a:	84c080e7          	jalr	-1972(ra) # 80002082 <exit>
    8000283e:	b75d                	j	800027e4 <usertrap+0x42>
    80002840:	00000097          	auipc	ra,0x0
    80002844:	ed6080e7          	jalr	-298(ra) # 80002716 <devintr>
    80002848:	892a                	mv	s2,a0
    8000284a:	c501                	beqz	a0,80002852 <usertrap+0xb0>
    8000284c:	589c                	lw	a5,48(s1)
    8000284e:	c3a1                	beqz	a5,8000288e <usertrap+0xec>
    80002850:	a815                	j	80002884 <usertrap+0xe2>
    80002852:	142025f3          	csrr	a1,scause
    80002856:	5c90                	lw	a2,56(s1)
    80002858:	00005517          	auipc	a0,0x5
    8000285c:	ef050513          	addi	a0,a0,-272 # 80007748 <userret+0x6b8>
    80002860:	ffffe097          	auipc	ra,0xffffe
    80002864:	d68080e7          	jalr	-664(ra) # 800005c8 <printf>
    80002868:	141025f3          	csrr	a1,sepc
    8000286c:	14302673          	csrr	a2,stval
    80002870:	00005517          	auipc	a0,0x5
    80002874:	f0850513          	addi	a0,a0,-248 # 80007778 <userret+0x6e8>
    80002878:	ffffe097          	auipc	ra,0xffffe
    8000287c:	d50080e7          	jalr	-688(ra) # 800005c8 <printf>
    80002880:	4785                	li	a5,1
    80002882:	d89c                	sw	a5,48(s1)
    80002884:	557d                	li	a0,-1
    80002886:	fffff097          	auipc	ra,0xfffff
    8000288a:	7fc080e7          	jalr	2044(ra) # 80002082 <exit>
    8000288e:	4789                	li	a5,2
    80002890:	f8f910e3          	bne	s2,a5,80002810 <usertrap+0x6e>
    80002894:	00000097          	auipc	ra,0x0
    80002898:	8fa080e7          	jalr	-1798(ra) # 8000218e <yield>
    8000289c:	bf95                	j	80002810 <usertrap+0x6e>
    8000289e:	4901                	li	s2,0
    800028a0:	b7d5                	j	80002884 <usertrap+0xe2>

00000000800028a2 <kerneltrap>:
    800028a2:	7179                	addi	sp,sp,-48
    800028a4:	f406                	sd	ra,40(sp)
    800028a6:	f022                	sd	s0,32(sp)
    800028a8:	ec26                	sd	s1,24(sp)
    800028aa:	e84a                	sd	s2,16(sp)
    800028ac:	e44e                	sd	s3,8(sp)
    800028ae:	1800                	addi	s0,sp,48
    800028b0:	14102973          	csrr	s2,sepc
    800028b4:	100024f3          	csrr	s1,sstatus
    800028b8:	142029f3          	csrr	s3,scause
    800028bc:	1004f793          	andi	a5,s1,256
    800028c0:	cb85                	beqz	a5,800028f0 <kerneltrap+0x4e>
    800028c2:	100027f3          	csrr	a5,sstatus
    800028c6:	8b89                	andi	a5,a5,2
    800028c8:	ef85                	bnez	a5,80002900 <kerneltrap+0x5e>
    800028ca:	00000097          	auipc	ra,0x0
    800028ce:	e4c080e7          	jalr	-436(ra) # 80002716 <devintr>
    800028d2:	cd1d                	beqz	a0,80002910 <kerneltrap+0x6e>
    800028d4:	4789                	li	a5,2
    800028d6:	06f50a63          	beq	a0,a5,8000294a <kerneltrap+0xa8>
    800028da:	14191073          	csrw	sepc,s2
    800028de:	10049073          	csrw	sstatus,s1
    800028e2:	70a2                	ld	ra,40(sp)
    800028e4:	7402                	ld	s0,32(sp)
    800028e6:	64e2                	ld	s1,24(sp)
    800028e8:	6942                	ld	s2,16(sp)
    800028ea:	69a2                	ld	s3,8(sp)
    800028ec:	6145                	addi	sp,sp,48
    800028ee:	8082                	ret
    800028f0:	00005517          	auipc	a0,0x5
    800028f4:	ea850513          	addi	a0,a0,-344 # 80007798 <userret+0x708>
    800028f8:	ffffe097          	auipc	ra,0xffffe
    800028fc:	c86080e7          	jalr	-890(ra) # 8000057e <panic>
    80002900:	00005517          	auipc	a0,0x5
    80002904:	ec050513          	addi	a0,a0,-320 # 800077c0 <userret+0x730>
    80002908:	ffffe097          	auipc	ra,0xffffe
    8000290c:	c76080e7          	jalr	-906(ra) # 8000057e <panic>
    80002910:	85ce                	mv	a1,s3
    80002912:	00005517          	auipc	a0,0x5
    80002916:	ece50513          	addi	a0,a0,-306 # 800077e0 <userret+0x750>
    8000291a:	ffffe097          	auipc	ra,0xffffe
    8000291e:	cae080e7          	jalr	-850(ra) # 800005c8 <printf>
    80002922:	141025f3          	csrr	a1,sepc
    80002926:	14302673          	csrr	a2,stval
    8000292a:	00005517          	auipc	a0,0x5
    8000292e:	ec650513          	addi	a0,a0,-314 # 800077f0 <userret+0x760>
    80002932:	ffffe097          	auipc	ra,0xffffe
    80002936:	c96080e7          	jalr	-874(ra) # 800005c8 <printf>
    8000293a:	00005517          	auipc	a0,0x5
    8000293e:	ece50513          	addi	a0,a0,-306 # 80007808 <userret+0x778>
    80002942:	ffffe097          	auipc	ra,0xffffe
    80002946:	c3c080e7          	jalr	-964(ra) # 8000057e <panic>
    8000294a:	fffff097          	auipc	ra,0xfffff
    8000294e:	0d4080e7          	jalr	212(ra) # 80001a1e <myproc>
    80002952:	d541                	beqz	a0,800028da <kerneltrap+0x38>
    80002954:	fffff097          	auipc	ra,0xfffff
    80002958:	0ca080e7          	jalr	202(ra) # 80001a1e <myproc>
    8000295c:	4d18                	lw	a4,24(a0)
    8000295e:	478d                	li	a5,3
    80002960:	f6f71de3          	bne	a4,a5,800028da <kerneltrap+0x38>
    80002964:	00000097          	auipc	ra,0x0
    80002968:	82a080e7          	jalr	-2006(ra) # 8000218e <yield>
    8000296c:	b7bd                	j	800028da <kerneltrap+0x38>

000000008000296e <argraw>:
    8000296e:	1101                	addi	sp,sp,-32
    80002970:	ec06                	sd	ra,24(sp)
    80002972:	e822                	sd	s0,16(sp)
    80002974:	e426                	sd	s1,8(sp)
    80002976:	1000                	addi	s0,sp,32
    80002978:	84aa                	mv	s1,a0
    8000297a:	fffff097          	auipc	ra,0xfffff
    8000297e:	0a4080e7          	jalr	164(ra) # 80001a1e <myproc>
    80002982:	4795                	li	a5,5
    80002984:	0497e363          	bltu	a5,s1,800029ca <argraw+0x5c>
    80002988:	1482                	slli	s1,s1,0x20
    8000298a:	9081                	srli	s1,s1,0x20
    8000298c:	048a                	slli	s1,s1,0x2
    8000298e:	00005717          	auipc	a4,0x5
    80002992:	23a70713          	addi	a4,a4,570 # 80007bc8 <states.1713+0x28>
    80002996:	94ba                	add	s1,s1,a4
    80002998:	409c                	lw	a5,0(s1)
    8000299a:	97ba                	add	a5,a5,a4
    8000299c:	8782                	jr	a5
    8000299e:	6d3c                	ld	a5,88(a0)
    800029a0:	7ba8                	ld	a0,112(a5)
    800029a2:	60e2                	ld	ra,24(sp)
    800029a4:	6442                	ld	s0,16(sp)
    800029a6:	64a2                	ld	s1,8(sp)
    800029a8:	6105                	addi	sp,sp,32
    800029aa:	8082                	ret
    800029ac:	6d3c                	ld	a5,88(a0)
    800029ae:	7fa8                	ld	a0,120(a5)
    800029b0:	bfcd                	j	800029a2 <argraw+0x34>
    800029b2:	6d3c                	ld	a5,88(a0)
    800029b4:	63c8                	ld	a0,128(a5)
    800029b6:	b7f5                	j	800029a2 <argraw+0x34>
    800029b8:	6d3c                	ld	a5,88(a0)
    800029ba:	67c8                	ld	a0,136(a5)
    800029bc:	b7dd                	j	800029a2 <argraw+0x34>
    800029be:	6d3c                	ld	a5,88(a0)
    800029c0:	6bc8                	ld	a0,144(a5)
    800029c2:	b7c5                	j	800029a2 <argraw+0x34>
    800029c4:	6d3c                	ld	a5,88(a0)
    800029c6:	6fc8                	ld	a0,152(a5)
    800029c8:	bfe9                	j	800029a2 <argraw+0x34>
    800029ca:	00005517          	auipc	a0,0x5
    800029ce:	e4e50513          	addi	a0,a0,-434 # 80007818 <userret+0x788>
    800029d2:	ffffe097          	auipc	ra,0xffffe
    800029d6:	bac080e7          	jalr	-1108(ra) # 8000057e <panic>

00000000800029da <fetchaddr>:
    800029da:	1101                	addi	sp,sp,-32
    800029dc:	ec06                	sd	ra,24(sp)
    800029de:	e822                	sd	s0,16(sp)
    800029e0:	e426                	sd	s1,8(sp)
    800029e2:	e04a                	sd	s2,0(sp)
    800029e4:	1000                	addi	s0,sp,32
    800029e6:	84aa                	mv	s1,a0
    800029e8:	892e                	mv	s2,a1
    800029ea:	fffff097          	auipc	ra,0xfffff
    800029ee:	034080e7          	jalr	52(ra) # 80001a1e <myproc>
    800029f2:	653c                	ld	a5,72(a0)
    800029f4:	02f4f963          	bleu	a5,s1,80002a26 <fetchaddr+0x4c>
    800029f8:	00848713          	addi	a4,s1,8
    800029fc:	02e7e763          	bltu	a5,a4,80002a2a <fetchaddr+0x50>
    80002a00:	46a1                	li	a3,8
    80002a02:	8626                	mv	a2,s1
    80002a04:	85ca                	mv	a1,s2
    80002a06:	6928                	ld	a0,80(a0)
    80002a08:	fffff097          	auipc	ra,0xfffff
    80002a0c:	d7e080e7          	jalr	-642(ra) # 80001786 <copyin>
    80002a10:	00a03533          	snez	a0,a0
    80002a14:	40a0053b          	negw	a0,a0
    80002a18:	2501                	sext.w	a0,a0
    80002a1a:	60e2                	ld	ra,24(sp)
    80002a1c:	6442                	ld	s0,16(sp)
    80002a1e:	64a2                	ld	s1,8(sp)
    80002a20:	6902                	ld	s2,0(sp)
    80002a22:	6105                	addi	sp,sp,32
    80002a24:	8082                	ret
    80002a26:	557d                	li	a0,-1
    80002a28:	bfcd                	j	80002a1a <fetchaddr+0x40>
    80002a2a:	557d                	li	a0,-1
    80002a2c:	b7fd                	j	80002a1a <fetchaddr+0x40>

0000000080002a2e <fetchstr>:
    80002a2e:	7179                	addi	sp,sp,-48
    80002a30:	f406                	sd	ra,40(sp)
    80002a32:	f022                	sd	s0,32(sp)
    80002a34:	ec26                	sd	s1,24(sp)
    80002a36:	e84a                	sd	s2,16(sp)
    80002a38:	e44e                	sd	s3,8(sp)
    80002a3a:	1800                	addi	s0,sp,48
    80002a3c:	892a                	mv	s2,a0
    80002a3e:	84ae                	mv	s1,a1
    80002a40:	89b2                	mv	s3,a2
    80002a42:	fffff097          	auipc	ra,0xfffff
    80002a46:	fdc080e7          	jalr	-36(ra) # 80001a1e <myproc>
    80002a4a:	86ce                	mv	a3,s3
    80002a4c:	864a                	mv	a2,s2
    80002a4e:	85a6                	mv	a1,s1
    80002a50:	6928                	ld	a0,80(a0)
    80002a52:	fffff097          	auipc	ra,0xfffff
    80002a56:	dc2080e7          	jalr	-574(ra) # 80001814 <copyinstr>
    80002a5a:	00054763          	bltz	a0,80002a68 <fetchstr+0x3a>
    80002a5e:	8526                	mv	a0,s1
    80002a60:	ffffe097          	auipc	ra,0xffffe
    80002a64:	2e4080e7          	jalr	740(ra) # 80000d44 <strlen>
    80002a68:	70a2                	ld	ra,40(sp)
    80002a6a:	7402                	ld	s0,32(sp)
    80002a6c:	64e2                	ld	s1,24(sp)
    80002a6e:	6942                	ld	s2,16(sp)
    80002a70:	69a2                	ld	s3,8(sp)
    80002a72:	6145                	addi	sp,sp,48
    80002a74:	8082                	ret

0000000080002a76 <argint>:
    80002a76:	1101                	addi	sp,sp,-32
    80002a78:	ec06                	sd	ra,24(sp)
    80002a7a:	e822                	sd	s0,16(sp)
    80002a7c:	e426                	sd	s1,8(sp)
    80002a7e:	1000                	addi	s0,sp,32
    80002a80:	84ae                	mv	s1,a1
    80002a82:	00000097          	auipc	ra,0x0
    80002a86:	eec080e7          	jalr	-276(ra) # 8000296e <argraw>
    80002a8a:	c088                	sw	a0,0(s1)
    80002a8c:	4501                	li	a0,0
    80002a8e:	60e2                	ld	ra,24(sp)
    80002a90:	6442                	ld	s0,16(sp)
    80002a92:	64a2                	ld	s1,8(sp)
    80002a94:	6105                	addi	sp,sp,32
    80002a96:	8082                	ret

0000000080002a98 <argaddr>:
    80002a98:	1101                	addi	sp,sp,-32
    80002a9a:	ec06                	sd	ra,24(sp)
    80002a9c:	e822                	sd	s0,16(sp)
    80002a9e:	e426                	sd	s1,8(sp)
    80002aa0:	1000                	addi	s0,sp,32
    80002aa2:	84ae                	mv	s1,a1
    80002aa4:	00000097          	auipc	ra,0x0
    80002aa8:	eca080e7          	jalr	-310(ra) # 8000296e <argraw>
    80002aac:	e088                	sd	a0,0(s1)
    80002aae:	4501                	li	a0,0
    80002ab0:	60e2                	ld	ra,24(sp)
    80002ab2:	6442                	ld	s0,16(sp)
    80002ab4:	64a2                	ld	s1,8(sp)
    80002ab6:	6105                	addi	sp,sp,32
    80002ab8:	8082                	ret

0000000080002aba <argstr>:
    80002aba:	1101                	addi	sp,sp,-32
    80002abc:	ec06                	sd	ra,24(sp)
    80002abe:	e822                	sd	s0,16(sp)
    80002ac0:	e426                	sd	s1,8(sp)
    80002ac2:	e04a                	sd	s2,0(sp)
    80002ac4:	1000                	addi	s0,sp,32
    80002ac6:	84ae                	mv	s1,a1
    80002ac8:	8932                	mv	s2,a2
    80002aca:	00000097          	auipc	ra,0x0
    80002ace:	ea4080e7          	jalr	-348(ra) # 8000296e <argraw>
    80002ad2:	864a                	mv	a2,s2
    80002ad4:	85a6                	mv	a1,s1
    80002ad6:	00000097          	auipc	ra,0x0
    80002ada:	f58080e7          	jalr	-168(ra) # 80002a2e <fetchstr>
    80002ade:	60e2                	ld	ra,24(sp)
    80002ae0:	6442                	ld	s0,16(sp)
    80002ae2:	64a2                	ld	s1,8(sp)
    80002ae4:	6902                	ld	s2,0(sp)
    80002ae6:	6105                	addi	sp,sp,32
    80002ae8:	8082                	ret

0000000080002aea <syscall>:
    80002aea:	1101                	addi	sp,sp,-32
    80002aec:	ec06                	sd	ra,24(sp)
    80002aee:	e822                	sd	s0,16(sp)
    80002af0:	e426                	sd	s1,8(sp)
    80002af2:	e04a                	sd	s2,0(sp)
    80002af4:	1000                	addi	s0,sp,32
    80002af6:	fffff097          	auipc	ra,0xfffff
    80002afa:	f28080e7          	jalr	-216(ra) # 80001a1e <myproc>
    80002afe:	84aa                	mv	s1,a0
    80002b00:	05853903          	ld	s2,88(a0)
    80002b04:	0a893783          	ld	a5,168(s2)
    80002b08:	0007869b          	sext.w	a3,a5
    80002b0c:	37fd                	addiw	a5,a5,-1
    80002b0e:	4751                	li	a4,20
    80002b10:	00f76f63          	bltu	a4,a5,80002b2e <syscall+0x44>
    80002b14:	00369713          	slli	a4,a3,0x3
    80002b18:	00005797          	auipc	a5,0x5
    80002b1c:	0c878793          	addi	a5,a5,200 # 80007be0 <syscalls>
    80002b20:	97ba                	add	a5,a5,a4
    80002b22:	639c                	ld	a5,0(a5)
    80002b24:	c789                	beqz	a5,80002b2e <syscall+0x44>
    80002b26:	9782                	jalr	a5
    80002b28:	06a93823          	sd	a0,112(s2)
    80002b2c:	a839                	j	80002b4a <syscall+0x60>
    80002b2e:	15848613          	addi	a2,s1,344
    80002b32:	5c8c                	lw	a1,56(s1)
    80002b34:	00005517          	auipc	a0,0x5
    80002b38:	cec50513          	addi	a0,a0,-788 # 80007820 <userret+0x790>
    80002b3c:	ffffe097          	auipc	ra,0xffffe
    80002b40:	a8c080e7          	jalr	-1396(ra) # 800005c8 <printf>
    80002b44:	6cbc                	ld	a5,88(s1)
    80002b46:	577d                	li	a4,-1
    80002b48:	fbb8                	sd	a4,112(a5)
    80002b4a:	60e2                	ld	ra,24(sp)
    80002b4c:	6442                	ld	s0,16(sp)
    80002b4e:	64a2                	ld	s1,8(sp)
    80002b50:	6902                	ld	s2,0(sp)
    80002b52:	6105                	addi	sp,sp,32
    80002b54:	8082                	ret

0000000080002b56 <sys_exit>:
    80002b56:	1101                	addi	sp,sp,-32
    80002b58:	ec06                	sd	ra,24(sp)
    80002b5a:	e822                	sd	s0,16(sp)
    80002b5c:	1000                	addi	s0,sp,32
    80002b5e:	fec40593          	addi	a1,s0,-20
    80002b62:	4501                	li	a0,0
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	f12080e7          	jalr	-238(ra) # 80002a76 <argint>
    80002b6c:	57fd                	li	a5,-1
    80002b6e:	00054963          	bltz	a0,80002b80 <sys_exit+0x2a>
    80002b72:	fec42503          	lw	a0,-20(s0)
    80002b76:	fffff097          	auipc	ra,0xfffff
    80002b7a:	50c080e7          	jalr	1292(ra) # 80002082 <exit>
    80002b7e:	4781                	li	a5,0
    80002b80:	853e                	mv	a0,a5
    80002b82:	60e2                	ld	ra,24(sp)
    80002b84:	6442                	ld	s0,16(sp)
    80002b86:	6105                	addi	sp,sp,32
    80002b88:	8082                	ret

0000000080002b8a <sys_getpid>:
    80002b8a:	1141                	addi	sp,sp,-16
    80002b8c:	e406                	sd	ra,8(sp)
    80002b8e:	e022                	sd	s0,0(sp)
    80002b90:	0800                	addi	s0,sp,16
    80002b92:	fffff097          	auipc	ra,0xfffff
    80002b96:	e8c080e7          	jalr	-372(ra) # 80001a1e <myproc>
    80002b9a:	5d08                	lw	a0,56(a0)
    80002b9c:	60a2                	ld	ra,8(sp)
    80002b9e:	6402                	ld	s0,0(sp)
    80002ba0:	0141                	addi	sp,sp,16
    80002ba2:	8082                	ret

0000000080002ba4 <sys_fork>:
    80002ba4:	1141                	addi	sp,sp,-16
    80002ba6:	e406                	sd	ra,8(sp)
    80002ba8:	e022                	sd	s0,0(sp)
    80002baa:	0800                	addi	s0,sp,16
    80002bac:	fffff097          	auipc	ra,0xfffff
    80002bb0:	1e2080e7          	jalr	482(ra) # 80001d8e <fork>
    80002bb4:	60a2                	ld	ra,8(sp)
    80002bb6:	6402                	ld	s0,0(sp)
    80002bb8:	0141                	addi	sp,sp,16
    80002bba:	8082                	ret

0000000080002bbc <sys_wait>:
    80002bbc:	1101                	addi	sp,sp,-32
    80002bbe:	ec06                	sd	ra,24(sp)
    80002bc0:	e822                	sd	s0,16(sp)
    80002bc2:	1000                	addi	s0,sp,32
    80002bc4:	fe840593          	addi	a1,s0,-24
    80002bc8:	4501                	li	a0,0
    80002bca:	00000097          	auipc	ra,0x0
    80002bce:	ece080e7          	jalr	-306(ra) # 80002a98 <argaddr>
    80002bd2:	57fd                	li	a5,-1
    80002bd4:	00054963          	bltz	a0,80002be6 <sys_wait+0x2a>
    80002bd8:	fe843503          	ld	a0,-24(s0)
    80002bdc:	fffff097          	auipc	ra,0xfffff
    80002be0:	66c080e7          	jalr	1644(ra) # 80002248 <wait>
    80002be4:	87aa                	mv	a5,a0
    80002be6:	853e                	mv	a0,a5
    80002be8:	60e2                	ld	ra,24(sp)
    80002bea:	6442                	ld	s0,16(sp)
    80002bec:	6105                	addi	sp,sp,32
    80002bee:	8082                	ret

0000000080002bf0 <sys_sbrk>:
    80002bf0:	7179                	addi	sp,sp,-48
    80002bf2:	f406                	sd	ra,40(sp)
    80002bf4:	f022                	sd	s0,32(sp)
    80002bf6:	ec26                	sd	s1,24(sp)
    80002bf8:	1800                	addi	s0,sp,48
    80002bfa:	fdc40593          	addi	a1,s0,-36
    80002bfe:	4501                	li	a0,0
    80002c00:	00000097          	auipc	ra,0x0
    80002c04:	e76080e7          	jalr	-394(ra) # 80002a76 <argint>
    80002c08:	54fd                	li	s1,-1
    80002c0a:	00054f63          	bltz	a0,80002c28 <sys_sbrk+0x38>
    80002c0e:	fffff097          	auipc	ra,0xfffff
    80002c12:	e10080e7          	jalr	-496(ra) # 80001a1e <myproc>
    80002c16:	4524                	lw	s1,72(a0)
    80002c18:	fdc42503          	lw	a0,-36(s0)
    80002c1c:	fffff097          	auipc	ra,0xfffff
    80002c20:	0fa080e7          	jalr	250(ra) # 80001d16 <growproc>
    80002c24:	00054863          	bltz	a0,80002c34 <sys_sbrk+0x44>
    80002c28:	8526                	mv	a0,s1
    80002c2a:	70a2                	ld	ra,40(sp)
    80002c2c:	7402                	ld	s0,32(sp)
    80002c2e:	64e2                	ld	s1,24(sp)
    80002c30:	6145                	addi	sp,sp,48
    80002c32:	8082                	ret
    80002c34:	54fd                	li	s1,-1
    80002c36:	bfcd                	j	80002c28 <sys_sbrk+0x38>

0000000080002c38 <sys_sleep>:
    80002c38:	7139                	addi	sp,sp,-64
    80002c3a:	fc06                	sd	ra,56(sp)
    80002c3c:	f822                	sd	s0,48(sp)
    80002c3e:	f426                	sd	s1,40(sp)
    80002c40:	f04a                	sd	s2,32(sp)
    80002c42:	ec4e                	sd	s3,24(sp)
    80002c44:	0080                	addi	s0,sp,64
    80002c46:	fcc40593          	addi	a1,s0,-52
    80002c4a:	4501                	li	a0,0
    80002c4c:	00000097          	auipc	ra,0x0
    80002c50:	e2a080e7          	jalr	-470(ra) # 80002a76 <argint>
    80002c54:	57fd                	li	a5,-1
    80002c56:	06054763          	bltz	a0,80002cc4 <sys_sleep+0x8c>
    80002c5a:	00015517          	auipc	a0,0x15
    80002c5e:	aa650513          	addi	a0,a0,-1370 # 80017700 <tickslock>
    80002c62:	ffffe097          	auipc	ra,0xffffe
    80002c66:	e9c080e7          	jalr	-356(ra) # 80000afe <acquire>
    80002c6a:	00023797          	auipc	a5,0x23
    80002c6e:	3ae78793          	addi	a5,a5,942 # 80026018 <ticks>
    80002c72:	0007a903          	lw	s2,0(a5)
    80002c76:	fcc42783          	lw	a5,-52(s0)
    80002c7a:	cf85                	beqz	a5,80002cb2 <sys_sleep+0x7a>
    80002c7c:	00015997          	auipc	s3,0x15
    80002c80:	a8498993          	addi	s3,s3,-1404 # 80017700 <tickslock>
    80002c84:	00023497          	auipc	s1,0x23
    80002c88:	39448493          	addi	s1,s1,916 # 80026018 <ticks>
    80002c8c:	fffff097          	auipc	ra,0xfffff
    80002c90:	d92080e7          	jalr	-622(ra) # 80001a1e <myproc>
    80002c94:	591c                	lw	a5,48(a0)
    80002c96:	ef9d                	bnez	a5,80002cd4 <sys_sleep+0x9c>
    80002c98:	85ce                	mv	a1,s3
    80002c9a:	8526                	mv	a0,s1
    80002c9c:	fffff097          	auipc	ra,0xfffff
    80002ca0:	52e080e7          	jalr	1326(ra) # 800021ca <sleep>
    80002ca4:	409c                	lw	a5,0(s1)
    80002ca6:	412787bb          	subw	a5,a5,s2
    80002caa:	fcc42703          	lw	a4,-52(s0)
    80002cae:	fce7efe3          	bltu	a5,a4,80002c8c <sys_sleep+0x54>
    80002cb2:	00015517          	auipc	a0,0x15
    80002cb6:	a4e50513          	addi	a0,a0,-1458 # 80017700 <tickslock>
    80002cba:	ffffe097          	auipc	ra,0xffffe
    80002cbe:	e98080e7          	jalr	-360(ra) # 80000b52 <release>
    80002cc2:	4781                	li	a5,0
    80002cc4:	853e                	mv	a0,a5
    80002cc6:	70e2                	ld	ra,56(sp)
    80002cc8:	7442                	ld	s0,48(sp)
    80002cca:	74a2                	ld	s1,40(sp)
    80002ccc:	7902                	ld	s2,32(sp)
    80002cce:	69e2                	ld	s3,24(sp)
    80002cd0:	6121                	addi	sp,sp,64
    80002cd2:	8082                	ret
    80002cd4:	00015517          	auipc	a0,0x15
    80002cd8:	a2c50513          	addi	a0,a0,-1492 # 80017700 <tickslock>
    80002cdc:	ffffe097          	auipc	ra,0xffffe
    80002ce0:	e76080e7          	jalr	-394(ra) # 80000b52 <release>
    80002ce4:	57fd                	li	a5,-1
    80002ce6:	bff9                	j	80002cc4 <sys_sleep+0x8c>

0000000080002ce8 <sys_kill>:
    80002ce8:	1101                	addi	sp,sp,-32
    80002cea:	ec06                	sd	ra,24(sp)
    80002cec:	e822                	sd	s0,16(sp)
    80002cee:	1000                	addi	s0,sp,32
    80002cf0:	fec40593          	addi	a1,s0,-20
    80002cf4:	4501                	li	a0,0
    80002cf6:	00000097          	auipc	ra,0x0
    80002cfa:	d80080e7          	jalr	-640(ra) # 80002a76 <argint>
    80002cfe:	57fd                	li	a5,-1
    80002d00:	00054963          	bltz	a0,80002d12 <sys_kill+0x2a>
    80002d04:	fec42503          	lw	a0,-20(s0)
    80002d08:	fffff097          	auipc	ra,0xfffff
    80002d0c:	6b2080e7          	jalr	1714(ra) # 800023ba <kill>
    80002d10:	87aa                	mv	a5,a0
    80002d12:	853e                	mv	a0,a5
    80002d14:	60e2                	ld	ra,24(sp)
    80002d16:	6442                	ld	s0,16(sp)
    80002d18:	6105                	addi	sp,sp,32
    80002d1a:	8082                	ret

0000000080002d1c <sys_uptime>:
    80002d1c:	1101                	addi	sp,sp,-32
    80002d1e:	ec06                	sd	ra,24(sp)
    80002d20:	e822                	sd	s0,16(sp)
    80002d22:	e426                	sd	s1,8(sp)
    80002d24:	1000                	addi	s0,sp,32
    80002d26:	00015517          	auipc	a0,0x15
    80002d2a:	9da50513          	addi	a0,a0,-1574 # 80017700 <tickslock>
    80002d2e:	ffffe097          	auipc	ra,0xffffe
    80002d32:	dd0080e7          	jalr	-560(ra) # 80000afe <acquire>
    80002d36:	00023797          	auipc	a5,0x23
    80002d3a:	2e278793          	addi	a5,a5,738 # 80026018 <ticks>
    80002d3e:	4384                	lw	s1,0(a5)
    80002d40:	00015517          	auipc	a0,0x15
    80002d44:	9c050513          	addi	a0,a0,-1600 # 80017700 <tickslock>
    80002d48:	ffffe097          	auipc	ra,0xffffe
    80002d4c:	e0a080e7          	jalr	-502(ra) # 80000b52 <release>
    80002d50:	02049513          	slli	a0,s1,0x20
    80002d54:	9101                	srli	a0,a0,0x20
    80002d56:	60e2                	ld	ra,24(sp)
    80002d58:	6442                	ld	s0,16(sp)
    80002d5a:	64a2                	ld	s1,8(sp)
    80002d5c:	6105                	addi	sp,sp,32
    80002d5e:	8082                	ret

0000000080002d60 <binit>:
    80002d60:	7179                	addi	sp,sp,-48
    80002d62:	f406                	sd	ra,40(sp)
    80002d64:	f022                	sd	s0,32(sp)
    80002d66:	ec26                	sd	s1,24(sp)
    80002d68:	e84a                	sd	s2,16(sp)
    80002d6a:	e44e                	sd	s3,8(sp)
    80002d6c:	e052                	sd	s4,0(sp)
    80002d6e:	1800                	addi	s0,sp,48
    80002d70:	00005597          	auipc	a1,0x5
    80002d74:	ad058593          	addi	a1,a1,-1328 # 80007840 <userret+0x7b0>
    80002d78:	00015517          	auipc	a0,0x15
    80002d7c:	9a050513          	addi	a0,a0,-1632 # 80017718 <bcache>
    80002d80:	ffffe097          	auipc	ra,0xffffe
    80002d84:	c70080e7          	jalr	-912(ra) # 800009f0 <initlock>
    80002d88:	0001d797          	auipc	a5,0x1d
    80002d8c:	99078793          	addi	a5,a5,-1648 # 8001f718 <bcache+0x8000>
    80002d90:	0001d717          	auipc	a4,0x1d
    80002d94:	ce070713          	addi	a4,a4,-800 # 8001fa70 <bcache+0x8358>
    80002d98:	3ae7b023          	sd	a4,928(a5)
    80002d9c:	3ae7b423          	sd	a4,936(a5)
    80002da0:	00015497          	auipc	s1,0x15
    80002da4:	99048493          	addi	s1,s1,-1648 # 80017730 <bcache+0x18>
    80002da8:	893e                	mv	s2,a5
    80002daa:	89ba                	mv	s3,a4
    80002dac:	00005a17          	auipc	s4,0x5
    80002db0:	a9ca0a13          	addi	s4,s4,-1380 # 80007848 <userret+0x7b8>
    80002db4:	3a893783          	ld	a5,936(s2)
    80002db8:	e8bc                	sd	a5,80(s1)
    80002dba:	0534b423          	sd	s3,72(s1)
    80002dbe:	85d2                	mv	a1,s4
    80002dc0:	01048513          	addi	a0,s1,16
    80002dc4:	00001097          	auipc	ra,0x1
    80002dc8:	4f4080e7          	jalr	1268(ra) # 800042b8 <initsleeplock>
    80002dcc:	3a893783          	ld	a5,936(s2)
    80002dd0:	e7a4                	sd	s1,72(a5)
    80002dd2:	3a993423          	sd	s1,936(s2)
    80002dd6:	46048493          	addi	s1,s1,1120
    80002dda:	fd349de3          	bne	s1,s3,80002db4 <binit+0x54>
    80002dde:	70a2                	ld	ra,40(sp)
    80002de0:	7402                	ld	s0,32(sp)
    80002de2:	64e2                	ld	s1,24(sp)
    80002de4:	6942                	ld	s2,16(sp)
    80002de6:	69a2                	ld	s3,8(sp)
    80002de8:	6a02                	ld	s4,0(sp)
    80002dea:	6145                	addi	sp,sp,48
    80002dec:	8082                	ret

0000000080002dee <bread>:
    80002dee:	7179                	addi	sp,sp,-48
    80002df0:	f406                	sd	ra,40(sp)
    80002df2:	f022                	sd	s0,32(sp)
    80002df4:	ec26                	sd	s1,24(sp)
    80002df6:	e84a                	sd	s2,16(sp)
    80002df8:	e44e                	sd	s3,8(sp)
    80002dfa:	1800                	addi	s0,sp,48
    80002dfc:	89aa                	mv	s3,a0
    80002dfe:	892e                	mv	s2,a1
    80002e00:	00015517          	auipc	a0,0x15
    80002e04:	91850513          	addi	a0,a0,-1768 # 80017718 <bcache>
    80002e08:	ffffe097          	auipc	ra,0xffffe
    80002e0c:	cf6080e7          	jalr	-778(ra) # 80000afe <acquire>
    80002e10:	0001d797          	auipc	a5,0x1d
    80002e14:	90878793          	addi	a5,a5,-1784 # 8001f718 <bcache+0x8000>
    80002e18:	3a87b483          	ld	s1,936(a5)
    80002e1c:	0001d797          	auipc	a5,0x1d
    80002e20:	c5478793          	addi	a5,a5,-940 # 8001fa70 <bcache+0x8358>
    80002e24:	02f48f63          	beq	s1,a5,80002e62 <bread+0x74>
    80002e28:	873e                	mv	a4,a5
    80002e2a:	a021                	j	80002e32 <bread+0x44>
    80002e2c:	68a4                	ld	s1,80(s1)
    80002e2e:	02e48a63          	beq	s1,a4,80002e62 <bread+0x74>
    80002e32:	449c                	lw	a5,8(s1)
    80002e34:	ff379ce3          	bne	a5,s3,80002e2c <bread+0x3e>
    80002e38:	44dc                	lw	a5,12(s1)
    80002e3a:	ff2799e3          	bne	a5,s2,80002e2c <bread+0x3e>
    80002e3e:	40bc                	lw	a5,64(s1)
    80002e40:	2785                	addiw	a5,a5,1
    80002e42:	c0bc                	sw	a5,64(s1)
    80002e44:	00015517          	auipc	a0,0x15
    80002e48:	8d450513          	addi	a0,a0,-1836 # 80017718 <bcache>
    80002e4c:	ffffe097          	auipc	ra,0xffffe
    80002e50:	d06080e7          	jalr	-762(ra) # 80000b52 <release>
    80002e54:	01048513          	addi	a0,s1,16
    80002e58:	00001097          	auipc	ra,0x1
    80002e5c:	49a080e7          	jalr	1178(ra) # 800042f2 <acquiresleep>
    80002e60:	a8b1                	j	80002ebc <bread+0xce>
    80002e62:	0001d797          	auipc	a5,0x1d
    80002e66:	8b678793          	addi	a5,a5,-1866 # 8001f718 <bcache+0x8000>
    80002e6a:	3a07b483          	ld	s1,928(a5)
    80002e6e:	0001d797          	auipc	a5,0x1d
    80002e72:	c0278793          	addi	a5,a5,-1022 # 8001fa70 <bcache+0x8358>
    80002e76:	04f48d63          	beq	s1,a5,80002ed0 <bread+0xe2>
    80002e7a:	40bc                	lw	a5,64(s1)
    80002e7c:	cb91                	beqz	a5,80002e90 <bread+0xa2>
    80002e7e:	0001d717          	auipc	a4,0x1d
    80002e82:	bf270713          	addi	a4,a4,-1038 # 8001fa70 <bcache+0x8358>
    80002e86:	64a4                	ld	s1,72(s1)
    80002e88:	04e48463          	beq	s1,a4,80002ed0 <bread+0xe2>
    80002e8c:	40bc                	lw	a5,64(s1)
    80002e8e:	ffe5                	bnez	a5,80002e86 <bread+0x98>
    80002e90:	0134a423          	sw	s3,8(s1)
    80002e94:	0124a623          	sw	s2,12(s1)
    80002e98:	0004a023          	sw	zero,0(s1)
    80002e9c:	4785                	li	a5,1
    80002e9e:	c0bc                	sw	a5,64(s1)
    80002ea0:	00015517          	auipc	a0,0x15
    80002ea4:	87850513          	addi	a0,a0,-1928 # 80017718 <bcache>
    80002ea8:	ffffe097          	auipc	ra,0xffffe
    80002eac:	caa080e7          	jalr	-854(ra) # 80000b52 <release>
    80002eb0:	01048513          	addi	a0,s1,16
    80002eb4:	00001097          	auipc	ra,0x1
    80002eb8:	43e080e7          	jalr	1086(ra) # 800042f2 <acquiresleep>
    80002ebc:	409c                	lw	a5,0(s1)
    80002ebe:	c38d                	beqz	a5,80002ee0 <bread+0xf2>
    80002ec0:	8526                	mv	a0,s1
    80002ec2:	70a2                	ld	ra,40(sp)
    80002ec4:	7402                	ld	s0,32(sp)
    80002ec6:	64e2                	ld	s1,24(sp)
    80002ec8:	6942                	ld	s2,16(sp)
    80002eca:	69a2                	ld	s3,8(sp)
    80002ecc:	6145                	addi	sp,sp,48
    80002ece:	8082                	ret
    80002ed0:	00005517          	auipc	a0,0x5
    80002ed4:	98050513          	addi	a0,a0,-1664 # 80007850 <userret+0x7c0>
    80002ed8:	ffffd097          	auipc	ra,0xffffd
    80002edc:	6a6080e7          	jalr	1702(ra) # 8000057e <panic>
    80002ee0:	4581                	li	a1,0
    80002ee2:	8526                	mv	a0,s1
    80002ee4:	00003097          	auipc	ra,0x3
    80002ee8:	f9c080e7          	jalr	-100(ra) # 80005e80 <virtio_disk_rw>
    80002eec:	4785                	li	a5,1
    80002eee:	c09c                	sw	a5,0(s1)
    80002ef0:	bfc1                	j	80002ec0 <bread+0xd2>

0000000080002ef2 <bwrite>:
    80002ef2:	1101                	addi	sp,sp,-32
    80002ef4:	ec06                	sd	ra,24(sp)
    80002ef6:	e822                	sd	s0,16(sp)
    80002ef8:	e426                	sd	s1,8(sp)
    80002efa:	1000                	addi	s0,sp,32
    80002efc:	84aa                	mv	s1,a0
    80002efe:	0541                	addi	a0,a0,16
    80002f00:	00001097          	auipc	ra,0x1
    80002f04:	48c080e7          	jalr	1164(ra) # 8000438c <holdingsleep>
    80002f08:	cd01                	beqz	a0,80002f20 <bwrite+0x2e>
    80002f0a:	4585                	li	a1,1
    80002f0c:	8526                	mv	a0,s1
    80002f0e:	00003097          	auipc	ra,0x3
    80002f12:	f72080e7          	jalr	-142(ra) # 80005e80 <virtio_disk_rw>
    80002f16:	60e2                	ld	ra,24(sp)
    80002f18:	6442                	ld	s0,16(sp)
    80002f1a:	64a2                	ld	s1,8(sp)
    80002f1c:	6105                	addi	sp,sp,32
    80002f1e:	8082                	ret
    80002f20:	00005517          	auipc	a0,0x5
    80002f24:	94850513          	addi	a0,a0,-1720 # 80007868 <userret+0x7d8>
    80002f28:	ffffd097          	auipc	ra,0xffffd
    80002f2c:	656080e7          	jalr	1622(ra) # 8000057e <panic>

0000000080002f30 <brelse>:
    80002f30:	1101                	addi	sp,sp,-32
    80002f32:	ec06                	sd	ra,24(sp)
    80002f34:	e822                	sd	s0,16(sp)
    80002f36:	e426                	sd	s1,8(sp)
    80002f38:	e04a                	sd	s2,0(sp)
    80002f3a:	1000                	addi	s0,sp,32
    80002f3c:	84aa                	mv	s1,a0
    80002f3e:	01050913          	addi	s2,a0,16
    80002f42:	854a                	mv	a0,s2
    80002f44:	00001097          	auipc	ra,0x1
    80002f48:	448080e7          	jalr	1096(ra) # 8000438c <holdingsleep>
    80002f4c:	c92d                	beqz	a0,80002fbe <brelse+0x8e>
    80002f4e:	854a                	mv	a0,s2
    80002f50:	00001097          	auipc	ra,0x1
    80002f54:	3f8080e7          	jalr	1016(ra) # 80004348 <releasesleep>
    80002f58:	00014517          	auipc	a0,0x14
    80002f5c:	7c050513          	addi	a0,a0,1984 # 80017718 <bcache>
    80002f60:	ffffe097          	auipc	ra,0xffffe
    80002f64:	b9e080e7          	jalr	-1122(ra) # 80000afe <acquire>
    80002f68:	40bc                	lw	a5,64(s1)
    80002f6a:	37fd                	addiw	a5,a5,-1
    80002f6c:	0007871b          	sext.w	a4,a5
    80002f70:	c0bc                	sw	a5,64(s1)
    80002f72:	eb05                	bnez	a4,80002fa2 <brelse+0x72>
    80002f74:	68bc                	ld	a5,80(s1)
    80002f76:	64b8                	ld	a4,72(s1)
    80002f78:	e7b8                	sd	a4,72(a5)
    80002f7a:	64bc                	ld	a5,72(s1)
    80002f7c:	68b8                	ld	a4,80(s1)
    80002f7e:	ebb8                	sd	a4,80(a5)
    80002f80:	0001c797          	auipc	a5,0x1c
    80002f84:	79878793          	addi	a5,a5,1944 # 8001f718 <bcache+0x8000>
    80002f88:	3a87b703          	ld	a4,936(a5)
    80002f8c:	e8b8                	sd	a4,80(s1)
    80002f8e:	0001d717          	auipc	a4,0x1d
    80002f92:	ae270713          	addi	a4,a4,-1310 # 8001fa70 <bcache+0x8358>
    80002f96:	e4b8                	sd	a4,72(s1)
    80002f98:	3a87b703          	ld	a4,936(a5)
    80002f9c:	e724                	sd	s1,72(a4)
    80002f9e:	3a97b423          	sd	s1,936(a5)
    80002fa2:	00014517          	auipc	a0,0x14
    80002fa6:	77650513          	addi	a0,a0,1910 # 80017718 <bcache>
    80002faa:	ffffe097          	auipc	ra,0xffffe
    80002fae:	ba8080e7          	jalr	-1112(ra) # 80000b52 <release>
    80002fb2:	60e2                	ld	ra,24(sp)
    80002fb4:	6442                	ld	s0,16(sp)
    80002fb6:	64a2                	ld	s1,8(sp)
    80002fb8:	6902                	ld	s2,0(sp)
    80002fba:	6105                	addi	sp,sp,32
    80002fbc:	8082                	ret
    80002fbe:	00005517          	auipc	a0,0x5
    80002fc2:	8b250513          	addi	a0,a0,-1870 # 80007870 <userret+0x7e0>
    80002fc6:	ffffd097          	auipc	ra,0xffffd
    80002fca:	5b8080e7          	jalr	1464(ra) # 8000057e <panic>

0000000080002fce <bpin>:
    80002fce:	1101                	addi	sp,sp,-32
    80002fd0:	ec06                	sd	ra,24(sp)
    80002fd2:	e822                	sd	s0,16(sp)
    80002fd4:	e426                	sd	s1,8(sp)
    80002fd6:	1000                	addi	s0,sp,32
    80002fd8:	84aa                	mv	s1,a0
    80002fda:	00014517          	auipc	a0,0x14
    80002fde:	73e50513          	addi	a0,a0,1854 # 80017718 <bcache>
    80002fe2:	ffffe097          	auipc	ra,0xffffe
    80002fe6:	b1c080e7          	jalr	-1252(ra) # 80000afe <acquire>
    80002fea:	40bc                	lw	a5,64(s1)
    80002fec:	2785                	addiw	a5,a5,1
    80002fee:	c0bc                	sw	a5,64(s1)
    80002ff0:	00014517          	auipc	a0,0x14
    80002ff4:	72850513          	addi	a0,a0,1832 # 80017718 <bcache>
    80002ff8:	ffffe097          	auipc	ra,0xffffe
    80002ffc:	b5a080e7          	jalr	-1190(ra) # 80000b52 <release>
    80003000:	60e2                	ld	ra,24(sp)
    80003002:	6442                	ld	s0,16(sp)
    80003004:	64a2                	ld	s1,8(sp)
    80003006:	6105                	addi	sp,sp,32
    80003008:	8082                	ret

000000008000300a <bunpin>:
    8000300a:	1101                	addi	sp,sp,-32
    8000300c:	ec06                	sd	ra,24(sp)
    8000300e:	e822                	sd	s0,16(sp)
    80003010:	e426                	sd	s1,8(sp)
    80003012:	1000                	addi	s0,sp,32
    80003014:	84aa                	mv	s1,a0
    80003016:	00014517          	auipc	a0,0x14
    8000301a:	70250513          	addi	a0,a0,1794 # 80017718 <bcache>
    8000301e:	ffffe097          	auipc	ra,0xffffe
    80003022:	ae0080e7          	jalr	-1312(ra) # 80000afe <acquire>
    80003026:	40bc                	lw	a5,64(s1)
    80003028:	37fd                	addiw	a5,a5,-1
    8000302a:	c0bc                	sw	a5,64(s1)
    8000302c:	00014517          	auipc	a0,0x14
    80003030:	6ec50513          	addi	a0,a0,1772 # 80017718 <bcache>
    80003034:	ffffe097          	auipc	ra,0xffffe
    80003038:	b1e080e7          	jalr	-1250(ra) # 80000b52 <release>
    8000303c:	60e2                	ld	ra,24(sp)
    8000303e:	6442                	ld	s0,16(sp)
    80003040:	64a2                	ld	s1,8(sp)
    80003042:	6105                	addi	sp,sp,32
    80003044:	8082                	ret

0000000080003046 <bfree>:
    80003046:	1101                	addi	sp,sp,-32
    80003048:	ec06                	sd	ra,24(sp)
    8000304a:	e822                	sd	s0,16(sp)
    8000304c:	e426                	sd	s1,8(sp)
    8000304e:	e04a                	sd	s2,0(sp)
    80003050:	1000                	addi	s0,sp,32
    80003052:	84ae                	mv	s1,a1
    80003054:	00d5d59b          	srliw	a1,a1,0xd
    80003058:	0001d797          	auipc	a5,0x1d
    8000305c:	e7878793          	addi	a5,a5,-392 # 8001fed0 <sb>
    80003060:	4fdc                	lw	a5,28(a5)
    80003062:	9dbd                	addw	a1,a1,a5
    80003064:	00000097          	auipc	ra,0x0
    80003068:	d8a080e7          	jalr	-630(ra) # 80002dee <bread>
    8000306c:	2481                	sext.w	s1,s1
    8000306e:	0074f793          	andi	a5,s1,7
    80003072:	4705                	li	a4,1
    80003074:	00f7173b          	sllw	a4,a4,a5
    80003078:	6789                	lui	a5,0x2
    8000307a:	17fd                	addi	a5,a5,-1
    8000307c:	8cfd                	and	s1,s1,a5
    8000307e:	41f4d79b          	sraiw	a5,s1,0x1f
    80003082:	01d7d79b          	srliw	a5,a5,0x1d
    80003086:	9fa5                	addw	a5,a5,s1
    80003088:	4037d79b          	sraiw	a5,a5,0x3
    8000308c:	00f506b3          	add	a3,a0,a5
    80003090:	0606c683          	lbu	a3,96(a3)
    80003094:	00d77633          	and	a2,a4,a3
    80003098:	c61d                	beqz	a2,800030c6 <bfree+0x80>
    8000309a:	892a                	mv	s2,a0
    8000309c:	97aa                	add	a5,a5,a0
    8000309e:	fff74713          	not	a4,a4
    800030a2:	8f75                	and	a4,a4,a3
    800030a4:	06e78023          	sb	a4,96(a5) # 2060 <_entry-0x7fffdfa0>
    800030a8:	00001097          	auipc	ra,0x1
    800030ac:	10c080e7          	jalr	268(ra) # 800041b4 <log_write>
    800030b0:	854a                	mv	a0,s2
    800030b2:	00000097          	auipc	ra,0x0
    800030b6:	e7e080e7          	jalr	-386(ra) # 80002f30 <brelse>
    800030ba:	60e2                	ld	ra,24(sp)
    800030bc:	6442                	ld	s0,16(sp)
    800030be:	64a2                	ld	s1,8(sp)
    800030c0:	6902                	ld	s2,0(sp)
    800030c2:	6105                	addi	sp,sp,32
    800030c4:	8082                	ret
    800030c6:	00004517          	auipc	a0,0x4
    800030ca:	7b250513          	addi	a0,a0,1970 # 80007878 <userret+0x7e8>
    800030ce:	ffffd097          	auipc	ra,0xffffd
    800030d2:	4b0080e7          	jalr	1200(ra) # 8000057e <panic>

00000000800030d6 <balloc>:
    800030d6:	711d                	addi	sp,sp,-96
    800030d8:	ec86                	sd	ra,88(sp)
    800030da:	e8a2                	sd	s0,80(sp)
    800030dc:	e4a6                	sd	s1,72(sp)
    800030de:	e0ca                	sd	s2,64(sp)
    800030e0:	fc4e                	sd	s3,56(sp)
    800030e2:	f852                	sd	s4,48(sp)
    800030e4:	f456                	sd	s5,40(sp)
    800030e6:	f05a                	sd	s6,32(sp)
    800030e8:	ec5e                	sd	s7,24(sp)
    800030ea:	e862                	sd	s8,16(sp)
    800030ec:	e466                	sd	s9,8(sp)
    800030ee:	1080                	addi	s0,sp,96
    800030f0:	0001d797          	auipc	a5,0x1d
    800030f4:	de078793          	addi	a5,a5,-544 # 8001fed0 <sb>
    800030f8:	43dc                	lw	a5,4(a5)
    800030fa:	10078e63          	beqz	a5,80003216 <balloc+0x140>
    800030fe:	8baa                	mv	s7,a0
    80003100:	4a81                	li	s5,0
    80003102:	0001db17          	auipc	s6,0x1d
    80003106:	dceb0b13          	addi	s6,s6,-562 # 8001fed0 <sb>
    8000310a:	4c05                	li	s8,1
    8000310c:	4985                	li	s3,1
    8000310e:	6a09                	lui	s4,0x2
    80003110:	6c89                	lui	s9,0x2
    80003112:	a079                	j	800031a0 <balloc+0xca>
    80003114:	8942                	mv	s2,a6
    80003116:	4705                	li	a4,1
    80003118:	4681                	li	a3,0
    8000311a:	96a6                	add	a3,a3,s1
    8000311c:	8f51                	or	a4,a4,a2
    8000311e:	06e68023          	sb	a4,96(a3)
    80003122:	8526                	mv	a0,s1
    80003124:	00001097          	auipc	ra,0x1
    80003128:	090080e7          	jalr	144(ra) # 800041b4 <log_write>
    8000312c:	8526                	mv	a0,s1
    8000312e:	00000097          	auipc	ra,0x0
    80003132:	e02080e7          	jalr	-510(ra) # 80002f30 <brelse>
    80003136:	85ca                	mv	a1,s2
    80003138:	855e                	mv	a0,s7
    8000313a:	00000097          	auipc	ra,0x0
    8000313e:	cb4080e7          	jalr	-844(ra) # 80002dee <bread>
    80003142:	84aa                	mv	s1,a0
    80003144:	40000613          	li	a2,1024
    80003148:	4581                	li	a1,0
    8000314a:	06050513          	addi	a0,a0,96
    8000314e:	ffffe097          	auipc	ra,0xffffe
    80003152:	a4c080e7          	jalr	-1460(ra) # 80000b9a <memset>
    80003156:	8526                	mv	a0,s1
    80003158:	00001097          	auipc	ra,0x1
    8000315c:	05c080e7          	jalr	92(ra) # 800041b4 <log_write>
    80003160:	8526                	mv	a0,s1
    80003162:	00000097          	auipc	ra,0x0
    80003166:	dce080e7          	jalr	-562(ra) # 80002f30 <brelse>
    8000316a:	854a                	mv	a0,s2
    8000316c:	60e6                	ld	ra,88(sp)
    8000316e:	6446                	ld	s0,80(sp)
    80003170:	64a6                	ld	s1,72(sp)
    80003172:	6906                	ld	s2,64(sp)
    80003174:	79e2                	ld	s3,56(sp)
    80003176:	7a42                	ld	s4,48(sp)
    80003178:	7aa2                	ld	s5,40(sp)
    8000317a:	7b02                	ld	s6,32(sp)
    8000317c:	6be2                	ld	s7,24(sp)
    8000317e:	6c42                	ld	s8,16(sp)
    80003180:	6ca2                	ld	s9,8(sp)
    80003182:	6125                	addi	sp,sp,96
    80003184:	8082                	ret
    80003186:	8526                	mv	a0,s1
    80003188:	00000097          	auipc	ra,0x0
    8000318c:	da8080e7          	jalr	-600(ra) # 80002f30 <brelse>
    80003190:	015c87bb          	addw	a5,s9,s5
    80003194:	00078a9b          	sext.w	s5,a5
    80003198:	004b2703          	lw	a4,4(s6)
    8000319c:	06eafd63          	bleu	a4,s5,80003216 <balloc+0x140>
    800031a0:	41fad79b          	sraiw	a5,s5,0x1f
    800031a4:	0137d79b          	srliw	a5,a5,0x13
    800031a8:	015787bb          	addw	a5,a5,s5
    800031ac:	40d7d79b          	sraiw	a5,a5,0xd
    800031b0:	01cb2583          	lw	a1,28(s6)
    800031b4:	9dbd                	addw	a1,a1,a5
    800031b6:	855e                	mv	a0,s7
    800031b8:	00000097          	auipc	ra,0x0
    800031bc:	c36080e7          	jalr	-970(ra) # 80002dee <bread>
    800031c0:	84aa                	mv	s1,a0
    800031c2:	000a881b          	sext.w	a6,s5
    800031c6:	004b2503          	lw	a0,4(s6)
    800031ca:	faa87ee3          	bleu	a0,a6,80003186 <balloc+0xb0>
    800031ce:	0604c603          	lbu	a2,96(s1)
    800031d2:	00167793          	andi	a5,a2,1
    800031d6:	df9d                	beqz	a5,80003114 <balloc+0x3e>
    800031d8:	4105053b          	subw	a0,a0,a6
    800031dc:	87e2                	mv	a5,s8
    800031de:	0107893b          	addw	s2,a5,a6
    800031e2:	faa782e3          	beq	a5,a0,80003186 <balloc+0xb0>
    800031e6:	41f7d71b          	sraiw	a4,a5,0x1f
    800031ea:	01d7561b          	srliw	a2,a4,0x1d
    800031ee:	00f606bb          	addw	a3,a2,a5
    800031f2:	0076f713          	andi	a4,a3,7
    800031f6:	9f11                	subw	a4,a4,a2
    800031f8:	00e9973b          	sllw	a4,s3,a4
    800031fc:	4036d69b          	sraiw	a3,a3,0x3
    80003200:	00d48633          	add	a2,s1,a3
    80003204:	06064603          	lbu	a2,96(a2)
    80003208:	00c775b3          	and	a1,a4,a2
    8000320c:	d599                	beqz	a1,8000311a <balloc+0x44>
    8000320e:	2785                	addiw	a5,a5,1
    80003210:	fd4797e3          	bne	a5,s4,800031de <balloc+0x108>
    80003214:	bf8d                	j	80003186 <balloc+0xb0>
    80003216:	00004517          	auipc	a0,0x4
    8000321a:	67a50513          	addi	a0,a0,1658 # 80007890 <userret+0x800>
    8000321e:	ffffd097          	auipc	ra,0xffffd
    80003222:	360080e7          	jalr	864(ra) # 8000057e <panic>

0000000080003226 <bmap>:
    80003226:	7179                	addi	sp,sp,-48
    80003228:	f406                	sd	ra,40(sp)
    8000322a:	f022                	sd	s0,32(sp)
    8000322c:	ec26                	sd	s1,24(sp)
    8000322e:	e84a                	sd	s2,16(sp)
    80003230:	e44e                	sd	s3,8(sp)
    80003232:	e052                	sd	s4,0(sp)
    80003234:	1800                	addi	s0,sp,48
    80003236:	89aa                	mv	s3,a0
    80003238:	47ad                	li	a5,11
    8000323a:	04b7fe63          	bleu	a1,a5,80003296 <bmap+0x70>
    8000323e:	ff45849b          	addiw	s1,a1,-12
    80003242:	0004871b          	sext.w	a4,s1
    80003246:	0ff00793          	li	a5,255
    8000324a:	0ae7e363          	bltu	a5,a4,800032f0 <bmap+0xca>
    8000324e:	08052583          	lw	a1,128(a0)
    80003252:	c5ad                	beqz	a1,800032bc <bmap+0x96>
    80003254:	0009a503          	lw	a0,0(s3)
    80003258:	00000097          	auipc	ra,0x0
    8000325c:	b96080e7          	jalr	-1130(ra) # 80002dee <bread>
    80003260:	8a2a                	mv	s4,a0
    80003262:	06050793          	addi	a5,a0,96
    80003266:	02049593          	slli	a1,s1,0x20
    8000326a:	9181                	srli	a1,a1,0x20
    8000326c:	058a                	slli	a1,a1,0x2
    8000326e:	00b784b3          	add	s1,a5,a1
    80003272:	0004a903          	lw	s2,0(s1)
    80003276:	04090d63          	beqz	s2,800032d0 <bmap+0xaa>
    8000327a:	8552                	mv	a0,s4
    8000327c:	00000097          	auipc	ra,0x0
    80003280:	cb4080e7          	jalr	-844(ra) # 80002f30 <brelse>
    80003284:	854a                	mv	a0,s2
    80003286:	70a2                	ld	ra,40(sp)
    80003288:	7402                	ld	s0,32(sp)
    8000328a:	64e2                	ld	s1,24(sp)
    8000328c:	6942                	ld	s2,16(sp)
    8000328e:	69a2                	ld	s3,8(sp)
    80003290:	6a02                	ld	s4,0(sp)
    80003292:	6145                	addi	sp,sp,48
    80003294:	8082                	ret
    80003296:	02059493          	slli	s1,a1,0x20
    8000329a:	9081                	srli	s1,s1,0x20
    8000329c:	048a                	slli	s1,s1,0x2
    8000329e:	94aa                	add	s1,s1,a0
    800032a0:	0504a903          	lw	s2,80(s1)
    800032a4:	fe0910e3          	bnez	s2,80003284 <bmap+0x5e>
    800032a8:	4108                	lw	a0,0(a0)
    800032aa:	00000097          	auipc	ra,0x0
    800032ae:	e2c080e7          	jalr	-468(ra) # 800030d6 <balloc>
    800032b2:	0005091b          	sext.w	s2,a0
    800032b6:	0524a823          	sw	s2,80(s1)
    800032ba:	b7e9                	j	80003284 <bmap+0x5e>
    800032bc:	4108                	lw	a0,0(a0)
    800032be:	00000097          	auipc	ra,0x0
    800032c2:	e18080e7          	jalr	-488(ra) # 800030d6 <balloc>
    800032c6:	0005059b          	sext.w	a1,a0
    800032ca:	08b9a023          	sw	a1,128(s3)
    800032ce:	b759                	j	80003254 <bmap+0x2e>
    800032d0:	0009a503          	lw	a0,0(s3)
    800032d4:	00000097          	auipc	ra,0x0
    800032d8:	e02080e7          	jalr	-510(ra) # 800030d6 <balloc>
    800032dc:	0005091b          	sext.w	s2,a0
    800032e0:	0124a023          	sw	s2,0(s1)
    800032e4:	8552                	mv	a0,s4
    800032e6:	00001097          	auipc	ra,0x1
    800032ea:	ece080e7          	jalr	-306(ra) # 800041b4 <log_write>
    800032ee:	b771                	j	8000327a <bmap+0x54>
    800032f0:	00004517          	auipc	a0,0x4
    800032f4:	5b850513          	addi	a0,a0,1464 # 800078a8 <userret+0x818>
    800032f8:	ffffd097          	auipc	ra,0xffffd
    800032fc:	286080e7          	jalr	646(ra) # 8000057e <panic>

0000000080003300 <iget>:
    80003300:	7179                	addi	sp,sp,-48
    80003302:	f406                	sd	ra,40(sp)
    80003304:	f022                	sd	s0,32(sp)
    80003306:	ec26                	sd	s1,24(sp)
    80003308:	e84a                	sd	s2,16(sp)
    8000330a:	e44e                	sd	s3,8(sp)
    8000330c:	e052                	sd	s4,0(sp)
    8000330e:	1800                	addi	s0,sp,48
    80003310:	89aa                	mv	s3,a0
    80003312:	8a2e                	mv	s4,a1
    80003314:	0001d517          	auipc	a0,0x1d
    80003318:	bdc50513          	addi	a0,a0,-1060 # 8001fef0 <icache>
    8000331c:	ffffd097          	auipc	ra,0xffffd
    80003320:	7e2080e7          	jalr	2018(ra) # 80000afe <acquire>
    80003324:	4901                	li	s2,0
    80003326:	0001d497          	auipc	s1,0x1d
    8000332a:	be248493          	addi	s1,s1,-1054 # 8001ff08 <icache+0x18>
    8000332e:	0001e697          	auipc	a3,0x1e
    80003332:	66a68693          	addi	a3,a3,1642 # 80021998 <log>
    80003336:	a039                	j	80003344 <iget+0x44>
    80003338:	02090b63          	beqz	s2,8000336e <iget+0x6e>
    8000333c:	08848493          	addi	s1,s1,136
    80003340:	02d48a63          	beq	s1,a3,80003374 <iget+0x74>
    80003344:	449c                	lw	a5,8(s1)
    80003346:	fef059e3          	blez	a5,80003338 <iget+0x38>
    8000334a:	4098                	lw	a4,0(s1)
    8000334c:	ff3716e3          	bne	a4,s3,80003338 <iget+0x38>
    80003350:	40d8                	lw	a4,4(s1)
    80003352:	ff4713e3          	bne	a4,s4,80003338 <iget+0x38>
    80003356:	2785                	addiw	a5,a5,1
    80003358:	c49c                	sw	a5,8(s1)
    8000335a:	0001d517          	auipc	a0,0x1d
    8000335e:	b9650513          	addi	a0,a0,-1130 # 8001fef0 <icache>
    80003362:	ffffd097          	auipc	ra,0xffffd
    80003366:	7f0080e7          	jalr	2032(ra) # 80000b52 <release>
    8000336a:	8926                	mv	s2,s1
    8000336c:	a03d                	j	8000339a <iget+0x9a>
    8000336e:	f7f9                	bnez	a5,8000333c <iget+0x3c>
    80003370:	8926                	mv	s2,s1
    80003372:	b7e9                	j	8000333c <iget+0x3c>
    80003374:	02090c63          	beqz	s2,800033ac <iget+0xac>
    80003378:	01392023          	sw	s3,0(s2)
    8000337c:	01492223          	sw	s4,4(s2)
    80003380:	4785                	li	a5,1
    80003382:	00f92423          	sw	a5,8(s2)
    80003386:	04092023          	sw	zero,64(s2)
    8000338a:	0001d517          	auipc	a0,0x1d
    8000338e:	b6650513          	addi	a0,a0,-1178 # 8001fef0 <icache>
    80003392:	ffffd097          	auipc	ra,0xffffd
    80003396:	7c0080e7          	jalr	1984(ra) # 80000b52 <release>
    8000339a:	854a                	mv	a0,s2
    8000339c:	70a2                	ld	ra,40(sp)
    8000339e:	7402                	ld	s0,32(sp)
    800033a0:	64e2                	ld	s1,24(sp)
    800033a2:	6942                	ld	s2,16(sp)
    800033a4:	69a2                	ld	s3,8(sp)
    800033a6:	6a02                	ld	s4,0(sp)
    800033a8:	6145                	addi	sp,sp,48
    800033aa:	8082                	ret
    800033ac:	00004517          	auipc	a0,0x4
    800033b0:	51450513          	addi	a0,a0,1300 # 800078c0 <userret+0x830>
    800033b4:	ffffd097          	auipc	ra,0xffffd
    800033b8:	1ca080e7          	jalr	458(ra) # 8000057e <panic>

00000000800033bc <fsinit>:
    800033bc:	7179                	addi	sp,sp,-48
    800033be:	f406                	sd	ra,40(sp)
    800033c0:	f022                	sd	s0,32(sp)
    800033c2:	ec26                	sd	s1,24(sp)
    800033c4:	e84a                	sd	s2,16(sp)
    800033c6:	e44e                	sd	s3,8(sp)
    800033c8:	1800                	addi	s0,sp,48
    800033ca:	89aa                	mv	s3,a0
    800033cc:	4585                	li	a1,1
    800033ce:	00000097          	auipc	ra,0x0
    800033d2:	a20080e7          	jalr	-1504(ra) # 80002dee <bread>
    800033d6:	892a                	mv	s2,a0
    800033d8:	0001d497          	auipc	s1,0x1d
    800033dc:	af848493          	addi	s1,s1,-1288 # 8001fed0 <sb>
    800033e0:	02000613          	li	a2,32
    800033e4:	06050593          	addi	a1,a0,96
    800033e8:	8526                	mv	a0,s1
    800033ea:	ffffe097          	auipc	ra,0xffffe
    800033ee:	81c080e7          	jalr	-2020(ra) # 80000c06 <memmove>
    800033f2:	854a                	mv	a0,s2
    800033f4:	00000097          	auipc	ra,0x0
    800033f8:	b3c080e7          	jalr	-1220(ra) # 80002f30 <brelse>
    800033fc:	4098                	lw	a4,0(s1)
    800033fe:	102037b7          	lui	a5,0x10203
    80003402:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003406:	02f71263          	bne	a4,a5,8000342a <fsinit+0x6e>
    8000340a:	0001d597          	auipc	a1,0x1d
    8000340e:	ac658593          	addi	a1,a1,-1338 # 8001fed0 <sb>
    80003412:	854e                	mv	a0,s3
    80003414:	00001097          	auipc	ra,0x1
    80003418:	b22080e7          	jalr	-1246(ra) # 80003f36 <initlog>
    8000341c:	70a2                	ld	ra,40(sp)
    8000341e:	7402                	ld	s0,32(sp)
    80003420:	64e2                	ld	s1,24(sp)
    80003422:	6942                	ld	s2,16(sp)
    80003424:	69a2                	ld	s3,8(sp)
    80003426:	6145                	addi	sp,sp,48
    80003428:	8082                	ret
    8000342a:	00004517          	auipc	a0,0x4
    8000342e:	4a650513          	addi	a0,a0,1190 # 800078d0 <userret+0x840>
    80003432:	ffffd097          	auipc	ra,0xffffd
    80003436:	14c080e7          	jalr	332(ra) # 8000057e <panic>

000000008000343a <iinit>:
    8000343a:	7179                	addi	sp,sp,-48
    8000343c:	f406                	sd	ra,40(sp)
    8000343e:	f022                	sd	s0,32(sp)
    80003440:	ec26                	sd	s1,24(sp)
    80003442:	e84a                	sd	s2,16(sp)
    80003444:	e44e                	sd	s3,8(sp)
    80003446:	1800                	addi	s0,sp,48
    80003448:	00004597          	auipc	a1,0x4
    8000344c:	4a058593          	addi	a1,a1,1184 # 800078e8 <userret+0x858>
    80003450:	0001d517          	auipc	a0,0x1d
    80003454:	aa050513          	addi	a0,a0,-1376 # 8001fef0 <icache>
    80003458:	ffffd097          	auipc	ra,0xffffd
    8000345c:	598080e7          	jalr	1432(ra) # 800009f0 <initlock>
    80003460:	0001d497          	auipc	s1,0x1d
    80003464:	ab848493          	addi	s1,s1,-1352 # 8001ff18 <icache+0x28>
    80003468:	0001e997          	auipc	s3,0x1e
    8000346c:	54098993          	addi	s3,s3,1344 # 800219a8 <log+0x10>
    80003470:	00004917          	auipc	s2,0x4
    80003474:	48090913          	addi	s2,s2,1152 # 800078f0 <userret+0x860>
    80003478:	85ca                	mv	a1,s2
    8000347a:	8526                	mv	a0,s1
    8000347c:	00001097          	auipc	ra,0x1
    80003480:	e3c080e7          	jalr	-452(ra) # 800042b8 <initsleeplock>
    80003484:	08848493          	addi	s1,s1,136
    80003488:	ff3498e3          	bne	s1,s3,80003478 <iinit+0x3e>
    8000348c:	70a2                	ld	ra,40(sp)
    8000348e:	7402                	ld	s0,32(sp)
    80003490:	64e2                	ld	s1,24(sp)
    80003492:	6942                	ld	s2,16(sp)
    80003494:	69a2                	ld	s3,8(sp)
    80003496:	6145                	addi	sp,sp,48
    80003498:	8082                	ret

000000008000349a <ialloc>:
    8000349a:	715d                	addi	sp,sp,-80
    8000349c:	e486                	sd	ra,72(sp)
    8000349e:	e0a2                	sd	s0,64(sp)
    800034a0:	fc26                	sd	s1,56(sp)
    800034a2:	f84a                	sd	s2,48(sp)
    800034a4:	f44e                	sd	s3,40(sp)
    800034a6:	f052                	sd	s4,32(sp)
    800034a8:	ec56                	sd	s5,24(sp)
    800034aa:	e85a                	sd	s6,16(sp)
    800034ac:	e45e                	sd	s7,8(sp)
    800034ae:	0880                	addi	s0,sp,80
    800034b0:	0001d797          	auipc	a5,0x1d
    800034b4:	a2078793          	addi	a5,a5,-1504 # 8001fed0 <sb>
    800034b8:	47d8                	lw	a4,12(a5)
    800034ba:	4785                	li	a5,1
    800034bc:	04e7fa63          	bleu	a4,a5,80003510 <ialloc+0x76>
    800034c0:	8a2a                	mv	s4,a0
    800034c2:	8b2e                	mv	s6,a1
    800034c4:	4485                	li	s1,1
    800034c6:	0001d997          	auipc	s3,0x1d
    800034ca:	a0a98993          	addi	s3,s3,-1526 # 8001fed0 <sb>
    800034ce:	00048a9b          	sext.w	s5,s1
    800034d2:	0044d593          	srli	a1,s1,0x4
    800034d6:	0189a783          	lw	a5,24(s3)
    800034da:	9dbd                	addw	a1,a1,a5
    800034dc:	8552                	mv	a0,s4
    800034de:	00000097          	auipc	ra,0x0
    800034e2:	910080e7          	jalr	-1776(ra) # 80002dee <bread>
    800034e6:	8baa                	mv	s7,a0
    800034e8:	06050913          	addi	s2,a0,96
    800034ec:	00f4f793          	andi	a5,s1,15
    800034f0:	079a                	slli	a5,a5,0x6
    800034f2:	993e                	add	s2,s2,a5
    800034f4:	00091783          	lh	a5,0(s2)
    800034f8:	c785                	beqz	a5,80003520 <ialloc+0x86>
    800034fa:	00000097          	auipc	ra,0x0
    800034fe:	a36080e7          	jalr	-1482(ra) # 80002f30 <brelse>
    80003502:	0485                	addi	s1,s1,1
    80003504:	00c9a703          	lw	a4,12(s3)
    80003508:	0004879b          	sext.w	a5,s1
    8000350c:	fce7e1e3          	bltu	a5,a4,800034ce <ialloc+0x34>
    80003510:	00004517          	auipc	a0,0x4
    80003514:	3e850513          	addi	a0,a0,1000 # 800078f8 <userret+0x868>
    80003518:	ffffd097          	auipc	ra,0xffffd
    8000351c:	066080e7          	jalr	102(ra) # 8000057e <panic>
    80003520:	04000613          	li	a2,64
    80003524:	4581                	li	a1,0
    80003526:	854a                	mv	a0,s2
    80003528:	ffffd097          	auipc	ra,0xffffd
    8000352c:	672080e7          	jalr	1650(ra) # 80000b9a <memset>
    80003530:	01691023          	sh	s6,0(s2)
    80003534:	855e                	mv	a0,s7
    80003536:	00001097          	auipc	ra,0x1
    8000353a:	c7e080e7          	jalr	-898(ra) # 800041b4 <log_write>
    8000353e:	855e                	mv	a0,s7
    80003540:	00000097          	auipc	ra,0x0
    80003544:	9f0080e7          	jalr	-1552(ra) # 80002f30 <brelse>
    80003548:	85d6                	mv	a1,s5
    8000354a:	8552                	mv	a0,s4
    8000354c:	00000097          	auipc	ra,0x0
    80003550:	db4080e7          	jalr	-588(ra) # 80003300 <iget>
    80003554:	60a6                	ld	ra,72(sp)
    80003556:	6406                	ld	s0,64(sp)
    80003558:	74e2                	ld	s1,56(sp)
    8000355a:	7942                	ld	s2,48(sp)
    8000355c:	79a2                	ld	s3,40(sp)
    8000355e:	7a02                	ld	s4,32(sp)
    80003560:	6ae2                	ld	s5,24(sp)
    80003562:	6b42                	ld	s6,16(sp)
    80003564:	6ba2                	ld	s7,8(sp)
    80003566:	6161                	addi	sp,sp,80
    80003568:	8082                	ret

000000008000356a <iupdate>:
    8000356a:	1101                	addi	sp,sp,-32
    8000356c:	ec06                	sd	ra,24(sp)
    8000356e:	e822                	sd	s0,16(sp)
    80003570:	e426                	sd	s1,8(sp)
    80003572:	e04a                	sd	s2,0(sp)
    80003574:	1000                	addi	s0,sp,32
    80003576:	84aa                	mv	s1,a0
    80003578:	415c                	lw	a5,4(a0)
    8000357a:	0047d79b          	srliw	a5,a5,0x4
    8000357e:	0001d717          	auipc	a4,0x1d
    80003582:	95270713          	addi	a4,a4,-1710 # 8001fed0 <sb>
    80003586:	4f0c                	lw	a1,24(a4)
    80003588:	9dbd                	addw	a1,a1,a5
    8000358a:	4108                	lw	a0,0(a0)
    8000358c:	00000097          	auipc	ra,0x0
    80003590:	862080e7          	jalr	-1950(ra) # 80002dee <bread>
    80003594:	892a                	mv	s2,a0
    80003596:	06050513          	addi	a0,a0,96
    8000359a:	40dc                	lw	a5,4(s1)
    8000359c:	8bbd                	andi	a5,a5,15
    8000359e:	079a                	slli	a5,a5,0x6
    800035a0:	953e                	add	a0,a0,a5
    800035a2:	04449783          	lh	a5,68(s1)
    800035a6:	00f51023          	sh	a5,0(a0)
    800035aa:	04649783          	lh	a5,70(s1)
    800035ae:	00f51123          	sh	a5,2(a0)
    800035b2:	04849783          	lh	a5,72(s1)
    800035b6:	00f51223          	sh	a5,4(a0)
    800035ba:	04a49783          	lh	a5,74(s1)
    800035be:	00f51323          	sh	a5,6(a0)
    800035c2:	44fc                	lw	a5,76(s1)
    800035c4:	c51c                	sw	a5,8(a0)
    800035c6:	03400613          	li	a2,52
    800035ca:	05048593          	addi	a1,s1,80
    800035ce:	0531                	addi	a0,a0,12
    800035d0:	ffffd097          	auipc	ra,0xffffd
    800035d4:	636080e7          	jalr	1590(ra) # 80000c06 <memmove>
    800035d8:	854a                	mv	a0,s2
    800035da:	00001097          	auipc	ra,0x1
    800035de:	bda080e7          	jalr	-1062(ra) # 800041b4 <log_write>
    800035e2:	854a                	mv	a0,s2
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	94c080e7          	jalr	-1716(ra) # 80002f30 <brelse>
    800035ec:	60e2                	ld	ra,24(sp)
    800035ee:	6442                	ld	s0,16(sp)
    800035f0:	64a2                	ld	s1,8(sp)
    800035f2:	6902                	ld	s2,0(sp)
    800035f4:	6105                	addi	sp,sp,32
    800035f6:	8082                	ret

00000000800035f8 <idup>:
    800035f8:	1101                	addi	sp,sp,-32
    800035fa:	ec06                	sd	ra,24(sp)
    800035fc:	e822                	sd	s0,16(sp)
    800035fe:	e426                	sd	s1,8(sp)
    80003600:	1000                	addi	s0,sp,32
    80003602:	84aa                	mv	s1,a0
    80003604:	0001d517          	auipc	a0,0x1d
    80003608:	8ec50513          	addi	a0,a0,-1812 # 8001fef0 <icache>
    8000360c:	ffffd097          	auipc	ra,0xffffd
    80003610:	4f2080e7          	jalr	1266(ra) # 80000afe <acquire>
    80003614:	449c                	lw	a5,8(s1)
    80003616:	2785                	addiw	a5,a5,1
    80003618:	c49c                	sw	a5,8(s1)
    8000361a:	0001d517          	auipc	a0,0x1d
    8000361e:	8d650513          	addi	a0,a0,-1834 # 8001fef0 <icache>
    80003622:	ffffd097          	auipc	ra,0xffffd
    80003626:	530080e7          	jalr	1328(ra) # 80000b52 <release>
    8000362a:	8526                	mv	a0,s1
    8000362c:	60e2                	ld	ra,24(sp)
    8000362e:	6442                	ld	s0,16(sp)
    80003630:	64a2                	ld	s1,8(sp)
    80003632:	6105                	addi	sp,sp,32
    80003634:	8082                	ret

0000000080003636 <ilock>:
    80003636:	1101                	addi	sp,sp,-32
    80003638:	ec06                	sd	ra,24(sp)
    8000363a:	e822                	sd	s0,16(sp)
    8000363c:	e426                	sd	s1,8(sp)
    8000363e:	e04a                	sd	s2,0(sp)
    80003640:	1000                	addi	s0,sp,32
    80003642:	c115                	beqz	a0,80003666 <ilock+0x30>
    80003644:	84aa                	mv	s1,a0
    80003646:	451c                	lw	a5,8(a0)
    80003648:	00f05f63          	blez	a5,80003666 <ilock+0x30>
    8000364c:	0541                	addi	a0,a0,16
    8000364e:	00001097          	auipc	ra,0x1
    80003652:	ca4080e7          	jalr	-860(ra) # 800042f2 <acquiresleep>
    80003656:	40bc                	lw	a5,64(s1)
    80003658:	cf99                	beqz	a5,80003676 <ilock+0x40>
    8000365a:	60e2                	ld	ra,24(sp)
    8000365c:	6442                	ld	s0,16(sp)
    8000365e:	64a2                	ld	s1,8(sp)
    80003660:	6902                	ld	s2,0(sp)
    80003662:	6105                	addi	sp,sp,32
    80003664:	8082                	ret
    80003666:	00004517          	auipc	a0,0x4
    8000366a:	2aa50513          	addi	a0,a0,682 # 80007910 <userret+0x880>
    8000366e:	ffffd097          	auipc	ra,0xffffd
    80003672:	f10080e7          	jalr	-240(ra) # 8000057e <panic>
    80003676:	40dc                	lw	a5,4(s1)
    80003678:	0047d79b          	srliw	a5,a5,0x4
    8000367c:	0001d717          	auipc	a4,0x1d
    80003680:	85470713          	addi	a4,a4,-1964 # 8001fed0 <sb>
    80003684:	4f0c                	lw	a1,24(a4)
    80003686:	9dbd                	addw	a1,a1,a5
    80003688:	4088                	lw	a0,0(s1)
    8000368a:	fffff097          	auipc	ra,0xfffff
    8000368e:	764080e7          	jalr	1892(ra) # 80002dee <bread>
    80003692:	892a                	mv	s2,a0
    80003694:	06050593          	addi	a1,a0,96
    80003698:	40dc                	lw	a5,4(s1)
    8000369a:	8bbd                	andi	a5,a5,15
    8000369c:	079a                	slli	a5,a5,0x6
    8000369e:	95be                	add	a1,a1,a5
    800036a0:	00059783          	lh	a5,0(a1)
    800036a4:	04f49223          	sh	a5,68(s1)
    800036a8:	00259783          	lh	a5,2(a1)
    800036ac:	04f49323          	sh	a5,70(s1)
    800036b0:	00459783          	lh	a5,4(a1)
    800036b4:	04f49423          	sh	a5,72(s1)
    800036b8:	00659783          	lh	a5,6(a1)
    800036bc:	04f49523          	sh	a5,74(s1)
    800036c0:	459c                	lw	a5,8(a1)
    800036c2:	c4fc                	sw	a5,76(s1)
    800036c4:	03400613          	li	a2,52
    800036c8:	05b1                	addi	a1,a1,12
    800036ca:	05048513          	addi	a0,s1,80
    800036ce:	ffffd097          	auipc	ra,0xffffd
    800036d2:	538080e7          	jalr	1336(ra) # 80000c06 <memmove>
    800036d6:	854a                	mv	a0,s2
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	858080e7          	jalr	-1960(ra) # 80002f30 <brelse>
    800036e0:	4785                	li	a5,1
    800036e2:	c0bc                	sw	a5,64(s1)
    800036e4:	04449783          	lh	a5,68(s1)
    800036e8:	fbad                	bnez	a5,8000365a <ilock+0x24>
    800036ea:	00004517          	auipc	a0,0x4
    800036ee:	22e50513          	addi	a0,a0,558 # 80007918 <userret+0x888>
    800036f2:	ffffd097          	auipc	ra,0xffffd
    800036f6:	e8c080e7          	jalr	-372(ra) # 8000057e <panic>

00000000800036fa <iunlock>:
    800036fa:	1101                	addi	sp,sp,-32
    800036fc:	ec06                	sd	ra,24(sp)
    800036fe:	e822                	sd	s0,16(sp)
    80003700:	e426                	sd	s1,8(sp)
    80003702:	e04a                	sd	s2,0(sp)
    80003704:	1000                	addi	s0,sp,32
    80003706:	c905                	beqz	a0,80003736 <iunlock+0x3c>
    80003708:	84aa                	mv	s1,a0
    8000370a:	01050913          	addi	s2,a0,16
    8000370e:	854a                	mv	a0,s2
    80003710:	00001097          	auipc	ra,0x1
    80003714:	c7c080e7          	jalr	-900(ra) # 8000438c <holdingsleep>
    80003718:	cd19                	beqz	a0,80003736 <iunlock+0x3c>
    8000371a:	449c                	lw	a5,8(s1)
    8000371c:	00f05d63          	blez	a5,80003736 <iunlock+0x3c>
    80003720:	854a                	mv	a0,s2
    80003722:	00001097          	auipc	ra,0x1
    80003726:	c26080e7          	jalr	-986(ra) # 80004348 <releasesleep>
    8000372a:	60e2                	ld	ra,24(sp)
    8000372c:	6442                	ld	s0,16(sp)
    8000372e:	64a2                	ld	s1,8(sp)
    80003730:	6902                	ld	s2,0(sp)
    80003732:	6105                	addi	sp,sp,32
    80003734:	8082                	ret
    80003736:	00004517          	auipc	a0,0x4
    8000373a:	1f250513          	addi	a0,a0,498 # 80007928 <userret+0x898>
    8000373e:	ffffd097          	auipc	ra,0xffffd
    80003742:	e40080e7          	jalr	-448(ra) # 8000057e <panic>

0000000080003746 <iput>:
    80003746:	7139                	addi	sp,sp,-64
    80003748:	fc06                	sd	ra,56(sp)
    8000374a:	f822                	sd	s0,48(sp)
    8000374c:	f426                	sd	s1,40(sp)
    8000374e:	f04a                	sd	s2,32(sp)
    80003750:	ec4e                	sd	s3,24(sp)
    80003752:	e852                	sd	s4,16(sp)
    80003754:	e456                	sd	s5,8(sp)
    80003756:	0080                	addi	s0,sp,64
    80003758:	84aa                	mv	s1,a0
    8000375a:	0001c517          	auipc	a0,0x1c
    8000375e:	79650513          	addi	a0,a0,1942 # 8001fef0 <icache>
    80003762:	ffffd097          	auipc	ra,0xffffd
    80003766:	39c080e7          	jalr	924(ra) # 80000afe <acquire>
    8000376a:	4498                	lw	a4,8(s1)
    8000376c:	4785                	li	a5,1
    8000376e:	02f70663          	beq	a4,a5,8000379a <iput+0x54>
    80003772:	449c                	lw	a5,8(s1)
    80003774:	37fd                	addiw	a5,a5,-1
    80003776:	c49c                	sw	a5,8(s1)
    80003778:	0001c517          	auipc	a0,0x1c
    8000377c:	77850513          	addi	a0,a0,1912 # 8001fef0 <icache>
    80003780:	ffffd097          	auipc	ra,0xffffd
    80003784:	3d2080e7          	jalr	978(ra) # 80000b52 <release>
    80003788:	70e2                	ld	ra,56(sp)
    8000378a:	7442                	ld	s0,48(sp)
    8000378c:	74a2                	ld	s1,40(sp)
    8000378e:	7902                	ld	s2,32(sp)
    80003790:	69e2                	ld	s3,24(sp)
    80003792:	6a42                	ld	s4,16(sp)
    80003794:	6aa2                	ld	s5,8(sp)
    80003796:	6121                	addi	sp,sp,64
    80003798:	8082                	ret
    8000379a:	40bc                	lw	a5,64(s1)
    8000379c:	dbf9                	beqz	a5,80003772 <iput+0x2c>
    8000379e:	04a49783          	lh	a5,74(s1)
    800037a2:	fbe1                	bnez	a5,80003772 <iput+0x2c>
    800037a4:	01048a13          	addi	s4,s1,16
    800037a8:	8552                	mv	a0,s4
    800037aa:	00001097          	auipc	ra,0x1
    800037ae:	b48080e7          	jalr	-1208(ra) # 800042f2 <acquiresleep>
    800037b2:	0001c517          	auipc	a0,0x1c
    800037b6:	73e50513          	addi	a0,a0,1854 # 8001fef0 <icache>
    800037ba:	ffffd097          	auipc	ra,0xffffd
    800037be:	398080e7          	jalr	920(ra) # 80000b52 <release>
    800037c2:	05048913          	addi	s2,s1,80
    800037c6:	08048993          	addi	s3,s1,128
    800037ca:	a819                	j	800037e0 <iput+0x9a>
    800037cc:	4088                	lw	a0,0(s1)
    800037ce:	00000097          	auipc	ra,0x0
    800037d2:	878080e7          	jalr	-1928(ra) # 80003046 <bfree>
    800037d6:	00092023          	sw	zero,0(s2)
    800037da:	0911                	addi	s2,s2,4
    800037dc:	01390663          	beq	s2,s3,800037e8 <iput+0xa2>
    800037e0:	00092583          	lw	a1,0(s2)
    800037e4:	d9fd                	beqz	a1,800037da <iput+0x94>
    800037e6:	b7dd                	j	800037cc <iput+0x86>
    800037e8:	0804a583          	lw	a1,128(s1)
    800037ec:	ed9d                	bnez	a1,8000382a <iput+0xe4>
    800037ee:	0404a623          	sw	zero,76(s1)
    800037f2:	8526                	mv	a0,s1
    800037f4:	00000097          	auipc	ra,0x0
    800037f8:	d76080e7          	jalr	-650(ra) # 8000356a <iupdate>
    800037fc:	04049223          	sh	zero,68(s1)
    80003800:	8526                	mv	a0,s1
    80003802:	00000097          	auipc	ra,0x0
    80003806:	d68080e7          	jalr	-664(ra) # 8000356a <iupdate>
    8000380a:	0404a023          	sw	zero,64(s1)
    8000380e:	8552                	mv	a0,s4
    80003810:	00001097          	auipc	ra,0x1
    80003814:	b38080e7          	jalr	-1224(ra) # 80004348 <releasesleep>
    80003818:	0001c517          	auipc	a0,0x1c
    8000381c:	6d850513          	addi	a0,a0,1752 # 8001fef0 <icache>
    80003820:	ffffd097          	auipc	ra,0xffffd
    80003824:	2de080e7          	jalr	734(ra) # 80000afe <acquire>
    80003828:	b7a9                	j	80003772 <iput+0x2c>
    8000382a:	4088                	lw	a0,0(s1)
    8000382c:	fffff097          	auipc	ra,0xfffff
    80003830:	5c2080e7          	jalr	1474(ra) # 80002dee <bread>
    80003834:	8aaa                	mv	s5,a0
    80003836:	06050913          	addi	s2,a0,96
    8000383a:	46050993          	addi	s3,a0,1120
    8000383e:	a809                	j	80003850 <iput+0x10a>
    80003840:	4088                	lw	a0,0(s1)
    80003842:	00000097          	auipc	ra,0x0
    80003846:	804080e7          	jalr	-2044(ra) # 80003046 <bfree>
    8000384a:	0911                	addi	s2,s2,4
    8000384c:	01390663          	beq	s2,s3,80003858 <iput+0x112>
    80003850:	00092583          	lw	a1,0(s2)
    80003854:	d9fd                	beqz	a1,8000384a <iput+0x104>
    80003856:	b7ed                	j	80003840 <iput+0xfa>
    80003858:	8556                	mv	a0,s5
    8000385a:	fffff097          	auipc	ra,0xfffff
    8000385e:	6d6080e7          	jalr	1750(ra) # 80002f30 <brelse>
    80003862:	0804a583          	lw	a1,128(s1)
    80003866:	4088                	lw	a0,0(s1)
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	7de080e7          	jalr	2014(ra) # 80003046 <bfree>
    80003870:	0804a023          	sw	zero,128(s1)
    80003874:	bfad                	j	800037ee <iput+0xa8>

0000000080003876 <iunlockput>:
    80003876:	1101                	addi	sp,sp,-32
    80003878:	ec06                	sd	ra,24(sp)
    8000387a:	e822                	sd	s0,16(sp)
    8000387c:	e426                	sd	s1,8(sp)
    8000387e:	1000                	addi	s0,sp,32
    80003880:	84aa                	mv	s1,a0
    80003882:	00000097          	auipc	ra,0x0
    80003886:	e78080e7          	jalr	-392(ra) # 800036fa <iunlock>
    8000388a:	8526                	mv	a0,s1
    8000388c:	00000097          	auipc	ra,0x0
    80003890:	eba080e7          	jalr	-326(ra) # 80003746 <iput>
    80003894:	60e2                	ld	ra,24(sp)
    80003896:	6442                	ld	s0,16(sp)
    80003898:	64a2                	ld	s1,8(sp)
    8000389a:	6105                	addi	sp,sp,32
    8000389c:	8082                	ret

000000008000389e <stati>:
    8000389e:	1141                	addi	sp,sp,-16
    800038a0:	e422                	sd	s0,8(sp)
    800038a2:	0800                	addi	s0,sp,16
    800038a4:	411c                	lw	a5,0(a0)
    800038a6:	c19c                	sw	a5,0(a1)
    800038a8:	415c                	lw	a5,4(a0)
    800038aa:	c1dc                	sw	a5,4(a1)
    800038ac:	04451783          	lh	a5,68(a0)
    800038b0:	00f59423          	sh	a5,8(a1)
    800038b4:	04a51783          	lh	a5,74(a0)
    800038b8:	00f59523          	sh	a5,10(a1)
    800038bc:	04c56783          	lwu	a5,76(a0)
    800038c0:	e99c                	sd	a5,16(a1)
    800038c2:	6422                	ld	s0,8(sp)
    800038c4:	0141                	addi	sp,sp,16
    800038c6:	8082                	ret

00000000800038c8 <readi>:
    800038c8:	457c                	lw	a5,76(a0)
    800038ca:	0ed7e563          	bltu	a5,a3,800039b4 <readi+0xec>
    800038ce:	7159                	addi	sp,sp,-112
    800038d0:	f486                	sd	ra,104(sp)
    800038d2:	f0a2                	sd	s0,96(sp)
    800038d4:	eca6                	sd	s1,88(sp)
    800038d6:	e8ca                	sd	s2,80(sp)
    800038d8:	e4ce                	sd	s3,72(sp)
    800038da:	e0d2                	sd	s4,64(sp)
    800038dc:	fc56                	sd	s5,56(sp)
    800038de:	f85a                	sd	s6,48(sp)
    800038e0:	f45e                	sd	s7,40(sp)
    800038e2:	f062                	sd	s8,32(sp)
    800038e4:	ec66                	sd	s9,24(sp)
    800038e6:	e86a                	sd	s10,16(sp)
    800038e8:	e46e                	sd	s11,8(sp)
    800038ea:	1880                	addi	s0,sp,112
    800038ec:	8baa                	mv	s7,a0
    800038ee:	8c2e                	mv	s8,a1
    800038f0:	8a32                	mv	s4,a2
    800038f2:	84b6                	mv	s1,a3
    800038f4:	8b3a                	mv	s6,a4
    800038f6:	9f35                	addw	a4,a4,a3
    800038f8:	0cd76063          	bltu	a4,a3,800039b8 <readi+0xf0>
    800038fc:	00e7f463          	bleu	a4,a5,80003904 <readi+0x3c>
    80003900:	40d78b3b          	subw	s6,a5,a3
    80003904:	080b0763          	beqz	s6,80003992 <readi+0xca>
    80003908:	4981                	li	s3,0
    8000390a:	40000d13          	li	s10,1024
    8000390e:	5cfd                	li	s9,-1
    80003910:	a82d                	j	8000394a <readi+0x82>
    80003912:	02091d93          	slli	s11,s2,0x20
    80003916:	020ddd93          	srli	s11,s11,0x20
    8000391a:	060a8613          	addi	a2,s5,96
    8000391e:	86ee                	mv	a3,s11
    80003920:	963a                	add	a2,a2,a4
    80003922:	85d2                	mv	a1,s4
    80003924:	8562                	mv	a0,s8
    80003926:	fffff097          	auipc	ra,0xfffff
    8000392a:	b06080e7          	jalr	-1274(ra) # 8000242c <either_copyout>
    8000392e:	05950d63          	beq	a0,s9,80003988 <readi+0xc0>
    80003932:	8556                	mv	a0,s5
    80003934:	fffff097          	auipc	ra,0xfffff
    80003938:	5fc080e7          	jalr	1532(ra) # 80002f30 <brelse>
    8000393c:	013909bb          	addw	s3,s2,s3
    80003940:	009904bb          	addw	s1,s2,s1
    80003944:	9a6e                	add	s4,s4,s11
    80003946:	0569f663          	bleu	s6,s3,80003992 <readi+0xca>
    8000394a:	000ba903          	lw	s2,0(s7)
    8000394e:	00a4d59b          	srliw	a1,s1,0xa
    80003952:	855e                	mv	a0,s7
    80003954:	00000097          	auipc	ra,0x0
    80003958:	8d2080e7          	jalr	-1838(ra) # 80003226 <bmap>
    8000395c:	0005059b          	sext.w	a1,a0
    80003960:	854a                	mv	a0,s2
    80003962:	fffff097          	auipc	ra,0xfffff
    80003966:	48c080e7          	jalr	1164(ra) # 80002dee <bread>
    8000396a:	8aaa                	mv	s5,a0
    8000396c:	3ff4f713          	andi	a4,s1,1023
    80003970:	40ed07bb          	subw	a5,s10,a4
    80003974:	413b06bb          	subw	a3,s6,s3
    80003978:	893e                	mv	s2,a5
    8000397a:	2781                	sext.w	a5,a5
    8000397c:	0006861b          	sext.w	a2,a3
    80003980:	f8f679e3          	bleu	a5,a2,80003912 <readi+0x4a>
    80003984:	8936                	mv	s2,a3
    80003986:	b771                	j	80003912 <readi+0x4a>
    80003988:	8556                	mv	a0,s5
    8000398a:	fffff097          	auipc	ra,0xfffff
    8000398e:	5a6080e7          	jalr	1446(ra) # 80002f30 <brelse>
    80003992:	000b051b          	sext.w	a0,s6
    80003996:	70a6                	ld	ra,104(sp)
    80003998:	7406                	ld	s0,96(sp)
    8000399a:	64e6                	ld	s1,88(sp)
    8000399c:	6946                	ld	s2,80(sp)
    8000399e:	69a6                	ld	s3,72(sp)
    800039a0:	6a06                	ld	s4,64(sp)
    800039a2:	7ae2                	ld	s5,56(sp)
    800039a4:	7b42                	ld	s6,48(sp)
    800039a6:	7ba2                	ld	s7,40(sp)
    800039a8:	7c02                	ld	s8,32(sp)
    800039aa:	6ce2                	ld	s9,24(sp)
    800039ac:	6d42                	ld	s10,16(sp)
    800039ae:	6da2                	ld	s11,8(sp)
    800039b0:	6165                	addi	sp,sp,112
    800039b2:	8082                	ret
    800039b4:	557d                	li	a0,-1
    800039b6:	8082                	ret
    800039b8:	557d                	li	a0,-1
    800039ba:	bff1                	j	80003996 <readi+0xce>

00000000800039bc <writei>:
    800039bc:	457c                	lw	a5,76(a0)
    800039be:	10d7e663          	bltu	a5,a3,80003aca <writei+0x10e>
    800039c2:	7159                	addi	sp,sp,-112
    800039c4:	f486                	sd	ra,104(sp)
    800039c6:	f0a2                	sd	s0,96(sp)
    800039c8:	eca6                	sd	s1,88(sp)
    800039ca:	e8ca                	sd	s2,80(sp)
    800039cc:	e4ce                	sd	s3,72(sp)
    800039ce:	e0d2                	sd	s4,64(sp)
    800039d0:	fc56                	sd	s5,56(sp)
    800039d2:	f85a                	sd	s6,48(sp)
    800039d4:	f45e                	sd	s7,40(sp)
    800039d6:	f062                	sd	s8,32(sp)
    800039d8:	ec66                	sd	s9,24(sp)
    800039da:	e86a                	sd	s10,16(sp)
    800039dc:	e46e                	sd	s11,8(sp)
    800039de:	1880                	addi	s0,sp,112
    800039e0:	8baa                	mv	s7,a0
    800039e2:	8c2e                	mv	s8,a1
    800039e4:	8ab2                	mv	s5,a2
    800039e6:	84b6                	mv	s1,a3
    800039e8:	8b3a                	mv	s6,a4
    800039ea:	00e687bb          	addw	a5,a3,a4
    800039ee:	0ed7e063          	bltu	a5,a3,80003ace <writei+0x112>
    800039f2:	00043737          	lui	a4,0x43
    800039f6:	0cf76e63          	bltu	a4,a5,80003ad2 <writei+0x116>
    800039fa:	0a0b0763          	beqz	s6,80003aa8 <writei+0xec>
    800039fe:	4a01                	li	s4,0
    80003a00:	40000d13          	li	s10,1024
    80003a04:	5cfd                	li	s9,-1
    80003a06:	a091                	j	80003a4a <writei+0x8e>
    80003a08:	02091d93          	slli	s11,s2,0x20
    80003a0c:	020ddd93          	srli	s11,s11,0x20
    80003a10:	06098513          	addi	a0,s3,96
    80003a14:	86ee                	mv	a3,s11
    80003a16:	8656                	mv	a2,s5
    80003a18:	85e2                	mv	a1,s8
    80003a1a:	953a                	add	a0,a0,a4
    80003a1c:	fffff097          	auipc	ra,0xfffff
    80003a20:	a66080e7          	jalr	-1434(ra) # 80002482 <either_copyin>
    80003a24:	07950263          	beq	a0,s9,80003a88 <writei+0xcc>
    80003a28:	854e                	mv	a0,s3
    80003a2a:	00000097          	auipc	ra,0x0
    80003a2e:	78a080e7          	jalr	1930(ra) # 800041b4 <log_write>
    80003a32:	854e                	mv	a0,s3
    80003a34:	fffff097          	auipc	ra,0xfffff
    80003a38:	4fc080e7          	jalr	1276(ra) # 80002f30 <brelse>
    80003a3c:	01490a3b          	addw	s4,s2,s4
    80003a40:	009904bb          	addw	s1,s2,s1
    80003a44:	9aee                	add	s5,s5,s11
    80003a46:	056a7663          	bleu	s6,s4,80003a92 <writei+0xd6>
    80003a4a:	000ba903          	lw	s2,0(s7)
    80003a4e:	00a4d59b          	srliw	a1,s1,0xa
    80003a52:	855e                	mv	a0,s7
    80003a54:	fffff097          	auipc	ra,0xfffff
    80003a58:	7d2080e7          	jalr	2002(ra) # 80003226 <bmap>
    80003a5c:	0005059b          	sext.w	a1,a0
    80003a60:	854a                	mv	a0,s2
    80003a62:	fffff097          	auipc	ra,0xfffff
    80003a66:	38c080e7          	jalr	908(ra) # 80002dee <bread>
    80003a6a:	89aa                	mv	s3,a0
    80003a6c:	3ff4f713          	andi	a4,s1,1023
    80003a70:	40ed07bb          	subw	a5,s10,a4
    80003a74:	414b06bb          	subw	a3,s6,s4
    80003a78:	893e                	mv	s2,a5
    80003a7a:	2781                	sext.w	a5,a5
    80003a7c:	0006861b          	sext.w	a2,a3
    80003a80:	f8f674e3          	bleu	a5,a2,80003a08 <writei+0x4c>
    80003a84:	8936                	mv	s2,a3
    80003a86:	b749                	j	80003a08 <writei+0x4c>
    80003a88:	854e                	mv	a0,s3
    80003a8a:	fffff097          	auipc	ra,0xfffff
    80003a8e:	4a6080e7          	jalr	1190(ra) # 80002f30 <brelse>
    80003a92:	04cba783          	lw	a5,76(s7)
    80003a96:	0097f463          	bleu	s1,a5,80003a9e <writei+0xe2>
    80003a9a:	049ba623          	sw	s1,76(s7)
    80003a9e:	855e                	mv	a0,s7
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	aca080e7          	jalr	-1334(ra) # 8000356a <iupdate>
    80003aa8:	000b051b          	sext.w	a0,s6
    80003aac:	70a6                	ld	ra,104(sp)
    80003aae:	7406                	ld	s0,96(sp)
    80003ab0:	64e6                	ld	s1,88(sp)
    80003ab2:	6946                	ld	s2,80(sp)
    80003ab4:	69a6                	ld	s3,72(sp)
    80003ab6:	6a06                	ld	s4,64(sp)
    80003ab8:	7ae2                	ld	s5,56(sp)
    80003aba:	7b42                	ld	s6,48(sp)
    80003abc:	7ba2                	ld	s7,40(sp)
    80003abe:	7c02                	ld	s8,32(sp)
    80003ac0:	6ce2                	ld	s9,24(sp)
    80003ac2:	6d42                	ld	s10,16(sp)
    80003ac4:	6da2                	ld	s11,8(sp)
    80003ac6:	6165                	addi	sp,sp,112
    80003ac8:	8082                	ret
    80003aca:	557d                	li	a0,-1
    80003acc:	8082                	ret
    80003ace:	557d                	li	a0,-1
    80003ad0:	bff1                	j	80003aac <writei+0xf0>
    80003ad2:	557d                	li	a0,-1
    80003ad4:	bfe1                	j	80003aac <writei+0xf0>

0000000080003ad6 <namecmp>:
    80003ad6:	1141                	addi	sp,sp,-16
    80003ad8:	e406                	sd	ra,8(sp)
    80003ada:	e022                	sd	s0,0(sp)
    80003adc:	0800                	addi	s0,sp,16
    80003ade:	4639                	li	a2,14
    80003ae0:	ffffd097          	auipc	ra,0xffffd
    80003ae4:	1a2080e7          	jalr	418(ra) # 80000c82 <strncmp>
    80003ae8:	60a2                	ld	ra,8(sp)
    80003aea:	6402                	ld	s0,0(sp)
    80003aec:	0141                	addi	sp,sp,16
    80003aee:	8082                	ret

0000000080003af0 <dirlookup>:
    80003af0:	7139                	addi	sp,sp,-64
    80003af2:	fc06                	sd	ra,56(sp)
    80003af4:	f822                	sd	s0,48(sp)
    80003af6:	f426                	sd	s1,40(sp)
    80003af8:	f04a                	sd	s2,32(sp)
    80003afa:	ec4e                	sd	s3,24(sp)
    80003afc:	e852                	sd	s4,16(sp)
    80003afe:	0080                	addi	s0,sp,64
    80003b00:	04451703          	lh	a4,68(a0)
    80003b04:	4785                	li	a5,1
    80003b06:	00f71a63          	bne	a4,a5,80003b1a <dirlookup+0x2a>
    80003b0a:	892a                	mv	s2,a0
    80003b0c:	89ae                	mv	s3,a1
    80003b0e:	8a32                	mv	s4,a2
    80003b10:	457c                	lw	a5,76(a0)
    80003b12:	4481                	li	s1,0
    80003b14:	4501                	li	a0,0
    80003b16:	e79d                	bnez	a5,80003b44 <dirlookup+0x54>
    80003b18:	a8a5                	j	80003b90 <dirlookup+0xa0>
    80003b1a:	00004517          	auipc	a0,0x4
    80003b1e:	e1650513          	addi	a0,a0,-490 # 80007930 <userret+0x8a0>
    80003b22:	ffffd097          	auipc	ra,0xffffd
    80003b26:	a5c080e7          	jalr	-1444(ra) # 8000057e <panic>
    80003b2a:	00004517          	auipc	a0,0x4
    80003b2e:	e1e50513          	addi	a0,a0,-482 # 80007948 <userret+0x8b8>
    80003b32:	ffffd097          	auipc	ra,0xffffd
    80003b36:	a4c080e7          	jalr	-1460(ra) # 8000057e <panic>
    80003b3a:	24c1                	addiw	s1,s1,16
    80003b3c:	04c92783          	lw	a5,76(s2)
    80003b40:	04f4f763          	bleu	a5,s1,80003b8e <dirlookup+0x9e>
    80003b44:	4741                	li	a4,16
    80003b46:	86a6                	mv	a3,s1
    80003b48:	fc040613          	addi	a2,s0,-64
    80003b4c:	4581                	li	a1,0
    80003b4e:	854a                	mv	a0,s2
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	d78080e7          	jalr	-648(ra) # 800038c8 <readi>
    80003b58:	47c1                	li	a5,16
    80003b5a:	fcf518e3          	bne	a0,a5,80003b2a <dirlookup+0x3a>
    80003b5e:	fc045783          	lhu	a5,-64(s0)
    80003b62:	dfe1                	beqz	a5,80003b3a <dirlookup+0x4a>
    80003b64:	fc240593          	addi	a1,s0,-62
    80003b68:	854e                	mv	a0,s3
    80003b6a:	00000097          	auipc	ra,0x0
    80003b6e:	f6c080e7          	jalr	-148(ra) # 80003ad6 <namecmp>
    80003b72:	f561                	bnez	a0,80003b3a <dirlookup+0x4a>
    80003b74:	000a0463          	beqz	s4,80003b7c <dirlookup+0x8c>
    80003b78:	009a2023          	sw	s1,0(s4) # 2000 <_entry-0x7fffe000>
    80003b7c:	fc045583          	lhu	a1,-64(s0)
    80003b80:	00092503          	lw	a0,0(s2)
    80003b84:	fffff097          	auipc	ra,0xfffff
    80003b88:	77c080e7          	jalr	1916(ra) # 80003300 <iget>
    80003b8c:	a011                	j	80003b90 <dirlookup+0xa0>
    80003b8e:	4501                	li	a0,0
    80003b90:	70e2                	ld	ra,56(sp)
    80003b92:	7442                	ld	s0,48(sp)
    80003b94:	74a2                	ld	s1,40(sp)
    80003b96:	7902                	ld	s2,32(sp)
    80003b98:	69e2                	ld	s3,24(sp)
    80003b9a:	6a42                	ld	s4,16(sp)
    80003b9c:	6121                	addi	sp,sp,64
    80003b9e:	8082                	ret

0000000080003ba0 <namex>:
    80003ba0:	711d                	addi	sp,sp,-96
    80003ba2:	ec86                	sd	ra,88(sp)
    80003ba4:	e8a2                	sd	s0,80(sp)
    80003ba6:	e4a6                	sd	s1,72(sp)
    80003ba8:	e0ca                	sd	s2,64(sp)
    80003baa:	fc4e                	sd	s3,56(sp)
    80003bac:	f852                	sd	s4,48(sp)
    80003bae:	f456                	sd	s5,40(sp)
    80003bb0:	f05a                	sd	s6,32(sp)
    80003bb2:	ec5e                	sd	s7,24(sp)
    80003bb4:	e862                	sd	s8,16(sp)
    80003bb6:	e466                	sd	s9,8(sp)
    80003bb8:	1080                	addi	s0,sp,96
    80003bba:	84aa                	mv	s1,a0
    80003bbc:	8bae                	mv	s7,a1
    80003bbe:	8ab2                	mv	s5,a2
    80003bc0:	00054703          	lbu	a4,0(a0)
    80003bc4:	02f00793          	li	a5,47
    80003bc8:	02f70363          	beq	a4,a5,80003bee <namex+0x4e>
    80003bcc:	ffffe097          	auipc	ra,0xffffe
    80003bd0:	e52080e7          	jalr	-430(ra) # 80001a1e <myproc>
    80003bd4:	15053503          	ld	a0,336(a0)
    80003bd8:	00000097          	auipc	ra,0x0
    80003bdc:	a20080e7          	jalr	-1504(ra) # 800035f8 <idup>
    80003be0:	89aa                	mv	s3,a0
    80003be2:	02f00913          	li	s2,47
    80003be6:	4b01                	li	s6,0
    80003be8:	4cb5                	li	s9,13
    80003bea:	4c05                	li	s8,1
    80003bec:	a865                	j	80003ca4 <namex+0x104>
    80003bee:	4585                	li	a1,1
    80003bf0:	4505                	li	a0,1
    80003bf2:	fffff097          	auipc	ra,0xfffff
    80003bf6:	70e080e7          	jalr	1806(ra) # 80003300 <iget>
    80003bfa:	89aa                	mv	s3,a0
    80003bfc:	b7dd                	j	80003be2 <namex+0x42>
    80003bfe:	854e                	mv	a0,s3
    80003c00:	00000097          	auipc	ra,0x0
    80003c04:	c76080e7          	jalr	-906(ra) # 80003876 <iunlockput>
    80003c08:	4981                	li	s3,0
    80003c0a:	854e                	mv	a0,s3
    80003c0c:	60e6                	ld	ra,88(sp)
    80003c0e:	6446                	ld	s0,80(sp)
    80003c10:	64a6                	ld	s1,72(sp)
    80003c12:	6906                	ld	s2,64(sp)
    80003c14:	79e2                	ld	s3,56(sp)
    80003c16:	7a42                	ld	s4,48(sp)
    80003c18:	7aa2                	ld	s5,40(sp)
    80003c1a:	7b02                	ld	s6,32(sp)
    80003c1c:	6be2                	ld	s7,24(sp)
    80003c1e:	6c42                	ld	s8,16(sp)
    80003c20:	6ca2                	ld	s9,8(sp)
    80003c22:	6125                	addi	sp,sp,96
    80003c24:	8082                	ret
    80003c26:	854e                	mv	a0,s3
    80003c28:	00000097          	auipc	ra,0x0
    80003c2c:	ad2080e7          	jalr	-1326(ra) # 800036fa <iunlock>
    80003c30:	bfe9                	j	80003c0a <namex+0x6a>
    80003c32:	854e                	mv	a0,s3
    80003c34:	00000097          	auipc	ra,0x0
    80003c38:	c42080e7          	jalr	-958(ra) # 80003876 <iunlockput>
    80003c3c:	89d2                	mv	s3,s4
    80003c3e:	b7f1                	j	80003c0a <namex+0x6a>
    80003c40:	40b48633          	sub	a2,s1,a1
    80003c44:	00060a1b          	sext.w	s4,a2
    80003c48:	094cd663          	ble	s4,s9,80003cd4 <namex+0x134>
    80003c4c:	4639                	li	a2,14
    80003c4e:	8556                	mv	a0,s5
    80003c50:	ffffd097          	auipc	ra,0xffffd
    80003c54:	fb6080e7          	jalr	-74(ra) # 80000c06 <memmove>
    80003c58:	0004c783          	lbu	a5,0(s1)
    80003c5c:	01279763          	bne	a5,s2,80003c6a <namex+0xca>
    80003c60:	0485                	addi	s1,s1,1
    80003c62:	0004c783          	lbu	a5,0(s1)
    80003c66:	ff278de3          	beq	a5,s2,80003c60 <namex+0xc0>
    80003c6a:	854e                	mv	a0,s3
    80003c6c:	00000097          	auipc	ra,0x0
    80003c70:	9ca080e7          	jalr	-1590(ra) # 80003636 <ilock>
    80003c74:	04499783          	lh	a5,68(s3)
    80003c78:	f98793e3          	bne	a5,s8,80003bfe <namex+0x5e>
    80003c7c:	000b8563          	beqz	s7,80003c86 <namex+0xe6>
    80003c80:	0004c783          	lbu	a5,0(s1)
    80003c84:	d3cd                	beqz	a5,80003c26 <namex+0x86>
    80003c86:	865a                	mv	a2,s6
    80003c88:	85d6                	mv	a1,s5
    80003c8a:	854e                	mv	a0,s3
    80003c8c:	00000097          	auipc	ra,0x0
    80003c90:	e64080e7          	jalr	-412(ra) # 80003af0 <dirlookup>
    80003c94:	8a2a                	mv	s4,a0
    80003c96:	dd51                	beqz	a0,80003c32 <namex+0x92>
    80003c98:	854e                	mv	a0,s3
    80003c9a:	00000097          	auipc	ra,0x0
    80003c9e:	bdc080e7          	jalr	-1060(ra) # 80003876 <iunlockput>
    80003ca2:	89d2                	mv	s3,s4
    80003ca4:	0004c783          	lbu	a5,0(s1)
    80003ca8:	05279d63          	bne	a5,s2,80003d02 <namex+0x162>
    80003cac:	0485                	addi	s1,s1,1
    80003cae:	0004c783          	lbu	a5,0(s1)
    80003cb2:	ff278de3          	beq	a5,s2,80003cac <namex+0x10c>
    80003cb6:	cf8d                	beqz	a5,80003cf0 <namex+0x150>
    80003cb8:	01278b63          	beq	a5,s2,80003cce <namex+0x12e>
    80003cbc:	c795                	beqz	a5,80003ce8 <namex+0x148>
    80003cbe:	85a6                	mv	a1,s1
    80003cc0:	0485                	addi	s1,s1,1
    80003cc2:	0004c783          	lbu	a5,0(s1)
    80003cc6:	f7278de3          	beq	a5,s2,80003c40 <namex+0xa0>
    80003cca:	fbfd                	bnez	a5,80003cc0 <namex+0x120>
    80003ccc:	bf95                	j	80003c40 <namex+0xa0>
    80003cce:	85a6                	mv	a1,s1
    80003cd0:	8a5a                	mv	s4,s6
    80003cd2:	865a                	mv	a2,s6
    80003cd4:	2601                	sext.w	a2,a2
    80003cd6:	8556                	mv	a0,s5
    80003cd8:	ffffd097          	auipc	ra,0xffffd
    80003cdc:	f2e080e7          	jalr	-210(ra) # 80000c06 <memmove>
    80003ce0:	9a56                	add	s4,s4,s5
    80003ce2:	000a0023          	sb	zero,0(s4)
    80003ce6:	bf8d                	j	80003c58 <namex+0xb8>
    80003ce8:	85a6                	mv	a1,s1
    80003cea:	8a5a                	mv	s4,s6
    80003cec:	865a                	mv	a2,s6
    80003cee:	b7dd                	j	80003cd4 <namex+0x134>
    80003cf0:	f00b8de3          	beqz	s7,80003c0a <namex+0x6a>
    80003cf4:	854e                	mv	a0,s3
    80003cf6:	00000097          	auipc	ra,0x0
    80003cfa:	a50080e7          	jalr	-1456(ra) # 80003746 <iput>
    80003cfe:	4981                	li	s3,0
    80003d00:	b729                	j	80003c0a <namex+0x6a>
    80003d02:	d7fd                	beqz	a5,80003cf0 <namex+0x150>
    80003d04:	85a6                	mv	a1,s1
    80003d06:	bf6d                	j	80003cc0 <namex+0x120>

0000000080003d08 <dirlink>:
    80003d08:	7139                	addi	sp,sp,-64
    80003d0a:	fc06                	sd	ra,56(sp)
    80003d0c:	f822                	sd	s0,48(sp)
    80003d0e:	f426                	sd	s1,40(sp)
    80003d10:	f04a                	sd	s2,32(sp)
    80003d12:	ec4e                	sd	s3,24(sp)
    80003d14:	e852                	sd	s4,16(sp)
    80003d16:	0080                	addi	s0,sp,64
    80003d18:	892a                	mv	s2,a0
    80003d1a:	8a2e                	mv	s4,a1
    80003d1c:	89b2                	mv	s3,a2
    80003d1e:	4601                	li	a2,0
    80003d20:	00000097          	auipc	ra,0x0
    80003d24:	dd0080e7          	jalr	-560(ra) # 80003af0 <dirlookup>
    80003d28:	e93d                	bnez	a0,80003d9e <dirlink+0x96>
    80003d2a:	04c92483          	lw	s1,76(s2)
    80003d2e:	c49d                	beqz	s1,80003d5c <dirlink+0x54>
    80003d30:	4481                	li	s1,0
    80003d32:	4741                	li	a4,16
    80003d34:	86a6                	mv	a3,s1
    80003d36:	fc040613          	addi	a2,s0,-64
    80003d3a:	4581                	li	a1,0
    80003d3c:	854a                	mv	a0,s2
    80003d3e:	00000097          	auipc	ra,0x0
    80003d42:	b8a080e7          	jalr	-1142(ra) # 800038c8 <readi>
    80003d46:	47c1                	li	a5,16
    80003d48:	06f51163          	bne	a0,a5,80003daa <dirlink+0xa2>
    80003d4c:	fc045783          	lhu	a5,-64(s0)
    80003d50:	c791                	beqz	a5,80003d5c <dirlink+0x54>
    80003d52:	24c1                	addiw	s1,s1,16
    80003d54:	04c92783          	lw	a5,76(s2)
    80003d58:	fcf4ede3          	bltu	s1,a5,80003d32 <dirlink+0x2a>
    80003d5c:	4639                	li	a2,14
    80003d5e:	85d2                	mv	a1,s4
    80003d60:	fc240513          	addi	a0,s0,-62
    80003d64:	ffffd097          	auipc	ra,0xffffd
    80003d68:	f6e080e7          	jalr	-146(ra) # 80000cd2 <strncpy>
    80003d6c:	fd341023          	sh	s3,-64(s0)
    80003d70:	4741                	li	a4,16
    80003d72:	86a6                	mv	a3,s1
    80003d74:	fc040613          	addi	a2,s0,-64
    80003d78:	4581                	li	a1,0
    80003d7a:	854a                	mv	a0,s2
    80003d7c:	00000097          	auipc	ra,0x0
    80003d80:	c40080e7          	jalr	-960(ra) # 800039bc <writei>
    80003d84:	4741                	li	a4,16
    80003d86:	4781                	li	a5,0
    80003d88:	02e51963          	bne	a0,a4,80003dba <dirlink+0xb2>
    80003d8c:	853e                	mv	a0,a5
    80003d8e:	70e2                	ld	ra,56(sp)
    80003d90:	7442                	ld	s0,48(sp)
    80003d92:	74a2                	ld	s1,40(sp)
    80003d94:	7902                	ld	s2,32(sp)
    80003d96:	69e2                	ld	s3,24(sp)
    80003d98:	6a42                	ld	s4,16(sp)
    80003d9a:	6121                	addi	sp,sp,64
    80003d9c:	8082                	ret
    80003d9e:	00000097          	auipc	ra,0x0
    80003da2:	9a8080e7          	jalr	-1624(ra) # 80003746 <iput>
    80003da6:	57fd                	li	a5,-1
    80003da8:	b7d5                	j	80003d8c <dirlink+0x84>
    80003daa:	00004517          	auipc	a0,0x4
    80003dae:	bae50513          	addi	a0,a0,-1106 # 80007958 <userret+0x8c8>
    80003db2:	ffffc097          	auipc	ra,0xffffc
    80003db6:	7cc080e7          	jalr	1996(ra) # 8000057e <panic>
    80003dba:	00004517          	auipc	a0,0x4
    80003dbe:	cbe50513          	addi	a0,a0,-834 # 80007a78 <userret+0x9e8>
    80003dc2:	ffffc097          	auipc	ra,0xffffc
    80003dc6:	7bc080e7          	jalr	1980(ra) # 8000057e <panic>

0000000080003dca <namei>:
    80003dca:	1101                	addi	sp,sp,-32
    80003dcc:	ec06                	sd	ra,24(sp)
    80003dce:	e822                	sd	s0,16(sp)
    80003dd0:	1000                	addi	s0,sp,32
    80003dd2:	fe040613          	addi	a2,s0,-32
    80003dd6:	4581                	li	a1,0
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	dc8080e7          	jalr	-568(ra) # 80003ba0 <namex>
    80003de0:	60e2                	ld	ra,24(sp)
    80003de2:	6442                	ld	s0,16(sp)
    80003de4:	6105                	addi	sp,sp,32
    80003de6:	8082                	ret

0000000080003de8 <nameiparent>:
    80003de8:	1141                	addi	sp,sp,-16
    80003dea:	e406                	sd	ra,8(sp)
    80003dec:	e022                	sd	s0,0(sp)
    80003dee:	0800                	addi	s0,sp,16
    80003df0:	862e                	mv	a2,a1
    80003df2:	4585                	li	a1,1
    80003df4:	00000097          	auipc	ra,0x0
    80003df8:	dac080e7          	jalr	-596(ra) # 80003ba0 <namex>
    80003dfc:	60a2                	ld	ra,8(sp)
    80003dfe:	6402                	ld	s0,0(sp)
    80003e00:	0141                	addi	sp,sp,16
    80003e02:	8082                	ret

0000000080003e04 <write_head>:
    80003e04:	1101                	addi	sp,sp,-32
    80003e06:	ec06                	sd	ra,24(sp)
    80003e08:	e822                	sd	s0,16(sp)
    80003e0a:	e426                	sd	s1,8(sp)
    80003e0c:	e04a                	sd	s2,0(sp)
    80003e0e:	1000                	addi	s0,sp,32
    80003e10:	0001e917          	auipc	s2,0x1e
    80003e14:	b8890913          	addi	s2,s2,-1144 # 80021998 <log>
    80003e18:	01892583          	lw	a1,24(s2)
    80003e1c:	02892503          	lw	a0,40(s2)
    80003e20:	fffff097          	auipc	ra,0xfffff
    80003e24:	fce080e7          	jalr	-50(ra) # 80002dee <bread>
    80003e28:	84aa                	mv	s1,a0
    80003e2a:	02c92683          	lw	a3,44(s2)
    80003e2e:	d134                	sw	a3,96(a0)
    80003e30:	02d05763          	blez	a3,80003e5e <write_head+0x5a>
    80003e34:	0001e797          	auipc	a5,0x1e
    80003e38:	b9478793          	addi	a5,a5,-1132 # 800219c8 <log+0x30>
    80003e3c:	06450713          	addi	a4,a0,100
    80003e40:	36fd                	addiw	a3,a3,-1
    80003e42:	1682                	slli	a3,a3,0x20
    80003e44:	9281                	srli	a3,a3,0x20
    80003e46:	068a                	slli	a3,a3,0x2
    80003e48:	0001e617          	auipc	a2,0x1e
    80003e4c:	b8460613          	addi	a2,a2,-1148 # 800219cc <log+0x34>
    80003e50:	96b2                	add	a3,a3,a2
    80003e52:	4390                	lw	a2,0(a5)
    80003e54:	c310                	sw	a2,0(a4)
    80003e56:	0791                	addi	a5,a5,4
    80003e58:	0711                	addi	a4,a4,4
    80003e5a:	fed79ce3          	bne	a5,a3,80003e52 <write_head+0x4e>
    80003e5e:	8526                	mv	a0,s1
    80003e60:	fffff097          	auipc	ra,0xfffff
    80003e64:	092080e7          	jalr	146(ra) # 80002ef2 <bwrite>
    80003e68:	8526                	mv	a0,s1
    80003e6a:	fffff097          	auipc	ra,0xfffff
    80003e6e:	0c6080e7          	jalr	198(ra) # 80002f30 <brelse>
    80003e72:	60e2                	ld	ra,24(sp)
    80003e74:	6442                	ld	s0,16(sp)
    80003e76:	64a2                	ld	s1,8(sp)
    80003e78:	6902                	ld	s2,0(sp)
    80003e7a:	6105                	addi	sp,sp,32
    80003e7c:	8082                	ret

0000000080003e7e <install_trans>:
    80003e7e:	0001e797          	auipc	a5,0x1e
    80003e82:	b1a78793          	addi	a5,a5,-1254 # 80021998 <log>
    80003e86:	57dc                	lw	a5,44(a5)
    80003e88:	0af05663          	blez	a5,80003f34 <install_trans+0xb6>
    80003e8c:	7139                	addi	sp,sp,-64
    80003e8e:	fc06                	sd	ra,56(sp)
    80003e90:	f822                	sd	s0,48(sp)
    80003e92:	f426                	sd	s1,40(sp)
    80003e94:	f04a                	sd	s2,32(sp)
    80003e96:	ec4e                	sd	s3,24(sp)
    80003e98:	e852                	sd	s4,16(sp)
    80003e9a:	e456                	sd	s5,8(sp)
    80003e9c:	0080                	addi	s0,sp,64
    80003e9e:	0001ea17          	auipc	s4,0x1e
    80003ea2:	b2aa0a13          	addi	s4,s4,-1238 # 800219c8 <log+0x30>
    80003ea6:	4981                	li	s3,0
    80003ea8:	0001e917          	auipc	s2,0x1e
    80003eac:	af090913          	addi	s2,s2,-1296 # 80021998 <log>
    80003eb0:	01892583          	lw	a1,24(s2)
    80003eb4:	013585bb          	addw	a1,a1,s3
    80003eb8:	2585                	addiw	a1,a1,1
    80003eba:	02892503          	lw	a0,40(s2)
    80003ebe:	fffff097          	auipc	ra,0xfffff
    80003ec2:	f30080e7          	jalr	-208(ra) # 80002dee <bread>
    80003ec6:	8aaa                	mv	s5,a0
    80003ec8:	000a2583          	lw	a1,0(s4)
    80003ecc:	02892503          	lw	a0,40(s2)
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	f1e080e7          	jalr	-226(ra) # 80002dee <bread>
    80003ed8:	84aa                	mv	s1,a0
    80003eda:	40000613          	li	a2,1024
    80003ede:	060a8593          	addi	a1,s5,96
    80003ee2:	06050513          	addi	a0,a0,96
    80003ee6:	ffffd097          	auipc	ra,0xffffd
    80003eea:	d20080e7          	jalr	-736(ra) # 80000c06 <memmove>
    80003eee:	8526                	mv	a0,s1
    80003ef0:	fffff097          	auipc	ra,0xfffff
    80003ef4:	002080e7          	jalr	2(ra) # 80002ef2 <bwrite>
    80003ef8:	8526                	mv	a0,s1
    80003efa:	fffff097          	auipc	ra,0xfffff
    80003efe:	110080e7          	jalr	272(ra) # 8000300a <bunpin>
    80003f02:	8556                	mv	a0,s5
    80003f04:	fffff097          	auipc	ra,0xfffff
    80003f08:	02c080e7          	jalr	44(ra) # 80002f30 <brelse>
    80003f0c:	8526                	mv	a0,s1
    80003f0e:	fffff097          	auipc	ra,0xfffff
    80003f12:	022080e7          	jalr	34(ra) # 80002f30 <brelse>
    80003f16:	2985                	addiw	s3,s3,1
    80003f18:	0a11                	addi	s4,s4,4
    80003f1a:	02c92783          	lw	a5,44(s2)
    80003f1e:	f8f9c9e3          	blt	s3,a5,80003eb0 <install_trans+0x32>
    80003f22:	70e2                	ld	ra,56(sp)
    80003f24:	7442                	ld	s0,48(sp)
    80003f26:	74a2                	ld	s1,40(sp)
    80003f28:	7902                	ld	s2,32(sp)
    80003f2a:	69e2                	ld	s3,24(sp)
    80003f2c:	6a42                	ld	s4,16(sp)
    80003f2e:	6aa2                	ld	s5,8(sp)
    80003f30:	6121                	addi	sp,sp,64
    80003f32:	8082                	ret
    80003f34:	8082                	ret

0000000080003f36 <initlog>:
    80003f36:	7179                	addi	sp,sp,-48
    80003f38:	f406                	sd	ra,40(sp)
    80003f3a:	f022                	sd	s0,32(sp)
    80003f3c:	ec26                	sd	s1,24(sp)
    80003f3e:	e84a                	sd	s2,16(sp)
    80003f40:	e44e                	sd	s3,8(sp)
    80003f42:	1800                	addi	s0,sp,48
    80003f44:	892a                	mv	s2,a0
    80003f46:	89ae                	mv	s3,a1
    80003f48:	0001e497          	auipc	s1,0x1e
    80003f4c:	a5048493          	addi	s1,s1,-1456 # 80021998 <log>
    80003f50:	00004597          	auipc	a1,0x4
    80003f54:	a1858593          	addi	a1,a1,-1512 # 80007968 <userret+0x8d8>
    80003f58:	8526                	mv	a0,s1
    80003f5a:	ffffd097          	auipc	ra,0xffffd
    80003f5e:	a96080e7          	jalr	-1386(ra) # 800009f0 <initlock>
    80003f62:	0149a583          	lw	a1,20(s3)
    80003f66:	cc8c                	sw	a1,24(s1)
    80003f68:	0109a783          	lw	a5,16(s3)
    80003f6c:	ccdc                	sw	a5,28(s1)
    80003f6e:	0324a423          	sw	s2,40(s1)
    80003f72:	854a                	mv	a0,s2
    80003f74:	fffff097          	auipc	ra,0xfffff
    80003f78:	e7a080e7          	jalr	-390(ra) # 80002dee <bread>
    80003f7c:	513c                	lw	a5,96(a0)
    80003f7e:	d4dc                	sw	a5,44(s1)
    80003f80:	02f05563          	blez	a5,80003faa <initlog+0x74>
    80003f84:	06450713          	addi	a4,a0,100
    80003f88:	0001e697          	auipc	a3,0x1e
    80003f8c:	a4068693          	addi	a3,a3,-1472 # 800219c8 <log+0x30>
    80003f90:	37fd                	addiw	a5,a5,-1
    80003f92:	1782                	slli	a5,a5,0x20
    80003f94:	9381                	srli	a5,a5,0x20
    80003f96:	078a                	slli	a5,a5,0x2
    80003f98:	06850613          	addi	a2,a0,104
    80003f9c:	97b2                	add	a5,a5,a2
    80003f9e:	4310                	lw	a2,0(a4)
    80003fa0:	c290                	sw	a2,0(a3)
    80003fa2:	0711                	addi	a4,a4,4
    80003fa4:	0691                	addi	a3,a3,4
    80003fa6:	fef71ce3          	bne	a4,a5,80003f9e <initlog+0x68>
    80003faa:	fffff097          	auipc	ra,0xfffff
    80003fae:	f86080e7          	jalr	-122(ra) # 80002f30 <brelse>
    80003fb2:	00000097          	auipc	ra,0x0
    80003fb6:	ecc080e7          	jalr	-308(ra) # 80003e7e <install_trans>
    80003fba:	0001e797          	auipc	a5,0x1e
    80003fbe:	a007a523          	sw	zero,-1526(a5) # 800219c4 <log+0x2c>
    80003fc2:	00000097          	auipc	ra,0x0
    80003fc6:	e42080e7          	jalr	-446(ra) # 80003e04 <write_head>
    80003fca:	70a2                	ld	ra,40(sp)
    80003fcc:	7402                	ld	s0,32(sp)
    80003fce:	64e2                	ld	s1,24(sp)
    80003fd0:	6942                	ld	s2,16(sp)
    80003fd2:	69a2                	ld	s3,8(sp)
    80003fd4:	6145                	addi	sp,sp,48
    80003fd6:	8082                	ret

0000000080003fd8 <begin_op>:
    80003fd8:	1101                	addi	sp,sp,-32
    80003fda:	ec06                	sd	ra,24(sp)
    80003fdc:	e822                	sd	s0,16(sp)
    80003fde:	e426                	sd	s1,8(sp)
    80003fe0:	e04a                	sd	s2,0(sp)
    80003fe2:	1000                	addi	s0,sp,32
    80003fe4:	0001e517          	auipc	a0,0x1e
    80003fe8:	9b450513          	addi	a0,a0,-1612 # 80021998 <log>
    80003fec:	ffffd097          	auipc	ra,0xffffd
    80003ff0:	b12080e7          	jalr	-1262(ra) # 80000afe <acquire>
    80003ff4:	0001e497          	auipc	s1,0x1e
    80003ff8:	9a448493          	addi	s1,s1,-1628 # 80021998 <log>
    80003ffc:	4979                	li	s2,30
    80003ffe:	a039                	j	8000400c <begin_op+0x34>
    80004000:	85a6                	mv	a1,s1
    80004002:	8526                	mv	a0,s1
    80004004:	ffffe097          	auipc	ra,0xffffe
    80004008:	1c6080e7          	jalr	454(ra) # 800021ca <sleep>
    8000400c:	50dc                	lw	a5,36(s1)
    8000400e:	fbed                	bnez	a5,80004000 <begin_op+0x28>
    80004010:	509c                	lw	a5,32(s1)
    80004012:	0017871b          	addiw	a4,a5,1
    80004016:	0007069b          	sext.w	a3,a4
    8000401a:	0027179b          	slliw	a5,a4,0x2
    8000401e:	9fb9                	addw	a5,a5,a4
    80004020:	0017979b          	slliw	a5,a5,0x1
    80004024:	54d8                	lw	a4,44(s1)
    80004026:	9fb9                	addw	a5,a5,a4
    80004028:	00f95963          	ble	a5,s2,8000403a <begin_op+0x62>
    8000402c:	85a6                	mv	a1,s1
    8000402e:	8526                	mv	a0,s1
    80004030:	ffffe097          	auipc	ra,0xffffe
    80004034:	19a080e7          	jalr	410(ra) # 800021ca <sleep>
    80004038:	bfd1                	j	8000400c <begin_op+0x34>
    8000403a:	0001e517          	auipc	a0,0x1e
    8000403e:	95e50513          	addi	a0,a0,-1698 # 80021998 <log>
    80004042:	d114                	sw	a3,32(a0)
    80004044:	ffffd097          	auipc	ra,0xffffd
    80004048:	b0e080e7          	jalr	-1266(ra) # 80000b52 <release>
    8000404c:	60e2                	ld	ra,24(sp)
    8000404e:	6442                	ld	s0,16(sp)
    80004050:	64a2                	ld	s1,8(sp)
    80004052:	6902                	ld	s2,0(sp)
    80004054:	6105                	addi	sp,sp,32
    80004056:	8082                	ret

0000000080004058 <end_op>:
    80004058:	7139                	addi	sp,sp,-64
    8000405a:	fc06                	sd	ra,56(sp)
    8000405c:	f822                	sd	s0,48(sp)
    8000405e:	f426                	sd	s1,40(sp)
    80004060:	f04a                	sd	s2,32(sp)
    80004062:	ec4e                	sd	s3,24(sp)
    80004064:	e852                	sd	s4,16(sp)
    80004066:	e456                	sd	s5,8(sp)
    80004068:	0080                	addi	s0,sp,64
    8000406a:	0001e917          	auipc	s2,0x1e
    8000406e:	92e90913          	addi	s2,s2,-1746 # 80021998 <log>
    80004072:	854a                	mv	a0,s2
    80004074:	ffffd097          	auipc	ra,0xffffd
    80004078:	a8a080e7          	jalr	-1398(ra) # 80000afe <acquire>
    8000407c:	02092783          	lw	a5,32(s2)
    80004080:	37fd                	addiw	a5,a5,-1
    80004082:	0007849b          	sext.w	s1,a5
    80004086:	02f92023          	sw	a5,32(s2)
    8000408a:	02492783          	lw	a5,36(s2)
    8000408e:	eba1                	bnez	a5,800040de <end_op+0x86>
    80004090:	ecb9                	bnez	s1,800040ee <end_op+0x96>
    80004092:	0001e917          	auipc	s2,0x1e
    80004096:	90690913          	addi	s2,s2,-1786 # 80021998 <log>
    8000409a:	4785                	li	a5,1
    8000409c:	02f92223          	sw	a5,36(s2)
    800040a0:	854a                	mv	a0,s2
    800040a2:	ffffd097          	auipc	ra,0xffffd
    800040a6:	ab0080e7          	jalr	-1360(ra) # 80000b52 <release>
    800040aa:	02c92783          	lw	a5,44(s2)
    800040ae:	06f04763          	bgtz	a5,8000411c <end_op+0xc4>
    800040b2:	0001e497          	auipc	s1,0x1e
    800040b6:	8e648493          	addi	s1,s1,-1818 # 80021998 <log>
    800040ba:	8526                	mv	a0,s1
    800040bc:	ffffd097          	auipc	ra,0xffffd
    800040c0:	a42080e7          	jalr	-1470(ra) # 80000afe <acquire>
    800040c4:	0204a223          	sw	zero,36(s1)
    800040c8:	8526                	mv	a0,s1
    800040ca:	ffffe097          	auipc	ra,0xffffe
    800040ce:	286080e7          	jalr	646(ra) # 80002350 <wakeup>
    800040d2:	8526                	mv	a0,s1
    800040d4:	ffffd097          	auipc	ra,0xffffd
    800040d8:	a7e080e7          	jalr	-1410(ra) # 80000b52 <release>
    800040dc:	a03d                	j	8000410a <end_op+0xb2>
    800040de:	00004517          	auipc	a0,0x4
    800040e2:	89250513          	addi	a0,a0,-1902 # 80007970 <userret+0x8e0>
    800040e6:	ffffc097          	auipc	ra,0xffffc
    800040ea:	498080e7          	jalr	1176(ra) # 8000057e <panic>
    800040ee:	0001e497          	auipc	s1,0x1e
    800040f2:	8aa48493          	addi	s1,s1,-1878 # 80021998 <log>
    800040f6:	8526                	mv	a0,s1
    800040f8:	ffffe097          	auipc	ra,0xffffe
    800040fc:	258080e7          	jalr	600(ra) # 80002350 <wakeup>
    80004100:	8526                	mv	a0,s1
    80004102:	ffffd097          	auipc	ra,0xffffd
    80004106:	a50080e7          	jalr	-1456(ra) # 80000b52 <release>
    8000410a:	70e2                	ld	ra,56(sp)
    8000410c:	7442                	ld	s0,48(sp)
    8000410e:	74a2                	ld	s1,40(sp)
    80004110:	7902                	ld	s2,32(sp)
    80004112:	69e2                	ld	s3,24(sp)
    80004114:	6a42                	ld	s4,16(sp)
    80004116:	6aa2                	ld	s5,8(sp)
    80004118:	6121                	addi	sp,sp,64
    8000411a:	8082                	ret
    8000411c:	0001ea17          	auipc	s4,0x1e
    80004120:	8aca0a13          	addi	s4,s4,-1876 # 800219c8 <log+0x30>
    80004124:	0001e917          	auipc	s2,0x1e
    80004128:	87490913          	addi	s2,s2,-1932 # 80021998 <log>
    8000412c:	01892583          	lw	a1,24(s2)
    80004130:	9da5                	addw	a1,a1,s1
    80004132:	2585                	addiw	a1,a1,1
    80004134:	02892503          	lw	a0,40(s2)
    80004138:	fffff097          	auipc	ra,0xfffff
    8000413c:	cb6080e7          	jalr	-842(ra) # 80002dee <bread>
    80004140:	89aa                	mv	s3,a0
    80004142:	000a2583          	lw	a1,0(s4)
    80004146:	02892503          	lw	a0,40(s2)
    8000414a:	fffff097          	auipc	ra,0xfffff
    8000414e:	ca4080e7          	jalr	-860(ra) # 80002dee <bread>
    80004152:	8aaa                	mv	s5,a0
    80004154:	40000613          	li	a2,1024
    80004158:	06050593          	addi	a1,a0,96
    8000415c:	06098513          	addi	a0,s3,96
    80004160:	ffffd097          	auipc	ra,0xffffd
    80004164:	aa6080e7          	jalr	-1370(ra) # 80000c06 <memmove>
    80004168:	854e                	mv	a0,s3
    8000416a:	fffff097          	auipc	ra,0xfffff
    8000416e:	d88080e7          	jalr	-632(ra) # 80002ef2 <bwrite>
    80004172:	8556                	mv	a0,s5
    80004174:	fffff097          	auipc	ra,0xfffff
    80004178:	dbc080e7          	jalr	-580(ra) # 80002f30 <brelse>
    8000417c:	854e                	mv	a0,s3
    8000417e:	fffff097          	auipc	ra,0xfffff
    80004182:	db2080e7          	jalr	-590(ra) # 80002f30 <brelse>
    80004186:	2485                	addiw	s1,s1,1
    80004188:	0a11                	addi	s4,s4,4
    8000418a:	02c92783          	lw	a5,44(s2)
    8000418e:	f8f4cfe3          	blt	s1,a5,8000412c <end_op+0xd4>
    80004192:	00000097          	auipc	ra,0x0
    80004196:	c72080e7          	jalr	-910(ra) # 80003e04 <write_head>
    8000419a:	00000097          	auipc	ra,0x0
    8000419e:	ce4080e7          	jalr	-796(ra) # 80003e7e <install_trans>
    800041a2:	0001e797          	auipc	a5,0x1e
    800041a6:	8207a123          	sw	zero,-2014(a5) # 800219c4 <log+0x2c>
    800041aa:	00000097          	auipc	ra,0x0
    800041ae:	c5a080e7          	jalr	-934(ra) # 80003e04 <write_head>
    800041b2:	b701                	j	800040b2 <end_op+0x5a>

00000000800041b4 <log_write>:
    800041b4:	1101                	addi	sp,sp,-32
    800041b6:	ec06                	sd	ra,24(sp)
    800041b8:	e822                	sd	s0,16(sp)
    800041ba:	e426                	sd	s1,8(sp)
    800041bc:	e04a                	sd	s2,0(sp)
    800041be:	1000                	addi	s0,sp,32
    800041c0:	0001d797          	auipc	a5,0x1d
    800041c4:	7d878793          	addi	a5,a5,2008 # 80021998 <log>
    800041c8:	57d8                	lw	a4,44(a5)
    800041ca:	47f5                	li	a5,29
    800041cc:	08e7c563          	blt	a5,a4,80004256 <log_write+0xa2>
    800041d0:	892a                	mv	s2,a0
    800041d2:	0001d797          	auipc	a5,0x1d
    800041d6:	7c678793          	addi	a5,a5,1990 # 80021998 <log>
    800041da:	4fdc                	lw	a5,28(a5)
    800041dc:	37fd                	addiw	a5,a5,-1
    800041de:	06f75c63          	ble	a5,a4,80004256 <log_write+0xa2>
    800041e2:	0001d797          	auipc	a5,0x1d
    800041e6:	7b678793          	addi	a5,a5,1974 # 80021998 <log>
    800041ea:	539c                	lw	a5,32(a5)
    800041ec:	06f05d63          	blez	a5,80004266 <log_write+0xb2>
    800041f0:	0001d497          	auipc	s1,0x1d
    800041f4:	7a848493          	addi	s1,s1,1960 # 80021998 <log>
    800041f8:	8526                	mv	a0,s1
    800041fa:	ffffd097          	auipc	ra,0xffffd
    800041fe:	904080e7          	jalr	-1788(ra) # 80000afe <acquire>
    80004202:	54d0                	lw	a2,44(s1)
    80004204:	0ac05063          	blez	a2,800042a4 <log_write+0xf0>
    80004208:	00c92583          	lw	a1,12(s2)
    8000420c:	589c                	lw	a5,48(s1)
    8000420e:	0ab78363          	beq	a5,a1,800042b4 <log_write+0x100>
    80004212:	0001d717          	auipc	a4,0x1d
    80004216:	7ba70713          	addi	a4,a4,1978 # 800219cc <log+0x34>
    8000421a:	4781                	li	a5,0
    8000421c:	2785                	addiw	a5,a5,1
    8000421e:	04c78c63          	beq	a5,a2,80004276 <log_write+0xc2>
    80004222:	4314                	lw	a3,0(a4)
    80004224:	0711                	addi	a4,a4,4
    80004226:	feb69be3          	bne	a3,a1,8000421c <log_write+0x68>
    8000422a:	07a1                	addi	a5,a5,8
    8000422c:	078a                	slli	a5,a5,0x2
    8000422e:	0001d717          	auipc	a4,0x1d
    80004232:	76a70713          	addi	a4,a4,1898 # 80021998 <log>
    80004236:	97ba                	add	a5,a5,a4
    80004238:	cb8c                	sw	a1,16(a5)
    8000423a:	0001d517          	auipc	a0,0x1d
    8000423e:	75e50513          	addi	a0,a0,1886 # 80021998 <log>
    80004242:	ffffd097          	auipc	ra,0xffffd
    80004246:	910080e7          	jalr	-1776(ra) # 80000b52 <release>
    8000424a:	60e2                	ld	ra,24(sp)
    8000424c:	6442                	ld	s0,16(sp)
    8000424e:	64a2                	ld	s1,8(sp)
    80004250:	6902                	ld	s2,0(sp)
    80004252:	6105                	addi	sp,sp,32
    80004254:	8082                	ret
    80004256:	00003517          	auipc	a0,0x3
    8000425a:	72a50513          	addi	a0,a0,1834 # 80007980 <userret+0x8f0>
    8000425e:	ffffc097          	auipc	ra,0xffffc
    80004262:	320080e7          	jalr	800(ra) # 8000057e <panic>
    80004266:	00003517          	auipc	a0,0x3
    8000426a:	73250513          	addi	a0,a0,1842 # 80007998 <userret+0x908>
    8000426e:	ffffc097          	auipc	ra,0xffffc
    80004272:	310080e7          	jalr	784(ra) # 8000057e <panic>
    80004276:	0621                	addi	a2,a2,8
    80004278:	060a                	slli	a2,a2,0x2
    8000427a:	0001d797          	auipc	a5,0x1d
    8000427e:	71e78793          	addi	a5,a5,1822 # 80021998 <log>
    80004282:	963e                	add	a2,a2,a5
    80004284:	00c92783          	lw	a5,12(s2)
    80004288:	ca1c                	sw	a5,16(a2)
    8000428a:	854a                	mv	a0,s2
    8000428c:	fffff097          	auipc	ra,0xfffff
    80004290:	d42080e7          	jalr	-702(ra) # 80002fce <bpin>
    80004294:	0001d717          	auipc	a4,0x1d
    80004298:	70470713          	addi	a4,a4,1796 # 80021998 <log>
    8000429c:	575c                	lw	a5,44(a4)
    8000429e:	2785                	addiw	a5,a5,1
    800042a0:	d75c                	sw	a5,44(a4)
    800042a2:	bf61                	j	8000423a <log_write+0x86>
    800042a4:	00c92783          	lw	a5,12(s2)
    800042a8:	0001d717          	auipc	a4,0x1d
    800042ac:	72f72023          	sw	a5,1824(a4) # 800219c8 <log+0x30>
    800042b0:	f649                	bnez	a2,8000423a <log_write+0x86>
    800042b2:	bfe1                	j	8000428a <log_write+0xd6>
    800042b4:	4781                	li	a5,0
    800042b6:	bf95                	j	8000422a <log_write+0x76>

00000000800042b8 <initsleeplock>:
    800042b8:	1101                	addi	sp,sp,-32
    800042ba:	ec06                	sd	ra,24(sp)
    800042bc:	e822                	sd	s0,16(sp)
    800042be:	e426                	sd	s1,8(sp)
    800042c0:	e04a                	sd	s2,0(sp)
    800042c2:	1000                	addi	s0,sp,32
    800042c4:	84aa                	mv	s1,a0
    800042c6:	892e                	mv	s2,a1
    800042c8:	00003597          	auipc	a1,0x3
    800042cc:	6f058593          	addi	a1,a1,1776 # 800079b8 <userret+0x928>
    800042d0:	0521                	addi	a0,a0,8
    800042d2:	ffffc097          	auipc	ra,0xffffc
    800042d6:	71e080e7          	jalr	1822(ra) # 800009f0 <initlock>
    800042da:	0324b023          	sd	s2,32(s1)
    800042de:	0004a023          	sw	zero,0(s1)
    800042e2:	0204a423          	sw	zero,40(s1)
    800042e6:	60e2                	ld	ra,24(sp)
    800042e8:	6442                	ld	s0,16(sp)
    800042ea:	64a2                	ld	s1,8(sp)
    800042ec:	6902                	ld	s2,0(sp)
    800042ee:	6105                	addi	sp,sp,32
    800042f0:	8082                	ret

00000000800042f2 <acquiresleep>:
    800042f2:	1101                	addi	sp,sp,-32
    800042f4:	ec06                	sd	ra,24(sp)
    800042f6:	e822                	sd	s0,16(sp)
    800042f8:	e426                	sd	s1,8(sp)
    800042fa:	e04a                	sd	s2,0(sp)
    800042fc:	1000                	addi	s0,sp,32
    800042fe:	84aa                	mv	s1,a0
    80004300:	00850913          	addi	s2,a0,8
    80004304:	854a                	mv	a0,s2
    80004306:	ffffc097          	auipc	ra,0xffffc
    8000430a:	7f8080e7          	jalr	2040(ra) # 80000afe <acquire>
    8000430e:	409c                	lw	a5,0(s1)
    80004310:	cb89                	beqz	a5,80004322 <acquiresleep+0x30>
    80004312:	85ca                	mv	a1,s2
    80004314:	8526                	mv	a0,s1
    80004316:	ffffe097          	auipc	ra,0xffffe
    8000431a:	eb4080e7          	jalr	-332(ra) # 800021ca <sleep>
    8000431e:	409c                	lw	a5,0(s1)
    80004320:	fbed                	bnez	a5,80004312 <acquiresleep+0x20>
    80004322:	4785                	li	a5,1
    80004324:	c09c                	sw	a5,0(s1)
    80004326:	ffffd097          	auipc	ra,0xffffd
    8000432a:	6f8080e7          	jalr	1784(ra) # 80001a1e <myproc>
    8000432e:	5d1c                	lw	a5,56(a0)
    80004330:	d49c                	sw	a5,40(s1)
    80004332:	854a                	mv	a0,s2
    80004334:	ffffd097          	auipc	ra,0xffffd
    80004338:	81e080e7          	jalr	-2018(ra) # 80000b52 <release>
    8000433c:	60e2                	ld	ra,24(sp)
    8000433e:	6442                	ld	s0,16(sp)
    80004340:	64a2                	ld	s1,8(sp)
    80004342:	6902                	ld	s2,0(sp)
    80004344:	6105                	addi	sp,sp,32
    80004346:	8082                	ret

0000000080004348 <releasesleep>:
    80004348:	1101                	addi	sp,sp,-32
    8000434a:	ec06                	sd	ra,24(sp)
    8000434c:	e822                	sd	s0,16(sp)
    8000434e:	e426                	sd	s1,8(sp)
    80004350:	e04a                	sd	s2,0(sp)
    80004352:	1000                	addi	s0,sp,32
    80004354:	84aa                	mv	s1,a0
    80004356:	00850913          	addi	s2,a0,8
    8000435a:	854a                	mv	a0,s2
    8000435c:	ffffc097          	auipc	ra,0xffffc
    80004360:	7a2080e7          	jalr	1954(ra) # 80000afe <acquire>
    80004364:	0004a023          	sw	zero,0(s1)
    80004368:	0204a423          	sw	zero,40(s1)
    8000436c:	8526                	mv	a0,s1
    8000436e:	ffffe097          	auipc	ra,0xffffe
    80004372:	fe2080e7          	jalr	-30(ra) # 80002350 <wakeup>
    80004376:	854a                	mv	a0,s2
    80004378:	ffffc097          	auipc	ra,0xffffc
    8000437c:	7da080e7          	jalr	2010(ra) # 80000b52 <release>
    80004380:	60e2                	ld	ra,24(sp)
    80004382:	6442                	ld	s0,16(sp)
    80004384:	64a2                	ld	s1,8(sp)
    80004386:	6902                	ld	s2,0(sp)
    80004388:	6105                	addi	sp,sp,32
    8000438a:	8082                	ret

000000008000438c <holdingsleep>:
    8000438c:	7179                	addi	sp,sp,-48
    8000438e:	f406                	sd	ra,40(sp)
    80004390:	f022                	sd	s0,32(sp)
    80004392:	ec26                	sd	s1,24(sp)
    80004394:	e84a                	sd	s2,16(sp)
    80004396:	e44e                	sd	s3,8(sp)
    80004398:	1800                	addi	s0,sp,48
    8000439a:	84aa                	mv	s1,a0
    8000439c:	00850913          	addi	s2,a0,8
    800043a0:	854a                	mv	a0,s2
    800043a2:	ffffc097          	auipc	ra,0xffffc
    800043a6:	75c080e7          	jalr	1884(ra) # 80000afe <acquire>
    800043aa:	409c                	lw	a5,0(s1)
    800043ac:	ef99                	bnez	a5,800043ca <holdingsleep+0x3e>
    800043ae:	4481                	li	s1,0
    800043b0:	854a                	mv	a0,s2
    800043b2:	ffffc097          	auipc	ra,0xffffc
    800043b6:	7a0080e7          	jalr	1952(ra) # 80000b52 <release>
    800043ba:	8526                	mv	a0,s1
    800043bc:	70a2                	ld	ra,40(sp)
    800043be:	7402                	ld	s0,32(sp)
    800043c0:	64e2                	ld	s1,24(sp)
    800043c2:	6942                	ld	s2,16(sp)
    800043c4:	69a2                	ld	s3,8(sp)
    800043c6:	6145                	addi	sp,sp,48
    800043c8:	8082                	ret
    800043ca:	0284a983          	lw	s3,40(s1)
    800043ce:	ffffd097          	auipc	ra,0xffffd
    800043d2:	650080e7          	jalr	1616(ra) # 80001a1e <myproc>
    800043d6:	5d04                	lw	s1,56(a0)
    800043d8:	413484b3          	sub	s1,s1,s3
    800043dc:	0014b493          	seqz	s1,s1
    800043e0:	bfc1                	j	800043b0 <holdingsleep+0x24>

00000000800043e2 <fileinit>:
    800043e2:	1141                	addi	sp,sp,-16
    800043e4:	e406                	sd	ra,8(sp)
    800043e6:	e022                	sd	s0,0(sp)
    800043e8:	0800                	addi	s0,sp,16
    800043ea:	00003597          	auipc	a1,0x3
    800043ee:	5de58593          	addi	a1,a1,1502 # 800079c8 <userret+0x938>
    800043f2:	0001d517          	auipc	a0,0x1d
    800043f6:	6ee50513          	addi	a0,a0,1774 # 80021ae0 <ftable>
    800043fa:	ffffc097          	auipc	ra,0xffffc
    800043fe:	5f6080e7          	jalr	1526(ra) # 800009f0 <initlock>
    80004402:	60a2                	ld	ra,8(sp)
    80004404:	6402                	ld	s0,0(sp)
    80004406:	0141                	addi	sp,sp,16
    80004408:	8082                	ret

000000008000440a <filealloc>:
    8000440a:	1101                	addi	sp,sp,-32
    8000440c:	ec06                	sd	ra,24(sp)
    8000440e:	e822                	sd	s0,16(sp)
    80004410:	e426                	sd	s1,8(sp)
    80004412:	1000                	addi	s0,sp,32
    80004414:	0001d517          	auipc	a0,0x1d
    80004418:	6cc50513          	addi	a0,a0,1740 # 80021ae0 <ftable>
    8000441c:	ffffc097          	auipc	ra,0xffffc
    80004420:	6e2080e7          	jalr	1762(ra) # 80000afe <acquire>
    80004424:	0001d797          	auipc	a5,0x1d
    80004428:	6bc78793          	addi	a5,a5,1724 # 80021ae0 <ftable>
    8000442c:	4fdc                	lw	a5,28(a5)
    8000442e:	cb8d                	beqz	a5,80004460 <filealloc+0x56>
    80004430:	0001d497          	auipc	s1,0x1d
    80004434:	6f048493          	addi	s1,s1,1776 # 80021b20 <ftable+0x40>
    80004438:	0001e717          	auipc	a4,0x1e
    8000443c:	66070713          	addi	a4,a4,1632 # 80022a98 <ftable+0xfb8>
    80004440:	40dc                	lw	a5,4(s1)
    80004442:	c39d                	beqz	a5,80004468 <filealloc+0x5e>
    80004444:	02848493          	addi	s1,s1,40
    80004448:	fee49ce3          	bne	s1,a4,80004440 <filealloc+0x36>
    8000444c:	0001d517          	auipc	a0,0x1d
    80004450:	69450513          	addi	a0,a0,1684 # 80021ae0 <ftable>
    80004454:	ffffc097          	auipc	ra,0xffffc
    80004458:	6fe080e7          	jalr	1790(ra) # 80000b52 <release>
    8000445c:	4481                	li	s1,0
    8000445e:	a839                	j	8000447c <filealloc+0x72>
    80004460:	0001d497          	auipc	s1,0x1d
    80004464:	69848493          	addi	s1,s1,1688 # 80021af8 <ftable+0x18>
    80004468:	4785                	li	a5,1
    8000446a:	c0dc                	sw	a5,4(s1)
    8000446c:	0001d517          	auipc	a0,0x1d
    80004470:	67450513          	addi	a0,a0,1652 # 80021ae0 <ftable>
    80004474:	ffffc097          	auipc	ra,0xffffc
    80004478:	6de080e7          	jalr	1758(ra) # 80000b52 <release>
    8000447c:	8526                	mv	a0,s1
    8000447e:	60e2                	ld	ra,24(sp)
    80004480:	6442                	ld	s0,16(sp)
    80004482:	64a2                	ld	s1,8(sp)
    80004484:	6105                	addi	sp,sp,32
    80004486:	8082                	ret

0000000080004488 <filedup>:
    80004488:	1101                	addi	sp,sp,-32
    8000448a:	ec06                	sd	ra,24(sp)
    8000448c:	e822                	sd	s0,16(sp)
    8000448e:	e426                	sd	s1,8(sp)
    80004490:	1000                	addi	s0,sp,32
    80004492:	84aa                	mv	s1,a0
    80004494:	0001d517          	auipc	a0,0x1d
    80004498:	64c50513          	addi	a0,a0,1612 # 80021ae0 <ftable>
    8000449c:	ffffc097          	auipc	ra,0xffffc
    800044a0:	662080e7          	jalr	1634(ra) # 80000afe <acquire>
    800044a4:	40dc                	lw	a5,4(s1)
    800044a6:	02f05263          	blez	a5,800044ca <filedup+0x42>
    800044aa:	2785                	addiw	a5,a5,1
    800044ac:	c0dc                	sw	a5,4(s1)
    800044ae:	0001d517          	auipc	a0,0x1d
    800044b2:	63250513          	addi	a0,a0,1586 # 80021ae0 <ftable>
    800044b6:	ffffc097          	auipc	ra,0xffffc
    800044ba:	69c080e7          	jalr	1692(ra) # 80000b52 <release>
    800044be:	8526                	mv	a0,s1
    800044c0:	60e2                	ld	ra,24(sp)
    800044c2:	6442                	ld	s0,16(sp)
    800044c4:	64a2                	ld	s1,8(sp)
    800044c6:	6105                	addi	sp,sp,32
    800044c8:	8082                	ret
    800044ca:	00003517          	auipc	a0,0x3
    800044ce:	50650513          	addi	a0,a0,1286 # 800079d0 <userret+0x940>
    800044d2:	ffffc097          	auipc	ra,0xffffc
    800044d6:	0ac080e7          	jalr	172(ra) # 8000057e <panic>

00000000800044da <fileclose>:
    800044da:	7139                	addi	sp,sp,-64
    800044dc:	fc06                	sd	ra,56(sp)
    800044de:	f822                	sd	s0,48(sp)
    800044e0:	f426                	sd	s1,40(sp)
    800044e2:	f04a                	sd	s2,32(sp)
    800044e4:	ec4e                	sd	s3,24(sp)
    800044e6:	e852                	sd	s4,16(sp)
    800044e8:	e456                	sd	s5,8(sp)
    800044ea:	0080                	addi	s0,sp,64
    800044ec:	84aa                	mv	s1,a0
    800044ee:	0001d517          	auipc	a0,0x1d
    800044f2:	5f250513          	addi	a0,a0,1522 # 80021ae0 <ftable>
    800044f6:	ffffc097          	auipc	ra,0xffffc
    800044fa:	608080e7          	jalr	1544(ra) # 80000afe <acquire>
    800044fe:	40dc                	lw	a5,4(s1)
    80004500:	06f05163          	blez	a5,80004562 <fileclose+0x88>
    80004504:	37fd                	addiw	a5,a5,-1
    80004506:	0007871b          	sext.w	a4,a5
    8000450a:	c0dc                	sw	a5,4(s1)
    8000450c:	06e04363          	bgtz	a4,80004572 <fileclose+0x98>
    80004510:	0004a903          	lw	s2,0(s1)
    80004514:	0094ca83          	lbu	s5,9(s1)
    80004518:	0104ba03          	ld	s4,16(s1)
    8000451c:	0184b983          	ld	s3,24(s1)
    80004520:	0004a223          	sw	zero,4(s1)
    80004524:	0004a023          	sw	zero,0(s1)
    80004528:	0001d517          	auipc	a0,0x1d
    8000452c:	5b850513          	addi	a0,a0,1464 # 80021ae0 <ftable>
    80004530:	ffffc097          	auipc	ra,0xffffc
    80004534:	622080e7          	jalr	1570(ra) # 80000b52 <release>
    80004538:	4785                	li	a5,1
    8000453a:	04f90d63          	beq	s2,a5,80004594 <fileclose+0xba>
    8000453e:	3979                	addiw	s2,s2,-2
    80004540:	4785                	li	a5,1
    80004542:	0527e063          	bltu	a5,s2,80004582 <fileclose+0xa8>
    80004546:	00000097          	auipc	ra,0x0
    8000454a:	a92080e7          	jalr	-1390(ra) # 80003fd8 <begin_op>
    8000454e:	854e                	mv	a0,s3
    80004550:	fffff097          	auipc	ra,0xfffff
    80004554:	1f6080e7          	jalr	502(ra) # 80003746 <iput>
    80004558:	00000097          	auipc	ra,0x0
    8000455c:	b00080e7          	jalr	-1280(ra) # 80004058 <end_op>
    80004560:	a00d                	j	80004582 <fileclose+0xa8>
    80004562:	00003517          	auipc	a0,0x3
    80004566:	47650513          	addi	a0,a0,1142 # 800079d8 <userret+0x948>
    8000456a:	ffffc097          	auipc	ra,0xffffc
    8000456e:	014080e7          	jalr	20(ra) # 8000057e <panic>
    80004572:	0001d517          	auipc	a0,0x1d
    80004576:	56e50513          	addi	a0,a0,1390 # 80021ae0 <ftable>
    8000457a:	ffffc097          	auipc	ra,0xffffc
    8000457e:	5d8080e7          	jalr	1496(ra) # 80000b52 <release>
    80004582:	70e2                	ld	ra,56(sp)
    80004584:	7442                	ld	s0,48(sp)
    80004586:	74a2                	ld	s1,40(sp)
    80004588:	7902                	ld	s2,32(sp)
    8000458a:	69e2                	ld	s3,24(sp)
    8000458c:	6a42                	ld	s4,16(sp)
    8000458e:	6aa2                	ld	s5,8(sp)
    80004590:	6121                	addi	sp,sp,64
    80004592:	8082                	ret
    80004594:	85d6                	mv	a1,s5
    80004596:	8552                	mv	a0,s4
    80004598:	00000097          	auipc	ra,0x0
    8000459c:	364080e7          	jalr	868(ra) # 800048fc <pipeclose>
    800045a0:	b7cd                	j	80004582 <fileclose+0xa8>

00000000800045a2 <filestat>:
    800045a2:	715d                	addi	sp,sp,-80
    800045a4:	e486                	sd	ra,72(sp)
    800045a6:	e0a2                	sd	s0,64(sp)
    800045a8:	fc26                	sd	s1,56(sp)
    800045aa:	f84a                	sd	s2,48(sp)
    800045ac:	f44e                	sd	s3,40(sp)
    800045ae:	0880                	addi	s0,sp,80
    800045b0:	84aa                	mv	s1,a0
    800045b2:	89ae                	mv	s3,a1
    800045b4:	ffffd097          	auipc	ra,0xffffd
    800045b8:	46a080e7          	jalr	1130(ra) # 80001a1e <myproc>
    800045bc:	409c                	lw	a5,0(s1)
    800045be:	37f9                	addiw	a5,a5,-2
    800045c0:	4705                	li	a4,1
    800045c2:	04f76763          	bltu	a4,a5,80004610 <filestat+0x6e>
    800045c6:	892a                	mv	s2,a0
    800045c8:	6c88                	ld	a0,24(s1)
    800045ca:	fffff097          	auipc	ra,0xfffff
    800045ce:	06c080e7          	jalr	108(ra) # 80003636 <ilock>
    800045d2:	fb840593          	addi	a1,s0,-72
    800045d6:	6c88                	ld	a0,24(s1)
    800045d8:	fffff097          	auipc	ra,0xfffff
    800045dc:	2c6080e7          	jalr	710(ra) # 8000389e <stati>
    800045e0:	6c88                	ld	a0,24(s1)
    800045e2:	fffff097          	auipc	ra,0xfffff
    800045e6:	118080e7          	jalr	280(ra) # 800036fa <iunlock>
    800045ea:	46e1                	li	a3,24
    800045ec:	fb840613          	addi	a2,s0,-72
    800045f0:	85ce                	mv	a1,s3
    800045f2:	05093503          	ld	a0,80(s2)
    800045f6:	ffffd097          	auipc	ra,0xffffd
    800045fa:	104080e7          	jalr	260(ra) # 800016fa <copyout>
    800045fe:	41f5551b          	sraiw	a0,a0,0x1f
    80004602:	60a6                	ld	ra,72(sp)
    80004604:	6406                	ld	s0,64(sp)
    80004606:	74e2                	ld	s1,56(sp)
    80004608:	7942                	ld	s2,48(sp)
    8000460a:	79a2                	ld	s3,40(sp)
    8000460c:	6161                	addi	sp,sp,80
    8000460e:	8082                	ret
    80004610:	557d                	li	a0,-1
    80004612:	bfc5                	j	80004602 <filestat+0x60>

0000000080004614 <fileread>:
    80004614:	7179                	addi	sp,sp,-48
    80004616:	f406                	sd	ra,40(sp)
    80004618:	f022                	sd	s0,32(sp)
    8000461a:	ec26                	sd	s1,24(sp)
    8000461c:	e84a                	sd	s2,16(sp)
    8000461e:	e44e                	sd	s3,8(sp)
    80004620:	1800                	addi	s0,sp,48
    80004622:	00854783          	lbu	a5,8(a0)
    80004626:	c3d5                	beqz	a5,800046ca <fileread+0xb6>
    80004628:	89b2                	mv	s3,a2
    8000462a:	892e                	mv	s2,a1
    8000462c:	84aa                	mv	s1,a0
    8000462e:	411c                	lw	a5,0(a0)
    80004630:	4705                	li	a4,1
    80004632:	04e78963          	beq	a5,a4,80004684 <fileread+0x70>
    80004636:	470d                	li	a4,3
    80004638:	04e78d63          	beq	a5,a4,80004692 <fileread+0x7e>
    8000463c:	4709                	li	a4,2
    8000463e:	06e79e63          	bne	a5,a4,800046ba <fileread+0xa6>
    80004642:	6d08                	ld	a0,24(a0)
    80004644:	fffff097          	auipc	ra,0xfffff
    80004648:	ff2080e7          	jalr	-14(ra) # 80003636 <ilock>
    8000464c:	874e                	mv	a4,s3
    8000464e:	5094                	lw	a3,32(s1)
    80004650:	864a                	mv	a2,s2
    80004652:	4585                	li	a1,1
    80004654:	6c88                	ld	a0,24(s1)
    80004656:	fffff097          	auipc	ra,0xfffff
    8000465a:	272080e7          	jalr	626(ra) # 800038c8 <readi>
    8000465e:	892a                	mv	s2,a0
    80004660:	00a05563          	blez	a0,8000466a <fileread+0x56>
    80004664:	509c                	lw	a5,32(s1)
    80004666:	9fa9                	addw	a5,a5,a0
    80004668:	d09c                	sw	a5,32(s1)
    8000466a:	6c88                	ld	a0,24(s1)
    8000466c:	fffff097          	auipc	ra,0xfffff
    80004670:	08e080e7          	jalr	142(ra) # 800036fa <iunlock>
    80004674:	854a                	mv	a0,s2
    80004676:	70a2                	ld	ra,40(sp)
    80004678:	7402                	ld	s0,32(sp)
    8000467a:	64e2                	ld	s1,24(sp)
    8000467c:	6942                	ld	s2,16(sp)
    8000467e:	69a2                	ld	s3,8(sp)
    80004680:	6145                	addi	sp,sp,48
    80004682:	8082                	ret
    80004684:	6908                	ld	a0,16(a0)
    80004686:	00000097          	auipc	ra,0x0
    8000468a:	400080e7          	jalr	1024(ra) # 80004a86 <piperead>
    8000468e:	892a                	mv	s2,a0
    80004690:	b7d5                	j	80004674 <fileread+0x60>
    80004692:	02451783          	lh	a5,36(a0)
    80004696:	03079693          	slli	a3,a5,0x30
    8000469a:	92c1                	srli	a3,a3,0x30
    8000469c:	4725                	li	a4,9
    8000469e:	02d76863          	bltu	a4,a3,800046ce <fileread+0xba>
    800046a2:	0792                	slli	a5,a5,0x4
    800046a4:	0001d717          	auipc	a4,0x1d
    800046a8:	39c70713          	addi	a4,a4,924 # 80021a40 <devsw>
    800046ac:	97ba                	add	a5,a5,a4
    800046ae:	639c                	ld	a5,0(a5)
    800046b0:	c38d                	beqz	a5,800046d2 <fileread+0xbe>
    800046b2:	4505                	li	a0,1
    800046b4:	9782                	jalr	a5
    800046b6:	892a                	mv	s2,a0
    800046b8:	bf75                	j	80004674 <fileread+0x60>
    800046ba:	00003517          	auipc	a0,0x3
    800046be:	32e50513          	addi	a0,a0,814 # 800079e8 <userret+0x958>
    800046c2:	ffffc097          	auipc	ra,0xffffc
    800046c6:	ebc080e7          	jalr	-324(ra) # 8000057e <panic>
    800046ca:	597d                	li	s2,-1
    800046cc:	b765                	j	80004674 <fileread+0x60>
    800046ce:	597d                	li	s2,-1
    800046d0:	b755                	j	80004674 <fileread+0x60>
    800046d2:	597d                	li	s2,-1
    800046d4:	b745                	j	80004674 <fileread+0x60>

00000000800046d6 <filewrite>:
    800046d6:	00954783          	lbu	a5,9(a0)
    800046da:	12078e63          	beqz	a5,80004816 <filewrite+0x140>
    800046de:	715d                	addi	sp,sp,-80
    800046e0:	e486                	sd	ra,72(sp)
    800046e2:	e0a2                	sd	s0,64(sp)
    800046e4:	fc26                	sd	s1,56(sp)
    800046e6:	f84a                	sd	s2,48(sp)
    800046e8:	f44e                	sd	s3,40(sp)
    800046ea:	f052                	sd	s4,32(sp)
    800046ec:	ec56                	sd	s5,24(sp)
    800046ee:	e85a                	sd	s6,16(sp)
    800046f0:	e45e                	sd	s7,8(sp)
    800046f2:	e062                	sd	s8,0(sp)
    800046f4:	0880                	addi	s0,sp,80
    800046f6:	8ab2                	mv	s5,a2
    800046f8:	8b2e                	mv	s6,a1
    800046fa:	84aa                	mv	s1,a0
    800046fc:	411c                	lw	a5,0(a0)
    800046fe:	4705                	li	a4,1
    80004700:	02e78263          	beq	a5,a4,80004724 <filewrite+0x4e>
    80004704:	470d                	li	a4,3
    80004706:	02e78563          	beq	a5,a4,80004730 <filewrite+0x5a>
    8000470a:	4709                	li	a4,2
    8000470c:	0ee79d63          	bne	a5,a4,80004806 <filewrite+0x130>
    80004710:	0ec05763          	blez	a2,800047fe <filewrite+0x128>
    80004714:	4901                	li	s2,0
    80004716:	6b85                	lui	s7,0x1
    80004718:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    8000471c:	6c05                	lui	s8,0x1
    8000471e:	c00c0c1b          	addiw	s8,s8,-1024
    80004722:	a061                	j	800047aa <filewrite+0xd4>
    80004724:	6908                	ld	a0,16(a0)
    80004726:	00000097          	auipc	ra,0x0
    8000472a:	246080e7          	jalr	582(ra) # 8000496c <pipewrite>
    8000472e:	a065                	j	800047d6 <filewrite+0x100>
    80004730:	02451783          	lh	a5,36(a0)
    80004734:	03079693          	slli	a3,a5,0x30
    80004738:	92c1                	srli	a3,a3,0x30
    8000473a:	4725                	li	a4,9
    8000473c:	0cd76f63          	bltu	a4,a3,8000481a <filewrite+0x144>
    80004740:	0792                	slli	a5,a5,0x4
    80004742:	0001d717          	auipc	a4,0x1d
    80004746:	2fe70713          	addi	a4,a4,766 # 80021a40 <devsw>
    8000474a:	97ba                	add	a5,a5,a4
    8000474c:	679c                	ld	a5,8(a5)
    8000474e:	cbe1                	beqz	a5,8000481e <filewrite+0x148>
    80004750:	4505                	li	a0,1
    80004752:	9782                	jalr	a5
    80004754:	a049                	j	800047d6 <filewrite+0x100>
    80004756:	00098a1b          	sext.w	s4,s3
    8000475a:	00000097          	auipc	ra,0x0
    8000475e:	87e080e7          	jalr	-1922(ra) # 80003fd8 <begin_op>
    80004762:	6c88                	ld	a0,24(s1)
    80004764:	fffff097          	auipc	ra,0xfffff
    80004768:	ed2080e7          	jalr	-302(ra) # 80003636 <ilock>
    8000476c:	8752                	mv	a4,s4
    8000476e:	5094                	lw	a3,32(s1)
    80004770:	01690633          	add	a2,s2,s6
    80004774:	4585                	li	a1,1
    80004776:	6c88                	ld	a0,24(s1)
    80004778:	fffff097          	auipc	ra,0xfffff
    8000477c:	244080e7          	jalr	580(ra) # 800039bc <writei>
    80004780:	89aa                	mv	s3,a0
    80004782:	02a05c63          	blez	a0,800047ba <filewrite+0xe4>
    80004786:	509c                	lw	a5,32(s1)
    80004788:	9fa9                	addw	a5,a5,a0
    8000478a:	d09c                	sw	a5,32(s1)
    8000478c:	6c88                	ld	a0,24(s1)
    8000478e:	fffff097          	auipc	ra,0xfffff
    80004792:	f6c080e7          	jalr	-148(ra) # 800036fa <iunlock>
    80004796:	00000097          	auipc	ra,0x0
    8000479a:	8c2080e7          	jalr	-1854(ra) # 80004058 <end_op>
    8000479e:	05499863          	bne	s3,s4,800047ee <filewrite+0x118>
    800047a2:	012a093b          	addw	s2,s4,s2
    800047a6:	03595563          	ble	s5,s2,800047d0 <filewrite+0xfa>
    800047aa:	412a87bb          	subw	a5,s5,s2
    800047ae:	89be                	mv	s3,a5
    800047b0:	2781                	sext.w	a5,a5
    800047b2:	fafbd2e3          	ble	a5,s7,80004756 <filewrite+0x80>
    800047b6:	89e2                	mv	s3,s8
    800047b8:	bf79                	j	80004756 <filewrite+0x80>
    800047ba:	6c88                	ld	a0,24(s1)
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	f3e080e7          	jalr	-194(ra) # 800036fa <iunlock>
    800047c4:	00000097          	auipc	ra,0x0
    800047c8:	894080e7          	jalr	-1900(ra) # 80004058 <end_op>
    800047cc:	fc09d9e3          	bgez	s3,8000479e <filewrite+0xc8>
    800047d0:	8556                	mv	a0,s5
    800047d2:	032a9863          	bne	s5,s2,80004802 <filewrite+0x12c>
    800047d6:	60a6                	ld	ra,72(sp)
    800047d8:	6406                	ld	s0,64(sp)
    800047da:	74e2                	ld	s1,56(sp)
    800047dc:	7942                	ld	s2,48(sp)
    800047de:	79a2                	ld	s3,40(sp)
    800047e0:	7a02                	ld	s4,32(sp)
    800047e2:	6ae2                	ld	s5,24(sp)
    800047e4:	6b42                	ld	s6,16(sp)
    800047e6:	6ba2                	ld	s7,8(sp)
    800047e8:	6c02                	ld	s8,0(sp)
    800047ea:	6161                	addi	sp,sp,80
    800047ec:	8082                	ret
    800047ee:	00003517          	auipc	a0,0x3
    800047f2:	20a50513          	addi	a0,a0,522 # 800079f8 <userret+0x968>
    800047f6:	ffffc097          	auipc	ra,0xffffc
    800047fa:	d88080e7          	jalr	-632(ra) # 8000057e <panic>
    800047fe:	4901                	li	s2,0
    80004800:	bfc1                	j	800047d0 <filewrite+0xfa>
    80004802:	557d                	li	a0,-1
    80004804:	bfc9                	j	800047d6 <filewrite+0x100>
    80004806:	00003517          	auipc	a0,0x3
    8000480a:	20250513          	addi	a0,a0,514 # 80007a08 <userret+0x978>
    8000480e:	ffffc097          	auipc	ra,0xffffc
    80004812:	d70080e7          	jalr	-656(ra) # 8000057e <panic>
    80004816:	557d                	li	a0,-1
    80004818:	8082                	ret
    8000481a:	557d                	li	a0,-1
    8000481c:	bf6d                	j	800047d6 <filewrite+0x100>
    8000481e:	557d                	li	a0,-1
    80004820:	bf5d                	j	800047d6 <filewrite+0x100>

0000000080004822 <pipealloc>:
    80004822:	7179                	addi	sp,sp,-48
    80004824:	f406                	sd	ra,40(sp)
    80004826:	f022                	sd	s0,32(sp)
    80004828:	ec26                	sd	s1,24(sp)
    8000482a:	e84a                	sd	s2,16(sp)
    8000482c:	e44e                	sd	s3,8(sp)
    8000482e:	e052                	sd	s4,0(sp)
    80004830:	1800                	addi	s0,sp,48
    80004832:	84aa                	mv	s1,a0
    80004834:	892e                	mv	s2,a1
    80004836:	0005b023          	sd	zero,0(a1)
    8000483a:	00053023          	sd	zero,0(a0)
    8000483e:	00000097          	auipc	ra,0x0
    80004842:	bcc080e7          	jalr	-1076(ra) # 8000440a <filealloc>
    80004846:	e088                	sd	a0,0(s1)
    80004848:	c551                	beqz	a0,800048d4 <pipealloc+0xb2>
    8000484a:	00000097          	auipc	ra,0x0
    8000484e:	bc0080e7          	jalr	-1088(ra) # 8000440a <filealloc>
    80004852:	00a93023          	sd	a0,0(s2)
    80004856:	c92d                	beqz	a0,800048c8 <pipealloc+0xa6>
    80004858:	ffffc097          	auipc	ra,0xffffc
    8000485c:	138080e7          	jalr	312(ra) # 80000990 <kalloc>
    80004860:	89aa                	mv	s3,a0
    80004862:	c125                	beqz	a0,800048c2 <pipealloc+0xa0>
    80004864:	4a05                	li	s4,1
    80004866:	23452023          	sw	s4,544(a0)
    8000486a:	23452223          	sw	s4,548(a0)
    8000486e:	20052e23          	sw	zero,540(a0)
    80004872:	20052c23          	sw	zero,536(a0)
    80004876:	00003597          	auipc	a1,0x3
    8000487a:	1a258593          	addi	a1,a1,418 # 80007a18 <userret+0x988>
    8000487e:	ffffc097          	auipc	ra,0xffffc
    80004882:	172080e7          	jalr	370(ra) # 800009f0 <initlock>
    80004886:	609c                	ld	a5,0(s1)
    80004888:	0147a023          	sw	s4,0(a5)
    8000488c:	609c                	ld	a5,0(s1)
    8000488e:	01478423          	sb	s4,8(a5)
    80004892:	609c                	ld	a5,0(s1)
    80004894:	000784a3          	sb	zero,9(a5)
    80004898:	609c                	ld	a5,0(s1)
    8000489a:	0137b823          	sd	s3,16(a5)
    8000489e:	00093783          	ld	a5,0(s2)
    800048a2:	0147a023          	sw	s4,0(a5)
    800048a6:	00093783          	ld	a5,0(s2)
    800048aa:	00078423          	sb	zero,8(a5)
    800048ae:	00093783          	ld	a5,0(s2)
    800048b2:	014784a3          	sb	s4,9(a5)
    800048b6:	00093783          	ld	a5,0(s2)
    800048ba:	0137b823          	sd	s3,16(a5)
    800048be:	4501                	li	a0,0
    800048c0:	a025                	j	800048e8 <pipealloc+0xc6>
    800048c2:	6088                	ld	a0,0(s1)
    800048c4:	e501                	bnez	a0,800048cc <pipealloc+0xaa>
    800048c6:	a039                	j	800048d4 <pipealloc+0xb2>
    800048c8:	6088                	ld	a0,0(s1)
    800048ca:	c51d                	beqz	a0,800048f8 <pipealloc+0xd6>
    800048cc:	00000097          	auipc	ra,0x0
    800048d0:	c0e080e7          	jalr	-1010(ra) # 800044da <fileclose>
    800048d4:	00093783          	ld	a5,0(s2)
    800048d8:	557d                	li	a0,-1
    800048da:	c799                	beqz	a5,800048e8 <pipealloc+0xc6>
    800048dc:	853e                	mv	a0,a5
    800048de:	00000097          	auipc	ra,0x0
    800048e2:	bfc080e7          	jalr	-1028(ra) # 800044da <fileclose>
    800048e6:	557d                	li	a0,-1
    800048e8:	70a2                	ld	ra,40(sp)
    800048ea:	7402                	ld	s0,32(sp)
    800048ec:	64e2                	ld	s1,24(sp)
    800048ee:	6942                	ld	s2,16(sp)
    800048f0:	69a2                	ld	s3,8(sp)
    800048f2:	6a02                	ld	s4,0(sp)
    800048f4:	6145                	addi	sp,sp,48
    800048f6:	8082                	ret
    800048f8:	557d                	li	a0,-1
    800048fa:	b7fd                	j	800048e8 <pipealloc+0xc6>

00000000800048fc <pipeclose>:
    800048fc:	1101                	addi	sp,sp,-32
    800048fe:	ec06                	sd	ra,24(sp)
    80004900:	e822                	sd	s0,16(sp)
    80004902:	e426                	sd	s1,8(sp)
    80004904:	e04a                	sd	s2,0(sp)
    80004906:	1000                	addi	s0,sp,32
    80004908:	84aa                	mv	s1,a0
    8000490a:	892e                	mv	s2,a1
    8000490c:	ffffc097          	auipc	ra,0xffffc
    80004910:	1f2080e7          	jalr	498(ra) # 80000afe <acquire>
    80004914:	02090d63          	beqz	s2,8000494e <pipeclose+0x52>
    80004918:	2204a223          	sw	zero,548(s1)
    8000491c:	21848513          	addi	a0,s1,536
    80004920:	ffffe097          	auipc	ra,0xffffe
    80004924:	a30080e7          	jalr	-1488(ra) # 80002350 <wakeup>
    80004928:	2204b783          	ld	a5,544(s1)
    8000492c:	eb95                	bnez	a5,80004960 <pipeclose+0x64>
    8000492e:	8526                	mv	a0,s1
    80004930:	ffffc097          	auipc	ra,0xffffc
    80004934:	222080e7          	jalr	546(ra) # 80000b52 <release>
    80004938:	8526                	mv	a0,s1
    8000493a:	ffffc097          	auipc	ra,0xffffc
    8000493e:	f56080e7          	jalr	-170(ra) # 80000890 <kfree>
    80004942:	60e2                	ld	ra,24(sp)
    80004944:	6442                	ld	s0,16(sp)
    80004946:	64a2                	ld	s1,8(sp)
    80004948:	6902                	ld	s2,0(sp)
    8000494a:	6105                	addi	sp,sp,32
    8000494c:	8082                	ret
    8000494e:	2204a023          	sw	zero,544(s1)
    80004952:	21c48513          	addi	a0,s1,540
    80004956:	ffffe097          	auipc	ra,0xffffe
    8000495a:	9fa080e7          	jalr	-1542(ra) # 80002350 <wakeup>
    8000495e:	b7e9                	j	80004928 <pipeclose+0x2c>
    80004960:	8526                	mv	a0,s1
    80004962:	ffffc097          	auipc	ra,0xffffc
    80004966:	1f0080e7          	jalr	496(ra) # 80000b52 <release>
    8000496a:	bfe1                	j	80004942 <pipeclose+0x46>

000000008000496c <pipewrite>:
    8000496c:	7159                	addi	sp,sp,-112
    8000496e:	f486                	sd	ra,104(sp)
    80004970:	f0a2                	sd	s0,96(sp)
    80004972:	eca6                	sd	s1,88(sp)
    80004974:	e8ca                	sd	s2,80(sp)
    80004976:	e4ce                	sd	s3,72(sp)
    80004978:	e0d2                	sd	s4,64(sp)
    8000497a:	fc56                	sd	s5,56(sp)
    8000497c:	f85a                	sd	s6,48(sp)
    8000497e:	f45e                	sd	s7,40(sp)
    80004980:	f062                	sd	s8,32(sp)
    80004982:	ec66                	sd	s9,24(sp)
    80004984:	1880                	addi	s0,sp,112
    80004986:	84aa                	mv	s1,a0
    80004988:	8bae                	mv	s7,a1
    8000498a:	8b32                	mv	s6,a2
    8000498c:	ffffd097          	auipc	ra,0xffffd
    80004990:	092080e7          	jalr	146(ra) # 80001a1e <myproc>
    80004994:	8c2a                	mv	s8,a0
    80004996:	8526                	mv	a0,s1
    80004998:	ffffc097          	auipc	ra,0xffffc
    8000499c:	166080e7          	jalr	358(ra) # 80000afe <acquire>
    800049a0:	0d605663          	blez	s6,80004a6c <pipewrite+0x100>
    800049a4:	8926                	mv	s2,s1
    800049a6:	fffb0a9b          	addiw	s5,s6,-1
    800049aa:	1a82                	slli	s5,s5,0x20
    800049ac:	020ada93          	srli	s5,s5,0x20
    800049b0:	001b8793          	addi	a5,s7,1
    800049b4:	9abe                	add	s5,s5,a5
    800049b6:	21848a13          	addi	s4,s1,536
    800049ba:	21c48993          	addi	s3,s1,540
    800049be:	5cfd                	li	s9,-1
    800049c0:	2184a783          	lw	a5,536(s1)
    800049c4:	21c4a703          	lw	a4,540(s1)
    800049c8:	2007879b          	addiw	a5,a5,512
    800049cc:	06f71463          	bne	a4,a5,80004a34 <pipewrite+0xc8>
    800049d0:	2204a783          	lw	a5,544(s1)
    800049d4:	cf8d                	beqz	a5,80004a0e <pipewrite+0xa2>
    800049d6:	ffffd097          	auipc	ra,0xffffd
    800049da:	048080e7          	jalr	72(ra) # 80001a1e <myproc>
    800049de:	591c                	lw	a5,48(a0)
    800049e0:	e79d                	bnez	a5,80004a0e <pipewrite+0xa2>
    800049e2:	8552                	mv	a0,s4
    800049e4:	ffffe097          	auipc	ra,0xffffe
    800049e8:	96c080e7          	jalr	-1684(ra) # 80002350 <wakeup>
    800049ec:	85ca                	mv	a1,s2
    800049ee:	854e                	mv	a0,s3
    800049f0:	ffffd097          	auipc	ra,0xffffd
    800049f4:	7da080e7          	jalr	2010(ra) # 800021ca <sleep>
    800049f8:	2184a783          	lw	a5,536(s1)
    800049fc:	21c4a703          	lw	a4,540(s1)
    80004a00:	2007879b          	addiw	a5,a5,512
    80004a04:	02f71863          	bne	a4,a5,80004a34 <pipewrite+0xc8>
    80004a08:	2204a783          	lw	a5,544(s1)
    80004a0c:	f7e9                	bnez	a5,800049d6 <pipewrite+0x6a>
    80004a0e:	8526                	mv	a0,s1
    80004a10:	ffffc097          	auipc	ra,0xffffc
    80004a14:	142080e7          	jalr	322(ra) # 80000b52 <release>
    80004a18:	557d                	li	a0,-1
    80004a1a:	70a6                	ld	ra,104(sp)
    80004a1c:	7406                	ld	s0,96(sp)
    80004a1e:	64e6                	ld	s1,88(sp)
    80004a20:	6946                	ld	s2,80(sp)
    80004a22:	69a6                	ld	s3,72(sp)
    80004a24:	6a06                	ld	s4,64(sp)
    80004a26:	7ae2                	ld	s5,56(sp)
    80004a28:	7b42                	ld	s6,48(sp)
    80004a2a:	7ba2                	ld	s7,40(sp)
    80004a2c:	7c02                	ld	s8,32(sp)
    80004a2e:	6ce2                	ld	s9,24(sp)
    80004a30:	6165                	addi	sp,sp,112
    80004a32:	8082                	ret
    80004a34:	4685                	li	a3,1
    80004a36:	865e                	mv	a2,s7
    80004a38:	f9f40593          	addi	a1,s0,-97
    80004a3c:	050c3503          	ld	a0,80(s8) # 1050 <_entry-0x7fffefb0>
    80004a40:	ffffd097          	auipc	ra,0xffffd
    80004a44:	d46080e7          	jalr	-698(ra) # 80001786 <copyin>
    80004a48:	03950263          	beq	a0,s9,80004a6c <pipewrite+0x100>
    80004a4c:	21c4a783          	lw	a5,540(s1)
    80004a50:	0017871b          	addiw	a4,a5,1
    80004a54:	20e4ae23          	sw	a4,540(s1)
    80004a58:	1ff7f793          	andi	a5,a5,511
    80004a5c:	97a6                	add	a5,a5,s1
    80004a5e:	f9f44703          	lbu	a4,-97(s0)
    80004a62:	00e78c23          	sb	a4,24(a5)
    80004a66:	0b85                	addi	s7,s7,1
    80004a68:	f55b9ce3          	bne	s7,s5,800049c0 <pipewrite+0x54>
    80004a6c:	21848513          	addi	a0,s1,536
    80004a70:	ffffe097          	auipc	ra,0xffffe
    80004a74:	8e0080e7          	jalr	-1824(ra) # 80002350 <wakeup>
    80004a78:	8526                	mv	a0,s1
    80004a7a:	ffffc097          	auipc	ra,0xffffc
    80004a7e:	0d8080e7          	jalr	216(ra) # 80000b52 <release>
    80004a82:	855a                	mv	a0,s6
    80004a84:	bf59                	j	80004a1a <pipewrite+0xae>

0000000080004a86 <piperead>:
    80004a86:	715d                	addi	sp,sp,-80
    80004a88:	e486                	sd	ra,72(sp)
    80004a8a:	e0a2                	sd	s0,64(sp)
    80004a8c:	fc26                	sd	s1,56(sp)
    80004a8e:	f84a                	sd	s2,48(sp)
    80004a90:	f44e                	sd	s3,40(sp)
    80004a92:	f052                	sd	s4,32(sp)
    80004a94:	ec56                	sd	s5,24(sp)
    80004a96:	e85a                	sd	s6,16(sp)
    80004a98:	0880                	addi	s0,sp,80
    80004a9a:	84aa                	mv	s1,a0
    80004a9c:	89ae                	mv	s3,a1
    80004a9e:	8a32                	mv	s4,a2
    80004aa0:	ffffd097          	auipc	ra,0xffffd
    80004aa4:	f7e080e7          	jalr	-130(ra) # 80001a1e <myproc>
    80004aa8:	8aaa                	mv	s5,a0
    80004aaa:	8526                	mv	a0,s1
    80004aac:	ffffc097          	auipc	ra,0xffffc
    80004ab0:	052080e7          	jalr	82(ra) # 80000afe <acquire>
    80004ab4:	2184a703          	lw	a4,536(s1)
    80004ab8:	21c4a783          	lw	a5,540(s1)
    80004abc:	06f71b63          	bne	a4,a5,80004b32 <piperead+0xac>
    80004ac0:	8926                	mv	s2,s1
    80004ac2:	2244a783          	lw	a5,548(s1)
    80004ac6:	cb85                	beqz	a5,80004af6 <piperead+0x70>
    80004ac8:	21848b13          	addi	s6,s1,536
    80004acc:	ffffd097          	auipc	ra,0xffffd
    80004ad0:	f52080e7          	jalr	-174(ra) # 80001a1e <myproc>
    80004ad4:	591c                	lw	a5,48(a0)
    80004ad6:	e7b9                	bnez	a5,80004b24 <piperead+0x9e>
    80004ad8:	85ca                	mv	a1,s2
    80004ada:	855a                	mv	a0,s6
    80004adc:	ffffd097          	auipc	ra,0xffffd
    80004ae0:	6ee080e7          	jalr	1774(ra) # 800021ca <sleep>
    80004ae4:	2184a703          	lw	a4,536(s1)
    80004ae8:	21c4a783          	lw	a5,540(s1)
    80004aec:	04f71363          	bne	a4,a5,80004b32 <piperead+0xac>
    80004af0:	2244a783          	lw	a5,548(s1)
    80004af4:	ffe1                	bnez	a5,80004acc <piperead+0x46>
    80004af6:	4901                	li	s2,0
    80004af8:	21c48513          	addi	a0,s1,540
    80004afc:	ffffe097          	auipc	ra,0xffffe
    80004b00:	854080e7          	jalr	-1964(ra) # 80002350 <wakeup>
    80004b04:	8526                	mv	a0,s1
    80004b06:	ffffc097          	auipc	ra,0xffffc
    80004b0a:	04c080e7          	jalr	76(ra) # 80000b52 <release>
    80004b0e:	854a                	mv	a0,s2
    80004b10:	60a6                	ld	ra,72(sp)
    80004b12:	6406                	ld	s0,64(sp)
    80004b14:	74e2                	ld	s1,56(sp)
    80004b16:	7942                	ld	s2,48(sp)
    80004b18:	79a2                	ld	s3,40(sp)
    80004b1a:	7a02                	ld	s4,32(sp)
    80004b1c:	6ae2                	ld	s5,24(sp)
    80004b1e:	6b42                	ld	s6,16(sp)
    80004b20:	6161                	addi	sp,sp,80
    80004b22:	8082                	ret
    80004b24:	8526                	mv	a0,s1
    80004b26:	ffffc097          	auipc	ra,0xffffc
    80004b2a:	02c080e7          	jalr	44(ra) # 80000b52 <release>
    80004b2e:	597d                	li	s2,-1
    80004b30:	bff9                	j	80004b0e <piperead+0x88>
    80004b32:	4901                	li	s2,0
    80004b34:	fd4052e3          	blez	s4,80004af8 <piperead+0x72>
    80004b38:	2184a783          	lw	a5,536(s1)
    80004b3c:	4901                	li	s2,0
    80004b3e:	5b7d                	li	s6,-1
    80004b40:	0017871b          	addiw	a4,a5,1
    80004b44:	20e4ac23          	sw	a4,536(s1)
    80004b48:	1ff7f793          	andi	a5,a5,511
    80004b4c:	97a6                	add	a5,a5,s1
    80004b4e:	0187c783          	lbu	a5,24(a5)
    80004b52:	faf40fa3          	sb	a5,-65(s0)
    80004b56:	4685                	li	a3,1
    80004b58:	fbf40613          	addi	a2,s0,-65
    80004b5c:	85ce                	mv	a1,s3
    80004b5e:	050ab503          	ld	a0,80(s5)
    80004b62:	ffffd097          	auipc	ra,0xffffd
    80004b66:	b98080e7          	jalr	-1128(ra) # 800016fa <copyout>
    80004b6a:	f96507e3          	beq	a0,s6,80004af8 <piperead+0x72>
    80004b6e:	2905                	addiw	s2,s2,1
    80004b70:	f92a04e3          	beq	s4,s2,80004af8 <piperead+0x72>
    80004b74:	2184a783          	lw	a5,536(s1)
    80004b78:	0985                	addi	s3,s3,1
    80004b7a:	21c4a703          	lw	a4,540(s1)
    80004b7e:	fcf711e3          	bne	a4,a5,80004b40 <piperead+0xba>
    80004b82:	bf9d                	j	80004af8 <piperead+0x72>

0000000080004b84 <exec>:
    80004b84:	de010113          	addi	sp,sp,-544
    80004b88:	20113c23          	sd	ra,536(sp)
    80004b8c:	20813823          	sd	s0,528(sp)
    80004b90:	20913423          	sd	s1,520(sp)
    80004b94:	21213023          	sd	s2,512(sp)
    80004b98:	ffce                	sd	s3,504(sp)
    80004b9a:	fbd2                	sd	s4,496(sp)
    80004b9c:	f7d6                	sd	s5,488(sp)
    80004b9e:	f3da                	sd	s6,480(sp)
    80004ba0:	efde                	sd	s7,472(sp)
    80004ba2:	ebe2                	sd	s8,464(sp)
    80004ba4:	e7e6                	sd	s9,456(sp)
    80004ba6:	e3ea                	sd	s10,448(sp)
    80004ba8:	ff6e                	sd	s11,440(sp)
    80004baa:	1400                	addi	s0,sp,544
    80004bac:	892a                	mv	s2,a0
    80004bae:	dea43823          	sd	a0,-528(s0)
    80004bb2:	deb43c23          	sd	a1,-520(s0)
    80004bb6:	ffffd097          	auipc	ra,0xffffd
    80004bba:	e68080e7          	jalr	-408(ra) # 80001a1e <myproc>
    80004bbe:	84aa                	mv	s1,a0
    80004bc0:	fffff097          	auipc	ra,0xfffff
    80004bc4:	418080e7          	jalr	1048(ra) # 80003fd8 <begin_op>
    80004bc8:	854a                	mv	a0,s2
    80004bca:	fffff097          	auipc	ra,0xfffff
    80004bce:	200080e7          	jalr	512(ra) # 80003dca <namei>
    80004bd2:	c93d                	beqz	a0,80004c48 <exec+0xc4>
    80004bd4:	892a                	mv	s2,a0
    80004bd6:	fffff097          	auipc	ra,0xfffff
    80004bda:	a60080e7          	jalr	-1440(ra) # 80003636 <ilock>
    80004bde:	04000713          	li	a4,64
    80004be2:	4681                	li	a3,0
    80004be4:	e4840613          	addi	a2,s0,-440
    80004be8:	4581                	li	a1,0
    80004bea:	854a                	mv	a0,s2
    80004bec:	fffff097          	auipc	ra,0xfffff
    80004bf0:	cdc080e7          	jalr	-804(ra) # 800038c8 <readi>
    80004bf4:	04000793          	li	a5,64
    80004bf8:	00f51a63          	bne	a0,a5,80004c0c <exec+0x88>
    80004bfc:	e4842703          	lw	a4,-440(s0)
    80004c00:	464c47b7          	lui	a5,0x464c4
    80004c04:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004c08:	04f70663          	beq	a4,a5,80004c54 <exec+0xd0>
    80004c0c:	854a                	mv	a0,s2
    80004c0e:	fffff097          	auipc	ra,0xfffff
    80004c12:	c68080e7          	jalr	-920(ra) # 80003876 <iunlockput>
    80004c16:	fffff097          	auipc	ra,0xfffff
    80004c1a:	442080e7          	jalr	1090(ra) # 80004058 <end_op>
    80004c1e:	557d                	li	a0,-1
    80004c20:	21813083          	ld	ra,536(sp)
    80004c24:	21013403          	ld	s0,528(sp)
    80004c28:	20813483          	ld	s1,520(sp)
    80004c2c:	20013903          	ld	s2,512(sp)
    80004c30:	79fe                	ld	s3,504(sp)
    80004c32:	7a5e                	ld	s4,496(sp)
    80004c34:	7abe                	ld	s5,488(sp)
    80004c36:	7b1e                	ld	s6,480(sp)
    80004c38:	6bfe                	ld	s7,472(sp)
    80004c3a:	6c5e                	ld	s8,464(sp)
    80004c3c:	6cbe                	ld	s9,456(sp)
    80004c3e:	6d1e                	ld	s10,448(sp)
    80004c40:	7dfa                	ld	s11,440(sp)
    80004c42:	22010113          	addi	sp,sp,544
    80004c46:	8082                	ret
    80004c48:	fffff097          	auipc	ra,0xfffff
    80004c4c:	410080e7          	jalr	1040(ra) # 80004058 <end_op>
    80004c50:	557d                	li	a0,-1
    80004c52:	b7f9                	j	80004c20 <exec+0x9c>
    80004c54:	8526                	mv	a0,s1
    80004c56:	ffffd097          	auipc	ra,0xffffd
    80004c5a:	e8e080e7          	jalr	-370(ra) # 80001ae4 <proc_pagetable>
    80004c5e:	e0a43423          	sd	a0,-504(s0)
    80004c62:	d54d                	beqz	a0,80004c0c <exec+0x88>
    80004c64:	e6842983          	lw	s3,-408(s0)
    80004c68:	e8045783          	lhu	a5,-384(s0)
    80004c6c:	cbed                	beqz	a5,80004d5e <exec+0x1da>
    80004c6e:	e0043023          	sd	zero,-512(s0)
    80004c72:	4b01                	li	s6,0
    80004c74:	6c05                	lui	s8,0x1
    80004c76:	fffc0793          	addi	a5,s8,-1 # fff <_entry-0x7ffff001>
    80004c7a:	def43423          	sd	a5,-536(s0)
    80004c7e:	6d05                	lui	s10,0x1
    80004c80:	a0a5                	j	80004ce8 <exec+0x164>
    80004c82:	00003517          	auipc	a0,0x3
    80004c86:	d9e50513          	addi	a0,a0,-610 # 80007a20 <userret+0x990>
    80004c8a:	ffffc097          	auipc	ra,0xffffc
    80004c8e:	8f4080e7          	jalr	-1804(ra) # 8000057e <panic>
    80004c92:	8756                	mv	a4,s5
    80004c94:	009d86bb          	addw	a3,s11,s1
    80004c98:	4581                	li	a1,0
    80004c9a:	854a                	mv	a0,s2
    80004c9c:	fffff097          	auipc	ra,0xfffff
    80004ca0:	c2c080e7          	jalr	-980(ra) # 800038c8 <readi>
    80004ca4:	2501                	sext.w	a0,a0
    80004ca6:	10aa9463          	bne	s5,a0,80004dae <exec+0x22a>
    80004caa:	009d04bb          	addw	s1,s10,s1
    80004cae:	77fd                	lui	a5,0xfffff
    80004cb0:	01478a3b          	addw	s4,a5,s4
    80004cb4:	0374f363          	bleu	s7,s1,80004cda <exec+0x156>
    80004cb8:	02049593          	slli	a1,s1,0x20
    80004cbc:	9181                	srli	a1,a1,0x20
    80004cbe:	95e6                	add	a1,a1,s9
    80004cc0:	e0843503          	ld	a0,-504(s0)
    80004cc4:	ffffc097          	auipc	ra,0xffffc
    80004cc8:	466080e7          	jalr	1126(ra) # 8000112a <walkaddr>
    80004ccc:	862a                	mv	a2,a0
    80004cce:	d955                	beqz	a0,80004c82 <exec+0xfe>
    80004cd0:	8ae2                	mv	s5,s8
    80004cd2:	fd8a70e3          	bleu	s8,s4,80004c92 <exec+0x10e>
    80004cd6:	8ad2                	mv	s5,s4
    80004cd8:	bf6d                	j	80004c92 <exec+0x10e>
    80004cda:	2b05                	addiw	s6,s6,1
    80004cdc:	0389899b          	addiw	s3,s3,56
    80004ce0:	e8045783          	lhu	a5,-384(s0)
    80004ce4:	06fb5f63          	ble	a5,s6,80004d62 <exec+0x1de>
    80004ce8:	2981                	sext.w	s3,s3
    80004cea:	03800713          	li	a4,56
    80004cee:	86ce                	mv	a3,s3
    80004cf0:	e1040613          	addi	a2,s0,-496
    80004cf4:	4581                	li	a1,0
    80004cf6:	854a                	mv	a0,s2
    80004cf8:	fffff097          	auipc	ra,0xfffff
    80004cfc:	bd0080e7          	jalr	-1072(ra) # 800038c8 <readi>
    80004d00:	03800793          	li	a5,56
    80004d04:	0af51563          	bne	a0,a5,80004dae <exec+0x22a>
    80004d08:	e1042783          	lw	a5,-496(s0)
    80004d0c:	4705                	li	a4,1
    80004d0e:	fce796e3          	bne	a5,a4,80004cda <exec+0x156>
    80004d12:	e3843603          	ld	a2,-456(s0)
    80004d16:	e3043783          	ld	a5,-464(s0)
    80004d1a:	08f66a63          	bltu	a2,a5,80004dae <exec+0x22a>
    80004d1e:	e2043783          	ld	a5,-480(s0)
    80004d22:	963e                	add	a2,a2,a5
    80004d24:	08f66563          	bltu	a2,a5,80004dae <exec+0x22a>
    80004d28:	e0043583          	ld	a1,-512(s0)
    80004d2c:	e0843503          	ld	a0,-504(s0)
    80004d30:	ffffc097          	auipc	ra,0xffffc
    80004d34:	7f0080e7          	jalr	2032(ra) # 80001520 <uvmalloc>
    80004d38:	e0a43023          	sd	a0,-512(s0)
    80004d3c:	c92d                	beqz	a0,80004dae <exec+0x22a>
    80004d3e:	e2043c83          	ld	s9,-480(s0)
    80004d42:	de843783          	ld	a5,-536(s0)
    80004d46:	00fcf7b3          	and	a5,s9,a5
    80004d4a:	e3b5                	bnez	a5,80004dae <exec+0x22a>
    80004d4c:	e1842d83          	lw	s11,-488(s0)
    80004d50:	e3042b83          	lw	s7,-464(s0)
    80004d54:	f80b83e3          	beqz	s7,80004cda <exec+0x156>
    80004d58:	8a5e                	mv	s4,s7
    80004d5a:	4481                	li	s1,0
    80004d5c:	bfb1                	j	80004cb8 <exec+0x134>
    80004d5e:	e0043023          	sd	zero,-512(s0)
    80004d62:	854a                	mv	a0,s2
    80004d64:	fffff097          	auipc	ra,0xfffff
    80004d68:	b12080e7          	jalr	-1262(ra) # 80003876 <iunlockput>
    80004d6c:	fffff097          	auipc	ra,0xfffff
    80004d70:	2ec080e7          	jalr	748(ra) # 80004058 <end_op>
    80004d74:	ffffd097          	auipc	ra,0xffffd
    80004d78:	caa080e7          	jalr	-854(ra) # 80001a1e <myproc>
    80004d7c:	8b2a                	mv	s6,a0
    80004d7e:	04853c83          	ld	s9,72(a0)
    80004d82:	6585                	lui	a1,0x1
    80004d84:	15fd                	addi	a1,a1,-1
    80004d86:	e0043783          	ld	a5,-512(s0)
    80004d8a:	00b78d33          	add	s10,a5,a1
    80004d8e:	75fd                	lui	a1,0xfffff
    80004d90:	00bd75b3          	and	a1,s10,a1
    80004d94:	6609                	lui	a2,0x2
    80004d96:	962e                	add	a2,a2,a1
    80004d98:	e0843483          	ld	s1,-504(s0)
    80004d9c:	8526                	mv	a0,s1
    80004d9e:	ffffc097          	auipc	ra,0xffffc
    80004da2:	782080e7          	jalr	1922(ra) # 80001520 <uvmalloc>
    80004da6:	e0a43023          	sd	a0,-512(s0)
    80004daa:	4901                	li	s2,0
    80004dac:	ed09                	bnez	a0,80004dc6 <exec+0x242>
    80004dae:	e0043583          	ld	a1,-512(s0)
    80004db2:	e0843503          	ld	a0,-504(s0)
    80004db6:	ffffd097          	auipc	ra,0xffffd
    80004dba:	e2e080e7          	jalr	-466(ra) # 80001be4 <proc_freepagetable>
    80004dbe:	e40917e3          	bnez	s2,80004c0c <exec+0x88>
    80004dc2:	557d                	li	a0,-1
    80004dc4:	bdb1                	j	80004c20 <exec+0x9c>
    80004dc6:	75f9                	lui	a1,0xffffe
    80004dc8:	892a                	mv	s2,a0
    80004dca:	95aa                	add	a1,a1,a0
    80004dcc:	8526                	mv	a0,s1
    80004dce:	ffffd097          	auipc	ra,0xffffd
    80004dd2:	8fa080e7          	jalr	-1798(ra) # 800016c8 <uvmclear>
    80004dd6:	7afd                	lui	s5,0xfffff
    80004dd8:	9aca                	add	s5,s5,s2
    80004dda:	df843783          	ld	a5,-520(s0)
    80004dde:	6388                	ld	a0,0(a5)
    80004de0:	c52d                	beqz	a0,80004e4a <exec+0x2c6>
    80004de2:	e8840993          	addi	s3,s0,-376
    80004de6:	f8840b93          	addi	s7,s0,-120
    80004dea:	4481                	li	s1,0
    80004dec:	ffffc097          	auipc	ra,0xffffc
    80004df0:	f58080e7          	jalr	-168(ra) # 80000d44 <strlen>
    80004df4:	2505                	addiw	a0,a0,1
    80004df6:	40a90933          	sub	s2,s2,a0
    80004dfa:	ff097913          	andi	s2,s2,-16
    80004dfe:	0f596f63          	bltu	s2,s5,80004efc <exec+0x378>
    80004e02:	df843c03          	ld	s8,-520(s0)
    80004e06:	000c3a03          	ld	s4,0(s8)
    80004e0a:	8552                	mv	a0,s4
    80004e0c:	ffffc097          	auipc	ra,0xffffc
    80004e10:	f38080e7          	jalr	-200(ra) # 80000d44 <strlen>
    80004e14:	0015069b          	addiw	a3,a0,1
    80004e18:	8652                	mv	a2,s4
    80004e1a:	85ca                	mv	a1,s2
    80004e1c:	e0843503          	ld	a0,-504(s0)
    80004e20:	ffffd097          	auipc	ra,0xffffd
    80004e24:	8da080e7          	jalr	-1830(ra) # 800016fa <copyout>
    80004e28:	0c054c63          	bltz	a0,80004f00 <exec+0x37c>
    80004e2c:	0129b023          	sd	s2,0(s3)
    80004e30:	0485                	addi	s1,s1,1
    80004e32:	008c0793          	addi	a5,s8,8
    80004e36:	def43c23          	sd	a5,-520(s0)
    80004e3a:	008c3503          	ld	a0,8(s8)
    80004e3e:	c909                	beqz	a0,80004e50 <exec+0x2cc>
    80004e40:	09a1                	addi	s3,s3,8
    80004e42:	fb7995e3          	bne	s3,s7,80004dec <exec+0x268>
    80004e46:	4901                	li	s2,0
    80004e48:	b79d                	j	80004dae <exec+0x22a>
    80004e4a:	e0043903          	ld	s2,-512(s0)
    80004e4e:	4481                	li	s1,0
    80004e50:	00349793          	slli	a5,s1,0x3
    80004e54:	f9040713          	addi	a4,s0,-112
    80004e58:	97ba                	add	a5,a5,a4
    80004e5a:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <end+0xffffffff7ffd8edc>
    80004e5e:	00148693          	addi	a3,s1,1
    80004e62:	068e                	slli	a3,a3,0x3
    80004e64:	40d90933          	sub	s2,s2,a3
    80004e68:	ff097993          	andi	s3,s2,-16
    80004e6c:	4901                	li	s2,0
    80004e6e:	f559e0e3          	bltu	s3,s5,80004dae <exec+0x22a>
    80004e72:	e8840613          	addi	a2,s0,-376
    80004e76:	85ce                	mv	a1,s3
    80004e78:	e0843503          	ld	a0,-504(s0)
    80004e7c:	ffffd097          	auipc	ra,0xffffd
    80004e80:	87e080e7          	jalr	-1922(ra) # 800016fa <copyout>
    80004e84:	08054063          	bltz	a0,80004f04 <exec+0x380>
    80004e88:	058b3783          	ld	a5,88(s6)
    80004e8c:	0737bc23          	sd	s3,120(a5)
    80004e90:	df043783          	ld	a5,-528(s0)
    80004e94:	0007c703          	lbu	a4,0(a5)
    80004e98:	cf11                	beqz	a4,80004eb4 <exec+0x330>
    80004e9a:	0785                	addi	a5,a5,1
    80004e9c:	02f00693          	li	a3,47
    80004ea0:	a029                	j	80004eaa <exec+0x326>
    80004ea2:	0785                	addi	a5,a5,1
    80004ea4:	fff7c703          	lbu	a4,-1(a5)
    80004ea8:	c711                	beqz	a4,80004eb4 <exec+0x330>
    80004eaa:	fed71ce3          	bne	a4,a3,80004ea2 <exec+0x31e>
    80004eae:	def43823          	sd	a5,-528(s0)
    80004eb2:	bfc5                	j	80004ea2 <exec+0x31e>
    80004eb4:	4641                	li	a2,16
    80004eb6:	df043583          	ld	a1,-528(s0)
    80004eba:	158b0513          	addi	a0,s6,344
    80004ebe:	ffffc097          	auipc	ra,0xffffc
    80004ec2:	e54080e7          	jalr	-428(ra) # 80000d12 <safestrcpy>
    80004ec6:	050b3503          	ld	a0,80(s6)
    80004eca:	e0843783          	ld	a5,-504(s0)
    80004ece:	04fb3823          	sd	a5,80(s6)
    80004ed2:	e0043783          	ld	a5,-512(s0)
    80004ed6:	04fb3423          	sd	a5,72(s6)
    80004eda:	058b3783          	ld	a5,88(s6)
    80004ede:	e6043703          	ld	a4,-416(s0)
    80004ee2:	ef98                	sd	a4,24(a5)
    80004ee4:	058b3783          	ld	a5,88(s6)
    80004ee8:	0337b823          	sd	s3,48(a5)
    80004eec:	85e6                	mv	a1,s9
    80004eee:	ffffd097          	auipc	ra,0xffffd
    80004ef2:	cf6080e7          	jalr	-778(ra) # 80001be4 <proc_freepagetable>
    80004ef6:	0004851b          	sext.w	a0,s1
    80004efa:	b31d                	j	80004c20 <exec+0x9c>
    80004efc:	4901                	li	s2,0
    80004efe:	bd45                	j	80004dae <exec+0x22a>
    80004f00:	4901                	li	s2,0
    80004f02:	b575                	j	80004dae <exec+0x22a>
    80004f04:	4901                	li	s2,0
    80004f06:	b565                	j	80004dae <exec+0x22a>

0000000080004f08 <argfd>:
    80004f08:	7179                	addi	sp,sp,-48
    80004f0a:	f406                	sd	ra,40(sp)
    80004f0c:	f022                	sd	s0,32(sp)
    80004f0e:	ec26                	sd	s1,24(sp)
    80004f10:	e84a                	sd	s2,16(sp)
    80004f12:	1800                	addi	s0,sp,48
    80004f14:	892e                	mv	s2,a1
    80004f16:	84b2                	mv	s1,a2
    80004f18:	fdc40593          	addi	a1,s0,-36
    80004f1c:	ffffe097          	auipc	ra,0xffffe
    80004f20:	b5a080e7          	jalr	-1190(ra) # 80002a76 <argint>
    80004f24:	04054063          	bltz	a0,80004f64 <argfd+0x5c>
    80004f28:	fdc42703          	lw	a4,-36(s0)
    80004f2c:	47bd                	li	a5,15
    80004f2e:	02e7ed63          	bltu	a5,a4,80004f68 <argfd+0x60>
    80004f32:	ffffd097          	auipc	ra,0xffffd
    80004f36:	aec080e7          	jalr	-1300(ra) # 80001a1e <myproc>
    80004f3a:	fdc42703          	lw	a4,-36(s0)
    80004f3e:	01a70793          	addi	a5,a4,26
    80004f42:	078e                	slli	a5,a5,0x3
    80004f44:	953e                	add	a0,a0,a5
    80004f46:	611c                	ld	a5,0(a0)
    80004f48:	c395                	beqz	a5,80004f6c <argfd+0x64>
    80004f4a:	00090463          	beqz	s2,80004f52 <argfd+0x4a>
    80004f4e:	00e92023          	sw	a4,0(s2)
    80004f52:	4501                	li	a0,0
    80004f54:	c091                	beqz	s1,80004f58 <argfd+0x50>
    80004f56:	e09c                	sd	a5,0(s1)
    80004f58:	70a2                	ld	ra,40(sp)
    80004f5a:	7402                	ld	s0,32(sp)
    80004f5c:	64e2                	ld	s1,24(sp)
    80004f5e:	6942                	ld	s2,16(sp)
    80004f60:	6145                	addi	sp,sp,48
    80004f62:	8082                	ret
    80004f64:	557d                	li	a0,-1
    80004f66:	bfcd                	j	80004f58 <argfd+0x50>
    80004f68:	557d                	li	a0,-1
    80004f6a:	b7fd                	j	80004f58 <argfd+0x50>
    80004f6c:	557d                	li	a0,-1
    80004f6e:	b7ed                	j	80004f58 <argfd+0x50>

0000000080004f70 <fdalloc>:
    80004f70:	1101                	addi	sp,sp,-32
    80004f72:	ec06                	sd	ra,24(sp)
    80004f74:	e822                	sd	s0,16(sp)
    80004f76:	e426                	sd	s1,8(sp)
    80004f78:	1000                	addi	s0,sp,32
    80004f7a:	84aa                	mv	s1,a0
    80004f7c:	ffffd097          	auipc	ra,0xffffd
    80004f80:	aa2080e7          	jalr	-1374(ra) # 80001a1e <myproc>
    80004f84:	697c                	ld	a5,208(a0)
    80004f86:	c395                	beqz	a5,80004faa <fdalloc+0x3a>
    80004f88:	0d850713          	addi	a4,a0,216
    80004f8c:	4785                	li	a5,1
    80004f8e:	4641                	li	a2,16
    80004f90:	6314                	ld	a3,0(a4)
    80004f92:	ce89                	beqz	a3,80004fac <fdalloc+0x3c>
    80004f94:	2785                	addiw	a5,a5,1
    80004f96:	0721                	addi	a4,a4,8
    80004f98:	fec79ce3          	bne	a5,a2,80004f90 <fdalloc+0x20>
    80004f9c:	57fd                	li	a5,-1
    80004f9e:	853e                	mv	a0,a5
    80004fa0:	60e2                	ld	ra,24(sp)
    80004fa2:	6442                	ld	s0,16(sp)
    80004fa4:	64a2                	ld	s1,8(sp)
    80004fa6:	6105                	addi	sp,sp,32
    80004fa8:	8082                	ret
    80004faa:	4781                	li	a5,0
    80004fac:	01a78713          	addi	a4,a5,26
    80004fb0:	070e                	slli	a4,a4,0x3
    80004fb2:	953a                	add	a0,a0,a4
    80004fb4:	e104                	sd	s1,0(a0)
    80004fb6:	b7e5                	j	80004f9e <fdalloc+0x2e>

0000000080004fb8 <create>:
    80004fb8:	715d                	addi	sp,sp,-80
    80004fba:	e486                	sd	ra,72(sp)
    80004fbc:	e0a2                	sd	s0,64(sp)
    80004fbe:	fc26                	sd	s1,56(sp)
    80004fc0:	f84a                	sd	s2,48(sp)
    80004fc2:	f44e                	sd	s3,40(sp)
    80004fc4:	f052                	sd	s4,32(sp)
    80004fc6:	ec56                	sd	s5,24(sp)
    80004fc8:	0880                	addi	s0,sp,80
    80004fca:	89ae                	mv	s3,a1
    80004fcc:	8ab2                	mv	s5,a2
    80004fce:	8a36                	mv	s4,a3
    80004fd0:	fb040593          	addi	a1,s0,-80
    80004fd4:	fffff097          	auipc	ra,0xfffff
    80004fd8:	e14080e7          	jalr	-492(ra) # 80003de8 <nameiparent>
    80004fdc:	892a                	mv	s2,a0
    80004fde:	12050f63          	beqz	a0,8000511c <create+0x164>
    80004fe2:	ffffe097          	auipc	ra,0xffffe
    80004fe6:	654080e7          	jalr	1620(ra) # 80003636 <ilock>
    80004fea:	4601                	li	a2,0
    80004fec:	fb040593          	addi	a1,s0,-80
    80004ff0:	854a                	mv	a0,s2
    80004ff2:	fffff097          	auipc	ra,0xfffff
    80004ff6:	afe080e7          	jalr	-1282(ra) # 80003af0 <dirlookup>
    80004ffa:	84aa                	mv	s1,a0
    80004ffc:	c921                	beqz	a0,8000504c <create+0x94>
    80004ffe:	854a                	mv	a0,s2
    80005000:	fffff097          	auipc	ra,0xfffff
    80005004:	876080e7          	jalr	-1930(ra) # 80003876 <iunlockput>
    80005008:	8526                	mv	a0,s1
    8000500a:	ffffe097          	auipc	ra,0xffffe
    8000500e:	62c080e7          	jalr	1580(ra) # 80003636 <ilock>
    80005012:	2981                	sext.w	s3,s3
    80005014:	4789                	li	a5,2
    80005016:	02f99463          	bne	s3,a5,8000503e <create+0x86>
    8000501a:	0444d783          	lhu	a5,68(s1)
    8000501e:	37f9                	addiw	a5,a5,-2
    80005020:	17c2                	slli	a5,a5,0x30
    80005022:	93c1                	srli	a5,a5,0x30
    80005024:	4705                	li	a4,1
    80005026:	00f76c63          	bltu	a4,a5,8000503e <create+0x86>
    8000502a:	8526                	mv	a0,s1
    8000502c:	60a6                	ld	ra,72(sp)
    8000502e:	6406                	ld	s0,64(sp)
    80005030:	74e2                	ld	s1,56(sp)
    80005032:	7942                	ld	s2,48(sp)
    80005034:	79a2                	ld	s3,40(sp)
    80005036:	7a02                	ld	s4,32(sp)
    80005038:	6ae2                	ld	s5,24(sp)
    8000503a:	6161                	addi	sp,sp,80
    8000503c:	8082                	ret
    8000503e:	8526                	mv	a0,s1
    80005040:	fffff097          	auipc	ra,0xfffff
    80005044:	836080e7          	jalr	-1994(ra) # 80003876 <iunlockput>
    80005048:	4481                	li	s1,0
    8000504a:	b7c5                	j	8000502a <create+0x72>
    8000504c:	85ce                	mv	a1,s3
    8000504e:	00092503          	lw	a0,0(s2)
    80005052:	ffffe097          	auipc	ra,0xffffe
    80005056:	448080e7          	jalr	1096(ra) # 8000349a <ialloc>
    8000505a:	84aa                	mv	s1,a0
    8000505c:	c529                	beqz	a0,800050a6 <create+0xee>
    8000505e:	ffffe097          	auipc	ra,0xffffe
    80005062:	5d8080e7          	jalr	1496(ra) # 80003636 <ilock>
    80005066:	05549323          	sh	s5,70(s1)
    8000506a:	05449423          	sh	s4,72(s1)
    8000506e:	4785                	li	a5,1
    80005070:	04f49523          	sh	a5,74(s1)
    80005074:	8526                	mv	a0,s1
    80005076:	ffffe097          	auipc	ra,0xffffe
    8000507a:	4f4080e7          	jalr	1268(ra) # 8000356a <iupdate>
    8000507e:	2981                	sext.w	s3,s3
    80005080:	4785                	li	a5,1
    80005082:	02f98a63          	beq	s3,a5,800050b6 <create+0xfe>
    80005086:	40d0                	lw	a2,4(s1)
    80005088:	fb040593          	addi	a1,s0,-80
    8000508c:	854a                	mv	a0,s2
    8000508e:	fffff097          	auipc	ra,0xfffff
    80005092:	c7a080e7          	jalr	-902(ra) # 80003d08 <dirlink>
    80005096:	06054b63          	bltz	a0,8000510c <create+0x154>
    8000509a:	854a                	mv	a0,s2
    8000509c:	ffffe097          	auipc	ra,0xffffe
    800050a0:	7da080e7          	jalr	2010(ra) # 80003876 <iunlockput>
    800050a4:	b759                	j	8000502a <create+0x72>
    800050a6:	00003517          	auipc	a0,0x3
    800050aa:	99a50513          	addi	a0,a0,-1638 # 80007a40 <userret+0x9b0>
    800050ae:	ffffb097          	auipc	ra,0xffffb
    800050b2:	4d0080e7          	jalr	1232(ra) # 8000057e <panic>
    800050b6:	04a95783          	lhu	a5,74(s2)
    800050ba:	2785                	addiw	a5,a5,1
    800050bc:	04f91523          	sh	a5,74(s2)
    800050c0:	854a                	mv	a0,s2
    800050c2:	ffffe097          	auipc	ra,0xffffe
    800050c6:	4a8080e7          	jalr	1192(ra) # 8000356a <iupdate>
    800050ca:	40d0                	lw	a2,4(s1)
    800050cc:	00003597          	auipc	a1,0x3
    800050d0:	98458593          	addi	a1,a1,-1660 # 80007a50 <userret+0x9c0>
    800050d4:	8526                	mv	a0,s1
    800050d6:	fffff097          	auipc	ra,0xfffff
    800050da:	c32080e7          	jalr	-974(ra) # 80003d08 <dirlink>
    800050de:	00054f63          	bltz	a0,800050fc <create+0x144>
    800050e2:	00492603          	lw	a2,4(s2)
    800050e6:	00003597          	auipc	a1,0x3
    800050ea:	97258593          	addi	a1,a1,-1678 # 80007a58 <userret+0x9c8>
    800050ee:	8526                	mv	a0,s1
    800050f0:	fffff097          	auipc	ra,0xfffff
    800050f4:	c18080e7          	jalr	-1000(ra) # 80003d08 <dirlink>
    800050f8:	f80557e3          	bgez	a0,80005086 <create+0xce>
    800050fc:	00003517          	auipc	a0,0x3
    80005100:	96450513          	addi	a0,a0,-1692 # 80007a60 <userret+0x9d0>
    80005104:	ffffb097          	auipc	ra,0xffffb
    80005108:	47a080e7          	jalr	1146(ra) # 8000057e <panic>
    8000510c:	00003517          	auipc	a0,0x3
    80005110:	96450513          	addi	a0,a0,-1692 # 80007a70 <userret+0x9e0>
    80005114:	ffffb097          	auipc	ra,0xffffb
    80005118:	46a080e7          	jalr	1130(ra) # 8000057e <panic>
    8000511c:	84aa                	mv	s1,a0
    8000511e:	b731                	j	8000502a <create+0x72>

0000000080005120 <sys_dup>:
    80005120:	7179                	addi	sp,sp,-48
    80005122:	f406                	sd	ra,40(sp)
    80005124:	f022                	sd	s0,32(sp)
    80005126:	ec26                	sd	s1,24(sp)
    80005128:	1800                	addi	s0,sp,48
    8000512a:	fd840613          	addi	a2,s0,-40
    8000512e:	4581                	li	a1,0
    80005130:	4501                	li	a0,0
    80005132:	00000097          	auipc	ra,0x0
    80005136:	dd6080e7          	jalr	-554(ra) # 80004f08 <argfd>
    8000513a:	57fd                	li	a5,-1
    8000513c:	02054363          	bltz	a0,80005162 <sys_dup+0x42>
    80005140:	fd843503          	ld	a0,-40(s0)
    80005144:	00000097          	auipc	ra,0x0
    80005148:	e2c080e7          	jalr	-468(ra) # 80004f70 <fdalloc>
    8000514c:	84aa                	mv	s1,a0
    8000514e:	57fd                	li	a5,-1
    80005150:	00054963          	bltz	a0,80005162 <sys_dup+0x42>
    80005154:	fd843503          	ld	a0,-40(s0)
    80005158:	fffff097          	auipc	ra,0xfffff
    8000515c:	330080e7          	jalr	816(ra) # 80004488 <filedup>
    80005160:	87a6                	mv	a5,s1
    80005162:	853e                	mv	a0,a5
    80005164:	70a2                	ld	ra,40(sp)
    80005166:	7402                	ld	s0,32(sp)
    80005168:	64e2                	ld	s1,24(sp)
    8000516a:	6145                	addi	sp,sp,48
    8000516c:	8082                	ret

000000008000516e <sys_read>:
    8000516e:	7179                	addi	sp,sp,-48
    80005170:	f406                	sd	ra,40(sp)
    80005172:	f022                	sd	s0,32(sp)
    80005174:	1800                	addi	s0,sp,48
    80005176:	fe840613          	addi	a2,s0,-24
    8000517a:	4581                	li	a1,0
    8000517c:	4501                	li	a0,0
    8000517e:	00000097          	auipc	ra,0x0
    80005182:	d8a080e7          	jalr	-630(ra) # 80004f08 <argfd>
    80005186:	57fd                	li	a5,-1
    80005188:	04054163          	bltz	a0,800051ca <sys_read+0x5c>
    8000518c:	fe440593          	addi	a1,s0,-28
    80005190:	4509                	li	a0,2
    80005192:	ffffe097          	auipc	ra,0xffffe
    80005196:	8e4080e7          	jalr	-1820(ra) # 80002a76 <argint>
    8000519a:	57fd                	li	a5,-1
    8000519c:	02054763          	bltz	a0,800051ca <sys_read+0x5c>
    800051a0:	fd840593          	addi	a1,s0,-40
    800051a4:	4505                	li	a0,1
    800051a6:	ffffe097          	auipc	ra,0xffffe
    800051aa:	8f2080e7          	jalr	-1806(ra) # 80002a98 <argaddr>
    800051ae:	57fd                	li	a5,-1
    800051b0:	00054d63          	bltz	a0,800051ca <sys_read+0x5c>
    800051b4:	fe442603          	lw	a2,-28(s0)
    800051b8:	fd843583          	ld	a1,-40(s0)
    800051bc:	fe843503          	ld	a0,-24(s0)
    800051c0:	fffff097          	auipc	ra,0xfffff
    800051c4:	454080e7          	jalr	1108(ra) # 80004614 <fileread>
    800051c8:	87aa                	mv	a5,a0
    800051ca:	853e                	mv	a0,a5
    800051cc:	70a2                	ld	ra,40(sp)
    800051ce:	7402                	ld	s0,32(sp)
    800051d0:	6145                	addi	sp,sp,48
    800051d2:	8082                	ret

00000000800051d4 <sys_write>:
    800051d4:	7179                	addi	sp,sp,-48
    800051d6:	f406                	sd	ra,40(sp)
    800051d8:	f022                	sd	s0,32(sp)
    800051da:	1800                	addi	s0,sp,48
    800051dc:	fe840613          	addi	a2,s0,-24
    800051e0:	4581                	li	a1,0
    800051e2:	4501                	li	a0,0
    800051e4:	00000097          	auipc	ra,0x0
    800051e8:	d24080e7          	jalr	-732(ra) # 80004f08 <argfd>
    800051ec:	57fd                	li	a5,-1
    800051ee:	04054163          	bltz	a0,80005230 <sys_write+0x5c>
    800051f2:	fe440593          	addi	a1,s0,-28
    800051f6:	4509                	li	a0,2
    800051f8:	ffffe097          	auipc	ra,0xffffe
    800051fc:	87e080e7          	jalr	-1922(ra) # 80002a76 <argint>
    80005200:	57fd                	li	a5,-1
    80005202:	02054763          	bltz	a0,80005230 <sys_write+0x5c>
    80005206:	fd840593          	addi	a1,s0,-40
    8000520a:	4505                	li	a0,1
    8000520c:	ffffe097          	auipc	ra,0xffffe
    80005210:	88c080e7          	jalr	-1908(ra) # 80002a98 <argaddr>
    80005214:	57fd                	li	a5,-1
    80005216:	00054d63          	bltz	a0,80005230 <sys_write+0x5c>
    8000521a:	fe442603          	lw	a2,-28(s0)
    8000521e:	fd843583          	ld	a1,-40(s0)
    80005222:	fe843503          	ld	a0,-24(s0)
    80005226:	fffff097          	auipc	ra,0xfffff
    8000522a:	4b0080e7          	jalr	1200(ra) # 800046d6 <filewrite>
    8000522e:	87aa                	mv	a5,a0
    80005230:	853e                	mv	a0,a5
    80005232:	70a2                	ld	ra,40(sp)
    80005234:	7402                	ld	s0,32(sp)
    80005236:	6145                	addi	sp,sp,48
    80005238:	8082                	ret

000000008000523a <sys_close>:
    8000523a:	1101                	addi	sp,sp,-32
    8000523c:	ec06                	sd	ra,24(sp)
    8000523e:	e822                	sd	s0,16(sp)
    80005240:	1000                	addi	s0,sp,32
    80005242:	fe040613          	addi	a2,s0,-32
    80005246:	fec40593          	addi	a1,s0,-20
    8000524a:	4501                	li	a0,0
    8000524c:	00000097          	auipc	ra,0x0
    80005250:	cbc080e7          	jalr	-836(ra) # 80004f08 <argfd>
    80005254:	57fd                	li	a5,-1
    80005256:	02054463          	bltz	a0,8000527e <sys_close+0x44>
    8000525a:	ffffc097          	auipc	ra,0xffffc
    8000525e:	7c4080e7          	jalr	1988(ra) # 80001a1e <myproc>
    80005262:	fec42783          	lw	a5,-20(s0)
    80005266:	07e9                	addi	a5,a5,26
    80005268:	078e                	slli	a5,a5,0x3
    8000526a:	953e                	add	a0,a0,a5
    8000526c:	00053023          	sd	zero,0(a0)
    80005270:	fe043503          	ld	a0,-32(s0)
    80005274:	fffff097          	auipc	ra,0xfffff
    80005278:	266080e7          	jalr	614(ra) # 800044da <fileclose>
    8000527c:	4781                	li	a5,0
    8000527e:	853e                	mv	a0,a5
    80005280:	60e2                	ld	ra,24(sp)
    80005282:	6442                	ld	s0,16(sp)
    80005284:	6105                	addi	sp,sp,32
    80005286:	8082                	ret

0000000080005288 <sys_fstat>:
    80005288:	1101                	addi	sp,sp,-32
    8000528a:	ec06                	sd	ra,24(sp)
    8000528c:	e822                	sd	s0,16(sp)
    8000528e:	1000                	addi	s0,sp,32
    80005290:	fe840613          	addi	a2,s0,-24
    80005294:	4581                	li	a1,0
    80005296:	4501                	li	a0,0
    80005298:	00000097          	auipc	ra,0x0
    8000529c:	c70080e7          	jalr	-912(ra) # 80004f08 <argfd>
    800052a0:	57fd                	li	a5,-1
    800052a2:	02054563          	bltz	a0,800052cc <sys_fstat+0x44>
    800052a6:	fe040593          	addi	a1,s0,-32
    800052aa:	4505                	li	a0,1
    800052ac:	ffffd097          	auipc	ra,0xffffd
    800052b0:	7ec080e7          	jalr	2028(ra) # 80002a98 <argaddr>
    800052b4:	57fd                	li	a5,-1
    800052b6:	00054b63          	bltz	a0,800052cc <sys_fstat+0x44>
    800052ba:	fe043583          	ld	a1,-32(s0)
    800052be:	fe843503          	ld	a0,-24(s0)
    800052c2:	fffff097          	auipc	ra,0xfffff
    800052c6:	2e0080e7          	jalr	736(ra) # 800045a2 <filestat>
    800052ca:	87aa                	mv	a5,a0
    800052cc:	853e                	mv	a0,a5
    800052ce:	60e2                	ld	ra,24(sp)
    800052d0:	6442                	ld	s0,16(sp)
    800052d2:	6105                	addi	sp,sp,32
    800052d4:	8082                	ret

00000000800052d6 <sys_link>:
    800052d6:	7169                	addi	sp,sp,-304
    800052d8:	f606                	sd	ra,296(sp)
    800052da:	f222                	sd	s0,288(sp)
    800052dc:	ee26                	sd	s1,280(sp)
    800052de:	ea4a                	sd	s2,272(sp)
    800052e0:	1a00                	addi	s0,sp,304
    800052e2:	08000613          	li	a2,128
    800052e6:	ed040593          	addi	a1,s0,-304
    800052ea:	4501                	li	a0,0
    800052ec:	ffffd097          	auipc	ra,0xffffd
    800052f0:	7ce080e7          	jalr	1998(ra) # 80002aba <argstr>
    800052f4:	57fd                	li	a5,-1
    800052f6:	10054e63          	bltz	a0,80005412 <sys_link+0x13c>
    800052fa:	08000613          	li	a2,128
    800052fe:	f5040593          	addi	a1,s0,-176
    80005302:	4505                	li	a0,1
    80005304:	ffffd097          	auipc	ra,0xffffd
    80005308:	7b6080e7          	jalr	1974(ra) # 80002aba <argstr>
    8000530c:	57fd                	li	a5,-1
    8000530e:	10054263          	bltz	a0,80005412 <sys_link+0x13c>
    80005312:	fffff097          	auipc	ra,0xfffff
    80005316:	cc6080e7          	jalr	-826(ra) # 80003fd8 <begin_op>
    8000531a:	ed040513          	addi	a0,s0,-304
    8000531e:	fffff097          	auipc	ra,0xfffff
    80005322:	aac080e7          	jalr	-1364(ra) # 80003dca <namei>
    80005326:	84aa                	mv	s1,a0
    80005328:	c551                	beqz	a0,800053b4 <sys_link+0xde>
    8000532a:	ffffe097          	auipc	ra,0xffffe
    8000532e:	30c080e7          	jalr	780(ra) # 80003636 <ilock>
    80005332:	04449703          	lh	a4,68(s1)
    80005336:	4785                	li	a5,1
    80005338:	08f70463          	beq	a4,a5,800053c0 <sys_link+0xea>
    8000533c:	04a4d783          	lhu	a5,74(s1)
    80005340:	2785                	addiw	a5,a5,1
    80005342:	04f49523          	sh	a5,74(s1)
    80005346:	8526                	mv	a0,s1
    80005348:	ffffe097          	auipc	ra,0xffffe
    8000534c:	222080e7          	jalr	546(ra) # 8000356a <iupdate>
    80005350:	8526                	mv	a0,s1
    80005352:	ffffe097          	auipc	ra,0xffffe
    80005356:	3a8080e7          	jalr	936(ra) # 800036fa <iunlock>
    8000535a:	fd040593          	addi	a1,s0,-48
    8000535e:	f5040513          	addi	a0,s0,-176
    80005362:	fffff097          	auipc	ra,0xfffff
    80005366:	a86080e7          	jalr	-1402(ra) # 80003de8 <nameiparent>
    8000536a:	892a                	mv	s2,a0
    8000536c:	c935                	beqz	a0,800053e0 <sys_link+0x10a>
    8000536e:	ffffe097          	auipc	ra,0xffffe
    80005372:	2c8080e7          	jalr	712(ra) # 80003636 <ilock>
    80005376:	00092703          	lw	a4,0(s2)
    8000537a:	409c                	lw	a5,0(s1)
    8000537c:	04f71d63          	bne	a4,a5,800053d6 <sys_link+0x100>
    80005380:	40d0                	lw	a2,4(s1)
    80005382:	fd040593          	addi	a1,s0,-48
    80005386:	854a                	mv	a0,s2
    80005388:	fffff097          	auipc	ra,0xfffff
    8000538c:	980080e7          	jalr	-1664(ra) # 80003d08 <dirlink>
    80005390:	04054363          	bltz	a0,800053d6 <sys_link+0x100>
    80005394:	854a                	mv	a0,s2
    80005396:	ffffe097          	auipc	ra,0xffffe
    8000539a:	4e0080e7          	jalr	1248(ra) # 80003876 <iunlockput>
    8000539e:	8526                	mv	a0,s1
    800053a0:	ffffe097          	auipc	ra,0xffffe
    800053a4:	3a6080e7          	jalr	934(ra) # 80003746 <iput>
    800053a8:	fffff097          	auipc	ra,0xfffff
    800053ac:	cb0080e7          	jalr	-848(ra) # 80004058 <end_op>
    800053b0:	4781                	li	a5,0
    800053b2:	a085                	j	80005412 <sys_link+0x13c>
    800053b4:	fffff097          	auipc	ra,0xfffff
    800053b8:	ca4080e7          	jalr	-860(ra) # 80004058 <end_op>
    800053bc:	57fd                	li	a5,-1
    800053be:	a891                	j	80005412 <sys_link+0x13c>
    800053c0:	8526                	mv	a0,s1
    800053c2:	ffffe097          	auipc	ra,0xffffe
    800053c6:	4b4080e7          	jalr	1204(ra) # 80003876 <iunlockput>
    800053ca:	fffff097          	auipc	ra,0xfffff
    800053ce:	c8e080e7          	jalr	-882(ra) # 80004058 <end_op>
    800053d2:	57fd                	li	a5,-1
    800053d4:	a83d                	j	80005412 <sys_link+0x13c>
    800053d6:	854a                	mv	a0,s2
    800053d8:	ffffe097          	auipc	ra,0xffffe
    800053dc:	49e080e7          	jalr	1182(ra) # 80003876 <iunlockput>
    800053e0:	8526                	mv	a0,s1
    800053e2:	ffffe097          	auipc	ra,0xffffe
    800053e6:	254080e7          	jalr	596(ra) # 80003636 <ilock>
    800053ea:	04a4d783          	lhu	a5,74(s1)
    800053ee:	37fd                	addiw	a5,a5,-1
    800053f0:	04f49523          	sh	a5,74(s1)
    800053f4:	8526                	mv	a0,s1
    800053f6:	ffffe097          	auipc	ra,0xffffe
    800053fa:	174080e7          	jalr	372(ra) # 8000356a <iupdate>
    800053fe:	8526                	mv	a0,s1
    80005400:	ffffe097          	auipc	ra,0xffffe
    80005404:	476080e7          	jalr	1142(ra) # 80003876 <iunlockput>
    80005408:	fffff097          	auipc	ra,0xfffff
    8000540c:	c50080e7          	jalr	-944(ra) # 80004058 <end_op>
    80005410:	57fd                	li	a5,-1
    80005412:	853e                	mv	a0,a5
    80005414:	70b2                	ld	ra,296(sp)
    80005416:	7412                	ld	s0,288(sp)
    80005418:	64f2                	ld	s1,280(sp)
    8000541a:	6952                	ld	s2,272(sp)
    8000541c:	6155                	addi	sp,sp,304
    8000541e:	8082                	ret

0000000080005420 <sys_unlink>:
    80005420:	7151                	addi	sp,sp,-240
    80005422:	f586                	sd	ra,232(sp)
    80005424:	f1a2                	sd	s0,224(sp)
    80005426:	eda6                	sd	s1,216(sp)
    80005428:	e9ca                	sd	s2,208(sp)
    8000542a:	e5ce                	sd	s3,200(sp)
    8000542c:	1980                	addi	s0,sp,240
    8000542e:	08000613          	li	a2,128
    80005432:	f3040593          	addi	a1,s0,-208
    80005436:	4501                	li	a0,0
    80005438:	ffffd097          	auipc	ra,0xffffd
    8000543c:	682080e7          	jalr	1666(ra) # 80002aba <argstr>
    80005440:	16054f63          	bltz	a0,800055be <sys_unlink+0x19e>
    80005444:	fffff097          	auipc	ra,0xfffff
    80005448:	b94080e7          	jalr	-1132(ra) # 80003fd8 <begin_op>
    8000544c:	fb040593          	addi	a1,s0,-80
    80005450:	f3040513          	addi	a0,s0,-208
    80005454:	fffff097          	auipc	ra,0xfffff
    80005458:	994080e7          	jalr	-1644(ra) # 80003de8 <nameiparent>
    8000545c:	89aa                	mv	s3,a0
    8000545e:	c979                	beqz	a0,80005534 <sys_unlink+0x114>
    80005460:	ffffe097          	auipc	ra,0xffffe
    80005464:	1d6080e7          	jalr	470(ra) # 80003636 <ilock>
    80005468:	00002597          	auipc	a1,0x2
    8000546c:	5e858593          	addi	a1,a1,1512 # 80007a50 <userret+0x9c0>
    80005470:	fb040513          	addi	a0,s0,-80
    80005474:	ffffe097          	auipc	ra,0xffffe
    80005478:	662080e7          	jalr	1634(ra) # 80003ad6 <namecmp>
    8000547c:	14050863          	beqz	a0,800055cc <sys_unlink+0x1ac>
    80005480:	00002597          	auipc	a1,0x2
    80005484:	5d858593          	addi	a1,a1,1496 # 80007a58 <userret+0x9c8>
    80005488:	fb040513          	addi	a0,s0,-80
    8000548c:	ffffe097          	auipc	ra,0xffffe
    80005490:	64a080e7          	jalr	1610(ra) # 80003ad6 <namecmp>
    80005494:	12050c63          	beqz	a0,800055cc <sys_unlink+0x1ac>
    80005498:	f2c40613          	addi	a2,s0,-212
    8000549c:	fb040593          	addi	a1,s0,-80
    800054a0:	854e                	mv	a0,s3
    800054a2:	ffffe097          	auipc	ra,0xffffe
    800054a6:	64e080e7          	jalr	1614(ra) # 80003af0 <dirlookup>
    800054aa:	84aa                	mv	s1,a0
    800054ac:	12050063          	beqz	a0,800055cc <sys_unlink+0x1ac>
    800054b0:	ffffe097          	auipc	ra,0xffffe
    800054b4:	186080e7          	jalr	390(ra) # 80003636 <ilock>
    800054b8:	04a49783          	lh	a5,74(s1)
    800054bc:	08f05263          	blez	a5,80005540 <sys_unlink+0x120>
    800054c0:	04449703          	lh	a4,68(s1)
    800054c4:	4785                	li	a5,1
    800054c6:	08f70563          	beq	a4,a5,80005550 <sys_unlink+0x130>
    800054ca:	4641                	li	a2,16
    800054cc:	4581                	li	a1,0
    800054ce:	fc040513          	addi	a0,s0,-64
    800054d2:	ffffb097          	auipc	ra,0xffffb
    800054d6:	6c8080e7          	jalr	1736(ra) # 80000b9a <memset>
    800054da:	4741                	li	a4,16
    800054dc:	f2c42683          	lw	a3,-212(s0)
    800054e0:	fc040613          	addi	a2,s0,-64
    800054e4:	4581                	li	a1,0
    800054e6:	854e                	mv	a0,s3
    800054e8:	ffffe097          	auipc	ra,0xffffe
    800054ec:	4d4080e7          	jalr	1236(ra) # 800039bc <writei>
    800054f0:	47c1                	li	a5,16
    800054f2:	0af51363          	bne	a0,a5,80005598 <sys_unlink+0x178>
    800054f6:	04449703          	lh	a4,68(s1)
    800054fa:	4785                	li	a5,1
    800054fc:	0af70663          	beq	a4,a5,800055a8 <sys_unlink+0x188>
    80005500:	854e                	mv	a0,s3
    80005502:	ffffe097          	auipc	ra,0xffffe
    80005506:	374080e7          	jalr	884(ra) # 80003876 <iunlockput>
    8000550a:	04a4d783          	lhu	a5,74(s1)
    8000550e:	37fd                	addiw	a5,a5,-1
    80005510:	04f49523          	sh	a5,74(s1)
    80005514:	8526                	mv	a0,s1
    80005516:	ffffe097          	auipc	ra,0xffffe
    8000551a:	054080e7          	jalr	84(ra) # 8000356a <iupdate>
    8000551e:	8526                	mv	a0,s1
    80005520:	ffffe097          	auipc	ra,0xffffe
    80005524:	356080e7          	jalr	854(ra) # 80003876 <iunlockput>
    80005528:	fffff097          	auipc	ra,0xfffff
    8000552c:	b30080e7          	jalr	-1232(ra) # 80004058 <end_op>
    80005530:	4501                	li	a0,0
    80005532:	a07d                	j	800055e0 <sys_unlink+0x1c0>
    80005534:	fffff097          	auipc	ra,0xfffff
    80005538:	b24080e7          	jalr	-1244(ra) # 80004058 <end_op>
    8000553c:	557d                	li	a0,-1
    8000553e:	a04d                	j	800055e0 <sys_unlink+0x1c0>
    80005540:	00002517          	auipc	a0,0x2
    80005544:	54050513          	addi	a0,a0,1344 # 80007a80 <userret+0x9f0>
    80005548:	ffffb097          	auipc	ra,0xffffb
    8000554c:	036080e7          	jalr	54(ra) # 8000057e <panic>
    80005550:	44f8                	lw	a4,76(s1)
    80005552:	02000793          	li	a5,32
    80005556:	f6e7fae3          	bleu	a4,a5,800054ca <sys_unlink+0xaa>
    8000555a:	02000913          	li	s2,32
    8000555e:	4741                	li	a4,16
    80005560:	86ca                	mv	a3,s2
    80005562:	f1840613          	addi	a2,s0,-232
    80005566:	4581                	li	a1,0
    80005568:	8526                	mv	a0,s1
    8000556a:	ffffe097          	auipc	ra,0xffffe
    8000556e:	35e080e7          	jalr	862(ra) # 800038c8 <readi>
    80005572:	47c1                	li	a5,16
    80005574:	00f51a63          	bne	a0,a5,80005588 <sys_unlink+0x168>
    80005578:	f1845783          	lhu	a5,-232(s0)
    8000557c:	e3b9                	bnez	a5,800055c2 <sys_unlink+0x1a2>
    8000557e:	2941                	addiw	s2,s2,16
    80005580:	44fc                	lw	a5,76(s1)
    80005582:	fcf96ee3          	bltu	s2,a5,8000555e <sys_unlink+0x13e>
    80005586:	b791                	j	800054ca <sys_unlink+0xaa>
    80005588:	00002517          	auipc	a0,0x2
    8000558c:	51050513          	addi	a0,a0,1296 # 80007a98 <userret+0xa08>
    80005590:	ffffb097          	auipc	ra,0xffffb
    80005594:	fee080e7          	jalr	-18(ra) # 8000057e <panic>
    80005598:	00002517          	auipc	a0,0x2
    8000559c:	51850513          	addi	a0,a0,1304 # 80007ab0 <userret+0xa20>
    800055a0:	ffffb097          	auipc	ra,0xffffb
    800055a4:	fde080e7          	jalr	-34(ra) # 8000057e <panic>
    800055a8:	04a9d783          	lhu	a5,74(s3)
    800055ac:	37fd                	addiw	a5,a5,-1
    800055ae:	04f99523          	sh	a5,74(s3)
    800055b2:	854e                	mv	a0,s3
    800055b4:	ffffe097          	auipc	ra,0xffffe
    800055b8:	fb6080e7          	jalr	-74(ra) # 8000356a <iupdate>
    800055bc:	b791                	j	80005500 <sys_unlink+0xe0>
    800055be:	557d                	li	a0,-1
    800055c0:	a005                	j	800055e0 <sys_unlink+0x1c0>
    800055c2:	8526                	mv	a0,s1
    800055c4:	ffffe097          	auipc	ra,0xffffe
    800055c8:	2b2080e7          	jalr	690(ra) # 80003876 <iunlockput>
    800055cc:	854e                	mv	a0,s3
    800055ce:	ffffe097          	auipc	ra,0xffffe
    800055d2:	2a8080e7          	jalr	680(ra) # 80003876 <iunlockput>
    800055d6:	fffff097          	auipc	ra,0xfffff
    800055da:	a82080e7          	jalr	-1406(ra) # 80004058 <end_op>
    800055de:	557d                	li	a0,-1
    800055e0:	70ae                	ld	ra,232(sp)
    800055e2:	740e                	ld	s0,224(sp)
    800055e4:	64ee                	ld	s1,216(sp)
    800055e6:	694e                	ld	s2,208(sp)
    800055e8:	69ae                	ld	s3,200(sp)
    800055ea:	616d                	addi	sp,sp,240
    800055ec:	8082                	ret

00000000800055ee <sys_open>:
    800055ee:	7131                	addi	sp,sp,-192
    800055f0:	fd06                	sd	ra,184(sp)
    800055f2:	f922                	sd	s0,176(sp)
    800055f4:	f526                	sd	s1,168(sp)
    800055f6:	f14a                	sd	s2,160(sp)
    800055f8:	ed4e                	sd	s3,152(sp)
    800055fa:	0180                	addi	s0,sp,192
    800055fc:	08000613          	li	a2,128
    80005600:	f5040593          	addi	a1,s0,-176
    80005604:	4501                	li	a0,0
    80005606:	ffffd097          	auipc	ra,0xffffd
    8000560a:	4b4080e7          	jalr	1204(ra) # 80002aba <argstr>
    8000560e:	54fd                	li	s1,-1
    80005610:	0a054763          	bltz	a0,800056be <sys_open+0xd0>
    80005614:	f4c40593          	addi	a1,s0,-180
    80005618:	4505                	li	a0,1
    8000561a:	ffffd097          	auipc	ra,0xffffd
    8000561e:	45c080e7          	jalr	1116(ra) # 80002a76 <argint>
    80005622:	08054e63          	bltz	a0,800056be <sys_open+0xd0>
    80005626:	fffff097          	auipc	ra,0xfffff
    8000562a:	9b2080e7          	jalr	-1614(ra) # 80003fd8 <begin_op>
    8000562e:	f4c42783          	lw	a5,-180(s0)
    80005632:	2007f793          	andi	a5,a5,512
    80005636:	c3cd                	beqz	a5,800056d8 <sys_open+0xea>
    80005638:	4681                	li	a3,0
    8000563a:	4601                	li	a2,0
    8000563c:	4589                	li	a1,2
    8000563e:	f5040513          	addi	a0,s0,-176
    80005642:	00000097          	auipc	ra,0x0
    80005646:	976080e7          	jalr	-1674(ra) # 80004fb8 <create>
    8000564a:	892a                	mv	s2,a0
    8000564c:	c149                	beqz	a0,800056ce <sys_open+0xe0>
    8000564e:	04491703          	lh	a4,68(s2)
    80005652:	478d                	li	a5,3
    80005654:	00f71763          	bne	a4,a5,80005662 <sys_open+0x74>
    80005658:	04695703          	lhu	a4,70(s2)
    8000565c:	47a5                	li	a5,9
    8000565e:	0ce7e263          	bltu	a5,a4,80005722 <sys_open+0x134>
    80005662:	fffff097          	auipc	ra,0xfffff
    80005666:	da8080e7          	jalr	-600(ra) # 8000440a <filealloc>
    8000566a:	89aa                	mv	s3,a0
    8000566c:	c175                	beqz	a0,80005750 <sys_open+0x162>
    8000566e:	00000097          	auipc	ra,0x0
    80005672:	902080e7          	jalr	-1790(ra) # 80004f70 <fdalloc>
    80005676:	84aa                	mv	s1,a0
    80005678:	0c054763          	bltz	a0,80005746 <sys_open+0x158>
    8000567c:	04491703          	lh	a4,68(s2)
    80005680:	478d                	li	a5,3
    80005682:	0af70b63          	beq	a4,a5,80005738 <sys_open+0x14a>
    80005686:	4789                	li	a5,2
    80005688:	00f9a023          	sw	a5,0(s3)
    8000568c:	0209a023          	sw	zero,32(s3)
    80005690:	0129bc23          	sd	s2,24(s3)
    80005694:	f4c42783          	lw	a5,-180(s0)
    80005698:	0017c713          	xori	a4,a5,1
    8000569c:	8b05                	andi	a4,a4,1
    8000569e:	00e98423          	sb	a4,8(s3)
    800056a2:	8b8d                	andi	a5,a5,3
    800056a4:	00f037b3          	snez	a5,a5
    800056a8:	00f984a3          	sb	a5,9(s3)
    800056ac:	854a                	mv	a0,s2
    800056ae:	ffffe097          	auipc	ra,0xffffe
    800056b2:	04c080e7          	jalr	76(ra) # 800036fa <iunlock>
    800056b6:	fffff097          	auipc	ra,0xfffff
    800056ba:	9a2080e7          	jalr	-1630(ra) # 80004058 <end_op>
    800056be:	8526                	mv	a0,s1
    800056c0:	70ea                	ld	ra,184(sp)
    800056c2:	744a                	ld	s0,176(sp)
    800056c4:	74aa                	ld	s1,168(sp)
    800056c6:	790a                	ld	s2,160(sp)
    800056c8:	69ea                	ld	s3,152(sp)
    800056ca:	6129                	addi	sp,sp,192
    800056cc:	8082                	ret
    800056ce:	fffff097          	auipc	ra,0xfffff
    800056d2:	98a080e7          	jalr	-1654(ra) # 80004058 <end_op>
    800056d6:	b7e5                	j	800056be <sys_open+0xd0>
    800056d8:	f5040513          	addi	a0,s0,-176
    800056dc:	ffffe097          	auipc	ra,0xffffe
    800056e0:	6ee080e7          	jalr	1774(ra) # 80003dca <namei>
    800056e4:	892a                	mv	s2,a0
    800056e6:	c905                	beqz	a0,80005716 <sys_open+0x128>
    800056e8:	ffffe097          	auipc	ra,0xffffe
    800056ec:	f4e080e7          	jalr	-178(ra) # 80003636 <ilock>
    800056f0:	04491703          	lh	a4,68(s2)
    800056f4:	4785                	li	a5,1
    800056f6:	f4f71ce3          	bne	a4,a5,8000564e <sys_open+0x60>
    800056fa:	f4c42783          	lw	a5,-180(s0)
    800056fe:	d3b5                	beqz	a5,80005662 <sys_open+0x74>
    80005700:	854a                	mv	a0,s2
    80005702:	ffffe097          	auipc	ra,0xffffe
    80005706:	174080e7          	jalr	372(ra) # 80003876 <iunlockput>
    8000570a:	fffff097          	auipc	ra,0xfffff
    8000570e:	94e080e7          	jalr	-1714(ra) # 80004058 <end_op>
    80005712:	54fd                	li	s1,-1
    80005714:	b76d                	j	800056be <sys_open+0xd0>
    80005716:	fffff097          	auipc	ra,0xfffff
    8000571a:	942080e7          	jalr	-1726(ra) # 80004058 <end_op>
    8000571e:	54fd                	li	s1,-1
    80005720:	bf79                	j	800056be <sys_open+0xd0>
    80005722:	854a                	mv	a0,s2
    80005724:	ffffe097          	auipc	ra,0xffffe
    80005728:	152080e7          	jalr	338(ra) # 80003876 <iunlockput>
    8000572c:	fffff097          	auipc	ra,0xfffff
    80005730:	92c080e7          	jalr	-1748(ra) # 80004058 <end_op>
    80005734:	54fd                	li	s1,-1
    80005736:	b761                	j	800056be <sys_open+0xd0>
    80005738:	00f9a023          	sw	a5,0(s3)
    8000573c:	04691783          	lh	a5,70(s2)
    80005740:	02f99223          	sh	a5,36(s3)
    80005744:	b7b1                	j	80005690 <sys_open+0xa2>
    80005746:	854e                	mv	a0,s3
    80005748:	fffff097          	auipc	ra,0xfffff
    8000574c:	d92080e7          	jalr	-622(ra) # 800044da <fileclose>
    80005750:	854a                	mv	a0,s2
    80005752:	ffffe097          	auipc	ra,0xffffe
    80005756:	124080e7          	jalr	292(ra) # 80003876 <iunlockput>
    8000575a:	fffff097          	auipc	ra,0xfffff
    8000575e:	8fe080e7          	jalr	-1794(ra) # 80004058 <end_op>
    80005762:	54fd                	li	s1,-1
    80005764:	bfa9                	j	800056be <sys_open+0xd0>

0000000080005766 <sys_mkdir>:
    80005766:	7175                	addi	sp,sp,-144
    80005768:	e506                	sd	ra,136(sp)
    8000576a:	e122                	sd	s0,128(sp)
    8000576c:	0900                	addi	s0,sp,144
    8000576e:	fffff097          	auipc	ra,0xfffff
    80005772:	86a080e7          	jalr	-1942(ra) # 80003fd8 <begin_op>
    80005776:	08000613          	li	a2,128
    8000577a:	f7040593          	addi	a1,s0,-144
    8000577e:	4501                	li	a0,0
    80005780:	ffffd097          	auipc	ra,0xffffd
    80005784:	33a080e7          	jalr	826(ra) # 80002aba <argstr>
    80005788:	02054963          	bltz	a0,800057ba <sys_mkdir+0x54>
    8000578c:	4681                	li	a3,0
    8000578e:	4601                	li	a2,0
    80005790:	4585                	li	a1,1
    80005792:	f7040513          	addi	a0,s0,-144
    80005796:	00000097          	auipc	ra,0x0
    8000579a:	822080e7          	jalr	-2014(ra) # 80004fb8 <create>
    8000579e:	cd11                	beqz	a0,800057ba <sys_mkdir+0x54>
    800057a0:	ffffe097          	auipc	ra,0xffffe
    800057a4:	0d6080e7          	jalr	214(ra) # 80003876 <iunlockput>
    800057a8:	fffff097          	auipc	ra,0xfffff
    800057ac:	8b0080e7          	jalr	-1872(ra) # 80004058 <end_op>
    800057b0:	4501                	li	a0,0
    800057b2:	60aa                	ld	ra,136(sp)
    800057b4:	640a                	ld	s0,128(sp)
    800057b6:	6149                	addi	sp,sp,144
    800057b8:	8082                	ret
    800057ba:	fffff097          	auipc	ra,0xfffff
    800057be:	89e080e7          	jalr	-1890(ra) # 80004058 <end_op>
    800057c2:	557d                	li	a0,-1
    800057c4:	b7fd                	j	800057b2 <sys_mkdir+0x4c>

00000000800057c6 <sys_mknod>:
    800057c6:	7135                	addi	sp,sp,-160
    800057c8:	ed06                	sd	ra,152(sp)
    800057ca:	e922                	sd	s0,144(sp)
    800057cc:	1100                	addi	s0,sp,160
    800057ce:	fffff097          	auipc	ra,0xfffff
    800057d2:	80a080e7          	jalr	-2038(ra) # 80003fd8 <begin_op>
    800057d6:	08000613          	li	a2,128
    800057da:	f7040593          	addi	a1,s0,-144
    800057de:	4501                	li	a0,0
    800057e0:	ffffd097          	auipc	ra,0xffffd
    800057e4:	2da080e7          	jalr	730(ra) # 80002aba <argstr>
    800057e8:	04054a63          	bltz	a0,8000583c <sys_mknod+0x76>
    800057ec:	f6c40593          	addi	a1,s0,-148
    800057f0:	4505                	li	a0,1
    800057f2:	ffffd097          	auipc	ra,0xffffd
    800057f6:	284080e7          	jalr	644(ra) # 80002a76 <argint>
    800057fa:	04054163          	bltz	a0,8000583c <sys_mknod+0x76>
    800057fe:	f6840593          	addi	a1,s0,-152
    80005802:	4509                	li	a0,2
    80005804:	ffffd097          	auipc	ra,0xffffd
    80005808:	272080e7          	jalr	626(ra) # 80002a76 <argint>
    8000580c:	02054863          	bltz	a0,8000583c <sys_mknod+0x76>
    80005810:	f6841683          	lh	a3,-152(s0)
    80005814:	f6c41603          	lh	a2,-148(s0)
    80005818:	458d                	li	a1,3
    8000581a:	f7040513          	addi	a0,s0,-144
    8000581e:	fffff097          	auipc	ra,0xfffff
    80005822:	79a080e7          	jalr	1946(ra) # 80004fb8 <create>
    80005826:	c919                	beqz	a0,8000583c <sys_mknod+0x76>
    80005828:	ffffe097          	auipc	ra,0xffffe
    8000582c:	04e080e7          	jalr	78(ra) # 80003876 <iunlockput>
    80005830:	fffff097          	auipc	ra,0xfffff
    80005834:	828080e7          	jalr	-2008(ra) # 80004058 <end_op>
    80005838:	4501                	li	a0,0
    8000583a:	a031                	j	80005846 <sys_mknod+0x80>
    8000583c:	fffff097          	auipc	ra,0xfffff
    80005840:	81c080e7          	jalr	-2020(ra) # 80004058 <end_op>
    80005844:	557d                	li	a0,-1
    80005846:	60ea                	ld	ra,152(sp)
    80005848:	644a                	ld	s0,144(sp)
    8000584a:	610d                	addi	sp,sp,160
    8000584c:	8082                	ret

000000008000584e <sys_chdir>:
    8000584e:	7135                	addi	sp,sp,-160
    80005850:	ed06                	sd	ra,152(sp)
    80005852:	e922                	sd	s0,144(sp)
    80005854:	e526                	sd	s1,136(sp)
    80005856:	e14a                	sd	s2,128(sp)
    80005858:	1100                	addi	s0,sp,160
    8000585a:	ffffc097          	auipc	ra,0xffffc
    8000585e:	1c4080e7          	jalr	452(ra) # 80001a1e <myproc>
    80005862:	892a                	mv	s2,a0
    80005864:	ffffe097          	auipc	ra,0xffffe
    80005868:	774080e7          	jalr	1908(ra) # 80003fd8 <begin_op>
    8000586c:	08000613          	li	a2,128
    80005870:	f6040593          	addi	a1,s0,-160
    80005874:	4501                	li	a0,0
    80005876:	ffffd097          	auipc	ra,0xffffd
    8000587a:	244080e7          	jalr	580(ra) # 80002aba <argstr>
    8000587e:	04054b63          	bltz	a0,800058d4 <sys_chdir+0x86>
    80005882:	f6040513          	addi	a0,s0,-160
    80005886:	ffffe097          	auipc	ra,0xffffe
    8000588a:	544080e7          	jalr	1348(ra) # 80003dca <namei>
    8000588e:	84aa                	mv	s1,a0
    80005890:	c131                	beqz	a0,800058d4 <sys_chdir+0x86>
    80005892:	ffffe097          	auipc	ra,0xffffe
    80005896:	da4080e7          	jalr	-604(ra) # 80003636 <ilock>
    8000589a:	04449703          	lh	a4,68(s1)
    8000589e:	4785                	li	a5,1
    800058a0:	04f71063          	bne	a4,a5,800058e0 <sys_chdir+0x92>
    800058a4:	8526                	mv	a0,s1
    800058a6:	ffffe097          	auipc	ra,0xffffe
    800058aa:	e54080e7          	jalr	-428(ra) # 800036fa <iunlock>
    800058ae:	15093503          	ld	a0,336(s2)
    800058b2:	ffffe097          	auipc	ra,0xffffe
    800058b6:	e94080e7          	jalr	-364(ra) # 80003746 <iput>
    800058ba:	ffffe097          	auipc	ra,0xffffe
    800058be:	79e080e7          	jalr	1950(ra) # 80004058 <end_op>
    800058c2:	14993823          	sd	s1,336(s2)
    800058c6:	4501                	li	a0,0
    800058c8:	60ea                	ld	ra,152(sp)
    800058ca:	644a                	ld	s0,144(sp)
    800058cc:	64aa                	ld	s1,136(sp)
    800058ce:	690a                	ld	s2,128(sp)
    800058d0:	610d                	addi	sp,sp,160
    800058d2:	8082                	ret
    800058d4:	ffffe097          	auipc	ra,0xffffe
    800058d8:	784080e7          	jalr	1924(ra) # 80004058 <end_op>
    800058dc:	557d                	li	a0,-1
    800058de:	b7ed                	j	800058c8 <sys_chdir+0x7a>
    800058e0:	8526                	mv	a0,s1
    800058e2:	ffffe097          	auipc	ra,0xffffe
    800058e6:	f94080e7          	jalr	-108(ra) # 80003876 <iunlockput>
    800058ea:	ffffe097          	auipc	ra,0xffffe
    800058ee:	76e080e7          	jalr	1902(ra) # 80004058 <end_op>
    800058f2:	557d                	li	a0,-1
    800058f4:	bfd1                	j	800058c8 <sys_chdir+0x7a>

00000000800058f6 <sys_exec>:
    800058f6:	7145                	addi	sp,sp,-464
    800058f8:	e786                	sd	ra,456(sp)
    800058fa:	e3a2                	sd	s0,448(sp)
    800058fc:	ff26                	sd	s1,440(sp)
    800058fe:	fb4a                	sd	s2,432(sp)
    80005900:	f74e                	sd	s3,424(sp)
    80005902:	f352                	sd	s4,416(sp)
    80005904:	ef56                	sd	s5,408(sp)
    80005906:	0b80                	addi	s0,sp,464
    80005908:	08000613          	li	a2,128
    8000590c:	f4040593          	addi	a1,s0,-192
    80005910:	4501                	li	a0,0
    80005912:	ffffd097          	auipc	ra,0xffffd
    80005916:	1a8080e7          	jalr	424(ra) # 80002aba <argstr>
    8000591a:	10054763          	bltz	a0,80005a28 <sys_exec+0x132>
    8000591e:	e3840593          	addi	a1,s0,-456
    80005922:	4505                	li	a0,1
    80005924:	ffffd097          	auipc	ra,0xffffd
    80005928:	174080e7          	jalr	372(ra) # 80002a98 <argaddr>
    8000592c:	10054863          	bltz	a0,80005a3c <sys_exec+0x146>
    80005930:	e4040913          	addi	s2,s0,-448
    80005934:	10000613          	li	a2,256
    80005938:	4581                	li	a1,0
    8000593a:	854a                	mv	a0,s2
    8000593c:	ffffb097          	auipc	ra,0xffffb
    80005940:	25e080e7          	jalr	606(ra) # 80000b9a <memset>
    80005944:	89ca                	mv	s3,s2
    80005946:	4481                	li	s1,0
    80005948:	02000a93          	li	s5,32
    8000594c:	00048a1b          	sext.w	s4,s1
    80005950:	00349513          	slli	a0,s1,0x3
    80005954:	e3040593          	addi	a1,s0,-464
    80005958:	e3843783          	ld	a5,-456(s0)
    8000595c:	953e                	add	a0,a0,a5
    8000595e:	ffffd097          	auipc	ra,0xffffd
    80005962:	07c080e7          	jalr	124(ra) # 800029da <fetchaddr>
    80005966:	02054a63          	bltz	a0,8000599a <sys_exec+0xa4>
    8000596a:	e3043783          	ld	a5,-464(s0)
    8000596e:	cfa1                	beqz	a5,800059c6 <sys_exec+0xd0>
    80005970:	ffffb097          	auipc	ra,0xffffb
    80005974:	020080e7          	jalr	32(ra) # 80000990 <kalloc>
    80005978:	85aa                	mv	a1,a0
    8000597a:	00a93023          	sd	a0,0(s2)
    8000597e:	c949                	beqz	a0,80005a10 <sys_exec+0x11a>
    80005980:	6605                	lui	a2,0x1
    80005982:	e3043503          	ld	a0,-464(s0)
    80005986:	ffffd097          	auipc	ra,0xffffd
    8000598a:	0a8080e7          	jalr	168(ra) # 80002a2e <fetchstr>
    8000598e:	00054663          	bltz	a0,8000599a <sys_exec+0xa4>
    80005992:	0485                	addi	s1,s1,1
    80005994:	0921                	addi	s2,s2,8
    80005996:	fb549be3          	bne	s1,s5,8000594c <sys_exec+0x56>
    8000599a:	e4043503          	ld	a0,-448(s0)
    8000599e:	c149                	beqz	a0,80005a20 <sys_exec+0x12a>
    800059a0:	ffffb097          	auipc	ra,0xffffb
    800059a4:	ef0080e7          	jalr	-272(ra) # 80000890 <kfree>
    800059a8:	e4840493          	addi	s1,s0,-440
    800059ac:	10098993          	addi	s3,s3,256
    800059b0:	6088                	ld	a0,0(s1)
    800059b2:	c92d                	beqz	a0,80005a24 <sys_exec+0x12e>
    800059b4:	ffffb097          	auipc	ra,0xffffb
    800059b8:	edc080e7          	jalr	-292(ra) # 80000890 <kfree>
    800059bc:	04a1                	addi	s1,s1,8
    800059be:	ff3499e3          	bne	s1,s3,800059b0 <sys_exec+0xba>
    800059c2:	557d                	li	a0,-1
    800059c4:	a09d                	j	80005a2a <sys_exec+0x134>
    800059c6:	0a0e                	slli	s4,s4,0x3
    800059c8:	fc040793          	addi	a5,s0,-64
    800059cc:	9a3e                	add	s4,s4,a5
    800059ce:	e80a3023          	sd	zero,-384(s4)
    800059d2:	e4040593          	addi	a1,s0,-448
    800059d6:	f4040513          	addi	a0,s0,-192
    800059da:	fffff097          	auipc	ra,0xfffff
    800059de:	1aa080e7          	jalr	426(ra) # 80004b84 <exec>
    800059e2:	892a                	mv	s2,a0
    800059e4:	e4043503          	ld	a0,-448(s0)
    800059e8:	c115                	beqz	a0,80005a0c <sys_exec+0x116>
    800059ea:	ffffb097          	auipc	ra,0xffffb
    800059ee:	ea6080e7          	jalr	-346(ra) # 80000890 <kfree>
    800059f2:	e4840493          	addi	s1,s0,-440
    800059f6:	10098993          	addi	s3,s3,256
    800059fa:	6088                	ld	a0,0(s1)
    800059fc:	c901                	beqz	a0,80005a0c <sys_exec+0x116>
    800059fe:	ffffb097          	auipc	ra,0xffffb
    80005a02:	e92080e7          	jalr	-366(ra) # 80000890 <kfree>
    80005a06:	04a1                	addi	s1,s1,8
    80005a08:	ff3499e3          	bne	s1,s3,800059fa <sys_exec+0x104>
    80005a0c:	854a                	mv	a0,s2
    80005a0e:	a831                	j	80005a2a <sys_exec+0x134>
    80005a10:	00002517          	auipc	a0,0x2
    80005a14:	0b050513          	addi	a0,a0,176 # 80007ac0 <userret+0xa30>
    80005a18:	ffffb097          	auipc	ra,0xffffb
    80005a1c:	b66080e7          	jalr	-1178(ra) # 8000057e <panic>
    80005a20:	557d                	li	a0,-1
    80005a22:	a021                	j	80005a2a <sys_exec+0x134>
    80005a24:	557d                	li	a0,-1
    80005a26:	a011                	j	80005a2a <sys_exec+0x134>
    80005a28:	557d                	li	a0,-1
    80005a2a:	60be                	ld	ra,456(sp)
    80005a2c:	641e                	ld	s0,448(sp)
    80005a2e:	74fa                	ld	s1,440(sp)
    80005a30:	795a                	ld	s2,432(sp)
    80005a32:	79ba                	ld	s3,424(sp)
    80005a34:	7a1a                	ld	s4,416(sp)
    80005a36:	6afa                	ld	s5,408(sp)
    80005a38:	6179                	addi	sp,sp,464
    80005a3a:	8082                	ret
    80005a3c:	557d                	li	a0,-1
    80005a3e:	b7f5                	j	80005a2a <sys_exec+0x134>

0000000080005a40 <sys_pipe>:
    80005a40:	7139                	addi	sp,sp,-64
    80005a42:	fc06                	sd	ra,56(sp)
    80005a44:	f822                	sd	s0,48(sp)
    80005a46:	f426                	sd	s1,40(sp)
    80005a48:	0080                	addi	s0,sp,64
    80005a4a:	ffffc097          	auipc	ra,0xffffc
    80005a4e:	fd4080e7          	jalr	-44(ra) # 80001a1e <myproc>
    80005a52:	84aa                	mv	s1,a0
    80005a54:	fd840593          	addi	a1,s0,-40
    80005a58:	4501                	li	a0,0
    80005a5a:	ffffd097          	auipc	ra,0xffffd
    80005a5e:	03e080e7          	jalr	62(ra) # 80002a98 <argaddr>
    80005a62:	57fd                	li	a5,-1
    80005a64:	0c054f63          	bltz	a0,80005b42 <sys_pipe+0x102>
    80005a68:	fc840593          	addi	a1,s0,-56
    80005a6c:	fd040513          	addi	a0,s0,-48
    80005a70:	fffff097          	auipc	ra,0xfffff
    80005a74:	db2080e7          	jalr	-590(ra) # 80004822 <pipealloc>
    80005a78:	57fd                	li	a5,-1
    80005a7a:	0c054463          	bltz	a0,80005b42 <sys_pipe+0x102>
    80005a7e:	fcf42223          	sw	a5,-60(s0)
    80005a82:	fd043503          	ld	a0,-48(s0)
    80005a86:	fffff097          	auipc	ra,0xfffff
    80005a8a:	4ea080e7          	jalr	1258(ra) # 80004f70 <fdalloc>
    80005a8e:	fca42223          	sw	a0,-60(s0)
    80005a92:	08054b63          	bltz	a0,80005b28 <sys_pipe+0xe8>
    80005a96:	fc843503          	ld	a0,-56(s0)
    80005a9a:	fffff097          	auipc	ra,0xfffff
    80005a9e:	4d6080e7          	jalr	1238(ra) # 80004f70 <fdalloc>
    80005aa2:	fca42023          	sw	a0,-64(s0)
    80005aa6:	06054863          	bltz	a0,80005b16 <sys_pipe+0xd6>
    80005aaa:	4691                	li	a3,4
    80005aac:	fc440613          	addi	a2,s0,-60
    80005ab0:	fd843583          	ld	a1,-40(s0)
    80005ab4:	68a8                	ld	a0,80(s1)
    80005ab6:	ffffc097          	auipc	ra,0xffffc
    80005aba:	c44080e7          	jalr	-956(ra) # 800016fa <copyout>
    80005abe:	02054063          	bltz	a0,80005ade <sys_pipe+0x9e>
    80005ac2:	4691                	li	a3,4
    80005ac4:	fc040613          	addi	a2,s0,-64
    80005ac8:	fd843583          	ld	a1,-40(s0)
    80005acc:	0591                	addi	a1,a1,4
    80005ace:	68a8                	ld	a0,80(s1)
    80005ad0:	ffffc097          	auipc	ra,0xffffc
    80005ad4:	c2a080e7          	jalr	-982(ra) # 800016fa <copyout>
    80005ad8:	4781                	li	a5,0
    80005ada:	06055463          	bgez	a0,80005b42 <sys_pipe+0x102>
    80005ade:	fc442783          	lw	a5,-60(s0)
    80005ae2:	07e9                	addi	a5,a5,26
    80005ae4:	078e                	slli	a5,a5,0x3
    80005ae6:	97a6                	add	a5,a5,s1
    80005ae8:	0007b023          	sd	zero,0(a5)
    80005aec:	fc042783          	lw	a5,-64(s0)
    80005af0:	07e9                	addi	a5,a5,26
    80005af2:	078e                	slli	a5,a5,0x3
    80005af4:	94be                	add	s1,s1,a5
    80005af6:	0004b023          	sd	zero,0(s1)
    80005afa:	fd043503          	ld	a0,-48(s0)
    80005afe:	fffff097          	auipc	ra,0xfffff
    80005b02:	9dc080e7          	jalr	-1572(ra) # 800044da <fileclose>
    80005b06:	fc843503          	ld	a0,-56(s0)
    80005b0a:	fffff097          	auipc	ra,0xfffff
    80005b0e:	9d0080e7          	jalr	-1584(ra) # 800044da <fileclose>
    80005b12:	57fd                	li	a5,-1
    80005b14:	a03d                	j	80005b42 <sys_pipe+0x102>
    80005b16:	fc442783          	lw	a5,-60(s0)
    80005b1a:	0007c763          	bltz	a5,80005b28 <sys_pipe+0xe8>
    80005b1e:	07e9                	addi	a5,a5,26
    80005b20:	078e                	slli	a5,a5,0x3
    80005b22:	94be                	add	s1,s1,a5
    80005b24:	0004b023          	sd	zero,0(s1)
    80005b28:	fd043503          	ld	a0,-48(s0)
    80005b2c:	fffff097          	auipc	ra,0xfffff
    80005b30:	9ae080e7          	jalr	-1618(ra) # 800044da <fileclose>
    80005b34:	fc843503          	ld	a0,-56(s0)
    80005b38:	fffff097          	auipc	ra,0xfffff
    80005b3c:	9a2080e7          	jalr	-1630(ra) # 800044da <fileclose>
    80005b40:	57fd                	li	a5,-1
    80005b42:	853e                	mv	a0,a5
    80005b44:	70e2                	ld	ra,56(sp)
    80005b46:	7442                	ld	s0,48(sp)
    80005b48:	74a2                	ld	s1,40(sp)
    80005b4a:	6121                	addi	sp,sp,64
    80005b4c:	8082                	ret
	...

0000000080005b50 <kernelvec>:
    80005b50:	7111                	addi	sp,sp,-256
    80005b52:	e006                	sd	ra,0(sp)
    80005b54:	e40a                	sd	sp,8(sp)
    80005b56:	e80e                	sd	gp,16(sp)
    80005b58:	ec12                	sd	tp,24(sp)
    80005b5a:	f016                	sd	t0,32(sp)
    80005b5c:	f41a                	sd	t1,40(sp)
    80005b5e:	f81e                	sd	t2,48(sp)
    80005b60:	fc22                	sd	s0,56(sp)
    80005b62:	e0a6                	sd	s1,64(sp)
    80005b64:	e4aa                	sd	a0,72(sp)
    80005b66:	e8ae                	sd	a1,80(sp)
    80005b68:	ecb2                	sd	a2,88(sp)
    80005b6a:	f0b6                	sd	a3,96(sp)
    80005b6c:	f4ba                	sd	a4,104(sp)
    80005b6e:	f8be                	sd	a5,112(sp)
    80005b70:	fcc2                	sd	a6,120(sp)
    80005b72:	e146                	sd	a7,128(sp)
    80005b74:	e54a                	sd	s2,136(sp)
    80005b76:	e94e                	sd	s3,144(sp)
    80005b78:	ed52                	sd	s4,152(sp)
    80005b7a:	f156                	sd	s5,160(sp)
    80005b7c:	f55a                	sd	s6,168(sp)
    80005b7e:	f95e                	sd	s7,176(sp)
    80005b80:	fd62                	sd	s8,184(sp)
    80005b82:	e1e6                	sd	s9,192(sp)
    80005b84:	e5ea                	sd	s10,200(sp)
    80005b86:	e9ee                	sd	s11,208(sp)
    80005b88:	edf2                	sd	t3,216(sp)
    80005b8a:	f1f6                	sd	t4,224(sp)
    80005b8c:	f5fa                	sd	t5,232(sp)
    80005b8e:	f9fe                	sd	t6,240(sp)
    80005b90:	d13fc0ef          	jal	ra,800028a2 <kerneltrap>
    80005b94:	6082                	ld	ra,0(sp)
    80005b96:	6122                	ld	sp,8(sp)
    80005b98:	61c2                	ld	gp,16(sp)
    80005b9a:	7282                	ld	t0,32(sp)
    80005b9c:	7322                	ld	t1,40(sp)
    80005b9e:	73c2                	ld	t2,48(sp)
    80005ba0:	7462                	ld	s0,56(sp)
    80005ba2:	6486                	ld	s1,64(sp)
    80005ba4:	6526                	ld	a0,72(sp)
    80005ba6:	65c6                	ld	a1,80(sp)
    80005ba8:	6666                	ld	a2,88(sp)
    80005baa:	7686                	ld	a3,96(sp)
    80005bac:	7726                	ld	a4,104(sp)
    80005bae:	77c6                	ld	a5,112(sp)
    80005bb0:	7866                	ld	a6,120(sp)
    80005bb2:	688a                	ld	a7,128(sp)
    80005bb4:	692a                	ld	s2,136(sp)
    80005bb6:	69ca                	ld	s3,144(sp)
    80005bb8:	6a6a                	ld	s4,152(sp)
    80005bba:	7a8a                	ld	s5,160(sp)
    80005bbc:	7b2a                	ld	s6,168(sp)
    80005bbe:	7bca                	ld	s7,176(sp)
    80005bc0:	7c6a                	ld	s8,184(sp)
    80005bc2:	6c8e                	ld	s9,192(sp)
    80005bc4:	6d2e                	ld	s10,200(sp)
    80005bc6:	6dce                	ld	s11,208(sp)
    80005bc8:	6e6e                	ld	t3,216(sp)
    80005bca:	7e8e                	ld	t4,224(sp)
    80005bcc:	7f2e                	ld	t5,232(sp)
    80005bce:	7fce                	ld	t6,240(sp)
    80005bd0:	6111                	addi	sp,sp,256
    80005bd2:	10200073          	sret
    80005bd6:	00000013          	nop
    80005bda:	00000013          	nop
    80005bde:	0001                	nop

0000000080005be0 <timervec>:
    80005be0:	34051573          	csrrw	a0,mscratch,a0
    80005be4:	e10c                	sd	a1,0(a0)
    80005be6:	e510                	sd	a2,8(a0)
    80005be8:	e914                	sd	a3,16(a0)
    80005bea:	710c                	ld	a1,32(a0)
    80005bec:	7510                	ld	a2,40(a0)
    80005bee:	6194                	ld	a3,0(a1)
    80005bf0:	96b2                	add	a3,a3,a2
    80005bf2:	e194                	sd	a3,0(a1)
    80005bf4:	4589                	li	a1,2
    80005bf6:	14459073          	csrw	sip,a1
    80005bfa:	6914                	ld	a3,16(a0)
    80005bfc:	6510                	ld	a2,8(a0)
    80005bfe:	610c                	ld	a1,0(a0)
    80005c00:	34051573          	csrrw	a0,mscratch,a0
    80005c04:	30200073          	mret
	...

0000000080005c0a <plicinit>:
    80005c0a:	1141                	addi	sp,sp,-16
    80005c0c:	e422                	sd	s0,8(sp)
    80005c0e:	0800                	addi	s0,sp,16
    80005c10:	0c0007b7          	lui	a5,0xc000
    80005c14:	4705                	li	a4,1
    80005c16:	d798                	sw	a4,40(a5)
    80005c18:	c3d8                	sw	a4,4(a5)
    80005c1a:	6422                	ld	s0,8(sp)
    80005c1c:	0141                	addi	sp,sp,16
    80005c1e:	8082                	ret

0000000080005c20 <plicinithart>:
    80005c20:	1141                	addi	sp,sp,-16
    80005c22:	e406                	sd	ra,8(sp)
    80005c24:	e022                	sd	s0,0(sp)
    80005c26:	0800                	addi	s0,sp,16
    80005c28:	ffffc097          	auipc	ra,0xffffc
    80005c2c:	dca080e7          	jalr	-566(ra) # 800019f2 <cpuid>
    80005c30:	0085171b          	slliw	a4,a0,0x8
    80005c34:	0c0027b7          	lui	a5,0xc002
    80005c38:	97ba                	add	a5,a5,a4
    80005c3a:	40200713          	li	a4,1026
    80005c3e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005c42:	00d5151b          	slliw	a0,a0,0xd
    80005c46:	0c2017b7          	lui	a5,0xc201
    80005c4a:	953e                	add	a0,a0,a5
    80005c4c:	00052023          	sw	zero,0(a0)
    80005c50:	60a2                	ld	ra,8(sp)
    80005c52:	6402                	ld	s0,0(sp)
    80005c54:	0141                	addi	sp,sp,16
    80005c56:	8082                	ret

0000000080005c58 <plic_pending>:
    80005c58:	1141                	addi	sp,sp,-16
    80005c5a:	e422                	sd	s0,8(sp)
    80005c5c:	0800                	addi	s0,sp,16
    80005c5e:	0c0017b7          	lui	a5,0xc001
    80005c62:	6388                	ld	a0,0(a5)
    80005c64:	6422                	ld	s0,8(sp)
    80005c66:	0141                	addi	sp,sp,16
    80005c68:	8082                	ret

0000000080005c6a <plic_claim>:
    80005c6a:	1141                	addi	sp,sp,-16
    80005c6c:	e406                	sd	ra,8(sp)
    80005c6e:	e022                	sd	s0,0(sp)
    80005c70:	0800                	addi	s0,sp,16
    80005c72:	ffffc097          	auipc	ra,0xffffc
    80005c76:	d80080e7          	jalr	-640(ra) # 800019f2 <cpuid>
    80005c7a:	00d5151b          	slliw	a0,a0,0xd
    80005c7e:	0c2017b7          	lui	a5,0xc201
    80005c82:	97aa                	add	a5,a5,a0
    80005c84:	43c8                	lw	a0,4(a5)
    80005c86:	60a2                	ld	ra,8(sp)
    80005c88:	6402                	ld	s0,0(sp)
    80005c8a:	0141                	addi	sp,sp,16
    80005c8c:	8082                	ret

0000000080005c8e <plic_complete>:
    80005c8e:	1101                	addi	sp,sp,-32
    80005c90:	ec06                	sd	ra,24(sp)
    80005c92:	e822                	sd	s0,16(sp)
    80005c94:	e426                	sd	s1,8(sp)
    80005c96:	1000                	addi	s0,sp,32
    80005c98:	84aa                	mv	s1,a0
    80005c9a:	ffffc097          	auipc	ra,0xffffc
    80005c9e:	d58080e7          	jalr	-680(ra) # 800019f2 <cpuid>
    80005ca2:	00d5151b          	slliw	a0,a0,0xd
    80005ca6:	0c2017b7          	lui	a5,0xc201
    80005caa:	97aa                	add	a5,a5,a0
    80005cac:	c3c4                	sw	s1,4(a5)
    80005cae:	60e2                	ld	ra,24(sp)
    80005cb0:	6442                	ld	s0,16(sp)
    80005cb2:	64a2                	ld	s1,8(sp)
    80005cb4:	6105                	addi	sp,sp,32
    80005cb6:	8082                	ret

0000000080005cb8 <free_desc>:
    80005cb8:	1141                	addi	sp,sp,-16
    80005cba:	e406                	sd	ra,8(sp)
    80005cbc:	e022                	sd	s0,0(sp)
    80005cbe:	0800                	addi	s0,sp,16
    80005cc0:	479d                	li	a5,7
    80005cc2:	04a7cd63          	blt	a5,a0,80005d1c <free_desc+0x64>
    80005cc6:	0001d797          	auipc	a5,0x1d
    80005cca:	33a78793          	addi	a5,a5,826 # 80023000 <disk>
    80005cce:	00a78733          	add	a4,a5,a0
    80005cd2:	6789                	lui	a5,0x2
    80005cd4:	97ba                	add	a5,a5,a4
    80005cd6:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005cda:	eba9                	bnez	a5,80005d2c <free_desc+0x74>
    80005cdc:	0001f797          	auipc	a5,0x1f
    80005ce0:	32478793          	addi	a5,a5,804 # 80025000 <disk+0x2000>
    80005ce4:	639c                	ld	a5,0(a5)
    80005ce6:	00451713          	slli	a4,a0,0x4
    80005cea:	97ba                	add	a5,a5,a4
    80005cec:	0007b023          	sd	zero,0(a5)
    80005cf0:	0001d797          	auipc	a5,0x1d
    80005cf4:	31078793          	addi	a5,a5,784 # 80023000 <disk>
    80005cf8:	97aa                	add	a5,a5,a0
    80005cfa:	6509                	lui	a0,0x2
    80005cfc:	953e                	add	a0,a0,a5
    80005cfe:	4785                	li	a5,1
    80005d00:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
    80005d04:	0001f517          	auipc	a0,0x1f
    80005d08:	31450513          	addi	a0,a0,788 # 80025018 <disk+0x2018>
    80005d0c:	ffffc097          	auipc	ra,0xffffc
    80005d10:	644080e7          	jalr	1604(ra) # 80002350 <wakeup>
    80005d14:	60a2                	ld	ra,8(sp)
    80005d16:	6402                	ld	s0,0(sp)
    80005d18:	0141                	addi	sp,sp,16
    80005d1a:	8082                	ret
    80005d1c:	00002517          	auipc	a0,0x2
    80005d20:	db450513          	addi	a0,a0,-588 # 80007ad0 <userret+0xa40>
    80005d24:	ffffb097          	auipc	ra,0xffffb
    80005d28:	85a080e7          	jalr	-1958(ra) # 8000057e <panic>
    80005d2c:	00002517          	auipc	a0,0x2
    80005d30:	dbc50513          	addi	a0,a0,-580 # 80007ae8 <userret+0xa58>
    80005d34:	ffffb097          	auipc	ra,0xffffb
    80005d38:	84a080e7          	jalr	-1974(ra) # 8000057e <panic>

0000000080005d3c <virtio_disk_init>:
    80005d3c:	1101                	addi	sp,sp,-32
    80005d3e:	ec06                	sd	ra,24(sp)
    80005d40:	e822                	sd	s0,16(sp)
    80005d42:	e426                	sd	s1,8(sp)
    80005d44:	1000                	addi	s0,sp,32
    80005d46:	00002597          	auipc	a1,0x2
    80005d4a:	dba58593          	addi	a1,a1,-582 # 80007b00 <userret+0xa70>
    80005d4e:	0001f517          	auipc	a0,0x1f
    80005d52:	35a50513          	addi	a0,a0,858 # 800250a8 <disk+0x20a8>
    80005d56:	ffffb097          	auipc	ra,0xffffb
    80005d5a:	c9a080e7          	jalr	-870(ra) # 800009f0 <initlock>
    80005d5e:	100017b7          	lui	a5,0x10001
    80005d62:	4398                	lw	a4,0(a5)
    80005d64:	2701                	sext.w	a4,a4
    80005d66:	747277b7          	lui	a5,0x74727
    80005d6a:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005d6e:	0ef71163          	bne	a4,a5,80005e50 <virtio_disk_init+0x114>
    80005d72:	100017b7          	lui	a5,0x10001
    80005d76:	43dc                	lw	a5,4(a5)
    80005d78:	2781                	sext.w	a5,a5
    80005d7a:	4705                	li	a4,1
    80005d7c:	0ce79a63          	bne	a5,a4,80005e50 <virtio_disk_init+0x114>
    80005d80:	100017b7          	lui	a5,0x10001
    80005d84:	479c                	lw	a5,8(a5)
    80005d86:	2781                	sext.w	a5,a5
    80005d88:	4709                	li	a4,2
    80005d8a:	0ce79363          	bne	a5,a4,80005e50 <virtio_disk_init+0x114>
    80005d8e:	100017b7          	lui	a5,0x10001
    80005d92:	47d8                	lw	a4,12(a5)
    80005d94:	2701                	sext.w	a4,a4
    80005d96:	554d47b7          	lui	a5,0x554d4
    80005d9a:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005d9e:	0af71963          	bne	a4,a5,80005e50 <virtio_disk_init+0x114>
    80005da2:	100017b7          	lui	a5,0x10001
    80005da6:	4705                	li	a4,1
    80005da8:	dbb8                	sw	a4,112(a5)
    80005daa:	470d                	li	a4,3
    80005dac:	dbb8                	sw	a4,112(a5)
    80005dae:	4b94                	lw	a3,16(a5)
    80005db0:	c7ffe737          	lui	a4,0xc7ffe
    80005db4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd8743>
    80005db8:	8f75                	and	a4,a4,a3
    80005dba:	2701                	sext.w	a4,a4
    80005dbc:	d398                	sw	a4,32(a5)
    80005dbe:	472d                	li	a4,11
    80005dc0:	dbb8                	sw	a4,112(a5)
    80005dc2:	473d                	li	a4,15
    80005dc4:	dbb8                	sw	a4,112(a5)
    80005dc6:	6705                	lui	a4,0x1
    80005dc8:	d798                	sw	a4,40(a5)
    80005dca:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
    80005dce:	5bdc                	lw	a5,52(a5)
    80005dd0:	2781                	sext.w	a5,a5
    80005dd2:	c7d9                	beqz	a5,80005e60 <virtio_disk_init+0x124>
    80005dd4:	471d                	li	a4,7
    80005dd6:	08f77d63          	bleu	a5,a4,80005e70 <virtio_disk_init+0x134>
    80005dda:	100014b7          	lui	s1,0x10001
    80005dde:	47a1                	li	a5,8
    80005de0:	dc9c                	sw	a5,56(s1)
    80005de2:	6609                	lui	a2,0x2
    80005de4:	4581                	li	a1,0
    80005de6:	0001d517          	auipc	a0,0x1d
    80005dea:	21a50513          	addi	a0,a0,538 # 80023000 <disk>
    80005dee:	ffffb097          	auipc	ra,0xffffb
    80005df2:	dac080e7          	jalr	-596(ra) # 80000b9a <memset>
    80005df6:	0001d717          	auipc	a4,0x1d
    80005dfa:	20a70713          	addi	a4,a4,522 # 80023000 <disk>
    80005dfe:	00c75793          	srli	a5,a4,0xc
    80005e02:	2781                	sext.w	a5,a5
    80005e04:	c0bc                	sw	a5,64(s1)
    80005e06:	0001f797          	auipc	a5,0x1f
    80005e0a:	1fa78793          	addi	a5,a5,506 # 80025000 <disk+0x2000>
    80005e0e:	e398                	sd	a4,0(a5)
    80005e10:	0001d717          	auipc	a4,0x1d
    80005e14:	27070713          	addi	a4,a4,624 # 80023080 <disk+0x80>
    80005e18:	e798                	sd	a4,8(a5)
    80005e1a:	0001e717          	auipc	a4,0x1e
    80005e1e:	1e670713          	addi	a4,a4,486 # 80024000 <disk+0x1000>
    80005e22:	eb98                	sd	a4,16(a5)
    80005e24:	4705                	li	a4,1
    80005e26:	00e78c23          	sb	a4,24(a5)
    80005e2a:	00e78ca3          	sb	a4,25(a5)
    80005e2e:	00e78d23          	sb	a4,26(a5)
    80005e32:	00e78da3          	sb	a4,27(a5)
    80005e36:	00e78e23          	sb	a4,28(a5)
    80005e3a:	00e78ea3          	sb	a4,29(a5)
    80005e3e:	00e78f23          	sb	a4,30(a5)
    80005e42:	00e78fa3          	sb	a4,31(a5)
    80005e46:	60e2                	ld	ra,24(sp)
    80005e48:	6442                	ld	s0,16(sp)
    80005e4a:	64a2                	ld	s1,8(sp)
    80005e4c:	6105                	addi	sp,sp,32
    80005e4e:	8082                	ret
    80005e50:	00002517          	auipc	a0,0x2
    80005e54:	cc050513          	addi	a0,a0,-832 # 80007b10 <userret+0xa80>
    80005e58:	ffffa097          	auipc	ra,0xffffa
    80005e5c:	726080e7          	jalr	1830(ra) # 8000057e <panic>
    80005e60:	00002517          	auipc	a0,0x2
    80005e64:	cd050513          	addi	a0,a0,-816 # 80007b30 <userret+0xaa0>
    80005e68:	ffffa097          	auipc	ra,0xffffa
    80005e6c:	716080e7          	jalr	1814(ra) # 8000057e <panic>
    80005e70:	00002517          	auipc	a0,0x2
    80005e74:	ce050513          	addi	a0,a0,-800 # 80007b50 <userret+0xac0>
    80005e78:	ffffa097          	auipc	ra,0xffffa
    80005e7c:	706080e7          	jalr	1798(ra) # 8000057e <panic>

0000000080005e80 <virtio_disk_rw>:
    80005e80:	7159                	addi	sp,sp,-112
    80005e82:	f486                	sd	ra,104(sp)
    80005e84:	f0a2                	sd	s0,96(sp)
    80005e86:	eca6                	sd	s1,88(sp)
    80005e88:	e8ca                	sd	s2,80(sp)
    80005e8a:	e4ce                	sd	s3,72(sp)
    80005e8c:	e0d2                	sd	s4,64(sp)
    80005e8e:	fc56                	sd	s5,56(sp)
    80005e90:	f85a                	sd	s6,48(sp)
    80005e92:	f45e                	sd	s7,40(sp)
    80005e94:	f062                	sd	s8,32(sp)
    80005e96:	1880                	addi	s0,sp,112
    80005e98:	892a                	mv	s2,a0
    80005e9a:	8c2e                	mv	s8,a1
    80005e9c:	00c52b83          	lw	s7,12(a0)
    80005ea0:	001b9b9b          	slliw	s7,s7,0x1
    80005ea4:	1b82                	slli	s7,s7,0x20
    80005ea6:	020bdb93          	srli	s7,s7,0x20
    80005eaa:	0001f517          	auipc	a0,0x1f
    80005eae:	1fe50513          	addi	a0,a0,510 # 800250a8 <disk+0x20a8>
    80005eb2:	ffffb097          	auipc	ra,0xffffb
    80005eb6:	c4c080e7          	jalr	-948(ra) # 80000afe <acquire>
    80005eba:	0001f997          	auipc	s3,0x1f
    80005ebe:	14698993          	addi	s3,s3,326 # 80025000 <disk+0x2000>
    80005ec2:	4b21                	li	s6,8
    80005ec4:	0001da97          	auipc	s5,0x1d
    80005ec8:	13ca8a93          	addi	s5,s5,316 # 80023000 <disk>
    80005ecc:	4a0d                	li	s4,3
    80005ece:	a079                	j	80005f5c <virtio_disk_rw+0xdc>
    80005ed0:	00fa86b3          	add	a3,s5,a5
    80005ed4:	96ae                	add	a3,a3,a1
    80005ed6:	00068c23          	sb	zero,24(a3)
    80005eda:	c21c                	sw	a5,0(a2)
    80005edc:	0207ca63          	bltz	a5,80005f10 <virtio_disk_rw+0x90>
    80005ee0:	2485                	addiw	s1,s1,1
    80005ee2:	0711                	addi	a4,a4,4
    80005ee4:	25448163          	beq	s1,s4,80006126 <virtio_disk_rw+0x2a6>
    80005ee8:	863a                	mv	a2,a4
    80005eea:	0189c783          	lbu	a5,24(s3)
    80005eee:	24079163          	bnez	a5,80006130 <virtio_disk_rw+0x2b0>
    80005ef2:	0001f697          	auipc	a3,0x1f
    80005ef6:	12768693          	addi	a3,a3,295 # 80025019 <disk+0x2019>
    80005efa:	87aa                	mv	a5,a0
    80005efc:	0006c803          	lbu	a6,0(a3)
    80005f00:	fc0818e3          	bnez	a6,80005ed0 <virtio_disk_rw+0x50>
    80005f04:	2785                	addiw	a5,a5,1
    80005f06:	0685                	addi	a3,a3,1
    80005f08:	ff679ae3          	bne	a5,s6,80005efc <virtio_disk_rw+0x7c>
    80005f0c:	57fd                	li	a5,-1
    80005f0e:	c21c                	sw	a5,0(a2)
    80005f10:	02905a63          	blez	s1,80005f44 <virtio_disk_rw+0xc4>
    80005f14:	fa042503          	lw	a0,-96(s0)
    80005f18:	00000097          	auipc	ra,0x0
    80005f1c:	da0080e7          	jalr	-608(ra) # 80005cb8 <free_desc>
    80005f20:	4785                	li	a5,1
    80005f22:	0297d163          	ble	s1,a5,80005f44 <virtio_disk_rw+0xc4>
    80005f26:	fa442503          	lw	a0,-92(s0)
    80005f2a:	00000097          	auipc	ra,0x0
    80005f2e:	d8e080e7          	jalr	-626(ra) # 80005cb8 <free_desc>
    80005f32:	4789                	li	a5,2
    80005f34:	0097d863          	ble	s1,a5,80005f44 <virtio_disk_rw+0xc4>
    80005f38:	fa842503          	lw	a0,-88(s0)
    80005f3c:	00000097          	auipc	ra,0x0
    80005f40:	d7c080e7          	jalr	-644(ra) # 80005cb8 <free_desc>
    80005f44:	0001f597          	auipc	a1,0x1f
    80005f48:	16458593          	addi	a1,a1,356 # 800250a8 <disk+0x20a8>
    80005f4c:	0001f517          	auipc	a0,0x1f
    80005f50:	0cc50513          	addi	a0,a0,204 # 80025018 <disk+0x2018>
    80005f54:	ffffc097          	auipc	ra,0xffffc
    80005f58:	276080e7          	jalr	630(ra) # 800021ca <sleep>
    80005f5c:	fa040713          	addi	a4,s0,-96
    80005f60:	4481                	li	s1,0
    80005f62:	4505                	li	a0,1
    80005f64:	6589                	lui	a1,0x2
    80005f66:	b749                	j	80005ee8 <virtio_disk_rw+0x68>
    80005f68:	4785                	li	a5,1
    80005f6a:	f8f42823          	sw	a5,-112(s0)
    80005f6e:	f8042a23          	sw	zero,-108(s0)
    80005f72:	f9743c23          	sd	s7,-104(s0)
    80005f76:	fa042983          	lw	s3,-96(s0)
    80005f7a:	00499493          	slli	s1,s3,0x4
    80005f7e:	0001fa17          	auipc	s4,0x1f
    80005f82:	082a0a13          	addi	s4,s4,130 # 80025000 <disk+0x2000>
    80005f86:	000a3a83          	ld	s5,0(s4)
    80005f8a:	9aa6                	add	s5,s5,s1
    80005f8c:	f9040513          	addi	a0,s0,-112
    80005f90:	ffffb097          	auipc	ra,0xffffb
    80005f94:	1dc080e7          	jalr	476(ra) # 8000116c <kvmpa>
    80005f98:	00aab023          	sd	a0,0(s5)
    80005f9c:	000a3783          	ld	a5,0(s4)
    80005fa0:	97a6                	add	a5,a5,s1
    80005fa2:	4741                	li	a4,16
    80005fa4:	c798                	sw	a4,8(a5)
    80005fa6:	000a3783          	ld	a5,0(s4)
    80005faa:	97a6                	add	a5,a5,s1
    80005fac:	4705                	li	a4,1
    80005fae:	00e79623          	sh	a4,12(a5)
    80005fb2:	fa442703          	lw	a4,-92(s0)
    80005fb6:	000a3783          	ld	a5,0(s4)
    80005fba:	97a6                	add	a5,a5,s1
    80005fbc:	00e79723          	sh	a4,14(a5)
    80005fc0:	0712                	slli	a4,a4,0x4
    80005fc2:	000a3783          	ld	a5,0(s4)
    80005fc6:	97ba                	add	a5,a5,a4
    80005fc8:	06090693          	addi	a3,s2,96
    80005fcc:	e394                	sd	a3,0(a5)
    80005fce:	000a3783          	ld	a5,0(s4)
    80005fd2:	97ba                	add	a5,a5,a4
    80005fd4:	40000693          	li	a3,1024
    80005fd8:	c794                	sw	a3,8(a5)
    80005fda:	100c0863          	beqz	s8,800060ea <virtio_disk_rw+0x26a>
    80005fde:	000a3783          	ld	a5,0(s4)
    80005fe2:	97ba                	add	a5,a5,a4
    80005fe4:	00079623          	sh	zero,12(a5)
    80005fe8:	0001d517          	auipc	a0,0x1d
    80005fec:	01850513          	addi	a0,a0,24 # 80023000 <disk>
    80005ff0:	0001f797          	auipc	a5,0x1f
    80005ff4:	01078793          	addi	a5,a5,16 # 80025000 <disk+0x2000>
    80005ff8:	6394                	ld	a3,0(a5)
    80005ffa:	96ba                	add	a3,a3,a4
    80005ffc:	00c6d603          	lhu	a2,12(a3)
    80006000:	00166613          	ori	a2,a2,1
    80006004:	00c69623          	sh	a2,12(a3)
    80006008:	fa842683          	lw	a3,-88(s0)
    8000600c:	6390                	ld	a2,0(a5)
    8000600e:	9732                	add	a4,a4,a2
    80006010:	00d71723          	sh	a3,14(a4)
    80006014:	20098613          	addi	a2,s3,512
    80006018:	0612                	slli	a2,a2,0x4
    8000601a:	962a                	add	a2,a2,a0
    8000601c:	02060823          	sb	zero,48(a2) # 2030 <_entry-0x7fffdfd0>
    80006020:	00469713          	slli	a4,a3,0x4
    80006024:	6394                	ld	a3,0(a5)
    80006026:	96ba                	add	a3,a3,a4
    80006028:	6589                	lui	a1,0x2
    8000602a:	03058593          	addi	a1,a1,48 # 2030 <_entry-0x7fffdfd0>
    8000602e:	94ae                	add	s1,s1,a1
    80006030:	94aa                	add	s1,s1,a0
    80006032:	e284                	sd	s1,0(a3)
    80006034:	6394                	ld	a3,0(a5)
    80006036:	96ba                	add	a3,a3,a4
    80006038:	4585                	li	a1,1
    8000603a:	c68c                	sw	a1,8(a3)
    8000603c:	6394                	ld	a3,0(a5)
    8000603e:	96ba                	add	a3,a3,a4
    80006040:	4509                	li	a0,2
    80006042:	00a69623          	sh	a0,12(a3)
    80006046:	6394                	ld	a3,0(a5)
    80006048:	9736                	add	a4,a4,a3
    8000604a:	00071723          	sh	zero,14(a4)
    8000604e:	00b92223          	sw	a1,4(s2)
    80006052:	03263423          	sd	s2,40(a2)
    80006056:	6794                	ld	a3,8(a5)
    80006058:	0026d703          	lhu	a4,2(a3)
    8000605c:	8b1d                	andi	a4,a4,7
    8000605e:	0709                	addi	a4,a4,2
    80006060:	0706                	slli	a4,a4,0x1
    80006062:	9736                	add	a4,a4,a3
    80006064:	01371023          	sh	s3,0(a4)
    80006068:	0ff0000f          	fence
    8000606c:	6798                	ld	a4,8(a5)
    8000606e:	00275783          	lhu	a5,2(a4)
    80006072:	2785                	addiw	a5,a5,1
    80006074:	00f71123          	sh	a5,2(a4)
    80006078:	100017b7          	lui	a5,0x10001
    8000607c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>
    80006080:	00492703          	lw	a4,4(s2)
    80006084:	4785                	li	a5,1
    80006086:	02f71163          	bne	a4,a5,800060a8 <virtio_disk_rw+0x228>
    8000608a:	0001f997          	auipc	s3,0x1f
    8000608e:	01e98993          	addi	s3,s3,30 # 800250a8 <disk+0x20a8>
    80006092:	4485                	li	s1,1
    80006094:	85ce                	mv	a1,s3
    80006096:	854a                	mv	a0,s2
    80006098:	ffffc097          	auipc	ra,0xffffc
    8000609c:	132080e7          	jalr	306(ra) # 800021ca <sleep>
    800060a0:	00492783          	lw	a5,4(s2)
    800060a4:	fe9788e3          	beq	a5,s1,80006094 <virtio_disk_rw+0x214>
    800060a8:	fa042483          	lw	s1,-96(s0)
    800060ac:	20048793          	addi	a5,s1,512 # 10001200 <_entry-0x6fffee00>
    800060b0:	00479713          	slli	a4,a5,0x4
    800060b4:	0001d797          	auipc	a5,0x1d
    800060b8:	f4c78793          	addi	a5,a5,-180 # 80023000 <disk>
    800060bc:	97ba                	add	a5,a5,a4
    800060be:	0207b423          	sd	zero,40(a5)
    800060c2:	0001f917          	auipc	s2,0x1f
    800060c6:	f3e90913          	addi	s2,s2,-194 # 80025000 <disk+0x2000>
    800060ca:	8526                	mv	a0,s1
    800060cc:	00000097          	auipc	ra,0x0
    800060d0:	bec080e7          	jalr	-1044(ra) # 80005cb8 <free_desc>
    800060d4:	0492                	slli	s1,s1,0x4
    800060d6:	00093783          	ld	a5,0(s2)
    800060da:	94be                	add	s1,s1,a5
    800060dc:	00c4d783          	lhu	a5,12(s1)
    800060e0:	8b85                	andi	a5,a5,1
    800060e2:	cf91                	beqz	a5,800060fe <virtio_disk_rw+0x27e>
    800060e4:	00e4d483          	lhu	s1,14(s1)
    800060e8:	b7cd                	j	800060ca <virtio_disk_rw+0x24a>
    800060ea:	0001f797          	auipc	a5,0x1f
    800060ee:	f1678793          	addi	a5,a5,-234 # 80025000 <disk+0x2000>
    800060f2:	639c                	ld	a5,0(a5)
    800060f4:	97ba                	add	a5,a5,a4
    800060f6:	4689                	li	a3,2
    800060f8:	00d79623          	sh	a3,12(a5)
    800060fc:	b5f5                	j	80005fe8 <virtio_disk_rw+0x168>
    800060fe:	0001f517          	auipc	a0,0x1f
    80006102:	faa50513          	addi	a0,a0,-86 # 800250a8 <disk+0x20a8>
    80006106:	ffffb097          	auipc	ra,0xffffb
    8000610a:	a4c080e7          	jalr	-1460(ra) # 80000b52 <release>
    8000610e:	70a6                	ld	ra,104(sp)
    80006110:	7406                	ld	s0,96(sp)
    80006112:	64e6                	ld	s1,88(sp)
    80006114:	6946                	ld	s2,80(sp)
    80006116:	69a6                	ld	s3,72(sp)
    80006118:	6a06                	ld	s4,64(sp)
    8000611a:	7ae2                	ld	s5,56(sp)
    8000611c:	7b42                	ld	s6,48(sp)
    8000611e:	7ba2                	ld	s7,40(sp)
    80006120:	7c02                	ld	s8,32(sp)
    80006122:	6165                	addi	sp,sp,112
    80006124:	8082                	ret
    80006126:	e40c11e3          	bnez	s8,80005f68 <virtio_disk_rw+0xe8>
    8000612a:	f8042823          	sw	zero,-112(s0)
    8000612e:	b581                	j	80005f6e <virtio_disk_rw+0xee>
    80006130:	00098c23          	sb	zero,24(s3)
    80006134:	00072023          	sw	zero,0(a4)
    80006138:	b365                	j	80005ee0 <virtio_disk_rw+0x60>

000000008000613a <virtio_disk_intr>:
    8000613a:	1101                	addi	sp,sp,-32
    8000613c:	ec06                	sd	ra,24(sp)
    8000613e:	e822                	sd	s0,16(sp)
    80006140:	e426                	sd	s1,8(sp)
    80006142:	e04a                	sd	s2,0(sp)
    80006144:	1000                	addi	s0,sp,32
    80006146:	0001f517          	auipc	a0,0x1f
    8000614a:	f6250513          	addi	a0,a0,-158 # 800250a8 <disk+0x20a8>
    8000614e:	ffffb097          	auipc	ra,0xffffb
    80006152:	9b0080e7          	jalr	-1616(ra) # 80000afe <acquire>
    80006156:	0001f797          	auipc	a5,0x1f
    8000615a:	eaa78793          	addi	a5,a5,-342 # 80025000 <disk+0x2000>
    8000615e:	0207d683          	lhu	a3,32(a5)
    80006162:	6b98                	ld	a4,16(a5)
    80006164:	00275783          	lhu	a5,2(a4)
    80006168:	8fb5                	xor	a5,a5,a3
    8000616a:	8b9d                	andi	a5,a5,7
    8000616c:	c7c9                	beqz	a5,800061f6 <virtio_disk_intr+0xbc>
    8000616e:	068e                	slli	a3,a3,0x3
    80006170:	9736                	add	a4,a4,a3
    80006172:	435c                	lw	a5,4(a4)
    80006174:	20078713          	addi	a4,a5,512
    80006178:	00471693          	slli	a3,a4,0x4
    8000617c:	0001d717          	auipc	a4,0x1d
    80006180:	e8470713          	addi	a4,a4,-380 # 80023000 <disk>
    80006184:	9736                	add	a4,a4,a3
    80006186:	03074703          	lbu	a4,48(a4)
    8000618a:	ef31                	bnez	a4,800061e6 <virtio_disk_intr+0xac>
    8000618c:	0001d917          	auipc	s2,0x1d
    80006190:	e7490913          	addi	s2,s2,-396 # 80023000 <disk>
    80006194:	0001f497          	auipc	s1,0x1f
    80006198:	e6c48493          	addi	s1,s1,-404 # 80025000 <disk+0x2000>
    8000619c:	20078793          	addi	a5,a5,512
    800061a0:	0792                	slli	a5,a5,0x4
    800061a2:	97ca                	add	a5,a5,s2
    800061a4:	7798                	ld	a4,40(a5)
    800061a6:	00072223          	sw	zero,4(a4)
    800061aa:	7788                	ld	a0,40(a5)
    800061ac:	ffffc097          	auipc	ra,0xffffc
    800061b0:	1a4080e7          	jalr	420(ra) # 80002350 <wakeup>
    800061b4:	0204d783          	lhu	a5,32(s1)
    800061b8:	2785                	addiw	a5,a5,1
    800061ba:	8b9d                	andi	a5,a5,7
    800061bc:	03079613          	slli	a2,a5,0x30
    800061c0:	9241                	srli	a2,a2,0x30
    800061c2:	02c49023          	sh	a2,32(s1)
    800061c6:	6898                	ld	a4,16(s1)
    800061c8:	00275683          	lhu	a3,2(a4)
    800061cc:	8a9d                	andi	a3,a3,7
    800061ce:	02c68463          	beq	a3,a2,800061f6 <virtio_disk_intr+0xbc>
    800061d2:	078e                	slli	a5,a5,0x3
    800061d4:	97ba                	add	a5,a5,a4
    800061d6:	43dc                	lw	a5,4(a5)
    800061d8:	20078713          	addi	a4,a5,512
    800061dc:	0712                	slli	a4,a4,0x4
    800061de:	974a                	add	a4,a4,s2
    800061e0:	03074703          	lbu	a4,48(a4)
    800061e4:	df45                	beqz	a4,8000619c <virtio_disk_intr+0x62>
    800061e6:	00002517          	auipc	a0,0x2
    800061ea:	98a50513          	addi	a0,a0,-1654 # 80007b70 <userret+0xae0>
    800061ee:	ffffa097          	auipc	ra,0xffffa
    800061f2:	390080e7          	jalr	912(ra) # 8000057e <panic>
    800061f6:	0001f517          	auipc	a0,0x1f
    800061fa:	eb250513          	addi	a0,a0,-334 # 800250a8 <disk+0x20a8>
    800061fe:	ffffb097          	auipc	ra,0xffffb
    80006202:	954080e7          	jalr	-1708(ra) # 80000b52 <release>
    80006206:	60e2                	ld	ra,24(sp)
    80006208:	6442                	ld	s0,16(sp)
    8000620a:	64a2                	ld	s1,8(sp)
    8000620c:	6902                	ld	s2,0(sp)
    8000620e:	6105                	addi	sp,sp,32
    80006210:	8082                	ret
	...

0000000080007000 <trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
