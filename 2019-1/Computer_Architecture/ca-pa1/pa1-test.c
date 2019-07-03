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

#include <stdio.h>
#include "pa1.h"


fixp a[] = { 0x00000000, 0x00000400, 0x00000600, 0x00000700,
		     0x7fffffff, 0x80000000, 0xffffffff, 0xff00ff00,
			 0xdeadbeef, 0xcafebabe, 0xfaceb00c, 0xc0dec001 };

double ans[] = { 0.0, 1.0, 1.5, 1.75,
			2097151.9990234375, -2097152.0, -0.0009765625, -16320.25,
			-545936.2666015625, -868433.3144531250, -85075.9882812500, -1034319.9990234375};


int main (void)
{
	int i;
	double d;

	for (i = 0; i < sizeof(a)/sizeof(fixp); i++)
	{
		d = fix2double (a[i]);
		printf ("0x%08x -> %.10lf, result = %.10lf %s\n", 
				a[i], ans[i], d, (ans[i] == d)? "CORRECT" : "WRONG");

	}

}

