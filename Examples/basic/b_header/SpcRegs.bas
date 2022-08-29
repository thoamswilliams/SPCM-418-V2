Attribute VB_Name = "regs"
' Spectrum C/C++ header file -> Basic file converter
' Source file:
' ***********************************************************************
'
' regs.h                                          (c) Spectrum GmbH, 2006
'
' ***********************************************************************
'
' software register and constants definition for all Spectrum drivers. 
' Please stick to the card manual to see which of the inhere defined 
' registers are used on your hardware.
'
' ***********************************************************************



' ***********************************************************************
' macros for kilo, Mega or Giga as standard version or binary (_B) (2^x)
' ***********************************************************************





' ***********************************************************************
' card types
' ***********************************************************************

Public Const TYP_PCIDEVICEID             = &H00000000&

' ***** Board Types ***************
Public Const TYP_EVAL                    = &H00000010&
Public Const TYP_RSDLGA                  = &H00000014&
Public Const TYP_GMG                     = &H00000018&
Public Const TYP_VAN8                    = &H00000020&
Public Const TYP_VAC                     = &H00000028&

Public Const TYP_PCIAUTOINSTALL          = &H000000FF&

Public Const TYP_DAP116                  = &H00000100&
Public Const TYP_PAD82                   = &H00000200&
Public Const TYP_PAD82a                  = &H00000210&
Public Const TYP_PAD82b                  = &H00000220&
Public Const TYP_PCI212                  = &H00000300&
Public Const TYP_PAD1232a                = &H00000400&
Public Const TYP_PAD1232b                = &H00000410&
Public Const TYP_PAD1232c                = &H00000420&
Public Const TYP_PAD1616a                = &H00000500&
Public Const TYP_PAD1616b                = &H00000510&
Public Const TYP_PAD1616c                = &H00000520&
Public Const TYP_PAD1616d                = &H00000530&
Public Const TYP_PAD52                   = &H00000600&
Public Const TYP_PAD242                  = &H00000700&
Public Const TYP_PCK400                  = &H00000800&
Public Const TYP_PAD164_2M               = &H00000900&
Public Const TYP_PAD164_5M               = &H00000910&
Public Const TYP_PCI208                  = &H00001000&
Public Const TYP_CPCI208                 = &H00001001&
Public Const TYP_PCI412                  = &H00001100&
Public Const TYP_PCIDIO32                = &H00001200&
Public Const TYP_PCI248                  = &H00001300&
Public Const TYP_PADCO                   = &H00001400&
Public Const TYP_TRS582                  = &H00001500&
Public Const TYP_PCI258                  = &H00001600&


' ------ series and familiy identifiers -----
Public Const TYP_SERIESMASK              = &H00FF0000&     ' the series (= type of base card), e.g. MI.xxxx
Public Const TYP_VERSIONMASK             = &H0000FFFF&     ' the version, e.g. XX.3012
Public Const TYP_FAMILYMASK              = &H0000FF00&     ' the family, e.g. XX.30xx
Public Const TYP_TYPEMASK                = &H000000FF&     ' the type, e.g. XX.xx12
Public Const TYP_SPEEDMASK               = &H000000F0&     ' the speed grade, e.g. XX.xx1x
Public Const TYP_CHMASK                  = &H0000000F&     ' the channel/modules, e.g. XX.xxx2

Public Const TYP_MISERIES                = &H00000000&
Public Const TYP_MCSERIES                = &H00010000&
Public Const TYP_MXSERIES                = &H00020000&
Public Const TYP_M2ISERIES               = &H00030000&
Public Const TYP_M2IEXPSERIES            = &H00040000&
Public Const TYP_M3ISERIES               = &H00050000&
Public Const TYP_M3IEXPSERIES            = &H00060000&
Public Const TYP_M4IEXPSERIES            = &H00070000&
Public Const TYP_M4XEXPSERIES            = &H00080000&
Public Const TYP_M2PEXPSERIES            = &H00090000&



' ----- MI.20xx, MC.20xx, MX.20xx -----
Public Const TYP_MI2020                  = &H00002020&
Public Const TYP_MI2021                  = &H00002021&
Public Const TYP_MI2025                  = &H00002025&
Public Const TYP_MI2030                  = &H00002030&
Public Const TYP_MI2031                  = &H00002031&

Public Const TYP_M2I2020                 = &H00032020&
Public Const TYP_M2I2021                 = &H00032021&
Public Const TYP_M2I2025                 = &H00032025&
Public Const TYP_M2I2030                 = &H00032030&
Public Const TYP_M2I2031                 = &H00032031&

Public Const TYP_M2I2020EXP              = &H00042020&
Public Const TYP_M2I2021EXP              = &H00042021&
Public Const TYP_M2I2025EXP              = &H00042025&
Public Const TYP_M2I2030EXP              = &H00042030&
Public Const TYP_M2I2031EXP              = &H00042031&

Public Const TYP_MC2020                  = &H00012020&
Public Const TYP_MC2021                  = &H00012021&
Public Const TYP_MC2025                  = &H00012025&
Public Const TYP_MC2030                  = &H00012030&
Public Const TYP_MC2031                  = &H00012031&

Public Const TYP_MX2020                  = &H00022020&
Public Const TYP_MX2025                  = &H00022025&
Public Const TYP_MX2030                  = &H00022030&

' ----- M3i.21xx, M3i.21xx-Exp (8 bit A/D) -----
Public Const TYP_M3I2120                 = &H00052120&     ' 1x500M
Public Const TYP_M3I2122                 = &H00052122&     ' 1x500M & 2x250M
Public Const TYP_M3I2130                 = &H00052130&     ' 1x1G
Public Const TYP_M3I2132                 = &H00052132&     ' 1x1G & 2x500M

Public Const TYP_M3I2120EXP              = &H00062120&     ' 1x500M
Public Const TYP_M3I2122EXP              = &H00062122&     ' 1x500M & 2x250M
Public Const TYP_M3I2130EXP              = &H00062130&     ' 1x1G
Public Const TYP_M3I2132EXP              = &H00062132&     ' 1x1G & 2x500M

' ----- M4i.22xx-x8 (8 bit A/D) -----
Public Const TYP_M4I22XX_X8              = &H00072200&
Public Const TYP_M4I2210_X8              = &H00072210&     ' 1x1.25G
Public Const TYP_M4I2211_X8              = &H00072211&     ' 2x1.25G
Public Const TYP_M4I2212_X8              = &H00072212&     ' 4x1.25G
Public Const TYP_M4I2220_X8              = &H00072220&     ' 1x2.5G
Public Const TYP_M4I2221_X8              = &H00072221&     ' 2x2.5G
Public Const TYP_M4I2223_X8              = &H00072223&     ' 1x2.5G & 2x1.25G
Public Const TYP_M4I2230_X8              = &H00072230&     ' 1x5G
Public Const TYP_M4I2233_X8              = &H00072233&     ' 1x5G & 2x2.5G 
Public Const TYP_M4I2234_X8              = &H00072234&     ' 1x5G & 2x2.5G & 4x1.25G
Public Const TYP_M4I2280_X8              = &H00072280&     ' customer specific variant
Public Const TYP_M4I2281_X8              = &H00072281&     ' customer specific variant
Public Const TYP_M4I2283_X8              = &H00072283&     ' customer specific variant
Public Const TYP_M4I2290_X8              = &H00072290&     ' customer specific variant
Public Const TYP_M4I2293_X8              = &H00072293&     ' customer specific variant
Public Const TYP_M4I2294_X8              = &H00072294&     ' customer specific variant

' ----- M4x.22xx-x8 (8 bit A/D) -----
Public Const TYP_M4X22XX_X4              = &H00082200&
Public Const TYP_M4X2210_X4              = &H00082210&     ' 1x1.25G
Public Const TYP_M4X2211_X4              = &H00082211&     ' 2x1.25G
Public Const TYP_M4X2212_X4              = &H00082212&     ' 4x1.25G
Public Const TYP_M4X2220_X4              = &H00082220&     ' 1x2.5G
Public Const TYP_M4X2221_X4              = &H00082221&     ' 2x2.5G
Public Const TYP_M4X2223_X4              = &H00082223&     ' 1x2.5G & 2x1.25G
Public Const TYP_M4X2230_X4              = &H00082230&     ' 1x5G
Public Const TYP_M4X2233_X4              = &H00082233&     ' 1x5G & 2x2.5G 
Public Const TYP_M4X2234_X4              = &H00082234&     ' 1x5G & 2x2.5G & 4x1.25G

' ----- M4i.23xx-x8 (7 bit A/D) -----
Public Const TYP_M4I23XX_X8              = &H00072300&
Public Const TYP_M4I2320_X8              = &H00072320&     ' 1x2.5G
Public Const TYP_M4I2321_X8              = &H00072321&     ' 2x2.5G
Public Const TYP_M4I2323_X8              = &H00072323&     ' 1x2.5G & 2x1.25G
Public Const TYP_M4I2330_X8              = &H00072330&     ' 1x5G
Public Const TYP_M4I2333_X8              = &H00072333&     ' 1x5G & 2x2.5G 
Public Const TYP_M4I2334_X8              = &H00072334&     ' 1x5G & 2x2.5G & 4x1.25G

' ----- MI.30xx, MC.30xx, MX.30xx -----
Public Const TYP_MI3010                  = &H00003010&
Public Const TYP_MI3011                  = &H00003011&
Public Const TYP_MI3012                  = &H00003012&
Public Const TYP_MI3013                  = &H00003013&
Public Const TYP_MI3014                  = &H00003014&
Public Const TYP_MI3015                  = &H00003015&
Public Const TYP_MI3016                  = &H00003016&
Public Const TYP_MI3020                  = &H00003020&
Public Const TYP_MI3021                  = &H00003021&
Public Const TYP_MI3022                  = &H00003022&
Public Const TYP_MI3023                  = &H00003023&
Public Const TYP_MI3024                  = &H00003024&
Public Const TYP_MI3025                  = &H00003025&
Public Const TYP_MI3026                  = &H00003026&
Public Const TYP_MI3027                  = &H00003027&
Public Const TYP_MI3031                  = &H00003031&
Public Const TYP_MI3033                  = &H00003033&

Public Const TYP_M2I3010                 = &H00033010&
Public Const TYP_M2I3011                 = &H00033011&
Public Const TYP_M2I3012                 = &H00033012&
Public Const TYP_M2I3013                 = &H00033013&
Public Const TYP_M2I3014                 = &H00033014&
Public Const TYP_M2I3015                 = &H00033015&
Public Const TYP_M2I3016                 = &H00033016&
Public Const TYP_M2I3020                 = &H00033020&
Public Const TYP_M2I3021                 = &H00033021&
Public Const TYP_M2I3022                 = &H00033022&
Public Const TYP_M2I3023                 = &H00033023&
Public Const TYP_M2I3024                 = &H00033024&
Public Const TYP_M2I3025                 = &H00033025&
Public Const TYP_M2I3026                 = &H00033026&
Public Const TYP_M2I3027                 = &H00033027&
Public Const TYP_M2I3031                 = &H00033031&
Public Const TYP_M2I3033                 = &H00033033&

Public Const TYP_M2I3010EXP              = &H00043010&
Public Const TYP_M2I3011EXP              = &H00043011&
Public Const TYP_M2I3012EXP              = &H00043012&
Public Const TYP_M2I3013EXP              = &H00043013&
Public Const TYP_M2I3014EXP              = &H00043014&
Public Const TYP_M2I3015EXP              = &H00043015&
Public Const TYP_M2I3016EXP              = &H00043016&
Public Const TYP_M2I3020EXP              = &H00043020&
Public Const TYP_M2I3021EXP              = &H00043021&
Public Const TYP_M2I3022EXP              = &H00043022&
Public Const TYP_M2I3023EXP              = &H00043023&
Public Const TYP_M2I3024EXP              = &H00043024&
Public Const TYP_M2I3025EXP              = &H00043025&
Public Const TYP_M2I3026EXP              = &H00043026&
Public Const TYP_M2I3027EXP              = &H00043027&
Public Const TYP_M2I3031EXP              = &H00043031&
Public Const TYP_M2I3033EXP              = &H00043033&

Public Const TYP_MC3010                  = &H00013010&
Public Const TYP_MC3011                  = &H00013011&
Public Const TYP_MC3012                  = &H00013012&
Public Const TYP_MC3013                  = &H00013013&
Public Const TYP_MC3014                  = &H00013014&
Public Const TYP_MC3015                  = &H00013015&
Public Const TYP_MC3016                  = &H00013016&
Public Const TYP_MC3020                  = &H00013020&
Public Const TYP_MC3021                  = &H00013021&
Public Const TYP_MC3022                  = &H00013022&
Public Const TYP_MC3023                  = &H00013023&
Public Const TYP_MC3024                  = &H00013024&
Public Const TYP_MC3025                  = &H00013025&
Public Const TYP_MC3026                  = &H00013026&
Public Const TYP_MC3027                  = &H00013027&
Public Const TYP_MC3031                  = &H00013031&
Public Const TYP_MC3033                  = &H00013033&

Public Const TYP_MX3010                  = &H00023010&
Public Const TYP_MX3011                  = &H00023011&
Public Const TYP_MX3012                  = &H00023012&
Public Const TYP_MX3020                  = &H00023020&
Public Const TYP_MX3021                  = &H00023021&
Public Const TYP_MX3022                  = &H00023022&
Public Const TYP_MX3031                  = &H00023031&



' ----- MI.31xx, MC.31xx, MX.31xx -----
Public Const TYP_MI3110                  = &H00003110&
Public Const TYP_MI3111                  = &H00003111&
Public Const TYP_MI3112                  = &H00003112&
Public Const TYP_MI3120                  = &H00003120&
Public Const TYP_MI3121                  = &H00003121&
Public Const TYP_MI3122                  = &H00003122&
Public Const TYP_MI3130                  = &H00003130&
Public Const TYP_MI3131                  = &H00003131&
Public Const TYP_MI3132                  = &H00003132&
Public Const TYP_MI3140                  = &H00003140&

Public Const TYP_M2I3110                 = &H00033110&
Public Const TYP_M2I3111                 = &H00033111&
Public Const TYP_M2I3112                 = &H00033112&
Public Const TYP_M2I3120                 = &H00033120&
Public Const TYP_M2I3121                 = &H00033121&
Public Const TYP_M2I3122                 = &H00033122&
Public Const TYP_M2I3130                 = &H00033130&
Public Const TYP_M2I3131                 = &H00033131&
Public Const TYP_M2I3132                 = &H00033132&

Public Const TYP_M2I3110EXP              = &H00043110&
Public Const TYP_M2I3111EXP              = &H00043111&
Public Const TYP_M2I3112EXP              = &H00043112&
Public Const TYP_M2I3120EXP              = &H00043120&
Public Const TYP_M2I3121EXP              = &H00043121&
Public Const TYP_M2I3122EXP              = &H00043122&
Public Const TYP_M2I3130EXP              = &H00043130&
Public Const TYP_M2I3131EXP              = &H00043131&
Public Const TYP_M2I3132EXP              = &H00043132&

Public Const TYP_MC3110                  = &H00013110&
Public Const TYP_MC3111                  = &H00013111&
Public Const TYP_MC3112                  = &H00013112&
Public Const TYP_MC3120                  = &H00013120&
Public Const TYP_MC3121                  = &H00013121&
Public Const TYP_MC3122                  = &H00013122&
Public Const TYP_MC3130                  = &H00013130&
Public Const TYP_MC3131                  = &H00013131&
Public Const TYP_MC3132                  = &H00013132&

Public Const TYP_MX3110                  = &H00023110&
Public Const TYP_MX3111                  = &H00023111&
Public Const TYP_MX3120                  = &H00023120&
Public Const TYP_MX3121                  = &H00023121&
Public Const TYP_MX3130                  = &H00023130&
Public Const TYP_MX3131                  = &H00023131&



' ----- M3i.32xx, M3i.32xx-Exp (12 bit A/D) -----
Public Const TYP_M3I3220                 = &H00053220&     ' 1x250M
Public Const TYP_M3I3221                 = &H00053221&     ' 2x250M
Public Const TYP_M3I3240                 = &H00053240&     ' 1x500M
Public Const TYP_M3I3242                 = &H00053242&     ' 1x500M & 2x250M

Public Const TYP_M3I3220EXP              = &H00063220&     ' 1x250M
Public Const TYP_M3I3221EXP              = &H00063221&     ' 2x250M
Public Const TYP_M3I3240EXP              = &H00063240&     ' 1x500M
Public Const TYP_M3I3242EXP              = &H00063242&     ' 1x500M & 2x250M



' ----- MI.40xx, MC.40xx, MX.40xx -----
Public Const TYP_MI4020                  = &H00004020&
Public Const TYP_MI4021                  = &H00004021&
Public Const TYP_MI4022                  = &H00004022&
Public Const TYP_MI4030                  = &H00004030&
Public Const TYP_MI4031                  = &H00004031&
Public Const TYP_MI4032                  = &H00004032&

Public Const TYP_M2I4020                 = &H00034020&
Public Const TYP_M2I4021                 = &H00034021&
Public Const TYP_M2I4022                 = &H00034022&
Public Const TYP_M2I4028                 = &H00034028&
Public Const TYP_M2I4030                 = &H00034030&
Public Const TYP_M2I4031                 = &H00034031&
Public Const TYP_M2I4032                 = &H00034032&
Public Const TYP_M2I4038                 = &H00034038&

Public Const TYP_M2I4020EXP              = &H00044020&
Public Const TYP_M2I4021EXP              = &H00044021&
Public Const TYP_M2I4022EXP              = &H00044022&
Public Const TYP_M2I4028EXP              = &H00044028&
Public Const TYP_M2I4030EXP              = &H00044030&
Public Const TYP_M2I4031EXP              = &H00044031&
Public Const TYP_M2I4032EXP              = &H00044032&
Public Const TYP_M2I4038EXP              = &H00044038&

Public Const TYP_MC4020                  = &H00014020&
Public Const TYP_MC4021                  = &H00014021&
Public Const TYP_MC4022                  = &H00014022&
Public Const TYP_MC4030                  = &H00014030&
Public Const TYP_MC4031                  = &H00014031&
Public Const TYP_MC4032                  = &H00014032&

Public Const TYP_MX4020                  = &H00024020&
Public Const TYP_MX4021                  = &H00024021&
Public Const TYP_MX4030                  = &H00024030&
Public Const TYP_MX4031                  = &H00024031&



' ----- M3i.41xx, M3i.41xx-Exp (14 bit A/D) -----
Public Const TYP_M3I4110                 = &H00054110&     ' 1x100M
Public Const TYP_M3I4111                 = &H00054111&     ' 2x100M
Public Const TYP_M3I4120                 = &H00054120&     ' 1x250M
Public Const TYP_M3I4121                 = &H00054121&     ' 2x250M
Public Const TYP_M3I4140                 = &H00054140&     ' 1x400M
Public Const TYP_M3I4142                 = &H00054142&     ' 1x400M & 2x250M

Public Const TYP_M3I4110EXP              = &H00064110&     ' 1x100M
Public Const TYP_M3I4111EXP              = &H00064111&     ' 2x100M
Public Const TYP_M3I4120EXP              = &H00064120&     ' 1x250M
Public Const TYP_M3I4121EXP              = &H00064121&     ' 2x250M
Public Const TYP_M3I4140EXP              = &H00064140&     ' 1x400M
Public Const TYP_M3I4142EXP              = &H00064142&     ' 1x400M & 2x250M

' ----- M4i.44xx-x8 (generic) -----
Public Const TYP_M4I44XX_X8              = &H00074400&      ' 

Public Const TYP_M4I4410_X8              = &H00074410&      ' 2x130M 16bit
Public Const TYP_M4I4411_X8              = &H00074411&      ' 4x130M 16bit
Public Const TYP_M4I4420_X8              = &H00074420&      ' 2x250M 16bit
Public Const TYP_M4I4421_X8              = &H00074421&      ' 4x250M 16bit
Public Const TYP_M4I4450_X8              = &H00074450&      ' 2x500M 14bit
Public Const TYP_M4I4451_X8              = &H00074451&      ' 4x500M 14bit
Public Const TYP_M4I4470_X8              = &H00074470&      ' 2x180M 16bit
Public Const TYP_M4I4471_X8              = &H00074471&      ' 4x180M 16bit
Public Const TYP_M4I4480_X8              = &H00074480&      ' 2x400M 14bit
Public Const TYP_M4I4481_X8              = &H00074481&      ' 4x400M 14bit

' ----- M4x.44xx-x4 (14/16 bit A/D) -----
Public Const TYP_M4X44XX_X4              = &H00084400&      ' generic
Public Const TYP_M4X4410_X4              = &H00084410&      ' 2x130M 16bit
Public Const TYP_M4X4411_X4              = &H00084411&      ' 4x130M 16bit
Public Const TYP_M4X4420_X4              = &H00084420&      ' 2x250M 16bit
Public Const TYP_M4X4421_X4              = &H00084421&      ' 4x250M 16bit
Public Const TYP_M4X4450_X4              = &H00084450&      ' 2x500M 14bit
Public Const TYP_M4X4451_X4              = &H00084451&      ' 4x500M 14bit
Public Const TYP_M4X4470_X4              = &H00084470&      ' 2x180M 16bit
Public Const TYP_M4X4471_X4              = &H00084471&      ' 4x180M 16bit
Public Const TYP_M4X4480_X4              = &H00084480&      ' 2x400M 14bit
Public Const TYP_M4X4481_X4              = &H00084481&      ' 4x400M 14bit


' ----- MI.45xx, MC.45xx, MX.45xx -----
Public Const TYP_MI4520                  = &H00004520&
Public Const TYP_MI4521                  = &H00004521&
Public Const TYP_MI4530                  = &H00004530&
Public Const TYP_MI4531                  = &H00004531&
Public Const TYP_MI4540                  = &H00004540&
Public Const TYP_MI4541                  = &H00004541&

Public Const TYP_M2I4520                 = &H00034520&
Public Const TYP_M2I4521                 = &H00034521&
Public Const TYP_M2I4530                 = &H00034530&
Public Const TYP_M2I4531                 = &H00034531&
Public Const TYP_M2I4540                 = &H00034540&
Public Const TYP_M2I4541                 = &H00034541&

Public Const TYP_MC4520                  = &H00014520&
Public Const TYP_MC4521                  = &H00014521&
Public Const TYP_MC4530                  = &H00014530&
Public Const TYP_MC4531                  = &H00014531&
Public Const TYP_MC4540                  = &H00014540&
Public Const TYP_MC4541                  = &H00014541&

Public Const TYP_MX4520                  = &H00024520&
Public Const TYP_MX4530                  = &H00024530&
Public Const TYP_MX4540                  = &H00024540&



' ----- MI.46xx, MC.46xx, MX.46xx -----
Public Const TYP_MI4620                  = &H00004620&
Public Const TYP_MI4621                  = &H00004621&
Public Const TYP_MI4622                  = &H00004622&
Public Const TYP_MI4630                  = &H00004630&
Public Const TYP_MI4631                  = &H00004631&
Public Const TYP_MI4632                  = &H00004632&
Public Const TYP_MI4640                  = &H00004640&
Public Const TYP_MI4641                  = &H00004641&
Public Const TYP_MI4642                  = &H00004642&
Public Const TYP_MI4650                  = &H00004650&
Public Const TYP_MI4651                  = &H00004651&
Public Const TYP_MI4652                  = &H00004652&

Public Const TYP_M2I4620                 = &H00034620&
Public Const TYP_M2I4621                 = &H00034621&
Public Const TYP_M2I4622                 = &H00034622&
Public Const TYP_M2I4630                 = &H00034630&
Public Const TYP_M2I4631                 = &H00034631&
Public Const TYP_M2I4632                 = &H00034632&
Public Const TYP_M2I4640                 = &H00034640&
Public Const TYP_M2I4641                 = &H00034641&
Public Const TYP_M2I4642                 = &H00034642&
Public Const TYP_M2I4650                 = &H00034650&
Public Const TYP_M2I4651                 = &H00034651&
Public Const TYP_M2I4652                 = &H00034652&

Public Const TYP_M2I4620EXP              = &H00044620&
Public Const TYP_M2I4621EXP              = &H00044621&
Public Const TYP_M2I4622EXP              = &H00044622&
Public Const TYP_M2I4630EXP              = &H00044630&
Public Const TYP_M2I4631EXP              = &H00044631&
Public Const TYP_M2I4632EXP              = &H00044632&
Public Const TYP_M2I4640EXP              = &H00044640&
Public Const TYP_M2I4641EXP              = &H00044641&
Public Const TYP_M2I4642EXP              = &H00044642&
Public Const TYP_M2I4650EXP              = &H00044650&
Public Const TYP_M2I4651EXP              = &H00044651&
Public Const TYP_M2I4652EXP              = &H00044652&

Public Const TYP_MC4620                  = &H00014620&
Public Const TYP_MC4621                  = &H00014621&
Public Const TYP_MC4622                  = &H00014622&
Public Const TYP_MC4630                  = &H00014630&
Public Const TYP_MC4631                  = &H00014631&
Public Const TYP_MC4632                  = &H00014632&
Public Const TYP_MC4640                  = &H00014640&
Public Const TYP_MC4641                  = &H00014641&
Public Const TYP_MC4642                  = &H00014642&
Public Const TYP_MC4650                  = &H00014650&
Public Const TYP_MC4651                  = &H00014651&
Public Const TYP_MC4652                  = &H00014652&

