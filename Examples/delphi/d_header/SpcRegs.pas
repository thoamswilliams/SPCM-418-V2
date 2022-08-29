unit SpcRegs;

interface

{ Spectrum C/C++ header file -> Pascal / Delphi unit file converter }
{ Source file: }
{ *********************************************************************** }
{ }
{ regs.h                                          (c) Spectrum GmbH, 2006 }
{ }
{ *********************************************************************** }
{ }
{ software register and constants definition for all Spectrum drivers.  }
{ Please stick to the card manual to see which of the inhere defined  }
{ registers are used on your hardware. }
{ }
{ *********************************************************************** }



{ *********************************************************************** }
{ macros for kilo, Mega or Giga as standard version or binary (_B) (2^x) }
{ *********************************************************************** }





{ *********************************************************************** }
{ card types }
{ *********************************************************************** }

const TYP_PCIDEVICEID             = $00000000;

{ ***** Board Types *************** }
const TYP_EVAL                    = $00000010;
const TYP_RSDLGA                  = $00000014;
const TYP_GMG                     = $00000018;
const TYP_VAN8                    = $00000020;
const TYP_VAC                     = $00000028;

const TYP_PCIAUTOINSTALL          = $000000FF;

const TYP_DAP116                  = $00000100;
const TYP_PAD82                   = $00000200;
const TYP_PAD82a                  = $00000210;
const TYP_PAD82b                  = $00000220;
const TYP_PCI212                  = $00000300;
const TYP_PAD1232a                = $00000400;
const TYP_PAD1232b                = $00000410;
const TYP_PAD1232c                = $00000420;
const TYP_PAD1616a                = $00000500;
const TYP_PAD1616b                = $00000510;
const TYP_PAD1616c                = $00000520;
const TYP_PAD1616d                = $00000530;
const TYP_PAD52                   = $00000600;
const TYP_PAD242                  = $00000700;
const TYP_PCK400                  = $00000800;
const TYP_PAD164_2M               = $00000900;
const TYP_PAD164_5M               = $00000910;
const TYP_PCI208                  = $00001000;
const TYP_CPCI208                 = $00001001;
const TYP_PCI412                  = $00001100;
const TYP_PCIDIO32                = $00001200;
const TYP_PCI248                  = $00001300;
const TYP_PADCO                   = $00001400;
const TYP_TRS582                  = $00001500;
const TYP_PCI258                  = $00001600;


{ ------ series and familiy identifiers ----- }
const TYP_SERIESMASK              = $00FF0000;     { the series (= type of base card), e.g. MI.xxxx }
const TYP_VERSIONMASK             = $0000FFFF;     { the version, e.g. XX.3012 }
const TYP_FAMILYMASK              = $0000FF00;     { the family, e.g. XX.30xx }
const TYP_TYPEMASK                = $000000FF;     { the type, e.g. XX.xx12 }
const TYP_SPEEDMASK               = $000000F0;     { the speed grade, e.g. XX.xx1x }
const TYP_CHMASK                  = $0000000F;     { the channel/modules, e.g. XX.xxx2 }

const TYP_MISERIES                = $00000000;
const TYP_MCSERIES                = $00010000;
const TYP_MXSERIES                = $00020000;
const TYP_M2ISERIES               = $00030000;
const TYP_M2IEXPSERIES            = $00040000;
const TYP_M3ISERIES               = $00050000;
const TYP_M3IEXPSERIES            = $00060000;
const TYP_M4IEXPSERIES            = $00070000;
const TYP_M4XEXPSERIES            = $00080000;
const TYP_M2PEXPSERIES            = $00090000;



{ ----- MI.20xx, MC.20xx, MX.20xx ----- }
const TYP_MI2020                  = $00002020;
const TYP_MI2021                  = $00002021;
const TYP_MI2025                  = $00002025;
const TYP_MI2030                  = $00002030;
const TYP_MI2031                  = $00002031;

const TYP_M2I2020                 = $00032020;
const TYP_M2I2021                 = $00032021;
const TYP_M2I2025                 = $00032025;
const TYP_M2I2030                 = $00032030;
const TYP_M2I2031                 = $00032031;

const TYP_M2I2020EXP              = $00042020;
const TYP_M2I2021EXP              = $00042021;
const TYP_M2I2025EXP              = $00042025;
const TYP_M2I2030EXP              = $00042030;
const TYP_M2I2031EXP              = $00042031;

const TYP_MC2020                  = $00012020;
const TYP_MC2021                  = $00012021;
const TYP_MC2025                  = $00012025;
const TYP_MC2030                  = $00012030;
const TYP_MC2031                  = $00012031;

const TYP_MX2020                  = $00022020;
const TYP_MX2025                  = $00022025;
const TYP_MX2030                  = $00022030;

{ ----- M3i.21xx, M3i.21xx-Exp (8 bit A/D) ----- }
const TYP_M3I2120                 = $00052120;     { 1x500M }
const TYP_M3I2122                 = $00052122;     { 1x500M & 2x250M }
const TYP_M3I2130                 = $00052130;     { 1x1G }
const TYP_M3I2132                 = $00052132;     { 1x1G & 2x500M }

const TYP_M3I2120EXP              = $00062120;     { 1x500M }
const TYP_M3I2122EXP              = $00062122;     { 1x500M & 2x250M }
const TYP_M3I2130EXP              = $00062130;     { 1x1G }
const TYP_M3I2132EXP              = $00062132;     { 1x1G & 2x500M }

{ ----- M4i.22xx-x8 (8 bit A/D) ----- }
const TYP_M4I22XX_X8              = $00072200;
const TYP_M4I2210_X8              = $00072210;     { 1x1.25G }
const TYP_M4I2211_X8              = $00072211;     { 2x1.25G }
const TYP_M4I2212_X8              = $00072212;     { 4x1.25G }
const TYP_M4I2220_X8              = $00072220;     { 1x2.5G }
const TYP_M4I2221_X8              = $00072221;     { 2x2.5G }
const TYP_M4I2223_X8              = $00072223;     { 1x2.5G & 2x1.25G }
const TYP_M4I2230_X8              = $00072230;     { 1x5G }
const TYP_M4I2233_X8              = $00072233;     { 1x5G & 2x2.5G  }
const TYP_M4I2234_X8              = $00072234;     { 1x5G & 2x2.5G & 4x1.25G }
const TYP_M4I2280_X8              = $00072280;     { customer specific variant }
const TYP_M4I2281_X8              = $00072281;     { customer specific variant }
const TYP_M4I2283_X8              = $00072283;     { customer specific variant }
const TYP_M4I2290_X8              = $00072290;     { customer specific variant }
const TYP_M4I2293_X8              = $00072293;     { customer specific variant }
const TYP_M4I2294_X8              = $00072294;     { customer specific variant }

{ ----- M4x.22xx-x8 (8 bit A/D) ----- }
const TYP_M4X22XX_X4              = $00082200;
const TYP_M4X2210_X4              = $00082210;     { 1x1.25G }
const TYP_M4X2211_X4              = $00082211;     { 2x1.25G }
const TYP_M4X2212_X4              = $00082212;     { 4x1.25G }
const TYP_M4X2220_X4              = $00082220;     { 1x2.5G }
const TYP_M4X2221_X4              = $00082221;     { 2x2.5G }
const TYP_M4X2223_X4              = $00082223;     { 1x2.5G & 2x1.25G }
const TYP_M4X2230_X4              = $00082230;     { 1x5G }
const TYP_M4X2233_X4              = $00082233;     { 1x5G & 2x2.5G  }
const TYP_M4X2234_X4              = $00082234;     { 1x5G & 2x2.5G & 4x1.25G }

{ ----- M4i.23xx-x8 (7 bit A/D) ----- }
const TYP_M4I23XX_X8              = $00072300;
const TYP_M4I2320_X8              = $00072320;     { 1x2.5G }
const TYP_M4I2321_X8              = $00072321;     { 2x2.5G }
const TYP_M4I2323_X8              = $00072323;     { 1x2.5G & 2x1.25G }
const TYP_M4I2330_X8              = $00072330;     { 1x5G }
const TYP_M4I2333_X8              = $00072333;     { 1x5G & 2x2.5G  }
const TYP_M4I2334_X8              = $00072334;     { 1x5G & 2x2.5G & 4x1.25G }

{ ----- MI.30xx, MC.30xx, MX.30xx ----- }
const TYP_MI3010                  = $00003010;
const TYP_MI3011                  = $00003011;
const TYP_MI3012                  = $00003012;
const TYP_MI3013                  = $00003013;
const TYP_MI3014                  = $00003014;
const TYP_MI3015                  = $00003015;
const TYP_MI3016                  = $00003016;
const TYP_MI3020                  = $00003020;
const TYP_MI3021                  = $00003021;
const TYP_MI3022                  = $00003022;
const TYP_MI3023                  = $00003023;
const TYP_MI3024                  = $00003024;
const TYP_MI3025                  = $00003025;
const TYP_MI3026                  = $00003026;
const TYP_MI3027                  = $00003027;
const TYP_MI3031                  = $00003031;
const TYP_MI3033                  = $00003033;

const TYP_M2I3010                 = $00033010;
const TYP_M2I3011                 = $00033011;
const TYP_M2I3012                 = $00033012;
const TYP_M2I3013                 = $00033013;
const TYP_M2I3014                 = $00033014;
const TYP_M2I3015                 = $00033015;
const TYP_M2I3016                 = $00033016;
const TYP_M2I3020                 = $00033020;
const TYP_M2I3021                 = $00033021;
const TYP_M2I3022                 = $00033022;
const TYP_M2I3023                 = $00033023;
const TYP_M2I3024                 = $00033024;
const TYP_M2I3025                 = $00033025;
const TYP_M2I3026                 = $00033026;
const TYP_M2I3027                 = $00033027;
const TYP_M2I3031                 = $00033031;
const TYP_M2I3033                 = $00033033;

const TYP_M2I3010EXP              = $00043010;
const TYP_M2I3011EXP              = $00043011;
const TYP_M2I3012EXP              = $00043012;
const TYP_M2I3013EXP              = $00043013;
const TYP_M2I3014EXP              = $00043014;
const TYP_M2I3015EXP              = $00043015;
const TYP_M2I3016EXP              = $00043016;
const TYP_M2I3020EXP              = $00043020;
const TYP_M2I3021EXP              = $00043021;
const TYP_M2I3022EXP              = $00043022;
const TYP_M2I3023EXP              = $00043023;
const TYP_M2I3024EXP              = $00043024;
const TYP_M2I3025EXP              = $00043025;
const TYP_M2I3026EXP              = $00043026;
const TYP_M2I3027EXP              = $00043027;
const TYP_M2I3031EXP              = $00043031;
const TYP_M2I3033EXP              = $00043033;

const TYP_MC3010                  = $00013010;
const TYP_MC3011                  = $00013011;
const TYP_MC3012                  = $00013012;
const TYP_MC3013                  = $00013013;
const TYP_MC3014                  = $00013014;
const TYP_MC3015                  = $00013015;
const TYP_MC3016                  = $00013016;
const TYP_MC3020                  = $00013020;
const TYP_MC3021                  = $00013021;
const TYP_MC3022                  = $00013022;
const TYP_MC3023                  = $00013023;
const TYP_MC3024                  = $00013024;
const TYP_MC3025                  = $00013025;
const TYP_MC3026                  = $00013026;
const TYP_MC3027                  = $00013027;
const TYP_MC3031                  = $00013031;
const TYP_MC3033                  = $00013033;

const TYP_MX3010                  = $00023010;
const TYP_MX3011                  = $00023011;
const TYP_MX3012                  = $00023012;
const TYP_MX3020                  = $00023020;
const TYP_MX3021                  = $00023021;
const TYP_MX3022                  = $00023022;
const TYP_MX3031                  = $00023031;



{ ----- MI.31xx, MC.31xx, MX.31xx ----- }
const TYP_MI3110                  = $00003110;
const TYP_MI3111                  = $00003111;
const TYP_MI3112                  = $00003112;
const TYP_MI3120                  = $00003120;
const TYP_MI3121                  = $00003121;
const TYP_MI3122                  = $00003122;
const TYP_MI3130                  = $00003130;
const TYP_MI3131                  = $00003131;
const TYP_MI3132                  = $00003132;
const TYP_MI3140                  = $00003140;

const TYP_M2I3110                 = $00033110;
const TYP_M2I3111                 = $00033111;
const TYP_M2I3112                 = $00033112;
const TYP_M2I3120                 = $00033120;
const TYP_M2I3121                 = $00033121;
const TYP_M2I3122                 = $00033122;
const TYP_M2I3130                 = $00033130;
const TYP_M2I3131                 = $00033131;
const TYP_M2I3132                 = $00033132;

const TYP_M2I3110EXP              = $00043110;
const TYP_M2I3111EXP              = $00043111;
const TYP_M2I3112EXP              = $00043112;
const TYP_M2I3120EXP              = $00043120;
const TYP_M2I3121EXP              = $00043121;
const TYP_M2I3122EXP              = $00043122;
const TYP_M2I3130EXP              = $00043130;
const TYP_M2I3131EXP              = $00043131;
const TYP_M2I3132EXP              = $00043132;

const TYP_MC3110                  = $00013110;
const TYP_MC3111                  = $00013111;
const TYP_MC3112                  = $00013112;
const TYP_MC3120                  = $00013120;
const TYP_MC3121                  = $00013121;
const TYP_MC3122                  = $00013122;
const TYP_MC3130                  = $00013130;
const TYP_MC3131                  = $00013131;
const TYP_MC3132                  = $00013132;

const TYP_MX3110                  = $00023110;
const TYP_MX3111                  = $00023111;
const TYP_MX3120                  = $00023120;
const TYP_MX3121                  = $00023121;
const TYP_MX3130                  = $00023130;
const TYP_MX3131                  = $00023131;



{ ----- M3i.32xx, M3i.32xx-Exp (12 bit A/D) ----- }
const TYP_M3I3220                 = $00053220;     { 1x250M }
const TYP_M3I3221                 = $00053221;     { 2x250M }
const TYP_M3I3240                 = $00053240;     { 1x500M }
const TYP_M3I3242                 = $00053242;     { 1x500M & 2x250M }

const TYP_M3I3220EXP              = $00063220;     { 1x250M }
const TYP_M3I3221EXP              = $00063221;     { 2x250M }
const TYP_M3I3240EXP              = $00063240;     { 1x500M }
const TYP_M3I3242EXP              = $00063242;     { 1x500M & 2x250M }



{ ----- MI.40xx, MC.40xx, MX.40xx ----- }
const TYP_MI4020                  = $00004020;
const TYP_MI4021                  = $00004021;
const TYP_MI4022                  = $00004022;
const TYP_MI4030                  = $00004030;
const TYP_MI4031                  = $00004031;
const TYP_MI4032                  = $00004032;

const TYP_M2I4020                 = $00034020;
const TYP_M2I4021                 = $00034021;
const TYP_M2I4022                 = $00034022;
const TYP_M2I4028                 = $00034028;
const TYP_M2I4030                 = $00034030;
const TYP_M2I4031                 = $00034031;
const TYP_M2I4032                 = $00034032;
const TYP_M2I4038                 = $00034038;

const TYP_M2I4020EXP              = $00044020;
const TYP_M2I4021EXP              = $00044021;
const TYP_M2I4022EXP              = $00044022;
const TYP_M2I4028EXP              = $00044028;
const TYP_M2I4030EXP              = $00044030;
const TYP_M2I4031EXP              = $00044031;
const TYP_M2I4032EXP              = $00044032;
const TYP_M2I4038EXP              = $00044038;

const TYP_MC4020                  = $00014020;
const TYP_MC4021                  = $00014021;
const TYP_MC4022                  = $00014022;
const TYP_MC4030                  = $00014030;
const TYP_MC4031                  = $00014031;
const TYP_MC4032                  = $00014032;

const TYP_MX4020                  = $00024020;
const TYP_MX4021                  = $00024021;
const TYP_MX4030                  = $00024030;
const TYP_MX4031                  = $00024031;



{ ----- M3i.41xx, M3i.41xx-Exp (14 bit A/D) ----- }
const TYP_M3I4110                 = $00054110;     { 1x100M }
const TYP_M3I4111                 = $00054111;     { 2x100M }
const TYP_M3I4120                 = $00054120;     { 1x250M }
const TYP_M3I4121                 = $00054121;     { 2x250M }
const TYP_M3I4140                 = $00054140;     { 1x400M }
const TYP_M3I4142                 = $00054142;     { 1x400M & 2x250M }

const TYP_M3I4110EXP              = $00064110;     { 1x100M }
const TYP_M3I4111EXP              = $00064111;     { 2x100M }
const TYP_M3I4120EXP              = $00064120;     { 1x250M }
const TYP_M3I4121EXP              = $00064121;     { 2x250M }
const TYP_M3I4140EXP              = $00064140;     { 1x400M }
const TYP_M3I4142EXP              = $00064142;     { 1x400M & 2x250M }

{ ----- M4i.44xx-x8 (generic) ----- }
const TYP_M4I44XX_X8              = $00074400;      {  }

const TYP_M4I4410_X8              = $00074410;      { 2x130M 16bit }
const TYP_M4I4411_X8              = $00074411;      { 4x130M 16bit }
const TYP_M4I4420_X8              = $00074420;      { 2x250M 16bit }
const TYP_M4I4421_X8              = $00074421;      { 4x250M 16bit }
const TYP_M4I4450_X8              = $00074450;      { 2x500M 14bit }
const TYP_M4I4451_X8              = $00074451;      { 4x500M 14bit }
const TYP_M4I4470_X8              = $00074470;      { 2x180M 16bit }
const TYP_M4I4471_X8              = $00074471;      { 4x180M 16bit }
const TYP_M4I4480_X8              = $00074480;      { 2x400M 14bit }
const TYP_M4I4481_X8              = $00074481;      { 4x400M 14bit }

{ ----- M4x.44xx-x4 (14/16 bit A/D) ----- }
const TYP_M4X44XX_X4              = $00084400;      { generic }
const TYP_M4X4410_X4              = $00084410;      { 2x130M 16bit }
const TYP_M4X4411_X4              = $00084411;      { 4x130M 16bit }
const TYP_M4X4420_X4              = $00084420;      { 2x250M 16bit }
const TYP_M4X4421_X4              = $00084421;      { 4x250M 16bit }
const TYP_M4X4450_X4              = $00084450;      { 2x500M 14bit }
const TYP_M4X4451_X4              = $00084451;      { 4x500M 14bit }
const TYP_M4X4470_X4              = $00084470;      { 2x180M 16bit }
const TYP_M4X4471_X4              = $00084471;      { 4x180M 16bit }
const TYP_M4X4480_X4              = $00084480;      { 2x400M 14bit }
const TYP_M4X4481_X4              = $00084481;      { 4x400M 14bit }


{ ----- MI.45xx, MC.45xx, MX.45xx ----- }
const TYP_MI4520                  = $00004520;
const TYP_MI4521                  = $00004521;
const TYP_MI4530                  = $00004530;
const TYP_MI4531                  = $00004531;
const TYP_MI4540                  = $00004540;
const TYP_MI4541                  = $00004541;

const TYP_M2I4520                 = $00034520;
const TYP_M2I4521                 = $00034521;
const TYP_M2I4530                 = $00034530;
const TYP_M2I4531                 = $00034531;
const TYP_M2I4540                 = $00034540;
const TYP_M2I4541                 = $00034541;

const TYP_MC4520                  = $00014520;
const TYP_MC4521                  = $00014521;
const TYP_MC4530                  = $00014530;
const TYP_MC4531                  = $00014531;
const TYP_MC4540                  = $00014540;
const TYP_MC4541                  = $00014541;

const TYP_MX4520                  = $00024520;
const TYP_MX4530                  = $00024530;
const TYP_MX4540                  = $00024540;



{ ----- MI.46xx, MC.46xx, MX.46xx ----- }
const TYP_MI4620                  = $00004620;
const TYP_MI4621                  = $00004621;
const TYP_MI4622                  = $00004622;
const TYP_MI4630                  = $00004630;
const TYP_MI4631                  = $00004631;
const TYP_MI4632                  = $00004632;
const TYP_MI4640                  = $00004640;
const TYP_MI4641                  = $00004641;
const TYP_MI4642                  = $00004642;
const TYP_MI4650                  = $00004650;
const TYP_MI4651                  = $00004651;
const TYP_MI4652                  = $00004652;

const TYP_M2I4620                 = $00034620;
const TYP_M2I4621                 = $00034621;
const TYP_M2I4622                 = $00034622;
const TYP_M2I4630                 = $00034630;
const TYP_M2I4631                 = $00034631;
const TYP_M2I4632                 = $00034632;
const TYP_M2I4640                 = $00034640;
const TYP_M2I4641                 = $00034641;
const TYP_M2I4642                 = $00034642;
const TYP_M2I4650                 = $00034650;
const TYP_M2I4651                 = $00034651;
const TYP_M2I4652                 = $00034652;

const TYP_M2I4620EXP              = $00044620;
const TYP_M2I4621EXP              = $00044621;
const TYP_M2I4622EXP              = $00044622;
const TYP_M2I4630EXP              = $00044630;
const TYP_M2I4631EXP              = $00044631;
const TYP_M2I4632EXP              = $00044632;
const TYP_M2I4640EXP              = $00044640;
const TYP_M2I4641EXP              = $00044641;
const TYP_M2I4642EXP              = $00044642;
const TYP_M2I4650EXP              = $00044650;
const TYP_M2I4651EXP              = $00044651;
const TYP_M2I4652EXP              = $00044652;

const TYP_MC4620                  = $00014620;
const TYP_MC4621                  = $00014621;
const TYP_MC4622                  = $00014622;
const TYP_MC4630                  = $00014630;
const TYP_MC4631                  = $00014631;
const TYP_MC4632                  = $00014632;
const TYP_MC4640                  = $00014640;
const TYP_MC4641                  = $00014641;
const TYP_MC4642                  = $00014642;
const TYP_MC4650                  = $00014650;
const TYP_MC4651                  = $00014651;
const TYP_MC4652                  = $00014652;

const TYP_MX4620                  = $00024620;
const TYP_MX4621                  = $00024621;
const TYP_MX4630                  = $00024630;
const TYP_MX4631                  = $00024631;
const TYP_MX4640                  = $00024640;
const TYP_MX4641                  = $00024641;
const TYP_MX4650                  = $00024650;
const TYP_MX4651                  = $00024651;



{ ----- MI.47xx, MC.47xx, MX.47xx ----- }
const TYP_MI4710                  = $00004710;
const TYP_MI4711                  = $00004711;
const TYP_MI4720                  = $00004720;
const TYP_MI4721                  = $00004721;
const TYP_MI4730                  = $00004730;
const TYP_MI4731                  = $00004731;
const TYP_MI4740                  = $00004740;
const TYP_MI4741                  = $00004741;

const TYP_M2I4710                 = $00034710;
const TYP_M2I4711                 = $00034711;
const TYP_M2I4720                 = $00034720;
const TYP_M2I4721                 = $00034721;
const TYP_M2I4730                 = $00034730;
const TYP_M2I4731                 = $00034731;
const TYP_M2I4740                 = $00034740;
const TYP_M2I4741                 = $00034741;

