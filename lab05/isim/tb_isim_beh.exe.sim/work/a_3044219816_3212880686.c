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
static const char *ng0 = "/home/csmajs/masfo001/Downloads/lab05/cpu_components.vhd";
extern char *WORK_P_3583369287;



static void work_a_3044219816_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    int t18;
    int t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(276, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 4624);
    t4 = 1;
    if (2U == 2U)
        goto LAB5;

LAB6:    t4 = 0;

LAB7:    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 4626);
    t4 = 1;
    if (2U == 2U)
        goto LAB13;

LAB14:    t4 = 0;

LAB15:    if (t4 != 0)
        goto LAB11;

LAB12:    xsi_set_current_line(283, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t1 = ((WORK_P_3583369287) + 1768U);
    t3 = *((char **)t1);
    t14 = xsi_mem_cmp(t3, t2, 6U);
    if (t14 == 1)
        goto LAB20;

LAB27:    t1 = ((WORK_P_3583369287) + 1888U);
    t6 = *((char **)t1);
    t15 = xsi_mem_cmp(t6, t2, 6U);
    if (t15 == 1)
        goto LAB21;

LAB28:    t1 = ((WORK_P_3583369287) + 2008U);
    t7 = *((char **)t1);
    t16 = xsi_mem_cmp(t7, t2, 6U);
    if (t16 == 1)
        goto LAB22;

LAB29:    t1 = ((WORK_P_3583369287) + 2128U);
    t8 = *((char **)t1);
    t17 = xsi_mem_cmp(t8, t2, 6U);
    if (t17 == 1)
        goto LAB23;

LAB30:    t1 = ((WORK_P_3583369287) + 2248U);
    t9 = *((char **)t1);
    t18 = xsi_mem_cmp(t9, t2, 6U);
    if (t18 == 1)
        goto LAB24;

LAB31:    t1 = ((WORK_P_3583369287) + 2368U);
    t10 = *((char **)t1);
    t19 = xsi_mem_cmp(t10, t2, 6U);
    if (t19 == 1)
        goto LAB25;

LAB32:
LAB26:    xsi_set_current_line(290, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t2 = t1;
    memset(t2, (unsigned char)2, 4U);
    t3 = (t0 + 2904);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);

LAB19:
LAB3:    t1 = (t0 + 2824);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(277, ng0);
    t8 = ((WORK_P_3583369287) + 2728U);
    t9 = *((char **)t8);
    t8 = (t0 + 2904);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 4U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB3;

LAB5:    t5 = 0;

LAB8:    if (t5 < 2U)
        goto LAB9;
    else
        goto LAB7;

LAB9:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB6;

LAB10:    t5 = (t5 + 1);
    goto LAB8;

LAB11:    xsi_set_current_line(280, ng0);
    t8 = ((WORK_P_3583369287) + 2848U);
    t9 = *((char **)t8);
    t8 = (t0 + 2904);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 4U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB3;

LAB13:    t5 = 0;

LAB16:    if (t5 < 2U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB14;

LAB18:    t5 = (t5 + 1);
    goto LAB16;

LAB20:    xsi_set_current_line(284, ng0);
    t1 = ((WORK_P_3583369287) + 2488U);
    t11 = *((char **)t1);
    t1 = (t0 + 2904);
    t12 = (t1 + 56U);
    t13 = *((char **)t12);
    t20 = (t13 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t11, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB21:    xsi_set_current_line(285, ng0);
    t1 = ((WORK_P_3583369287) + 2608U);
    t2 = *((char **)t1);
    t1 = (t0 + 2904);
    t3 = (t1 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB22:    xsi_set_current_line(286, ng0);
    t1 = ((WORK_P_3583369287) + 2728U);
    t2 = *((char **)t1);
    t1 = (t0 + 2904);
    t3 = (t1 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB23:    xsi_set_current_line(287, ng0);
    t1 = ((WORK_P_3583369287) + 2848U);
    t2 = *((char **)t1);
    t1 = (t0 + 2904);
    t3 = (t1 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB24:    xsi_set_current_line(288, ng0);
    t1 = ((WORK_P_3583369287) + 2968U);
    t2 = *((char **)t1);
    t1 = (t0 + 2904);
    t3 = (t1 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB25:    xsi_set_current_line(289, ng0);
    t1 = ((WORK_P_3583369287) + 3088U);
    t2 = *((char **)t1);
    t1 = (t0 + 2904);
    t3 = (t1 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB19;

LAB33:;
}


extern void work_a_3044219816_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3044219816_3212880686_p_0};
	xsi_register_didat("work_a_3044219816_3212880686", "isim/tb_isim_beh.exe.sim/work/a_3044219816_3212880686.didat");
	xsi_register_executes(pe);
}