Public Const TYP_MX4620                  = &H00024620&
Public Const TYP_MX4621                  = &H00024621&
Public Const TYP_MX4630                  = &H00024630&
Public Const TYP_MX4631                  = &H00024631&
Public Const TYP_MX4640                  = &H00024640&
Public Const TYP_MX4641                  = &H00024641&
Public Const TYP_MX4650                  = &H00024650&
Public Const TYP_MX4651                  = &H00024651&



' ----- MI.47xx, MC.47xx, MX.47xx -----
Public Const TYP_MI4710                  = &H00004710&
Public Const TYP_MI4711                  = &H00004711&
Public Const TYP_MI4720                  = &H00004720&
Public Const TYP_MI4721                  = &H00004721&
Public Const TYP_MI4730                  = &H00004730&
Public Const TYP_MI4731                  = &H00004731&
Public Const TYP_MI4740                  = &H00004740&
Public Const TYP_MI4741                  = &H00004741&

Public Const TYP_M2I4710                 = &H00034710&
Public Const TYP_M2I4711                 = &H00034711&
Public Const TYP_M2I4720                 = &H00034720&
Public Const TYP_M2I4721                 = &H00034721&
Public Const TYP_M2I4730                 = &H00034730&
Public Const TYP_M2I4731                 = &H00034731&
Public Const TYP_M2I4740                 = &H00034740&
Public Const TYP_M2I4741                 = &H00034741&

Public Const TYP_M2I4710EXP              = &H00044710&
Public Const TYP_M2I4711EXP              = &H00044711&
Public Const TYP_M2I4720EXP              = &H00044720&
Public Const TYP_M2I4721EXP              = &H00044721&
Public Const TYP_M2I4730EXP              = &H00044730&
Public Const TYP_M2I4731EXP              = &H00044731&
Public Const TYP_M2I4740EXP              = &H00044740&
Public Const TYP_M2I4741EXP              = &H00044741&

Public Const TYP_MC4710                  = &H00014710&
Public Const TYP_MC4711                  = &H00014711&
Public Const TYP_MC4720                  = &H00014720&
Public Const TYP_MC4721                  = &H00014721&
Public Const TYP_MC4730                  = &H00014730&
Public Const TYP_MC4731                  = &H00014731&

Public Const TYP_MX4710                  = &H00024710&
Public Const TYP_MX4720                  = &H00024720&
Public Const TYP_MX4730                  = &H00024730&



' ----- M3i.48xx, M3i.48xx-Exp (16 bit A/D) -----
Public Const TYP_M3I4830                 = &H00054830&     
Public Const TYP_M3I4831                 = &H00054831&    
Public Const TYP_M3I4840                 = &H00054840&     
Public Const TYP_M3I4841                 = &H00054841&    
Public Const TYP_M3I4860                 = &H00054860&     
Public Const TYP_M3I4861                 = &H00054861&    

Public Const TYP_M3I4830EXP              = &H00064830&     
Public Const TYP_M3I4831EXP              = &H00064831&    
Public Const TYP_M3I4840EXP              = &H00064840&     
Public Const TYP_M3I4841EXP              = &H00064841&    
Public Const TYP_M3I4860EXP              = &H00064860&     
Public Const TYP_M3I4861EXP              = &H00064861&    



' ----- MI.46xx, MC.46xx, MX.46xx -----
Public Const TYP_MI4911                  = &H00004911&
Public Const TYP_MI4912                  = &H00004912&
Public Const TYP_MI4931                  = &H00004931&
Public Const TYP_MI4932                  = &H00004932&
Public Const TYP_MI4960                  = &H00004960&
Public Const TYP_MI4961                  = &H00004961&
Public Const TYP_MI4963                  = &H00004963&
Public Const TYP_MI4964                  = &H00004964&

Public Const TYP_MC4911                  = &H00014911&
Public Const TYP_MC4912                  = &H00014912&
Public Const TYP_MC4931                  = &H00014931&
Public Const TYP_MC4932                  = &H00014932&
Public Const TYP_MC4960                  = &H00014960&
Public Const TYP_MC4961                  = &H00014961&
Public Const TYP_MC4963                  = &H00014963&
Public Const TYP_MC4964                  = &H00014964&

Public Const TYP_MX4911                  = &H00024911&
Public Const TYP_MX4931                  = &H00024931&
Public Const TYP_MX4960                  = &H00024960&
Public Const TYP_MX4963                  = &H00024963&

Public Const TYP_M2I4911                 = &H00034911&
Public Const TYP_M2I4912                 = &H00034912&
Public Const TYP_M2I4931                 = &H00034931&
Public Const TYP_M2I4932                 = &H00034932&
Public Const TYP_M2I4960                 = &H00034960&
Public Const TYP_M2I4961                 = &H00034961&
Public Const TYP_M2I4963                 = &H00034963&
Public Const TYP_M2I4964                 = &H00034964&

Public Const TYP_M2I4911EXP              = &H00044911&
Public Const TYP_M2I4912EXP              = &H00044912&
Public Const TYP_M2I4931EXP              = &H00044931&
Public Const TYP_M2I4932EXP              = &H00044932&
Public Const TYP_M2I4960EXP              = &H00044960&
Public Const TYP_M2I4961EXP              = &H00044961&
Public Const TYP_M2I4963EXP              = &H00044963&
Public Const TYP_M2I4964EXP              = &H00044964&

' ----- M2p.59xx-x4 -----
Public Const TYP_M2P59XX_X4              = &H00095900&      ' generic
Public Const TYP_M2P5911_X4              = &H00095911&
Public Const TYP_M2P5912_X4              = &H00095912&
Public Const TYP_M2P5913_X4              = &H00095913&
Public Const TYP_M2P5916_X4              = &H00095916&
Public Const TYP_M2P5920_X4              = &H00095920&
Public Const TYP_M2P5921_X4              = &H00095921&
Public Const TYP_M2P5922_X4              = &H00095922&
Public Const TYP_M2P5923_X4              = &H00095923&
Public Const TYP_M2P5926_X4              = &H00095926&
Public Const TYP_M2P5930_X4              = &H00095930&
Public Const TYP_M2P5931_X4              = &H00095931&
Public Const TYP_M2P5932_X4              = &H00095932&
Public Const TYP_M2P5933_X4              = &H00095933&
Public Const TYP_M2P5936_X4              = &H00095936&
Public Const TYP_M2P5940_X4              = &H00095940&
Public Const TYP_M2P5941_X4              = &H00095941&
Public Const TYP_M2P5942_X4              = &H00095942&
Public Const TYP_M2P5943_X4              = &H00095943&
Public Const TYP_M2P5946_X4              = &H00095946&
Public Const TYP_M2P5960_X4              = &H00095960&
Public Const TYP_M2P5961_X4              = &H00095961&
Public Const TYP_M2P5962_X4              = &H00095962&
Public Const TYP_M2P5966_X4              = &H00095966&
Public Const TYP_M2P5968_X4              = &H00095968&


' ----- MI.60xx, MC.60xx, MX.60xx -----
Public Const TYP_MI6010                  = &H00006010&
Public Const TYP_MI6011                  = &H00006011&
Public Const TYP_MI6012                  = &H00006012&
Public Const TYP_MI6021                  = &H00006021&
Public Const TYP_MI6022                  = &H00006022&
Public Const TYP_MI6030                  = &H00006030&
Public Const TYP_MI6031                  = &H00006031&
Public Const TYP_MI6033                  = &H00006033&
Public Const TYP_MI6034                  = &H00006034&

Public Const TYP_M2I6010                 = &H00036010&
Public Const TYP_M2I6011                 = &H00036011&
Public Const TYP_M2I6012                 = &H00036012&
Public Const TYP_M2I6021                 = &H00036021&
Public Const TYP_M2I6022                 = &H00036022&
Public Const TYP_M2I6030                 = &H00036030&
Public Const TYP_M2I6031                 = &H00036031&
Public Const TYP_M2I6033                 = &H00036033&
Public Const TYP_M2I6034                 = &H00036034&

Public Const TYP_M2I6010EXP              = &H00046010&
Public Const TYP_M2I6011EXP              = &H00046011&
Public Const TYP_M2I6012EXP              = &H00046012&
Public Const TYP_M2I6021EXP              = &H00046021&
Public Const TYP_M2I6022EXP              = &H00046022&
Public Const TYP_M2I6030EXP              = &H00046030&
Public Const TYP_M2I6031EXP              = &H00046031&
Public Const TYP_M2I6033EXP              = &H00046033&
Public Const TYP_M2I6034EXP              = &H00046034&

Public Const TYP_MC6010                  = &H00016010&
Public Const TYP_MC6011                  = &H00016011&
Public Const TYP_MC6012                  = &H00016012&
Public Const TYP_MC6021                  = &H00016021&
Public Const TYP_MC6022                  = &H00016022&
Public Const TYP_MC6030                  = &H00016030&
Public Const TYP_MC6031                  = &H00016031&
Public Const TYP_MC6033                  = &H00016033&
Public Const TYP_MC6034                  = &H00016034&

Public Const TYP_MX6010                  = &H00026010&
Public Const TYP_MX6011                  = &H00026011&
Public Const TYP_MX6021                  = &H00026021&
Public Const TYP_MX6030                  = &H00026030&
Public Const TYP_MX6033                  = &H00026033&



' ----- MI.61xx, MC.61xx, MX.61xx -----
Public Const TYP_MI6105                  = &H00006105&
Public Const TYP_MI6110                  = &H00006110&
Public Const TYP_MI6111                  = &H00006111&

Public Const TYP_M2I6105                 = &H00036105&
Public Const TYP_M2I6110                 = &H00036110&
Public Const TYP_M2I6111                 = &H00036111&

Public Const TYP_M2I6105EXP              = &H00046105&
Public Const TYP_M2I6110EXP              = &H00046110&
Public Const TYP_M2I6111EXP              = &H00046111&

Public Const TYP_MC6110                  = &H00016110&
Public Const TYP_MC6111                  = &H00016111&

Public Const TYP_MX6110                  = &H00026110&

' ----- M2p.65xx-x4 -----
Public Const TYP_M2P65XX_X4              = &H00096500&      ' generic
Public Const TYP_M2P6522_X4              = &H00096522&      ' 4 ch @   40 MS/s (1x4) (low voltage)
Public Const TYP_M2P6523_X4              = &H00096523&      ' 8 ch @   40 MS/s (low voltage)
Public Const TYP_M2P6530_X4              = &H00096530&      ' 1 ch @   40 MS/s
Public Const TYP_M2P6531_X4              = &H00096531&      ' 2 ch @   40 MS/s
Public Const TYP_M2P6532_X4              = &H00096532&      ' 4 ch @   40 MS/s (1x4)
Public Const TYP_M2P6536_X4              = &H00096536&      ' 4 ch @   40 MS/s (2x2)
Public Const TYP_M2P6533_X4              = &H00096533&      ' 8 ch @   40 MS/s
Public Const TYP_M2P6540_X4              = &H00096540&      ' 1 ch @   40 MS/s (high voltage)
Public Const TYP_M2P6541_X4              = &H00096541&      ' 2 ch @   40 MS/s (high voltage)
Public Const TYP_M2P6546_X4              = &H00096546&      ' 4 ch @   40 MS/s (2x2) (high voltage)
Public Const TYP_M2P6560_X4              = &H00096560&      ' 1 ch @  125 MS/s
Public Const TYP_M2P6561_X4              = &H00096561&      ' 2 ch @  125 MS/s
Public Const TYP_M2P6562_X4              = &H00096562&      ' 4 ch @  125 MS/s (1x4)
Public Const TYP_M2P6566_X4              = &H00096566&      ' 4 ch @  125 MS/s (2x2)
Public Const TYP_M2P6568_X4              = &H00096568&      ' 8 ch @  125/80 MS/s
Public Const TYP_M2P6570_X4              = &H00096570&      ' 1 ch @  125 MS/s (high voltage)
Public Const TYP_M2P6571_X4              = &H00096571&      ' 2 ch @  125 MS/s (high voltage)
Public Const TYP_M2P6576_X4              = &H00096576&      ' 4 ch @  125 MS/s (2x2) (high voltage)

' ----- M4i.66xx-x8 (16 bit D/A) -----
' ----- M4i.66xx-x8 (generic) -----
Public Const TYP_M4I66XX_X8              = &H00076600&

Public Const TYP_M4I6620_X8              = &H00076620&      ' 1 ch @  625 MS/s
Public Const TYP_M4I6621_X8              = &H00076621&      ' 2 ch @  625 MS/s
Public Const TYP_M4I6622_X8              = &H00076622&      ' 4 ch @  625 MS/s
Public Const TYP_M4I6630_X8              = &H00076630&      ' 1 ch @ 1250 MS/s
Public Const TYP_M4I6631_X8              = &H00076631&      ' 2 ch @ 1250 MS/s

' ----- M4x.66xx-x8 (16 bit D/A) -----
' ----- M4x.66xx-x8 (generic) -----
Public Const TYP_M4X66XX_X4              = &H00086600&

Public Const TYP_M4X6620_X4              = &H00086620&      ' 1 ch @  625 MS/s
Public Const TYP_M4X6621_X4              = &H00086621&      ' 2 ch @  625 MS/s
Public Const TYP_M4X6622_X4              = &H00086622&      ' 4 ch @  625 MS/s
Public Const TYP_M4X6630_X4              = &H00086630&      ' 1 ch @ 1250 MS/s
Public Const TYP_M4X6631_X4              = &H00086631&      ' 2 ch @ 1250 MS/s

' ----- MI.70xx, MC.70xx, MX.70xx -----
Public Const TYP_MI7005                  = &H00007005&
Public Const TYP_MI7010                  = &H00007010&
Public Const TYP_MI7011                  = &H00007011&
Public Const TYP_MI7020                  = &H00007020&
Public Const TYP_MI7021                  = &H00007021&

Public Const TYP_M2I7005                 = &H00037005&
Public Const TYP_M2I7010                 = &H00037010&
Public Const TYP_M2I7011                 = &H00037011&
Public Const TYP_M2I7020                 = &H00037020&
Public Const TYP_M2I7021                 = &H00037021&

Public Const TYP_M2I7005EXP              = &H00047005&
Public Const TYP_M2I7010EXP              = &H00047010&
Public Const TYP_M2I7011EXP              = &H00047011&
Public Const TYP_M2I7020EXP              = &H00047020&
Public Const TYP_M2I7021EXP              = &H00047021&

Public Const TYP_MC7005                  = &H00017005&
Public Const TYP_MC7010                  = &H00017010&
Public Const TYP_MC7011                  = &H00017011&
Public Const TYP_MC7020                  = &H00017020&
Public Const TYP_MC7021                  = &H00017021&

Public Const TYP_MX7005                  = &H00027005&
Public Const TYP_MX7010                  = &H00027010&
Public Const TYP_MX7011                  = &H00027011&



' ----- MI.72xx, MC.72xx, MX.72xx -----
Public Const TYP_MI7210                  = &H00007210&
Public Const TYP_MI7211                  = &H00007211&
Public Const TYP_MI7220                  = &H00007220&
Public Const TYP_MI7221                  = &H00007221&

Public Const TYP_M2I7210                 = &H00037210&
Public Const TYP_M2I7211                 = &H00037211&
Public Const TYP_M2I7220                 = &H00037220&
Public Const TYP_M2I7221                 = &H00037221&

Public Const TYP_M2I7210EXP              = &H00047210&
Public Const TYP_M2I7211EXP              = &H00047211&
Public Const TYP_M2I7220EXP              = &H00047220&
Public Const TYP_M2I7221EXP              = &H00047221&

Public Const TYP_MC7210                  = &H00017210&
Public Const TYP_MC7211                  = &H00017211&
Public Const TYP_MC7220                  = &H00017220&
Public Const TYP_MC7221                  = &H00017221&

Public Const TYP_MX7210                  = &H00027210&
Public Const TYP_MX7220                  = &H00027220&

' ----- M2p.75xx-x4 -----
Public Const TYP_M2P75XX_X4              = &H00097500&      ' generic
Public Const TYP_M2P7515_X4              = &H00097515&

' ----- M4i.77xx-x8  -----
Public Const TYP_M4I77XX_X8              = &H00077700& ' generic
Public Const TYP_M4I7710_X8              = &H00077710& ' single-ended
Public Const TYP_M4I7720_X8              = &H00077720& ' single-ended
Public Const TYP_M4I7730_X8              = &H00077730& ' single-ended
Public Const TYP_M4I7725_X8              = &H00077725& ' differential
Public Const TYP_M4I7735_X8              = &H00077735& ' differential

' ----- M4x.77xx-x8  -----
Public Const TYP_M4X77XX_X4              = &H00087700& ' generic
Public Const TYP_M4X7710_X4              = &H00087710& ' single-ended
Public Const TYP_M4X7720_X4              = &H00087720& ' single-ended
Public Const TYP_M4X7730_X4              = &H00087730& ' single-ended
Public Const TYP_M4X7725_X4              = &H00087725& ' differential
Public Const TYP_M4X7735_X4              = &H00087735& ' differential

' ----- MX.90xx -----
Public Const TYP_MX9010                  = &H00029010&



' ***********************************************************************
' software registers
' ***********************************************************************


' ***** PCI Features Bits (MI/MC/MX and prior cards) *********
Public Const PCIBIT_MULTI                = &H00000001&
Public Const PCIBIT_DIGITAL              = &H00000002&
Public Const PCIBIT_CH0DIGI              = &H00000004&
Public Const PCIBIT_EXTSAM               = &H00000008&
Public Const PCIBIT_3CHANNEL             = &H00000010&
Public Const PCIBIT_GATE                 = &H00000020&
Public Const PCIBIT_SLAVE                = &H00000040&
Public Const PCIBIT_MASTER               = &H00000080&
Public Const PCIBIT_DOUBLEMEM            = &H00000100&
Public Const PCIBIT_SYNC                 = &H00000200&
Public Const PCIBIT_TIMESTAMP            = &H00000400&
Public Const PCIBIT_STARHUB              = &H00000800&
Public Const PCIBIT_CA                   = &H00001000&
Public Const PCIBIT_XIO                  = &H00002000&
Public Const PCIBIT_AMPLIFIER            = &H00004000&
Public Const PCIBIT_DIFFMODE             = &H00008000&

Public Const PCIBIT_ELISA                = &H10000000&


' ***** PCI features starting with M2i card series *****
Public Const SPCM_FEAT_MULTI             = &H00000001&      ' multiple recording
Public Const SPCM_FEAT_GATE              = &H00000002&      ' gated sampling
Public Const SPCM_FEAT_DIGITAL           = &H00000004&      ' additional synchronous digital inputs or outputs
Public Const SPCM_FEAT_TIMESTAMP         = &H00000008&      ' timestamp
Public Const SPCM_FEAT_STARHUB5          = &H00000020&      ' starhub for  5 cards installed (M2i + M2i-Exp)
Public Const SPCM_FEAT_STARHUB4          = &H00000020&      ' starhub for  4 cards installed (M3i + M3i-Exp)
Public Const SPCM_FEAT_STARHUB6_EXTM     = &H00000020&      ' starhub for  6 cards installed as card extension or piggy back (M2p)
Public Const SPCM_FEAT_STARHUB8_EXTM     = &H00000020&      ' starhub for  8 cards installed as card extension or piggy back (M4i-Exp)
Public Const SPCM_FEAT_STARHUB16         = &H00000040&      ' starhub for 16 cards installed (M2i, M2i-exp)
Public Const SPCM_FEAT_STARHUB16_EXTM    = &H00000040&      ' starhub for 16 cards installed as card extension or piggy back (M2p)
Public Const SPCM_FEAT_STARHUB8          = &H00000040&      ' starhub for  8 cards installed (M3i + M3i-Exp)
Public Const SPCM_FEAT_STARHUBXX_MASK    = &H00000060&      ' mask to detect one of the above installed starhub
Public Const SPCM_FEAT_ABA               = &H00000080&      ' ABA mode installed
Public Const SPCM_FEAT_BASEXIO           = &H00000100&      ' extra I/O on base card installed
Public Const SPCM_FEAT_AMPLIFIER_10V     = &H00000200&      ' external amplifier for 60/61
Public Const SPCM_FEAT_STARHUBSYSMASTER  = &H00000400&      ' system starhub master installed
Public Const SPCM_FEAT_DIFFMODE          = &H00000800&      ' Differential mode installed
Public Const SPCM_FEAT_SEQUENCE          = &H00001000&      ' Sequence programming mode for generator cards
Public Const SPCM_FEAT_AMPMODULE_10V     = &H00002000&      ' amplifier module for 60/61
Public Const SPCM_FEAT_STARHUBSYSSLAVE   = &H00004000&      ' system starhub slave installed
Public Const SPCM_FEAT_NETBOX            = &H00008000&      ' card is part of netbox
Public Const SPCM_FEAT_REMOTESERVER      = &H00010000&      ' remote server can be used with this card
Public Const SPCM_FEAT_SCAPP             = &H00020000&      ' SCAPP option (CUDA RDMA)
Public Const SPCM_FEAT_DIG16_SMB         = &H00040000&      ' M2p: 16 additional digital inputs or outputs (via SMB connectors) 
Public Const SPCM_FEAT_DIG8_SMA          = &H00040000&      ' M4i:  8 additional digital inputs or 6 additional outputs (via SMA connectors) 
Public Const SPCM_FEAT_DIG16_FX2         = &H00080000&      ' M2p: 16 additional digital inputs or outputs (via FX2 connector)
Public Const SPCM_FEAT_DIGITALBWFILTER   = &H00100000&      ' Digital BW filter is available
Public Const SPCM_FEAT_CUSTOMMOD_MASK    = &HF0000000&      ' mask for custom modification code, meaning of code depends on type and customer


' ***** Extended Features starting with M4i *****
Public Const SPCM_FEAT_EXTFW_SEGSTAT     = &H00000001&        ' segment (Multiple Recording, ABA) statistics like average, min/max
Public Const SPCM_FEAT_EXTFW_SEGAVERAGE  = &H00000002&        ' average of multiple segments (Multiple Recording, ABA) 
Public Const SPCM_FEAT_EXTFW_BOXCAR      = &H00000004&      ' boxcar averaging (high-res mode)


' ***** Error Request *************
Public Const ERRORTEXTLEN                = 200
Public Const SPC_LASTERRORTEXT           = 999996
Public Const SPC_LASTERRORVALUE          = 999997
Public Const SPC_LASTERRORREG            = 999998
Public Const SPC_LASTERRORCODE           = 999999     ' Reading this reset the internal error-memory.

' ***** constants to use with the various _ACDC registers *****
Public Const COUPLING_DC = 0
Public Const COUPLING_AC = 1


' ***** Register and Command Structure
Public Const SPC_COMMAND                 = 0
Public Const     SPC_RESET               = 0
Public Const     SPC_SOFTRESET           = 1
Public Const     SPC_WRITESETUP          = 2
Public Const     SPC_START               = 10
Public Const     SPC_STARTANDWAIT        = 11
Public Const     SPC_FIFOSTART           = 12
Public Const     SPC_FIFOWAIT            = 13
Public Const     SPC_FIFOSTARTNOWAIT     = 14
Public Const     SPC_FORCETRIGGER        = 16
Public Const     SPC_STOP                = 20
Public Const     SPC_FLUSHFIFOBUFFER     = 21
Public Const     SPC_POWERDOWN           = 30
Public Const     SPC_SYNCMASTER          = 100
Public Const     SPC_SYNCTRIGGERMASTER   = 101
Public Const     SPC_SYNCMASTERFIFO      = 102
Public Const     SPC_SYNCSLAVE           = 110
Public Const     SPC_SYNCTRIGGERSLAVE    = 111
Public Const     SPC_SYNCSLAVEFIFO       = 112
Public Const     SPC_NOSYNC              = 120
Public Const     SPC_SYNCSTART           = 130
Public Const     SPC_SYNCCALCMASTER      = 140
Public Const     SPC_SYNCCALCMASTERFIFO  = 141
Public Const     SPC_PXIDIVIDERRESET     = 150
Public Const     SPC_RELAISON            = 200
Public Const     SPC_RELAISOFF           = 210
Public Const     SPC_ADJUSTSTART         = 300
Public Const     SPC_FIFO_BUFREADY0      = 400
Public Const     SPC_FIFO_BUFREADY1      = 401
Public Const     SPC_FIFO_BUFREADY2      = 402
Public Const     SPC_FIFO_BUFREADY3      = 403
Public Const     SPC_FIFO_BUFREADY4      = 404
Public Const     SPC_FIFO_BUFREADY5      = 405
Public Const     SPC_FIFO_BUFREADY6      = 406
Public Const     SPC_FIFO_BUFREADY7      = 407
Public Const     SPC_FIFO_BUFREADY8      = 408
Public Const     SPC_FIFO_BUFREADY9      = 409
Public Const     SPC_FIFO_BUFREADY10     = 410
Public Const     SPC_FIFO_BUFREADY11     = 411
Public Const     SPC_FIFO_BUFREADY12     = 412
Public Const     SPC_FIFO_BUFREADY13     = 413
Public Const     SPC_FIFO_BUFREADY14     = 414
Public Const     SPC_FIFO_BUFREADY15     = 415
Public Const     SPC_FIFO_AUTOBUFSTART   = 500
Public Const     SPC_FIFO_AUTOBUFEND     = 510