const TYP_M2I4710EXP              = $00044710;
const TYP_M2I4711EXP              = $00044711;
const TYP_M2I4720EXP              = $00044720;
const TYP_M2I4721EXP              = $00044721;
const TYP_M2I4730EXP              = $00044730;
const TYP_M2I4731EXP              = $00044731;
const TYP_M2I4740EXP              = $00044740;
const TYP_M2I4741EXP              = $00044741;

const TYP_MC4710                  = $00014710;
const TYP_MC4711                  = $00014711;
const TYP_MC4720                  = $00014720;
const TYP_MC4721                  = $00014721;
const TYP_MC4730                  = $00014730;
const TYP_MC4731                  = $00014731;

const TYP_MX4710                  = $00024710;
const TYP_MX4720                  = $00024720;
const TYP_MX4730                  = $00024730;



{ ----- M3i.48xx, M3i.48xx-Exp (16 bit A/D) ----- }
const TYP_M3I4830                 = $00054830;     
const TYP_M3I4831                 = $00054831;    
const TYP_M3I4840                 = $00054840;     
const TYP_M3I4841                 = $00054841;    
const TYP_M3I4860                 = $00054860;     
const TYP_M3I4861                 = $00054861;    

const TYP_M3I4830EXP              = $00064830;     
const TYP_M3I4831EXP              = $00064831;    
const TYP_M3I4840EXP              = $00064840;     
const TYP_M3I4841EXP              = $00064841;    
const TYP_M3I4860EXP              = $00064860;     
const TYP_M3I4861EXP              = $00064861;    



{ ----- MI.46xx, MC.46xx, MX.46xx ----- }
const TYP_MI4911                  = $00004911;
const TYP_MI4912                  = $00004912;
const TYP_MI4931                  = $00004931;
const TYP_MI4932                  = $00004932;
const TYP_MI4960                  = $00004960;
const TYP_MI4961                  = $00004961;
const TYP_MI4963                  = $00004963;
const TYP_MI4964                  = $00004964;

const TYP_MC4911                  = $00014911;
const TYP_MC4912                  = $00014912;
const TYP_MC4931                  = $00014931;
const TYP_MC4932                  = $00014932;
const TYP_MC4960                  = $00014960;
const TYP_MC4961                  = $00014961;
const TYP_MC4963                  = $00014963;
const TYP_MC4964                  = $00014964;

const TYP_MX4911                  = $00024911;
const TYP_MX4931                  = $00024931;
const TYP_MX4960                  = $00024960;
const TYP_MX4963                  = $00024963;

const TYP_M2I4911                 = $00034911;
const TYP_M2I4912                 = $00034912;
const TYP_M2I4931                 = $00034931;
const TYP_M2I4932                 = $00034932;
const TYP_M2I4960                 = $00034960;
const TYP_M2I4961                 = $00034961;
const TYP_M2I4963                 = $00034963;
const TYP_M2I4964                 = $00034964;

const TYP_M2I4911EXP              = $00044911;
const TYP_M2I4912EXP              = $00044912;
const TYP_M2I4931EXP              = $00044931;
const TYP_M2I4932EXP              = $00044932;
const TYP_M2I4960EXP              = $00044960;
const TYP_M2I4961EXP              = $00044961;
const TYP_M2I4963EXP              = $00044963;
const TYP_M2I4964EXP              = $00044964;

{ ----- M2p.59xx-x4 ----- }
const TYP_M2P59XX_X4              = $00095900;      { generic }
const TYP_M2P5911_X4              = $00095911;
const TYP_M2P5912_X4              = $00095912;
const TYP_M2P5913_X4              = $00095913;
const TYP_M2P5916_X4              = $00095916;
const TYP_M2P5920_X4              = $00095920;
const TYP_M2P5921_X4              = $00095921;
const TYP_M2P5922_X4              = $00095922;
const TYP_M2P5923_X4              = $00095923;
const TYP_M2P5926_X4              = $00095926;
const TYP_M2P5930_X4              = $00095930;
const TYP_M2P5931_X4              = $00095931;
const TYP_M2P5932_X4              = $00095932;
const TYP_M2P5933_X4              = $00095933;
const TYP_M2P5936_X4              = $00095936;
const TYP_M2P5940_X4              = $00095940;
const TYP_M2P5941_X4              = $00095941;
const TYP_M2P5942_X4              = $00095942;
const TYP_M2P5943_X4              = $00095943;
const TYP_M2P5946_X4              = $00095946;
const TYP_M2P5960_X4              = $00095960;
const TYP_M2P5961_X4              = $00095961;
const TYP_M2P5962_X4              = $00095962;
const TYP_M2P5966_X4              = $00095966;
const TYP_M2P5968_X4              = $00095968;


{ ----- MI.60xx, MC.60xx, MX.60xx ----- }
const TYP_MI6010                  = $00006010;
const TYP_MI6011                  = $00006011;
const TYP_MI6012                  = $00006012;
const TYP_MI6021                  = $00006021;
const TYP_MI6022                  = $00006022;
const TYP_MI6030                  = $00006030;
const TYP_MI6031                  = $00006031;
const TYP_MI6033                  = $00006033;
const TYP_MI6034                  = $00006034;

const TYP_M2I6010                 = $00036010;
const TYP_M2I6011                 = $00036011;
const TYP_M2I6012                 = $00036012;
const TYP_M2I6021                 = $00036021;
const TYP_M2I6022                 = $00036022;
const TYP_M2I6030                 = $00036030;
const TYP_M2I6031                 = $00036031;
const TYP_M2I6033                 = $00036033;
const TYP_M2I6034                 = $00036034;

const TYP_M2I6010EXP              = $00046010;
const TYP_M2I6011EXP              = $00046011;
const TYP_M2I6012EXP              = $00046012;
const TYP_M2I6021EXP              = $00046021;
const TYP_M2I6022EXP              = $00046022;
const TYP_M2I6030EXP              = $00046030;
const TYP_M2I6031EXP              = $00046031;
const TYP_M2I6033EXP              = $00046033;
const TYP_M2I6034EXP              = $00046034;

const TYP_MC6010                  = $00016010;
const TYP_MC6011                  = $00016011;
const TYP_MC6012                  = $00016012;
const TYP_MC6021                  = $00016021;
const TYP_MC6022                  = $00016022;
const TYP_MC6030                  = $00016030;
const TYP_MC6031                  = $00016031;
const TYP_MC6033                  = $00016033;
const TYP_MC6034                  = $00016034;

const TYP_MX6010                  = $00026010;
const TYP_MX6011                  = $00026011;
const TYP_MX6021                  = $00026021;
const TYP_MX6030                  = $00026030;
const TYP_MX6033                  = $00026033;



{ ----- MI.61xx, MC.61xx, MX.61xx ----- }
const TYP_MI6105                  = $00006105;
const TYP_MI6110                  = $00006110;
const TYP_MI6111                  = $00006111;

const TYP_M2I6105                 = $00036105;
const TYP_M2I6110                 = $00036110;
const TYP_M2I6111                 = $00036111;

const TYP_M2I6105EXP              = $00046105;
const TYP_M2I6110EXP              = $00046110;
const TYP_M2I6111EXP              = $00046111;

const TYP_MC6110                  = $00016110;
const TYP_MC6111                  = $00016111;

const TYP_MX6110                  = $00026110;

{ ----- M2p.65xx-x4 ----- }
const TYP_M2P65XX_X4              = $00096500;      { generic }
const TYP_M2P6522_X4              = $00096522;      { 4 ch @   40 MS/s (1x4) (low voltage) }
const TYP_M2P6523_X4              = $00096523;      { 8 ch @   40 MS/s (low voltage) }
const TYP_M2P6530_X4              = $00096530;      { 1 ch @   40 MS/s }
const TYP_M2P6531_X4              = $00096531;      { 2 ch @   40 MS/s }
const TYP_M2P6532_X4              = $00096532;      { 4 ch @   40 MS/s (1x4) }
const TYP_M2P6536_X4              = $00096536;      { 4 ch @   40 MS/s (2x2) }
const TYP_M2P6533_X4              = $00096533;      { 8 ch @   40 MS/s }
const TYP_M2P6540_X4              = $00096540;      { 1 ch @   40 MS/s (high voltage) }
const TYP_M2P6541_X4              = $00096541;      { 2 ch @   40 MS/s (high voltage) }
const TYP_M2P6546_X4              = $00096546;      { 4 ch @   40 MS/s (2x2) (high voltage) }
const TYP_M2P6560_X4              = $00096560;      { 1 ch @  125 MS/s }
const TYP_M2P6561_X4              = $00096561;      { 2 ch @  125 MS/s }
const TYP_M2P6562_X4              = $00096562;      { 4 ch @  125 MS/s (1x4) }
const TYP_M2P6566_X4              = $00096566;      { 4 ch @  125 MS/s (2x2) }
const TYP_M2P6568_X4              = $00096568;      { 8 ch @  125/80 MS/s }
const TYP_M2P6570_X4              = $00096570;      { 1 ch @  125 MS/s (high voltage) }
const TYP_M2P6571_X4              = $00096571;      { 2 ch @  125 MS/s (high voltage) }
const TYP_M2P6576_X4              = $00096576;      { 4 ch @  125 MS/s (2x2) (high voltage) }

{ ----- M4i.66xx-x8 (16 bit D/A) ----- }
{ ----- M4i.66xx-x8 (generic) ----- }
const TYP_M4I66XX_X8              = $00076600;

const TYP_M4I6620_X8              = $00076620;      { 1 ch @  625 MS/s }
const TYP_M4I6621_X8              = $00076621;      { 2 ch @  625 MS/s }
const TYP_M4I6622_X8              = $00076622;      { 4 ch @  625 MS/s }
const TYP_M4I6630_X8              = $00076630;      { 1 ch @ 1250 MS/s }
const TYP_M4I6631_X8              = $00076631;      { 2 ch @ 1250 MS/s }

{ ----- M4x.66xx-x8 (16 bit D/A) ----- }
{ ----- M4x.66xx-x8 (generic) ----- }
const TYP_M4X66XX_X4              = $00086600;

const TYP_M4X6620_X4              = $00086620;      { 1 ch @  625 MS/s }
const TYP_M4X6621_X4              = $00086621;      { 2 ch @  625 MS/s }
const TYP_M4X6622_X4              = $00086622;      { 4 ch @  625 MS/s }
const TYP_M4X6630_X4              = $00086630;      { 1 ch @ 1250 MS/s }
const TYP_M4X6631_X4              = $00086631;      { 2 ch @ 1250 MS/s }

{ ----- MI.70xx, MC.70xx, MX.70xx ----- }
const TYP_MI7005                  = $00007005;
const TYP_MI7010                  = $00007010;
const TYP_MI7011                  = $00007011;
const TYP_MI7020                  = $00007020;
const TYP_MI7021                  = $00007021;

const TYP_M2I7005                 = $00037005;
const TYP_M2I7010                 = $00037010;
const TYP_M2I7011                 = $00037011;
const TYP_M2I7020                 = $00037020;
const TYP_M2I7021                 = $00037021;

const TYP_M2I7005EXP              = $00047005;
const TYP_M2I7010EXP              = $00047010;
const TYP_M2I7011EXP              = $00047011;
const TYP_M2I7020EXP              = $00047020;
const TYP_M2I7021EXP              = $00047021;

const TYP_MC7005                  = $00017005;
const TYP_MC7010                  = $00017010;
const TYP_MC7011                  = $00017011;
const TYP_MC7020                  = $00017020;
const TYP_MC7021                  = $00017021;

const TYP_MX7005                  = $00027005;
const TYP_MX7010                  = $00027010;
const TYP_MX7011                  = $00027011;



{ ----- MI.72xx, MC.72xx, MX.72xx ----- }
const TYP_MI7210                  = $00007210;
const TYP_MI7211                  = $00007211;
const TYP_MI7220                  = $00007220;
const TYP_MI7221                  = $00007221;

const TYP_M2I7210                 = $00037210;
const TYP_M2I7211                 = $00037211;
const TYP_M2I7220                 = $00037220;
const TYP_M2I7221                 = $00037221;

const TYP_M2I7210EXP              = $00047210;
const TYP_M2I7211EXP              = $00047211;
const TYP_M2I7220EXP              = $00047220;
const TYP_M2I7221EXP              = $00047221;

const TYP_MC7210                  = $00017210;
const TYP_MC7211                  = $00017211;
const TYP_MC7220                  = $00017220;
const TYP_MC7221                  = $00017221;

const TYP_MX7210                  = $00027210;
const TYP_MX7220                  = $00027220;

{ ----- M2p.75xx-x4 ----- }
const TYP_M2P75XX_X4              = $00097500;      { generic }
const TYP_M2P7515_X4              = $00097515;

{ ----- M4i.77xx-x8  ----- }
const TYP_M4I77XX_X8              = $00077700; { generic }
const TYP_M4I7710_X8              = $00077710; { single-ended }
const TYP_M4I7720_X8              = $00077720; { single-ended }
const TYP_M4I7730_X8              = $00077730; { single-ended }
const TYP_M4I7725_X8              = $00077725; { differential }
const TYP_M4I7735_X8              = $00077735; { differential }

{ ----- M4x.77xx-x8  ----- }
const TYP_M4X77XX_X4              = $00087700; { generic }
const TYP_M4X7710_X4              = $00087710; { single-ended }
const TYP_M4X7720_X4              = $00087720; { single-ended }
const TYP_M4X7730_X4              = $00087730; { single-ended }
const TYP_M4X7725_X4              = $00087725; { differential }
const TYP_M4X7735_X4              = $00087735; { differential }

{ ----- MX.90xx ----- }
const TYP_MX9010                  = $00029010;



{ *********************************************************************** }
{ software registers }
{ *********************************************************************** }


{ ***** PCI Features Bits (MI/MC/MX and prior cards) ********* }
const PCIBIT_MULTI                = $00000001;
const PCIBIT_DIGITAL              = $00000002;
const PCIBIT_CH0DIGI              = $00000004;
const PCIBIT_EXTSAM               = $00000008;
const PCIBIT_3CHANNEL             = $00000010;
const PCIBIT_GATE                 = $00000020;
const PCIBIT_SLAVE                = $00000040;
const PCIBIT_MASTER               = $00000080;
const PCIBIT_DOUBLEMEM            = $00000100;
const PCIBIT_SYNC                 = $00000200;
const PCIBIT_TIMESTAMP            = $00000400;
const PCIBIT_STARHUB              = $00000800;
const PCIBIT_CA                   = $00001000;
const PCIBIT_XIO                  = $00002000;
const PCIBIT_AMPLIFIER            = $00004000;
const PCIBIT_DIFFMODE             = $00008000;

const PCIBIT_ELISA                = $10000000;


{ ***** PCI features starting with M2i card series ***** }
const SPCM_FEAT_MULTI             = $00000001;      { multiple recording }
const SPCM_FEAT_GATE              = $00000002;      { gated sampling }
const SPCM_FEAT_DIGITAL           = $00000004;      { additional synchronous digital inputs or outputs }
const SPCM_FEAT_TIMESTAMP         = $00000008;      { timestamp }
const SPCM_FEAT_STARHUB5          = $00000020;      { starhub for  5 cards installed (M2i + M2i-Exp) }
const SPCM_FEAT_STARHUB4          = $00000020;      { starhub for  4 cards installed (M3i + M3i-Exp) }
const SPCM_FEAT_STARHUB6_EXTM     = $00000020;      { starhub for  6 cards installed as card extension or piggy back (M2p) }
const SPCM_FEAT_STARHUB8_EXTM     = $00000020;      { starhub for  8 cards installed as card extension or piggy back (M4i-Exp) }
const SPCM_FEAT_STARHUB16         = $00000040;      { starhub for 16 cards installed (M2i, M2i-exp) }
const SPCM_FEAT_STARHUB16_EXTM    = $00000040;      { starhub for 16 cards installed as card extension or piggy back (M2p) }
const SPCM_FEAT_STARHUB8          = $00000040;      { starhub for  8 cards installed (M3i + M3i-Exp) }
const SPCM_FEAT_STARHUBXX_MASK    = $00000060;      { mask to detect one of the above installed starhub }
const SPCM_FEAT_ABA               = $00000080;      { ABA mode installed }
const SPCM_FEAT_BASEXIO           = $00000100;      { extra I/O on base card installed }
const SPCM_FEAT_AMPLIFIER_10V     = $00000200;      { external amplifier for 60/61 }
const SPCM_FEAT_STARHUBSYSMASTER  = $00000400;      { system starhub master installed }
const SPCM_FEAT_DIFFMODE          = $00000800;      { Differential mode installed }
const SPCM_FEAT_SEQUENCE          = $00001000;      { Sequence programming mode for generator cards }
const SPCM_FEAT_AMPMODULE_10V     = $00002000;      { amplifier module for 60/61 }
const SPCM_FEAT_STARHUBSYSSLAVE   = $00004000;      { system starhub slave installed }
const SPCM_FEAT_NETBOX            = $00008000;      { card is part of netbox }
const SPCM_FEAT_REMOTESERVER      = $00010000;      { remote server can be used with this card }
const SPCM_FEAT_SCAPP             = $00020000;      { SCAPP option (CUDA RDMA) }
const SPCM_FEAT_DIG16_SMB         = $00040000;      { M2p: 16 additional digital inputs or outputs (via SMB connectors)  }
const SPCM_FEAT_DIG8_SMA          = $00040000;      { M4i:  8 additional digital inputs or 6 additional outputs (via SMA connectors)  }
const SPCM_FEAT_DIG16_FX2         = $00080000;      { M2p: 16 additional digital inputs or outputs (via FX2 connector) }
const SPCM_FEAT_DIGITALBWFILTER   = $00100000;      { Digital BW filter is available }
const SPCM_FEAT_CUSTOMMOD_MASK    = $F0000000;      { mask for custom modification code, meaning of code depends on type and customer }


{ ***** Extended Features starting with M4i ***** }
const SPCM_FEAT_EXTFW_SEGSTAT     = $00000001;        { segment (Multiple Recording, ABA) statistics like average, min/max }
const SPCM_FEAT_EXTFW_SEGAVERAGE  = $00000002;        { average of multiple segments (Multiple Recording, ABA)  }
const SPCM_FEAT_EXTFW_BOXCAR      = $00000004;      { boxcar averaging (high-res mode) }


{ ***** Error Request ************* }
const ERRORTEXTLEN                = 200;
const SPC_LASTERRORTEXT           = 999996;
const SPC_LASTERRORVALUE          = 999997;
const SPC_LASTERRORREG            = 999998;
const SPC_LASTERRORCODE           = 999999;     { Reading this reset the internal error-memory. }

{ ***** constants to use with the various _ACDC registers ***** }
const COUPLING_DC = 0;
const COUPLING_AC = 1;


{ ***** Register and Command Structure }
const SPC_COMMAND                 = 0;
const     SPC_RESET               = 0;
const     SPC_SOFTRESET           = 1;
const     SPC_WRITESETUP          = 2;
const     SPC_START               = 10;
const     SPC_STARTANDWAIT        = 11;
const     SPC_FIFOSTART           = 12;
const     SPC_FIFOWAIT            = 13;
const     SPC_FIFOSTARTNOWAIT     = 14;
const     SPC_FORCETRIGGER        = 16;
const     SPC_STOP                = 20;
const     SPC_FLUSHFIFOBUFFER     = 21;
const     SPC_POWERDOWN           = 30;
const     SPC_SYNCMASTER          = 100;
const     SPC_SYNCTRIGGERMASTER   = 101;
const     SPC_SYNCMASTERFIFO      = 102;
const     SPC_SYNCSLAVE           = 110;
const     SPC_SYNCTRIGGERSLAVE    = 111;
const     SPC_SYNCSLAVEFIFO       = 112;
const     SPC_NOSYNC              = 120;
const     SPC_SYNCSTART           = 130;
const     SPC_SYNCCALCMASTER      = 140;
const     SPC_SYNCCALCMASTERFIFO  = 141;
const     SPC_PXIDIVIDERRESET     = 150;
const     SPC_RELAISON            = 200;
const     SPC_RELAISOFF           = 210;
const     SPC_ADJUSTSTART         = 300;
const     SPC_FIFO_BUFREADY0      = 400;
const     SPC_FIFO_BUFREADY1      = 401;
const     SPC_FIFO_BUFREADY2      = 402;
const     SPC_FIFO_BUFREADY3      = 403;
const     SPC_FIFO_BUFREADY4      = 404;
const     SPC_FIFO_BUFREADY5      = 405;
const     SPC_FIFO_BUFREADY6      = 406;
const     SPC_FIFO_BUFREADY7      = 407;
const     SPC_FIFO_BUFREADY8      = 408;
const     SPC_FIFO_BUFREADY9      = 409;
const     SPC_FIFO_BUFREADY10     = 410;
const     SPC_FIFO_BUFREADY11     = 411;
const     SPC_FIFO_BUFREADY12     = 412;
const     SPC_FIFO_BUFREADY13     = 413;
const     SPC_FIFO_BUFREADY14     = 414;
const     SPC_FIFO_BUFREADY15     = 415;
const     SPC_FIFO_AUTOBUFSTART   = 500;
const     SPC_FIFO_AUTOBUFEND     = 510;

const SPC_STATUS                  = 10;
const     SPC_RUN                 = 0;
const     SPC_TRIGGER             = 10;
const     SPC_READY               = 20;



{ commands for M2 cards }
const SPC_M2CMD                   = 100;                { write a command }
const     M2CMD_CARD_RESET            = $00000001;     { hardware reset    }
const     M2CMD_CARD_WRITESETUP       = $00000002;     { write setup only }
const     M2CMD_CARD_START            = $00000004;     { start of card (including writesetup) }
const     M2CMD_CARD_ENABLETRIGGER    = $00000008;     { enable trigger engine }
const     M2CMD_CARD_FORCETRIGGER     = $00000010;     { force trigger }
const     M2CMD_CARD_DISABLETRIGGER   = $00000020;     { disable trigger engine again (multi or gate) }
const     M2CMD_CARD_STOP             = $00000040;     { stop run }
const     M2CMD_CARD_FLUSHFIFO        = $00000080;     { flush fifos to memory }
const     M2CMD_CARD_INVALIDATEDATA   = $00000100;     { current data in memory is invalidated, next data transfer start will wait until new data is available }
const     M2CMD_CARD_INTERNALRESET    = $00000200;     { INTERNAL reset command }

const     M2CMD_ALL_STOP              = $00440060;     { stops card and all running transfers }

const     M2CMD_CARD_WAITPREFULL      = $00001000;     { wait until pretrigger is full }
const     M2CMD_CARD_WAITTRIGGER      = $00002000;     { wait for trigger recognition }
const     M2CMD_CARD_WAITREADY        = $00004000;     { wait for card ready }

const     M2CMD_DATA_STARTDMA         = $00010000;     { start of DMA transfer for data }
const     M2CMD_DATA_WAITDMA          = $00020000;     { wait for end of data transfer / next block ready }
const     M2CMD_DATA_STOPDMA          = $00040000;     { abort the data transfer }
const     M2CMD_DATA_POLL             = $00080000;     { transfer data using single access and polling }

