/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab8/shift_reg_8b.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {3U, 0U};
static unsigned int ng3[] = {2U, 0U};
static unsigned int ng4[] = {1U, 0U};



static void Always_14_0(char *t0)
{
    char t6[8];
    char t31[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    int t30;

LAB0:    t1 = (t0 + 3160U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(14, ng0);
    t2 = (t0 + 3480);
    *((int *)t2) = 1;
    t3 = (t0 + 3192);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(14, ng0);

LAB5:    xsi_set_current_line(15, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t4 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t4);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(16, ng0);

LAB13:    xsi_set_current_line(17, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);

LAB14:    t2 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng3)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB19;

LAB20:
LAB22:
LAB21:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 2248);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 2248);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);

LAB23:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(15, ng0);
    t28 = ((char*)((ng1)));
    t29 = (t0 + 2248);
    xsi_vlogvar_assign_value(t29, t28, 0, 0, 8);
    goto LAB12;

LAB15:    xsi_set_current_line(18, ng0);
    t4 = (t0 + 1848U);
    t5 = *((char **)t4);
    t4 = (t0 + 2248);
    xsi_vlogvar_assign_value(t4, t5, 0, 0, 8);
    goto LAB23;

LAB17:    xsi_set_current_line(19, ng0);
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    t4 = (t0 + 2248);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    memset(t31, 0, 8);
    t21 = (t31 + 4);
    t22 = (t8 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (t9 >> 0);
    *((unsigned int *)t31) = t10;
    t11 = *((unsigned int *)t22);
    t12 = (t11 >> 0);
    *((unsigned int *)t21) = t12;
    t13 = *((unsigned int *)t31);
    *((unsigned int *)t31) = (t13 & 127U);
    t14 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t14 & 127U);
    xsi_vlogtype_concat(t6, 8, 8, 2U, t31, 7, t5, 1);
    t28 = (t0 + 2248);
    xsi_vlogvar_assign_value(t28, t6, 0, 0, 8);
    goto LAB23;

LAB19:    xsi_set_current_line(20, ng0);
    t4 = (t0 + 2248);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    memset(t31, 0, 8);
    t8 = (t31 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (t9 >> 1);
    *((unsigned int *)t31) = t10;
    t11 = *((unsigned int *)t21);
    t12 = (t11 >> 1);
    *((unsigned int *)t8) = t12;
    t13 = *((unsigned int *)t31);
    *((unsigned int *)t31) = (t13 & 127U);
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t14 & 127U);
    t22 = (t0 + 1688U);
    t28 = *((char **)t22);
    xsi_vlogtype_concat(t6, 8, 8, 2U, t28, 1, t31, 7);
    t22 = (t0 + 2248);
    xsi_vlogvar_assign_value(t22, t6, 0, 0, 8);
    goto LAB23;

}


extern void work_m_05917687237853127895_0567277079_init()
{
	static char *pe[] = {(void *)Always_14_0};
	xsi_register_didat("work_m_05917687237853127895_0567277079", "isim/shift_reg_8b_isim_beh.exe.sim/work/m_05917687237853127895_0567277079.didat");
	xsi_register_executes(pe);
}