Public Const SPC_STATUS                  = 10
Public Const     SPC_RUN                 = 0
Public Const     SPC_TRIGGER             = 10
Public Const     SPC_READY               = 20



' commands for M2 cards
Public Const SPC_M2CMD                   = 100                ' write a command
Public Const     M2CMD_CARD_RESET            = &H00000001&     ' hardware reset   
Public Const     M2CMD_CARD_WRITESETUP       = &H00000002&     ' write setup only
Public Const     M2CMD_CARD_START            = &H00000004&     ' start of card (including writesetup)
Public Const     M2CMD_CARD_ENABLETRIGGER    = &H00000008&     ' enable trigger engine
Public Const     M2CMD_CARD_FORCETRIGGER     = &H00000010&     ' force trigger
Public Const     M2CMD_CARD_DISABLETRIGGER   = &H00000020&     ' disable trigger engine again (multi or gate)
Public Const     M2CMD_CARD_STOP             = &H00000040&     ' stop run
Public Const     M2CMD_CARD_FLUSHFIFO        = &H00000080&     ' flush fifos to memory
Public Const     M2CMD_CARD_INVALIDATEDATA   = &H00000100&     ' current data in memory is invalidated, next data transfer start will wait until new data is available
Public Const     M2CMD_CARD_INTERNALRESET    = &H00000200&     ' INTERNAL reset command

Public Const     M2CMD_ALL_STOP              = &H00440060&     ' stops card and all running transfers

Public Const     M2CMD_CARD_WAITPREFULL      = &H00001000&     ' wait until pretrigger is full
Public Const     M2CMD_CARD_WAITTRIGGER      = &H00002000&     ' wait for trigger recognition
Public Const     M2CMD_CARD_WAITREADY        = &H00004000&     ' wait for card ready

Public Const     M2CMD_DATA_STARTDMA         = &H00010000&     ' start of DMA transfer for data
Public Const     M2CMD_DATA_WAITDMA          = &H00020000&     ' wait for end of data transfer / next block ready
Public Const     M2CMD_DATA_STOPDMA          = &H00040000&     ' abort the data transfer
Public Const     M2CMD_DATA_POLL             = &H00080000&     ' transfer data using single access and polling

Public Const     M2CMD_EXTRA_STARTDMA        = &H00100000&     ' start of DMA transfer for extra (ABA + timestamp) data
Public Const     M2CMD_EXTRA_WAITDMA         = &H00200000&     ' wait for end of extra (ABA + timestamp) data transfer / next block ready
Public Const     M2CMD_EXTRA_STOPDMA         = &H00400000&     ' abort the extra (ABA + timestamp) data transfer
Public Const     M2CMD_EXTRA_POLL            = &H00800000&     ' transfer data using single access and polling

Public Const     M2CMD_DATA_SGFLUSH          = &H01000000&     ' flush incomplete pages from sg list


' status for M2 cards (bitmask)
Public Const SPC_M2STATUS                = 110                ' read the current status
Public Const     M2STAT_NONE                 = &H00000000&     ' status empty
Public Const     M2STAT_CARD_PRETRIGGER      = &H00000001&     ' pretrigger area is full
Public Const     M2STAT_CARD_TRIGGER         = &H00000002&     ' trigger recognized
Public Const     M2STAT_CARD_READY           = &H00000004&     ' card is ready, run finished
Public Const     M2STAT_CARD_SEGMENT_PRETRG  = &H00000008&     ' since M4i: at muliple-recording: pretrigger area of a segment is full

Public Const     M2STAT_DATA_BLOCKREADY      = &H00000100&     ' next data block is available
Public Const     M2STAT_DATA_END             = &H00000200&     ' data transfer has ended
Public Const     M2STAT_DATA_OVERRUN         = &H00000400&     ' FIFO overrun (record) or underrun (replay)
Public Const     M2STAT_DATA_ERROR           = &H00000800&     ' internal error

Public Const     M2STAT_EXTRA_BLOCKREADY     = &H00001000&     ' next extra data (ABA and timestamp) block is available
Public Const     M2STAT_EXTRA_END            = &H00002000&     ' extra data (ABA and timestamp) transfer has ended
Public Const     M2STAT_EXTRA_OVERRUN        = &H00004000&     ' FIFO overrun
Public Const     M2STAT_EXTRA_ERROR          = &H00008000&     ' internal error

Public Const     M2STAT_TSCNT_OVERRUN        = &H00010000&     ' timestamp counter overrun

Public Const     M2STAT_INTERNALMASK         = &Hff000000&     ' mask for internal status signals
Public Const     M2STAT_INTERNAL_SYSLOCK     = &H02000000&



' buffer control registers for samples data
Public Const SPC_DATA_AVAIL_USER_LEN     = 200                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_DATA_AVAIL_USER_POS     = 201                ' the current byte position where the available user data starts
Public Const SPC_DATA_AVAIL_CARD_LEN     = 202                ' number of bytes available for card (free buffer if READ, filled data if WRITE)
Public Const SPC_DATA_OUTBUFSIZE         = 209                ' output buffer size in bytes

' buffer control registers for extra data (ABA slow data, timestamps)
Public Const SPC_ABA_AVAIL_USER_LEN      = 210                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_ABA_AVAIL_USER_POS      = 211                ' the current byte position where the available user data starts
Public Const SPC_ABA_AVAIL_CARD_LEN      = 212                ' number of bytes available for card (free buffer if READ, filled data if WRITE)

Public Const SPC_TS_AVAIL_USER_LEN       = 220                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_TS_AVAIL_USER_POS       = 221                ' the current byte position where the available user data starts
Public Const SPC_TS_AVAIL_CARD_LEN       = 222                ' number of bytes available for card (free buffer if READ, filled data if WRITE)



' Installation
Public Const SPC_VERSION                 = 1000
Public Const SPC_ISAADR                  = 1010
Public Const SPC_INSTMEM                 = 1020
Public Const SPC_INSTSAMPLERATE          = 1030
Public Const SPC_BRDTYP                  = 1040

' MI/MC/MX type information (internal use)
Public Const SPC_MIINST_MODULES          = 1100
Public Const SPC_MIINST_CHPERMODULE      = 1110
Public Const SPC_MIINST_BYTESPERSAMPLE   = 1120
Public Const SPC_MIINST_BITSPERSAMPLE    = 1125
Public Const SPC_MIINST_MAXADCVALUE      = 1126
Public Const SPC_MIINST_MINADCLOCK       = 1130
Public Const SPC_MIINST_MAXADCLOCK       = 1140
Public Const SPC_MIINST_MINEXTCLOCK      = 1145
Public Const SPC_MIINST_MAXEXTCLOCK      = 1146
Public Const SPC_MIINST_MINSYNCCLOCK     = 1147
Public Const SPC_MIINST_MINEXTREFCLOCK   = 1148
Public Const SPC_MIINST_MAXEXTREFCLOCK   = 1149
Public Const SPC_MIINST_QUARZ            = 1150
Public Const SPC_MIINST_QUARZ2           = 1151
Public Const SPC_MIINST_MINEXTCLOCK1     = 1152
Public Const SPC_MIINST_FLAGS            = 1160
Public Const SPC_MIINST_FIFOSUPPORT      = 1170
Public Const SPC_MIINST_ISDEMOCARD       = 1175

' Driver information
Public Const SPC_GETDRVVERSION           = 1200
Public Const SPC_GETKERNELVERSION        = 1210
Public Const SPC_GETDRVTYPE              = 1220
Public Const     DRVTYP_DOS              = 0
Public Const     DRVTYP_LINUX32          = 1
Public Const     DRVTYP_VXD              = 2
Public Const     DRVTYP_NTLEGACY         = 3
Public Const     DRVTYP_WDM32            = 4
Public Const     DRVTYP_WDM64            = 5
Public Const     DRVTYP_WOW64            = 6
Public Const     DRVTYP_LINUX64          = 7
Public Const     DRVTYP_QNX32            = 8
Public Const     DRVTYP_QNX64            = 9
Public Const SPC_GETCOMPATIBILITYVERSION = 1230
Public Const SPC_GETMINDRVVERSION        = 1240

' PCI, CompactPCI and PXI Installation Information
Public Const SPC_PCITYP                  = 2000

' ***** available card function types *****
Public Const SPC_FNCTYPE                 = 2001
Public Const     SPCM_TYPE_AI            = &H01&
Public Const     SPCM_TYPE_AO            = &H02&
Public Const     SPCM_TYPE_DI            = &H04&
Public Const     SPCM_TYPE_DO            = &H08&
Public Const     SPCM_TYPE_DIO           = &H10&

Public Const SPC_PCIVERSION              = 2010
Public Const SPC_PCIEXTVERSION           = 2011
Public Const SPC_PCIMODULEVERSION        = 2012
Public Const SPC_PCIMODULEBVERSION       = 2013
Public Const SPC_BASEPCBVERSION          = 2014
Public Const SPC_MODULEPCBVERSION        = 2015
Public Const SPC_MODULEAPCBVERSION       = 2015
Public Const SPC_MODULEBPCBVERSION       = 2016
Public Const SPC_EXTPCBVERSION           = 2017
Public Const SPC_PCIDIGVERSION           = 2018
Public Const SPC_DIGPCBVERSION           = 2019
Public Const SPC_PCIDATE                 = 2020
Public Const SPC_CALIBDATE               = 2025
Public Const SPC_CALIBDATEONBOARD        = 2026
Public Const SPC_PCISERIALNR             = 2030
Public Const SPC_PCISERIALNO             = 2030
Public Const SPC_PCIHWBUSNO              = 2040
Public Const SPC_PCIHWDEVNO              = 2041
Public Const SPC_PCIHWFNCNO              = 2042
Public Const SPC_PCIHWSLOTNO             = 2043
Public Const SPC_PCIEXPGENERATION        = 2050
Public Const SPC_PCIEXPLANES             = 2051
Public Const SPC_PCIEXPPAYLOAD           = 2052
Public Const SPC_PCIEXPREADREQUESTSIZE   = 2053
Public Const SPC_PCIEXPREADCOMPLBOUNDARY = 2054
Public Const SPC_PXIHWSLOTNO             = 2055
Public Const SPC_PCISAMPLERATE           = 2100
Public Const SPC_PCIMEMSIZE              = 2110
Public Const SPC_PCIFEATURES             = 2120
Public Const SPC_PCIEXTFEATURES          = 2121
Public Const SPC_PCIINFOADR              = 2200
Public Const SPC_PCIINTERRUPT            = 2300
Public Const SPC_PCIBASEADR0             = 2400
Public Const SPC_PCIBASEADR1             = 2401
Public Const SPC_PCIREGION0              = 2410
Public Const SPC_PCIREGION1              = 2411
Public Const SPC_READTRGLVLCOUNT         = 2500
Public Const SPC_READIRCOUNT             = 3000
Public Const SPC_READUNIPOLAR0           = 3010
Public Const SPC_READUNIPOLAR1           = 3020
Public Const SPC_READUNIPOLAR2           = 3030
Public Const SPC_READUNIPOLAR3           = 3040
Public Const SPC_READMAXOFFSET           = 3100

Public Const SPC_READAIFEATURES          = 3101
Public Const     SPCM_AI_TERM            = &H00000001&  ' input termination available
Public Const     SPCM_AI_SE              = &H00000002&  ' single-ended mode available
Public Const     SPCM_AI_DIFF            = &H00000004&  ' differential mode available
Public Const     SPCM_AI_OFFSPERCENT     = &H00000008&  ' offset programming is done in percent of input range
Public Const     SPCM_AI_OFFSMV          = &H00000010&  ' offset programming is done in mV absolut
Public Const     SPCM_AI_OVERRANGEDETECT = &H00000020&  ' overrange detection is programmable
Public Const     SPCM_AI_DCCOUPLING      = &H00000040&  ' DC coupling available
Public Const     SPCM_AI_ACCOUPLING      = &H00000080&  ' AC coupling available
Public Const     SPCM_AI_LOWPASS         = &H00000100&  ' selectable low pass
Public Const     SPCM_AI_ACDC_OFFS_COMP  = &H00000200&  ' AC/DC offset compensation
Public Const     SPCM_AI_DIFFMUX         = &H00000400&  ' differential mode (two channels combined to one) available
Public Const     SPCM_AI_GLOBALLOWPASS   = &H00000800&  ' globally selectable low pass (all channels same setting)
Public Const     SPCM_AI_AUTOCALOFFS     = &H00001000&  ' automatic offset calibration in hardware
Public Const     SPCM_AI_AUTOCALGAIN     = &H00002000&  ' automatic gain calibration in hardware
Public Const     SPCM_AI_AUTOCALOFFSNOIN = &H00004000&  ' automatic offset calibration with open inputs
Public Const     SPCM_AI_HIGHIMP         = &H00008000&  ' high impedance available
Public Const     SPCM_AI_LOWIMP          = &H00010000&  ' low impedance available (50 ohm)
Public Const     SPCM_AI_DIGITALLOWPASS  = &H00020000&  ' selectable digital low pass filter
Public Const     SPCM_AI_INDIVPULSEWIDTH = &H00100000&  ' individual pulsewidth per channel available

Public Const SPC_READAOFEATURES          = 3102
Public Const     SPCM_AO_SE              = &H00000002&  ' single-ended mode available
Public Const     SPCM_AO_DIFF            = &H00000004&  ' differential mode available
Public Const     SPCM_AO_PROGFILTER      = &H00000008&  ' programmable filters available
Public Const     SPCM_AO_PROGOFFSET      = &H00000010&  ' programmable offset available
Public Const     SPCM_AO_PROGGAIN        = &H00000020&  ' programmable gain available
Public Const     SPCM_AO_PROGSTOPLEVEL   = &H00000040&  ' programmable stop level available
Public Const     SPCM_AO_DOUBLEOUT       = &H00000080&  ' double out mode available
Public Const     SPCM_AO_ENABLEOUT       = &H00000100&  ' outputs can be disabled/enabled

Public Const SPC_READDIFEATURES          = 3103
Public Const     SPCM_DI_TERM            = &H00000001&  ' input termination available
Public Const     SPCM_DI_SE              = &H00000002&  ' single-ended mode available
Public Const     SPCM_DI_DIFF            = &H00000004&  ' differential mode available
Public Const     SPCM_DI_PROGTHRESHOLD   = &H00000008&  ' programmable threshold available
Public Const     SPCM_DI_HIGHIMP         = &H00000010&  ' high impedance available
Public Const     SPCM_DI_LOWIMP          = &H00000020&  ' low impedance available
Public Const     SPCM_DI_INDIVPULSEWIDTH = &H00100000&  ' individual pulsewidth per channel available
Public Const     SPCM_DI_IOCHANNEL       = &H00200000&  ' connected with DO channel

Public Const SPC_READDOFEATURES          = 3104
Public Const     SPCM_DO_SE              = &H00000002&  ' single-ended mode available
Public Const     SPCM_DO_DIFF            = &H00000004&  ' differential mode available
Public Const     SPCM_DO_PROGSTOPLEVEL   = &H00000008&  ' programmable stop level available
Public Const     SPCM_DO_PROGOUTLEVELS   = &H00000010&  ' programmable output levels (low + high) available
Public Const     SPCM_DO_ENABLEMASK      = &H00000020&  ' individual enable mask for each output channel
Public Const     SPCM_DO_IOCHANNEL       = &H00200000&  ' connected with DI channel

Public Const SPC_READCHGROUPING          = 3110
Public Const SPC_READAIPATHCOUNT         = 3120       ' number of available analog input paths
Public Const SPC_READAIPATH              = 3121       ' the current path for which all the settings are read

Public Const SPCM_CUSTOMMOD              = 3130
Public Const     SPCM_CUSTOMMOD_BASE_MASK    = &H000000FF&
Public Const     SPCM_CUSTOMMOD_MODULE_MASK  = &H0000FF00&
Public Const     SPCM_CUSTOMMOD_STARHUB_MASK = &H00FF0000&

Public Const SPC_READRANGECH0_0          = 3200
Public Const SPC_READRANGECH0_1          = 3201
Public Const SPC_READRANGECH0_2          = 3202
Public Const SPC_READRANGECH0_3          = 3203
Public Const SPC_READRANGECH0_4          = 3204
Public Const SPC_READRANGECH0_5          = 3205
Public Const SPC_READRANGECH0_6          = 3206
Public Const SPC_READRANGECH0_7          = 3207
Public Const SPC_READRANGECH0_8          = 3208
Public Const SPC_READRANGECH0_9          = 3209
Public Const SPC_READRANGECH1_0          = 3300
Public Const SPC_READRANGECH1_1          = 3301
Public Const SPC_READRANGECH1_2          = 3302
Public Const SPC_READRANGECH1_3          = 3303
Public Const SPC_READRANGECH1_4          = 3304
Public Const SPC_READRANGECH1_5          = 3305
Public Const SPC_READRANGECH1_6          = 3306
Public Const SPC_READRANGECH1_7          = 3307
Public Const SPC_READRANGECH1_8          = 3308
Public Const SPC_READRANGECH1_9          = 3309
Public Const SPC_READRANGECH2_0          = 3400
Public Const SPC_READRANGECH2_1          = 3401
Public Const SPC_READRANGECH2_2          = 3402
Public Const SPC_READRANGECH2_3          = 3403
Public Const SPC_READRANGECH3_0          = 3500
Public Const SPC_READRANGECH3_1          = 3501
Public Const SPC_READRANGECH3_2          = 3502
Public Const SPC_READRANGECH3_3          = 3503

Public Const SPC_READRANGEMIN0           = 4000
Public Const SPC_READRANGEMIN99          = 4099
Public Const SPC_READRANGEMAX0           = 4100
Public Const SPC_READRANGEMAX99          = 4199
Public Const SPC_READOFFSMIN0            = 4200
Public Const SPC_READOFFSMIN99           = 4299
Public Const SPC_READOFFSMAX0            = 4300
Public Const SPC_READOFFSMAX99           = 4399
Public Const SPC_PCICOUNTER              = 9000
Public Const SPC_BUFFERPOS               = 9010

Public Const SPC_READAOGAINMIN           = 9100
Public Const SPC_READAOGAINMAX           = 9110
Public Const SPC_READAOOFFSETMIN         = 9120
Public Const SPC_READAOOFFSETMAX         = 9130

Public Const SPC_CARDMODE                = 9500       ' card modes as listed below
Public Const SPC_AVAILCARDMODES          = 9501       ' list with available card modes

' card modes
Public Const     SPC_REC_STD_SINGLE          = &H00000001&  ' singleshot recording to memory
Public Const     SPC_REC_STD_MULTI           = &H00000002&  ' multiple records to memory on each trigger event
Public Const     SPC_REC_STD_GATE            = &H00000004&  ' gated recording to memory on gate signal
Public Const     SPC_REC_STD_ABA             = &H00000008&  ' ABA: A slowly to extra FIFO, B to memory on each trigger event 
Public Const     SPC_REC_STD_SEGSTATS        = &H00010000&  ' segment information stored on each trigger segment -> stored in on-board memory
Public Const     SPC_REC_STD_AVERAGE         = &H00020000&  ' multiple records summed to average memory on each trigger event -> stored in on-board memory
Public Const     SPC_REC_STD_AVERAGE_16BIT   = &H00080000&  ' multiple records summed to average memory on each trigger event -> stored in on-board memory
Public Const     SPC_REC_STD_BOXCAR          = &H00800000&  ' boxcar averaging

Public Const     SPC_REC_FIFO_SINGLE         = &H00000010&  ' singleshot to FIFO on trigger event
Public Const     SPC_REC_FIFO_MULTI          = &H00000020&  ' multiple records to FIFO on each trigger event
Public Const     SPC_REC_FIFO_GATE           = &H00000040&  ' gated sampling to FIFO on gate signal
Public Const     SPC_REC_FIFO_ABA            = &H00000080&  ' ABA: A slowly to extra FIFO, B to FIFO on each trigger event
Public Const     SPC_REC_FIFO_SEGSTATS       = &H00100000&  ' segment information stored on each trigger segment -> streamed to host
Public Const     SPC_REC_FIFO_AVERAGE        = &H00200000&  ' multiple records summed to average memory on each trigger event -> streamed to host
Public Const     SPC_REC_FIFO_AVERAGE_16BIT  = &H00400000&  ' multiple records summed to average memory on each trigger event -> streamed to host
Public Const     SPC_REC_FIFO_BOXCAR         = &H01000000&  ' boxcar averaging FIFO mode
Public Const     SPC_REC_FIFO_SINGLE_MONITOR = &H02000000&  ' like SPC_REC_FIFO_SINGLE but with additional slow A data stream for monitoring

Public Const     SPC_REP_STD_SINGLE          = &H00000100&  ' single replay from memory on trigger event 
Public Const     SPC_REP_STD_MULTI           = &H00000200&  ' multiple replay from memory on each trigger event
Public Const     SPC_REP_STD_GATE            = &H00000400&  ' gated replay from memory on gate signal

Public Const     SPC_REP_FIFO_SINGLE         = &H00000800&  ' single replay from FIFO on trigger event
Public Const     SPC_REP_FIFO_MULTI          = &H00001000&  ' multiple replay from FIFO on each trigger event
Public Const     SPC_REP_FIFO_GATE           = &H00002000&  ' gated replay from FIFO on gate signal

Public Const     SPC_REP_STD_CONTINUOUS      = &H00004000&  ' continuous replay started by one trigger event
Public Const     SPC_REP_STD_SINGLERESTART   = &H00008000&  ' single replays on every detected trigger event
Public Const     SPC_REP_STD_SEQUENCE        = &H00040000&  ' sequence mode replay

' Waveforms for demo cards
Public Const SPC_DEMOWAVEFORM            = 9600
Public Const SPC_AVAILDEMOWAVEFORMS      = 9601
Public Const     SPCM_DEMOWAVEFORM_SINE      = &H00000001&
Public Const     SPCM_DEMOWAVEFORM_RECT      = &H00000002&
Public Const     SPCM_DEMOWAVEFORM_TRIANGLE  = &H00000004&


' Memory
Public Const SPC_MEMSIZE                 = 10000
Public Const SPC_SEGMENTSIZE             = 10010
Public Const SPC_LOOPS                   = 10020
Public Const SPC_PRETRIGGER              = 10030
Public Const SPC_ABADIVIDER              = 10040
Public Const SPC_AVERAGES                = 10050
Public Const SPC_BOX_AVERAGES            = 10060
Public Const SPC_SEGSPLIT_START          = 10070
Public Const SPC_SEGSPLIT_PAUSE          = 10071
Public Const SPC_POSTTRIGGER             = 10100
Public Const SPC_STARTOFFSET             = 10200

' Memory info (depends on mode and channelenable)
Public Const SPC_AVAILMEMSIZE_MIN        = 10201
Public Const SPC_AVAILMEMSIZE_MAX        = 10202
Public Const SPC_AVAILMEMSIZE_STEP       = 10203
Public Const SPC_AVAILPOSTTRIGGER_MIN    = 10204
Public Const SPC_AVAILPOSTTRIGGER_MAX    = 10205
Public Const SPC_AVAILPOSTTRIGGER_STEP   = 10206

Public Const SPC_AVAILABADIVIDER_MIN     = 10207
Public Const SPC_AVAILABADIVIDER_MAX     = 10208
Public Const SPC_AVAILABADIVIDER_STEP    = 10209

Public Const SPC_AVAILLOOPS_MIN          = 10210
Public Const SPC_AVAILLOOPS_MAX          = 10211
Public Const SPC_AVAILLOOPS_STEP         = 10212

Public Const SPC_AVAILAVERAGES_MIN       = 10220
Public Const SPC_AVAILAVERAGES_MAX       = 10221
Public Const SPC_AVAILAVERAGES_STEP      = 10222

Public Const SPC_AVAILAVRGSEGSIZE_MIN    = 10223
Public Const SPC_AVAILAVRGSEGSIZE_MAX    = 10224
Public Const SPC_AVAILAVRGSEGSIZE_STEP   = 10225

Public Const SPC_AVAILAVERAGES16BIT_MIN     = 10226
Public Const SPC_AVAILAVERAGES16BIT_MAX     = 10227
Public Const SPC_AVAILAVERAGES16BIT_STEP    = 10228

Public Const SPC_AVAILAVRG16BITSEGSIZE_MIN  = 10229
Public Const SPC_AVAILAVRG16BITSEGSIZE_MAX  = 10230
Public Const SPC_AVAILAVRG16BITSEGSIZE_STEP = 10231

Public Const SPC_AVAILBOXCARAVERAGES_MIN         = 10232
Public Const SPC_AVAILBOXCARAVERAGES_MAX         = 10233
Public Const SPC_AVAILBOXCARAVERAGES_STEPFACTOR  = 10234


' Channels
Public Const SPC_CHENABLE                = 11000
Public Const SPC_CHCOUNT                 = 11001
Public Const SPC_CHMODACOUNT             = 11100
Public Const SPC_CHMODBCOUNT             = 11101


