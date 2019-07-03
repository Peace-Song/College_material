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
static const char *ng0 = "/home/peacesong/Documents/Workspace/2019-1/Logic_Design/cpu/tb.v";
static unsigned int ng1[] = {1U, 0U};
static int ng2[] = {0, 0};
static unsigned int ng3[] = {2U, 0U};
static int ng4[] = {1, 0};
static unsigned int ng5[] = {3U, 0U};
static int ng6[] = {2, 0};
static unsigned int ng7[] = {4U, 0U};
static int ng8[] = {3, 0};
static unsigned int ng9[] = {5U, 0U};
static int ng10[] = {4, 0};
static unsigned int ng11[] = {6U, 0U};
static int ng12[] = {5, 0};
static unsigned int ng13[] = {7U, 0U};
static int ng14[] = {6, 0};
static unsigned int ng15[] = {8U, 0U};
static int ng16[] = {7, 0};
static unsigned int ng17[] = {9U, 0U};
static int ng18[] = {8, 0};
static unsigned int ng19[] = {16U, 0U};
static int ng20[] = {9, 0};
static unsigned int ng21[] = {17U, 0U};
static int ng22[] = {10, 0};
static unsigned int ng23[] = {18U, 0U};
static int ng24[] = {11, 0};
static unsigned int ng25[] = {19U, 0U};
static int ng26[] = {12, 0};
static unsigned int ng27[] = {20U, 0U};
static int ng28[] = {13, 0};
static unsigned int ng29[] = {21U, 0U};
static int ng30[] = {14, 0};
static unsigned int ng31[] = {22U, 0U};
static int ng32[] = {15, 0};
static unsigned int ng33[] = {23U, 0U};
static int ng34[] = {16, 0};
static unsigned int ng35[] = {24U, 0U};
static int ng36[] = {17, 0};
static unsigned int ng37[] = {25U, 0U};
static int ng38[] = {18, 0};
static unsigned int ng39[] = {32U, 0U};
static int ng40[] = {19, 0};
static unsigned int ng41[] = {33U, 0U};
static int ng42[] = {20, 0};
static unsigned int ng43[] = {34U, 0U};
static int ng44[] = {21, 0};
static unsigned int ng45[] = {35U, 0U};
static int ng46[] = {22, 0};
static unsigned int ng47[] = {36U, 0U};
static int ng48[] = {23, 0};
static unsigned int ng49[] = {37U, 0U};
static int ng50[] = {24, 0};
static unsigned int ng51[] = {38U, 0U};
static int ng52[] = {25, 0};
static unsigned int ng53[] = {39U, 0U};
static int ng54[] = {26, 0};
static unsigned int ng55[] = {40U, 0U};
static int ng56[] = {27, 0};
static unsigned int ng57[] = {41U, 0U};
static int ng58[] = {28, 0};
static unsigned int ng59[] = {48U, 0U};
static int ng60[] = {29, 0};
static unsigned int ng61[] = {49U, 0U};
static int ng62[] = {30, 0};
static unsigned int ng63[] = {50U, 0U};
static int ng64[] = {31, 0};
static int ng65[] = {32, 0};
static unsigned int ng66[] = {255U, 0U};



