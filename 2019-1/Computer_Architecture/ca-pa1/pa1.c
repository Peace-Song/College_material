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


// fix2double() returns the double-precision floating-point value for 
// the given fixed-point value 'a'. Note that 'a' is represented in 
// 21.10 fixed-point format.

double fix2double (fixp a)
{
//    int sign = a >> 31;
    int sign = (a & 0x80000000) >> 31;
    double target = 0;
    int i;

    if(sign == 1) target = -(1 << 21); // target = -a_32 * 2^21

    for(i = 20; i >= 0; i--){ // target = -a_32 * 2^21 + ... + a_10 * 2^0
        target += (a & (1 << (i + 10))) >> 10; 
    }

    for(i = 1; i <= 10; i++){ // target = -a_32 * 2^21 + ... + a_0 * 2^-10
        target += (double)((a & (1 << (10 - i))) >> (10 - i)) / (1 << i);
    }
      
    return target;
}