' ----- channel enable flags for A/D and D/A boards (MI/MC/MX series) -----
'       and all cards on M2i series
Public Const     CHANNEL0                = &H00000001&
Public Const     CHANNEL1                = &H00000002&
Public Const     CHANNEL2                = &H00000004&
Public Const     CHANNEL3                = &H00000008&
Public Const     CHANNEL4                = &H00000010&
Public Const     CHANNEL5                = &H00000020&
Public Const     CHANNEL6                = &H00000040&
Public Const     CHANNEL7                = &H00000080&
Public Const     CHANNEL8                = &H00000100&
Public Const     CHANNEL9                = &H00000200&
Public Const     CHANNEL10               = &H00000400&
Public Const     CHANNEL11               = &H00000800&
Public Const     CHANNEL12               = &H00001000&
Public Const     CHANNEL13               = &H00002000&
Public Const     CHANNEL14               = &H00004000&
Public Const     CHANNEL15               = &H00008000&
Public Const     CHANNEL16               = &H00010000&
Public Const     CHANNEL17               = &H00020000&
Public Const     CHANNEL18               = &H00040000&
Public Const     CHANNEL19               = &H00080000&
Public Const     CHANNEL20               = &H00100000&
Public Const     CHANNEL21               = &H00200000&
Public Const     CHANNEL22               = &H00400000&
Public Const     CHANNEL23               = &H00800000&
Public Const     CHANNEL24               = &H01000000&
Public Const     CHANNEL25               = &H02000000&
Public Const     CHANNEL26               = &H04000000&
Public Const     CHANNEL27               = &H08000000&
Public Const     CHANNEL28               = &H10000000&
Public Const     CHANNEL29               = &H20000000&
Public Const     CHANNEL30               = &H40000000&
Public Const     CHANNEL31               = &H80000000&
' CHANNEL32 up to CHANNEL63 are placed in the upper 32 bit of a 64 bit word (M2i only)


' ----- old digital i/o settings for 16 bit implementation (MI/MC/MX series)  -----
Public Const     CH0_8BITMODE            = 65536  ' for MI.70xx only
Public Const     CH0_16BIT               = 1
Public Const     CH0_32BIT               = 3
Public Const     CH1_16BIT               = 4
Public Const     CH1_32BIT               = 12

' ----- new digital i/o settings for 8 bit implementation (MI/MC/MX series) -----
Public Const     MOD0_8BIT               = 1
Public Const     MOD0_16BIT              = 3
Public Const     MOD0_32BIT              = 15
Public Const     MOD1_8BIT               = 16
Public Const     MOD1_16BIT              = 48
Public Const     MOD1_32BIT              = 240

Public Const SPC_CHROUTE0                = 11010
Public Const SPC_CHROUTE1                = 11020

Public Const SPC_BITENABLE               = 11030



' ----- Clock Settings -----
Public Const SPC_SAMPLERATE              = 20000
Public Const SPC_SYNCCLOCK               = 20005
Public Const SPC_SAMPLERATE2             = 20010
Public Const SPC_SR2                     = 20020
Public Const SPC_PLL_ENABLE              = 20030
Public Const SPC_PLL_ISLOCKED            = 20031
Public Const SPC_CLOCKDIV                = 20040
Public Const SPC_INTCLOCKDIV             = 20041
Public Const SPC_PXICLOCKDIV             = 20042
Public Const SPC_PLL_R                   = 20060
Public Const SPC_PLL_F                   = 20061
Public Const SPC_PLL_S                   = 20062
Public Const SPC_PLL_DIV                 = 20063
Public Const SPC_PXI_CLK_OUT             = 20090
Public Const SPC_EXTERNALCLOCK           = 20100
Public Const SPC_EXTERNOUT               = 20110
Public Const SPC_CLOCKOUT                = 20110
Public Const SPC_CLOCKOUTFREQUENCY       = 20111
Public Const SPC_CLOCK50OHM              = 20120
Public Const SPC_CLOCK110OHM             = 20120
Public Const SPC_CLOCK75OHM              = 20120
Public Const SPC_STROBE75OHM             = 20121
Public Const SPC_EXTERNRANGE             = 20130
Public Const SPC_EXTRANGESHDIRECT        = 20131
Public Const     EXRANGE_NONE            = 0
Public Const     EXRANGE_NOPLL           = 1
Public Const     EXRANGE_SINGLE          = 2
Public Const     EXRANGE_BURST_S         = 4
Public Const     EXRANGE_BURST_M         = 8
Public Const     EXRANGE_BURST_L         = 16
Public Const     EXRANGE_BURST_XL        = 32
Public Const     EXRANGE_LOW             = 64
Public Const     EXRANGE_HIGH            = 128
Public Const     EXRANGE_LOW_DPS         = 256            ' digital phase synchronization
Public Const SPC_REFERENCECLOCK          = 20140
Public Const     REFCLOCK_PXI            = -1

' ----- new clock registers starting with M2i cards -----
Public Const SPC_CLOCKMODE               = 20200      ' clock mode as listed below
Public Const SPC_AVAILCLOCKMODES         = 20201      ' returns all available clock modes
Public Const     SPC_CM_INTPLL           = &H00000001&      ' use internal PLL
Public Const     SPC_CM_QUARTZ1          = &H00000002&      ' use plain quartz1 (with divider)
Public Const     SPC_CM_QUARTZ2          = &H00000004&      ' use plain quartz2 (with divider)
Public Const     SPC_CM_EXTERNAL         = &H00000008&      ' use external clock directly
Public Const     SPC_CM_EXTERNAL0        = &H00000008&      ' use external clock0 directly (identical value to SPC_CM_EXTERNAL)
Public Const     SPC_CM_EXTDIVIDER       = &H00000010&      ' use external clock with programmed divider
Public Const     SPC_CM_EXTREFCLOCK      = &H00000020&      ' external reference clock fed in (defined with SPC_REFERENCECLOCK)
Public Const     SPC_CM_PXIREFCLOCK      = &H00000040&      ' PXI reference clock
Public Const     SPC_CM_SHDIRECT         = &H00000080&      ' Star-hub direct clock (not synchronised)
Public Const     SPC_CM_QUARTZ2_DIRSYNC  = &H00000100&      ' use plain quartz2 (with divider) and put the Q2 clock on the star-hub module
Public Const     SPC_CM_QUARTZ1_DIRSYNC  = &H00000200&      ' use plain quartz1 (with divider) and put the Q1 clock on the star-hub module
Public Const     SPC_CM_EXTERNAL1        = &H00000400&      ' use external clock1 directly
' ----- internal use only! -----
Public Const     SPC_CM_SYNCINT          = &H01000000&
Public Const     SPC_CM_SYNCEXT          = &H02000000&

Public Const SPC_CLOCK_READFEATURES      = 20205
Public Const SPC_CLOCK_READFEATURES0     = 20205
Public Const SPC_CLOCK_READFEATURES1     = 20206
Public Const     SPCM_CKFEAT_TERM            = &H00000001&
Public Const     SPCM_CKFEAT_HIGHIMP         = &H00000002&
Public Const     SPCM_CKFEAT_DCCOUPLING      = &H00000004&
Public Const     SPCM_CKFEAT_ACCOUPLING      = &H00000008&
Public Const     SPCM_CKFEAT_SE              = &H00000010&
Public Const     SPCM_CKFEAT_DIFF            = &H00000020&
Public Const     SPCM_CKFEAT_PROGEDGE        = &H00000040&
Public Const     SPCM_CKFEAT_LEVELPROG       = &H00000100&
Public Const     SPCM_CKFEAT_PROGTHRESHOLD   = &H00000200&
Public Const     SPCM_CKFEAT_PROGDELAY       = &H00000400&

Public Const SPC_BURSTSYSCLOCKMODE       = 20210
Public Const SPC_SYNCMASTERSYSCLOCKMODE  = 20211
Public Const SPC_CLOCK_SETUP_CHANGED     = 20212

' clock delay if available
Public Const SPC_CLOCK_AVAILDELAY_MIN    = 20220
Public Const SPC_CLOCK_AVAILDELAY_MAX    = 20221
Public Const SPC_CLOCK_AVAILDELAY_STEP   = 20222
Public Const SPC_CLOCK_DELAY             = 20223

' clock edges
Public Const SPC_AVAILCLOCKEDGES         = 20224
Public Const     SPCM_EDGE_FALLING       = &H00000001& ' Originally SPCM_RISING_EDGE  : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details.
Public Const     SPCM_EDGE_RISING        = &H00000002& ' Originally SPCM_FALLING_EDGE : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details.
Public Const     SPCM_BOTH_EDGES         = &H00000004&
Public Const     SPCM_EDGES_BOTH         = &H00000004& 'Just added for good measure to match naming scheme of above SPCM_EDGE_FALLING and SPCM_EDGE_RISING constants.
Public Const SPC_CLOCK_EDGE              = 20225

' mux definitions for channel routing
Public Const SPC_CHANNELMUXINFO          = 20300
Public Const     SPCM_MUX_NONE            = &H00000000&  ' nothing is interlaced
Public Const     SPCM_MUX_MUXONMOD        = &H00000001&  ' data on module is multiplexed, only one channel can have full speed
Public Const     SPCM_MUX_INVERTCLKONMOD  = &H00000002&  ' two channels on one module run with inverted clock
Public Const     SPCM_MUX_DLY             = &H00000003&  ' delay cable between modules, one channel can have full interlace speed
Public Const     SPCM_MUX_DLYANDMUXONMOD  = &H00000004&  ' delay cable between modules and multplexing on module
Public Const     SPCM_MUX_MUXBETWEENMODS  = &H00000005&  ' multiplexed between modules (fastest sampling rate only with one module)
Public Const     SPCM_MUX_MUXONMOD2CH     = &H00000006&  ' data on module is multiplexed, only two channel can have full speed
Public Const     SPCM_MUX_MAX4CH          = &H00000007&  ' only four channels can have full speed, independent of distribution on modules


' ----- In/Out Range -----
Public Const SPC_OFFS0                   = 30000
Public Const SPC_AMP0                    = 30010
Public Const SPC_ACDC0                   = 30020
Public Const SPC_ACDC_OFFS_COMPENSATION0 = 30021
Public Const SPC_50OHM0                  = 30030
Public Const SPC_DIFF0                   = 30040
Public Const SPC_DOUBLEOUT0              = 30041
Public Const SPC_DIGITAL0                = 30050
Public Const SPC_110OHM0                 = 30060
Public Const SPC_110OHM0L                = 30060
Public Const SPC_75OHM0                  = 30060
Public Const SPC_INOUT0                  = 30070
Public Const SPC_FILTER0                 = 30080
Public Const SPC_BANKSWITCH0             = 30081
Public Const SPC_PATH0                   = 30090
Public Const SPC_ENABLEOUT0              = 30091

Public Const SPC_OFFS1                   = 30100
Public Const SPC_AMP1                    = 30110
Public Const SPC_ACDC1                   = 30120
Public Const SPC_ACDC_OFFS_COMPENSATION1 = 30121
Public Const SPC_50OHM1                  = 30130
Public Const SPC_DIFF1                   = 30140
Public Const SPC_DOUBLEOUT1              = 30141
Public Const SPC_DIGITAL1                = 30150
Public Const SPC_110OHM1                 = 30160
Public Const SPC_110OHM0H                = 30160
Public Const SPC_75OHM1                  = 30160
Public Const SPC_INOUT1                  = 30170
Public Const SPC_FILTER1                 = 30180
Public Const SPC_BANKSWITCH1             = 30181
Public Const SPC_PATH1                   = 30190
Public Const SPC_ENABLEOUT1              = 30191

Public Const SPC_OFFS2                   = 30200
Public Const SPC_AMP2                    = 30210
Public Const SPC_ACDC2                   = 30220
Public Const SPC_ACDC_OFFS_COMPENSATION2 = 30221
Public Const SPC_50OHM2                  = 30230
Public Const SPC_DIFF2                   = 30240
Public Const SPC_DOUBLEOUT2              = 30241
Public Const SPC_110OHM2                 = 30260
Public Const SPC_110OHM1L                = 30260
Public Const SPC_75OHM2                  = 30260
Public Const SPC_INOUT2                  = 30270
Public Const SPC_FILTER2                 = 30280
Public Const SPC_BANKSWITCH2             = 30281
Public Const SPC_PATH2                   = 30290
Public Const SPC_ENABLEOUT2              = 30291

Public Const SPC_OFFS3                   = 30300
Public Const SPC_AMP3                    = 30310
Public Const SPC_ACDC3                   = 30320
Public Const SPC_ACDC_OFFS_COMPENSATION3 = 30321
Public Const SPC_50OHM3                  = 30330
Public Const SPC_DIFF3                   = 30340
Public Const SPC_DOUBLEOUT3              = 30341
Public Const SPC_110OHM3                 = 30360
Public Const SPC_110OHM1H                = 30360
Public Const SPC_75OHM3                  = 30360
Public Const SPC_INOUT3                  = 30370
Public Const SPC_FILTER3                 = 30380
Public Const SPC_BANKSWITCH3             = 30381
Public Const SPC_PATH3                   = 30390
Public Const SPC_ENABLEOUT3              = 30391

Public Const SPC_OFFS4                   = 30400
Public Const SPC_AMP4                    = 30410
Public Const SPC_ACDC4                   = 30420
Public Const SPC_50OHM4                  = 30430
Public Const SPC_DIFF4                   = 30440
Public Const SPC_DOUBLEOUT4              = 30441
Public Const SPC_FILTER4                 = 30480
Public Const SPC_ENABLEOUT4              = 30491
Public Const SPC_PATH4                   = 30490

Public Const SPC_OFFS5                   = 30500
Public Const SPC_AMP5                    = 30510
Public Const SPC_ACDC5                   = 30520
Public Const SPC_50OHM5                  = 30530
Public Const SPC_DIFF5                   = 30540
Public Const SPC_DOUBLEOUT5              = 30541
Public Const SPC_FILTER5                 = 30580
Public Const SPC_ENABLEOUT5              = 30591
Public Const SPC_PATH5                   = 30590

Public Const SPC_OFFS6                   = 30600
Public Const SPC_AMP6                    = 30610
Public Const SPC_ACDC6                   = 30620
Public Const SPC_50OHM6                  = 30630
Public Const SPC_DIFF6                   = 30640
Public Const SPC_DOUBLEOUT6              = 30641
Public Const SPC_FILTER6                 = 30680
Public Const SPC_ENABLEOUT6              = 30691
Public Const SPC_PATH6                   = 30690

Public Const SPC_OFFS7                   = 30700
Public Const SPC_AMP7                    = 30710
Public Const SPC_ACDC7                   = 30720
Public Const SPC_50OHM7                  = 30730
Public Const SPC_DIFF7                   = 30740
Public Const SPC_DOUBLEOUT7              = 30741
Public Const SPC_FILTER7                 = 30780
Public Const SPC_ENABLEOUT7              = 30791
Public Const SPC_PATH7                   = 30790

Public Const SPC_OFFS8                   = 30800
Public Const SPC_AMP8                    = 30810
Public Const SPC_ACDC8                   = 30820
Public Const SPC_50OHM8                  = 30830
Public Const SPC_DIFF8                   = 30840
Public Const SPC_PATH8                   = 30890

Public Const SPC_OFFS9                   = 30900
Public Const SPC_AMP9                    = 30910
Public Const SPC_ACDC9                   = 30920
Public Const SPC_50OHM9                  = 30930
Public Const SPC_DIFF9                   = 30940
Public Const SPC_PATH9                   = 30990

Public Const SPC_OFFS10                  = 31000
Public Const SPC_AMP10                   = 31010
Public Const SPC_ACDC10                  = 31020
Public Const SPC_50OHM10                 = 31030
Public Const SPC_DIFF10                  = 31040
Public Const SPC_PATH10                  = 31090

Public Const SPC_OFFS11                  = 31100
Public Const SPC_AMP11                   = 31110
Public Const SPC_ACDC11                  = 31120
Public Const SPC_50OHM11                 = 31130
Public Const SPC_DIFF11                  = 31140
Public Const SPC_PATH11                  = 31190

Public Const SPC_OFFS12                  = 31200
Public Const SPC_AMP12                   = 31210
Public Const SPC_ACDC12                  = 31220
Public Const SPC_50OHM12                 = 31230
Public Const SPC_DIFF12                  = 31240
Public Const SPC_PATH12                  = 31290

Public Const SPC_OFFS13                  = 31300
Public Const SPC_AMP13                   = 31310
Public Const SPC_ACDC13                  = 31320
Public Const SPC_50OHM13                 = 31330
Public Const SPC_DIFF13                  = 31340
Public Const SPC_PATH13                  = 31390

Public Const SPC_OFFS14                  = 31400
Public Const SPC_AMP14                   = 31410
Public Const SPC_ACDC14                  = 31420
Public Const SPC_50OHM14                 = 31430
Public Const SPC_DIFF14                  = 31440
Public Const SPC_PATH14                  = 31490

Public Const SPC_OFFS15                  = 31500
Public Const SPC_AMP15                   = 31510
Public Const SPC_ACDC15                  = 31520
Public Const SPC_50OHM15                 = 31530
Public Const SPC_DIFF15                  = 31540
Public Const SPC_PATH15                  = 31590

Public Const SPC_110OHMTRIGGER           = 30400
Public Const SPC_110OHMCLOCK             = 30410


Public Const   AMP_BI200                 = 200
Public Const   AMP_BI500                 = 500
Public Const   AMP_BI1000                = 1000
Public Const   AMP_BI2000                = 2000
Public Const   AMP_BI2500                = 2500
Public Const   AMP_BI4000                = 4000
Public Const   AMP_BI5000                = 5000
Public Const   AMP_BI10000               = 10000
Public Const   AMP_UNI400                = 100400
Public Const   AMP_UNI1000               = 101000
Public Const   AMP_UNI2000               = 102000


' ----- Trigger Settings -----
Public Const SPC_TRIGGERMODE             = 40000
Public Const SPC_TRIG_OUTPUT             = 40100
Public Const SPC_TRIGGEROUT              = 40100
Public Const SPC_TRIG_TERM               = 40110
Public Const SPC_TRIG_TERM0              = 40110
Public Const SPC_TRIGGER50OHM            = 40110
Public Const SPC_TRIGGER110OHM0          = 40110
Public Const SPC_TRIGGER75OHM0           = 40110
Public Const SPC_TRIG_TERM1              = 40111
Public Const SPC_TRIGGER110OHM1          = 40111
Public Const SPC_TRIG_EXT0_ACDC          = 40120
Public Const SPC_TRIG_EXT1_ACDC          = 40121
Public Const SPC_TRIG_EXT2_ACDC          = 40122

Public Const SPC_TRIGGERMODE0            = 40200
Public Const SPC_TRIGGERMODE1            = 40201
Public Const SPC_TRIGGERMODE2            = 40202
Public Const SPC_TRIGGERMODE3            = 40203
Public Const SPC_TRIGGERMODE4            = 40204
Public Const SPC_TRIGGERMODE5            = 40205
Public Const SPC_TRIGGERMODE6            = 40206
Public Const SPC_TRIGGERMODE7            = 40207
Public Const SPC_TRIGGERMODE8            = 40208
Public Const SPC_TRIGGERMODE9            = 40209
Public Const SPC_TRIGGERMODE10           = 40210
Public Const SPC_TRIGGERMODE11           = 40211
Public Const SPC_TRIGGERMODE12           = 40212
Public Const SPC_TRIGGERMODE13           = 40213
Public Const SPC_TRIGGERMODE14           = 40214
Public Const SPC_TRIGGERMODE15           = 40215

Public Const     TM_SOFTWARE             = 0
Public Const     TM_NOTRIGGER            = 10
Public Const     TM_CHXPOS               = 10000
Public Const     TM_CHXPOS_LP            = 10001
Public Const     TM_CHXPOS_SP            = 10002
Public Const     TM_CHXPOS_GS            = 10003
Public Const     TM_CHXPOS_SS            = 10004
Public Const     TM_CHXNEG               = 10010
Public Const     TM_CHXNEG_LP            = 10011
Public Const     TM_CHXNEG_SP            = 10012
Public Const     TM_CHXNEG_GS            = 10013
Public Const     TM_CHXNEG_SS            = 10014
Public Const     TM_CHXOFF               = 10020
Public Const     TM_CHXBOTH              = 10030
Public Const     TM_CHXWINENTER          = 10040
Public Const     TM_CHXWINENTER_LP       = 10041
Public Const     TM_CHXWINENTER_SP       = 10042
Public Const     TM_CHXWINLEAVE          = 10050
Public Const     TM_CHXWINLEAVE_LP       = 10051
Public Const     TM_CHXWINLEAVE_SP       = 10052
Public Const     TM_CHXLOW               = 10060
Public Const     TM_CHXHIGH              = 10061
Public Const     TM_CHXINWIN             = 10062
Public Const     TM_CHXOUTWIN            = 10063
Public Const     TM_CHXSPIKE             = 10064


Public Const     TM_CH0POS               = 10000
Public Const     TM_CH0NEG               = 10010
Public Const     TM_CH0OFF               = 10020
Public Const     TM_CH0BOTH              = 10030
Public Const     TM_CH1POS               = 10100
Public Const     TM_CH1NEG               = 10110
Public Const     TM_CH1OFF               = 10120
Public Const     TM_CH1BOTH              = 10130
Public Const     TM_CH2POS               = 10200
Public Const     TM_CH2NEG               = 10210
Public Const     TM_CH2OFF               = 10220
Public Const     TM_CH2BOTH              = 10230
Public Const     TM_CH3POS               = 10300
Public Const     TM_CH3NEG               = 10310
Public Const     TM_CH3OFF               = 10320
Public Const     TM_CH3BOTH              = 10330

Public Const     TM_TTLPOS               = 20000
Public Const     TM_TTLHIGH_LP           = 20001
Public Const     TM_TTLHIGH_SP           = 20002
Public Const     TM_TTLNEG               = 20010
Public Const     TM_TTLLOW_LP            = 20011
Public Const     TM_TTLLOW_SP            = 20012
Public Const     TM_TTL                  = 20020
Public Const     TM_TTLBOTH              = 20030
Public Const     TM_TTLBOTH_LP           = 20031
Public Const     TM_TTLBOTH_SP           = 20032
Public Const     TM_CHANNEL              = 20040
Public Const     TM_TTLHIGH              = 20050
Public Const     TM_TTLLOW               = 20051
Public Const     TM_PATTERN              = 21000
Public Const     TM_PATTERN_LP           = 21001
Public Const     TM_PATTERN_SP           = 21002
Public Const     TM_PATTERNANDEDGE       = 22000
Public Const     TM_PATTERNANDEDGE_LP    = 22001
Public Const     TM_PATTERNANDEDGE_SP    = 22002
Public Const     TM_GATELOW              = 30000
Public Const     TM_GATEHIGH             = 30010
Public Const     TM_GATEPATTERN          = 30020
Public Const     TM_CHOR                 = 35000
Public Const     TM_CHAND                = 35010
Public Const     TM_CHORTTLPOS           = 35020
Public Const     TM_CHORTTLNEG           = 35021

Public Const SPC_PXITRGOUT               = 40300
Public Const     PTO_OFF                  = 0
Public Const     PTO_LINE0                = 1
Public Const     PTO_LINE1                = 2
Public Const     PTO_LINE2                = 3
Public Const     PTO_LINE3                = 4
Public Const     PTO_LINE4                = 5
Public Const     PTO_LINE5                = 6
Public Const     PTO_LINE6                = 7
Public Const     PTO_LINE7                = 8
Public Const     PTO_LINESTAR             = 9
Public Const SPC_PXITRGOUT_AVAILABLE     = 40301  ' bitmap register

Public Const SPC_PXISTARTRG_DIVRST_OUT   = 40302  ' bitmap register
Public Const SPC_PXISTARTRG_DIVRST_OUT_AVAILABLE   = 40303
Public Const SPC_PXISTARTRG_OUT          = 40304  ' bitmap register
Public Const     PSTO_LINESTAR0           = &H00000001&
Public Const     PSTO_LINESTAR1           = &H00000002&
Public Const     PSTO_LINESTAR2           = &H00000004&
Public Const     PSTO_LINESTAR3           = &H00000008&
Public Const     PSTO_LINESTAR4           = &H00000010&
Public Const     PSTO_LINESTAR5           = &H00000020&
Public Const     PSTO_LINESTAR6           = &H00000040&
Public Const     PSTO_LINESTAR7           = &H00000080&
Public Const     PSTO_LINESTAR8           = &H00000100&
Public Const     PSTO_LINESTAR9           = &H00000200&
Public Const     PSTO_LINESTAR10          = &H00000400&
Public Const     PSTO_LINESTAR11          = &H00000800&
Public Const     PSTO_LINESTAR12          = &H00001000&
Public Const     PSTO_LINE0               = &H00010000&
Public Const     PSTO_LINE1               = &H00020000&
Public Const     PSTO_LINE2               = &H00040000&
Public Const     PSTO_LINE3               = &H00080000&
Public Const     PSTO_LINE4               = &H00100000&
Public Const     PSTO_LINE5               = &H00200000&
Public Const     PSTO_LINE6               = &H00400000&
Public Const     PSTO_LINE7               = &H00800000&
Public Const SPC_PXISTARTRG_OUT_AVAILABLE          = 40305

Public Const SPC_PXITRGIN                = 40310  ' bitmap register
Public Const     PTI_OFF                  = 0
Public Const     PTI_LINE0                = 1
Public Const     PTI_LINE1                = 2
Public Const     PTI_LINE2                = 4
Public Const     PTI_LINE3                = 8
Public Const     PTI_LINE4                = 16
Public Const     PTI_LINE5                = 32
Public Const     PTI_LINE6                = 64
Public Const     PTI_LINE7                = 128
Public Const     PTI_LINESTAR             = 256
Public Const SPC_PXITRGIN_AVAILABLE      = 40311  ' bitmap register
Public Const SPC_PXI_DIVIDER_RESET_IN            = 40320
Public Const SPC_PXI_DIVIDER_RESET_IN_AVAILABLE  = 40321