static void Always_342_0(char *t0)
{
    char t13[8];
    char t14[8];
    char t41[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    unsigned int t23;
    int t24;
    char *t25;
    unsigned int t26;
    int t27;
    int t28;
    unsigned int t29;
    unsigned int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t42;
    unsigned int t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;

LAB0:    t1 = (t0 + 3160U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(342, ng0);
    t2 = (t0 + 3728);
    *((int *)t2) = 1;
    t3 = (t0 + 3192);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(343, ng0);

LAB5:    xsi_set_current_line(344, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(380, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t13, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t6 = *((unsigned int *)t3);
    t7 = *((unsigned int *)t2);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t23 = (t9 ^ t10);
    t26 = (t8 | t23);
    t29 = *((unsigned int *)t4);
    t30 = *((unsigned int *)t5);
    t33 = (t29 | t30);
    t34 = (~(t33));
    t35 = (t26 & t34);
    if (t35 != 0)
        goto LAB75;

LAB74:    if (t33 != 0)
        goto LAB76;

LAB77:    t12 = (t13 + 4);
    t36 = *((unsigned int *)t12);
    t37 = (~(t36));
    t38 = *((unsigned int *)t13);
    t39 = (t38 & t37);
    t40 = (t39 != 0);
    if (t40 > 0)
        goto LAB78;

LAB79:
LAB80:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(345, ng0);

LAB9:    xsi_set_current_line(346, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2248);
    t15 = (t0 + 2248);
    t16 = (t15 + 72U);
    t17 = *((char **)t16);
    t18 = (t0 + 2248);
    t19 = (t18 + 64U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng2)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t17, t20, 2, 1, t21, 32, 1);
    t22 = (t13 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (!(t23));
    t25 = (t14 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (!(t26));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB10;

LAB11:    xsi_set_current_line(347, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng4)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB12;

LAB13:    xsi_set_current_line(348, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng6)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB14;

LAB15:    xsi_set_current_line(349, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng8)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB16;

LAB17:    xsi_set_current_line(350, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng10)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB18;

LAB19:    xsi_set_current_line(351, ng0);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng12)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB20;

LAB21:    xsi_set_current_line(352, ng0);
    t2 = ((char*)((ng13)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng14)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB22;

LAB23:    xsi_set_current_line(353, ng0);
    t2 = ((char*)((ng15)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng16)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB24;

LAB25:    xsi_set_current_line(354, ng0);
    t2 = ((char*)((ng17)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng18)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB26;

LAB27:    xsi_set_current_line(355, ng0);
    t2 = ((char*)((ng19)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng20)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB28;

LAB29:    xsi_set_current_line(356, ng0);
    t2 = ((char*)((ng21)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng22)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB30;

LAB31:    xsi_set_current_line(357, ng0);
    t2 = ((char*)((ng23)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng24)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB32;

LAB33:    xsi_set_current_line(358, ng0);
    t2 = ((char*)((ng25)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng26)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB34;

LAB35:    xsi_set_current_line(359, ng0);
    t2 = ((char*)((ng27)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng28)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB36;

LAB37:    xsi_set_current_line(360, ng0);
    t2 = ((char*)((ng29)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng30)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB38;

LAB39:    xsi_set_current_line(361, ng0);
    t2 = ((char*)((ng31)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng32)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB40;

LAB41:    xsi_set_current_line(362, ng0);
    t2 = ((char*)((ng33)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng34)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB42;

LAB43:    xsi_set_current_line(363, ng0);
    t2 = ((char*)((ng35)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng36)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB44;

LAB45:    xsi_set_current_line(364, ng0);
    t2 = ((char*)((ng37)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng38)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB46;

LAB47:    xsi_set_current_line(365, ng0);
    t2 = ((char*)((ng39)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng40)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB48;

LAB49:    xsi_set_current_line(366, ng0);
    t2 = ((char*)((ng41)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng42)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB50;

LAB51:    xsi_set_current_line(367, ng0);
    t2 = ((char*)((ng43)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng44)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB52;

LAB53:    xsi_set_current_line(368, ng0);
    t2 = ((char*)((ng45)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng46)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB54;

LAB55:    xsi_set_current_line(369, ng0);
    t2 = ((char*)((ng47)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng48)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB56;

LAB57:    xsi_set_current_line(370, ng0);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng50)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB58;

LAB59:    xsi_set_current_line(371, ng0);
    t2 = ((char*)((ng51)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng52)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB60;

LAB61:    xsi_set_current_line(372, ng0);
    t2 = ((char*)((ng53)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng54)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB62;

LAB63:    xsi_set_current_line(373, ng0);
    t2 = ((char*)((ng55)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng56)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB64;

LAB65:    xsi_set_current_line(374, ng0);
    t2 = ((char*)((ng57)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng58)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB66;

LAB67:    xsi_set_current_line(375, ng0);
    t2 = ((char*)((ng59)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng60)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB68;

LAB69:    xsi_set_current_line(376, ng0);
    t2 = ((char*)((ng61)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng62)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB70;

LAB71:    xsi_set_current_line(377, ng0);
    t2 = ((char*)((ng63)));
    t3 = (t0 + 2248);
    t4 = (t0 + 2248);
    t5 = (t4 + 72U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 64U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng64)));
    xsi_vlog_generic_convert_array_indices(t13, t14, t11, t16, 2, 1, t17, 32, 1);
    t18 = (t13 + 4);
    t6 = *((unsigned int *)t18);
    t24 = (!(t6));
    t19 = (t14 + 4);
    t7 = *((unsigned int *)t19);
    t27 = (!(t7));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB72;

LAB73:    goto LAB8;

LAB10:    t29 = *((unsigned int *)t13);
    t30 = *((unsigned int *)t14);
    t31 = (t29 - t30);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB11;

LAB12:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB13;

LAB14:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB15;

LAB16:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB17;

LAB18:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB19;

LAB20:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB21;

LAB22:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB23;

LAB24:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB25;

LAB26:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB27;

LAB28:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB29;

LAB30:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB31;

LAB32:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB33;

LAB34:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB35;

LAB36:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB37;

LAB38:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB39;

LAB40:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB41;

LAB42:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB43;

LAB44:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB45;

LAB46:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB47;

LAB48:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB49;

LAB50:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB51;

LAB52:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB53;

LAB54:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB55;

LAB56:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB57;

LAB58:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB59;

LAB60:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB61;

LAB62:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB63;

LAB64:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB65;

LAB66:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB67;

LAB68:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB69;

LAB70:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB71;

LAB72:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t14);
    t31 = (t8 - t9);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, *((unsigned int *)t14), t32, 0LL);
    goto LAB73;

LAB75:    *((unsigned int *)t13) = 1;
    goto LAB77;

LAB76:    t11 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB77;

LAB78:    xsi_set_current_line(381, ng0);

LAB81:    xsi_set_current_line(382, ng0);
    t15 = (t0 + 1688U);
    t16 = *((char **)t15);
    t15 = (t0 + 2248);
    t17 = (t0 + 2248);
    t18 = (t17 + 72U);
    t19 = *((char **)t18);
    t20 = (t0 + 2248);
    t21 = (t20 + 64U);
    t22 = *((char **)t21);
    t25 = (t0 + 1528U);
    t42 = *((char **)t25);
    xsi_vlog_generic_convert_array_indices(t14, t41, t19, t22, 2, 1, t42, 8, 2);
    t25 = (t14 + 4);
    t43 = *((unsigned int *)t25);
    t24 = (!(t43));
    t44 = (t41 + 4);
    t45 = *((unsigned int *)t44);
    t27 = (!(t45));
    t28 = (t24 && t27);
    if (t28 == 1)
        goto LAB82;

LAB83:    goto LAB80;

LAB82:    t46 = *((unsigned int *)t14);
    t47 = *((unsigned int *)t41);
    t31 = (t46 - t47);
    t32 = (t31 + 1);
    xsi_vlogvar_wait_assign_value(t15, t16, 0, *((unsigned int *)t41), t32, 0LL);
    goto LAB83;

}

static void Cont_386_1(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t20[8];
    char t24[8];
    char t32[8];
    char t79[8];
    char *t1;
    char *t2;
    char *t5;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t21;
    char *t22;
    char *t23;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t46;
    char *t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    char *t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    char *t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    char *t76;
    char *t77;
    char *t78;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    unsigned int t92;
    unsigned int t93;
    char *t94;
    unsigned int t95;
    unsigned int t96;
    char *t97;
    unsigned int t98;
    unsigned int t99;
    char *t100;

LAB0:    t1 = (t0 + 3408U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(386, ng0);
    t2 = (t0 + 1368U);
    t5 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t5 + 4);
    t7 = *((unsigned int *)t2);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB4;

LAB5:    if (*((unsigned int *)t2) != 0)
        goto LAB6;

LAB7:    t13 = (t6 + 4);
    t14 = *((unsigned int *)t6);
    t15 = (!(t14));
    t16 = *((unsigned int *)t13);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB8;

LAB9:    memcpy(t32, t6, 8);

LAB10:    memset(t4, 0, 8);
    t60 = (t32 + 4);
    t61 = *((unsigned int *)t60);
    t62 = (~(t61));
    t63 = *((unsigned int *)t32);
    t64 = (t63 & t62);
    t65 = (t64 & 1U);
    if (t65 != 0)
        goto LAB23;

LAB24:    if (*((unsigned int *)t60) != 0)
        goto LAB25;

LAB26:    t67 = (t4 + 4);
    t68 = *((unsigned int *)t4);
    t69 = *((unsigned int *)t67);
    t70 = (t68 || t69);
    if (t70 > 0)
        goto LAB27;

LAB28:    t72 = *((unsigned int *)t4);
    t73 = (~(t72));
    t74 = *((unsigned int *)t67);
    t75 = (t73 || t74);
    if (t75 > 0)
        goto LAB29;

LAB30:    if (*((unsigned int *)t67) > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t4) > 0)
        goto LAB33;

LAB34:    memcpy(t3, t79, 8);

LAB35:    t86 = (t0 + 3824);
    t88 = (t86 + 56U);
    t89 = *((char **)t88);
    t90 = (t89 + 56U);
    t91 = *((char **)t90);
    memset(t91, 0, 8);
    t92 = 255U;
    t93 = t92;
    t94 = (t3 + 4);
    t95 = *((unsigned int *)t3);
    t92 = (t92 & t95);
    t96 = *((unsigned int *)t94);
    t93 = (t93 & t96);
    t97 = (t91 + 4);
    t98 = *((unsigned int *)t91);
    *((unsigned int *)t91) = (t98 | t92);
    t99 = *((unsigned int *)t97);
    *((unsigned int *)t97) = (t99 | t93);
    xsi_driver_vfirst_trans(t86, 0, 7);
    t100 = (t0 + 3744);
    *((int *)t100) = 1;

LAB1:    return;
LAB4:    *((unsigned int *)t6) = 1;
    goto LAB7;

LAB6:    t12 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB7;

LAB8:    t18 = (t0 + 1528U);
    t19 = *((char **)t18);
    t18 = ((char*)((ng65)));
    memset(t20, 0, 8);
    t21 = (t19 + 4);
    if (*((unsigned int *)t21) != 0)
        goto LAB12;

LAB11:    t22 = (t18 + 4);
    if (*((unsigned int *)t22) != 0)
        goto LAB12;

LAB15:    if (*((unsigned int *)t19) > *((unsigned int *)t18))
        goto LAB13;

LAB14:    memset(t24, 0, 8);
    t25 = (t20 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t20);
    t29 = (t28 & t27);
    t30 = (t29 & 1U);
    if (t30 != 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t25) != 0)
        goto LAB18;

LAB19:    t33 = *((unsigned int *)t6);
    t34 = *((unsigned int *)t24);
    t35 = (t33 | t34);
    *((unsigned int *)t32) = t35;
    t36 = (t6 + 4);
    t37 = (t24 + 4);
    t38 = (t32 + 4);
    t39 = *((unsigned int *)t36);
    t40 = *((unsigned int *)t37);
    t41 = (t39 | t40);
    *((unsigned int *)t38) = t41;
    t42 = *((unsigned int *)t38);
    t43 = (t42 != 0);
    if (t43 == 1)
        goto LAB20;

LAB21:
LAB22:    goto LAB10;

LAB12:    t23 = (t20 + 4);
    *((unsigned int *)t20) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB14;

LAB13:    *((unsigned int *)t20) = 1;
    goto LAB14;

LAB16:    *((unsigned int *)t24) = 1;
    goto LAB19;

LAB18:    t31 = (t24 + 4);
    *((unsigned int *)t24) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB19;

LAB20:    t44 = *((unsigned int *)t32);
    t45 = *((unsigned int *)t38);
    *((unsigned int *)t32) = (t44 | t45);
    t46 = (t6 + 4);
    t47 = (t24 + 4);
    t48 = *((unsigned int *)t46);
    t49 = (~(t48));
    t50 = *((unsigned int *)t6);
    t51 = (t50 & t49);
    t52 = *((unsigned int *)t47);
    t53 = (~(t52));
    t54 = *((unsigned int *)t24);
    t55 = (t54 & t53);
    t56 = (~(t51));
    t57 = (~(t55));
    t58 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t58 & t56);
    t59 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t59 & t57);
    goto LAB22;

LAB23:    *((unsigned int *)t4) = 1;
    goto LAB26;

LAB25:    t66 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t66) = 1;
    goto LAB26;

LAB27:    t71 = ((char*)((ng66)));
    goto LAB28;

LAB29:    t76 = (t0 + 2248);
    t77 = (t76 + 56U);
    t78 = *((char **)t77);
    t80 = (t0 + 2248);
    t81 = (t80 + 72U);
    t82 = *((char **)t81);
    t83 = (t0 + 2248);
    t84 = (t83 + 64U);
    t85 = *((char **)t84);
    t86 = (t0 + 1528U);
    t87 = *((char **)t86);
    xsi_vlog_generic_get_array_select_value(t79, 8, t78, t82, t85, 2, 1, t87, 8, 2);
    goto LAB30;

LAB31:    xsi_vlog_unsigned_bit_combine(t3, 8, t71, 8, t79, 8);
    goto LAB35;

LAB33:    memcpy(t3, t71, 8);
    goto LAB35;

}


extern void work_m_14220053135729120782_2381739659_init()
{
	static char *pe[] = {(void *)Always_342_0,(void *)Cont_386_1};
	xsi_register_didat("work_m_14220053135729120782_2381739659", "isim/tb_isim_beh.exe.sim/work/m_14220053135729120782_2381739659.didat");
	xsi_register_executes(pe);
}
