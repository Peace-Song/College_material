//--------------------------------------------------------------
// 
//  4190.308 Computer Architecture (Spring 2019)
//
//  Project #1: Converting Fixed-Point to Floating-Point
//
//  March 20, 2019
//
//  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
//  Systems Software & Architecture Laboratory
//  Dept. of Computer Science and Engineering
//  Seoul National University
//
//--------------------------------------------------------------


// 32-bit used for (21.10) fixed-point
// 		Bit 31:		Sign
//		Bit 30-10:	Integer part (21 bits)
//		Bit 9-0:	Fractional part (10 bits)

typedef int 				fixp;		



// Function prototypes

extern double fix2double (fixp a);

