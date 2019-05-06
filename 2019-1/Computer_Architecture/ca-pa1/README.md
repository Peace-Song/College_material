# 4190.308 Computer Architecture (Spring 2019)
# Project #1: Converting Fixed-Point to Floating-Point
### Due: 11:59PM (Sunday), March 31


## Introduction

The purpose of this project is to understand the fixed-point representation. Another goal is to make your Linux development environment ready and to get familiar with our sys.snu.ac.kr server for project submission.

## Problem specification

We consider the _21.10_ fixed-point format for representing real numbers. In the 21.10 fixed-point representation, the most significant bit (bit 31) is used as a sign bit, and the next 21 bits (bits 30-10) are used to represent the integer part. The rest of the bits (bits 9-0) are used for the fractional part, as shown in the following figure.

```
bit31                                     bit10                 bit0
  S I I I I I I I I I I I I I I I I I I I I I . F F F F F F F F F F
  ^              Integer (21 bits)            ^  Fraction (10 bits)
  |                                           |
  Sign bit                            Imaginary binary point
```

For the given 32-bit _B_ represented in the 21.10 fixed-point format, the corresponding value _V(B)_ can be obtained as follows (_b<sub>i</sub>_ denotes the _i_-th bit of _B_):

V(B) = -b<sub>31</sub> &sdot; 2<sup>21</sup> +
b<sub>30</sub> &sdot; 2<sup>20</sup> +
b<sub>29</sub> &sdot; 2<sup>19</sup> + &hellip; +
b<sub>10</sub> &sdot; 2<sup>0</sup> +
b<sub>9</sub> &sdot; 2<sup>-1</sup> +
b<sub>8</sub> &sdot; 2<sup>-2</sup> + &hellip; +
b<sub>0</sub> &sdot; 2<sup>-10</sup>

Here are some examples:

0000 0000 0000 0000 0000 0100 0000 0000 -> 1.0  
0000 0000 0000 0000 0000 1111 0000 0000 -> 3.75  
1111 1111 1111 1111 1111 1111 1111 1111 -> -0.0009765625  
1111 1111 1111 1111 0000 0000 0110 0000 -> -63.90625  

In C, the new type `fixp` is defined as follows:

```
typedef int fixp;
```

As you can see, the type `fixp` is an alias for 32-bit integers but you have to interpret its bit pattern as a 21.10 fixed-point value.

Your task is to implement the C function named `fix2double()` that converts a `fixp`-type value to the corresponding `double`-type value.

```
double fix2double (fixp a);
```

## Skeleton code

We provide you with the skeleton code for this project. It can be download from Github at https://github.com/snu-csl/ca-pa1/. If you don't have the git utility, you need to install it first. To download and build the skeleton code, please follow these steps:

```
$ sudo apt install git        
$ git clone https://github.com/snu-csl/ca-pa1.git
$ cd ca-pa1
$ make
gcc -g -O2 -Wall  -c pa1-test.c -o pa1-test.o
gcc -g -O2 -Wall  -c pa1.c -o pa1.o
gcc -g -O2 -Wall  -o pa1 pa1-test.o pa1.o
```

The result of a sample run looks like this:

```
$ ./pa1
0x00000000 -> 0.0000000000, result = 3.1400000000 WRONG
0x00000400 -> 1.0000000000, result = 3.1400000000 WRONG
0x00000600 -> 1.5000000000, result = 3.1400000000 WRONG
0x00000700 -> 1.7500000000, result = 3.1400000000 WRONG
0x7fffffff -> 2097151.9990234375, result = 3.1400000000 WRONG
0x80000000 -> -2097152.0000000000, result = 3.1400000000 WRONG
0xffffffff -> -0.0009765625, result = 3.1400000000 WRONG
0xff00ff00 -> -16320.2500000000, result = 3.1400000000 WRONG
0xdeadbeef -> -545936.2666015625, result = 3.1400000000 WRONG
0xcafebabe -> -868433.3144531250, result = 3.1400000000 WRONG
0xfaceb00c -> -85075.9882812500, result = 3.1400000000 WRONG
0xc0dec001 -> -1034319.9990234375, result = 3.1400000000 WRONG
```

You are required to complete the `fix2double()` function in the `pa1.c` file.


## Restrictions

* You should not use any array even in comment lines. Any source file that contains the symbol [ or ] will be rejected by the server.

* Do not use any header file other than `stdio.h` and `pa1.h` in the `pa1.c` file.

## Hand in instructions

* Register an account to the submission server at https://sys.snu.ac.kr
  * You must enter your real name & student ID
  * Wait for an approval from the admin
* Submit only the `pa1.c` file to the submission server

## Logistics

* You will work on this project alone.
* Only the upload submitted before the deadline will receive the full credit. 25% of the credit will be deducted for every single day delay.
* __You can use up to 5 _slip days_ during this semester__. If your submission is delayed by 1 day and if you decided to use 1 slip day, there will be no penalty. In this case, you should explicitly declare the number of slip days you want to use in the QnA board of the submission server after each submission. Saving the slip days for later projects is highly recommended!
* Any attempt to copy others' work will result in heavy penalty (for both the copier and the originator). Don't take a risk.

Have fun!

[Jin-Soo Kim](mailto:jinsoo.kim_AT_snu.ac.kr)  
[Systems Software and Architecture Laboratory](http://csl.snu.ac.kr)  
[Dept. of Computer Science and Engineering](http://cse.snu.ac.kr)  
[Seoul National University](http://www.snu.ac.kr)