const     M2CMD_EXTRA_STARTDMA        = $00100000;     { start of DMA transfer for extra (ABA + timestamp) data }
const     M2CMD_EXTRA_WAITDMA         = $00200000;     { wait for end of extra (ABA + timestamp) data transfer / next block ready }
const     M2CMD_EXTRA_STOPDMA         = $00400000;     { abort the extra (ABA + timestamp) data transfer }
const     M2CMD_EXTRA_POLL            = $00800000;     { transfer data using single access and polling }

const     M2CMD_DATA_SGFLUSH          = $01000000;     { flush incomplete pages from sg list }


{ status for M2 cards (bitmask) }
const SPC_M2STATUS                = 110;                { read the current status }
const     M2STAT_NONE                 = $00000000;     { status empty }
const     M2STAT_CARD_PRETRIGGER      = $00000001;     { pretrigger area is full }
const     M2STAT_CARD_TRIGGER         = $00000002;     { trigger recognized }
const     M2STAT_CARD_READY           = $00000004;     { card is ready, run finished }
const     M2STAT_CARD_SEGMENT_PRETRG  = $00000008;     { since M4i: at muliple-recording: pretrigger area of a segment is full }

const     M2STAT_DATA_BLOCKREADY      = $00000100;     { next data block is available }
const     M2STAT_DATA_END             = $00000200;     { data transfer has ended }
const     M2STAT_DATA_OVERRUN         = $00000400;     { FIFO overrun (record) or underrun (replay) }
const     M2STAT_DATA_ERROR           = $00000800;     { internal error }

const     M2STAT_EXTRA_BLOCKREADY     = $00001000;     { next extra data (ABA and timestamp) block is available }
const     M2STAT_EXTRA_END            = $00002000;     { extra data (ABA and timestamp) transfer has ended }
const     M2STAT_EXTRA_OVERRUN        = $00004000;     { FIFO overrun }
const     M2STAT_EXTRA_ERROR          = $00008000;     { internal error }

const     M2STAT_TSCNT_OVERRUN        = $00010000;     { timestamp counter overrun }

const     M2STAT_INTERNALMASK         = $ff000000;     { mask for internal status signals }
const     M2STAT_INTERNAL_SYSLOCK     = $02000000;



{ buffer control registers for samples data }
const SPC_DATA_AVAIL_USER_LEN     = 200;                { number of bytes available for user (valid data if READ, free buffer if WRITE) }
const SPC_DATA_AVAIL_USER_POS     = 201;                { the current byte position where the available user data starts }
const SPC_DATA_AVAIL_CARD_LEN     = 202;                { number of bytes available for card (free buffer if READ, filled data if WRITE) }
const SPC_DATA_OUTBUFSIZE         = 209;                { output buffer size in bytes }

{ buffer control registers for extra data (ABA slow data, timestamps) }
const SPC_ABA_AVAIL_USER_LEN      = 210;                { number of bytes available for user (valid data if READ, free buffer if WRITE) }
const SPC_ABA_AVAIL_USER_POS      = 211;                { the current byte position where the available user data starts }
const SPC_ABA_AVAIL_CARD_LEN      = 212;                { number of bytes available for card (free buffer if READ, filled data if WRITE) }

const SPC_TS_AVAIL_USER_LEN       = 220;                { number of bytes available for user (valid data if READ, free buffer if WRITE) }
const SPC_TS_AVAIL_USER_POS       = 221;                { the current byte position where the available user data starts }
const SPC_TS_AVAIL_CARD_LEN       = 222;                { number of bytes available for card (free buffer if READ, filled data if WRITE) }



{ Installation }
const SPC_VERSION                 = 1000;
const SPC_ISAADR                  = 1010;
const SPC_INSTMEM                 = 1020;
const SPC_INSTSAMPLERATE          = 1030;
const SPC_BRDTYP                  = 1040;

{ MI/MC/MX type information (internal use) }
const SPC_MIINST_MODULES          = 1100;
const SPC_MIINST_CHPERMODULE      = 1110;
const SPC_MIINST_BYTESPERSAMPLE   = 1120;
const SPC_MIINST_BITSPERSAMPLE    = 1125;
const SPC_MIINST_MAXADCVALUE      = 1126;
const SPC_MIINST_MINADCLOCK       = 1130;
const SPC_MIINST_MAXADCLOCK       = 1140;
const SPC_MIINST_MINEXTCLOCK      = 1145;
const SPC_MIINST_MAXEXTCLOCK      = 1146;
const SPC_MIINST_MINSYNCCLOCK     = 1147;
const SPC_MIINST_MINEXTREFCLOCK   = 1148;
const SPC_MIINST_MAXEXTREFCLOCK   = 1149;
const SPC_MIINST_QUARZ            = 1150;
const SPC_MIINST_QUARZ2           = 1151;
const SPC_MIINST_MINEXTCLOCK1     = 1152;
const SPC_MIINST_FLAGS            = 1160;
const SPC_MIINST_FIFOSUPPORT      = 1170;
const SPC_MIINST_ISDEMOCARD       = 1175;

{ Driver information }
const SPC_GETDRVVERSION           = 1200;
const SPC_GETKERNELVERSION        = 1210;
const SPC_GETDRVTYPE              = 1220;
const     DRVTYP_DOS              = 0;
const     DRVTYP_LINUX32          = 1;
const     DRVTYP_VXD              = 2;
const     DRVTYP_NTLEGACY         = 3;
const     DRVTYP_WDM32            = 4;
const     DRVTYP_WDM64            = 5;
const     DRVTYP_WOW64            = 6;
const     DRVTYP_LINUX64          = 7;
const     DRVTYP_QNX32            = 8;
const     DRVTYP_QNX64            = 9;
const SPC_GETCOMPATIBILITYVERSION = 1230;
const SPC_GETMINDRVVERSION        = 1240;

{ PCI, CompactPCI and PXI Installation Information }
const SPC_PCITYP                  = 2000;

{ ***** available card function types ***** }
const SPC_FNCTYPE                 = 2001;
const     SPCM_TYPE_AI            = $01;
const     SPCM_TYPE_AO            = $02;
const     SPCM_TYPE_DI            = $04;
const     SPCM_TYPE_DO            = $08;
const     SPCM_TYPE_DIO           = $10;

const SPC_PCIVERSION              = 2010;
const SPC_PCIEXTVERSION           = 2011;
const SPC_PCIMODULEVERSION        = 2012;
const SPC_PCIMODULEBVERSION       = 2013;
const SPC_BASEPCBVERSION          = 2014;
const SPC_MODULEPCBVERSION        = 2015;
const SPC_MODULEAPCBVERSION       = 2015;
const SPC_MODULEBPCBVERSION       = 2016;
const SPC_EXTPCBVERSION           = 2017;
const SPC_PCIDIGVERSION           = 2018;
const SPC_DIGPCBVERSION           = 2019;
const SPC_PCIDATE                 = 2020;
const SPC_CALIBDATE               = 2025;
const SPC_CALIBDATEONBOARD        = 2026;
const SPC_PCISERIALNR             = 2030;
const SPC_PCISERIALNO             = 2030;
const SPC_PCIHWBUSNO              = 2040;
const SPC_PCIHWDEVNO              = 2041;
const SPC_PCIHWFNCNO              = 2042;
const SPC_PCIHWSLOTNO             = 2043;
const SPC_PCIEXPGENERATION        = 2050;
const SPC_PCIEXPLANES             = 2051;
const SPC_PCIEXPPAYLOAD           = 2052;
const SPC_PCIEXPREADREQUESTSIZE   = 2053;
const SPC_PCIEXPREADCOMPLBOUNDARY = 2054;
const SPC_PXIHWSLOTNO             = 2055;
const SPC_PCISAMPLERATE           = 2100;
const SPC_PCIMEMSIZE              = 2110;
const SPC_PCIFEATURES             = 2120;
const SPC_PCIEXTFEATURES          = 2121;
const SPC_PCIINFOADR              = 2200;
const SPC_PCIINTERRUPT            = 2300;
const SPC_PCIBASEADR0             = 2400;
const SPC_PCIBASEADR1             = 2401;
const SPC_PCIREGION0              = 2410;
const SPC_PCIREGION1              = 2411;
const SPC_READTRGLVLCOUNT         = 2500;
const SPC_READIRCOUNT             = 3000;
const SPC_READUNIPOLAR0           = 3010;
const SPC_READUNIPOLAR1           = 3020;
const SPC_READUNIPOLAR2           = 3030;
const SPC_READUNIPOLAR3           = 3040;
const SPC_READMAXOFFSET           = 3100;

const SPC_READAIFEATURES          = 3101;
const     SPCM_AI_TERM            = $00000001;  { input termination available }
const     SPCM_AI_SE              = $00000002;  { single-ended mode available }
const     SPCM_AI_DIFF            = $00000004;  { differential mode available }
const     SPCM_AI_OFFSPERCENT     = $00000008;  { offset programming is done in percent of input range }
const     SPCM_AI_OFFSMV          = $00000010;  { offset programming is done in mV absolut }
const     SPCM_AI_OVERRANGEDETECT = $00000020;  { overrange detection is programmable }
const     SPCM_AI_DCCOUPLING      = $00000040;  { DC coupling available }
const     SPCM_AI_ACCOUPLING      = $00000080;  { AC coupling available }
const     SPCM_AI_LOWPASS         = $00000100;  { selectable low pass }
const     SPCM_AI_ACDC_OFFS_COMP  = $00000200;  { AC/DC offset compensation }
const     SPCM_AI_DIFFMUX         = $00000400;  { differential mode (two channels combined to one) available }
const     SPCM_AI_GLOBALLOWPASS   = $00000800;  { globally selectable low pass (all channels same setting) }
const     SPCM_AI_AUTOCALOFFS     = $00001000;  { automatic offset calibration in hardware }
const     SPCM_AI_AUTOCALGAIN     = $00002000;  { automatic gain calibration in hardware }
const     SPCM_AI_AUTOCALOFFSNOIN = $00004000;  { automatic offset calibration with open inputs }
const     SPCM_AI_HIGHIMP         = $00008000;  { high impedance available }
const     SPCM_AI_LOWIMP          = $00010000;  { low impedance available (50 ohm) }
const     SPCM_AI_DIGITALLOWPASS  = $00020000;  { selectable digital low pass filter }
const     SPCM_AI_INDIVPULSEWIDTH = $00100000;  { individual pulsewidth per channel available }

const SPC_READAOFEATURES          = 3102;
const     SPCM_AO_SE              = $00000002;  { single-ended mode available }
const     SPCM_AO_DIFF            = $00000004;  { differential mode available }
const     SPCM_AO_PROGFILTER      = $00000008;  { programmable filters available }
const     SPCM_AO_PROGOFFSET      = $00000010;  { programmable offset available }
const     SPCM_AO_PROGGAIN        = $00000020;  { programmable gain available }
const     SPCM_AO_PROGSTOPLEVEL   = $00000040;  { programmable stop level available }
const     SPCM_AO_DOUBLEOUT       = $00000080;  { double out mode available }
const     SPCM_AO_ENABLEOUT       = $00000100;  { outputs can be disabled/enabled }

const SPC_READDIFEATURES          = 3103;
const     SPCM_DI_TERM            = $00000001;  { input termination available }
const     SPCM_DI_SE              = $00000002;  { single-ended mode available }
const     SPCM_DI_DIFF            = $00000004;  { differential mode available }
const     SPCM_DI_PROGTHRESHOLD   = $00000008;  { programmable threshold available }
const     SPCM_DI_HIGHIMP         = $00000010;  { high impedance available }
const     SPCM_DI_LOWIMP          = $00000020;  { low impedance available }
const     SPCM_DI_INDIVPULSEWIDTH = $00100000;  { individual pulsewidth per channel available }
const     SPCM_DI_IOCHANNEL       = $00200000;  { connected with DO channel }

const SPC_READDOFEATURES          = 3104;
const     SPCM_DO_SE              = $00000002;  { single-ended mode available }
const     SPCM_DO_DIFF            = $00000004;  { differential mode available }
const     SPCM_DO_PROGSTOPLEVEL   = $00000008;  { programmable stop level available }
const     SPCM_DO_PROGOUTLEVELS   = $00000010;  { programmable output levels (low + high) available }
const     SPCM_DO_ENABLEMASK      = $00000020;  { individual enable mask for each output channel }
const     SPCM_DO_IOCHANNEL       = $00200000;  { connected with DI channel }

const SPC_READCHGROUPING          = 3110;
const SPC_READAIPATHCOUNT         = 3120;       { number of available analog input paths }
const SPC_READAIPATH              = 3121;       { the current path for which all the settings are read }

const SPCM_CUSTOMMOD              = 3130;
const     SPCM_CUSTOMMOD_BASE_MASK    = $000000FF;
const     SPCM_CUSTOMMOD_MODULE_MASK  = $0000FF00;
const     SPCM_CUSTOMMOD_STARHUB_MASK = $00FF0000;

const SPC_READRANGECH0_0          = 3200;
const SPC_READRANGECH0_1          = 3201;
const SPC_READRANGECH0_2          = 3202;
const SPC_READRANGECH0_3          = 3203;
const SPC_READRANGECH0_4          = 3204;
const SPC_READRANGECH0_5          = 3205;
const SPC_READRANGECH0_6          = 3206;
const SPC_READRANGECH0_7          = 3207;
const SPC_READRANGECH0_8          = 3208;
const SPC_READRANGECH0_9          = 3209;
const SPC_READRANGECH1_0          = 3300;
const SPC_READRANGECH1_1          = 3301;
const SPC_READRANGECH1_2          = 3302;
const SPC_READRANGECH1_3          = 3303;
const SPC_READRANGECH1_4          = 3304;
const SPC_READRANGECH1_5          = 3305;
const SPC_READRANGECH1_6          = 3306;
const SPC_READRANGECH1_7          = 3307;
const SPC_READRANGECH1_8          = 3308;
const SPC_READRANGECH1_9          = 3309;
const SPC_READRANGECH2_0          = 3400;
const SPC_READRANGECH2_1          = 3401;
const SPC_READRANGECH2_2          = 3402;
const SPC_READRANGECH2_3          = 3403;
const SPC_READRANGECH3_0          = 3500;
const SPC_READRANGECH3_1          = 3501;
const SPC_READRANGECH3_2          = 3502;
const SPC_READRANGECH3_3          = 3503;

const SPC_READRANGEMIN0           = 4000;
const SPC_READRANGEMIN99          = 4099;
const SPC_READRANGEMAX0           = 4100;
const SPC_READRANGEMAX99          = 4199;
const SPC_READOFFSMIN0            = 4200;
const SPC_READOFFSMIN99           = 4299;
const SPC_READOFFSMAX0            = 4300;
const SPC_READOFFSMAX99           = 4399;
const SPC_PCICOUNTER              = 9000;
const SPC_BUFFERPOS               = 9010;

const SPC_READAOGAINMIN           = 9100;
const SPC_READAOGAINMAX           = 9110;
const SPC_READAOOFFSETMIN         = 9120;
const SPC_READAOOFFSETMAX         = 9130;

const SPC_CARDMODE                = 9500;       { card modes as listed below }
const SPC_AVAILCARDMODES          = 9501;       { list with available card modes }

{ card modes }
const     SPC_REC_STD_SINGLE          = $00000001;  { singleshot recording to memory }
const     SPC_REC_STD_MULTI           = $00000002;  { multiple records to memory on each trigger event }
const     SPC_REC_STD_GATE            = $00000004;  { gated recording to memory on gate signal }
const     SPC_REC_STD_ABA             = $00000008;  { ABA: A slowly to extra FIFO, B to memory on each trigger event  }
const     SPC_REC_STD_SEGSTATS        = $00010000;  { segment information stored on each trigger segment -> stored in on-board memory }
const     SPC_REC_STD_AVERAGE         = $00020000;  { multiple records summed to average memory on each trigger event -> stored in on-board memory }
const     SPC_REC_STD_AVERAGE_16BIT   = $00080000;  { multiple records summed to average memory on each trigger event -> stored in on-board memory }
const     SPC_REC_STD_BOXCAR          = $00800000;  { boxcar averaging }

const     SPC_REC_FIFO_SINGLE         = $00000010;  { singleshot to FIFO on trigger event }
const     SPC_REC_FIFO_MULTI          = $00000020;  { multiple records to FIFO on each trigger event }
const     SPC_REC_FIFO_GATE           = $00000040;  { gated sampling to FIFO on gate signal }
const     SPC_REC_FIFO_ABA            = $00000080;  { ABA: A slowly to extra FIFO, B to FIFO on each trigger event }
const     SPC_REC_FIFO_SEGSTATS       = $00100000;  { segment information stored on each trigger segment -> streamed to host }
const     SPC_REC_FIFO_AVERAGE        = $00200000;  { multiple records summed to average memory on each trigger event -> streamed to host }
const     SPC_REC_FIFO_AVERAGE_16BIT  = $00400000;  { multiple records summed to average memory on each trigger event -> streamed to host }
const     SPC_REC_FIFO_BOXCAR         = $01000000;  { boxcar averaging FIFO mode }
const     SPC_REC_FIFO_SINGLE_MONITOR = $02000000;  { like SPC_REC_FIFO_SINGLE but with additional slow A data stream for monitoring }

const     SPC_REP_STD_SINGLE          = $00000100;  { single replay from memory on trigger event  }
const     SPC_REP_STD_MULTI           = $00000200;  { multiple replay from memory on each trigger event }
const     SPC_REP_STD_GATE            = $00000400;  { gated replay from memory on gate signal }

const     SPC_REP_FIFO_SINGLE         = $00000800;  { single replay from FIFO on trigger event }
const     SPC_REP_FIFO_MULTI          = $00001000;  { multiple replay from FIFO on each trigger event }
const     SPC_REP_FIFO_GATE           = $00002000;  { gated replay from FIFO on gate signal }

const     SPC_REP_STD_CONTINUOUS      = $00004000;  { continuous replay started by one trigger event }
const     SPC_REP_STD_SINGLERESTART   = $00008000;  { single replays on every detected trigger event }
const     SPC_REP_STD_SEQUENCE        = $00040000;  { sequence mode replay }

{ Waveforms for demo cards }
const SPC_DEMOWAVEFORM            = 9600;
const SPC_AVAILDEMOWAVEFORMS      = 9601;
const     SPCM_DEMOWAVEFORM_SINE      = $00000001;
const     SPCM_DEMOWAVEFORM_RECT      = $00000002;
const     SPCM_DEMOWAVEFORM_TRIANGLE  = $00000004;


{ Memory }
const SPC_MEMSIZE                 = 10000;
const SPC_SEGMENTSIZE             = 10010;
const SPC_LOOPS                   = 10020;
const SPC_PRETRIGGER              = 10030;
const SPC_ABADIVIDER              = 10040;
const SPC_AVERAGES                = 10050;
const SPC_BOX_AVERAGES            = 10060;
const SPC_SEGSPLIT_START          = 10070;
const SPC_SEGSPLIT_PAUSE          = 10071;
const SPC_POSTTRIGGER             = 10100;
const SPC_STARTOFFSET             = 10200;

{ Memory info (depends on mode and channelenable) }
const SPC_AVAILMEMSIZE_MIN        = 10201;
const SPC_AVAILMEMSIZE_MAX        = 10202;
const SPC_AVAILMEMSIZE_STEP       = 10203;
const SPC_AVAILPOSTTRIGGER_MIN    = 10204;
const SPC_AVAILPOSTTRIGGER_MAX    = 10205;
const SPC_AVAILPOSTTRIGGER_STEP   = 10206;

const SPC_AVAILABADIVIDER_MIN     = 10207;
const SPC_AVAILABADIVIDER_MAX     = 10208;
const SPC_AVAILABADIVIDER_STEP    = 10209;

const SPC_AVAILLOOPS_MIN          = 10210;
const SPC_AVAILLOOPS_MAX          = 10211;
const SPC_AVAILLOOPS_STEP         = 10212;

const SPC_AVAILAVERAGES_MIN       = 10220;
const SPC_AVAILAVERAGES_MAX       = 10221;
const SPC_AVAILAVERAGES_STEP      = 10222;

const SPC_AVAILAVRGSEGSIZE_MIN    = 10223;
const SPC_AVAILAVRGSEGSIZE_MAX    = 10224;
const SPC_AVAILAVRGSEGSIZE_STEP   = 10225;

const SPC_AVAILAVERAGES16BIT_MIN     = 10226;
const SPC_AVAILAVERAGES16BIT_MAX     = 10227;
const SPC_AVAILAVERAGES16BIT_STEP    = 10228;

const SPC_AVAILAVRG16BITSEGSIZE_MIN  = 10229;
const SPC_AVAILAVRG16BITSEGSIZE_MAX  = 10230;
const SPC_AVAILAVRG16BITSEGSIZE_STEP = 10231;

const SPC_AVAILBOXCARAVERAGES_MIN         = 10232;
const SPC_AVAILBOXCARAVERAGES_MAX         = 10233;
const SPC_AVAILBOXCARAVERAGES_STEPFACTOR  = 10234;


{ Channels }
const SPC_CHENABLE                = 11000;
const SPC_CHCOUNT                 = 11001;
const SPC_CHMODACOUNT             = 11100;
const SPC_CHMODBCOUNT             = 11101;


{ ----- channel enable flags for A/D and D/A boards (MI/MC/MX series) ----- }
{       and all cards on M2i series }
const     CHANNEL0                = $00000001;
const     CHANNEL1                = $00000002;
const     CHANNEL2                = $00000004;
const     CHANNEL3                = $00000008;
const     CHANNEL4                = $00000010;
const     CHANNEL5                = $00000020;
const     CHANNEL6                = $00000040;
const     CHANNEL7                = $00000080;
const     CHANNEL8                = $00000100;
const     CHANNEL9                = $00000200;
const     CHANNEL10               = $00000400;
const     CHANNEL11               = $00000800;
const     CHANNEL12               = $00001000;
const     CHANNEL13               = $00002000;
const     CHANNEL14               = $00004000;
const     CHANNEL15               = $00008000;
const     CHANNEL16               = $00010000;
const     CHANNEL17               = $00020000;
const     CHANNEL18               = $00040000;
const     CHANNEL19               = $00080000;
const     CHANNEL20               = $00100000;
const     CHANNEL21               = $00200000;
const     CHANNEL22               = $00400000;
const     CHANNEL23               = $00800000;
const     CHANNEL24               = $01000000;
const     CHANNEL25               = $02000000;
const     CHANNEL26               = $04000000;
const     CHANNEL27               = $08000000;
const     CHANNEL28               = $10000000;
const     CHANNEL29               = $20000000;
const     CHANNEL30               = $40000000;
const     CHANNEL31               = $80000000;
{ CHANNEL32 up to CHANNEL63 are placed in the upper 32 bit of a 64 bit word (M2i only) }


