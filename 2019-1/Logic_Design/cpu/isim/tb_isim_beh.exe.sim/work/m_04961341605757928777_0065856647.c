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
static const char *ng0 = "/home/peacesong/Documents/Workspace/2019-1/Logic_Design/cpu/cpu.v";
static int ng1[] = {1, 0};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {2U, 0U};
static unsigned int ng6[] = {3U, 0U};



static void Always_90_0(char *t0)
{
    char t6[8];
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
    char *t31;
    char *t32;
    char *t33;
    char *t34;

LAB0:    t1 = (t0 + 4120U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 4440);
    *((int *)t2) = 1;
    t3 = (t0 + 4152);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(90, ng0);

LAB5:    xsi_set_current_line(91, ng0);
    t4 = (t0 + 1368U);
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

LAB11:    xsi_set_current_line(97, ng0);

LAB14:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t4);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB18;

LAB15:    if (t18 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t6) = 1;

LAB18:    t8 = (t6 + 4);
    t23 = *((unsigned int *)t8);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(112, ng0);
    t2 = (t0 + 1208U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t5 = (t4 + 4);
    t7 = (t2 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t7);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB46;

LAB43:    if (t18 != 0)
        goto LAB45;

LAB44:    *((unsigned int *)t6) = 1;

LAB46:    t21 = (t6 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB47;

LAB48:
LAB49:
LAB21:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(91, ng0);

LAB13:    xsi_set_current_line(92, ng0);
    t28 = ((char*)((ng2)));
    t29 = (t0 + 2728);
    xsi_vlogvar_assign_value(t29, t28, 0, 0, 8);
    xsi_set_current_line(93, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2888);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3048);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(95, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    goto LAB12;

LAB17:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(98, ng0);

LAB22:    xsi_set_current_line(99, ng0);
    t21 = (t0 + 1528U);
    t22 = *((char **)t21);

LAB23:    t21 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 2, t21, 2);
    if (t30 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 2, t2, 2);
    if (t30 == 1)
        goto LAB26;

LAB27:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 2, t2, 2);
    if (t30 == 1)
        goto LAB28;

LAB29:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 2, t2, 2);
    if (t30 == 1)
        goto LAB30;

LAB31:
LAB32:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 1688U);
    t3 = *((char **)t2);

LAB33:    t2 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB34;

LAB35:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB36;

LAB37:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB38;

LAB39:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t3, 2, t2, 2);
    if (t30 == 1)
        goto LAB40;

LAB41:
LAB42:    goto LAB21;

LAB24:    xsi_set_current_line(100, ng0);
    t28 = (t0 + 2728);
    t29 = (t28 + 56U);
    t31 = *((char **)t29);
    t32 = (t0 + 2408);
    xsi_vlogvar_assign_value(t32, t31, 0, 0, 8);
    goto LAB32;

LAB26:    xsi_set_current_line(101, ng0);
    t3 = (t0 + 2888);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 2408);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);
    goto LAB32;

LAB28:    xsi_set_current_line(102, ng0);
    t3 = (t0 + 3048);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 2408);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);
    goto LAB32;

LAB30:    xsi_set_current_line(103, ng0);
    t3 = (t0 + 3208);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 2408);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);
    goto LAB32;

LAB34:    xsi_set_current_line(106, ng0);
    t4 = (t0 + 2728);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB42;

LAB36:    xsi_set_current_line(107, ng0);
    t4 = (t0 + 2888);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB42;

LAB38:    xsi_set_current_line(108, ng0);
    t4 = (t0 + 3048);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB42;

LAB40:    xsi_set_current_line(109, ng0);
    t4 = (t0 + 3208);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB42;

LAB45:    t8 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB46;

LAB47:    xsi_set_current_line(112, ng0);

LAB50:    xsi_set_current_line(113, ng0);
    t28 = (t0 + 1528U);
    t29 = *((char **)t28);

