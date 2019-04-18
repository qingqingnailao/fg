/* �мǣ������ﲻ������rtsxxx.lib�ļ�
// TI File $Revision: /main/9 $
// Checkin $Date: August 28, 2007   11:23:38 $
//###########################################################################
//
// FILE:	F28335.cmd
//
// TITLE:	Linker Command File For F28335 Device
//
//###########################################################################
// $TI Release: DSP2833x Header Files V1.10 $
// $Release Date: February 15, 2008 $
//###########################################################################
*/

/* ======================================================
// For Code Composer Studio V2.2 and later
// ---------------------------------------
// In addition to this memory linker command file, 
// add the header linker command file directly to the project. 
// The header linker command file is required to link the
// peripheral structures to the proper locations within 
// the memory map.
//
// The header linker files are found in <base>\DSP2833x_Headers\cmd
//   
// For BIOS applications add:      DSP2833x_Headers_BIOS.cmd
// For nonBIOS applications add:   DSP2833x_Headers_nonBIOS.cmd    
========================================================= */

/* ======================================================
// For Code Composer Studio prior to V2.2
// --------------------------------------
// 1) Use one of the following -l statements to include the 
// header linker command file in the project. The header linker
// file is required to link the peripheral structures to the proper 
// locations within the memory map                                    */

/* Uncomment this line to include file only for non-BIOS applications */
/* -l DSP2833x_Headers_nonBIOS.cmd */

/* Uncomment this line to include file only for BIOS applications */
/* -l DSP2833x_Headers_BIOS.cmd */

/* 2) In your project add the path to <base>\DSP2833x_headers\cmd to the
   library search path under project->build options, linker tab, 
   library search path (-i).
/*========================================================= */

/* Define the memory block start/length for the F28335  
   PAGE 0 will be used to organize program sections
   PAGE 1 will be used to organize data sections

    Notes: 
          Memory blocks on F28335 are uniform (ie same
          physical memory) in both PAGE 0 and PAGE 1.  
          That is the same memory region should not be
          defined for both PAGE 0 and PAGE 1.
          Doing so will result in corruption of program 
          and/or data. 
          
          L0/L1/L2 and L3 memory blocks are mirrored - that is
          they can be accessed in high memory or low memory.
          For simplicity only one instance is used in this
          linker file. 
          
          Contiguous SARAM memory blocks can be combined 
          if required to create a larger memory block. 
 */

#include "flashburn.h"
#ifdef FLASHBURN

