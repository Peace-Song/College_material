//--------------------------------------------------------------
// 
//  4190.308 Computer Architecture (Spring 2019)
//
//  Project #2: TinyFP Representation
//
//  April 4, 2019
//
//  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
//  Systems Software & Architecture Laboratory
//  Dept. of Computer Science and Engineering
//  Seoul National University
//
//--------------------------------------------------------------

#include <stdio.h>
#include "pa2.h"

typedef int bool;
#define false 0
#define true 1

#define tinyfp_posInf 0b01110000
#define tinyfp_negInf 0b11110000
#define tinyfp_posNaN 0b01110001
#define tinyfp_negNaN 0b11110001

#define fixp_smallest 0x80000000

#define float_posInf 0b01111111100000000000000000000000
#define float_negInf 0b11111111100000000000000000000000
#define float_posNaN 0b01111111100000000000000000000001
#define float_negNaN 0b11111111100000000000000000000001

// typedef unsigned char tinyfp; // 8-bit floating point
// typedef int fixp;             // 21.10 fixed-point

union bitwise_float{
    unsigned int bw_f;
    float f;
};

bool isPosNaN(tinyfp f){
    if(((f >> 7) == 0) && ((f >> 4) == 7) && f != tinyfp_posInf)
        return true;
    else
        return false;
}

bool isNegNaN(tinyfp f){
    if(((f >> 7) == 1) && ((f >> 4) == 15) && f != tinyfp_negInf)
        return true;
    else
        return false;
}

int getExp(fixp f){
    int matisse = (f & 0x7FFFFC00) >> 10;
    int frac = f & 0x000003FF;
    int i = 0;
    int j = 1;

    if(matisse != 0){
        while(1){
            j *= 2;
            if(matisse / j == 0) return i;
            else i++;
        }
    }
    else{
        while(1){
            j *= 2;
            if(frac / j == 0) return i-10;
            else i++;
        }
    }
}

unsigned int round2Even_fixp(unsigned int frac, int exp){
    int R_index = 5 + exp; // 1.BBBGRXXX
    int R_mask = (1 << (R_index +1)) - 1;
    int threshold = 1 << R_index; // ...BG100000 
    int G = (frac & (1 << (R_index + 1))) >> (R_index + 1);

    if(exp <= -3){
        if((frac & 0b1111) < 0b1000) return (frac >> 4) << 4;
        else if((frac & 0b1111) > 0b1000) return ((frac >> 4) << 4) + (1 << 4);
        else{
            if((frac & 0b10000) == 0) return (frac >> 4) << 4;
            else return ((frac >> 4) << 4) + (1 << 4);
        }
    }
    if((frac & R_mask) < threshold) // ...BG0101101...
        return (frac >> (R_index + 1)) << (R_index + 1);
    else if((frac & R_mask) > threshold) // ...BG1101101
        return ((frac >> (R_index + 1)) << (R_index + 1)) + (1 << (R_index + 1));
    else{
        //printf("DEBUG: threshold case activated.\n");
        //printf("DEBUG: G = %d\n", G);
        if(G == 0)
            return (frac >> (R_index + 1)) << (R_index + 1);
        else
            return ((frac >> (R_index + 1)) << (R_index + 1)) + (1 << (R_index + 1));
    }
}

unsigned int round2Even_float(unsigned int frac){
    int threshold = 1 << 18;
    int G = (frac & 0x80000) >> 19;
    int exp = ((frac & 0x7F800000) >> 23) - 127;
    int temp = 0;
    if(exp <= -3){
        temp = frac & 0x7FFFFF;
        temp += 1 << 23;
        temp = temp >> -(exp + 2);
        if((temp & 0x7FFFF) < threshold){
            return (frac & 0x7F800000) + temp;}
        else if((temp & 0x7FFFF) > threshold)
            return ((frac & 0x7F800000) + temp) + (1 << 19);
        else{
            if((temp & 0x80000) == 0) 
                return (frac & 0x7F800000) + temp;
            else
                return ((frac & 0x7F800000) + temp) + (1 << 19);
        }
    }
            
    if((frac & 0x7FFFF) < threshold){
        return (frac >> 19) << 19;}
    else if((frac & 0x7FFFF) > threshold)
        return ((frac >> 19) << 19) + (1 << 19); // if OF occurs 24th bit is flag
    else{
        //printf("DEBUG: threshold case activated.\n");
        //printf("DEBUG: G = %d\n", G);
        if(G == 0)
            return (frac >> 19) << 19;
        else
            return ((frac >> 19) << 19) + (1 << 19);
    }
}

tinyfp fixp2tinyfp(fixp f){

    int sign = (f & 0x80000000) >> 31;
    int exp = getExp(f);
    int frac = 0x0000;
    fixp f_inv = ~f + 1;
    fixp f_r2e;

    if(sign == 1){    
        //printf("DEBUG: f_inv = %X\n", f_inv);
        exp = getExp(f_inv);
        f_r2e = round2Even_fixp(f_inv, exp);
    }
    else{
        f_r2e = round2Even_fixp(f, exp);
    }
    exp = getExp(f_r2e);


    //printf("DEBUG: f = %X\n", f);
    //printf("DEBUG: sign = %X\n", sign);
    //printf("DEBUG: exp b4 r2e = %d\n", exp);

    //printf("DEBUG: f_inv = %X\n", f_inv);
    //printf("DEBUG: f_r2e = %X\n", f_r2e);
    //printf("DEBUG: frac = %X\n", frac);
    //printf("DEBUG: exp af. r2e = %d\n", exp);
    //printf("DEBUG: -----------------------\n");
   
    if(exp >= 4){
        if(sign == 0) return tinyfp_posInf;
        else return tinyfp_negInf;
    }
    else if(exp <= -3){
        frac = (f_r2e >> 4) & 0xF;
        return ((sign << 7) + frac);
    }
    else{
        frac = (f_r2e >> (6 + exp)) & 0xF;
        //printf("DEBUG: exp w/ bias = %X\n", exp+3);
        //printf("DEBUG: frac = %X\n", frac);
        return ((sign << 7) + ((3 + exp) << 4) + frac);
    }
}