{ ----- old digital i/o settings for 16 bit implementation (MI/MC/MX series)  ----- }
const     CH0_8BITMODE            = 65536;  { for MI.70xx only }
const     CH0_16BIT               = 1;
const     CH0_32BIT               = 3;
const     CH1_16BIT               = 4;
const     CH1_32BIT               = 12;

{ ----- new digital i/o settings for 8 bit implementation (MI/MC/MX series) ----- }
const     MOD0_8BIT               = 1;
const     MOD0_16BIT              = 3;
const     MOD0_32BIT              = 15;
const     MOD1_8BIT               = 16;
const     MOD1_16BIT              = 48;
const     MOD1_32BIT              = 240;

const SPC_CHROUTE0                = 11010;
const SPC_CHROUTE1                = 11020;

const SPC_BITENABLE               = 11030;



{ ----- Clock Settings ----- }
const SPC_SAMPLERATE              = 20000;
const SPC_SYNCCLOCK               = 20005;
const SPC_SAMPLERATE2             = 20010;
const SPC_SR2                     = 20020;
const SPC_PLL_ENABLE              = 20030;
const SPC_PLL_ISLOCKED            = 20031;
const SPC_CLOCKDIV                = 20040;
const SPC_INTCLOCKDIV             = 20041;
const SPC_PXICLOCKDIV             = 20042;
const SPC_PLL_R                   = 20060;
const SPC_PLL_F                   = 20061;
const SPC_PLL_S                   = 20062;
const SPC_PLL_DIV                 = 20063;
const SPC_PXI_CLK_OUT             = 20090;
const SPC_EXTERNALCLOCK           = 20100;
const SPC_EXTERNOUT               = 20110;
const SPC_CLOCKOUT                = 20110;
const SPC_CLOCKOUTFREQUENCY       = 20111;
const SPC_CLOCK50OHM              = 20120;
const SPC_CLOCK110OHM             = 20120;
const SPC_CLOCK75OHM              = 20120;
const SPC_STROBE75OHM             = 20121;
const SPC_EXTERNRANGE             = 20130;
const SPC_EXTRANGESHDIRECT        = 20131;
const     EXRANGE_NONE            = 0;
const     EXRANGE_NOPLL           = 1;
const     EXRANGE_SINGLE          = 2;
const     EXRANGE_BURST_S         = 4;
const     EXRANGE_BURST_M         = 8;
const     EXRANGE_BURST_L         = 16;
const     EXRANGE_BURST_XL        = 32;
const     EXRANGE_LOW             = 64;
const     EXRANGE_HIGH            = 128;
const     EXRANGE_LOW_DPS         = 256;            { digital phase synchronization }
const SPC_REFERENCECLOCK          = 20140;
const     REFCLOCK_PXI            = -1;

{ ----- new clock registers starting with M2i cards ----- }
const SPC_CLOCKMODE               = 20200;      { clock mode as listed below }
const SPC_AVAILCLOCKMODES         = 20201;      { returns all available clock modes }
const     SPC_CM_INTPLL           = $00000001;      { use internal PLL }
const     SPC_CM_QUARTZ1          = $00000002;      { use plain quartz1 (with divider) }
const     SPC_CM_QUARTZ2          = $00000004;      { use plain quartz2 (with divider) }
const     SPC_CM_EXTERNAL         = $00000008;      { use external clock directly }
const     SPC_CM_EXTERNAL0        = $00000008;      { use external clock0 directly (identical value to SPC_CM_EXTERNAL) }
const     SPC_CM_EXTDIVIDER       = $00000010;      { use external clock with programmed divider }
const     SPC_CM_EXTREFCLOCK      = $00000020;      { external reference clock fed in (defined with SPC_REFERENCECLOCK) }
const     SPC_CM_PXIREFCLOCK      = $00000040;      { PXI reference clock }
const     SPC_CM_SHDIRECT         = $00000080;      { Star-hub direct clock (not synchronised) }
const     SPC_CM_QUARTZ2_DIRSYNC  = $00000100;      { use plain quartz2 (with divider) and put the Q2 clock on the star-hub module }
const     SPC_CM_QUARTZ1_DIRSYNC  = $00000200;      { use plain quartz1 (with divider) and put the Q1 clock on the star-hub module }
const     SPC_CM_EXTERNAL1        = $00000400;      { use external clock1 directly }
{ ----- internal use only! ----- }
const     SPC_CM_SYNCINT          = $01000000;
const     SPC_CM_SYNCEXT          = $02000000;

const SPC_CLOCK_READFEATURES      = 20205;
const SPC_CLOCK_READFEATURES0     = 20205;
const SPC_CLOCK_READFEATURES1     = 20206;
const     SPCM_CKFEAT_TERM            = $00000001;
const     SPCM_CKFEAT_HIGHIMP         = $00000002;
const     SPCM_CKFEAT_DCCOUPLING      = $00000004;
const     SPCM_CKFEAT_ACCOUPLING      = $00000008;
const     SPCM_CKFEAT_SE              = $00000010;
const     SPCM_CKFEAT_DIFF            = $00000020;
const     SPCM_CKFEAT_PROGEDGE        = $00000040;
const     SPCM_CKFEAT_LEVELPROG       = $00000100;
const     SPCM_CKFEAT_PROGTHRESHOLD   = $00000200;
const     SPCM_CKFEAT_PROGDELAY       = $00000400;

const SPC_BURSTSYSCLOCKMODE       = 20210;
const SPC_SYNCMASTERSYSCLOCKMODE  = 20211;
const SPC_CLOCK_SETUP_CHANGED     = 20212;

{ clock delay if available }
const SPC_CLOCK_AVAILDELAY_MIN    = 20220;
const SPC_CLOCK_AVAILDELAY_MAX    = 20221;
const SPC_CLOCK_AVAILDELAY_STEP   = 20222;
const SPC_CLOCK_DELAY             = 20223;

{ clock edges }
const SPC_AVAILCLOCKEDGES         = 20224;
const     SPCM_EDGE_FALLING       = $00000001; { Originally SPCM_RISING_EDGE  : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details. }
const     SPCM_EDGE_RISING        = $00000002; { Originally SPCM_FALLING_EDGE : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details. }
const     SPCM_BOTH_EDGES         = $00000004;
const     SPCM_EDGES_BOTH         = $00000004; {Just added for good measure to match naming scheme of above SPCM_EDGE_FALLING and SPCM_EDGE_RISING constants. }
const SPC_CLOCK_EDGE              = 20225;

{ mux definitions for channel routing }
const SPC_CHANNELMUXINFO          = 20300;
const     SPCM_MUX_NONE            = $00000000;  { nothing is interlaced }
const     SPCM_MUX_MUXONMOD        = $00000001;  { data on module is multiplexed, only one channel can have full speed }
const     SPCM_MUX_INVERTCLKONMOD  = $00000002;  { two channels on one module run with inverted clock }
const     SPCM_MUX_DLY             = $00000003;  { delay cable between modules, one channel can have full interlace speed }
const     SPCM_MUX_DLYANDMUXONMOD  = $00000004;  { delay cable between modules and multplexing on module }
const     SPCM_MUX_MUXBETWEENMODS  = $00000005;  { multiplexed between modules (fastest sampling rate only with one module) }
const     SPCM_MUX_MUXONMOD2CH     = $00000006;  { data on module is multiplexed, only two channel can have full speed }
const     SPCM_MUX_MAX4CH          = $00000007;  { only four channels can have full speed, independent of distribution on modules }


{ ----- In/Out Range ----- }
const SPC_OFFS0                   = 30000;
const SPC_AMP0                    = 30010;
const SPC_ACDC0                   = 30020;
const SPC_ACDC_OFFS_COMPENSATION0 = 30021;
const SPC_50OHM0                  = 30030;
const SPC_DIFF0                   = 30040;
const SPC_DOUBLEOUT0              = 30041;
const SPC_DIGITAL0                = 30050;
const SPC_110OHM0                 = 30060;
const SPC_110OHM0L                = 30060;
const SPC_75OHM0                  = 30060;
const SPC_INOUT0                  = 30070;
const SPC_FILTER0                 = 30080;
const SPC_BANKSWITCH0             = 30081;
const SPC_PATH0                   = 30090;
const SPC_ENABLEOUT0              = 30091;

const SPC_OFFS1                   = 30100;
const SPC_AMP1                    = 30110;
const SPC_ACDC1                   = 30120;
const SPC_ACDC_OFFS_COMPENSATION1 = 30121;
const SPC_50OHM1                  = 30130;
const SPC_DIFF1                   = 30140;
const SPC_DOUBLEOUT1              = 30141;
const SPC_DIGITAL1                = 30150;
const SPC_110OHM1                 = 30160;
const SPC_110OHM0H                = 30160;
const SPC_75OHM1                  = 30160;
const SPC_INOUT1                  = 30170;
const SPC_FILTER1                 = 30180;
const SPC_BANKSWITCH1             = 30181;
const SPC_PATH1                   = 30190;
const SPC_ENABLEOUT1              = 30191;

const SPC_OFFS2                   = 30200;
const SPC_AMP2                    = 30210;
const SPC_ACDC2                   = 30220;
const SPC_ACDC_OFFS_COMPENSATION2 = 30221;
const SPC_50OHM2                  = 30230;
const SPC_DIFF2                   = 30240;
const SPC_DOUBLEOUT2              = 30241;
const SPC_110OHM2                 = 30260;
const SPC_110OHM1L                = 30260;
const SPC_75OHM2                  = 30260;
const SPC_INOUT2                  = 30270;
const SPC_FILTER2                 = 30280;
const SPC_BANKSWITCH2             = 30281;
const SPC_PATH2                   = 30290;
const SPC_ENABLEOUT2              = 30291;

const SPC_OFFS3                   = 30300;
const SPC_AMP3                    = 30310;
const SPC_ACDC3                   = 30320;
const SPC_ACDC_OFFS_COMPENSATION3 = 30321;
const SPC_50OHM3                  = 30330;
const SPC_DIFF3                   = 30340;
const SPC_DOUBLEOUT3              = 30341;
const SPC_110OHM3                 = 30360;
const SPC_110OHM1H                = 30360;
const SPC_75OHM3                  = 30360;
const SPC_INOUT3                  = 30370;
const SPC_FILTER3                 = 30380;
const SPC_BANKSWITCH3             = 30381;
const SPC_PATH3                   = 30390;
const SPC_ENABLEOUT3              = 30391;

const SPC_OFFS4                   = 30400;
const SPC_AMP4                    = 30410;
const SPC_ACDC4                   = 30420;
const SPC_50OHM4                  = 30430;
const SPC_DIFF4                   = 30440;
const SPC_DOUBLEOUT4              = 30441;
const SPC_FILTER4                 = 30480;
const SPC_ENABLEOUT4              = 30491;
const SPC_PATH4                   = 30490;

const SPC_OFFS5                   = 30500;
const SPC_AMP5                    = 30510;
const SPC_ACDC5                   = 30520;
const SPC_50OHM5                  = 30530;
const SPC_DIFF5                   = 30540;
const SPC_DOUBLEOUT5              = 30541;
const SPC_FILTER5                 = 30580;
const SPC_ENABLEOUT5              = 30591;
const SPC_PATH5                   = 30590;

const SPC_OFFS6                   = 30600;
const SPC_AMP6                    = 30610;
const SPC_ACDC6                   = 30620;
const SPC_50OHM6                  = 30630;
const SPC_DIFF6                   = 30640;
const SPC_DOUBLEOUT6              = 30641;
const SPC_FILTER6                 = 30680;
const SPC_ENABLEOUT6              = 30691;
const SPC_PATH6                   = 30690;

const SPC_OFFS7                   = 30700;
const SPC_AMP7                    = 30710;
const SPC_ACDC7                   = 30720;
const SPC_50OHM7                  = 30730;
const SPC_DIFF7                   = 30740;
const SPC_DOUBLEOUT7              = 30741;
const SPC_FILTER7                 = 30780;
const SPC_ENABLEOUT7              = 30791;
const SPC_PATH7                   = 30790;

const SPC_OFFS8                   = 30800;
const SPC_AMP8                    = 30810;
const SPC_ACDC8                   = 30820;
const SPC_50OHM8                  = 30830;
const SPC_DIFF8                   = 30840;
const SPC_PATH8                   = 30890;

const SPC_OFFS9                   = 30900;
const SPC_AMP9                    = 30910;
const SPC_ACDC9                   = 30920;
const SPC_50OHM9                  = 30930;
const SPC_DIFF9                   = 30940;
const SPC_PATH9                   = 30990;

const SPC_OFFS10                  = 31000;
const SPC_AMP10                   = 31010;
const SPC_ACDC10                  = 31020;
const SPC_50OHM10                 = 31030;
const SPC_DIFF10                  = 31040;
const SPC_PATH10                  = 31090;

const SPC_OFFS11                  = 31100;
const SPC_AMP11                   = 31110;
const SPC_ACDC11                  = 31120;
const SPC_50OHM11                 = 31130;
const SPC_DIFF11                  = 31140;
const SPC_PATH11                  = 31190;

const SPC_OFFS12                  = 31200;
const SPC_AMP12                   = 31210;
const SPC_ACDC12                  = 31220;
const SPC_50OHM12                 = 31230;
const SPC_DIFF12                  = 31240;
const SPC_PATH12                  = 31290;

const SPC_OFFS13                  = 31300;
const SPC_AMP13                   = 31310;
const SPC_ACDC13                  = 31320;
const SPC_50OHM13                 = 31330;
const SPC_DIFF13                  = 31340;
const SPC_PATH13                  = 31390;

const SPC_OFFS14                  = 31400;
const SPC_AMP14                   = 31410;
const SPC_ACDC14                  = 31420;
const SPC_50OHM14                 = 31430;
const SPC_DIFF14                  = 31440;
const SPC_PATH14                  = 31490;

const SPC_OFFS15                  = 31500;
const SPC_AMP15                   = 31510;
const SPC_ACDC15                  = 31520;
const SPC_50OHM15                 = 31530;
const SPC_DIFF15                  = 31540;
const SPC_PATH15                  = 31590;

const SPC_110OHMTRIGGER           = 30400;
const SPC_110OHMCLOCK             = 30410;


const   AMP_BI200                 = 200;
const   AMP_BI500                 = 500;
const   AMP_BI1000                = 1000;
const   AMP_BI2000                = 2000;
const   AMP_BI2500                = 2500;
const   AMP_BI4000                = 4000;
const   AMP_BI5000                = 5000;
const   AMP_BI10000               = 10000;
const   AMP_UNI400                = 100400;
const   AMP_UNI1000               = 101000;
const   AMP_UNI2000               = 102000;


{ ----- Trigger Settings ----- }
const SPC_TRIGGERMODE             = 40000;
const SPC_TRIG_OUTPUT             = 40100;
const SPC_TRIGGEROUT              = 40100;
const SPC_TRIG_TERM               = 40110;
const SPC_TRIG_TERM0              = 40110;
const SPC_TRIGGER50OHM            = 40110;
const SPC_TRIGGER110OHM0          = 40110;
const SPC_TRIGGER75OHM0           = 40110;
const SPC_TRIG_TERM1              = 40111;
const SPC_TRIGGER110OHM1          = 40111;
const SPC_TRIG_EXT0_ACDC          = 40120;
const SPC_TRIG_EXT1_ACDC          = 40121;
const SPC_TRIG_EXT2_ACDC          = 40122;

const SPC_TRIGGERMODE0            = 40200;
const SPC_TRIGGERMODE1            = 40201;
const SPC_TRIGGERMODE2            = 40202;
const SPC_TRIGGERMODE3            = 40203;
const SPC_TRIGGERMODE4            = 40204;
const SPC_TRIGGERMODE5            = 40205;
const SPC_TRIGGERMODE6            = 40206;
const SPC_TRIGGERMODE7            = 40207;
const SPC_TRIGGERMODE8            = 40208;
const SPC_TRIGGERMODE9            = 40209;
const SPC_TRIGGERMODE10           = 40210;
const SPC_TRIGGERMODE11           = 40211;
const SPC_TRIGGERMODE12           = 40212;
const SPC_TRIGGERMODE13           = 40213;
const SPC_TRIGGERMODE14           = 40214;
const SPC_TRIGGERMODE15           = 40215;

const     TM_SOFTWARE             = 0;
const     TM_NOTRIGGER            = 10;
const     TM_CHXPOS               = 10000;
const     TM_CHXPOS_LP            = 10001;
const     TM_CHXPOS_SP            = 10002;
const     TM_CHXPOS_GS            = 10003;
const     TM_CHXPOS_SS            = 10004;
const     TM_CHXNEG               = 10010;
const     TM_CHXNEG_LP            = 10011;
const     TM_CHXNEG_SP            = 10012;
const     TM_CHXNEG_GS            = 10013;
const     TM_CHXNEG_SS            = 10014;
const     TM_CHXOFF               = 10020;
const     TM_CHXBOTH              = 10030;
const     TM_CHXWINENTER          = 10040;
const     TM_CHXWINENTER_LP       = 10041;
const     TM_CHXWINENTER_SP       = 10042;
const     TM_CHXWINLEAVE          = 10050;
const     TM_CHXWINLEAVE_LP       = 10051;
const     TM_CHXWINLEAVE_SP       = 10052;
const     TM_CHXLOW               = 10060;
const     TM_CHXHIGH              = 10061;
const     TM_CHXINWIN             = 10062;
const     TM_CHXOUTWIN            = 10063;
const     TM_CHXSPIKE             = 10064;


const     TM_CH0POS               = 10000;
const     TM_CH0NEG               = 10010;
const     TM_CH0OFF               = 10020;
const     TM_CH0BOTH              = 10030;
const     TM_CH1POS               = 10100;
const     TM_CH1NEG               = 10110;
const     TM_CH1OFF               = 10120;
const     TM_CH1BOTH              = 10130;
const     TM_CH2POS               = 10200;
const     TM_CH2NEG               = 10210;
const     TM_CH2OFF               = 10220;
const     TM_CH2BOTH              = 10230;
const     TM_CH3POS               = 10300;
const     TM_CH3NEG               = 10310;
const     TM_CH3OFF               = 10320;
const     TM_CH3BOTH              = 10330;

const     TM_TTLPOS               = 20000;
const     TM_TTLHIGH_LP           = 20001;
const     TM_TTLHIGH_SP           = 20002;
const     TM_TTLNEG               = 20010;
const     TM_TTLLOW_LP            = 20011;
const     TM_TTLLOW_SP            = 20012;
const     TM_TTL                  = 20020;
const     TM_TTLBOTH              = 20030;
const     TM_TTLBOTH_LP           = 20031;
const     TM_TTLBOTH_SP           = 20032;
const     TM_CHANNEL              = 20040;
const     TM_TTLHIGH              = 20050;
const     TM_TTLLOW               = 20051;
const     TM_PATTERN              = 21000;
const     TM_PATTERN_LP           = 21001;
const     TM_PATTERN_SP           = 21002;
const     TM_PATTERNANDEDGE       = 22000;
const     TM_PATTERNANDEDGE_LP    = 22001;
const     TM_PATTERNANDEDGE_SP    = 22002;
const     TM_GATELOW              = 30000;
const     TM_GATEHIGH             = 30010;
const     TM_GATEPATTERN          = 30020;
const     TM_CHOR                 = 35000;
const     TM_CHAND                = 35010;
const     TM_CHORTTLPOS           = 35020;
const     TM_CHORTTLNEG           = 35021;

const SPC_PXITRGOUT               = 40300;
const     PTO_OFF                  = 0;
const     PTO_LINE0                = 1;
const     PTO_LINE1                = 2;
const     PTO_LINE2                = 3;
const     PTO_LINE3                = 4;
const     PTO_LINE4                = 5;
const     PTO_LINE5                = 6;
const     PTO_LINE6                = 7;
const     PTO_LINE7                = 8;
const     PTO_LINESTAR             = 9;
const SPC_PXITRGOUT_AVAILABLE     = 40301;  { bitmap register }

const SPC_PXISTARTRG_DIVRST_OUT   = 40302;  { bitmap register }
const SPC_PXISTARTRG_DIVRST_OUT_AVAILABLE   = 40303;
const SPC_PXISTARTRG_OUT          = 40304;  { bitmap register }
const     PSTO_LINESTAR0           = $00000001;
const     PSTO_LINESTAR1           = $00000002;
const     PSTO_LINESTAR2           = $00000004;
const     PSTO_LINESTAR3           = $00000008;
const     PSTO_LINESTAR4           = $00000010;
const     PSTO_LINESTAR5           = $00000020;
const     PSTO_LINESTAR6           = $00000040;
const     PSTO_LINESTAR7           = $00000080;
const     PSTO_LINESTAR8           = $00000100;
const     PSTO_LINESTAR9           = $00000200;
const     PSTO_LINESTAR10          = $00000400;
const     PSTO_LINESTAR11          = $00000800;
const     PSTO_LINESTAR12          = $00001000;
const     PSTO_LINE0               = $00010000;
const     PSTO_LINE1               = $00020000;
const     PSTO_LINE2               = $00040000;
const     PSTO_LINE3               = $00080000;
const     PSTO_LINE4               = $00100000;
const     PSTO_LINE5               = $00200000;
const     PSTO_LINE6               = $00400000;
const     PSTO_LINE7               = $00800000;
const SPC_PXISTARTRG_OUT_AVAILABLE          = 40305;

const SPC_PXITRGIN                = 40310;  { bitmap register }
const     PTI_OFF                  = 0;
const     PTI_LINE0                = 1;
const     PTI_LINE1                = 2;
const     PTI_LINE2                = 4;
const     PTI_LINE3                = 8;
const     PTI_LINE4                = 16;
const     PTI_LINE5                = 32;
const     PTI_LINE6                = 64;
const     PTI_LINE7                = 128;
const     PTI_LINESTAR             = 256;
const SPC_PXITRGIN_AVAILABLE      = 40311;  { bitmap register }
const SPC_PXI_DIVIDER_RESET_IN            = 40320;
const SPC_PXI_DIVIDER_RESET_IN_AVAILABLE  = 40321;


{ new registers of M2i driver }
const SPC_TRIG_AVAILORMASK        = 40400;
const SPC_TRIG_ORMASK             = 40410;
const SPC_TRIG_AVAILANDMASK       = 40420;
const SPC_TRIG_ANDMASK            = 40430;
const     SPC_TMASK_NONE          = $00000000;
const     SPC_TMASK_SOFTWARE      = $00000001;
const     SPC_TMASK_EXT0          = $00000002;
const     SPC_TMASK_EXT1          = $00000004;
const     SPC_TMASK_EXT2          = $00000008;
const     SPC_TMASK_EXT3          = $00000010;
const     SPC_TMASK_XIO0          = $00000100;
const     SPC_TMASK_XIO1          = $00000200;
const     SPC_TMASK_XIO2          = $00000400;
const     SPC_TMASK_XIO3          = $00000800;
const     SPC_TMASK_XIO4          = $00001000;
const     SPC_TMASK_XIO5          = $00002000;
const     SPC_TMASK_XIO6          = $00004000;
const     SPC_TMASK_XIO7          = $00008000;
const     SPC_TMASK_PXI0          = $00100000;
const     SPC_TMASK_PXI1          = $00200000;
const     SPC_TMASK_PXI2          = $00400000;
const     SPC_TMASK_PXI3          = $00800000;
const     SPC_TMASK_PXI4          = $01000000;
const     SPC_TMASK_PXI5          = $02000000;
const     SPC_TMASK_PXI6          = $04000000;
const     SPC_TMASK_PXI7          = $08000000;
const     SPC_TMASK_PXISTAR       = $10000000;
const     SPC_TMASK_PXIDSTARB     = $20000000;