LAB51:    t28 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t29, 2, t28, 2);
    if (t30 == 1)
        goto LAB52;

LAB53:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t29, 2, t2, 2);
    if (t30 == 1)
        goto LAB54;

LAB55:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t29, 2, t2, 2);
    if (t30 == 1)
        goto LAB56;

LAB57:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t29, 2, t2, 2);
    if (t30 == 1)
        goto LAB58;

LAB59:
LAB60:    xsi_set_current_line(119, ng0);
    t2 = (t0 + 1688U);
    t4 = *((char **)t2);

LAB61:    t2 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t30 == 1)
        goto LAB62;

LAB63:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t30 == 1)
        goto LAB64;

LAB65:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t30 == 1)
        goto LAB66;

LAB67:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 2, t2, 2);
    if (t30 == 1)
        goto LAB68;

LAB69:
LAB70:    xsi_set_current_line(126, ng0);
    t2 = (t0 + 1848U);
    t5 = *((char **)t2);

LAB71:    t2 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t30 == 1)
        goto LAB72;

LAB73:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t30 == 1)
        goto LAB74;

LAB75:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t30 == 1)
        goto LAB76;

LAB77:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 2, t2, 2);
    if (t30 == 1)
        goto LAB78;

LAB79:
LAB80:    goto LAB49;

LAB52:    xsi_set_current_line(114, ng0);
    t31 = (t0 + 2728);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    t34 = (t0 + 2408);
    xsi_vlogvar_assign_value(t34, t33, 0, 0, 8);
    goto LAB60;

LAB54:    xsi_set_current_line(115, ng0);
    t4 = (t0 + 2888);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2408);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB60;

LAB56:    xsi_set_current_line(116, ng0);
    t4 = (t0 + 3048);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2408);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB60;

LAB58:    xsi_set_current_line(117, ng0);
    t4 = (t0 + 3208);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 2408);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 8);
    goto LAB60;

LAB62:    xsi_set_current_line(120, ng0);
    t5 = (t0 + 2728);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 2568);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 8);
    goto LAB70;

LAB64:    xsi_set_current_line(121, ng0);
    t5 = (t0 + 2888);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 2568);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 8);
    goto LAB70;

LAB66:    xsi_set_current_line(122, ng0);
    t5 = (t0 + 3048);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 2568);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 8);
    goto LAB70;

LAB68:    xsi_set_current_line(123, ng0);
    t5 = (t0 + 3208);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 2568);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 8);
    goto LAB70;

LAB72:    xsi_set_current_line(127, ng0);
    t7 = (t0 + 2008U);
    t8 = *((char **)t7);
    t7 = (t0 + 2728);
    xsi_vlogvar_assign_value(t7, t8, 0, 0, 8);
    goto LAB80;

LAB74:    xsi_set_current_line(128, ng0);
    t7 = (t0 + 2008U);
    t8 = *((char **)t7);
    t7 = (t0 + 2888);
    xsi_vlogvar_assign_value(t7, t8, 0, 0, 8);
    goto LAB80;

LAB76:    xsi_set_current_line(129, ng0);
    t7 = (t0 + 2008U);
    t8 = *((char **)t7);
    t7 = (t0 + 3048);
    xsi_vlogvar_assign_value(t7, t8, 0, 0, 8);
    goto LAB80;

LAB78:    xsi_set_current_line(130, ng0);
    t7 = (t0 + 2008U);
    t8 = *((char **)t7);
    t7 = (t0 + 3208);
    xsi_vlogvar_assign_value(t7, t8, 0, 0, 8);
    goto LAB80;

}


extern void work_m_04961341605757928777_0065856647_init()
{
	static char *pe[] = {(void *)Always_90_0};
	xsi_register_didat("work_m_04961341605757928777_0065856647", "isim/tb_isim_beh.exe.sim/work/m_04961341605757928777_0065856647.didat");
	xsi_register_executes(pe);
}