MEMORY
{
PAGE 0:    /* Program Memory */
           /* Memory (RAM/FLASH/OTP) blocks can be moved to PAGE1 for data allocation */
   RAML0123    : origin = 0x008000, length = 0x004000	 /*	program area */
/* RAML0       : origin = 0x008000, length = 0x001000    
   RAML1       : origin = 0x009000, length = 0x001000    
   RAML2       : origin = 0x00A000, length = 0x001000    
   RAML3       : origin = 0x00B000, length = 0x001000
*/
   RAM_EX_PROG : origin = 0x200000, length = 0x080000     /* XINTF zone 7A -  program area */
  
  
   ZONE0       : origin = 0x004000, length = 0x001000     /* XINTF zone 0 */
/* ZONE6       : origin = 0x0200000, length = 0x100000 */ /* XINTF zone 7 */ 
   ZONE7A      : origin = 0x0100000, length = 0x00FC00    /* XINTF zone 6 - program space */ 
   FLASHH      : origin = 0x300000, length = 0x008000     /* on-chip FLASH */
   FLASHG      : origin = 0x308000, length = 0x008000     /* on-chip FLASH */
   FLASHF      : origin = 0x310000, length = 0x008000     /* on-chip FLASH */
   FLASHE      : origin = 0x318000, length = 0x008000     /* on-chip FLASH */
   FLASHD      : origin = 0x320000, length = 0x008000     /* on-chip FLASH */
   FLASHC_S  : origin = 0x328000, length = 0x000010    /*FLASH C_S��ų���������Ϣ*/
   FLASHC    : origin = 0x328010, length = 0x007FF0     /* FLASH C��ų����Text�� */

   FLASHA      : origin = 0x338000, length = 0x007F80     /* on-chip FLASH */ /* no use*/
   CSM_RSVD    : origin = 0x33FF80, length = 0x000076     /* Part of FLASHA.  Program with all 0x0000 when CSM is in use. */
   BEGIN       : origin = 0x33FFF6, length = 0x000002     /* Part of FLASHA.  Used for "boot to Flash" bootloader mode. */
   CSM_PWL     : origin = 0x33FFF8, length = 0x000008     /* Part of FLASHA.  CSM password locations in FLASHA */
   OTP         : origin = 0x380400, length = 0x000400     /* on-chip OTP */
   ADC_CAL     : origin = 0x380080, length = 0x000009     /* ADC_cal function in Reserved memory */
   IQTABLES    : origin = 0x3FE000, length = 0x000b50     /* IQ Math Tables in Boot ROM */
   IQTABLES2   : origin = 0x3FEB50, length = 0x00008c     /* IQ Math Tables in Boot ROM */  
   FPUTABLES   : origin = 0x3FEBDC, length = 0x0006A0     /* FPU Tables in Boot ROM */
   ROM         : origin = 0x3FF27C, length = 0x000D44     /* Boot ROM */        
   RESET       : origin = 0x3FFFC0, length = 0x000002     /* part of boot ROM  */
   VECTORS     : origin = 0x3FFFC2, length = 0x00003E     /* part of boot ROM  */

PAGE 1 :   /* Data Memory */
           /* Memory (RAM/FLASH/OTP) blocks can be moved to PAGE0 for program allocation */
           /* Registers remain on PAGE1                                                  */
   
   RAML4567    : origin = 0x00C000, length = 0x004000	  /* data area */
/* RAML4	   : origin = 0x00C000, length = 0x001000    
   RAML5       : origin = 0x00D000, length = 0x001000    
   RAML6       : origin = 0x00E000, length = 0x001000    
   RAML7       : origin = 0x00F000, length = 0x001000
*/
   RAM_EX_DATA : origin = 0x280000, length = 0x080000     /* XINTF zone 7B - data space */
/* RAM_WLG_g   : origin = 0x200000, length = 0x100000*/   /* XINTF zone 7 - data space */


   BOOT_RSVD   : origin = 0x000000, length = 0x000050     /* Part of M0, BOOT rom will use this for stack */
   RAMM0       : origin = 0x000050, length = 0x0003B0     /* on-chip RAM block M0 */
   RAMM1       : origin = 0x000400, length = 0x000400     /* on-chip RAM block M1 */
   ZONE6B      : origin = 0x10FC00, length = 0x000400     /* XINTF zone 6 - data space */
   FLASHB      : origin = 0x330000, length = 0x008000     /* on-chip FLASH */
}

/* Allocate sections to memory blocks.
   Note:
         codestart user defined section in DSP28_CodeStartBranch.asm used to redirect code 
                   execution when booting to flash
         ramfuncs  user defined section to store functions that will be copied from Flash into RAM
*/ 
 