const SPC_TRIG_CH_AVAILORMASK0    = 40450;
const SPC_TRIG_CH_AVAILORMASK1    = 40451;
const SPC_TRIG_CH_ORMASK0         = 40460;
const SPC_TRIG_CH_ORMASK1         = 40461;
const SPC_TRIG_CH_AVAILANDMASK0   = 40470;
const SPC_TRIG_CH_AVAILANDMASK1   = 40471;
const SPC_TRIG_CH_ANDMASK0        = 40480; 
const SPC_TRIG_CH_ANDMASK1        = 40481; 
const     SPC_TMASK0_NONE         = $00000000;
const     SPC_TMASK0_CH0          = $00000001;
const     SPC_TMASK0_CH1          = $00000002;
const     SPC_TMASK0_CH2          = $00000004;
const     SPC_TMASK0_CH3          = $00000008;
const     SPC_TMASK0_CH4          = $00000010;
const     SPC_TMASK0_CH5          = $00000020;
const     SPC_TMASK0_CH6          = $00000040;
const     SPC_TMASK0_CH7          = $00000080;
const     SPC_TMASK0_CH8          = $00000100;
const     SPC_TMASK0_CH9          = $00000200;
const     SPC_TMASK0_CH10         = $00000400;
const     SPC_TMASK0_CH11         = $00000800;
const     SPC_TMASK0_CH12         = $00001000;
const     SPC_TMASK0_CH13         = $00002000;
const     SPC_TMASK0_CH14         = $00004000;
const     SPC_TMASK0_CH15         = $00008000;
const     SPC_TMASK0_CH16         = $00010000;
const     SPC_TMASK0_CH17         = $00020000;
const     SPC_TMASK0_CH18         = $00040000;
const     SPC_TMASK0_CH19         = $00080000;
const     SPC_TMASK0_CH20         = $00100000;
const     SPC_TMASK0_CH21         = $00200000;
const     SPC_TMASK0_CH22         = $00400000;
const     SPC_TMASK0_CH23         = $00800000;
const     SPC_TMASK0_CH24         = $01000000;
const     SPC_TMASK0_CH25         = $02000000;
const     SPC_TMASK0_CH26         = $04000000;
const     SPC_TMASK0_CH27         = $08000000;
const     SPC_TMASK0_CH28         = $10000000;
const     SPC_TMASK0_CH29         = $20000000;
const     SPC_TMASK0_CH30         = $40000000;
const     SPC_TMASK0_CH31         = $80000000;

const     SPC_TMASK1_NONE         = $00000000;
const     SPC_TMASK1_CH32         = $00000001;
const     SPC_TMASK1_CH33         = $00000002;
const     SPC_TMASK1_CH34         = $00000004;
const     SPC_TMASK1_CH35         = $00000008;
const     SPC_TMASK1_CH36         = $00000010;
const     SPC_TMASK1_CH37         = $00000020;
const     SPC_TMASK1_CH38         = $00000040;
const     SPC_TMASK1_CH39         = $00000080;
const     SPC_TMASK1_CH40         = $00000100;
const     SPC_TMASK1_CH41         = $00000200;
const     SPC_TMASK1_CH42         = $00000400;
const     SPC_TMASK1_CH43         = $00000800;
const     SPC_TMASK1_CH44         = $00001000;
const     SPC_TMASK1_CH45         = $00002000;
const     SPC_TMASK1_CH46         = $00004000;
const     SPC_TMASK1_CH47         = $00008000;
const     SPC_TMASK1_CH48         = $00010000;
const     SPC_TMASK1_CH49         = $00020000;
const     SPC_TMASK1_CH50         = $00040000;
const     SPC_TMASK1_CH51         = $00080000;
const     SPC_TMASK1_CH52         = $00100000;
const     SPC_TMASK1_CH53         = $00200000;
const     SPC_TMASK1_CH54         = $00400000;
const     SPC_TMASK1_CH55         = $00800000;
const     SPC_TMASK1_CH56         = $01000000;
const     SPC_TMASK1_CH57         = $02000000;
const     SPC_TMASK1_CH58         = $04000000;
const     SPC_TMASK1_CH59         = $08000000;
const     SPC_TMASK1_CH60         = $10000000;
const     SPC_TMASK1_CH61         = $20000000;
const     SPC_TMASK1_CH62         = $40000000;
const     SPC_TMASK1_CH63         = $80000000;

const SPC_TRIG_EXT_AVAILMODES     = 40500;
const SPC_TRIG_EXT0_AVAILMODES    = 40500;
const SPC_TRIG_EXT1_AVAILMODES    = 40501;
const SPC_TRIG_EXT2_AVAILMODES    = 40502;
const SPC_TRIG_EXT0_AVAILMODESOR  = 40503;
const SPC_TRIG_EXT1_AVAILMODESOR  = 40504;
const SPC_TRIG_EXT2_AVAILMODESOR  = 40505;
const SPC_TRIG_EXT0_AVAILMODESAND = 40506;
const SPC_TRIG_EXT1_AVAILMODESAND = 40507;
const SPC_TRIG_EXT2_AVAILMODESAND = 40508;
const SPC_TRIG_EXT3_AVAILMODESAND = 40509;
const SPC_TRIG_EXT0_MODE          = 40510;
const SPC_TRIG_EXT1_MODE          = 40511;
const SPC_TRIG_EXT2_MODE          = 40512;
const SPC_TRIG_EXT3_MODE          = 40513;
const SPC_TRIG_EXT3_AVAILMODES    = 40514;
const SPC_TRIG_EXT3_AVAILMODESOR  = 40515;

const SPC_TRIG_EXT0_READFEATURES  = 40520;
const SPC_TRIG_EXT1_READFEATURES  = 40521;
const SPC_TRIG_EXT2_READFEATURES  = 40522;
const SPC_TRIG_EXT3_READFEATURES  = 40523;
const     SPCM_TRFEAT_TERM            = $00000001;
const     SPCM_TRFEAT_HIGHIMP         = $00000002;
const     SPCM_TRFEAT_DCCOUPLING      = $00000004;
const     SPCM_TRFEAT_ACCOUPLING      = $00000008;
const     SPCM_TRFEAT_SE              = $00000010;
const     SPCM_TRFEAT_DIFF            = $00000020;
const     SPCM_TRFEAT_LEVELPROG       = $00000100;
const     SPCM_TRFEAT_PROGTHRESHOLD   = $00000200;

{ legacy constants: not enough contiguous constants possible for X4..X19 }
const SPC_LEGACY_X0_READFEATURES  = 40530;
const SPC_LEGACY_X1_READFEATURES  = 40531;
const SPC_LEGACY_X2_READFEATURES  = 40532;
const SPC_LEGACY_X3_READFEATURES  = 40533;

{ legacy constants: not enough contiguous constants possible for X4..X19 }
const SPC_LEGACY_X0_TERM          = 40535;
const SPC_LEGACY_X1_TERM          = 40536;
const SPC_LEGACY_X2_TERM          = 40537;
const SPC_LEGACY_X3_TERM          = 40538;

const SPC_TRIG_XIO_AVAILMODES     = 40550;
const SPC_TRIG_XIO_AVAILMODESOR   = 40551;
const SPC_TRIG_XIO_AVAILMODESAND  = 40552;
const SPC_TRIG_XIO0_MODE          = 40560;
const SPC_TRIG_XIO1_MODE          = 40561;
const     SPC_TM_MODEMASK         = $00FFFFFF;
const     SPC_TM_NONE             = $00000000;
const     SPC_TM_POS              = $00000001;
const     SPC_TM_NEG              = $00000002;
const     SPC_TM_BOTH             = $00000004;
const     SPC_TM_HIGH             = $00000008;
const     SPC_TM_LOW              = $00000010;
const     SPC_TM_WINENTER         = $00000020;
const     SPC_TM_WINLEAVE         = $00000040;
const     SPC_TM_INWIN            = $00000080;
const     SPC_TM_OUTSIDEWIN       = $00000100;
const     SPC_TM_SPIKE            = $00000200;
const     SPC_TM_PATTERN          = $00000400;
const     SPC_TM_STEEPPOS         = $00000800;
const     SPC_TM_STEEPNEG         = $00001000;
const     SPC_TM_EXTRAMASK        = $FF000000;
const     SPC_TM_REARM            = $01000000;
const     SPC_TM_PW_SMALLER       = $02000000;
const     SPC_TM_PW_GREATER       = $04000000;
const     SPC_TM_DOUBLEEDGE       = $08000000;
const     SPC_TM_PULSESTRETCH     = $10000000;
const     SPC_TM_HYSTERESIS       = $20000000;

const SPC_TRIG_PATTERN_AVAILMODES = 40580;
const SPC_TRIG_PATTERN_MODE       = 40590;

const SPC_TRIG_CH_AVAILMODES      = 40600;
const SPC_TRIG_CH_AVAILMODESOR    = 40601;
const SPC_TRIG_CH_AVAILMODESAND   = 40602;
const SPC_TRIG_CH0_MODE           = 40610;
const SPC_TRIG_CH1_MODE           = 40611;
const SPC_TRIG_CH2_MODE           = 40612;
const SPC_TRIG_CH3_MODE           = 40613;
const SPC_TRIG_CH4_MODE           = 40614;
const SPC_TRIG_CH5_MODE           = 40615;
const SPC_TRIG_CH6_MODE           = 40616;
const SPC_TRIG_CH7_MODE           = 40617;
const SPC_TRIG_CH8_MODE           = 40618;
const SPC_TRIG_CH9_MODE           = 40619;
const SPC_TRIG_CH10_MODE          = 40620;
const SPC_TRIG_CH11_MODE          = 40621;
const SPC_TRIG_CH12_MODE          = 40622;
const SPC_TRIG_CH13_MODE          = 40623;
const SPC_TRIG_CH14_MODE          = 40624;
const SPC_TRIG_CH15_MODE          = 40625;
const SPC_TRIG_CH16_MODE          = 40626;
const SPC_TRIG_CH17_MODE          = 40627;
const SPC_TRIG_CH18_MODE          = 40628;
const SPC_TRIG_CH19_MODE          = 40629;
const SPC_TRIG_CH20_MODE          = 40630;
const SPC_TRIG_CH21_MODE          = 40631;
const SPC_TRIG_CH22_MODE          = 40632;
const SPC_TRIG_CH23_MODE          = 40633;
const SPC_TRIG_CH24_MODE          = 40634;
const SPC_TRIG_CH25_MODE          = 40635;
const SPC_TRIG_CH26_MODE          = 40636;
const SPC_TRIG_CH27_MODE          = 40637;
const SPC_TRIG_CH28_MODE          = 40638;
const SPC_TRIG_CH29_MODE          = 40639;
const SPC_TRIG_CH30_MODE          = 40640;
const SPC_TRIG_CH31_MODE          = 40641;

const SPC_TRIG_CH32_MODE          = 40642;
const SPC_TRIG_CH33_MODE          = 40643;
const SPC_TRIG_CH34_MODE          = 40644;
const SPC_TRIG_CH35_MODE          = 40645;
const SPC_TRIG_CH36_MODE          = 40646;
const SPC_TRIG_CH37_MODE          = 40647;
const SPC_TRIG_CH38_MODE          = 40648;
const SPC_TRIG_CH39_MODE          = 40649;
const SPC_TRIG_CH40_MODE          = 40650;
const SPC_TRIG_CH41_MODE          = 40651;
const SPC_TRIG_CH42_MODE          = 40652;
const SPC_TRIG_CH43_MODE          = 40653;
const SPC_TRIG_CH44_MODE          = 40654;
const SPC_TRIG_CH45_MODE          = 40655;
const SPC_TRIG_CH46_MODE          = 40656;
const SPC_TRIG_CH47_MODE          = 40657;
const SPC_TRIG_CH48_MODE          = 40658;
const SPC_TRIG_CH49_MODE          = 40659;
const SPC_TRIG_CH50_MODE          = 40660;
const SPC_TRIG_CH51_MODE          = 40661;
const SPC_TRIG_CH52_MODE          = 40662;
const SPC_TRIG_CH53_MODE          = 40663;
const SPC_TRIG_CH54_MODE          = 40664;
const SPC_TRIG_CH55_MODE          = 40665;
const SPC_TRIG_CH56_MODE          = 40666;
const SPC_TRIG_CH57_MODE          = 40667;
const SPC_TRIG_CH58_MODE          = 40668;
const SPC_TRIG_CH59_MODE          = 40669;
const SPC_TRIG_CH60_MODE          = 40670;
const SPC_TRIG_CH61_MODE          = 40671;
const SPC_TRIG_CH62_MODE          = 40672;
const SPC_TRIG_CH63_MODE          = 40673;


const SPC_TRIG_AVAILDELAY         = 40800;
const SPC_TRIG_AVAILDELAY_STEP    = 40801;
const SPC_TRIG_DELAY              = 40810;

const SPC_TRIG_AVAILHOLDOFF       = 40802;
const SPC_TRIG_AVAILHOLDOFF_STEP  = 40803;
const SPC_TRIG_HOLDOFF            = 40811;

const SPC_SINGLESHOT              = 41000;
const SPC_OUTONTRIGGER            = 41100;
const SPC_RESTARTCONT             = 41200;
const SPC_SINGLERESTART           = 41300;

const SPC_TRIGGERLEVEL            = 42000;
const SPC_TRIGGERLEVEL0           = 42000;
const SPC_TRIGGERLEVEL1           = 42001;
const SPC_TRIGGERLEVEL2           = 42002;
const SPC_TRIGGERLEVEL3           = 42003;
const SPC_TRIGGERLEVEL4           = 42004;
const SPC_TRIGGERLEVEL5           = 42005;
const SPC_TRIGGERLEVEL6           = 42006;
const SPC_TRIGGERLEVEL7           = 42007;
const SPC_TRIGGERLEVEL8           = 42008;
const SPC_TRIGGERLEVEL9           = 42009;
const SPC_TRIGGERLEVEL10          = 42010;
const SPC_TRIGGERLEVEL11          = 42011;
const SPC_TRIGGERLEVEL12          = 42012;
const SPC_TRIGGERLEVEL13          = 42013;
const SPC_TRIGGERLEVEL14          = 42014;
const SPC_TRIGGERLEVEL15          = 42015;

const SPC_AVAILHIGHLEVEL_MIN      = 41997;
const SPC_AVAILHIGHLEVEL_MAX      = 41998;
const SPC_AVAILHIGHLEVEL_STEP     = 41999;

const SPC_HIGHLEVEL0              = 42000;
const SPC_HIGHLEVEL1              = 42001;
const SPC_HIGHLEVEL2              = 42002;
const SPC_HIGHLEVEL3              = 42003;
const SPC_HIGHLEVEL4              = 42004;
const SPC_HIGHLEVEL5              = 42005;
const SPC_HIGHLEVEL6              = 42006;
const SPC_HIGHLEVEL7              = 42007;
const SPC_HIGHLEVEL8              = 42008;
const SPC_HIGHLEVEL9              = 42009;
const SPC_HIGHLEVEL10             = 42010;
const SPC_HIGHLEVEL11             = 42011;
const SPC_HIGHLEVEL12             = 42012;
const SPC_HIGHLEVEL13             = 42013;
const SPC_HIGHLEVEL14             = 42014;
const SPC_HIGHLEVEL15             = 42015;

const SPC_AVAILLOWLEVEL_MIN       = 42097;
const SPC_AVAILLOWLEVEL_MAX       = 42098;
const SPC_AVAILLOWLEVEL_STEP      = 42099;

const SPC_LOWLEVEL0               = 42100;
const SPC_LOWLEVEL1               = 42101;
const SPC_LOWLEVEL2               = 42102;
const SPC_LOWLEVEL3               = 42103;
const SPC_LOWLEVEL4               = 42104;
const SPC_LOWLEVEL5               = 42105;
const SPC_LOWLEVEL6               = 42106;
const SPC_LOWLEVEL7               = 42107;
const SPC_LOWLEVEL8               = 42108;
const SPC_LOWLEVEL9               = 42109;
const SPC_LOWLEVEL10              = 42110;
const SPC_LOWLEVEL11              = 42111;
const SPC_LOWLEVEL12              = 42112;
const SPC_LOWLEVEL13              = 42113;
const SPC_LOWLEVEL14              = 42114;
const SPC_LOWLEVEL15              = 42115;

const SPC_TRIG_CH0_LEVEL0         = 42200;
const SPC_TRIG_CH1_LEVEL0         = 42201;
const SPC_TRIG_CH2_LEVEL0         = 42202;
const SPC_TRIG_CH3_LEVEL0         = 42203;
const SPC_TRIG_CH4_LEVEL0         = 42204;
const SPC_TRIG_CH5_LEVEL0         = 42205;
const SPC_TRIG_CH6_LEVEL0         = 42206;
const SPC_TRIG_CH7_LEVEL0         = 42207;
const SPC_TRIG_CH8_LEVEL0         = 42208;
const SPC_TRIG_CH9_LEVEL0         = 42209;
const SPC_TRIG_CH10_LEVEL0        = 42210;
const SPC_TRIG_CH11_LEVEL0        = 42211;
const SPC_TRIG_CH12_LEVEL0        = 42212;
const SPC_TRIG_CH13_LEVEL0        = 42213;
const SPC_TRIG_CH14_LEVEL0        = 42214;
const SPC_TRIG_CH15_LEVEL0        = 42215;

const SPC_TRIG_CH0_LEVEL1         = 42300;
const SPC_TRIG_CH1_LEVEL1         = 42301;
const SPC_TRIG_CH2_LEVEL1         = 42302;
const SPC_TRIG_CH3_LEVEL1         = 42303;
const SPC_TRIG_CH4_LEVEL1         = 42304;
const SPC_TRIG_CH5_LEVEL1         = 42305;
const SPC_TRIG_CH6_LEVEL1         = 42306;
const SPC_TRIG_CH7_LEVEL1         = 42307;
const SPC_TRIG_CH8_LEVEL1         = 42308;
const SPC_TRIG_CH9_LEVEL1         = 42309;
const SPC_TRIG_CH10_LEVEL1        = 42310;
const SPC_TRIG_CH11_LEVEL1        = 42311;
const SPC_TRIG_CH12_LEVEL1        = 42312;
const SPC_TRIG_CH13_LEVEL1        = 42313;
const SPC_TRIG_CH14_LEVEL1        = 42314;
const SPC_TRIG_CH15_LEVEL1        = 42315;

const SPC_TRIG_EXT0_LEVEL0        = 42320;
const SPC_TRIG_EXT1_LEVEL0        = 42321;
const SPC_TRIG_EXT2_LEVEL0        = 42322;

const SPC_TRIG_EXT0_LEVEL1        = 42330;
const SPC_TRIG_EXT1_LEVEL1        = 42331;
const SPC_TRIG_EXT2_LEVEL1        = 42332;

const SPC_TRIG_EXT_AVAIL0_MIN     = 42340;
const SPC_TRIG_EXT_AVAIL0_MAX     = 42341;
const SPC_TRIG_EXT_AVAIL0_STEP    = 42342;

const SPC_TRIG_EXT_AVAIL1_MIN     = 42345;
const SPC_TRIG_EXT_AVAIL1_MAX     = 42346;
const SPC_TRIG_EXT_AVAIL1_STEP    = 42347;

{ threshold levels (for 77xx) }
const SPC_THRESHOLD0              = 42400;  { threshold level for channel group 0 }
const SPC_THRESHOLD1              = 42401;  { threshold level for channel group 1 }
const SPC_THRESHOLD2              = 42402;  { threshold level for channel group 2 }
const SPC_THRESHOLD3              = 42403;  { threshold level for channel group 3 }
const SPC_CLOCK_THRESHOLD         = 42410;  { threshold level for clock input }
const SPC_TRIG_THRESHOLD          = 42411;  { threshold level for trigger input }
const SPC_X0X1_THRESHOLD          = 42412;  { threshold level for X0/X1 input }
const SPC_STROBE_THRESHOLD        = 42413;  { threshold level for strobe input }

const SPC_AVAILTHRESHOLD_MIN      = 42420;
const SPC_AVAILTHRESHOLD_MAX      = 42421;
const SPC_AVAILTHRESHOLD_STEP     = 42422;

const SPC_CLOCK_AVAILTHRESHOLD_MIN  = 42423;
const SPC_CLOCK_AVAILTHRESHOLD_MAX  = 42424;
const SPC_CLOCK_AVAILTHRESHOLD_STEP = 42425;

const SPC_TRIG_AVAILTHRESHOLD_MIN  = 42426;
const SPC_TRIG_AVAILTHRESHOLD_MAX  = 42427;
const SPC_TRIG_AVAILTHRESHOLD_STEP = 42428;

const SPC_TRIGGERPATTERN          = 43000;
const SPC_TRIGGERPATTERN0         = 43000;
const SPC_TRIGGERPATTERN1         = 43001;
const SPC_TRIGGERMASK             = 43100;
const SPC_TRIGGERMASK0            = 43100;
const SPC_TRIGGERMASK1            = 43101;

const SPC_PULSEWIDTH              = 44000;
const SPC_PULSEWIDTH0             = 44000;
const SPC_PULSEWIDTH1             = 44001;

const SPC_TRIG_CH_AVAILPULSEWIDTH = 44100;
const SPC_TRIG_CH_PULSEWIDTH      = 44101;
const SPC_TRIG_CH0_PULSEWIDTH     = 44101;
const SPC_TRIG_CH1_PULSEWIDTH     = 44102;
const SPC_TRIG_CH2_PULSEWIDTH     = 44103;
const SPC_TRIG_CH3_PULSEWIDTH     = 44104;
const SPC_TRIG_CH4_PULSEWIDTH     = 44105;
const SPC_TRIG_CH5_PULSEWIDTH     = 44106;
const SPC_TRIG_CH6_PULSEWIDTH     = 44107;
const SPC_TRIG_CH7_PULSEWIDTH     = 44108;
const SPC_TRIG_CH8_PULSEWIDTH     = 44109;
const SPC_TRIG_CH9_PULSEWIDTH     = 44110;
const SPC_TRIG_CH10_PULSEWIDTH    = 44111;
const SPC_TRIG_CH11_PULSEWIDTH    = 44112;
const SPC_TRIG_CH12_PULSEWIDTH    = 44113;
const SPC_TRIG_CH13_PULSEWIDTH    = 44114;
const SPC_TRIG_CH14_PULSEWIDTH    = 44115;
const SPC_TRIG_CH15_PULSEWIDTH    = 44116;

const SPC_TRIG_EXT_AVAILPULSEWIDTH = 44200;
const SPC_TRIG_EXT0_PULSEWIDTH    = 44210;
const SPC_TRIG_EXT1_PULSEWIDTH    = 44211;
const SPC_TRIG_EXT2_PULSEWIDTH    = 44212;
const SPC_TRIG_EXT3_PULSEWIDTH    = 44213;