' new registers of M2i driver
Public Const SPC_TRIG_AVAILORMASK        = 40400
Public Const SPC_TRIG_ORMASK             = 40410
Public Const SPC_TRIG_AVAILANDMASK       = 40420
Public Const SPC_TRIG_ANDMASK            = 40430
Public Const     SPC_TMASK_NONE          = &H00000000&
Public Const     SPC_TMASK_SOFTWARE      = &H00000001&
Public Const     SPC_TMASK_EXT0          = &H00000002&
Public Const     SPC_TMASK_EXT1          = &H00000004&
Public Const     SPC_TMASK_EXT2          = &H00000008&
Public Const     SPC_TMASK_EXT3          = &H00000010&
Public Const     SPC_TMASK_XIO0          = &H00000100&
Public Const     SPC_TMASK_XIO1          = &H00000200&
Public Const     SPC_TMASK_XIO2          = &H00000400&
Public Const     SPC_TMASK_XIO3          = &H00000800&
Public Const     SPC_TMASK_XIO4          = &H00001000&
Public Const     SPC_TMASK_XIO5          = &H00002000&
Public Const     SPC_TMASK_XIO6          = &H00004000&
Public Const     SPC_TMASK_XIO7          = &H00008000&
Public Const     SPC_TMASK_PXI0          = &H00100000&
Public Const     SPC_TMASK_PXI1          = &H00200000&
Public Const     SPC_TMASK_PXI2          = &H00400000&
Public Const     SPC_TMASK_PXI3          = &H00800000&
Public Const     SPC_TMASK_PXI4          = &H01000000&
Public Const     SPC_TMASK_PXI5          = &H02000000&
Public Const     SPC_TMASK_PXI6          = &H04000000&
Public Const     SPC_TMASK_PXI7          = &H08000000&
Public Const     SPC_TMASK_PXISTAR       = &H10000000&
Public Const     SPC_TMASK_PXIDSTARB     = &H20000000&

Public Const SPC_TRIG_CH_AVAILORMASK0    = 40450
Public Const SPC_TRIG_CH_AVAILORMASK1    = 40451
Public Const SPC_TRIG_CH_ORMASK0         = 40460
Public Const SPC_TRIG_CH_ORMASK1         = 40461
Public Const SPC_TRIG_CH_AVAILANDMASK0   = 40470
Public Const SPC_TRIG_CH_AVAILANDMASK1   = 40471
Public Const SPC_TRIG_CH_ANDMASK0        = 40480 
Public Const SPC_TRIG_CH_ANDMASK1        = 40481 
Public Const     SPC_TMASK0_NONE         = &H00000000&
Public Const     SPC_TMASK0_CH0          = &H00000001&
Public Const     SPC_TMASK0_CH1          = &H00000002&
Public Const     SPC_TMASK0_CH2          = &H00000004&
Public Const     SPC_TMASK0_CH3          = &H00000008&
Public Const     SPC_TMASK0_CH4          = &H00000010&
Public Const     SPC_TMASK0_CH5          = &H00000020&
Public Const     SPC_TMASK0_CH6          = &H00000040&
Public Const     SPC_TMASK0_CH7          = &H00000080&
Public Const     SPC_TMASK0_CH8          = &H00000100&
Public Const     SPC_TMASK0_CH9          = &H00000200&
Public Const     SPC_TMASK0_CH10         = &H00000400&
Public Const     SPC_TMASK0_CH11         = &H00000800&
Public Const     SPC_TMASK0_CH12         = &H00001000&
Public Const     SPC_TMASK0_CH13         = &H00002000&
Public Const     SPC_TMASK0_CH14         = &H00004000&
Public Const     SPC_TMASK0_CH15         = &H00008000&
Public Const     SPC_TMASK0_CH16         = &H00010000&
Public Const     SPC_TMASK0_CH17         = &H00020000&
Public Const     SPC_TMASK0_CH18         = &H00040000&
Public Const     SPC_TMASK0_CH19         = &H00080000&
Public Const     SPC_TMASK0_CH20         = &H00100000&
Public Const     SPC_TMASK0_CH21         = &H00200000&
Public Const     SPC_TMASK0_CH22         = &H00400000&
Public Const     SPC_TMASK0_CH23         = &H00800000&
Public Const     SPC_TMASK0_CH24         = &H01000000&
Public Const     SPC_TMASK0_CH25         = &H02000000&
Public Const     SPC_TMASK0_CH26         = &H04000000&
Public Const     SPC_TMASK0_CH27         = &H08000000&
Public Const     SPC_TMASK0_CH28         = &H10000000&
Public Const     SPC_TMASK0_CH29         = &H20000000&
Public Const     SPC_TMASK0_CH30         = &H40000000&
Public Const     SPC_TMASK0_CH31         = &H80000000&

Public Const     SPC_TMASK1_NONE         = &H00000000&
Public Const     SPC_TMASK1_CH32         = &H00000001&
Public Const     SPC_TMASK1_CH33         = &H00000002&
Public Const     SPC_TMASK1_CH34         = &H00000004&
Public Const     SPC_TMASK1_CH35         = &H00000008&
Public Const     SPC_TMASK1_CH36         = &H00000010&
Public Const     SPC_TMASK1_CH37         = &H00000020&
Public Const     SPC_TMASK1_CH38         = &H00000040&
Public Const     SPC_TMASK1_CH39         = &H00000080&
Public Const     SPC_TMASK1_CH40         = &H00000100&
Public Const     SPC_TMASK1_CH41         = &H00000200&
Public Const     SPC_TMASK1_CH42         = &H00000400&
Public Const     SPC_TMASK1_CH43         = &H00000800&
Public Const     SPC_TMASK1_CH44         = &H00001000&
Public Const     SPC_TMASK1_CH45         = &H00002000&
Public Const     SPC_TMASK1_CH46         = &H00004000&
Public Const     SPC_TMASK1_CH47         = &H00008000&
Public Const     SPC_TMASK1_CH48         = &H00010000&
Public Const     SPC_TMASK1_CH49         = &H00020000&
Public Const     SPC_TMASK1_CH50         = &H00040000&
Public Const     SPC_TMASK1_CH51         = &H00080000&
Public Const     SPC_TMASK1_CH52         = &H00100000&
Public Const     SPC_TMASK1_CH53         = &H00200000&
Public Const     SPC_TMASK1_CH54         = &H00400000&
Public Const     SPC_TMASK1_CH55         = &H00800000&
Public Const     SPC_TMASK1_CH56         = &H01000000&
Public Const     SPC_TMASK1_CH57         = &H02000000&
Public Const     SPC_TMASK1_CH58         = &H04000000&
Public Const     SPC_TMASK1_CH59         = &H08000000&
Public Const     SPC_TMASK1_CH60         = &H10000000&
Public Const     SPC_TMASK1_CH61         = &H20000000&
Public Const     SPC_TMASK1_CH62         = &H40000000&
Public Const     SPC_TMASK1_CH63         = &H80000000&

Public Const SPC_TRIG_EXT_AVAILMODES     = 40500
Public Const SPC_TRIG_EXT0_AVAILMODES    = 40500
Public Const SPC_TRIG_EXT1_AVAILMODES    = 40501
Public Const SPC_TRIG_EXT2_AVAILMODES    = 40502
Public Const SPC_TRIG_EXT0_AVAILMODESOR  = 40503
Public Const SPC_TRIG_EXT1_AVAILMODESOR  = 40504
Public Const SPC_TRIG_EXT2_AVAILMODESOR  = 40505
Public Const SPC_TRIG_EXT0_AVAILMODESAND = 40506
Public Const SPC_TRIG_EXT1_AVAILMODESAND = 40507
Public Const SPC_TRIG_EXT2_AVAILMODESAND = 40508
Public Const SPC_TRIG_EXT3_AVAILMODESAND = 40509
Public Const SPC_TRIG_EXT0_MODE          = 40510
Public Const SPC_TRIG_EXT1_MODE          = 40511
Public Const SPC_TRIG_EXT2_MODE          = 40512
Public Const SPC_TRIG_EXT3_MODE          = 40513
Public Const SPC_TRIG_EXT3_AVAILMODES    = 40514
Public Const SPC_TRIG_EXT3_AVAILMODESOR  = 40515

Public Const SPC_TRIG_EXT0_READFEATURES  = 40520
Public Const SPC_TRIG_EXT1_READFEATURES  = 40521
Public Const SPC_TRIG_EXT2_READFEATURES  = 40522
Public Const SPC_TRIG_EXT3_READFEATURES  = 40523
Public Const     SPCM_TRFEAT_TERM            = &H00000001&
Public Const     SPCM_TRFEAT_HIGHIMP         = &H00000002&
Public Const     SPCM_TRFEAT_DCCOUPLING      = &H00000004&
Public Const     SPCM_TRFEAT_ACCOUPLING      = &H00000008&
Public Const     SPCM_TRFEAT_SE              = &H00000010&
Public Const     SPCM_TRFEAT_DIFF            = &H00000020&
Public Const     SPCM_TRFEAT_LEVELPROG       = &H00000100&
Public Const     SPCM_TRFEAT_PROGTHRESHOLD   = &H00000200&

' legacy constants: not enough contiguous constants possible for X4..X19
Public Const SPC_LEGACY_X0_READFEATURES  = 40530
Public Const SPC_LEGACY_X1_READFEATURES  = 40531
Public Const SPC_LEGACY_X2_READFEATURES  = 40532
Public Const SPC_LEGACY_X3_READFEATURES  = 40533

' legacy constants: not enough contiguous constants possible for X4..X19
Public Const SPC_LEGACY_X0_TERM          = 40535
Public Const SPC_LEGACY_X1_TERM          = 40536
Public Const SPC_LEGACY_X2_TERM          = 40537
Public Const SPC_LEGACY_X3_TERM          = 40538

Public Const SPC_TRIG_XIO_AVAILMODES     = 40550
Public Const SPC_TRIG_XIO_AVAILMODESOR   = 40551
Public Const SPC_TRIG_XIO_AVAILMODESAND  = 40552
Public Const SPC_TRIG_XIO0_MODE          = 40560
Public Const SPC_TRIG_XIO1_MODE          = 40561
Public Const     SPC_TM_MODEMASK         = &H00FFFFFF&
Public Const     SPC_TM_NONE             = &H00000000&
Public Const     SPC_TM_POS              = &H00000001&
Public Const     SPC_TM_NEG              = &H00000002&
Public Const     SPC_TM_BOTH             = &H00000004&
Public Const     SPC_TM_HIGH             = &H00000008&
Public Const     SPC_TM_LOW              = &H00000010&
Public Const     SPC_TM_WINENTER         = &H00000020&
Public Const     SPC_TM_WINLEAVE         = &H00000040&
Public Const     SPC_TM_INWIN            = &H00000080&
Public Const     SPC_TM_OUTSIDEWIN       = &H00000100&
Public Const     SPC_TM_SPIKE            = &H00000200&
Public Const     SPC_TM_PATTERN          = &H00000400&
Public Const     SPC_TM_STEEPPOS         = &H00000800&
Public Const     SPC_TM_STEEPNEG         = &H00001000&
Public Const     SPC_TM_EXTRAMASK        = &HFF000000&
Public Const     SPC_TM_REARM            = &H01000000&
Public Const     SPC_TM_PW_SMALLER       = &H02000000&
Public Const     SPC_TM_PW_GREATER       = &H04000000&
Public Const     SPC_TM_DOUBLEEDGE       = &H08000000&
Public Const     SPC_TM_PULSESTRETCH     = &H10000000&
Public Const     SPC_TM_HYSTERESIS       = &H20000000&

Public Const SPC_TRIG_PATTERN_AVAILMODES = 40580
Public Const SPC_TRIG_PATTERN_MODE       = 40590

Public Const SPC_TRIG_CH_AVAILMODES      = 40600
Public Const SPC_TRIG_CH_AVAILMODESOR    = 40601
Public Const SPC_TRIG_CH_AVAILMODESAND   = 40602
Public Const SPC_TRIG_CH0_MODE           = 40610
Public Const SPC_TRIG_CH1_MODE           = 40611
Public Const SPC_TRIG_CH2_MODE           = 40612
Public Const SPC_TRIG_CH3_MODE           = 40613
Public Const SPC_TRIG_CH4_MODE           = 40614
Public Const SPC_TRIG_CH5_MODE           = 40615
Public Const SPC_TRIG_CH6_MODE           = 40616
Public Const SPC_TRIG_CH7_MODE           = 40617
Public Const SPC_TRIG_CH8_MODE           = 40618
Public Const SPC_TRIG_CH9_MODE           = 40619
Public Const SPC_TRIG_CH10_MODE          = 40620
Public Const SPC_TRIG_CH11_MODE          = 40621
Public Const SPC_TRIG_CH12_MODE          = 40622
Public Const SPC_TRIG_CH13_MODE          = 40623
Public Const SPC_TRIG_CH14_MODE          = 40624
Public Const SPC_TRIG_CH15_MODE          = 40625
Public Const SPC_TRIG_CH16_MODE          = 40626
Public Const SPC_TRIG_CH17_MODE          = 40627
Public Const SPC_TRIG_CH18_MODE          = 40628
Public Const SPC_TRIG_CH19_MODE          = 40629
Public Const SPC_TRIG_CH20_MODE          = 40630
Public Const SPC_TRIG_CH21_MODE          = 40631
Public Const SPC_TRIG_CH22_MODE          = 40632
Public Const SPC_TRIG_CH23_MODE          = 40633
Public Const SPC_TRIG_CH24_MODE          = 40634
Public Const SPC_TRIG_CH25_MODE          = 40635
Public Const SPC_TRIG_CH26_MODE          = 40636
Public Const SPC_TRIG_CH27_MODE          = 40637
Public Const SPC_TRIG_CH28_MODE          = 40638
Public Const SPC_TRIG_CH29_MODE          = 40639
Public Const SPC_TRIG_CH30_MODE          = 40640
Public Const SPC_TRIG_CH31_MODE          = 40641

Public Const SPC_TRIG_CH32_MODE          = 40642
Public Const SPC_TRIG_CH33_MODE          = 40643
Public Const SPC_TRIG_CH34_MODE          = 40644
Public Const SPC_TRIG_CH35_MODE          = 40645
Public Const SPC_TRIG_CH36_MODE          = 40646
Public Const SPC_TRIG_CH37_MODE          = 40647
Public Const SPC_TRIG_CH38_MODE          = 40648
Public Const SPC_TRIG_CH39_MODE          = 40649
Public Const SPC_TRIG_CH40_MODE          = 40650
Public Const SPC_TRIG_CH41_MODE          = 40651
Public Const SPC_TRIG_CH42_MODE          = 40652
Public Const SPC_TRIG_CH43_MODE          = 40653
Public Const SPC_TRIG_CH44_MODE          = 40654
Public Const SPC_TRIG_CH45_MODE          = 40655
Public Const SPC_TRIG_CH46_MODE          = 40656
Public Const SPC_TRIG_CH47_MODE          = 40657
Public Const SPC_TRIG_CH48_MODE          = 40658
Public Const SPC_TRIG_CH49_MODE          = 40659
Public Const SPC_TRIG_CH50_MODE          = 40660
Public Const SPC_TRIG_CH51_MODE          = 40661
Public Const SPC_TRIG_CH52_MODE          = 40662
Public Const SPC_TRIG_CH53_MODE          = 40663
Public Const SPC_TRIG_CH54_MODE          = 40664
Public Const SPC_TRIG_CH55_MODE          = 40665
Public Const SPC_TRIG_CH56_MODE          = 40666
Public Const SPC_TRIG_CH57_MODE          = 40667
Public Const SPC_TRIG_CH58_MODE          = 40668
Public Const SPC_TRIG_CH59_MODE          = 40669
Public Const SPC_TRIG_CH60_MODE          = 40670
Public Const SPC_TRIG_CH61_MODE          = 40671
Public Const SPC_TRIG_CH62_MODE          = 40672
Public Const SPC_TRIG_CH63_MODE          = 40673


Public Const SPC_TRIG_AVAILDELAY         = 40800
Public Const SPC_TRIG_AVAILDELAY_STEP    = 40801
Public Const SPC_TRIG_DELAY              = 40810

Public Const SPC_TRIG_AVAILHOLDOFF       = 40802
Public Const SPC_TRIG_AVAILHOLDOFF_STEP  = 40803
Public Const SPC_TRIG_HOLDOFF            = 40811

Public Const SPC_SINGLESHOT              = 41000
Public Const SPC_OUTONTRIGGER            = 41100
Public Const SPC_RESTARTCONT             = 41200
Public Const SPC_SINGLERESTART           = 41300

Public Const SPC_TRIGGERLEVEL            = 42000
Public Const SPC_TRIGGERLEVEL0           = 42000
Public Const SPC_TRIGGERLEVEL1           = 42001
Public Const SPC_TRIGGERLEVEL2           = 42002
Public Const SPC_TRIGGERLEVEL3           = 42003
Public Const SPC_TRIGGERLEVEL4           = 42004
Public Const SPC_TRIGGERLEVEL5           = 42005
Public Const SPC_TRIGGERLEVEL6           = 42006
Public Const SPC_TRIGGERLEVEL7           = 42007
Public Const SPC_TRIGGERLEVEL8           = 42008
Public Const SPC_TRIGGERLEVEL9           = 42009
Public Const SPC_TRIGGERLEVEL10          = 42010
Public Const SPC_TRIGGERLEVEL11          = 42011
Public Const SPC_TRIGGERLEVEL12          = 42012
Public Const SPC_TRIGGERLEVEL13          = 42013
Public Const SPC_TRIGGERLEVEL14          = 42014
Public Const SPC_TRIGGERLEVEL15          = 42015

Public Const SPC_AVAILHIGHLEVEL_MIN      = 41997
Public Const SPC_AVAILHIGHLEVEL_MAX      = 41998
Public Const SPC_AVAILHIGHLEVEL_STEP     = 41999

Public Const SPC_HIGHLEVEL0              = 42000
Public Const SPC_HIGHLEVEL1              = 42001
Public Const SPC_HIGHLEVEL2              = 42002
Public Const SPC_HIGHLEVEL3              = 42003
Public Const SPC_HIGHLEVEL4              = 42004
Public Const SPC_HIGHLEVEL5              = 42005
Public Const SPC_HIGHLEVEL6              = 42006
Public Const SPC_HIGHLEVEL7              = 42007
Public Const SPC_HIGHLEVEL8              = 42008
Public Const SPC_HIGHLEVEL9              = 42009
Public Const SPC_HIGHLEVEL10             = 42010
Public Const SPC_HIGHLEVEL11             = 42011
Public Const SPC_HIGHLEVEL12             = 42012
Public Const SPC_HIGHLEVEL13             = 42013
Public Const SPC_HIGHLEVEL14             = 42014
Public Const SPC_HIGHLEVEL15             = 42015

Public Const SPC_AVAILLOWLEVEL_MIN       = 42097
Public Const SPC_AVAILLOWLEVEL_MAX       = 42098
Public Const SPC_AVAILLOWLEVEL_STEP      = 42099

Public Const SPC_LOWLEVEL0               = 42100
Public Const SPC_LOWLEVEL1               = 42101
Public Const SPC_LOWLEVEL2               = 42102
Public Const SPC_LOWLEVEL3               = 42103
Public Const SPC_LOWLEVEL4               = 42104
Public Const SPC_LOWLEVEL5               = 42105
Public Const SPC_LOWLEVEL6               = 42106
Public Const SPC_LOWLEVEL7               = 42107
Public Const SPC_LOWLEVEL8               = 42108
Public Const SPC_LOWLEVEL9               = 42109
Public Const SPC_LOWLEVEL10              = 42110
Public Const SPC_LOWLEVEL11              = 42111
Public Const SPC_LOWLEVEL12              = 42112
Public Const SPC_LOWLEVEL13              = 42113
Public Const SPC_LOWLEVEL14              = 42114
Public Const SPC_LOWLEVEL15              = 42115

Public Const SPC_TRIG_CH0_LEVEL0         = 42200
Public Const SPC_TRIG_CH1_LEVEL0         = 42201
Public Const SPC_TRIG_CH2_LEVEL0         = 42202
Public Const SPC_TRIG_CH3_LEVEL0         = 42203
Public Const SPC_TRIG_CH4_LEVEL0         = 42204
Public Const SPC_TRIG_CH5_LEVEL0         = 42205
Public Const SPC_TRIG_CH6_LEVEL0         = 42206
Public Const SPC_TRIG_CH7_LEVEL0         = 42207
Public Const SPC_TRIG_CH8_LEVEL0         = 42208
Public Const SPC_TRIG_CH9_LEVEL0         = 42209
Public Const SPC_TRIG_CH10_LEVEL0        = 42210
Public Const SPC_TRIG_CH11_LEVEL0        = 42211
Public Const SPC_TRIG_CH12_LEVEL0        = 42212
Public Const SPC_TRIG_CH13_LEVEL0        = 42213
Public Const SPC_TRIG_CH14_LEVEL0        = 42214
Public Const SPC_TRIG_CH15_LEVEL0        = 42215

Public Const SPC_TRIG_CH0_LEVEL1         = 42300
Public Const SPC_TRIG_CH1_LEVEL1         = 42301
Public Const SPC_TRIG_CH2_LEVEL1         = 42302
Public Const SPC_TRIG_CH3_LEVEL1         = 42303
Public Const SPC_TRIG_CH4_LEVEL1         = 42304
Public Const SPC_TRIG_CH5_LEVEL1         = 42305
Public Const SPC_TRIG_CH6_LEVEL1         = 42306
Public Const SPC_TRIG_CH7_LEVEL1         = 42307
Public Const SPC_TRIG_CH8_LEVEL1         = 42308
Public Const SPC_TRIG_CH9_LEVEL1         = 42309
Public Const SPC_TRIG_CH10_LEVEL1        = 42310
Public Const SPC_TRIG_CH11_LEVEL1        = 42311
Public Const SPC_TRIG_CH12_LEVEL1        = 42312
Public Const SPC_TRIG_CH13_LEVEL1        = 42313
Public Const SPC_TRIG_CH14_LEVEL1        = 42314
Public Const SPC_TRIG_CH15_LEVEL1        = 42315

Public Const SPC_TRIG_EXT0_LEVEL0        = 42320
Public Const SPC_TRIG_EXT1_LEVEL0        = 42321
Public Const SPC_TRIG_EXT2_LEVEL0        = 42322

Public Const SPC_TRIG_EXT0_LEVEL1        = 42330
Public Const SPC_TRIG_EXT1_LEVEL1        = 42331
Public Const SPC_TRIG_EXT2_LEVEL1        = 42332

Public Const SPC_TRIG_EXT_AVAIL0_MIN     = 42340
Public Const SPC_TRIG_EXT_AVAIL0_MAX     = 42341
Public Const SPC_TRIG_EXT_AVAIL0_STEP    = 42342

Public Const SPC_TRIG_EXT_AVAIL1_MIN     = 42345
Public Const SPC_TRIG_EXT_AVAIL1_MAX     = 42346
Public Const SPC_TRIG_EXT_AVAIL1_STEP    = 42347

' threshold levels (for 77xx)
Public Const SPC_THRESHOLD0              = 42400  ' threshold level for channel group 0
Public Const SPC_THRESHOLD1              = 42401  ' threshold level for channel group 1
Public Const SPC_THRESHOLD2              = 42402  ' threshold level for channel group 2
Public Const SPC_THRESHOLD3              = 42403  ' threshold level for channel group 3
Public Const SPC_CLOCK_THRESHOLD         = 42410  ' threshold level for clock input
Public Const SPC_TRIG_THRESHOLD          = 42411  ' threshold level for trigger input
Public Const SPC_X0X1_THRESHOLD          = 42412  ' threshold level for X0/X1 input
Public Const SPC_STROBE_THRESHOLD        = 42413  ' threshold level for strobe input

Public Const SPC_AVAILTHRESHOLD_MIN      = 42420
Public Const SPC_AVAILTHRESHOLD_MAX      = 42421
Public Const SPC_AVAILTHRESHOLD_STEP     = 42422

Public Const SPC_CLOCK_AVAILTHRESHOLD_MIN  = 42423
Public Const SPC_CLOCK_AVAILTHRESHOLD_MAX  = 42424
Public Const SPC_CLOCK_AVAILTHRESHOLD_STEP = 42425

Public Const SPC_TRIG_AVAILTHRESHOLD_MIN  = 42426
Public Const SPC_TRIG_AVAILTHRESHOLD_MAX  = 42427
Public Const SPC_TRIG_AVAILTHRESHOLD_STEP = 42428

Public Const SPC_TRIGGERPATTERN          = 43000
Public Const SPC_TRIGGERPATTERN0         = 43000
Public Const SPC_TRIGGERPATTERN1         = 43001
Public Const SPC_TRIGGERMASK             = 43100
Public Const SPC_TRIGGERMASK0            = 43100
Public Const SPC_TRIGGERMASK1            = 43101

