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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_15196197707748857170_2885530436_init();
    work_m_07588606971434002998_0225447451_init();
    work_m_18088941667394697406_2180173631_init();
    work_m_12701946546026875303_0305373726_init();
    work_m_07776570237921942826_2021209643_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_07776570237921942826_2021209643");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