{ available dividers for MICX }
const SPC_READCLOCKDIVCOUNT       = 44300;
const SPC_CLOCKDIV0               = 44301;
const SPC_CLOCKDIV1               = 44302;
const SPC_CLOCKDIV2               = 44303;
const SPC_CLOCKDIV3               = 44304;
const SPC_CLOCKDIV4               = 44305;
const SPC_CLOCKDIV5               = 44306;
const SPC_CLOCKDIV6               = 44307;
const SPC_CLOCKDIV7               = 44308;
const SPC_CLOCKDIV8               = 44309;
const SPC_CLOCKDIV9               = 44310;
const SPC_CLOCKDIV10              = 44311;
const SPC_CLOCKDIV11              = 44312;
const SPC_CLOCKDIV12              = 44313;
const SPC_CLOCKDIV13              = 44314;
const SPC_CLOCKDIV14              = 44315;
const SPC_CLOCKDIV15              = 44316;
const SPC_CLOCKDIV16              = 44317;

const SPC_READTROFFSET            = 45000;
const SPC_TRIGGEREDGE             = 46000;
const SPC_TRIGGEREDGE0            = 46000;
const SPC_TRIGGEREDGE1            = 46001;
const     TE_POS                  = 10000;
const     TE_NEG                  = 10010;
const     TE_BOTH                 = 10020;
const     TE_NONE                 = 10030;


{ ----- Timestamp ----- }
const CH_TIMESTAMP                = 9999;

const SPC_TIMESTAMP_CMD           = 47000;
const     TS_RESET                    = 0;
const     TS_MODE_DISABLE             = 10;
const     TS_MODE_STARTRESET          = 11;
const     TS_MODE_STANDARD            = 12;
const     TS_MODE_REFCLOCK            = 13;
const     TS_MODE_TEST5555            = 90;
const     TS_MODE_TESTAAAA            = 91;
const     TS_MODE_ZHTEST              = 92;

{ ----- modes for M2i, M3i, M4i, M4x, M2p hardware (bitmap) ----- }
const SPC_TIMESTAMP_AVAILMODES    = 47001;
const     SPC_TSMODE_DISABLE      = $00000000;
const     SPC_TS_RESET            = $00000001;
const     SPC_TSMODE_STANDARD     = $00000002;
const     SPC_TSMODE_STARTRESET   = $00000004;
const     SPC_TS_RESET_WAITREFCLK = $00000008;
const     SPC_TSCNT_INTERNAL      = $00000100;
const     SPC_TSCNT_REFCLOCKPOS   = $00000200;
const     SPC_TSCNT_REFCLOCKNEG   = $00000400;
const     SPC_TSFEAT_NONE         = $00000000;
const     SPC_TSFEAT_STORE1STABA  = $00010000;
const     SPC_TSFEAT_INCRMODE     = $00020000;
const     SPC_TSFEAT_INCRMODE12   = $00040000;
const     SPC_TSFEAT_TRGSRC       = $00080000;

const     SPC_TSXIOACQ_DISABLE    = $00000000;
const     SPC_TSXIOACQ_ENABLE     = $00001000;
const     SPC_TSXIOINC_ENABLE     = $00002000;
const     SPC_TSXIOINC12_ENABLE   = $00004000;

const     SPC_TSMODE_MASK         = $000000FF;
const     SPC_TSCNT_MASK          = $00000F00;
const     SPC_TSFEAT_MASK         = $000F0000;

const     SPC_TRGSRC_MASK_CH0       = $00000001;
const     SPC_TRGSRC_MASK_CH1       = $00000002;
const     SPC_TRGSRC_MASK_CH2       = $00000004;
const     SPC_TRGSRC_MASK_CH3       = $00000008;
const     SPC_TRGSRC_MASK_CH4       = $00000010;
const     SPC_TRGSRC_MASK_CH5       = $00000020;
const     SPC_TRGSRC_MASK_CH6       = $00000040;
const     SPC_TRGSRC_MASK_CH7       = $00000080;
const     SPC_TRGSRC_MASK_EXT0      = $00000100;
const     SPC_TRGSRC_MASK_EXT1      = $00000200;
const     SPC_TRGSRC_MASK_FORCE     = $00000400;
{ space for digital channels using TSXIOACQ_ENABLE of standard multi-purpose lines }
const     SPC_TRGSRC_MASK_PXI0      = $00010000;
const     SPC_TRGSRC_MASK_PXI1      = $00020000;
const     SPC_TRGSRC_MASK_PXI2      = $00040000;
const     SPC_TRGSRC_MASK_PXI3      = $00080000;
const     SPC_TRGSRC_MASK_PXI4      = $00100000;
const     SPC_TRGSRC_MASK_PXI5      = $00200000;
const     SPC_TRGSRC_MASK_PXI6      = $00400000;
const     SPC_TRGSRC_MASK_PXI7      = $00800000;
const     SPC_TRGSRC_MASK_PXISTAR   = $01000000;
const     SPC_TRGSRC_MASK_PXIDSTARB = $02000000;
const     SPC_TRGSRC_MASK_X1        = $20000000;
const     SPC_TRGSRC_MASK_X2        = $40000000;
const     SPC_TRGSRC_MASK_X3        = $80000000;
{ space for more digital channels using TSXIOACQ_ENABLE of additional multi-purpose lines (optional) }


const SPC_TIMESTAMP_STATUS        = 47010;
const     TS_FIFO_EMPTY               = 0;
const     TS_FIFO_LESSHALF            = 1;
const     TS_FIFO_MOREHALF            = 2;
const     TS_FIFO_OVERFLOW            = 3;

const SPC_TIMESTAMP_COUNT         = 47020;
const SPC_TIMESTAMP_STARTTIME     = 47030;
const SPC_TIMESTAMP_STARTDATE     = 47031;
const SPC_TIMESTAMP_FIFO          = 47040;
const SPC_TIMESTAMP_TIMEOUT       = 47045;

const SPC_TIMESTAMP_RESETMODE     = 47050;
const     TS_RESET_POS               = 10;
const     TS_RESET_NEG               = 20;



{ ----- Extra I/O module ----- }
const SPC_XIO_DIRECTION           = 47100;
const     XD_CH0_INPUT                = 0;
const     XD_CH0_OUTPUT               = 1;
const     XD_CH1_INPUT                = 0;
const     XD_CH1_OUTPUT               = 2;
const     XD_CH2_INPUT                = 0;
const     XD_CH2_OUTPUT               = 4;
const SPC_XIO_DIGITALIO           = 47110;
const SPC_XIO_ANALOGOUT0          = 47120;
const SPC_XIO_ANALOGOUT1          = 47121;
const SPC_XIO_ANALOGOUT2          = 47122;
const SPC_XIO_ANALOGOUT3          = 47123;
const SPC_XIO_WRITEDACS           = 47130;



{ ----- M3i        multi purpose lines (X0, X1        )  }
{ ----- M4i + M4x  multi purpose lines (X0, X1, X2    )  }
{ ----- M2p        multi purpose lines (X0, X1, X2, X3) and with installed option also (X4 .. X19) }

{ legacy constants: not enough contiguous constants possible for X4..X19, }
{ hence new constants for X-modes (SPCM_X0_MODE.. SPCM_X19_MODE) exist further below }
const SPCM_LEGACY_X0_MODE         = 47200;
const SPCM_LEGACY_X1_MODE         = 47201;
const SPCM_LEGACY_X2_MODE         = 47202;
const SPCM_LEGACY_X3_MODE         = 47203;
const SPCM_LEGACY_X0_AVAILMODES   = 47210;
const SPCM_LEGACY_X1_AVAILMODES   = 47211;
const SPCM_LEGACY_X2_AVAILMODES   = 47212;
const SPCM_LEGACY_X3_AVAILMODES   = 47213;
const     SPCM_XMODE_DISABLE           = $00000000;
const     SPCM_XMODE_ASYNCIN           = $00000001;  { used as asynchronous input }
const     SPCM_XMODE_ASYNCOUT          = $00000002;  { used as asynchronous output }
const     SPCM_XMODE_DIGIN             = $00000004;  { used as synchronous digital input }
const     SPCM_XMODE_DIGOUT            = $00000008;  { used as synchronous digital output }
const     SPCM_XMODE_TRIGIN            = $00000010;  { used as trigger input }
const     SPCM_XMODE_TRIGOUT           = $00000020;  { used as trigger output }
const     SPCM_XMODE_OVROUT            = $00000040;  { used as ADC overrange output }
const     SPCM_XMODE_DIGIN2BIT         = $00000080;  { used as synchronous digital input, 2bits per channel }
const     SPCM_XMODE_RUNSTATE          = $00000100;  { shows the run state of the card (high = run) }
const     SPCM_XMODE_ARMSTATE          = $00000200;  { shows the arm state (high = armed for trigger of one single card) }
const     SPCM_XMODE_DIRECTTRIGOUT     = $00000400;  { used as direct trigger output (safe mode)  }
const     SPCM_XMODE_DIRECTTRIGOUT_LR  = $00000800;  { used as direct trigger output (low re-arm) }
const     SPCM_XMODE_REFCLKOUT         = $00001000;  { outputs internal or fed in external refclock }
const     SPCM_XMODE_CONTOUTMARK       = $00002000;  { outputs a half posttrigger long HIGH pulse on replay }
const     SPCM_XMODE_SYSCLKOUT         = $00004000;  { outputs internal system clock }
const     SPCM_XMODE_CLKOUT            = $00008000;  { clock output }
const     SPCM_XMODE_SYNCARMSTATE      = $00010000;  { shows the arm state (high = armed for trigger when all cards connected to a Star-Hub are armed) }
const     SPCM_XMODE_OPTDIGIN2BIT      = $00020000;  { used as synchronous digital input from digitaloption, 2bits per channel }
const     SPCM_XMODE_OPTDIGIN4BIT      = $00040000;  { used as synchronous digital input from digitaloption, 4bits per channel }
const     SPCM_XMODE_MODEMASK          = $000FFFFF;

{ additional constants to be combined together with SPCM_XMODE_DIGOUT to select analog channel containing digital data }
const     SPCM_XMODE_DIGOUTSRC_CH0     = $01000000;  { Select Ch0 as source  }
const     SPCM_XMODE_DIGOUTSRC_CH1     = $02000000;  { Select Ch1 as source }
const     SPCM_XMODE_DIGOUTSRC_CH2     = $04000000;  { Select Ch2 as source }
const     SPCM_XMODE_DIGOUTSRC_CH3     = $08000000;  { Select Ch3 as source }
const     SPCM_XMODE_DIGOUTSRC_CH4     = $10000000;  { Select Ch4 as source }
const     SPCM_XMODE_DIGOUTSRC_CH5     = $20000000;  { Select Ch5 as source }
const     SPCM_XMODE_DIGOUTSRC_CH6     = $40000000;  { Select Ch6 as source }
const     SPCM_XMODE_DIGOUTSRC_CH7     = $80000000;  { Select Ch7 as source }
const     SPCM_XMODE_DIGOUTSRC_CHMASK  = $FF000000;

{ additional constants to be combined together with SPCM_XMODE_DIGOUT to select digital signal source }
const     SPCM_XMODE_DIGOUTSRC_BIT15              = $00100000;  { Use Bit15 (MSB    ) of selected channel: channel resolution will be reduced to 15 bit }
const     SPCM_XMODE_DIGOUTSRC_BIT14              = $00200000;  { Use Bit14 (MSB - 1) of selected channel: channel resolution will be reduced to 14 bit }
const     SPCM_XMODE_DIGOUTSRC_BIT13              = $00400000;  { Use Bit13 (MSB - 2) of selected channel: channel resolution will be reduced to 13 bit }
const     SPCM_XMODE_DIGOUTSRC_BIT12              = $00800000;  { Use Bit12 (MSB - 3) of selected channel: channel resolution will be reduced to 12 bit }
const     SPCM_XMODE_DIGOUTSRC_BITMASK            = $00F00000;
{ special combinations for M2p.65xx cards with options SPCM_FEAT_DIG16_SMB or SPCM_FEAT_DIG16_FX2 }
const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_0     = $00F00000;  { use all   16 bits of selected channel on  (X19..X4)              : channel will only contain digital data }
const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_8     = $00700000;  { use upper  8 bits of selected channel for (X19..X12) or (X11..X4): channel resolution will be reduced to 8 bit }

const SPCM_XX_ASYNCIO             = 47220;           { asynchronous in/out register }

const SPC_DIGMODE0 = 47250;
const SPC_DIGMODE1 = 47251;
const SPC_DIGMODE2 = 47252;
const SPC_DIGMODE3 = 47253;
const SPC_DIGMODE4 = 47254;
const SPC_DIGMODE5 = 47255;
const SPC_DIGMODE6 = 47256;
const SPC_DIGMODE7 = 47257;
const     SPCM_DIGMODE_OFF = $00000000;

const     SPCM_DIGMODE_X1  = $294A5000; { (M2P_DIGMODE_X1 << (32 - 5)) | (M2P_DIGMODE_X1 << (32 - 10))  ... etc }
const     SPCM_DIGMODE_X2  = $318C6000; { (M2P_DIGMODE_X2 << (32 - 5)) | (M2P_DIGMODE_X2 << (32 - 10))  ... etc }
const     SPCM_DIGMODE_X3  = $39CE7000; { (M2P_DIGMODE_X3 << (32 - 5)) | (M2P_DIGMODE_X3 << (32 - 10))  ... etc }
const     SPCM_DIGMODE_X4  = $84210001;
const     SPCM_DIGMODE_X5  = $8c631002;
const     SPCM_DIGMODE_X6  = $94a52004;
const     SPCM_DIGMODE_X7  = $9ce73008;
const     SPCM_DIGMODE_X8  = $a5294010;
const     SPCM_DIGMODE_X9  = $ad6b5020;
const     SPCM_DIGMODE_X10 = $b5ad6040;
const     SPCM_DIGMODE_X11 = $bdef7080;
const     SPCM_DIGMODE_X12 = $c6318100;
const     SPCM_DIGMODE_X13 = $ce739200;
const     SPCM_DIGMODE_X14 = $d6b5a400;
const     SPCM_DIGMODE_X15 = $def7b800;
const     SPCM_DIGMODE_X16 = $e739c000;
const     SPCM_DIGMODE_X17 = $ef7bd000;
const     SPCM_DIGMODE_X18 = $f7bde000;
const     SPCM_DIGMODE_X19 = $fffff000;

const     DIGMODEMASK_BIT15 = $F8000000;
const     DIGMODEMASK_BIT14 = $07C00000;
const     DIGMODEMASK_BIT13 = $003E0000;
const     DIGMODEMASK_BIT12 = $0001F000;
const     DIGMODEMASK_BIT11 = $00000800; { one bit only for bit 11 downto 0 }
const     DIGMODEMASK_BIT10 = $00000400;
const     DIGMODEMASK_BIT9  = $00000200;
const     DIGMODEMASK_BIT8  = $00000100;
const     DIGMODEMASK_BIT7  = $00000080;
const     DIGMODEMASK_BIT6  = $00000040;
const     DIGMODEMASK_BIT5  = $00000020;
const     DIGMODEMASK_BIT4  = $00000010;
const     DIGMODEMASK_BIT3  = $00000008;
const     DIGMODEMASK_BIT2  = $00000004;
const     DIGMODEMASK_BIT1  = $00000002;
const     DIGMODEMASK_BIT0  = $00000001;

{ provided for convenience }
const SPCM_DIGMODE_CHREPLACE     = $FFBBCFFF;
{#define SPCM_DIGMODE_CHREPLACE    (  (DIGMODEMASK_BIT15 & SPCM_DIGMODE_X19) }
{                                   | (DIGMODEMASK_BIT14 & SPCM_DIGMODE_X18) }
{                                   | (DIGMODEMASK_BIT13 & SPCM_DIGMODE_X17) }
{                                   | (DIGMODEMASK_BIT12 & SPCM_DIGMODE_X16) }
{                                   | (DIGMODEMASK_BIT11 & SPCM_DIGMODE_X15) }
{                                   | (DIGMODEMASK_BIT10 & SPCM_DIGMODE_X14) }
{                                   | (DIGMODEMASK_BIT9  & SPCM_DIGMODE_X13) }
{                                   | (DIGMODEMASK_BIT8  & SPCM_DIGMODE_X12) }
{                                   | (DIGMODEMASK_BIT7  & SPCM_DIGMODE_X11) }
{                                   | (DIGMODEMASK_BIT6  & SPCM_DIGMODE_X10) }
{                                   | (DIGMODEMASK_BIT5  & SPCM_DIGMODE_X9 ) }
{                                   | (DIGMODEMASK_BIT4  & SPCM_DIGMODE_X8 ) }
{                                   | (DIGMODEMASK_BIT3  & SPCM_DIGMODE_X7 ) }
{                                   | (DIGMODEMASK_BIT2  & SPCM_DIGMODE_X6 ) }
{                                   | (DIGMODEMASK_BIT1  & SPCM_DIGMODE_X5 ) }
{                                   | (DIGMODEMASK_BIT0  & SPCM_DIGMODE_X4 ) ) }
{ }


{ ----- M4x PXI Trigger lines ----- }
const SPC_PXITRG0_MODE           = 47300;
const SPC_PXITRG1_MODE           = 47301;
const SPC_PXITRG2_MODE           = 47302;
const SPC_PXITRG3_MODE           = 47303;
const SPC_PXITRG4_MODE           = 47304;
const SPC_PXITRG5_MODE           = 47305;
const SPC_PXITRG6_MODE           = 47306;
const SPC_PXITRG7_MODE           = 47307;
const SPC_PXISTAR_MODE           = 47308;
const SPC_PXIDSTARC_MODE         = 47309;
const SPC_PXITRG0_AVAILMODES     = 47310;
const SPC_PXITRG1_AVAILMODES     = 47311;
const SPC_PXITRG2_AVAILMODES     = 47312;
const SPC_PXITRG3_AVAILMODES     = 47313;
const SPC_PXITRG4_AVAILMODES     = 47314;
const SPC_PXITRG5_AVAILMODES     = 47315;
const SPC_PXITRG6_AVAILMODES     = 47316;
const SPC_PXITRG7_AVAILMODES     = 47317;
const SPC_PXISTAR_AVAILMODES     = 47318;
const SPC_PXIDSTARC_AVAILMODES   = 47319;
const SPC_PXITRG_ASYNCIO         = 47320;          { asynchronous in/out register }
const     SPCM_PXITRGMODE_DISABLE     = $00000000;
const     SPCM_PXITRGMODE_IN          = $00000001;  { used as input }
const     SPCM_PXITRGMODE_ASYNCOUT    = $00000002;  { used as asynchronous output }
const     SPCM_PXITRGMODE_RUNSTATE    = $00000004;  { shows the run state of the card (high = run) }
const     SPCM_PXITRGMODE_ARMSTATE    = $00000008;  { shows the arm state (high = armed for trigger) }
const     SPCM_PXITRGMODE_TRIGOUT     = $00000010;  { used as trigger output }
const     SPCM_PXITRGMODE_REFCLKOUT   = $00000020;  { outputs PXI refclock (10 MHz) }
const     SPCM_PXITRGMODE_CONTOUTMARK = $00000040;  { outputs a half posttrigger long HIGH pulse on replay }


{ ----- Star-Hub ----- }
{ 48000 not usable }

const SPC_STARHUB_STATUS          = 48010;

const SPC_STARHUB_ROUTE0          = 48100;  { Routing Information for Test }
const SPC_STARHUB_ROUTE99         = 48199;  { ... }