SECTIONS
{
 
   /* Allocate program areas: */
   .cinit              : > FLASHC      PAGE = 0
   .pinit              : > FLASHC,     PAGE = 0
   
   codestart           : > BEGIN       PAGE = 0
   
   ramfuncs            : LOAD = FLASHC, 
                         RUN = RAML0123, 
                         LOAD_START(_RamfuncsLoadStart),
                         LOAD_END(_RamfuncsLoadEnd),
                         RUN_START(_RamfuncsRunStart),
                         PAGE = 0

         
	Ramfuncs2:
	{  
	/* 
		-l rts2800_fpu32.lib<atan.obj> 		(.text)
		-l rts2800_fpu32.lib<atan2.obj> 	(.text)
		-l rts2800_fpu32.lib<exp.obj> 		(.text)
		-l rts2800_fpu32.lib<ldexp.obj> 	(.text)
		-l rts2800_fpu32.lib<frexp.obj> 	(.text)
	*/
		-l rts2800_fpu32.lib<fs_div.obj>	(.text)
		-l rts2800_fpu32.lib<u_div.obj> 	(.text)
		-l rts2800_fpu32.lib<sin.obj> 		(.text)
		-l rts2800_fpu32.lib<cos.obj> 		(.text)
		-l rts2800_fpu32.lib<sqrt.obj> 		(.text)
		-l rts2800_fpu32.lib<lock.obj> 		(.text)
		-l C28x_FPU_Lib.lib<RFFT_f32.obj>	(.text)
	}
   	   					 LOAD = FLASHC, 
                         RUN = RAML0123, 
                         LOAD_START(_RamfuncsLoadStart2),
                         LOAD_END(_RamfuncsLoadEnd2),
                         RUN_START(_RamfuncsRunStart2),
                         PAGE = 0
   
	flashstart         : > FLASHC_S,      PAGE = 0
   Progload28335_CAN:
    				   {
        				  -lProgload28335_CAN.lib(.text)
    				   }                  
    				   LOAD = FLASHC, PAGE = 0
                       RUN = RAML0123, PAGE = 0
                       LOAD_START(_Progload28335_CAN_LoadStart),
                       LOAD_END(_Progload28335_CAN_LoadEnd),
                       RUN_START(_Progload28335_CAN_RunStart) 
    Flash28_API:
    				   {
        				  -lFlash28335_API_V210.lib(.econst) 
        				  -lFlash28335_API_V210.lib(.text)
    				   }                  
    				   LOAD = FLASHC, PAGE = 0
                       RUN = RAML0123, PAGE = 0
                       LOAD_START(_Flash28_API_LoadStart),
                       LOAD_END(_Flash28_API_LoadEnd),
                       RUN_START(_Flash28_API_RunStart)

   .text2     : {*(.text)} > FLASHC      PAGE = 0
   
   csmpasswds          : > CSM_PWL     PAGE = 0
   csm_rsvd            : > CSM_RSVD    PAGE = 0
   
   /* Allocate uninitalized data sections: */
   .stack              : > RAMM1       PAGE = 1
   .esysmem            : > RAMM1       PAGE = 1
   .ebss               : > RAML4567    PAGE = 1

   /* Initalized sections go in Flash */
   /* For SDFlash to program these, they must be allocated to page 0 */
   .econst             : > FLASHC      PAGE = 0
   .switch             : > FLASHC      PAGE = 0      

   RFFT_IN_LM1	     : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_LM2		 : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_LM3       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_LM4       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_CT1       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_CT2       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_CT3       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT_IN_CT4       : > RAML4567,     PAGE = 1, ALIGN(256)
   RFFT			     : > RAML4567,     PAGE = 1

   /* Allocate IQ math areas: */
   IQmath              : > FLASHC     PAGE = 0                  /* Math Code */
   IQmathTables        : > IQTABLES,  PAGE = 0, TYPE = NOLOAD 
   IQmathTables2       : > IQTABLES2, PAGE = 0, TYPE = NOLOAD 
   FPUmathTables       : > FPUTABLES, PAGE = 0, TYPE = NOLOAD 
         
   /* Allocate DMA-accessible RAM sections: */
   DMARAML4            : > RAML4567,  PAGE = 1
   DMARAML5            : > RAML4567,  PAGE = 1
   DMARAML6            : > RAML4567,  PAGE = 1
   DMARAML7            : > RAML4567,  PAGE = 1
   
   /* Allocate 0x400 of XINTF Zone 6 to storing data */
   ZONE6DATA        : > ZONE6B,    PAGE = 1

   /* .reset is a standard section used by the compiler.  It contains the */ 
   /* the address of the start of _c_int00 for C Code.   /*
   /* When using the boot ROM this section and the CPU vector */
   /* table is not needed.  Thus the default type is set here to  */
   /* DSECT  */ 
   .reset              : > RESET,      PAGE = 0, TYPE = DSECT
   vectors             : > VECTORS     PAGE = 0, TYPE = DSECT
   
   /* Allocate ADC_cal function (pre-programmed by factory into TI reserved memory) */
   .adc_cal     : load = ADC_CAL,   PAGE = 0, TYPE = NOLOAD

	WLG_g           : > RAM_EX_DATA,     PAGE = 1  
	DFT_g           : > RAM_EX_DATA,     PAGE = 1  
}
#endif
/*
//===========================================================================
// End of file.
//===========================================================================
*/