Public Const SPC_PULSEWIDTH              = 44000
Public Const SPC_PULSEWIDTH0             = 44000
Public Const SPC_PULSEWIDTH1             = 44001

Public Const SPC_TRIG_CH_AVAILPULSEWIDTH = 44100
Public Const SPC_TRIG_CH_PULSEWIDTH      = 44101
Public Const SPC_TRIG_CH0_PULSEWIDTH     = 44101
Public Const SPC_TRIG_CH1_PULSEWIDTH     = 44102
Public Const SPC_TRIG_CH2_PULSEWIDTH     = 44103
Public Const SPC_TRIG_CH3_PULSEWIDTH     = 44104
Public Const SPC_TRIG_CH4_PULSEWIDTH     = 44105
Public Const SPC_TRIG_CH5_PULSEWIDTH     = 44106
Public Const SPC_TRIG_CH6_PULSEWIDTH     = 44107
Public Const SPC_TRIG_CH7_PULSEWIDTH     = 44108
Public Const SPC_TRIG_CH8_PULSEWIDTH     = 44109
Public Const SPC_TRIG_CH9_PULSEWIDTH     = 44110
Public Const SPC_TRIG_CH10_PULSEWIDTH    = 44111
Public Const SPC_TRIG_CH11_PULSEWIDTH    = 44112
Public Const SPC_TRIG_CH12_PULSEWIDTH    = 44113
Public Const SPC_TRIG_CH13_PULSEWIDTH    = 44114
Public Const SPC_TRIG_CH14_PULSEWIDTH    = 44115
Public Const SPC_TRIG_CH15_PULSEWIDTH    = 44116

Public Const SPC_TRIG_EXT_AVAILPULSEWIDTH = 44200
Public Const SPC_TRIG_EXT0_PULSEWIDTH    = 44210
Public Const SPC_TRIG_EXT1_PULSEWIDTH    = 44211
Public Const SPC_TRIG_EXT2_PULSEWIDTH    = 44212
Public Const SPC_TRIG_EXT3_PULSEWIDTH    = 44213

' available dividers for MICX
Public Const SPC_READCLOCKDIVCOUNT       = 44300
Public Const SPC_CLOCKDIV0               = 44301
Public Const SPC_CLOCKDIV1               = 44302
Public Const SPC_CLOCKDIV2               = 44303
Public Const SPC_CLOCKDIV3               = 44304
Public Const SPC_CLOCKDIV4               = 44305
Public Const SPC_CLOCKDIV5               = 44306
Public Const SPC_CLOCKDIV6               = 44307
Public Const SPC_CLOCKDIV7               = 44308
Public Const SPC_CLOCKDIV8               = 44309
Public Const SPC_CLOCKDIV9               = 44310
Public Const SPC_CLOCKDIV10              = 44311
Public Const SPC_CLOCKDIV11              = 44312
Public Const SPC_CLOCKDIV12              = 44313
Public Const SPC_CLOCKDIV13              = 44314
Public Const SPC_CLOCKDIV14              = 44315
Public Const SPC_CLOCKDIV15              = 44316
Public Const SPC_CLOCKDIV16              = 44317

Public Const SPC_READTROFFSET            = 45000
Public Const SPC_TRIGGEREDGE             = 46000
Public Const SPC_TRIGGEREDGE0            = 46000
Public Const SPC_TRIGGEREDGE1            = 46001
Public Const     TE_POS                  = 10000
Public Const     TE_NEG                  = 10010
Public Const     TE_BOTH                 = 10020
Public Const     TE_NONE                 = 10030


' ----- Timestamp -----
Public Const CH_TIMESTAMP                = 9999

Public Const SPC_TIMESTAMP_CMD           = 47000
Public Const     TS_RESET                    = 0
Public Const     TS_MODE_DISABLE             = 10
Public Const     TS_MODE_STARTRESET          = 11
Public Const     TS_MODE_STANDARD            = 12
Public Const     TS_MODE_REFCLOCK            = 13
Public Const     TS_MODE_TEST5555            = 90
Public Const     TS_MODE_TESTAAAA            = 91
Public Const     TS_MODE_ZHTEST              = 92

' ----- modes for M2i, M3i, M4i, M4x, M2p hardware (bitmap) -----
Public Const SPC_TIMESTAMP_AVAILMODES    = 47001
Public Const     SPC_TSMODE_DISABLE      = &H00000000&
Public Const     SPC_TS_RESET            = &H00000001&
Public Const     SPC_TSMODE_STANDARD     = &H00000002&
Public Const     SPC_TSMODE_STARTRESET   = &H00000004&
Public Const     SPC_TS_RESET_WAITREFCLK = &H00000008&
Public Const     SPC_TSCNT_INTERNAL      = &H00000100&
Public Const     SPC_TSCNT_REFCLOCKPOS   = &H00000200&
Public Const     SPC_TSCNT_REFCLOCKNEG   = &H00000400&
Public Const     SPC_TSFEAT_NONE         = &H00000000&
Public Const     SPC_TSFEAT_STORE1STABA  = &H00010000&
Public Const     SPC_TSFEAT_INCRMODE     = &H00020000&
Public Const     SPC_TSFEAT_INCRMODE12   = &H00040000&
Public Const     SPC_TSFEAT_TRGSRC       = &H00080000&

Public Const     SPC_TSXIOACQ_DISABLE    = &H00000000&
Public Const     SPC_TSXIOACQ_ENABLE     = &H00001000&
Public Const     SPC_TSXIOINC_ENABLE     = &H00002000&
Public Const     SPC_TSXIOINC12_ENABLE   = &H00004000&

Public Const     SPC_TSMODE_MASK         = &H000000FF&
Public Const     SPC_TSCNT_MASK          = &H00000F00&
Public Const     SPC_TSFEAT_MASK         = &H000F0000&

Public Const     SPC_TRGSRC_MASK_CH0       = &H00000001&
Public Const     SPC_TRGSRC_MASK_CH1       = &H00000002&
Public Const     SPC_TRGSRC_MASK_CH2       = &H00000004&
Public Const     SPC_TRGSRC_MASK_CH3       = &H00000008&
Public Const     SPC_TRGSRC_MASK_CH4       = &H00000010&
Public Const     SPC_TRGSRC_MASK_CH5       = &H00000020&
Public Const     SPC_TRGSRC_MASK_CH6       = &H00000040&
Public Const     SPC_TRGSRC_MASK_CH7       = &H00000080&
Public Const     SPC_TRGSRC_MASK_EXT0      = &H00000100&
Public Const     SPC_TRGSRC_MASK_EXT1      = &H00000200&
Public Const     SPC_TRGSRC_MASK_FORCE     = &H00000400&
' space for digital channels using TSXIOACQ_ENABLE of standard multi-purpose lines
Public Const     SPC_TRGSRC_MASK_PXI0      = &H00010000&
Public Const     SPC_TRGSRC_MASK_PXI1      = &H00020000&
Public Const     SPC_TRGSRC_MASK_PXI2      = &H00040000&
Public Const     SPC_TRGSRC_MASK_PXI3      = &H00080000&
Public Const     SPC_TRGSRC_MASK_PXI4      = &H00100000&
Public Const     SPC_TRGSRC_MASK_PXI5      = &H00200000&
Public Const     SPC_TRGSRC_MASK_PXI6      = &H00400000&
Public Const     SPC_TRGSRC_MASK_PXI7      = &H00800000&
Public Const     SPC_TRGSRC_MASK_PXISTAR   = &H01000000&
Public Const     SPC_TRGSRC_MASK_PXIDSTARB = &H02000000&
Public Const     SPC_TRGSRC_MASK_X1        = &H20000000&
Public Const     SPC_TRGSRC_MASK_X2        = &H40000000&
Public Const     SPC_TRGSRC_MASK_X3        = &H80000000&
' space for more digital channels using TSXIOACQ_ENABLE of additional multi-purpose lines (optional)


Public Const SPC_TIMESTAMP_STATUS        = 47010
Public Const     TS_FIFO_EMPTY               = 0
Public Const     TS_FIFO_LESSHALF            = 1
Public Const     TS_FIFO_MOREHALF            = 2
Public Const     TS_FIFO_OVERFLOW            = 3

Public Const SPC_TIMESTAMP_COUNT         = 47020
Public Const SPC_TIMESTAMP_STARTTIME     = 47030
Public Const SPC_TIMESTAMP_STARTDATE     = 47031
Public Const SPC_TIMESTAMP_FIFO          = 47040
Public Const SPC_TIMESTAMP_TIMEOUT       = 47045

Public Const SPC_TIMESTAMP_RESETMODE     = 47050
Public Const     TS_RESET_POS               = 10
Public Const     TS_RESET_NEG               = 20



' ----- Extra I/O module -----
Public Const SPC_XIO_DIRECTION           = 47100
Public Const     XD_CH0_INPUT                = 0
Public Const     XD_CH0_OUTPUT               = 1
Public Const     XD_CH1_INPUT                = 0
Public Const     XD_CH1_OUTPUT               = 2
Public Const     XD_CH2_INPUT                = 0
Public Const     XD_CH2_OUTPUT               = 4
Public Const SPC_XIO_DIGITALIO           = 47110
Public Const SPC_XIO_ANALOGOUT0          = 47120
Public Const SPC_XIO_ANALOGOUT1          = 47121
Public Const SPC_XIO_ANALOGOUT2          = 47122
Public Const SPC_XIO_ANALOGOUT3          = 47123
Public Const SPC_XIO_WRITEDACS           = 47130



' ----- M3i        multi purpose lines (X0, X1        ) 
' ----- M4i + M4x  multi purpose lines (X0, X1, X2    ) 
' ----- M2p        multi purpose lines (X0, X1, X2, X3) and with installed option also (X4 .. X19)

' legacy constants: not enough contiguous constants possible for X4..X19,
' hence new constants for X-modes (SPCM_X0_MODE.. SPCM_X19_MODE) exist further below
Public Const SPCM_LEGACY_X0_MODE         = 47200
Public Const SPCM_LEGACY_X1_MODE         = 47201
Public Const SPCM_LEGACY_X2_MODE         = 47202
Public Const SPCM_LEGACY_X3_MODE         = 47203
Public Const SPCM_LEGACY_X0_AVAILMODES   = 47210
Public Const SPCM_LEGACY_X1_AVAILMODES   = 47211
Public Const SPCM_LEGACY_X2_AVAILMODES   = 47212
Public Const SPCM_LEGACY_X3_AVAILMODES   = 47213
Public Const     SPCM_XMODE_DISABLE           = &H00000000&
Public Const     SPCM_XMODE_ASYNCIN           = &H00000001&  ' used as asynchronous input
Public Const     SPCM_XMODE_ASYNCOUT          = &H00000002&  ' used as asynchronous output
Public Const     SPCM_XMODE_DIGIN             = &H00000004&  ' used as synchronous digital input
Public Const     SPCM_XMODE_DIGOUT            = &H00000008&  ' used as synchronous digital output
Public Const     SPCM_XMODE_TRIGIN            = &H00000010&  ' used as trigger input
Public Const     SPCM_XMODE_TRIGOUT           = &H00000020&  ' used as trigger output
Public Const     SPCM_XMODE_OVROUT            = &H00000040&  ' used as ADC overrange output
Public Const     SPCM_XMODE_DIGIN2BIT         = &H00000080&  ' used as synchronous digital input, 2bits per channel
Public Const     SPCM_XMODE_RUNSTATE          = &H00000100&  ' shows the run state of the card (high = run)
Public Const     SPCM_XMODE_ARMSTATE          = &H00000200&  ' shows the arm state (high = armed for trigger of one single card)
Public Const     SPCM_XMODE_DIRECTTRIGOUT     = &H00000400&  ' used as direct trigger output (safe mode) 
Public Const     SPCM_XMODE_DIRECTTRIGOUT_LR  = &H00000800&  ' used as direct trigger output (low re-arm)
Public Const     SPCM_XMODE_REFCLKOUT         = &H00001000&  ' outputs internal or fed in external refclock
Public Const     SPCM_XMODE_CONTOUTMARK       = &H00002000&  ' outputs a half posttrigger long HIGH pulse on replay
Public Const     SPCM_XMODE_SYSCLKOUT         = &H00004000&  ' outputs internal system clock
Public Const     SPCM_XMODE_CLKOUT            = &H00008000&  ' clock output
Public Const     SPCM_XMODE_SYNCARMSTATE      = &H00010000&  ' shows the arm state (high = armed for trigger when all cards connected to a Star-Hub are armed)
Public Const     SPCM_XMODE_OPTDIGIN2BIT      = &H00020000&  ' used as synchronous digital input from digitaloption, 2bits per channel
Public Const     SPCM_XMODE_OPTDIGIN4BIT      = &H00040000&  ' used as synchronous digital input from digitaloption, 4bits per channel
Public Const     SPCM_XMODE_MODEMASK          = &H000FFFFF&

' additional constants to be combined together with SPCM_XMODE_DIGOUT to select analog channel containing digital data
Public Const     SPCM_XMODE_DIGOUTSRC_CH0     = &H01000000&  ' Select Ch0 as source 
Public Const     SPCM_XMODE_DIGOUTSRC_CH1     = &H02000000&  ' Select Ch1 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH2     = &H04000000&  ' Select Ch2 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH3     = &H08000000&  ' Select Ch3 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH4     = &H10000000&  ' Select Ch4 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH5     = &H20000000&  ' Select Ch5 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH6     = &H40000000&  ' Select Ch6 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH7     = &H80000000&  ' Select Ch7 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CHMASK  = &HFF000000&

' additional constants to be combined together with SPCM_XMODE_DIGOUT to select digital signal source
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15              = &H00100000&  ' Use Bit15 (MSB    ) of selected channel: channel resolution will be reduced to 15 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT14              = &H00200000&  ' Use Bit14 (MSB - 1) of selected channel: channel resolution will be reduced to 14 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT13              = &H00400000&  ' Use Bit13 (MSB - 2) of selected channel: channel resolution will be reduced to 13 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT12              = &H00800000&  ' Use Bit12 (MSB - 3) of selected channel: channel resolution will be reduced to 12 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BITMASK            = &H00F00000&
' special combinations for M2p.65xx cards with options SPCM_FEAT_DIG16_SMB or SPCM_FEAT_DIG16_FX2
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_0     = &H00F00000&  ' use all   16 bits of selected channel on  (X19..X4)              : channel will only contain digital data
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_8     = &H00700000&  ' use upper  8 bits of selected channel for (X19..X12) or (X11..X4): channel resolution will be reduced to 8 bit

Public Const SPCM_XX_ASYNCIO             = 47220           ' asynchronous in/out register

Public Const SPC_DIGMODE0 = 47250
Public Const SPC_DIGMODE1 = 47251
Public Const SPC_DIGMODE2 = 47252
Public Const SPC_DIGMODE3 = 47253
Public Const SPC_DIGMODE4 = 47254
Public Const SPC_DIGMODE5 = 47255
Public Const SPC_DIGMODE6 = 47256
Public Const SPC_DIGMODE7 = 47257
Public Const     SPCM_DIGMODE_OFF = &H00000000&