{ Spcm driver (M2i, M3i, M4i, M4x, M2p) sync setup registers }
const SPC_SYNC_READ_SYNCCOUNT     = 48990;  { number of sync'd cards }
const SPC_SYNC_READ_NUMCONNECTORS = 48991;  { number of connectors on starhub }

const SPC_SYNC_READ_CARDIDX0      = 49000;  { read index of card at location 0 of sync }
const SPC_SYNC_READ_CARDIDX1      = 49001;  { ... }
const SPC_SYNC_READ_CARDIDX2      = 49002;  { ... }
const SPC_SYNC_READ_CARDIDX3      = 49003;  { ... }
const SPC_SYNC_READ_CARDIDX4      = 49004;  { ... }
const SPC_SYNC_READ_CARDIDX5      = 49005;  { ... }
const SPC_SYNC_READ_CARDIDX6      = 49006;  { ... }
const SPC_SYNC_READ_CARDIDX7      = 49007;  { ... }
const SPC_SYNC_READ_CARDIDX8      = 49008;  { ... }
const SPC_SYNC_READ_CARDIDX9      = 49009;  { ... }
const SPC_SYNC_READ_CARDIDX10     = 49010;  { ... }
const SPC_SYNC_READ_CARDIDX11     = 49011;  { ... }
const SPC_SYNC_READ_CARDIDX12     = 49012;  { ... }
const SPC_SYNC_READ_CARDIDX13     = 49013;  { ... }
const SPC_SYNC_READ_CARDIDX14     = 49014;  { ... }
const SPC_SYNC_READ_CARDIDX15     = 49015;  { ... }

const SPC_SYNC_READ_CABLECON0     = 49100;  { read cable connection of card at location 0 of sync }
const SPC_SYNC_READ_CABLECON1     = 49101;  { ... }
const SPC_SYNC_READ_CABLECON2     = 49102;  { ... }
const SPC_SYNC_READ_CABLECON3     = 49103;  { ... }
const SPC_SYNC_READ_CABLECON4     = 49104;  { ... }
const SPC_SYNC_READ_CABLECON5     = 49105;  { ... }
const SPC_SYNC_READ_CABLECON6     = 49106;  { ... }
const SPC_SYNC_READ_CABLECON7     = 49107;  { ... }
const SPC_SYNC_READ_CABLECON8     = 49108;  { ... }
const SPC_SYNC_READ_CABLECON9     = 49109;  { ... }
const SPC_SYNC_READ_CABLECON10    = 49110;  { ... }
const SPC_SYNC_READ_CABLECON11    = 49111;  { ... }
const SPC_SYNC_READ_CABLECON12    = 49112;  { ... }
const SPC_SYNC_READ_CABLECON13    = 49113;  { ... }
const SPC_SYNC_READ_CABLECON14    = 49114;  { ... }
const SPC_SYNC_READ_CABLECON15    = 49115;  { ... }

const SPC_SYNC_ENABLEMASK         = 49200;  { synchronisation enable (mask) }
const SPC_SYNC_NOTRIGSYNCMASK     = 49210;  { trigger disabled for sync (mask) }
const SPC_SYNC_CLKMASK            = 49220;  { clock master (mask) }
const SPC_SYNC_MODE               = 49230;  { synchronization mode }
const SPC_AVAILSYNC_MODES         = 49231;  { available synchronization modes }
const     SPC_SYNC_STANDARD         = $00000001;  { starhub uses its own clock and trigger sources }
const     SPC_SYNC_SYSTEMCLOCK      = $00000002;  { starhub uses own trigger sources and takes clock from system starhub }
const     SPC_SYNC_SYSTEMCLOCKTRIG  = $00000004;  { starhub takes clock and trigger from system starhub (trigger sampled on rising  clock edge) }
const     SPC_SYNC_SYSTEMCLOCKTRIGN = $00000008;  { starhub takes clock and trigger from system starhub (trigger sampled on falling clock edge) }
const SPC_SYNC_SYSTEM_TRIGADJUST  = 49240;  { Delay value for adjusting trigger position using system starhub }


{ ----- Gain and Offset Adjust DAC's ----- }
const SPC_ADJ_START               = 50000;

const SPC_ADJ_LOAD                = 50000;
const SPC_ADJ_SAVE                = 50010;
const     ADJ_DEFAULT                 = 0;
const     ADJ_USER0                   = 1;
const     ADJ_USER1                   = 2;
const     ADJ_USER2                   = 3;
const     ADJ_USER3                   = 4;
const     ADJ_USER4                   = 5;
const     ADJ_USER5                   = 6;
const     ADJ_USER6                   = 7;
const     ADJ_USER7                   = 8;

const SPC_ADJ_AUTOADJ             = 50020;
const     ADJ_ALL                     = 0;
const     ADJ_CURRENT                 = 1;
const     ADJ_EXTERNAL                = 2;
const     ADJ_1MOHM                   = 3;

const     ADJ_CURRENT_CLOCK           = 4;
const     ADJ_CURRENT_IR              = 8;
const     ADJ_OFFSET_ONLY            = 16;
const     ADJ_SPECIAL_CLOCK          = 32;

const SPC_ADJ_SOURCE_CALLBACK     = 50021;
const SPC_ADJ_PROGRESS_CALLBACK   = 50022;

const SPC_ADJ_SET                 = 50030;
const SPC_ADJ_FAILMASK            = 50040;

const SPC_ADJ_CALIBSOURCE            = 50050;
const        ADJ_CALSRC_GAIN             = 1;
const        ADJ_CALSRC_OFF              = 0;
const        ADJ_CALSRC_GND             = -1;
const        ADJ_CALSRC_GNDOFFS         = -2;
const        ADJ_CALSRC_AC              = 10;

const SPC_ADJ_CALIBVALUE0            = 50060;
const SPC_ADJ_CALIBVALUE1            = 50061;
const SPC_ADJ_CALIBVALUE2            = 50062;
const SPC_ADJ_CALIBVALUE3            = 50063;
const SPC_ADJ_CALIBVALUE4            = 50064;
const SPC_ADJ_CALIBVALUE5            = 50065;
const SPC_ADJ_CALIBVALUE6            = 50066;
const SPC_ADJ_CALIBVALUE7            = 50067;

const SPC_ADJ_OFFSET_CH0          = 50900;
const SPC_ADJ_OFFSET_CH1          = 50901;
const SPC_ADJ_OFFSET_CH2          = 50902;
const SPC_ADJ_OFFSET_CH3          = 50903;
const SPC_ADJ_OFFSET_CH4          = 50904;
const SPC_ADJ_OFFSET_CH5          = 50905;
const SPC_ADJ_OFFSET_CH6          = 50906;
const SPC_ADJ_OFFSET_CH7          = 50907;
const SPC_ADJ_OFFSET_CH8          = 50908;
const SPC_ADJ_OFFSET_CH9          = 50909;
const SPC_ADJ_OFFSET_CH10         = 50910;
const SPC_ADJ_OFFSET_CH11         = 50911;
const SPC_ADJ_OFFSET_CH12         = 50912;
const SPC_ADJ_OFFSET_CH13         = 50913;
const SPC_ADJ_OFFSET_CH14         = 50914;
const SPC_ADJ_OFFSET_CH15         = 50915;

const SPC_ADJ_GAIN_CH0            = 50916;
const SPC_ADJ_GAIN_CH1            = 50917;
const SPC_ADJ_GAIN_CH2            = 50918;
const SPC_ADJ_GAIN_CH3            = 50919;
const SPC_ADJ_GAIN_CH4            = 50920;
const SPC_ADJ_GAIN_CH5            = 50921;
const SPC_ADJ_GAIN_CH6            = 50922;
const SPC_ADJ_GAIN_CH7            = 50923;
const SPC_ADJ_GAIN_CH8            = 50924;
const SPC_ADJ_GAIN_CH9            = 50925;
const SPC_ADJ_GAIN_CH10           = 50926;
const SPC_ADJ_GAIN_CH11           = 50927;
const SPC_ADJ_GAIN_CH12           = 50928;
const SPC_ADJ_GAIN_CH13           = 50929;
const SPC_ADJ_GAIN_CH14           = 50930;
const SPC_ADJ_GAIN_CH15           = 50931;

const SPC_ADJ_OFFSET0             = 51000;
const SPC_ADJ_OFFSET999           = 51999;

const SPC_ADJ_GAIN0               = 52000;
const SPC_ADJ_GAIN999             = 52999;

const SPC_ADJ_CORRECT0            = 53000;
const SPC_ADJ_OFFS_CORRECT0       = 53000;
const SPC_ADJ_CORRECT999          = 53999;
const SPC_ADJ_OFFS_CORRECT999     = 53999;

const SPC_ADJ_XIOOFFS0            = 54000;
const SPC_ADJ_XIOOFFS1            = 54001;
const SPC_ADJ_XIOOFFS2            = 54002;
const SPC_ADJ_XIOOFFS3            = 54003;

const SPC_ADJ_XIOGAIN0            = 54010;
const SPC_ADJ_XIOGAIN1            = 54011;
const SPC_ADJ_XIOGAIN2            = 54012;
const SPC_ADJ_XIOGAIN3            = 54013;

const SPC_ADJ_GAIN_CORRECT0       = 55000;
const SPC_ADJ_GAIN_CORRECT999     = 55999;

const SPC_ADJ_OFFSCALIBCORRECT0   = 56000;
const SPC_ADJ_OFFSCALIBCORRECT999 = 56999;

const SPC_ADJ_GAINCALIBCORRECT0   = 57000;
const SPC_ADJ_GAINCALIBCORRECT999 = 57999;

const SPC_ADJ_ANALOGTRIGGER0      = 58000;
const SPC_ADJ_ANALOGTRIGGER99     = 58099;

const SPC_ADJ_CALIBSAMPLERATE0    = 58100;
const SPC_ADJ_CALIBSAMPLERATE99   = 58199;

const SPC_ADJ_CALIBSAMPLERATE_GAIN0    = 58200;
const SPC_ADJ_CALIBSAMPLERATE_GAIN99   = 58299;

const SPC_ADJ_REFCLOCK            = 58300;
const SPC_ADJ_STARHUB_REFCLOCK    = 58301;

const SPC_ADJ_END                 = 59999;



{ ----- FIFO Control ----- }
const SPC_FIFO_BUFFERS            = 60000;          { number of FIFO buffers }
const SPC_FIFO_BUFLEN             = 60010;          { len of each FIFO buffer }
const SPC_FIFO_BUFCOUNT           = 60020;          { number of FIFO buffers tranfered until now }
const SPC_FIFO_BUFMAXCNT          = 60030;          { number of FIFO buffers to be transfered (0=continuous) }
const SPC_FIFO_BUFADRCNT          = 60040;          { number of FIFO buffers allowed }
const SPC_FIFO_BUFREADY           = 60050;          { fifo buffer ready register (same as SPC_COMMAND + SPC_FIFO_BUFREADY0...) }
const SPC_FIFO_BUFFILLCNT         = 60060;          { number of currently filled buffers }
const SPC_FIFO_BUFADR0            = 60100;          { adress of FIFO buffer no. 0 }
const SPC_FIFO_BUFADR1            = 60101;          { ... }
const SPC_FIFO_BUFADR2            = 60102;          { ... }
const SPC_FIFO_BUFADR3            = 60103;          { ... }
const SPC_FIFO_BUFADR4            = 60104;          { ... }
const SPC_FIFO_BUFADR5            = 60105;          { ... }
const SPC_FIFO_BUFADR6            = 60106;          { ... }
const SPC_FIFO_BUFADR7            = 60107;          { ... }
const SPC_FIFO_BUFADR8            = 60108;          { ... }
const SPC_FIFO_BUFADR9            = 60109;          { ... }
const SPC_FIFO_BUFADR10           = 60110;          { ... }
const SPC_FIFO_BUFADR11           = 60111;          { ... }
const SPC_FIFO_BUFADR12           = 60112;          { ... }
const SPC_FIFO_BUFADR13           = 60113;          { ... }
const SPC_FIFO_BUFADR14           = 60114;          { ... }
const SPC_FIFO_BUFADR15           = 60115;          { ... }
const SPC_FIFO_BUFADR255          = 60355;          { last }



{ ----- Filter ----- }
const SPC_FILTER                  = 100000;
const SPC_READNUMFILTERS          = 100001;         { number of programable filters }
const SPC_FILTERFREQUENCY0        = 100002;         { frequency of filter 0 (bypass) }
const SPC_FILTERFREQUENCY1        = 100003;         { frequency of filter 1 }
const SPC_FILTERFREQUENCY2        = 100004;         { frequency of filter 2 }
const SPC_FILTERFREQUENCY3        = 100005;         { frequency of filter 3 }
const SPC_DIGITALBWFILTER         = 100100;         { enable/disable digital bandwith filter }


{ ----- Pattern ----- }
const SPC_PATTERNENABLE           = 110000;
const SPC_READDIGITAL             = 110100;

const SPC_DIGITALMODE0            = 110200;
const SPC_DIGITALMODE1            = 110201;
const SPC_DIGITALMODE2            = 110202;
const SPC_DIGITALMODE3            = 110203;
const SPC_DIGITALMODE4            = 110204;
const SPC_DIGITALMODE5            = 110205;
const SPC_DIGITALMODE6            = 110206;
const SPC_DIGITALMODE7            = 110207;
const     SPC_DIGITALMODE_OFF         = 0;
const     SPC_DIGITALMODE_2BIT        = 1;
const     SPC_DIGITALMODE_4BIT        = 2;
const     SPC_DIGITALMODE_CHREPLACE   = 3;


{ ----- Miscellanous ----- }
const SPC_MISCDAC0                = 200000;
const SPC_MISCDAC1                = 200010;
const SPC_FACTORYMODE             = 200020;
const SPC_DIRECTDAC               = 200030;
const SPC_NOTRIGSYNC              = 200040;
const SPC_DSPDIRECT               = 200100;
const SPC_DMAPHYSICALADR          = 200110;
const SPC_MICXCOMP_CLOSEBOARD     = 200119;
const SPC_MICXCOMPATIBILITYMODE   = 200120;
const SPC_TEST_FIFOSPEED          = 200121;
const SPC_RELOADDEMO              = 200122;
const SPC_OVERSAMPLINGFACTOR      = 200123;
const SPC_ISMAPPEDCARD            = 200124;
const     SPCM_NOT_MAPPED             = 0;
const     SPCM_LOCAL_MAPPED           = 1;
const     SPCM_REMOTE_MAPPED          = 2;
const SPC_GETTHREADHANDLE         = 200130;
const SPC_GETKERNELHANDLE         = 200131;
const SPC_XYZMODE                 = 200200;
const SPC_INVERTDATA              = 200300;
const SPC_GATEMARKENABLE          = 200400;
const SPC_GATE_LEN_ALIGNMENT      = 200401;
const SPC_CONTOUTMARK             = 200450;
const SPC_EXPANDINT32             = 200500;
const SPC_NOPRETRIGGER            = 200600;
const SPC_RELAISWAITTIME          = 200700;
const SPC_DACWAITTIME             = 200710;
const SPC_DELAY_US                = 200720;
const SPC_ILAMODE                 = 200800;
const SPC_NMDGMODE                = 200810;
const SPC_CKADHALF_OUTPUT         = 200820;
const SPC_LONGTRIG_OUTPUT         = 200830;
const SPC_STOREMODAENDOFSEGMENT   = 200840;
const SPC_COUNTERMODE             = 200850;
const     SPC_CNTMOD_MASK             = $0000000F;
const     SPC_CNTMOD_PARALLELDATA     = $00000000;
const     SPC_CNTMOD_8BITCNT          = $00000001;
const     SPC_CNTMOD_2x8BITCNT        = $00000002;
const     SPC_CNTMOD_16BITCNT         = $00000003;
const     SPC_CNT0_MASK               = $000000F0;
const     SPC_CNT0_CNTONPOSEDGE       = $00000000;
const     SPC_CNT0_CNTONNEGEDGE       = $00000010;
const     SPC_CNT0_RESETHIGHLVL       = $00000000;
const     SPC_CNT0_RESETLOWLVL        = $00000020;
const     SPC_CNT0_STOPATMAX          = $00000000;
const     SPC_CNT0_ROLLOVER           = $00000040;
const     SPC_CNT1_MASK               = $00000F00;
const     SPC_CNT1_CNTONPOSEDGE       = $00000000;
const     SPC_CNT1_CNTONNEGEDGE       = $00000100;
const     SPC_CNT1_RESETHIGHLVL       = $00000000;
const     SPC_CNT1_RESETLOWLVL        = $00000200;
const     SPC_CNT1_STOPATMAX          = $00000000;
const     SPC_CNT1_ROLLOVER           = $00000400;
const     SPC_CNTCMD_MASK             = $0000F000;
const     SPC_CNTCMD_RESETCNT0        = $00001000;
const     SPC_CNTCMD_RESETCNT1        = $00002000;
const SPC_ENHANCEDSTATUS          = 200900;
const     SPC_ENHSTAT_OVERRANGE0      = $00000001;
const     SPC_ENHSTAT_OVERRANGE1      = $00000002;
const     SPC_ENHSTAT_OVERRANGE2      = $00000004;
const     SPC_ENHSTAT_OVERRANGE3      = $00000008;
const     SPC_ENHSTAT_OVERRANGE4      = $00000010;
const     SPC_ENHSTAT_OVERRANGE5      = $00000020;
const     SPC_ENHSTAT_OVERRANGE6      = $00000040;
const     SPC_ENHSTAT_OVERRANGE7      = $00000080;
const     SPC_ENHSTAT_COMPARATOR0     = $40000000;
const     SPC_ENHSTAT_COMPARATOR1     = $80000000;
const     SPC_ENHSTAT_COMPARATOR2     = $20000000;
const     SPC_ENHSTAT_TRGCOMPARATOR   = $40000000;
const     SPC_ENHSTAT_CLKCOMPARATOR   = $80000000;
const SPC_TRIGGERCOUNTER          = 200905;
const SPC_FILLSIZEPROMILLE        = 200910;
const SPC_OVERRANGEBIT            = 201000;
const SPC_2CH8BITMODE             = 201100;
const SPC_12BITMODE               = 201200;
const SPC_HOLDLASTSAMPLE          = 201300;

const SPC_DATACONVERSION          = 201400;
const SPC_AVAILDATACONVERSION     = 201401;
const     SPCM_DC_NONE            = $00000000;
const     SPCM_DC_12BIT_TO_14BIT  = $00000001;
const     SPCM_DC_16BIT_TO_14BIT  = $00000002;
const     SPCM_DC_12BIT_TO_16BIT  = $00000004;
const     SPCM_DC_14BIT_TO_16BIT  = $00000008;
const     SPCM_DC_15BIT_TO_16BIT  = $00000010;
const     SPCM_DC_13BIT_TO_16BIT  = $00000020;
const     SPCM_DC_14BIT_TO_8BIT   = $00000100;
const     SPCM_DC_16BIT_TO_8BIT   = $00000200;
const     SPCM_DC_16BIT_TO_12BIT  = $00000400;
const     SPCM_DC_TO_OFFSETBINARY = $00000800;

const SPC_CARDIDENTIFICATION      = 201500;

const SPC_HANDSHAKE               = 201600;

const SPC_CKSYNC0                 = 202000;
const SPC_CKSYNC1                 = 202001;
const SPC_DISABLEMOD0             = 203000;
const SPC_DISABLEMOD1             = 203010;
const SPC_ENABLEOVERRANGECHECK    = 204000;
const SPC_OVERRANGESTATUS         = 204010;
const SPC_BITMODE                 = 205000;

const SPC_READBACK                = 206000;
const SPC_AVAILSTOPLEVEL          = 206009;
const SPC_STOPLEVEL1              = 206010;
const SPC_STOPLEVEL0              = 206020;
const SPC_CH0_STOPLEVEL           = 206020;
const SPC_CH1_STOPLEVEL           = 206021;
const SPC_CH2_STOPLEVEL           = 206022;
const SPC_CH3_STOPLEVEL           = 206023;
const SPC_CH4_STOPLEVEL           = 206024;
const SPC_CH5_STOPLEVEL           = 206025;
const SPC_CH6_STOPLEVEL           = 206026;
const SPC_CH7_STOPLEVEL           = 206027;
const     SPCM_STOPLVL_TRISTATE   = $00000001;
const     SPCM_STOPLVL_LOW        = $00000002;
const     SPCM_STOPLVL_HIGH       = $00000004;
const     SPCM_STOPLVL_HOLDLAST   = $00000008;
const     SPCM_STOPLVL_ZERO       = $00000010;
const     SPCM_STOPLVL_CUSTOM     = $00000020;

const SPC_DIFFMODE                = 206030;
const SPC_DACADJUST               = 206040;

const SPC_CH0_CUSTOM_STOP         = 206050;
const SPC_CH1_CUSTOM_STOP         = 206051;
const SPC_CH2_CUSTOM_STOP         = 206052;
const SPC_CH3_CUSTOM_STOP         = 206053;
const SPC_CH4_CUSTOM_STOP         = 206054;
const SPC_CH5_CUSTOM_STOP         = 206055;
const SPC_CH6_CUSTOM_STOP         = 206056;
const SPC_CH7_CUSTOM_STOP         = 206057;

const SPC_AMP_MODE                = 207000;

const SPCM_FW_CTRL                = 210000;
const SPCM_FW_CTRL_GOLDEN         = 210001;
const SPCM_FW_CTRL_ACTIVE         = 210002;
const SPCM_FW_CLOCK               = 210010;
const SPCM_FW_CONFIG              = 210020;
const SPCM_FW_MODULEA             = 210030;
const SPCM_FW_MODULEB             = 210031;
const SPCM_FW_MODULEA_ACTIVE      = 210032;
const SPCM_FW_MODULEB_ACTIVE      = 210033;
const SPCM_FW_MODEXTRA            = 210050;
const SPCM_FW_MODEXTRA_ACTIVE     = 210052;
const SPCM_FW_POWER               = 210060;
const SPCM_FW_POWER_ACTIVE        = 210062;

const SPC_MULTI                   = 220000;
const SPC_DOUBLEMEM               = 220100;
const SPC_MULTIMEMVALID           = 220200;
const SPC_BANK                    = 220300;
const SPC_GATE                    = 220400;
const SPC_RELOAD                  = 230000;
const SPC_USEROUT                 = 230010;
const SPC_WRITEUSER0              = 230100;
const SPC_WRITEUSER1              = 230110;
const SPC_READUSER0               = 230200;
const SPC_READUSER1               = 230210;
const SPC_MUX                     = 240000;
const SPC_ADJADC                  = 241000;
const SPC_ADJOFFS0                = 242000;
const SPC_ADJOFFS1                = 243000;
const SPC_ADJGAIN0                = 244000;
const SPC_ADJGAIN1                = 245000;
const SPC_READEPROM               = 250000;
const SPC_WRITEEPROM              = 250010;
const SPC_DIRECTIO                = 260000;
const SPC_DIRECT_MODA             = 260010;
const SPC_DIRECT_MODB             = 260020;
const SPC_DIRECT_EXT0             = 260030;
const SPC_DIRECT_EXT1             = 260031;
const SPC_DIRECT_EXT2             = 260032;
const SPC_DIRECT_EXT3             = 260033;
const SPC_DIRECT_EXT4             = 260034;
const SPC_DIRECT_EXT5             = 260035;
const SPC_DIRECT_EXT6             = 260036;
const SPC_DIRECT_EXT7             = 260037;
const SPC_MEMTEST                 = 270000;
const SPC_NODMA                   = 275000;
const SPC_NOCOUNTER               = 275010;
const SPC_NOSCATTERGATHER         = 275020;
const SPC_USER_RELAIS_OVERWRITE   = 275030;
const     SPCM_URO_ENABLE             = $80000000;
const     SPCM_URO_INVERT_10TO1REL    = $00000001;
const SPC_RUNINTENABLE            = 290000;
const SPC_XFERBUFSIZE             = 295000;
const SPC_CHLX                    = 295010;
const SPC_SPECIALCLOCK            = 295100;
const SPC_PLL0_ICP                = 295105;
const     SPCM_ICP0            = $00000000;
{ ... }
const     SPCM_ICP7            = $00000007;
const SPC_STARTDELAY              = 295110;
const SPC_BASISTTLTRIG            = 295120;
const SPC_TIMEOUT                 = 295130;
const SPC_SWL_INFO                = 295140;
const SPC_SWD_INFO                = 295141;
const SPC_SWD_DOWN                = 295142;
const SPC_SWL_EXTRAINFO           = 295143;
const SPC_SPECIALCLOCK_ADJUST0    = 295150;
const SPC_SPECIALCLOCK_ADJUST1    = 295151;
const SPC_SPECIALCLOCK_ADJUST2    = 295152;
const SPC_SPECIALCLOCK_ADJUST3    = 295153;
const    SPCM_SPECIALCLOCK_ADJUST_SHIFT = 1000000;
const SPC_REGACC_CONTMEM          = 299000;
const SPC_REGACC_MEMORYUSAGE      = 299001;
const SPC_REINITLOGSETTINGS       = 299998;
const SPC_LOGDLLCALLS             = 299999;






{ ----- PCK400 ----- }
const SPC_FREQUENCE               = 300000;
const SPC_DELTAFREQUENCE          = 300010;
const SPC_PINHIGH                 = 300100;
const SPC_PINLOW                  = 300110;
const SPC_PINDELTA                = 300120;
const SPC_STOPLEVEL               = 300200;
const SPC_PINRELAIS               = 300210;
const SPC_EXTERNLEVEL             = 300300;



{ ----- PADCO ----- }
const SPC_COUNTER0                = 310000;
const SPC_COUNTER1                = 310001;
const SPC_COUNTER2                = 310002;
const SPC_COUNTER3                = 310003;
const SPC_COUNTER4                = 310004;
const SPC_COUNTER5                = 310005;
const SPC_MODE0                   = 310100;
const SPC_MODE1                   = 310101;
const SPC_MODE2                   = 310102;
const SPC_MODE3                   = 310103;
const SPC_MODE4                   = 310104;
const SPC_MODE5                   = 310105;
const     CM_SINGLE                   = 1;
const     CM_MULTI                    = 2;
const     CM_POSEDGE                  = 4;
const     CM_NEGEDGE                  = 8;
const     CM_HIGHPULSE                = 16;
const     CM_LOWPULSE                 = 32;



{ ----- PAD1616 ----- }
const SPC_SEQUENCERESET           = 320000;
const SPC_SEQUENCEADD             = 320010;
const     SEQ_IR_10000MV              = 0;
const     SEQ_IR_5000MV               = 1;
const     SEQ_IR_2000MV               = 2;
const     SEQ_IR_1000MV               = 3;
const     SEQ_IR_500MV                = 4;
const     SEQ_CH0                     = 0;
const     SEQ_CH1                     = 8;
const     SEQ_CH2                     = 16;
const     SEQ_CH3                     = 24;
const     SEQ_CH4                     = 32;
const     SEQ_CH5                     = 40;
const     SEQ_CH6                     = 48;
const     SEQ_CH7                     = 56;
const     SEQ_CH8                     = 64;
const     SEQ_CH9                     = 72;
const     SEQ_CH10                    = 80;
const     SEQ_CH11                    = 88;
const     SEQ_CH12                    = 96;
const     SEQ_CH13                    = 104;
const     SEQ_CH14                    = 112;
const     SEQ_CH15                    = 120;
const     SEQ_TRIGGER                 = 128;
const     SEQ_START                   = 256;



{ ----- Option CA ----- }
const SPC_CA_MODE                 = 330000;
const     CAMODE_OFF                  = 0;
const     CAMODE_CDM                  = 1;
const     CAMODE_KW                   = 2;
const     CAMODE_OT                   = 3;
const     CAMODE_CDMMUL               = 4;
const SPC_CA_TRIGDELAY            = 330010;
const SPC_CA_CKDIV                = 330020;
const SPC_CA_PULS                 = 330030;
const SPC_CA_CKMUL                = 330040;
const SPC_CA_DREHZAHLFORMAT       = 330050;
const     CADREH_4X4                  = 0;
const     CADREH_1X16                 = 1;
const SPC_CA_KWINVERT             = 330060;
const SPC_CA_OUTA                 = 330100;
const SPC_CA_OUTB                 = 330110;
const     CAOUT_TRISTATE              = 0;
const     CAOUT_LOW                   = 1;
const     CAOUT_HIGH                  = 2;
const     CAOUT_CDM                   = 3;
const     CAOUT_OT                    = 4;
const     CAOUT_KW                    = 5;
const     CAOUT_TRIG                  = 6;
const     CAOUT_CLK                   = 7;
const     CAOUT_KW60                  = 8;
const     CAOUT_KWGAP                 = 9;
const     CAOUT_TRDLY                 = 10;
const     CAOUT_INVERT                = 16;


{ ----- Option Sequence Mode (output cards) ----- }
const SPC_SEQMODE_STEPMEM0        = 340000;
{ ...  }
const SPC_SEQMODE_STEPMEM8191     = 348191;

{ low part of 64 bit entry }
const     SPCSEQ_SEGMENTMASK      = $0000FFFF;
const     SPCSEQ_NEXTSTEPMASK     = $FFFF0000;

{ high part of 64 bit entry }
const     SPCSEQ_LOOPMASK         = $000FFFFF;
const     SPCSEQ_ENDLOOPALWAYS    = $00000000;
const     SPCSEQ_ENDLOOPONTRIG    = $40000000;
const     SPCSEQ_END              = $80000000;

const SPC_SEQMODE_AVAILMAXSEGMENT = 349900;
const SPC_SEQMODE_AVAILMAXSTEPS   = 349901;
const SPC_SEQMODE_AVAILMAXLOOP    = 349902;
const SPC_SEQMODE_AVAILFEATURES   = 349903;

const SPC_SEQMODE_MAXSEGMENTS     = 349910;
const SPC_SEQMODE_WRITESEGMENT    = 349920;
const SPC_SEQMODE_STARTSTEP       = 349930;
const SPC_SEQMODE_SEGMENTSIZE     = 349940;

const SPC_SEQMODE_STATUS          = 349950;
const     SEQSTAT_STEPCHANGE          = $80000000;


{ ----- netbox registers ----- }
const SPC_NETBOX_TYPE             = 400000;
const     NETBOX_SERIES_MASK      = $FF000000;
const     NETBOX_FAMILY_MASK      = $00FF0000;
const     NETBOX_SPEED_MASK       = $0000FF00;
const     NETBOX_CHANNEL_MASK     = $000000FF;

const     NETBOX_SERIES_DN2       = $02000000;
const     NETBOX_SERIES_DN6       = $06000000;

const     NETBOX_FAMILY_20        = $00200000;
const     NETBOX_FAMILY_22        = $00220000;
const     NETBOX_FAMILY_44        = $00440000;
const     NETBOX_FAMILY_46        = $00460000;
const     NETBOX_FAMILY_47        = $00470000;
const     NETBOX_FAMILY_48        = $00480000;
const     NETBOX_FAMILY_49        = $00490000;
const     NETBOX_FAMILY_59        = $00590000;
const     NETBOX_FAMILY_60        = $00600000;
const     NETBOX_FAMILY_65        = $00650000;
const     NETBOX_FAMILY_66        = $00660000;
const     NETBOX_FAMILY_8X        = $00800000;
const     NETBOX_FAMILY_80        = $00800000;
const     NETBOX_FAMILY_81        = $00810000;
const     NETBOX_FAMILY_82        = $00820000;
const     NETBOX_FAMILY_83        = $00830000;

const     NETBOX_SPEED_1          = $00000100;
const     NETBOX_SPEED_2          = $00000200;
const     NETBOX_SPEED_3          = $00000300;
const     NETBOX_SPEED_4          = $00000400;
const     NETBOX_SPEED_5          = $00000500;
const     NETBOX_SPEED_6          = $00000600;
const     NETBOX_SPEED_7          = $00000700;
const     NETBOX_SPEED_8          = $00000800;

const     NETBOX_CHANNELS_2       = $00000002;
const     NETBOX_CHANNELS_4       = $00000004;
const     NETBOX_CHANNELS_6       = $00000006;
const     NETBOX_CHANNELS_8       = $00000008;
const     NETBOX_CHANNELS_10      = $0000000A;
const     NETBOX_CHANNELS_12      = $0000000C;
const     NETBOX_CHANNELS_16      = $00000010;
const     NETBOX_CHANNELS_20      = $00000014;
const     NETBOX_CHANNELS_24      = $00000018;
const     NETBOX_CHANNELS_32      = $00000020;
const     NETBOX_CHANNELS_40      = $00000028;
const     NETBOX_CHANNELS_48      = $00000030;

const SPC_NETBOX_SERIALNO         = 400001;
const SPC_NETBOX_PRODUCTIONDATE   = 400002;
const SPC_NETBOX_HWVERSION        = 400003;
const SPC_NETBOX_SWVERSION        = 400004;

const SPC_NETBOX_FEATURES         = 400005;
const     NETBOX_FEAT_DCPOWER         = $1;
const     NETBOX_FEAT_BOOTATPOWERON   = $2;
const     NETBOX_FEAT_EMBEDDEDSERVER  = $4;

const SPC_NETBOX_CUSTOM           = 400006;

const SPC_NETBOX_WAKEONLAN        = 400007;
const SPC_NETBOX_MACADDRESS       = 400008;
const SPC_NETBOX_LANIDFLASH       = 400009;
const SPC_NETBOX_TEMPERATURE      = 400010;
const SPC_NETBOX_SHUTDOWN         = 400011;
const SPC_NETBOX_RESTART          = 400012;
const SPC_NETBOX_FANSPEED0        = 400013;
const SPC_NETBOX_FANSPEED1        = 400014;
const SPC_NETBOX_TEMPERATURE_K    = 400010; { same SPC_NETBOX_TEMPERATURE }
const SPC_NETBOX_TEMPERATURE_C    = 400015;
const SPC_NETBOX_TEMPERATURE_F    = 400016;

{ ----- hardware monitor registers ----- }
const SPC_MON_V_PCIE_BUS          = 500000;
const SPC_MON_V_CONNECTOR         = 500001;
const SPC_MON_CARD_PWRSOURCE      = 500002;
const     CARD_PWRSOURCE_BUS          = 0;
const     CARD_PWRSOURCE_CONNECTOR    = 1;
const SPC_MON_V_CARD_IN           = 500003;
const SPC_MON_I_CARD_IN           = 500004;
const SPC_MON_P_CARD_IN           = 500005;
const SPC_MON_V_3V3               = 500006;
const SPC_MON_V_2V5               = 500007;
const SPC_MON_V_CORE              = 500008;
const SPC_MON_V_AVTT              = 500009;
const SPC_MON_V_AVCC              = 500010;
const SPC_MON_V_MEMVCC            = 500011;
const SPC_MON_V_MEMVTT            = 500012;
const SPC_MON_V_CP_POS            = 500013;
const SPC_MON_V_CP_NEG            = 500014;

const SPC_MON_V_5VA               = 500015;
const SPC_MON_V_ADCA              = 500016;
const SPC_MON_V_ADCD              = 500017;
const SPC_MON_V_OP_POS            = 500018;
const SPC_MON_V_OP_NEG            = 500019;
const SPC_MON_V_COMP_NEG          = 500020;
const SPC_MON_V_COMP_POS          = 500021;

{ legacy temperature registers (Kelvin) }
const SPC_MON_T_BASE_CTRL         = 500022;
const SPC_MON_T_MODULE_0          = 500023;
const SPC_MON_T_MODULE_1          = 500024;

{ new temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF) }
const SPC_MON_TK_BASE_CTRL         = 500022;
const SPC_MON_TK_MODULE_0          = 500023;
const SPC_MON_TK_MODULE_1          = 500024;

const SPC_MON_TC_BASE_CTRL         = 500025;
const SPC_MON_TC_MODULE_0          = 500026;
const SPC_MON_TC_MODULE_1          = 500027;

const SPC_MON_TF_BASE_CTRL         = 500028;
const SPC_MON_TF_MODULE_0          = 500029;
const SPC_MON_TF_MODULE_1          = 500030;

{ some more voltages (used on M2p) }
const SPC_MON_V_1V8_BASE           = 500031;
const SPC_MON_V_1V8_MOD            = 500032;
const SPC_MON_V_MODA_0             = 500033;
const SPC_MON_V_MODA_1             = 500034;
const SPC_MON_V_MODB_0             = 500035;
const SPC_MON_V_MODB_1             = 500037;

{ some more voltages and temperatures (used on M2p.65xx-hv) }
const SPC_MON_TK_MODA_0           = 500023; { same as SPC_MON_TK_MODULE_0 }
const SPC_MON_TK_MODA_1           = 500038;
const SPC_MON_TK_MODA_2           = 500039;
const SPC_MON_TK_MODA_3           = 500040;
const SPC_MON_TK_MODA_4           = 500041;
const SPC_MON_TK_MODB_0           = 500024; { same as SPC_MON_TK_MODULE_1 }
const SPC_MON_TK_MODB_1           = 500042;
const SPC_MON_TK_MODB_2           = 500043;
const SPC_MON_TK_MODB_3           = 500044;
const SPC_MON_TK_MODB_4           = 500045;

const SPC_MON_TC_MODA_0           = 500026; { same as SPC_MON_TC_MODULE_0 }
const SPC_MON_TC_MODA_1           = 500046;
const SPC_MON_TC_MODA_2           = 500047;
const SPC_MON_TC_MODA_3           = 500048;
const SPC_MON_TC_MODA_4           = 500049;
const SPC_MON_TC_MODB_0           = 500027; { same as SPC_MON_TC_MODULE_1 }
const SPC_MON_TC_MODB_1           = 500050;
const SPC_MON_TC_MODB_2           = 500051;
const SPC_MON_TC_MODB_3           = 500052;
const SPC_MON_TC_MODB_4           = 500053;

const SPC_MON_TF_MODA_0           = 500029; { same as SPC_MON_TF_MODULE_0 }
const SPC_MON_TF_MODA_1           = 500054;
const SPC_MON_TF_MODA_2           = 500055;
const SPC_MON_TF_MODA_3           = 500056;
const SPC_MON_TF_MODA_4           = 500057;
const SPC_MON_TF_MODB_0           = 500030; { same as SPC_MON_TF_MODULE_1 }
const SPC_MON_TF_MODB_1           = 500058;
const SPC_MON_TF_MODB_2           = 500059;
const SPC_MON_TF_MODB_3           = 500060;
const SPC_MON_TF_MODB_4           = 500061;

const SPC_MON_I_MODA_0            = 500062;
const SPC_MON_I_MODA_1            = 500063;
const SPC_MON_I_MODA_2            = 500064;
const SPC_MON_I_MODA_3            = 500065;
const SPC_MON_I_MODB_0            = 500066;
const SPC_MON_I_MODB_1            = 500067;
const SPC_MON_I_MODB_2            = 500068;
const SPC_MON_I_MODB_3            = 500069;

const SPC_MON_MOD_FAULT           = 500070;
const SPC_CLR_MOD_FAULT           = 500071;

{ power section temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF) }
const SPC_MON_TK_MODA_5           = 500072;
const SPC_MON_TK_MODB_5           = 500073;

