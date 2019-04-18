#include "apply.h"
#include "cmm.h"
#include "pu.h"


//数据范围：
//无符型U： [0		65535]
//有符型I： [-32768  32767]
//浮点型F： [-32768  32767]，无论是否需要-号，最大不能超过32767.
//分辨率宗旨：设定频率0.01，转速0.1，电压1，电流1，功率1
//R表用I型变量，W表就不用I型变量了

//地址是二进制16位数据,即16进制4位,以下的位都是按16进制来讲述,地址共4位
//地址最高位是2,表示是主机的数据
//地址最高位是1,表示是从机的数据
//地址最高位是0,表示主机从机都有的数据
//cmm_r与cmm_w是不能重复的。规律在次高位,规定cmm_r的地址是0--4，cmm_w的地址是5--F
//地址0x999不可用,用于识别有无屏幕

CMMPARA  cmm_r[CMM_READ_N]=
{
//地址   	分辨率	下限		工厂值  	上限		读/系统	基准值	变量类型		变量名
// 第一组：
{0x1010,	1,		0,  		0,			1,			'R',    1,		'U',	&cmm.bstart_chg		},//开充电
{0x1011,	1,		0,  		0,			1,			'R',    1,		'U',	&cmm.bstart_dchg    },//开放电
{0x1012,	1,		0, 			0,			1,			'S',    1,		'U',	&cmm.bstart_1			},//bltest
{0x0003,	1,		0,  		0,			1,			'S',    1,		'U',	&cmm.bclear_error		},	// 清故障. 网侧船侧共用
{0x0004,	1,		0,  		0,			1,			'R',    1,		'U',	&cmm.ChargeFastSlow		},	// 

// 第二组：
{0x1021,	1,		0, 	        0,		    1000,		'R',    1,		'I',	&cmm.IA_ref_T			},
// 第十五组：
{0x1101,	1,		-32768, 	0,			32767,		'R',    1,		'I',	&cmm.in1				},
{0x1102,	1,		-32768,		0,			32767,		'R',    1,		'I',	&cmm.in2				},
{0x1103,	1,		-32768,		0,			32767,		'R',    1,		'I',	&cmm.in3				},
{0x1104,	1,		-32768,		250,		32767,		'R',    1,		'I',	&cmm.in4				},
{0x1105,	1,		-32768,		1000,		32767,		'R',    1,		'I',	&cmm.in5				},

{0x1106,	1,		-32768, 	1,			32767,		'R',    1,		'I',	&cmm.in6				},
{0x1107,	1,		-32768,		1,			32767,		'R',    1,		'I',	&cmm.in7				},
{0x1108,	1,		-32768,		30, 		32767,		'R',    1,		'I',	&cmm.in8				},
{0x1109,	1,		-32768,		1000,		32767,		'R',    1,		'I',	&cmm.in9				},
{0x1110,	1,		-32768,		100,		32767,		'R',    1,		'I',	&cmm.in10				},

{0x1111,	1,		-32768, 	130,		32767,		'R',    1,		'I',	&cmm.in11				},
{0x1112,	1,		-32768,		60,			32767,		'R',    1,		'I',	&cmm.in12				},
{0x1113,	1,		-32768,		130,		32767,		'R',    1,		'I',	&cmm.in13				},
{0x1114,	1,		-32768,		0,			32767,		'R',    1,		'I',	&cmm.in14				},
{0x1115,	1,		-32768,		0,			32767,		'R',    1,		'I',	&cmm.in15				},
};
//==================================================================================================================================================================================================================

CMMPARA  cmm_w[CMM_WRITE_N]=
{
//地址   	分辨率	下限		工厂值  	上限		写	基准值		变量类型	变量名
// 第一组：
{0x1500,  	1,  	0,			0,			1,			'W',    1,				'U',	&PcsA_1.BatRunState			},	//	"-" 	实际状态停止、运行
{0x1510,	1,		0, 			0,			1500,		'W',    UDCPU,			'F',	&drv_ad.udc				},	//	"V" 	实际直流电压
{0x1540,	1,		0, 			0,			1500,		'W',    UACPU*(3.43),	'F',	&rms_ua_in				},	//	"V" 	实际直流电压
{0x1541,	0.01,	0, 			0,			1500,		'W',    (1.0/1000.0),	'F',	&power.p_ct				},	//	"V" 	实际直流电压

// 第二组：

// 第三组：

// 第三组：

// 第四组：
{0x2550,  	1,  	0,			0,			0xFFFF,		'W',    1,		'U',	&except.warn			},	//	"-" 警告1
{0x2551,  	1,  	0,			0,			0xFFFF,		'W',    1,		'U',	&except.error			},	//	"-" 故障1

// 第xx组：
{0x1560,  	1,  	-32768, 	0,			32767,		'W',	1,		'I',	&cmm.out1				},
{0x1561,  	1,  	-32768, 	0,			32767,		'W',	1,		'I',	&cmm.out2				},
{0x2560,  	1,  	-32768, 	0,			32767,		'W',	1,		'I',	&cmm.out3				},
{0x2561,  	1,  	-32768, 	0,			32767,		'W',	1,		'I',	&cmm.out4				},
{0x2563,  	1,  	-32768, 	0,			32767,		'W',	1,		'I',	&cmm.out5				},
};