fixp tinyfp2fixp(tinyfp t)
{
    int sign = (t & 0b10000000) >> 7;
    int exp = ((t & 0b01110000) >> 4) - 3;
    int frac = t & 0b00001111;
    fixp target = 0;


    //printf("DEBUG: sign = %X\n", sign);
    //printf("DEBUG: exp = %d\n", exp);
    //printf("DEBUG: frac = %X\n", frac);

    if(isPosNaN(t) || isNegNaN(t) || t == tinyfp_posInf || t == tinyfp_negInf){
        return fixp_smallest;
    }
    if(t == 0b10000000 || t  == 0b00000000){
        return 0;
    }

    if(exp == -3){
        target = frac << 4;
        if(sign == 1) target = ~target + 1;
    }
    else{
        target = frac << 6;
        target += (1 << 10);
        if(exp < 0)
            target = target >> -exp;
        else if(exp >= 0)
            target = target << exp;
       
        //printf("DEBUG: target = %X\n", target);
        if(sign == 1) target = ~target + 1;
    }

	return target;
}


tinyfp float2tinyfp(float f)
{   
    union bitwise_float u;
    u.f = f;

    int sign = (u.bw_f & 0x80000000) >> 31;
    int exp = ((u.bw_f & 0x7F800000) >> 23) - 127;
    int frac = u.bw_f & 0x7FFFFF;
    int f_r2e = 0;
    int exp_r2e = 0;
    int frac_r2e = 0;


    int exp_tgt = 0;
    int frac_tgt = 0;

    //printf("DEBUG: f = %X\n", u.bw_f);
    //printf("DEBUG: sign = %X\n", sign);
    //printf("DEBUG: exp = %d\n", exp);
    //printf("DEBUG: frac = %X\n", frac);

    if(exp >= 4 && frac == 0){ 
        if(sign == 0) return tinyfp_posInf;
        else return tinyfp_negInf;
    }
    else if(exp >= 4 && frac != 0){
        if(sign == 0) return tinyfp_posNaN;
        else return tinyfp_negNaN;
    }

    f_r2e = round2Even_float(u.bw_f);

    //printf("DEBUG: f_r2e = %X\n", f_r2e);

    exp_r2e = ((f_r2e & 0x7F800000) >> 23) - 127;
    frac_r2e = f_r2e & 0x7FFFFF;

    //printf("DEBUG: exp_r2e = %d\n", exp_r2e);
    //printf("DEBUG: frac_r2e = %X\n", frac_r2e);

    if(exp_r2e <= -3){
        exp_tgt = 0;

        frac_tgt = (frac_r2e >> 19);
        //printf("DEBUG: intermediate frac_r2e =  %X\n", frac_tgt);
    }
    else{
        frac_tgt = frac_r2e >> 19;
        exp_tgt = exp_r2e + 3;
    }

    //printf("DEBUG: exp_tgt = %d\n", exp_tgt);
    //printf("DEBUG: frac_tgt = %X\n", frac_tgt);

    if(exp_tgt == 7){
        if(sign == 0) return tinyfp_posInf;
        else return tinyfp_negInf;
    }

	return (sign << 7) + (exp_tgt << 4) + frac_tgt;
}


float tinyfp2float(tinyfp t)
{   
    union bitwise_float u;

    float tgt = 0;
    
    int sign = (t & 0b10000000) >> 7;
    int exp = ((t & 0b01110000) >> 4) - 3;
    int frac = t & 0b00001111;

    //printf("DEBUG: sign = %X\n", sign);
    //printf("DEBUG: exp = %d\n", exp);
    //printf("DEBUG: frac = %X\n", frac);

    if(t == tinyfp_posInf){
        u.bw_f = float_posInf;
        return u.f;
    }
    if(t == tinyfp_negInf){
        u.bw_f = float_negInf;
        return u.f;
    }
    if(isPosNaN(t)){
        u.bw_f = float_posNaN;
        return u.f;
    }
    if(isNegNaN(t)){
        u.bw_f = float_negNaN;
        return u.f;
    }

    //printf("DEBUG: %d\n", frac & 0b0010);
    if(exp == -3){
        tgt = (((frac & 0b1000) >> 3) * (1.0/2)) + (((frac & 0b0100) >> 2) * (1.0/4)) + (((frac & 0b0010) >> 1) * (1.0/8)) + ((frac & 0b0001) * (1.0/16));
        tgt *= (1.0/4);
    }
    else{
        tgt = 1 + (((frac & 0b1000) >> 3) * (1.0/2)) + (((frac & 0b0100) >> 2) * (1.0/4)) + (((frac & 0b0010) >> 1) * (1.0/8)) + ((frac & 0b0001) * (1.0/16));
        if(exp == -2) tgt *= (1.0/4);
        else if(exp == -1) tgt *= (1.0/2);
        else if(exp == 0) tgt *= 1;
        else if(exp == 1) tgt *= 2;
        else if(exp == 2) tgt *= 4;
        else tgt *= 8;
    }

    if(sign == 1) tgt = -tgt;
    
    //printf("DEBUG: tgt = %f\n", tgt);
    return tgt;
}