const SPC_MON_TC_MODA_5           = 500074;
const SPC_MON_TC_MODB_5           = 500075;

const SPC_MON_TF_MODA_5           = 500076;
const SPC_MON_TF_MODB_5           = 500077;

{ mask with available monitor registers }
const SPC_AVAILMONITORS            = 510000;
const     SPCM_MON_T_BASE_CTRL        = $0000000000000001UL;
const     SPCM_MON_T_MODULE_0         = $0000000000000002UL;
const     SPCM_MON_T_MODULE_1         = $0000000000000004UL;

const     SPCM_MON_V_PCIE_BUS         = $0000000000000010UL;
const     SPCM_MON_V_CONNECTOR        = $0000000000000020UL;
const     SPCM_MON_CARD_PWRSOURCE     = $0000000000000040UL;
const     SPCM_MON_V_CARD_IN          = $0000000000000080UL;
const     SPCM_MON_I_CARD_IN          = $0000000000000100UL;
const     SPCM_MON_P_CARD_IN          = $0000000000000200UL;
const     SPCM_MON_V_3V3              = $0000000000000400UL;
const     SPCM_MON_V_2V5              = $0000000000000800UL;
const     SPCM_MON_V_CORE             = $0000000000001000UL;
const     SPCM_MON_V_AVTT             = $0000000000002000UL;
const     SPCM_MON_V_AVCC             = $0000000000004000UL;
const     SPCM_MON_V_MEMVCC           = $0000000000008000UL;
const     SPCM_MON_V_MEMVTT           = $0000000000010000UL;
const     SPCM_MON_V_CP_POS           = $0000000000020000UL;
const     SPCM_MON_V_CP_NEG           = $0000000000040000UL;
const     SPCM_MON_V_5VA              = $0000000000080000UL;
const     SPCM_MON_V_ADCA             = $0000000000100000UL;
const     SPCM_MON_V_ADCD             = $0000000000200000UL;
const     SPCM_MON_V_OP_POS           = $0000000000400000UL;
const     SPCM_MON_V_OP_NEG           = $0000000000800000UL;
const     SPCM_MON_V_COMP_NEG         = $0000000001000000UL;
const     SPCM_MON_V_COMP_POS         = $0000000002000000UL;
const     SPCM_MON_V_1V8_BASE         = $0000000004000000UL;
const     SPCM_MON_V_1V8_MOD          = $0000000008000000UL;

const     SPCM_MON_V_MODA_0           = $0000000010000000UL;
const     SPCM_MON_V_MODA_1           = $0000000020000000UL;
const     SPCM_MON_V_MODB_0           = $0000000040000000UL;
const     SPCM_MON_V_MODB_1           = $0000000080000000UL;

const     SPCM_MON_T_MODA_0           = $0000000000000002UL; { same as SPCM_MON_T_MODULE_0 }
const     SPCM_MON_T_MODA_1           = $0000000100000000UL;
const     SPCM_MON_T_MODA_2           = $0000000200000000UL;
const     SPCM_MON_T_MODA_3           = $0000000400000000UL;
const     SPCM_MON_T_MODA_4           = $0000000800000000UL;
const     SPCM_MON_T_MODB_0           = $0000000000000004UL; { same as SPCM_MON_T_MODULE_1 }
const     SPCM_MON_T_MODB_1           = $0000001000000000UL;
const     SPCM_MON_T_MODB_2           = $0000002000000000UL;
const     SPCM_MON_T_MODB_3           = $0000004000000000UL;
const     SPCM_MON_T_MODB_4           = $0000008000000000UL;

const     SPCM_MON_I_MODA_0           = $0000010000000000UL;
const     SPCM_MON_I_MODA_1           = $0000020000000000UL;
const     SPCM_MON_I_MODA_2           = $0000040000000000UL;
const     SPCM_MON_I_MODA_3           = $0000080000000000UL;
const     SPCM_MON_I_MODB_0           = $0000100000000000UL;
const     SPCM_MON_I_MODB_1           = $0000200000000000UL;
const     SPCM_MON_I_MODB_2           = $0000300000000000UL;
const     SPCM_MON_I_MODB_3           = $0000400000000000UL;

const     SPCM_MON_T_MODA_5           = $0000800000000000UL;
const     SPCM_MON_T_MODB_5           = $0001000000000000UL;


{ ----- re-located multi-purpose i/o related registers ----- }
const SPC_X0_READFEATURES         = 600000;
const SPC_X1_READFEATURES         = 600001;
const SPC_X2_READFEATURES         = 600002;
const SPC_X3_READFEATURES         = 600003;
const SPC_X4_READFEATURES         = 600004;
const SPC_X5_READFEATURES         = 600005;
const SPC_X6_READFEATURES         = 600006;
const SPC_X7_READFEATURES         = 600007;
const SPC_X8_READFEATURES         = 600008;
const SPC_X9_READFEATURES         = 600009;
const SPC_X10_READFEATURES        = 600010;
const SPC_X11_READFEATURES        = 600011;
const SPC_X12_READFEATURES        = 600012;
const SPC_X13_READFEATURES        = 600013;
const SPC_X14_READFEATURES        = 600014;
const SPC_X15_READFEATURES        = 600015;
const SPC_X16_READFEATURES        = 600016;
const SPC_X17_READFEATURES        = 600017;
const SPC_X18_READFEATURES        = 600018;
const SPC_X19_READFEATURES        = 600019;
const     SPCM_XFEAT_TERM             = $00000001;
const     SPCM_XFEAT_HIGHIMP          = $00000002;
const     SPCM_XFEAT_DCCOUPLING       = $00000004;
const     SPCM_XFEAT_ACCOUPLING       = $00000008;
const     SPCM_XFEAT_SE               = $00000010;
const     SPCM_XFEAT_DIFF             = $00000020;
const     SPCM_XFEAT_PROGTHRESHOLD    = $00000040;

const SPC_X0_TERM                = 600100;
const SPC_X1_TERM                = 600101;
const SPC_X2_TERM                = 600102;
const SPC_X3_TERM                = 600103;
const SPC_X4_TERM                = 600104;
const SPC_X5_TERM                = 600105;
const SPC_X6_TERM                = 600106;
const SPC_X7_TERM                = 600107;
const SPC_X8_TERM                = 600108;
const SPC_X9_TERM                = 600109;
const SPC_X10_TERM               = 600110;
const SPC_X11_TERM               = 600111;
const SPC_X12_TERM               = 600112;
const SPC_X13_TERM               = 600113;
const SPC_X14_TERM               = 600114;
const SPC_X15_TERM               = 600115;
const SPC_X16_TERM               = 600116;
const SPC_X17_TERM               = 600117;
const SPC_X18_TERM               = 600118;
const SPC_X19_TERM               = 600119;

const SPCM_X0_MODE                = 600200;
const SPCM_X1_MODE                = 600201;
const SPCM_X2_MODE                = 600202;
const SPCM_X3_MODE                = 600203;
const SPCM_X4_MODE                = 600204;
const SPCM_X5_MODE                = 600205;
const SPCM_X6_MODE                = 600206;
const SPCM_X7_MODE                = 600207;
const SPCM_X8_MODE                = 600208;
const SPCM_X9_MODE                = 600209;
const SPCM_X10_MODE               = 600210;
const SPCM_X11_MODE               = 600211;
const SPCM_X12_MODE               = 600212;
const SPCM_X13_MODE               = 600213;
const SPCM_X14_MODE               = 600214;
const SPCM_X15_MODE               = 600215;
const SPCM_X16_MODE               = 600216;
const SPCM_X17_MODE               = 600217;
const SPCM_X18_MODE               = 600218;
const SPCM_X19_MODE               = 600219;

const SPCM_X0_AVAILMODES          = 600300;
const SPCM_X1_AVAILMODES          = 600301;
const SPCM_X2_AVAILMODES          = 600302;
const SPCM_X3_AVAILMODES          = 600303;
const SPCM_X4_AVAILMODES          = 600304;
const SPCM_X5_AVAILMODES          = 600305;
const SPCM_X6_AVAILMODES          = 600306;
const SPCM_X7_AVAILMODES          = 600307;
const SPCM_X8_AVAILMODES          = 600308;
const SPCM_X9_AVAILMODES          = 600309;
const SPCM_X10_AVAILMODES         = 600310;
const SPCM_X11_AVAILMODES         = 600311;
const SPCM_X12_AVAILMODES         = 600312;
const SPCM_X13_AVAILMODES         = 600313;
const SPCM_X14_AVAILMODES         = 600314;
const SPCM_X15_AVAILMODES         = 600315;
const SPCM_X16_AVAILMODES         = 600316;
const SPCM_X17_AVAILMODES         = 600317;
const SPCM_X18_AVAILMODES         = 600318;
const SPCM_X19_AVAILMODES         = 600319;
{ for definitions of the available modes see section at SPCM_LEGACY_X0_MODE above }


{ ----- Hardware registers (debug use only) ----- }
const SPC_REG0x00                 = 900000;
const SPC_REG0x02                 = 900010;
const SPC_REG0x04                 = 900020;
const SPC_REG0x06                 = 900030;
const SPC_REG0x08                 = 900040;
const SPC_REG0x0A                 = 900050;
const SPC_REG0x0C                 = 900060;
const SPC_REG0x0E                 = 900070;

const SPC_DEBUGREG0               = 900100;
const SPC_DEBUGREG15              = 900115;
const SPC_DEBUGVALUE0             = 900200;
const SPC_DEBUGVALUE15            = 900215;

const SPC_MI_ISP                  = 901000;
const     ISP_TMS_0                   = 0;
const     ISP_TMS_1                   = 1;
const     ISP_TDO_0                   = 0;
const     ISP_TDO_1                   = 2;


const SPC_EE_RWAUTH               = 901100;
const SPC_EE_REG                  = 901110;
const SPC_EE_RESETCOUNTER         = 901120;

{ ----- Test Registers ----- }
const SPC_TEST_BASE               = 902000;
const SPC_TEST_LOCAL_START        = 902100;
const SPC_TEST_LOCAL_END          = 902356;
const SPC_TEST_PLX_START          = 902400;
const SPC_TEST_PLX_END            = 902656;

{ 9012xx not usable }
{ 901900 not usable }
{ 903000 not usable }
{ 91xxxx not usable }

{ ----- used by GetErrorInfo to mark errors in other functions than SetParam/GetParam ----- }
const SPC_FUNCTION_DEFTRANSFER = 100000000;


implementation

end.