Public Const     SPCM_DIGMODE_X1  = &H294A5000& ' (M2P_DIGMODE_X1 << (32 - 5)) | (M2P_DIGMODE_X1 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X2  = &H318C6000& ' (M2P_DIGMODE_X2 << (32 - 5)) | (M2P_DIGMODE_X2 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X3  = &H39CE7000& ' (M2P_DIGMODE_X3 << (32 - 5)) | (M2P_DIGMODE_X3 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X4  = &H84210001&
Public Const     SPCM_DIGMODE_X5  = &H8c631002&
Public Const     SPCM_DIGMODE_X6  = &H94a52004&
Public Const     SPCM_DIGMODE_X7  = &H9ce73008&
Public Const     SPCM_DIGMODE_X8  = &Ha5294010&
Public Const     SPCM_DIGMODE_X9  = &Had6b5020&
Public Const     SPCM_DIGMODE_X10 = &Hb5ad6040&
Public Const     SPCM_DIGMODE_X11 = &Hbdef7080&
Public Const     SPCM_DIGMODE_X12 = &Hc6318100&
Public Const     SPCM_DIGMODE_X13 = &Hce739200&
Public Const     SPCM_DIGMODE_X14 = &Hd6b5a400&
Public Const     SPCM_DIGMODE_X15 = &Hdef7b800&
Public Const     SPCM_DIGMODE_X16 = &He739c000&
Public Const     SPCM_DIGMODE_X17 = &Hef7bd000&
Public Const     SPCM_DIGMODE_X18 = &Hf7bde000&
Public Const     SPCM_DIGMODE_X19 = &Hfffff000&

Public Const     DIGMODEMASK_BIT15 = &HF8000000&
Public Const     DIGMODEMASK_BIT14 = &H07C00000&
Public Const     DIGMODEMASK_BIT13 = &H003E0000&
Public Const     DIGMODEMASK_BIT12 = &H0001F000&
Public Const     DIGMODEMASK_BIT11 = &H00000800& ' one bit only for bit 11 downto 0
Public Const     DIGMODEMASK_BIT10 = &H00000400&
Public Const     DIGMODEMASK_BIT9  = &H00000200&
Public Const     DIGMODEMASK_BIT8  = &H00000100&
Public Const     DIGMODEMASK_BIT7  = &H00000080&
Public Const     DIGMODEMASK_BIT6  = &H00000040&
Public Const     DIGMODEMASK_BIT5  = &H00000020&
Public Const     DIGMODEMASK_BIT4  = &H00000010&
Public Const     DIGMODEMASK_BIT3  = &H00000008&
Public Const     DIGMODEMASK_BIT2  = &H00000004&
Public Const     DIGMODEMASK_BIT1  = &H00000002&
Public Const     DIGMODEMASK_BIT0  = &H00000001&

' provided for convenience
Public Const SPCM_DIGMODE_CHREPLACE     = &HFFBBCFFF&
'#define SPCM_DIGMODE_CHREPLACE    (  (DIGMODEMASK_BIT15 & SPCM_DIGMODE_X19)
'                                   | (DIGMODEMASK_BIT14 & SPCM_DIGMODE_X18)
'                                   | (DIGMODEMASK_BIT13 & SPCM_DIGMODE_X17)
'                                   | (DIGMODEMASK_BIT12 & SPCM_DIGMODE_X16)
'                                   | (DIGMODEMASK_BIT11 & SPCM_DIGMODE_X15)
'                                   | (DIGMODEMASK_BIT10 & SPCM_DIGMODE_X14)
'                                   | (DIGMODEMASK_BIT9  & SPCM_DIGMODE_X13)
'                                   | (DIGMODEMASK_BIT8  & SPCM_DIGMODE_X12)
'                                   | (DIGMODEMASK_BIT7  & SPCM_DIGMODE_X11)
'                                   | (DIGMODEMASK_BIT6  & SPCM_DIGMODE_X10)
'                                   | (DIGMODEMASK_BIT5  & SPCM_DIGMODE_X9 )
'                                   | (DIGMODEMASK_BIT4  & SPCM_DIGMODE_X8 )
'                                   | (DIGMODEMASK_BIT3  & SPCM_DIGMODE_X7 )
'                                   | (DIGMODEMASK_BIT2  & SPCM_DIGMODE_X6 )
'                                   | (DIGMODEMASK_BIT1  & SPCM_DIGMODE_X5 )
'                                   | (DIGMODEMASK_BIT0  & SPCM_DIGMODE_X4 ) )
'


' ----- M4x PXI Trigger lines -----
Public Const SPC_PXITRG0_MODE           = 47300
Public Const SPC_PXITRG1_MODE           = 47301
Public Const SPC_PXITRG2_MODE           = 47302
Public Const SPC_PXITRG3_MODE           = 47303
Public Const SPC_PXITRG4_MODE           = 47304
Public Const SPC_PXITRG5_MODE           = 47305
Public Const SPC_PXITRG6_MODE           = 47306
Public Const SPC_PXITRG7_MODE           = 47307
Public Const SPC_PXISTAR_MODE           = 47308
Public Const SPC_PXIDSTARC_MODE         = 47309
Public Const SPC_PXITRG0_AVAILMODES     = 47310
Public Const SPC_PXITRG1_AVAILMODES     = 47311
Public Const SPC_PXITRG2_AVAILMODES     = 47312
Public Const SPC_PXITRG3_AVAILMODES     = 47313
Public Const SPC_PXITRG4_AVAILMODES     = 47314
Public Const SPC_PXITRG5_AVAILMODES     = 47315
Public Const SPC_PXITRG6_AVAILMODES     = 47316
Public Const SPC_PXITRG7_AVAILMODES     = 47317
Public Const SPC_PXISTAR_AVAILMODES     = 47318
Public Const SPC_PXIDSTARC_AVAILMODES   = 47319
Public Const SPC_PXITRG_ASYNCIO         = 47320          ' asynchronous in/out register
Public Const     SPCM_PXITRGMODE_DISABLE     = &H00000000&
Public Const     SPCM_PXITRGMODE_IN          = &H00000001&  ' used as input
Public Const     SPCM_PXITRGMODE_ASYNCOUT    = &H00000002&  ' used as asynchronous output
Public Const     SPCM_PXITRGMODE_RUNSTATE    = &H00000004&  ' shows the run state of the card (high = run)
Public Const     SPCM_PXITRGMODE_ARMSTATE    = &H00000008&  ' shows the arm state (high = armed for trigger)
Public Const     SPCM_PXITRGMODE_TRIGOUT     = &H00000010&  ' used as trigger output
Public Const     SPCM_PXITRGMODE_REFCLKOUT   = &H00000020&  ' outputs PXI refclock (10 MHz)
Public Const     SPCM_PXITRGMODE_CONTOUTMARK = &H00000040&  ' outputs a half posttrigger long HIGH pulse on replay


' ----- Star-Hub -----
' 48000 not usable

Public Const SPC_STARHUB_STATUS          = 48010

Public Const SPC_STARHUB_ROUTE0          = 48100  ' Routing Information for Test
Public Const SPC_STARHUB_ROUTE99         = 48199  ' ...


' Spcm driver (M2i, M3i, M4i, M4x, M2p) sync setup registers
Public Const SPC_SYNC_READ_SYNCCOUNT     = 48990  ' number of sync'd cards
Public Const SPC_SYNC_READ_NUMCONNECTORS = 48991  ' number of connectors on starhub

Public Const SPC_SYNC_READ_CARDIDX0      = 49000  ' read index of card at location 0 of sync
Public Const SPC_SYNC_READ_CARDIDX1      = 49001  ' ...
Public Const SPC_SYNC_READ_CARDIDX2      = 49002  ' ...
Public Const SPC_SYNC_READ_CARDIDX3      = 49003  ' ...
Public Const SPC_SYNC_READ_CARDIDX4      = 49004  ' ...
Public Const SPC_SYNC_READ_CARDIDX5      = 49005  ' ...
Public Const SPC_SYNC_READ_CARDIDX6      = 49006  ' ...
Public Const SPC_SYNC_READ_CARDIDX7      = 49007  ' ...
Public Const SPC_SYNC_READ_CARDIDX8      = 49008  ' ...
Public Const SPC_SYNC_READ_CARDIDX9      = 49009  ' ...
Public Const SPC_SYNC_READ_CARDIDX10     = 49010  ' ...
Public Const SPC_SYNC_READ_CARDIDX11     = 49011  ' ...
Public Const SPC_SYNC_READ_CARDIDX12     = 49012  ' ...
Public Const SPC_SYNC_READ_CARDIDX13     = 49013  ' ...
Public Const SPC_SYNC_READ_CARDIDX14     = 49014  ' ...
Public Const SPC_SYNC_READ_CARDIDX15     = 49015  ' ...

Public Const SPC_SYNC_READ_CABLECON0     = 49100  ' read cable connection of card at location 0 of sync
Public Const SPC_SYNC_READ_CABLECON1     = 49101  ' ...
Public Const SPC_SYNC_READ_CABLECON2     = 49102  ' ...
Public Const SPC_SYNC_READ_CABLECON3     = 49103  ' ...
Public Const SPC_SYNC_READ_CABLECON4     = 49104  ' ...
Public Const SPC_SYNC_READ_CABLECON5     = 49105  ' ...
Public Const SPC_SYNC_READ_CABLECON6     = 49106  ' ...
Public Const SPC_SYNC_READ_CABLECON7     = 49107  ' ...
Public Const SPC_SYNC_READ_CABLECON8     = 49108  ' ...
Public Const SPC_SYNC_READ_CABLECON9     = 49109  ' ...
Public Const SPC_SYNC_READ_CABLECON10    = 49110  ' ...
Public Const SPC_SYNC_READ_CABLECON11    = 49111  ' ...
Public Const SPC_SYNC_READ_CABLECON12    = 49112  ' ...
Public Const SPC_SYNC_READ_CABLECON13    = 49113  ' ...
Public Const SPC_SYNC_READ_CABLECON14    = 49114  ' ...
Public Const SPC_SYNC_READ_CABLECON15    = 49115  ' ...

Public Const SPC_SYNC_ENABLEMASK         = 49200  ' synchronisation enable (mask)
Public Const SPC_SYNC_NOTRIGSYNCMASK     = 49210  ' trigger disabled for sync (mask)
Public Const SPC_SYNC_CLKMASK            = 49220  ' clock master (mask)
Public Const SPC_SYNC_MODE               = 49230  ' synchronization mode
Public Const SPC_AVAILSYNC_MODES         = 49231  ' available synchronization modes
Public Const     SPC_SYNC_STANDARD         = &H00000001&  ' starhub uses its own clock and trigger sources
Public Const     SPC_SYNC_SYSTEMCLOCK      = &H00000002&  ' starhub uses own trigger sources and takes clock from system starhub
Public Const     SPC_SYNC_SYSTEMCLOCKTRIG  = &H00000004&  ' starhub takes clock and trigger from system starhub (trigger sampled on rising  clock edge)
Public Const     SPC_SYNC_SYSTEMCLOCKTRIGN = &H00000008&  ' starhub takes clock and trigger from system starhub (trigger sampled on falling clock edge)
Public Const SPC_SYNC_SYSTEM_TRIGADJUST  = 49240  ' Delay value for adjusting trigger position using system starhub


' ----- Gain and Offset Adjust DAC's -----
Public Const SPC_ADJ_START               = 50000

Public Const SPC_ADJ_LOAD                = 50000
Public Const SPC_ADJ_SAVE                = 50010
Public Const     ADJ_DEFAULT                 = 0
Public Const     ADJ_USER0                   = 1
Public Const     ADJ_USER1                   = 2
Public Const     ADJ_USER2                   = 3
Public Const     ADJ_USER3                   = 4
Public Const     ADJ_USER4                   = 5
Public Const     ADJ_USER5                   = 6
Public Const     ADJ_USER6                   = 7
Public Const     ADJ_USER7                   = 8

Public Const SPC_ADJ_AUTOADJ             = 50020
Public Const     ADJ_ALL                     = 0
Public Const     ADJ_CURRENT                 = 1
Public Const     ADJ_EXTERNAL                = 2
Public Const     ADJ_1MOHM                   = 3

Public Const     ADJ_CURRENT_CLOCK           = 4
Public Const     ADJ_CURRENT_IR              = 8
Public Const     ADJ_OFFSET_ONLY            = 16
Public Const     ADJ_SPECIAL_CLOCK          = 32

Public Const SPC_ADJ_SOURCE_CALLBACK     = 50021
Public Const SPC_ADJ_PROGRESS_CALLBACK   = 50022

Public Const SPC_ADJ_SET                 = 50030
Public Const SPC_ADJ_FAILMASK            = 50040

Public Const SPC_ADJ_CALIBSOURCE            = 50050
Public Const        ADJ_CALSRC_GAIN             = 1
Public Const        ADJ_CALSRC_OFF              = 0
Public Const        ADJ_CALSRC_GND             = -1
Public Const        ADJ_CALSRC_GNDOFFS         = -2
Public Const        ADJ_CALSRC_AC              = 10

Public Const SPC_ADJ_CALIBVALUE0            = 50060
Public Const SPC_ADJ_CALIBVALUE1            = 50061
Public Const SPC_ADJ_CALIBVALUE2            = 50062
Public Const SPC_ADJ_CALIBVALUE3            = 50063
Public Const SPC_ADJ_CALIBVALUE4            = 50064
Public Const SPC_ADJ_CALIBVALUE5            = 50065
Public Const SPC_ADJ_CALIBVALUE6            = 50066
Public Const SPC_ADJ_CALIBVALUE7            = 50067

Public Const SPC_ADJ_OFFSET_CH0          = 50900
Public Const SPC_ADJ_OFFSET_CH1          = 50901
Public Const SPC_ADJ_OFFSET_CH2          = 50902
Public Const SPC_ADJ_OFFSET_CH3          = 50903
Public Const SPC_ADJ_OFFSET_CH4          = 50904
Public Const SPC_ADJ_OFFSET_CH5          = 50905
Public Const SPC_ADJ_OFFSET_CH6          = 50906
Public Const SPC_ADJ_OFFSET_CH7          = 50907
Public Const SPC_ADJ_OFFSET_CH8          = 50908
Public Const SPC_ADJ_OFFSET_CH9          = 50909
Public Const SPC_ADJ_OFFSET_CH10         = 50910
Public Const SPC_ADJ_OFFSET_CH11         = 50911
Public Const SPC_ADJ_OFFSET_CH12         = 50912
Public Const SPC_ADJ_OFFSET_CH13         = 50913
Public Const SPC_ADJ_OFFSET_CH14         = 50914
Public Const SPC_ADJ_OFFSET_CH15         = 50915

Public Const SPC_ADJ_GAIN_CH0            = 50916
Public Const SPC_ADJ_GAIN_CH1            = 50917
Public Const SPC_ADJ_GAIN_CH2            = 50918
Public Const SPC_ADJ_GAIN_CH3            = 50919
Public Const SPC_ADJ_GAIN_CH4            = 50920
Public Const SPC_ADJ_GAIN_CH5            = 50921
Public Const SPC_ADJ_GAIN_CH6            = 50922
Public Const SPC_ADJ_GAIN_CH7            = 50923
Public Const SPC_ADJ_GAIN_CH8            = 50924
Public Const SPC_ADJ_GAIN_CH9            = 50925
Public Const SPC_ADJ_GAIN_CH10           = 50926
Public Const SPC_ADJ_GAIN_CH11           = 50927
Public Const SPC_ADJ_GAIN_CH12           = 50928
Public Const SPC_ADJ_GAIN_CH13           = 50929
Public Const SPC_ADJ_GAIN_CH14           = 50930
Public Const SPC_ADJ_GAIN_CH15           = 50931

Public Const SPC_ADJ_OFFSET0             = 51000
Public Const SPC_ADJ_OFFSET999           = 51999

Public Const SPC_ADJ_GAIN0               = 52000
Public Const SPC_ADJ_GAIN999             = 52999

Public Const SPC_ADJ_CORRECT0            = 53000
Public Const SPC_ADJ_OFFS_CORRECT0       = 53000
Public Const SPC_ADJ_CORRECT999          = 53999
Public Const SPC_ADJ_OFFS_CORRECT999     = 53999

Public Const SPC_ADJ_XIOOFFS0            = 54000
Public Const SPC_ADJ_XIOOFFS1            = 54001
Public Const SPC_ADJ_XIOOFFS2            = 54002
Public Const SPC_ADJ_XIOOFFS3            = 54003

Public Const SPC_ADJ_XIOGAIN0            = 54010
Public Const SPC_ADJ_XIOGAIN1            = 54011
Public Const SPC_ADJ_XIOGAIN2            = 54012
Public Const SPC_ADJ_XIOGAIN3            = 54013

Public Const SPC_ADJ_GAIN_CORRECT0       = 55000
Public Const SPC_ADJ_GAIN_CORRECT999     = 55999

Public Const SPC_ADJ_OFFSCALIBCORRECT0   = 56000
Public Const SPC_ADJ_OFFSCALIBCORRECT999 = 56999

Public Const SPC_ADJ_GAINCALIBCORRECT0   = 57000
Public Const SPC_ADJ_GAINCALIBCORRECT999 = 57999

Public Const SPC_ADJ_ANALOGTRIGGER0      = 58000
Public Const SPC_ADJ_ANALOGTRIGGER99     = 58099

Public Const SPC_ADJ_CALIBSAMPLERATE0    = 58100
Public Const SPC_ADJ_CALIBSAMPLERATE99   = 58199

Public Const SPC_ADJ_CALIBSAMPLERATE_GAIN0    = 58200
Public Const SPC_ADJ_CALIBSAMPLERATE_GAIN99   = 58299

Public Const SPC_ADJ_REFCLOCK            = 58300
Public Const SPC_ADJ_STARHUB_REFCLOCK    = 58301

Public Const SPC_ADJ_END                 = 59999



' ----- FIFO Control -----
Public Const SPC_FIFO_BUFFERS            = 60000          ' number of FIFO buffers
Public Const SPC_FIFO_BUFLEN             = 60010          ' len of each FIFO buffer
Public Const SPC_FIFO_BUFCOUNT           = 60020          ' number of FIFO buffers tranfered until now
Public Const SPC_FIFO_BUFMAXCNT          = 60030          ' number of FIFO buffers to be transfered (0=continuous)
Public Const SPC_FIFO_BUFADRCNT          = 60040          ' number of FIFO buffers allowed
Public Const SPC_FIFO_BUFREADY           = 60050          ' fifo buffer ready register (same as SPC_COMMAND + SPC_FIFO_BUFREADY0...)
Public Const SPC_FIFO_BUFFILLCNT         = 60060          ' number of currently filled buffers
Public Const SPC_FIFO_BUFADR0            = 60100          ' adress of FIFO buffer no. 0
Public Const SPC_FIFO_BUFADR1            = 60101          ' ...
Public Const SPC_FIFO_BUFADR2            = 60102          ' ...
Public Const SPC_FIFO_BUFADR3            = 60103          ' ...
Public Const SPC_FIFO_BUFADR4            = 60104          ' ...
Public Const SPC_FIFO_BUFADR5            = 60105          ' ...
Public Const SPC_FIFO_BUFADR6            = 60106          ' ...
Public Const SPC_FIFO_BUFADR7            = 60107          ' ...
Public Const SPC_FIFO_BUFADR8            = 60108          ' ...
Public Const SPC_FIFO_BUFADR9            = 60109          ' ...
Public Const SPC_FIFO_BUFADR10           = 60110          ' ...
Public Const SPC_FIFO_BUFADR11           = 60111          ' ...
Public Const SPC_FIFO_BUFADR12           = 60112          ' ...
Public Const SPC_FIFO_BUFADR13           = 60113          ' ...
Public Const SPC_FIFO_BUFADR14           = 60114          ' ...
Public Const SPC_FIFO_BUFADR15           = 60115          ' ...
Public Const SPC_FIFO_BUFADR255          = 60355          ' last



' ----- Filter -----
Public Const SPC_FILTER                  = 100000
Public Const SPC_READNUMFILTERS          = 100001         ' number of programable filters
Public Const SPC_FILTERFREQUENCY0        = 100002         ' frequency of filter 0 (bypass)
Public Const SPC_FILTERFREQUENCY1        = 100003         ' frequency of filter 1
Public Const SPC_FILTERFREQUENCY2        = 100004         ' frequency of filter 2
Public Const SPC_FILTERFREQUENCY3        = 100005         ' frequency of filter 3
Public Const SPC_DIGITALBWFILTER         = 100100         ' enable/disable digital bandwith filter


' ----- Pattern -----
Public Const SPC_PATTERNENABLE           = 110000
Public Const SPC_READDIGITAL             = 110100

Public Const SPC_DIGITALMODE0            = 110200
Public Const SPC_DIGITALMODE1            = 110201
Public Const SPC_DIGITALMODE2            = 110202
Public Const SPC_DIGITALMODE3            = 110203
Public Const SPC_DIGITALMODE4            = 110204
Public Const SPC_DIGITALMODE5            = 110205
Public Const SPC_DIGITALMODE6            = 110206
Public Const SPC_DIGITALMODE7            = 110207
Public Const     SPC_DIGITALMODE_OFF         = 0
Public Const     SPC_DIGITALMODE_2BIT        = 1
Public Const     SPC_DIGITALMODE_4BIT        = 2
Public Const     SPC_DIGITALMODE_CHREPLACE   = 3


' ----- Miscellanous -----
Public Const SPC_MISCDAC0                = 200000
Public Const SPC_MISCDAC1                = 200010
Public Const SPC_FACTORYMODE             = 200020
Public Const SPC_DIRECTDAC               = 200030
Public Const SPC_NOTRIGSYNC              = 200040
Public Const SPC_DSPDIRECT               = 200100
Public Const SPC_DMAPHYSICALADR          = 200110
Public Const SPC_MICXCOMP_CLOSEBOARD     = 200119
Public Const SPC_MICXCOMPATIBILITYMODE   = 200120
Public Const SPC_TEST_FIFOSPEED          = 200121
Public Const SPC_RELOADDEMO              = 200122
Public Const SPC_OVERSAMPLINGFACTOR      = 200123
Public Const SPC_ISMAPPEDCARD            = 200124
Public Const     SPCM_NOT_MAPPED             = 0
Public Const     SPCM_LOCAL_MAPPED           = 1
Public Const     SPCM_REMOTE_MAPPED          = 2
Public Const SPC_GETTHREADHANDLE         = 200130
Public Const SPC_GETKERNELHANDLE         = 200131
Public Const SPC_XYZMODE                 = 200200
Public Const SPC_INVERTDATA              = 200300
Public Const SPC_GATEMARKENABLE          = 200400
Public Const SPC_GATE_LEN_ALIGNMENT      = 200401
Public Const SPC_CONTOUTMARK             = 200450
Public Const SPC_EXPANDINT32             = 200500
Public Const SPC_NOPRETRIGGER            = 200600
Public Const SPC_RELAISWAITTIME          = 200700
Public Const SPC_DACWAITTIME             = 200710
Public Const SPC_DELAY_US                = 200720
Public Const SPC_ILAMODE                 = 200800
Public Const SPC_NMDGMODE                = 200810
Public Const SPC_CKADHALF_OUTPUT         = 200820
Public Const SPC_LONGTRIG_OUTPUT         = 200830
Public Const SPC_STOREMODAENDOFSEGMENT   = 200840
Public Const SPC_COUNTERMODE             = 200850
Public Const     SPC_CNTMOD_MASK             = &H0000000F&
Public Const     SPC_CNTMOD_PARALLELDATA     = &H00000000&
Public Const     SPC_CNTMOD_8BITCNT          = &H00000001&
Public Const     SPC_CNTMOD_2x8BITCNT        = &H00000002&
Public Const     SPC_CNTMOD_16BITCNT         = &H00000003&
Public Const     SPC_CNT0_MASK               = &H000000F0&
Public Const     SPC_CNT0_CNTONPOSEDGE       = &H00000000&
Public Const     SPC_CNT0_CNTONNEGEDGE       = &H00000010&
Public Const     SPC_CNT0_RESETHIGHLVL       = &H00000000&
Public Const     SPC_CNT0_RESETLOWLVL        = &H00000020&
Public Const     SPC_CNT0_STOPATMAX          = &H00000000&
Public Const     SPC_CNT0_ROLLOVER           = &H00000040&
Public Const     SPC_CNT1_MASK               = &H00000F00&
Public Const     SPC_CNT1_CNTONPOSEDGE       = &H00000000&
Public Const     SPC_CNT1_CNTONNEGEDGE       = &H00000100&
Public Const     SPC_CNT1_RESETHIGHLVL       = &H00000000&
Public Const     SPC_CNT1_RESETLOWLVL        = &H00000200&
Public Const     SPC_CNT1_STOPATMAX          = &H00000000&
Public Const     SPC_CNT1_ROLLOVER           = &H00000400&
Public Const     SPC_CNTCMD_MASK             = &H0000F000&
Public Const     SPC_CNTCMD_RESETCNT0        = &H00001000&
Public Const     SPC_CNTCMD_RESETCNT1        = &H00002000&
Public Const SPC_ENHANCEDSTATUS          = 200900
Public Const     SPC_ENHSTAT_OVERRANGE0      = &H00000001&
Public Const     SPC_ENHSTAT_OVERRANGE1      = &H00000002&
Public Const     SPC_ENHSTAT_OVERRANGE2      = &H00000004&
Public Const     SPC_ENHSTAT_OVERRANGE3      = &H00000008&
Public Const     SPC_ENHSTAT_OVERRANGE4      = &H00000010&
Public Const     SPC_ENHSTAT_OVERRANGE5      = &H00000020&
Public Const     SPC_ENHSTAT_OVERRANGE6      = &H00000040&
Public Const     SPC_ENHSTAT_OVERRANGE7      = &H00000080&
Public Const     SPC_ENHSTAT_COMPARATOR0     = &H40000000&
Public Const     SPC_ENHSTAT_COMPARATOR1     = &H80000000&
Public Const     SPC_ENHSTAT_COMPARATOR2     = &H20000000&
Public Const     SPC_ENHSTAT_TRGCOMPARATOR   = &H40000000&
Public Const     SPC_ENHSTAT_CLKCOMPARATOR   = &H80000000&
Public Const SPC_TRIGGERCOUNTER          = 200905
Public Const SPC_FILLSIZEPROMILLE        = 200910
Public Const SPC_OVERRANGEBIT            = 201000
Public Const SPC_2CH8BITMODE             = 201100
Public Const SPC_12BITMODE               = 201200
Public Const SPC_HOLDLASTSAMPLE          = 201300

Public Const SPC_DATACONVERSION          = 201400
Public Const SPC_AVAILDATACONVERSION     = 201401
Public Const     SPCM_DC_NONE            = &H00000000&
Public Const     SPCM_DC_12BIT_TO_14BIT  = &H00000001&
Public Const     SPCM_DC_16BIT_TO_14BIT  = &H00000002&
Public Const     SPCM_DC_12BIT_TO_16BIT  = &H00000004&
Public Const     SPCM_DC_14BIT_TO_16BIT  = &H00000008&
Public Const     SPCM_DC_15BIT_TO_16BIT  = &H00000010&
Public Const     SPCM_DC_13BIT_TO_16BIT  = &H00000020&
Public Const     SPCM_DC_14BIT_TO_8BIT   = &H00000100&
Public Const     SPCM_DC_16BIT_TO_8BIT   = &H00000200&
Public Const     SPCM_DC_16BIT_TO_12BIT  = &H00000400&
Public Const     SPCM_DC_TO_OFFSETBINARY = &H00000800&

Public Const SPC_CARDIDENTIFICATION      = 201500

Public Const SPC_HANDSHAKE               = 201600

Public Const SPC_CKSYNC0                 = 202000
Public Const SPC_CKSYNC1                 = 202001
Public Const SPC_DISABLEMOD0             = 203000
Public Const SPC_DISABLEMOD1             = 203010
Public Const SPC_ENABLEOVERRANGECHECK    = 204000
Public Const SPC_OVERRANGESTATUS         = 204010
Public Const SPC_BITMODE                 = 205000

Public Const SPC_READBACK                = 206000
Public Const SPC_AVAILSTOPLEVEL          = 206009
Public Const SPC_STOPLEVEL1              = 206010
Public Const SPC_STOPLEVEL0              = 206020
Public Const SPC_CH0_STOPLEVEL           = 206020
Public Const SPC_CH1_STOPLEVEL           = 206021
Public Const SPC_CH2_STOPLEVEL           = 206022
Public Const SPC_CH3_STOPLEVEL           = 206023
Public Const SPC_CH4_STOPLEVEL           = 206024
Public Const SPC_CH5_STOPLEVEL           = 206025
Public Const SPC_CH6_STOPLEVEL           = 206026
Public Const SPC_CH7_STOPLEVEL           = 206027
Public Const     SPCM_STOPLVL_TRISTATE   = &H00000001&
Public Const     SPCM_STOPLVL_LOW        = &H00000002&
Public Const     SPCM_STOPLVL_HIGH       = &H00000004&
Public Const     SPCM_STOPLVL_HOLDLAST   = &H00000008&
Public Const     SPCM_STOPLVL_ZERO       = &H00000010&
Public Const     SPCM_STOPLVL_CUSTOM     = &H00000020&

Public Const SPC_DIFFMODE                = 206030
Public Const SPC_DACADJUST               = 206040

Public Const SPC_CH0_CUSTOM_STOP         = 206050
Public Const SPC_CH1_CUSTOM_STOP         = 206051
Public Const SPC_CH2_CUSTOM_STOP         = 206052
Public Const SPC_CH3_CUSTOM_STOP         = 206053
Public Const SPC_CH4_CUSTOM_STOP         = 206054
Public Const SPC_CH5_CUSTOM_STOP         = 206055
Public Const SPC_CH6_CUSTOM_STOP         = 206056
Public Const SPC_CH7_CUSTOM_STOP         = 206057

Public Const SPC_AMP_MODE                = 207000

Public Const SPCM_FW_CTRL                = 210000
Public Const SPCM_FW_CTRL_GOLDEN         = 210001
Public Const SPCM_FW_CTRL_ACTIVE         = 210002
Public Const SPCM_FW_CLOCK               = 210010
Public Const SPCM_FW_CONFIG              = 210020
Public Const SPCM_FW_MODULEA             = 210030
Public Const SPCM_FW_MODULEB             = 210031
Public Const SPCM_FW_MODULEA_ACTIVE      = 210032
Public Const SPCM_FW_MODULEB_ACTIVE      = 210033
Public Const SPCM_FW_MODEXTRA            = 210050
Public Const SPCM_FW_MODEXTRA_ACTIVE     = 210052
Public Const SPCM_FW_POWER               = 210060
Public Const SPCM_FW_POWER_ACTIVE        = 210062

Public Const SPC_MULTI                   = 220000
Public Const SPC_DOUBLEMEM               = 220100
Public Const SPC_MULTIMEMVALID           = 220200
Public Const SPC_BANK                    = 220300
Public Const SPC_GATE                    = 220400
Public Const SPC_RELOAD                  = 230000
Public Const SPC_USEROUT                 = 230010
Public Const SPC_WRITEUSER0              = 230100
Public Const SPC_WRITEUSER1              = 230110
Public Const SPC_READUSER0               = 230200
Public Const SPC_READUSER1               = 230210
Public Const SPC_MUX                     = 240000
Public Const SPC_ADJADC                  = 241000
Public Const SPC_ADJOFFS0                = 242000
Public Const SPC_ADJOFFS1                = 243000
Public Const SPC_ADJGAIN0                = 244000
Public Const SPC_ADJGAIN1                = 245000
Public Const SPC_READEPROM               = 250000
Public Const SPC_WRITEEPROM              = 250010
Public Const SPC_DIRECTIO                = 260000
Public Const SPC_DIRECT_MODA             = 260010
Public Const SPC_DIRECT_MODB             = 260020
Public Const SPC_DIRECT_EXT0             = 260030
Public Const SPC_DIRECT_EXT1             = 260031
Public Const SPC_DIRECT_EXT2             = 260032
Public Const SPC_DIRECT_EXT3             = 260033
Public Const SPC_DIRECT_EXT4             = 260034
Public Const SPC_DIRECT_EXT5             = 260035
Public Const SPC_DIRECT_EXT6             = 260036
Public Const SPC_DIRECT_EXT7             = 260037
Public Const SPC_MEMTEST                 = 270000
Public Const SPC_NODMA                   = 275000
Public Const SPC_NOCOUNTER               = 275010
Public Const SPC_NOSCATTERGATHER         = 275020
Public Const SPC_USER_RELAIS_OVERWRITE   = 275030
Public Const     SPCM_URO_ENABLE             = &H80000000&
Public Const     SPCM_URO_INVERT_10TO1REL    = &H00000001&
Public Const SPC_RUNINTENABLE            = 290000
Public Const SPC_XFERBUFSIZE             = 295000
Public Const SPC_CHLX                    = 295010
Public Const SPC_SPECIALCLOCK            = 295100
Public Const SPC_PLL0_ICP                = 295105
Public Const     SPCM_ICP0            = &H00000000&
' ...
Public Const     SPCM_ICP7            = &H00000007&
Public Const SPC_STARTDELAY              = 295110
Public Const SPC_BASISTTLTRIG            = 295120
Public Const SPC_TIMEOUT                 = 295130
Public Const SPC_SWL_INFO                = 295140
Public Const SPC_SWD_INFO                = 295141
Public Const SPC_SWD_DOWN                = 295142
Public Const SPC_SWL_EXTRAINFO           = 295143
Public Const SPC_SPECIALCLOCK_ADJUST0    = 295150
Public Const SPC_SPECIALCLOCK_ADJUST1    = 295151
Public Const SPC_SPECIALCLOCK_ADJUST2    = 295152
Public Const SPC_SPECIALCLOCK_ADJUST3    = 295153
Public Const    SPCM_SPECIALCLOCK_ADJUST_SHIFT = 1000000
Public Const SPC_REGACC_CONTMEM          = 299000
Public Const SPC_REGACC_MEMORYUSAGE      = 299001
Public Const SPC_REINITLOGSETTINGS       = 299998
Public Const SPC_LOGDLLCALLS             = 299999






' ----- PCK400 -----
Public Const SPC_FREQUENCE               = 300000
Public Const SPC_DELTAFREQUENCE          = 300010
Public Const SPC_PINHIGH                 = 300100
Public Const SPC_PINLOW                  = 300110
Public Const SPC_PINDELTA                = 300120
Public Const SPC_STOPLEVEL               = 300200
Public Const SPC_PINRELAIS               = 300210
Public Const SPC_EXTERNLEVEL             = 300300



' ----- PADCO -----
Public Const SPC_COUNTER0                = 310000
Public Const SPC_COUNTER1                = 310001
Public Const SPC_COUNTER2                = 310002
Public Const SPC_COUNTER3                = 310003
Public Const SPC_COUNTER4                = 310004
Public Const SPC_COUNTER5                = 310005
Public Const SPC_MODE0                   = 310100
Public Const SPC_MODE1                   = 310101
Public Const SPC_MODE2                   = 310102
Public Const SPC_MODE3                   = 310103
Public Const SPC_MODE4                   = 310104
Public Const SPC_MODE5                   = 310105
Public Const     CM_SINGLE                   = 1
Public Const     CM_MULTI                    = 2
Public Const     CM_POSEDGE                  = 4
Public Const     CM_NEGEDGE                  = 8
Public Const     CM_HIGHPULSE                = 16
Public Const     CM_LOWPULSE                 = 32



' ----- PAD1616 -----
Public Const SPC_SEQUENCERESET           = 320000
Public Const SPC_SEQUENCEADD             = 320010
Public Const     SEQ_IR_10000MV              = 0
Public Const     SEQ_IR_5000MV               = 1
Public Const     SEQ_IR_2000MV               = 2
Public Const     SEQ_IR_1000MV               = 3
Public Const     SEQ_IR_500MV                = 4
Public Const     SEQ_CH0                     = 0
Public Const     SEQ_CH1                     = 8
Public Const     SEQ_CH2                     = 16
Public Const     SEQ_CH3                     = 24
Public Const     SEQ_CH4                     = 32
Public Const     SEQ_CH5                     = 40
Public Const     SEQ_CH6                     = 48
Public Const     SEQ_CH7                     = 56
Public Const     SEQ_CH8                     = 64
Public Const     SEQ_CH9                     = 72
Public Const     SEQ_CH10                    = 80
Public Const     SEQ_CH11                    = 88
Public Const     SEQ_CH12                    = 96
Public Const     SEQ_CH13                    = 104
Public Const     SEQ_CH14                    = 112
Public Const     SEQ_CH15                    = 120
Public Const     SEQ_TRIGGER                 = 128
Public Const     SEQ_START                   = 256



' ----- Option CA -----
Public Const SPC_CA_MODE                 = 330000
Public Const     CAMODE_OFF                  = 0
Public Const     CAMODE_CDM                  = 1
Public Const     CAMODE_KW                   = 2
Public Const     CAMODE_OT                   = 3
Public Const     CAMODE_CDMMUL               = 4
Public Const SPC_CA_TRIGDELAY            = 330010
Public Const SPC_CA_CKDIV                = 330020
Public Const SPC_CA_PULS                 = 330030
Public Const SPC_CA_CKMUL                = 330040
Public Const SPC_CA_DREHZAHLFORMAT       = 330050
Public Const     CADREH_4X4                  = 0
Public Const     CADREH_1X16                 = 1
Public Const SPC_CA_KWINVERT             = 330060
Public Const SPC_CA_OUTA                 = 330100
Public Const SPC_CA_OUTB                 = 330110
Public Const     CAOUT_TRISTATE              = 0
Public Const     CAOUT_LOW                   = 1
Public Const     CAOUT_HIGH                  = 2
Public Const     CAOUT_CDM                   = 3
Public Const     CAOUT_OT                    = 4
Public Const     CAOUT_KW                    = 5
Public Const     CAOUT_TRIG                  = 6
Public Const     CAOUT_CLK                   = 7
Public Const     CAOUT_KW60                  = 8
Public Const     CAOUT_KWGAP                 = 9
Public Const     CAOUT_TRDLY                 = 10
Public Const     CAOUT_INVERT                = 16


' ----- Option Sequence Mode (output cards) -----
Public Const SPC_SEQMODE_STEPMEM0        = 340000
' ... 
Public Const SPC_SEQMODE_STEPMEM8191     = 348191

' low part of 64 bit entry
Public Const     SPCSEQ_SEGMENTMASK      = &H0000FFFF&
Public Const     SPCSEQ_NEXTSTEPMASK     = &HFFFF0000&

' high part of 64 bit entry
Public Const     SPCSEQ_LOOPMASK         = &H000FFFFF&
Public Const     SPCSEQ_ENDLOOPALWAYS    = &H00000000&
Public Const     SPCSEQ_ENDLOOPONTRIG    = &H40000000&
Public Const     SPCSEQ_END              = &H80000000&

Public Const SPC_SEQMODE_AVAILMAXSEGMENT = 349900
Public Const SPC_SEQMODE_AVAILMAXSTEPS   = 349901
Public Const SPC_SEQMODE_AVAILMAXLOOP    = 349902
Public Const SPC_SEQMODE_AVAILFEATURES   = 349903

Public Const SPC_SEQMODE_MAXSEGMENTS     = 349910
Public Const SPC_SEQMODE_WRITESEGMENT    = 349920
Public Const SPC_SEQMODE_STARTSTEP       = 349930
Public Const SPC_SEQMODE_SEGMENTSIZE     = 349940

Public Const SPC_SEQMODE_STATUS          = 349950
Public Const     SEQSTAT_STEPCHANGE          = &H80000000&


' ----- netbox registers -----
Public Const SPC_NETBOX_TYPE             = 400000
Public Const     NETBOX_SERIES_MASK      = &HFF000000&
Public Const     NETBOX_FAMILY_MASK      = &H00FF0000&
Public Const     NETBOX_SPEED_MASK       = &H0000FF00&
Public Const     NETBOX_CHANNEL_MASK     = &H000000FF&

Public Const     NETBOX_SERIES_DN2       = &H02000000&
Public Const     NETBOX_SERIES_DN6       = &H06000000&

Public Const     NETBOX_FAMILY_20        = &H00200000&
Public Const     NETBOX_FAMILY_22        = &H00220000&
Public Const     NETBOX_FAMILY_44        = &H00440000&
Public Const     NETBOX_FAMILY_46        = &H00460000&
Public Const     NETBOX_FAMILY_47        = &H00470000&
Public Const     NETBOX_FAMILY_48        = &H00480000&
Public Const     NETBOX_FAMILY_49        = &H00490000&
Public Const     NETBOX_FAMILY_59        = &H00590000&
Public Const     NETBOX_FAMILY_60        = &H00600000&
Public Const     NETBOX_FAMILY_65        = &H00650000&
Public Const     NETBOX_FAMILY_66        = &H00660000&
Public Const     NETBOX_FAMILY_8X        = &H00800000&
Public Const     NETBOX_FAMILY_80        = &H00800000&
Public Const     NETBOX_FAMILY_81        = &H00810000&
Public Const     NETBOX_FAMILY_82        = &H00820000&
Public Const     NETBOX_FAMILY_83        = &H00830000&

Public Const     NETBOX_SPEED_1          = &H00000100&
Public Const     NETBOX_SPEED_2          = &H00000200&
Public Const     NETBOX_SPEED_3          = &H00000300&
Public Const     NETBOX_SPEED_4          = &H00000400&
Public Const     NETBOX_SPEED_5          = &H00000500&
Public Const     NETBOX_SPEED_6          = &H00000600&
Public Const     NETBOX_SPEED_7          = &H00000700&
Public Const     NETBOX_SPEED_8          = &H00000800&

Public Const     NETBOX_CHANNELS_2       = &H00000002&
Public Const     NETBOX_CHANNELS_4       = &H00000004&
Public Const     NETBOX_CHANNELS_6       = &H00000006&
Public Const     NETBOX_CHANNELS_8       = &H00000008&
Public Const     NETBOX_CHANNELS_10      = &H0000000A&
Public Const     NETBOX_CHANNELS_12      = &H0000000C&
Public Const     NETBOX_CHANNELS_16      = &H00000010&
Public Const     NETBOX_CHANNELS_20      = &H00000014&
Public Const     NETBOX_CHANNELS_24      = &H00000018&
Public Const     NETBOX_CHANNELS_32      = &H00000020&
Public Const     NETBOX_CHANNELS_40      = &H00000028&
Public Const     NETBOX_CHANNELS_48      = &H00000030&

Public Const SPC_NETBOX_SERIALNO         = 400001
Public Const SPC_NETBOX_PRODUCTIONDATE   = 400002
Public Const SPC_NETBOX_HWVERSION        = 400003
Public Const SPC_NETBOX_SWVERSION        = 400004

Public Const SPC_NETBOX_FEATURES         = 400005
Public Const     NETBOX_FEAT_DCPOWER         = &H1&
Public Const     NETBOX_FEAT_BOOTATPOWERON   = &H2&
Public Const     NETBOX_FEAT_EMBEDDEDSERVER  = &H4&

Public Const SPC_NETBOX_CUSTOM           = 400006

Public Const SPC_NETBOX_WAKEONLAN        = 400007
Public Const SPC_NETBOX_MACADDRESS       = 400008
Public Const SPC_NETBOX_LANIDFLASH       = 400009
Public Const SPC_NETBOX_TEMPERATURE      = 400010
Public Const SPC_NETBOX_SHUTDOWN         = 400011
Public Const SPC_NETBOX_RESTART          = 400012
Public Const SPC_NETBOX_FANSPEED0        = 400013
Public Const SPC_NETBOX_FANSPEED1        = 400014
Public Const SPC_NETBOX_TEMPERATURE_K    = 400010 ' same SPC_NETBOX_TEMPERATURE
Public Const SPC_NETBOX_TEMPERATURE_C    = 400015
Public Const SPC_NETBOX_TEMPERATURE_F    = 400016

' ----- hardware monitor registers -----
Public Const SPC_MON_V_PCIE_BUS          = 500000
Public Const SPC_MON_V_CONNECTOR         = 500001
Public Const SPC_MON_CARD_PWRSOURCE      = 500002
Public Const     CARD_PWRSOURCE_BUS          = 0
Public Const     CARD_PWRSOURCE_CONNECTOR    = 1
Public Const SPC_MON_V_CARD_IN           = 500003
Public Const SPC_MON_I_CARD_IN           = 500004
Public Const SPC_MON_P_CARD_IN           = 500005
Public Const SPC_MON_V_3V3               = 500006
Public Const SPC_MON_V_2V5               = 500007
Public Const SPC_MON_V_CORE              = 500008
Public Const SPC_MON_V_AVTT              = 500009
Public Const SPC_MON_V_AVCC              = 500010
Public Const SPC_MON_V_MEMVCC            = 500011
Public Const SPC_MON_V_MEMVTT            = 500012
Public Const SPC_MON_V_CP_POS            = 500013
Public Const SPC_MON_V_CP_NEG            = 500014

Public Const SPC_MON_V_5VA               = 500015
Public Const SPC_MON_V_ADCA              = 500016
Public Const SPC_MON_V_ADCD              = 500017
Public Const SPC_MON_V_OP_POS            = 500018
Public Const SPC_MON_V_OP_NEG            = 500019
Public Const SPC_MON_V_COMP_NEG          = 500020
Public Const SPC_MON_V_COMP_POS          = 500021

' legacy temperature registers (Kelvin)
Public Const SPC_MON_T_BASE_CTRL         = 500022
Public Const SPC_MON_T_MODULE_0          = 500023
Public Const SPC_MON_T_MODULE_1          = 500024

' new temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF)
Public Const SPC_MON_TK_BASE_CTRL         = 500022
Public Const SPC_MON_TK_MODULE_0          = 500023
Public Const SPC_MON_TK_MODULE_1          = 500024

Public Const SPC_MON_TC_BASE_CTRL         = 500025
Public Const SPC_MON_TC_MODULE_0          = 500026
Public Const SPC_MON_TC_MODULE_1          = 500027

Public Const SPC_MON_TF_BASE_CTRL         = 500028
Public Const SPC_MON_TF_MODULE_0          = 500029
Public Const SPC_MON_TF_MODULE_1          = 500030

' some more voltages (used on M2p)
Public Const SPC_MON_V_1V8_BASE           = 500031
Public Const SPC_MON_V_1V8_MOD            = 500032
Public Const SPC_MON_V_MODA_0             = 500033
Public Const SPC_MON_V_MODA_1             = 500034
Public Const SPC_MON_V_MODB_0             = 500035
Public Const SPC_MON_V_MODB_1             = 500037

' some more voltages and temperatures (used on M2p.65xx-hv)
Public Const SPC_MON_TK_MODA_0           = 500023 ' same as SPC_MON_TK_MODULE_0
Public Const SPC_MON_TK_MODA_1           = 500038
Public Const SPC_MON_TK_MODA_2           = 500039
Public Const SPC_MON_TK_MODA_3           = 500040
Public Const SPC_MON_TK_MODA_4           = 500041
Public Const SPC_MON_TK_MODB_0           = 500024 ' same as SPC_MON_TK_MODULE_1
Public Const SPC_MON_TK_MODB_1           = 500042
Public Const SPC_MON_TK_MODB_2           = 500043
Public Const SPC_MON_TK_MODB_3           = 500044
Public Const SPC_MON_TK_MODB_4           = 500045

Public Const SPC_MON_TC_MODA_0           = 500026 ' same as SPC_MON_TC_MODULE_0
Public Const SPC_MON_TC_MODA_1           = 500046
Public Const SPC_MON_TC_MODA_2           = 500047
Public Const SPC_MON_TC_MODA_3           = 500048
Public Const SPC_MON_TC_MODA_4           = 500049
Public Const SPC_MON_TC_MODB_0           = 500027 ' same as SPC_MON_TC_MODULE_1
Public Const SPC_MON_TC_MODB_1           = 500050
Public Const SPC_MON_TC_MODB_2           = 500051
Public Const SPC_MON_TC_MODB_3           = 500052
Public Const SPC_MON_TC_MODB_4           = 500053

Public Const SPC_MON_TF_MODA_0           = 500029 ' same as SPC_MON_TF_MODULE_0
Public Const SPC_MON_TF_MODA_1           = 500054
Public Const SPC_MON_TF_MODA_2           = 500055
Public Const SPC_MON_TF_MODA_3           = 500056
Public Const SPC_MON_TF_MODA_4           = 500057
Public Const SPC_MON_TF_MODB_0           = 500030 ' same as SPC_MON_TF_MODULE_1
Public Const SPC_MON_TF_MODB_1           = 500058
Public Const SPC_MON_TF_MODB_2           = 500059
Public Const SPC_MON_TF_MODB_3           = 500060
Public Const SPC_MON_TF_MODB_4           = 500061

Public Const SPC_MON_I_MODA_0            = 500062
Public Const SPC_MON_I_MODA_1            = 500063
Public Const SPC_MON_I_MODA_2            = 500064
Public Const SPC_MON_I_MODA_3            = 500065
Public Const SPC_MON_I_MODB_0            = 500066
Public Const SPC_MON_I_MODB_1            = 500067
Public Const SPC_MON_I_MODB_2            = 500068
Public Const SPC_MON_I_MODB_3            = 500069

Public Const SPC_MON_MOD_FAULT           = 500070
Public Const SPC_CLR_MOD_FAULT           = 500071

' power section temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF)
Public Const SPC_MON_TK_MODA_5           = 500072
Public Const SPC_MON_TK_MODB_5           = 500073

Public Const SPC_MON_TC_MODA_5           = 500074
Public Const SPC_MON_TC_MODB_5           = 500075

Public Const SPC_MON_TF_MODA_5           = 500076
Public Const SPC_MON_TF_MODB_5           = 500077

' mask with available monitor registers
Public Const SPC_AVAILMONITORS            = 510000
Public Const     SPCM_MON_T_BASE_CTRL        = &H0000000000000001UL&
Public Const     SPCM_MON_T_MODULE_0         = &H0000000000000002UL&
Public Const     SPCM_MON_T_MODULE_1         = &H0000000000000004UL&

Public Const     SPCM_MON_V_PCIE_BUS         = &H0000000000000010UL&
Public Const     SPCM_MON_V_CONNECTOR        = &H0000000000000020UL&
Public Const     SPCM_MON_CARD_PWRSOURCE     = &H0000000000000040UL&
Public Const     SPCM_MON_V_CARD_IN          = &H0000000000000080UL&
Public Const     SPCM_MON_I_CARD_IN          = &H0000000000000100UL&
Public Const     SPCM_MON_P_CARD_IN          = &H0000000000000200UL&
Public Const     SPCM_MON_V_3V3              = &H0000000000000400UL&
Public Const     SPCM_MON_V_2V5              = &H0000000000000800UL&
Public Const     SPCM_MON_V_CORE             = &H0000000000001000UL&
Public Const     SPCM_MON_V_AVTT             = &H0000000000002000UL&
Public Const     SPCM_MON_V_AVCC             = &H0000000000004000UL&
Public Const     SPCM_MON_V_MEMVCC           = &H0000000000008000UL&
Public Const     SPCM_MON_V_MEMVTT           = &H0000000000010000UL&
Public Const     SPCM_MON_V_CP_POS           = &H0000000000020000UL&
Public Const     SPCM_MON_V_CP_NEG           = &H0000000000040000UL&
Public Const     SPCM_MON_V_5VA              = &H0000000000080000UL&
Public Const     SPCM_MON_V_ADCA             = &H0000000000100000UL&
Public Const     SPCM_MON_V_ADCD             = &H0000000000200000UL&
Public Const     SPCM_MON_V_OP_POS           = &H0000000000400000UL&
Public Const     SPCM_MON_V_OP_NEG           = &H0000000000800000UL&
Public Const     SPCM_MON_V_COMP_NEG         = &H0000000001000000UL&
Public Const     SPCM_MON_V_COMP_POS         = &H0000000002000000UL&
Public Const     SPCM_MON_V_1V8_BASE         = &H0000000004000000UL&
Public Const     SPCM_MON_V_1V8_MOD          = &H0000000008000000UL&

Public Const     SPCM_MON_V_MODA_0           = &H0000000010000000UL&
Public Const     SPCM_MON_V_MODA_1           = &H0000000020000000UL&
Public Const     SPCM_MON_V_MODB_0           = &H0000000040000000UL&
Public Const     SPCM_MON_V_MODB_1           = &H0000000080000000UL&

Public Const     SPCM_MON_T_MODA_0           = &H0000000000000002UL& ' same as SPCM_MON_T_MODULE_0
Public Const     SPCM_MON_T_MODA_1           = &H0000000100000000UL&
Public Const     SPCM_MON_T_MODA_2           = &H0000000200000000UL&
Public Const     SPCM_MON_T_MODA_3           = &H0000000400000000UL&
Public Const     SPCM_MON_T_MODA_4           = &H0000000800000000UL&
Public Const     SPCM_MON_T_MODB_0           = &H0000000000000004UL& ' same as SPCM_MON_T_MODULE_1
Public Const     SPCM_MON_T_MODB_1           = &H0000001000000000UL&
Public Const     SPCM_MON_T_MODB_2           = &H0000002000000000UL&
Public Const     SPCM_MON_T_MODB_3           = &H0000004000000000UL&
Public Const     SPCM_MON_T_MODB_4           = &H0000008000000000UL&

Public Const     SPCM_MON_I_MODA_0           = &H0000010000000000UL&
Public Const     SPCM_MON_I_MODA_1           = &H0000020000000000UL&
Public Const     SPCM_MON_I_MODA_2           = &H0000040000000000UL&
Public Const     SPCM_MON_I_MODA_3           = &H0000080000000000UL&
Public Const     SPCM_MON_I_MODB_0           = &H0000100000000000UL&
Public Const     SPCM_MON_I_MODB_1           = &H0000200000000000UL&
Public Const     SPCM_MON_I_MODB_2           = &H0000300000000000UL&
Public Const     SPCM_MON_I_MODB_3           = &H0000400000000000UL&

Public Const     SPCM_MON_T_MODA_5           = &H0000800000000000UL&
Public Const     SPCM_MON_T_MODB_5           = &H0001000000000000UL&


' ----- re-located multi-purpose i/o related registers -----
Public Const SPC_X0_READFEATURES         = 600000
Public Const SPC_X1_READFEATURES         = 600001
Public Const SPC_X2_READFEATURES         = 600002
Public Const SPC_X3_READFEATURES         = 600003
Public Const SPC_X4_READFEATURES         = 600004
Public Const SPC_X5_READFEATURES         = 600005
Public Const SPC_X6_READFEATURES         = 600006
Public Const SPC_X7_READFEATURES         = 600007
Public Const SPC_X8_READFEATURES         = 600008
Public Const SPC_X9_READFEATURES         = 600009
Public Const SPC_X10_READFEATURES        = 600010
Public Const SPC_X11_READFEATURES        = 600011
Public Const SPC_X12_READFEATURES        = 600012
Public Const SPC_X13_READFEATURES        = 600013
Public Const SPC_X14_READFEATURES        = 600014
Public Const SPC_X15_READFEATURES        = 600015
Public Const SPC_X16_READFEATURES        = 600016
Public Const SPC_X17_READFEATURES        = 600017
Public Const SPC_X18_READFEATURES        = 600018
Public Const SPC_X19_READFEATURES        = 600019
Public Const     SPCM_XFEAT_TERM             = &H00000001&
Public Const     SPCM_XFEAT_HIGHIMP          = &H00000002&
Public Const     SPCM_XFEAT_DCCOUPLING       = &H00000004&
Public Const     SPCM_XFEAT_ACCOUPLING       = &H00000008&
Public Const     SPCM_XFEAT_SE               = &H00000010&
Public Const     SPCM_XFEAT_DIFF             = &H00000020&
Public Const     SPCM_XFEAT_PROGTHRESHOLD    = &H00000040&

Public Const SPC_X0_TERM                = 600100
Public Const SPC_X1_TERM                = 600101
Public Const SPC_X2_TERM                = 600102
Public Const SPC_X3_TERM                = 600103
Public Const SPC_X4_TERM                = 600104
Public Const SPC_X5_TERM                = 600105
Public Const SPC_X6_TERM                = 600106
Public Const SPC_X7_TERM                = 600107
Public Const SPC_X8_TERM                = 600108
Public Const SPC_X9_TERM                = 600109
Public Const SPC_X10_TERM               = 600110
Public Const SPC_X11_TERM               = 600111
Public Const SPC_X12_TERM               = 600112
Public Const SPC_X13_TERM               = 600113
Public Const SPC_X14_TERM               = 600114
Public Const SPC_X15_TERM               = 600115
Public Const SPC_X16_TERM               = 600116
Public Const SPC_X17_TERM               = 600117
Public Const SPC_X18_TERM               = 600118
Public Const SPC_X19_TERM               = 600119

Public Const SPCM_X0_MODE                = 600200
Public Const SPCM_X1_MODE                = 600201
Public Const SPCM_X2_MODE                = 600202
Public Const SPCM_X3_MODE                = 600203
Public Const SPCM_X4_MODE                = 600204
Public Const SPCM_X5_MODE                = 600205
Public Const SPCM_X6_MODE                = 600206
Public Const SPCM_X7_MODE                = 600207
Public Const SPCM_X8_MODE                = 600208
Public Const SPCM_X9_MODE                = 600209
Public Const SPCM_X10_MODE               = 600210
Public Const SPCM_X11_MODE               = 600211
Public Const SPCM_X12_MODE               = 600212
Public Const SPCM_X13_MODE               = 600213
Public Const SPCM_X14_MODE               = 600214
Public Const SPCM_X15_MODE               = 600215
Public Const SPCM_X16_MODE               = 600216
Public Const SPCM_X17_MODE               = 600217
Public Const SPCM_X18_MODE               = 600218
Public Const SPCM_X19_MODE               = 600219

Public Const SPCM_X0_AVAILMODES          = 600300
Public Const SPCM_X1_AVAILMODES          = 600301
Public Const SPCM_X2_AVAILMODES          = 600302
Public Const SPCM_X3_AVAILMODES          = 600303
Public Const SPCM_X4_AVAILMODES          = 600304
Public Const SPCM_X5_AVAILMODES          = 600305
Public Const SPCM_X6_AVAILMODES          = 600306
Public Const SPCM_X7_AVAILMODES          = 600307
Public Const SPCM_X8_AVAILMODES          = 600308
Public Const SPCM_X9_AVAILMODES          = 600309
Public Const SPCM_X10_AVAILMODES         = 600310
Public Const SPCM_X11_AVAILMODES         = 600311
Public Const SPCM_X12_AVAILMODES         = 600312
Public Const SPCM_X13_AVAILMODES         = 600313
Public Const SPCM_X14_AVAILMODES         = 600314
Public Const SPCM_X15_AVAILMODES         = 600315
Public Const SPCM_X16_AVAILMODES         = 600316
Public Const SPCM_X17_AVAILMODES         = 600317
Public Const SPCM_X18_AVAILMODES         = 600318
Public Const SPCM_X19_AVAILMODES         = 600319
' for definitions of the available modes see section at SPCM_LEGACY_X0_MODE above


' ----- Hardware registers (debug use only) -----
Public Const SPC_REG0x00                 = 900000
Public Const SPC_REG0x02                 = 900010
Public Const SPC_REG0x04                 = 900020
Public Const SPC_REG0x06                 = 900030
Public Const SPC_REG0x08                 = 900040
Public Const SPC_REG0x0A                 = 900050
Public Const SPC_REG0x0C                 = 900060
Public Const SPC_REG0x0E                 = 900070

Public Const SPC_DEBUGREG0               = 900100
Public Const SPC_DEBUGREG15              = 900115
Public Const SPC_DEBUGVALUE0             = 900200
Public Const SPC_DEBUGVALUE15            = 900215

Public Const SPC_MI_ISP                  = 901000
Public Const     ISP_TMS_0                   = 0
Public Const     ISP_TMS_1                   = 1
Public Const     ISP_TDO_0                   = 0
Public Const     ISP_TDO_1                   = 2


Public Const SPC_EE_RWAUTH               = 901100
Public Const SPC_EE_REG                  = 901110
Public Const SPC_EE_RESETCOUNTER         = 901120

' ----- Test Registers -----
Public Const SPC_TEST_BASE               = 902000
Public Const SPC_TEST_LOCAL_START        = 902100
Public Const SPC_TEST_LOCAL_END          = 902356
Public Const SPC_TEST_PLX_START          = 902400
Public Const SPC_TEST_PLX_END            = 902656

' 9012xx not usable
' 901900 not usable
' 903000 not usable
' 91xxxx not usable

' ----- used by GetErrorInfo to mark errors in other functions than SetParam/GetParam -----
Public Const SPC_FUNCTION_DEFTRANSFER = 100000000


' end of file