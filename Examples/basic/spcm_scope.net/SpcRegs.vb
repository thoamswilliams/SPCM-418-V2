Option Strict Off
Option Explicit On
Module regs
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

Public Const TYP_PCIDEVICEID             As Integer = &H00000000

' ***** Board Types ***************
Public Const TYP_EVAL                    As Integer = &H00000010
Public Const TYP_RSDLGA                  As Integer = &H00000014
Public Const TYP_GMG                     As Integer = &H00000018
Public Const TYP_VAN8                    As Integer = &H00000020
Public Const TYP_VAC                     As Integer = &H00000028

Public Const TYP_PCIAUTOINSTALL          As Integer = &H000000FF

Public Const TYP_DAP116                  As Integer = &H00000100
Public Const TYP_PAD82                   As Integer = &H00000200
Public Const TYP_PAD82a                  As Integer = &H00000210
Public Const TYP_PAD82b                  As Integer = &H00000220
Public Const TYP_PCI212                  As Integer = &H00000300
Public Const TYP_PAD1232a                As Integer = &H00000400
Public Const TYP_PAD1232b                As Integer = &H00000410
Public Const TYP_PAD1232c                As Integer = &H00000420
Public Const TYP_PAD1616a                As Integer = &H00000500
Public Const TYP_PAD1616b                As Integer = &H00000510
Public Const TYP_PAD1616c                As Integer = &H00000520
Public Const TYP_PAD1616d                As Integer = &H00000530
Public Const TYP_PAD52                   As Integer = &H00000600
Public Const TYP_PAD242                  As Integer = &H00000700
Public Const TYP_PCK400                  As Integer = &H00000800
Public Const TYP_PAD164_2M               As Integer = &H00000900
Public Const TYP_PAD164_5M               As Integer = &H00000910
Public Const TYP_PCI208                  As Integer = &H00001000
Public Const TYP_CPCI208                 As Integer = &H00001001
Public Const TYP_PCI412                  As Integer = &H00001100
Public Const TYP_PCIDIO32                As Integer = &H00001200
Public Const TYP_PCI248                  As Integer = &H00001300
Public Const TYP_PADCO                   As Integer = &H00001400
Public Const TYP_TRS582                  As Integer = &H00001500
Public Const TYP_PCI258                  As Integer = &H00001600


' ------ series and familiy identifiers -----
Public Const TYP_SERIESMASK              As Integer = &H00FF0000     ' the series (= type of base card), e.g. MI.xxxx
Public Const TYP_VERSIONMASK             As Integer = &H0000FFFF     ' the version, e.g. XX.3012
Public Const TYP_FAMILYMASK              As Integer = &H0000FF00     ' the family, e.g. XX.30xx
Public Const TYP_TYPEMASK                As Integer = &H000000FF     ' the type, e.g. XX.xx12
Public Const TYP_SPEEDMASK               As Integer = &H000000F0     ' the speed grade, e.g. XX.xx1x
Public Const TYP_CHMASK                  As Integer = &H0000000F     ' the channel/modules, e.g. XX.xxx2

Public Const TYP_MISERIES                As Integer = &H00000000
Public Const TYP_MCSERIES                As Integer = &H00010000
Public Const TYP_MXSERIES                As Integer = &H00020000
Public Const TYP_M2ISERIES               As Integer = &H00030000
Public Const TYP_M2IEXPSERIES            As Integer = &H00040000
Public Const TYP_M3ISERIES               As Integer = &H00050000
Public Const TYP_M3IEXPSERIES            As Integer = &H00060000
Public Const TYP_M4IEXPSERIES            As Integer = &H00070000
Public Const TYP_M4XEXPSERIES            As Integer = &H00080000
Public Const TYP_M2PEXPSERIES            As Integer = &H00090000



' ----- MI.20xx, MC.20xx, MX.20xx -----
Public Const TYP_MI2020                  As Integer = &H00002020
Public Const TYP_MI2021                  As Integer = &H00002021
Public Const TYP_MI2025                  As Integer = &H00002025
Public Const TYP_MI2030                  As Integer = &H00002030
Public Const TYP_MI2031                  As Integer = &H00002031

Public Const TYP_M2I2020                 As Integer = &H00032020
Public Const TYP_M2I2021                 As Integer = &H00032021
Public Const TYP_M2I2025                 As Integer = &H00032025
Public Const TYP_M2I2030                 As Integer = &H00032030
Public Const TYP_M2I2031                 As Integer = &H00032031

Public Const TYP_M2I2020EXP              As Integer = &H00042020
Public Const TYP_M2I2021EXP              As Integer = &H00042021
Public Const TYP_M2I2025EXP              As Integer = &H00042025
Public Const TYP_M2I2030EXP              As Integer = &H00042030
Public Const TYP_M2I2031EXP              As Integer = &H00042031

Public Const TYP_MC2020                  As Integer = &H00012020
Public Const TYP_MC2021                  As Integer = &H00012021
Public Const TYP_MC2025                  As Integer = &H00012025
Public Const TYP_MC2030                  As Integer = &H00012030
Public Const TYP_MC2031                  As Integer = &H00012031

Public Const TYP_MX2020                  As Integer = &H00022020
Public Const TYP_MX2025                  As Integer = &H00022025
Public Const TYP_MX2030                  As Integer = &H00022030

' ----- M3i.21xx, M3i.21xx-Exp (8 bit A/D) -----
Public Const TYP_M3I2120                 As Integer = &H00052120     ' 1x500M
Public Const TYP_M3I2122                 As Integer = &H00052122     ' 1x500M & 2x250M
Public Const TYP_M3I2130                 As Integer = &H00052130     ' 1x1G
Public Const TYP_M3I2132                 As Integer = &H00052132     ' 1x1G & 2x500M

Public Const TYP_M3I2120EXP              As Integer = &H00062120     ' 1x500M
Public Const TYP_M3I2122EXP              As Integer = &H00062122     ' 1x500M & 2x250M
Public Const TYP_M3I2130EXP              As Integer = &H00062130     ' 1x1G
Public Const TYP_M3I2132EXP              As Integer = &H00062132     ' 1x1G & 2x500M

' ----- M4i.22xx-x8 (8 bit A/D) -----
Public Const TYP_M4I22XX_X8              As Integer = &H00072200
Public Const TYP_M4I2210_X8              As Integer = &H00072210     ' 1x1.25G
Public Const TYP_M4I2211_X8              As Integer = &H00072211     ' 2x1.25G
Public Const TYP_M4I2212_X8              As Integer = &H00072212     ' 4x1.25G
Public Const TYP_M4I2220_X8              As Integer = &H00072220     ' 1x2.5G
Public Const TYP_M4I2221_X8              As Integer = &H00072221     ' 2x2.5G
Public Const TYP_M4I2223_X8              As Integer = &H00072223     ' 1x2.5G & 2x1.25G
Public Const TYP_M4I2230_X8              As Integer = &H00072230     ' 1x5G
Public Const TYP_M4I2233_X8              As Integer = &H00072233     ' 1x5G & 2x2.5G 
Public Const TYP_M4I2234_X8              As Integer = &H00072234     ' 1x5G & 2x2.5G & 4x1.25G
Public Const TYP_M4I2280_X8              As Integer = &H00072280     ' customer specific variant
Public Const TYP_M4I2281_X8              As Integer = &H00072281     ' customer specific variant
Public Const TYP_M4I2283_X8              As Integer = &H00072283     ' customer specific variant
Public Const TYP_M4I2290_X8              As Integer = &H00072290     ' customer specific variant
Public Const TYP_M4I2293_X8              As Integer = &H00072293     ' customer specific variant
Public Const TYP_M4I2294_X8              As Integer = &H00072294     ' customer specific variant

' ----- M4x.22xx-x8 (8 bit A/D) -----
Public Const TYP_M4X22XX_X4              As Integer = &H00082200
Public Const TYP_M4X2210_X4              As Integer = &H00082210     ' 1x1.25G
Public Const TYP_M4X2211_X4              As Integer = &H00082211     ' 2x1.25G
Public Const TYP_M4X2212_X4              As Integer = &H00082212     ' 4x1.25G
Public Const TYP_M4X2220_X4              As Integer = &H00082220     ' 1x2.5G
Public Const TYP_M4X2221_X4              As Integer = &H00082221     ' 2x2.5G
Public Const TYP_M4X2223_X4              As Integer = &H00082223     ' 1x2.5G & 2x1.25G
Public Const TYP_M4X2230_X4              As Integer = &H00082230     ' 1x5G
Public Const TYP_M4X2233_X4              As Integer = &H00082233     ' 1x5G & 2x2.5G 
Public Const TYP_M4X2234_X4              As Integer = &H00082234     ' 1x5G & 2x2.5G & 4x1.25G

' ----- M4i.23xx-x8 (7 bit A/D) -----
Public Const TYP_M4I23XX_X8              As Integer = &H00072300
Public Const TYP_M4I2320_X8              As Integer = &H00072320     ' 1x2.5G
Public Const TYP_M4I2321_X8              As Integer = &H00072321     ' 2x2.5G
Public Const TYP_M4I2323_X8              As Integer = &H00072323     ' 1x2.5G & 2x1.25G
Public Const TYP_M4I2330_X8              As Integer = &H00072330     ' 1x5G
Public Const TYP_M4I2333_X8              As Integer = &H00072333     ' 1x5G & 2x2.5G 
Public Const TYP_M4I2334_X8              As Integer = &H00072334     ' 1x5G & 2x2.5G & 4x1.25G

' ----- MI.30xx, MC.30xx, MX.30xx -----
Public Const TYP_MI3010                  As Integer = &H00003010
Public Const TYP_MI3011                  As Integer = &H00003011
Public Const TYP_MI3012                  As Integer = &H00003012
Public Const TYP_MI3013                  As Integer = &H00003013
Public Const TYP_MI3014                  As Integer = &H00003014
Public Const TYP_MI3015                  As Integer = &H00003015
Public Const TYP_MI3016                  As Integer = &H00003016
Public Const TYP_MI3020                  As Integer = &H00003020
Public Const TYP_MI3021                  As Integer = &H00003021
Public Const TYP_MI3022                  As Integer = &H00003022
Public Const TYP_MI3023                  As Integer = &H00003023
Public Const TYP_MI3024                  As Integer = &H00003024
Public Const TYP_MI3025                  As Integer = &H00003025
Public Const TYP_MI3026                  As Integer = &H00003026
Public Const TYP_MI3027                  As Integer = &H00003027
Public Const TYP_MI3031                  As Integer = &H00003031
Public Const TYP_MI3033                  As Integer = &H00003033

Public Const TYP_M2I3010                 As Integer = &H00033010
Public Const TYP_M2I3011                 As Integer = &H00033011
Public Const TYP_M2I3012                 As Integer = &H00033012
Public Const TYP_M2I3013                 As Integer = &H00033013
Public Const TYP_M2I3014                 As Integer = &H00033014
Public Const TYP_M2I3015                 As Integer = &H00033015
Public Const TYP_M2I3016                 As Integer = &H00033016
Public Const TYP_M2I3020                 As Integer = &H00033020
Public Const TYP_M2I3021                 As Integer = &H00033021
Public Const TYP_M2I3022                 As Integer = &H00033022
Public Const TYP_M2I3023                 As Integer = &H00033023
Public Const TYP_M2I3024                 As Integer = &H00033024
Public Const TYP_M2I3025                 As Integer = &H00033025
Public Const TYP_M2I3026                 As Integer = &H00033026
Public Const TYP_M2I3027                 As Integer = &H00033027
Public Const TYP_M2I3031                 As Integer = &H00033031
Public Const TYP_M2I3033                 As Integer = &H00033033

Public Const TYP_M2I3010EXP              As Integer = &H00043010
Public Const TYP_M2I3011EXP              As Integer = &H00043011
Public Const TYP_M2I3012EXP              As Integer = &H00043012
Public Const TYP_M2I3013EXP              As Integer = &H00043013
Public Const TYP_M2I3014EXP              As Integer = &H00043014
Public Const TYP_M2I3015EXP              As Integer = &H00043015
Public Const TYP_M2I3016EXP              As Integer = &H00043016
Public Const TYP_M2I3020EXP              As Integer = &H00043020
Public Const TYP_M2I3021EXP              As Integer = &H00043021
Public Const TYP_M2I3022EXP              As Integer = &H00043022
Public Const TYP_M2I3023EXP              As Integer = &H00043023
Public Const TYP_M2I3024EXP              As Integer = &H00043024
Public Const TYP_M2I3025EXP              As Integer = &H00043025
Public Const TYP_M2I3026EXP              As Integer = &H00043026
Public Const TYP_M2I3027EXP              As Integer = &H00043027
Public Const TYP_M2I3031EXP              As Integer = &H00043031
Public Const TYP_M2I3033EXP              As Integer = &H00043033

Public Const TYP_MC3010                  As Integer = &H00013010
Public Const TYP_MC3011                  As Integer = &H00013011
Public Const TYP_MC3012                  As Integer = &H00013012
Public Const TYP_MC3013                  As Integer = &H00013013
Public Const TYP_MC3014                  As Integer = &H00013014
Public Const TYP_MC3015                  As Integer = &H00013015
Public Const TYP_MC3016                  As Integer = &H00013016
Public Const TYP_MC3020                  As Integer = &H00013020
Public Const TYP_MC3021                  As Integer = &H00013021
Public Const TYP_MC3022                  As Integer = &H00013022
Public Const TYP_MC3023                  As Integer = &H00013023
Public Const TYP_MC3024                  As Integer = &H00013024
Public Const TYP_MC3025                  As Integer = &H00013025
Public Const TYP_MC3026                  As Integer = &H00013026
Public Const TYP_MC3027                  As Integer = &H00013027
Public Const TYP_MC3031                  As Integer = &H00013031
Public Const TYP_MC3033                  As Integer = &H00013033

Public Const TYP_MX3010                  As Integer = &H00023010
Public Const TYP_MX3011                  As Integer = &H00023011
Public Const TYP_MX3012                  As Integer = &H00023012
Public Const TYP_MX3020                  As Integer = &H00023020
Public Const TYP_MX3021                  As Integer = &H00023021
Public Const TYP_MX3022                  As Integer = &H00023022
Public Const TYP_MX3031                  As Integer = &H00023031



' ----- MI.31xx, MC.31xx, MX.31xx -----
Public Const TYP_MI3110                  As Integer = &H00003110
Public Const TYP_MI3111                  As Integer = &H00003111
Public Const TYP_MI3112                  As Integer = &H00003112
Public Const TYP_MI3120                  As Integer = &H00003120
Public Const TYP_MI3121                  As Integer = &H00003121
Public Const TYP_MI3122                  As Integer = &H00003122
Public Const TYP_MI3130                  As Integer = &H00003130
Public Const TYP_MI3131                  As Integer = &H00003131
Public Const TYP_MI3132                  As Integer = &H00003132
Public Const TYP_MI3140                  As Integer = &H00003140

Public Const TYP_M2I3110                 As Integer = &H00033110
Public Const TYP_M2I3111                 As Integer = &H00033111
Public Const TYP_M2I3112                 As Integer = &H00033112
Public Const TYP_M2I3120                 As Integer = &H00033120
Public Const TYP_M2I3121                 As Integer = &H00033121
Public Const TYP_M2I3122                 As Integer = &H00033122
Public Const TYP_M2I3130                 As Integer = &H00033130
Public Const TYP_M2I3131                 As Integer = &H00033131
Public Const TYP_M2I3132                 As Integer = &H00033132

Public Const TYP_M2I3110EXP              As Integer = &H00043110
Public Const TYP_M2I3111EXP              As Integer = &H00043111
Public Const TYP_M2I3112EXP              As Integer = &H00043112
Public Const TYP_M2I3120EXP              As Integer = &H00043120
Public Const TYP_M2I3121EXP              As Integer = &H00043121
Public Const TYP_M2I3122EXP              As Integer = &H00043122
Public Const TYP_M2I3130EXP              As Integer = &H00043130
Public Const TYP_M2I3131EXP              As Integer = &H00043131
Public Const TYP_M2I3132EXP              As Integer = &H00043132

Public Const TYP_MC3110                  As Integer = &H00013110
Public Const TYP_MC3111                  As Integer = &H00013111
Public Const TYP_MC3112                  As Integer = &H00013112
Public Const TYP_MC3120                  As Integer = &H00013120
Public Const TYP_MC3121                  As Integer = &H00013121
Public Const TYP_MC3122                  As Integer = &H00013122
Public Const TYP_MC3130                  As Integer = &H00013130
Public Const TYP_MC3131                  As Integer = &H00013131
Public Const TYP_MC3132                  As Integer = &H00013132

Public Const TYP_MX3110                  As Integer = &H00023110
Public Const TYP_MX3111                  As Integer = &H00023111
Public Const TYP_MX3120                  As Integer = &H00023120
Public Const TYP_MX3121                  As Integer = &H00023121
Public Const TYP_MX3130                  As Integer = &H00023130
Public Const TYP_MX3131                  As Integer = &H00023131



' ----- M3i.32xx, M3i.32xx-Exp (12 bit A/D) -----
Public Const TYP_M3I3220                 As Integer = &H00053220     ' 1x250M
Public Const TYP_M3I3221                 As Integer = &H00053221     ' 2x250M
Public Const TYP_M3I3240                 As Integer = &H00053240     ' 1x500M
Public Const TYP_M3I3242                 As Integer = &H00053242     ' 1x500M & 2x250M

Public Const TYP_M3I3220EXP              As Integer = &H00063220     ' 1x250M
Public Const TYP_M3I3221EXP              As Integer = &H00063221     ' 2x250M
Public Const TYP_M3I3240EXP              As Integer = &H00063240     ' 1x500M
Public Const TYP_M3I3242EXP              As Integer = &H00063242     ' 1x500M & 2x250M



' ----- MI.40xx, MC.40xx, MX.40xx -----
Public Const TYP_MI4020                  As Integer = &H00004020
Public Const TYP_MI4021                  As Integer = &H00004021
Public Const TYP_MI4022                  As Integer = &H00004022
Public Const TYP_MI4030                  As Integer = &H00004030
Public Const TYP_MI4031                  As Integer = &H00004031
Public Const TYP_MI4032                  As Integer = &H00004032

Public Const TYP_M2I4020                 As Integer = &H00034020
Public Const TYP_M2I4021                 As Integer = &H00034021
Public Const TYP_M2I4022                 As Integer = &H00034022
Public Const TYP_M2I4028                 As Integer = &H00034028
Public Const TYP_M2I4030                 As Integer = &H00034030
Public Const TYP_M2I4031                 As Integer = &H00034031
Public Const TYP_M2I4032                 As Integer = &H00034032
Public Const TYP_M2I4038                 As Integer = &H00034038

Public Const TYP_M2I4020EXP              As Integer = &H00044020
Public Const TYP_M2I4021EXP              As Integer = &H00044021
Public Const TYP_M2I4022EXP              As Integer = &H00044022
Public Const TYP_M2I4028EXP              As Integer = &H00044028
Public Const TYP_M2I4030EXP              As Integer = &H00044030
Public Const TYP_M2I4031EXP              As Integer = &H00044031
Public Const TYP_M2I4032EXP              As Integer = &H00044032
Public Const TYP_M2I4038EXP              As Integer = &H00044038

Public Const TYP_MC4020                  As Integer = &H00014020
Public Const TYP_MC4021                  As Integer = &H00014021
Public Const TYP_MC4022                  As Integer = &H00014022
Public Const TYP_MC4030                  As Integer = &H00014030
Public Const TYP_MC4031                  As Integer = &H00014031
Public Const TYP_MC4032                  As Integer = &H00014032

Public Const TYP_MX4020                  As Integer = &H00024020
Public Const TYP_MX4021                  As Integer = &H00024021
Public Const TYP_MX4030                  As Integer = &H00024030
Public Const TYP_MX4031                  As Integer = &H00024031



' ----- M3i.41xx, M3i.41xx-Exp (14 bit A/D) -----
Public Const TYP_M3I4110                 As Integer = &H00054110     ' 1x100M
Public Const TYP_M3I4111                 As Integer = &H00054111     ' 2x100M
Public Const TYP_M3I4120                 As Integer = &H00054120     ' 1x250M
Public Const TYP_M3I4121                 As Integer = &H00054121     ' 2x250M
Public Const TYP_M3I4140                 As Integer = &H00054140     ' 1x400M
Public Const TYP_M3I4142                 As Integer = &H00054142     ' 1x400M & 2x250M

Public Const TYP_M3I4110EXP              As Integer = &H00064110     ' 1x100M
Public Const TYP_M3I4111EXP              As Integer = &H00064111     ' 2x100M
Public Const TYP_M3I4120EXP              As Integer = &H00064120     ' 1x250M
Public Const TYP_M3I4121EXP              As Integer = &H00064121     ' 2x250M
Public Const TYP_M3I4140EXP              As Integer = &H00064140     ' 1x400M
Public Const TYP_M3I4142EXP              As Integer = &H00064142     ' 1x400M & 2x250M

' ----- M4i.44xx-x8 (generic) -----
Public Const TYP_M4I44XX_X8              As Integer = &H00074400      ' 

Public Const TYP_M4I4410_X8              As Integer = &H00074410      ' 2x130M 16bit
Public Const TYP_M4I4411_X8              As Integer = &H00074411      ' 4x130M 16bit
Public Const TYP_M4I4420_X8              As Integer = &H00074420      ' 2x250M 16bit
Public Const TYP_M4I4421_X8              As Integer = &H00074421      ' 4x250M 16bit
Public Const TYP_M4I4450_X8              As Integer = &H00074450      ' 2x500M 14bit
Public Const TYP_M4I4451_X8              As Integer = &H00074451      ' 4x500M 14bit
Public Const TYP_M4I4470_X8              As Integer = &H00074470      ' 2x180M 16bit
Public Const TYP_M4I4471_X8              As Integer = &H00074471      ' 4x180M 16bit
Public Const TYP_M4I4480_X8              As Integer = &H00074480      ' 2x400M 14bit
Public Const TYP_M4I4481_X8              As Integer = &H00074481      ' 4x400M 14bit

' ----- M4x.44xx-x4 (14/16 bit A/D) -----
Public Const TYP_M4X44XX_X4              As Integer = &H00084400      ' generic
Public Const TYP_M4X4410_X4              As Integer = &H00084410      ' 2x130M 16bit
Public Const TYP_M4X4411_X4              As Integer = &H00084411      ' 4x130M 16bit
Public Const TYP_M4X4420_X4              As Integer = &H00084420      ' 2x250M 16bit
Public Const TYP_M4X4421_X4              As Integer = &H00084421      ' 4x250M 16bit
Public Const TYP_M4X4450_X4              As Integer = &H00084450      ' 2x500M 14bit
Public Const TYP_M4X4451_X4              As Integer = &H00084451      ' 4x500M 14bit
Public Const TYP_M4X4470_X4              As Integer = &H00084470      ' 2x180M 16bit
Public Const TYP_M4X4471_X4              As Integer = &H00084471      ' 4x180M 16bit
Public Const TYP_M4X4480_X4              As Integer = &H00084480      ' 2x400M 14bit
Public Const TYP_M4X4481_X4              As Integer = &H00084481      ' 4x400M 14bit


' ----- MI.45xx, MC.45xx, MX.45xx -----
Public Const TYP_MI4520                  As Integer = &H00004520
Public Const TYP_MI4521                  As Integer = &H00004521
Public Const TYP_MI4530                  As Integer = &H00004530
Public Const TYP_MI4531                  As Integer = &H00004531
Public Const TYP_MI4540                  As Integer = &H00004540
Public Const TYP_MI4541                  As Integer = &H00004541

Public Const TYP_M2I4520                 As Integer = &H00034520
Public Const TYP_M2I4521                 As Integer = &H00034521
Public Const TYP_M2I4530                 As Integer = &H00034530
Public Const TYP_M2I4531                 As Integer = &H00034531
Public Const TYP_M2I4540                 As Integer = &H00034540
Public Const TYP_M2I4541                 As Integer = &H00034541

Public Const TYP_MC4520                  As Integer = &H00014520
Public Const TYP_MC4521                  As Integer = &H00014521
Public Const TYP_MC4530                  As Integer = &H00014530
Public Const TYP_MC4531                  As Integer = &H00014531
Public Const TYP_MC4540                  As Integer = &H00014540
Public Const TYP_MC4541                  As Integer = &H00014541

Public Const TYP_MX4520                  As Integer = &H00024520
Public Const TYP_MX4530                  As Integer = &H00024530
Public Const TYP_MX4540                  As Integer = &H00024540



' ----- MI.46xx, MC.46xx, MX.46xx -----
Public Const TYP_MI4620                  As Integer = &H00004620
Public Const TYP_MI4621                  As Integer = &H00004621
Public Const TYP_MI4622                  As Integer = &H00004622
Public Const TYP_MI4630                  As Integer = &H00004630
Public Const TYP_MI4631                  As Integer = &H00004631
Public Const TYP_MI4632                  As Integer = &H00004632
Public Const TYP_MI4640                  As Integer = &H00004640
Public Const TYP_MI4641                  As Integer = &H00004641
Public Const TYP_MI4642                  As Integer = &H00004642
Public Const TYP_MI4650                  As Integer = &H00004650
Public Const TYP_MI4651                  As Integer = &H00004651
Public Const TYP_MI4652                  As Integer = &H00004652

Public Const TYP_M2I4620                 As Integer = &H00034620
Public Const TYP_M2I4621                 As Integer = &H00034621
Public Const TYP_M2I4622                 As Integer = &H00034622
Public Const TYP_M2I4630                 As Integer = &H00034630
Public Const TYP_M2I4631                 As Integer = &H00034631
Public Const TYP_M2I4632                 As Integer = &H00034632
Public Const TYP_M2I4640                 As Integer = &H00034640
Public Const TYP_M2I4641                 As Integer = &H00034641
Public Const TYP_M2I4642                 As Integer = &H00034642
Public Const TYP_M2I4650                 As Integer = &H00034650
Public Const TYP_M2I4651                 As Integer = &H00034651
Public Const TYP_M2I4652                 As Integer = &H00034652

Public Const TYP_M2I4620EXP              As Integer = &H00044620
Public Const TYP_M2I4621EXP              As Integer = &H00044621
Public Const TYP_M2I4622EXP              As Integer = &H00044622
Public Const TYP_M2I4630EXP              As Integer = &H00044630
Public Const TYP_M2I4631EXP              As Integer = &H00044631
Public Const TYP_M2I4632EXP              As Integer = &H00044632
Public Const TYP_M2I4640EXP              As Integer = &H00044640
Public Const TYP_M2I4641EXP              As Integer = &H00044641
Public Const TYP_M2I4642EXP              As Integer = &H00044642
Public Const TYP_M2I4650EXP              As Integer = &H00044650
Public Const TYP_M2I4651EXP              As Integer = &H00044651
Public Const TYP_M2I4652EXP              As Integer = &H00044652

Public Const TYP_MC4620                  As Integer = &H00014620
Public Const TYP_MC4621                  As Integer = &H00014621
Public Const TYP_MC4622                  As Integer = &H00014622
Public Const TYP_MC4630                  As Integer = &H00014630
Public Const TYP_MC4631                  As Integer = &H00014631
Public Const TYP_MC4632                  As Integer = &H00014632
Public Const TYP_MC4640                  As Integer = &H00014640
Public Const TYP_MC4641                  As Integer = &H00014641
Public Const TYP_MC4642                  As Integer = &H00014642
Public Const TYP_MC4650                  As Integer = &H00014650
Public Const TYP_MC4651                  As Integer = &H00014651
Public Const TYP_MC4652                  As Integer = &H00014652

Public Const TYP_MX4620                  As Integer = &H00024620
Public Const TYP_MX4621                  As Integer = &H00024621
Public Const TYP_MX4630                  As Integer = &H00024630
Public Const TYP_MX4631                  As Integer = &H00024631
Public Const TYP_MX4640                  As Integer = &H00024640
Public Const TYP_MX4641                  As Integer = &H00024641
Public Const TYP_MX4650                  As Integer = &H00024650
Public Const TYP_MX4651                  As Integer = &H00024651



' ----- MI.47xx, MC.47xx, MX.47xx -----
Public Const TYP_MI4710                  As Integer = &H00004710
Public Const TYP_MI4711                  As Integer = &H00004711
Public Const TYP_MI4720                  As Integer = &H00004720
Public Const TYP_MI4721                  As Integer = &H00004721
Public Const TYP_MI4730                  As Integer = &H00004730
Public Const TYP_MI4731                  As Integer = &H00004731
Public Const TYP_MI4740                  As Integer = &H00004740
Public Const TYP_MI4741                  As Integer = &H00004741

Public Const TYP_M2I4710                 As Integer = &H00034710
Public Const TYP_M2I4711                 As Integer = &H00034711
Public Const TYP_M2I4720                 As Integer = &H00034720
Public Const TYP_M2I4721                 As Integer = &H00034721
Public Const TYP_M2I4730                 As Integer = &H00034730
Public Const TYP_M2I4731                 As Integer = &H00034731
Public Const TYP_M2I4740                 As Integer = &H00034740
Public Const TYP_M2I4741                 As Integer = &H00034741

Public Const TYP_M2I4710EXP              As Integer = &H00044710
Public Const TYP_M2I4711EXP              As Integer = &H00044711
Public Const TYP_M2I4720EXP              As Integer = &H00044720
Public Const TYP_M2I4721EXP              As Integer = &H00044721
Public Const TYP_M2I4730EXP              As Integer = &H00044730
Public Const TYP_M2I4731EXP              As Integer = &H00044731
Public Const TYP_M2I4740EXP              As Integer = &H00044740
Public Const TYP_M2I4741EXP              As Integer = &H00044741

Public Const TYP_MC4710                  As Integer = &H00014710
Public Const TYP_MC4711                  As Integer = &H00014711
Public Const TYP_MC4720                  As Integer = &H00014720
Public Const TYP_MC4721                  As Integer = &H00014721
Public Const TYP_MC4730                  As Integer = &H00014730
Public Const TYP_MC4731                  As Integer = &H00014731

Public Const TYP_MX4710                  As Integer = &H00024710
Public Const TYP_MX4720                  As Integer = &H00024720
Public Const TYP_MX4730                  As Integer = &H00024730



' ----- M3i.48xx, M3i.48xx-Exp (16 bit A/D) -----
Public Const TYP_M3I4830                 As Integer = &H00054830     
Public Const TYP_M3I4831                 As Integer = &H00054831    
Public Const TYP_M3I4840                 As Integer = &H00054840     
Public Const TYP_M3I4841                 As Integer = &H00054841    
Public Const TYP_M3I4860                 As Integer = &H00054860     
Public Const TYP_M3I4861                 As Integer = &H00054861    

Public Const TYP_M3I4830EXP              As Integer = &H00064830     
Public Const TYP_M3I4831EXP              As Integer = &H00064831    
Public Const TYP_M3I4840EXP              As Integer = &H00064840     
Public Const TYP_M3I4841EXP              As Integer = &H00064841    
Public Const TYP_M3I4860EXP              As Integer = &H00064860     
Public Const TYP_M3I4861EXP              As Integer = &H00064861    



' ----- MI.46xx, MC.46xx, MX.46xx -----
Public Const TYP_MI4911                  As Integer = &H00004911
Public Const TYP_MI4912                  As Integer = &H00004912
Public Const TYP_MI4931                  As Integer = &H00004931
Public Const TYP_MI4932                  As Integer = &H00004932
Public Const TYP_MI4960                  As Integer = &H00004960
Public Const TYP_MI4961                  As Integer = &H00004961
Public Const TYP_MI4963                  As Integer = &H00004963
Public Const TYP_MI4964                  As Integer = &H00004964

Public Const TYP_MC4911                  As Integer = &H00014911
Public Const TYP_MC4912                  As Integer = &H00014912
Public Const TYP_MC4931                  As Integer = &H00014931
Public Const TYP_MC4932                  As Integer = &H00014932
Public Const TYP_MC4960                  As Integer = &H00014960
Public Const TYP_MC4961                  As Integer = &H00014961
Public Const TYP_MC4963                  As Integer = &H00014963
Public Const TYP_MC4964                  As Integer = &H00014964

Public Const TYP_MX4911                  As Integer = &H00024911
Public Const TYP_MX4931                  As Integer = &H00024931
Public Const TYP_MX4960                  As Integer = &H00024960
Public Const TYP_MX4963                  As Integer = &H00024963

Public Const TYP_M2I4911                 As Integer = &H00034911
Public Const TYP_M2I4912                 As Integer = &H00034912
Public Const TYP_M2I4931                 As Integer = &H00034931
Public Const TYP_M2I4932                 As Integer = &H00034932
Public Const TYP_M2I4960                 As Integer = &H00034960
Public Const TYP_M2I4961                 As Integer = &H00034961
Public Const TYP_M2I4963                 As Integer = &H00034963
Public Const TYP_M2I4964                 As Integer = &H00034964

Public Const TYP_M2I4911EXP              As Integer = &H00044911
Public Const TYP_M2I4912EXP              As Integer = &H00044912
Public Const TYP_M2I4931EXP              As Integer = &H00044931
Public Const TYP_M2I4932EXP              As Integer = &H00044932
Public Const TYP_M2I4960EXP              As Integer = &H00044960
Public Const TYP_M2I4961EXP              As Integer = &H00044961
Public Const TYP_M2I4963EXP              As Integer = &H00044963
Public Const TYP_M2I4964EXP              As Integer = &H00044964

' ----- M2p.59xx-x4 -----
Public Const TYP_M2P59XX_X4              As Integer = &H00095900      ' generic
Public Const TYP_M2P5911_X4              As Integer = &H00095911
Public Const TYP_M2P5912_X4              As Integer = &H00095912
Public Const TYP_M2P5913_X4              As Integer = &H00095913
Public Const TYP_M2P5916_X4              As Integer = &H00095916
Public Const TYP_M2P5920_X4              As Integer = &H00095920
Public Const TYP_M2P5921_X4              As Integer = &H00095921
Public Const TYP_M2P5922_X4              As Integer = &H00095922
Public Const TYP_M2P5923_X4              As Integer = &H00095923
Public Const TYP_M2P5926_X4              As Integer = &H00095926
Public Const TYP_M2P5930_X4              As Integer = &H00095930
Public Const TYP_M2P5931_X4              As Integer = &H00095931
Public Const TYP_M2P5932_X4              As Integer = &H00095932
Public Const TYP_M2P5933_X4              As Integer = &H00095933
Public Const TYP_M2P5936_X4              As Integer = &H00095936
Public Const TYP_M2P5940_X4              As Integer = &H00095940
Public Const TYP_M2P5941_X4              As Integer = &H00095941
Public Const TYP_M2P5942_X4              As Integer = &H00095942
Public Const TYP_M2P5943_X4              As Integer = &H00095943
Public Const TYP_M2P5946_X4              As Integer = &H00095946
Public Const TYP_M2P5960_X4              As Integer = &H00095960
Public Const TYP_M2P5961_X4              As Integer = &H00095961
Public Const TYP_M2P5962_X4              As Integer = &H00095962
Public Const TYP_M2P5966_X4              As Integer = &H00095966
Public Const TYP_M2P5968_X4              As Integer = &H00095968


' ----- MI.60xx, MC.60xx, MX.60xx -----
Public Const TYP_MI6010                  As Integer = &H00006010
Public Const TYP_MI6011                  As Integer = &H00006011
Public Const TYP_MI6012                  As Integer = &H00006012
Public Const TYP_MI6021                  As Integer = &H00006021
Public Const TYP_MI6022                  As Integer = &H00006022
Public Const TYP_MI6030                  As Integer = &H00006030
Public Const TYP_MI6031                  As Integer = &H00006031
Public Const TYP_MI6033                  As Integer = &H00006033
Public Const TYP_MI6034                  As Integer = &H00006034

Public Const TYP_M2I6010                 As Integer = &H00036010
Public Const TYP_M2I6011                 As Integer = &H00036011
Public Const TYP_M2I6012                 As Integer = &H00036012
Public Const TYP_M2I6021                 As Integer = &H00036021
Public Const TYP_M2I6022                 As Integer = &H00036022
Public Const TYP_M2I6030                 As Integer = &H00036030
Public Const TYP_M2I6031                 As Integer = &H00036031
Public Const TYP_M2I6033                 As Integer = &H00036033
Public Const TYP_M2I6034                 As Integer = &H00036034

Public Const TYP_M2I6010EXP              As Integer = &H00046010
Public Const TYP_M2I6011EXP              As Integer = &H00046011
Public Const TYP_M2I6012EXP              As Integer = &H00046012
Public Const TYP_M2I6021EXP              As Integer = &H00046021
Public Const TYP_M2I6022EXP              As Integer = &H00046022
Public Const TYP_M2I6030EXP              As Integer = &H00046030
Public Const TYP_M2I6031EXP              As Integer = &H00046031
Public Const TYP_M2I6033EXP              As Integer = &H00046033
Public Const TYP_M2I6034EXP              As Integer = &H00046034

Public Const TYP_MC6010                  As Integer = &H00016010
Public Const TYP_MC6011                  As Integer = &H00016011
Public Const TYP_MC6012                  As Integer = &H00016012
Public Const TYP_MC6021                  As Integer = &H00016021
Public Const TYP_MC6022                  As Integer = &H00016022
Public Const TYP_MC6030                  As Integer = &H00016030
Public Const TYP_MC6031                  As Integer = &H00016031
Public Const TYP_MC6033                  As Integer = &H00016033
Public Const TYP_MC6034                  As Integer = &H00016034

Public Const TYP_MX6010                  As Integer = &H00026010
Public Const TYP_MX6011                  As Integer = &H00026011
Public Const TYP_MX6021                  As Integer = &H00026021
Public Const TYP_MX6030                  As Integer = &H00026030
Public Const TYP_MX6033                  As Integer = &H00026033



' ----- MI.61xx, MC.61xx, MX.61xx -----
Public Const TYP_MI6105                  As Integer = &H00006105
Public Const TYP_MI6110                  As Integer = &H00006110
Public Const TYP_MI6111                  As Integer = &H00006111

Public Const TYP_M2I6105                 As Integer = &H00036105
Public Const TYP_M2I6110                 As Integer = &H00036110
Public Const TYP_M2I6111                 As Integer = &H00036111

Public Const TYP_M2I6105EXP              As Integer = &H00046105
Public Const TYP_M2I6110EXP              As Integer = &H00046110
Public Const TYP_M2I6111EXP              As Integer = &H00046111

Public Const TYP_MC6110                  As Integer = &H00016110
Public Const TYP_MC6111                  As Integer = &H00016111

Public Const TYP_MX6110                  As Integer = &H00026110

' ----- M2p.65xx-x4 -----
Public Const TYP_M2P65XX_X4              As Integer = &H00096500      ' generic
Public Const TYP_M2P6522_X4              As Integer = &H00096522      ' 4 ch @   40 MS/s (1x4) (low voltage)
Public Const TYP_M2P6523_X4              As Integer = &H00096523      ' 8 ch @   40 MS/s (low voltage)
Public Const TYP_M2P6530_X4              As Integer = &H00096530      ' 1 ch @   40 MS/s
Public Const TYP_M2P6531_X4              As Integer = &H00096531      ' 2 ch @   40 MS/s
Public Const TYP_M2P6532_X4              As Integer = &H00096532      ' 4 ch @   40 MS/s (1x4)
Public Const TYP_M2P6536_X4              As Integer = &H00096536      ' 4 ch @   40 MS/s (2x2)
Public Const TYP_M2P6533_X4              As Integer = &H00096533      ' 8 ch @   40 MS/s
Public Const TYP_M2P6540_X4              As Integer = &H00096540      ' 1 ch @   40 MS/s (high voltage)
Public Const TYP_M2P6541_X4              As Integer = &H00096541      ' 2 ch @   40 MS/s (high voltage)
Public Const TYP_M2P6546_X4              As Integer = &H00096546      ' 4 ch @   40 MS/s (2x2) (high voltage)
Public Const TYP_M2P6560_X4              As Integer = &H00096560      ' 1 ch @  125 MS/s
Public Const TYP_M2P6561_X4              As Integer = &H00096561      ' 2 ch @  125 MS/s
Public Const TYP_M2P6562_X4              As Integer = &H00096562      ' 4 ch @  125 MS/s (1x4)
Public Const TYP_M2P6566_X4              As Integer = &H00096566      ' 4 ch @  125 MS/s (2x2)
Public Const TYP_M2P6568_X4              As Integer = &H00096568      ' 8 ch @  125/80 MS/s
Public Const TYP_M2P6570_X4              As Integer = &H00096570      ' 1 ch @  125 MS/s (high voltage)
Public Const TYP_M2P6571_X4              As Integer = &H00096571      ' 2 ch @  125 MS/s (high voltage)
Public Const TYP_M2P6576_X4              As Integer = &H00096576      ' 4 ch @  125 MS/s (2x2) (high voltage)

' ----- M4i.66xx-x8 (16 bit D/A) -----
' ----- M4i.66xx-x8 (generic) -----
Public Const TYP_M4I66XX_X8              As Integer = &H00076600

Public Const TYP_M4I6620_X8              As Integer = &H00076620      ' 1 ch @  625 MS/s
Public Const TYP_M4I6621_X8              As Integer = &H00076621      ' 2 ch @  625 MS/s
Public Const TYP_M4I6622_X8              As Integer = &H00076622      ' 4 ch @  625 MS/s
Public Const TYP_M4I6630_X8              As Integer = &H00076630      ' 1 ch @ 1250 MS/s
Public Const TYP_M4I6631_X8              As Integer = &H00076631      ' 2 ch @ 1250 MS/s

' ----- M4x.66xx-x8 (16 bit D/A) -----
' ----- M4x.66xx-x8 (generic) -----
Public Const TYP_M4X66XX_X4              As Integer = &H00086600

Public Const TYP_M4X6620_X4              As Integer = &H00086620      ' 1 ch @  625 MS/s
Public Const TYP_M4X6621_X4              As Integer = &H00086621      ' 2 ch @  625 MS/s
Public Const TYP_M4X6622_X4              As Integer = &H00086622      ' 4 ch @  625 MS/s
Public Const TYP_M4X6630_X4              As Integer = &H00086630      ' 1 ch @ 1250 MS/s
Public Const TYP_M4X6631_X4              As Integer = &H00086631      ' 2 ch @ 1250 MS/s

' ----- MI.70xx, MC.70xx, MX.70xx -----
Public Const TYP_MI7005                  As Integer = &H00007005
Public Const TYP_MI7010                  As Integer = &H00007010
Public Const TYP_MI7011                  As Integer = &H00007011
Public Const TYP_MI7020                  As Integer = &H00007020
Public Const TYP_MI7021                  As Integer = &H00007021

Public Const TYP_M2I7005                 As Integer = &H00037005
Public Const TYP_M2I7010                 As Integer = &H00037010
Public Const TYP_M2I7011                 As Integer = &H00037011
Public Const TYP_M2I7020                 As Integer = &H00037020
Public Const TYP_M2I7021                 As Integer = &H00037021

Public Const TYP_M2I7005EXP              As Integer = &H00047005
Public Const TYP_M2I7010EXP              As Integer = &H00047010
Public Const TYP_M2I7011EXP              As Integer = &H00047011
Public Const TYP_M2I7020EXP              As Integer = &H00047020
Public Const TYP_M2I7021EXP              As Integer = &H00047021

Public Const TYP_MC7005                  As Integer = &H00017005
Public Const TYP_MC7010                  As Integer = &H00017010
Public Const TYP_MC7011                  As Integer = &H00017011
Public Const TYP_MC7020                  As Integer = &H00017020
Public Const TYP_MC7021                  As Integer = &H00017021

Public Const TYP_MX7005                  As Integer = &H00027005
Public Const TYP_MX7010                  As Integer = &H00027010
Public Const TYP_MX7011                  As Integer = &H00027011



' ----- MI.72xx, MC.72xx, MX.72xx -----
Public Const TYP_MI7210                  As Integer = &H00007210
Public Const TYP_MI7211                  As Integer = &H00007211
Public Const TYP_MI7220                  As Integer = &H00007220
Public Const TYP_MI7221                  As Integer = &H00007221

Public Const TYP_M2I7210                 As Integer = &H00037210
Public Const TYP_M2I7211                 As Integer = &H00037211
Public Const TYP_M2I7220                 As Integer = &H00037220
Public Const TYP_M2I7221                 As Integer = &H00037221

Public Const TYP_M2I7210EXP              As Integer = &H00047210
Public Const TYP_M2I7211EXP              As Integer = &H00047211
Public Const TYP_M2I7220EXP              As Integer = &H00047220
Public Const TYP_M2I7221EXP              As Integer = &H00047221

Public Const TYP_MC7210                  As Integer = &H00017210
Public Const TYP_MC7211                  As Integer = &H00017211
Public Const TYP_MC7220                  As Integer = &H00017220
Public Const TYP_MC7221                  As Integer = &H00017221

Public Const TYP_MX7210                  As Integer = &H00027210
Public Const TYP_MX7220                  As Integer = &H00027220

' ----- M2p.75xx-x4 -----
Public Const TYP_M2P75XX_X4              As Integer = &H00097500      ' generic
Public Const TYP_M2P7515_X4              As Integer = &H00097515

' ----- M4i.77xx-x8  -----
Public Const TYP_M4I77XX_X8              As Integer = &H00077700 ' generic
Public Const TYP_M4I7710_X8              As Integer = &H00077710 ' single-ended
Public Const TYP_M4I7720_X8              As Integer = &H00077720 ' single-ended
Public Const TYP_M4I7730_X8              As Integer = &H00077730 ' single-ended
Public Const TYP_M4I7725_X8              As Integer = &H00077725 ' differential
Public Const TYP_M4I7735_X8              As Integer = &H00077735 ' differential

' ----- M4x.77xx-x8  -----
Public Const TYP_M4X77XX_X4              As Integer = &H00087700 ' generic
Public Const TYP_M4X7710_X4              As Integer = &H00087710 ' single-ended
Public Const TYP_M4X7720_X4              As Integer = &H00087720 ' single-ended
Public Const TYP_M4X7730_X4              As Integer = &H00087730 ' single-ended
Public Const TYP_M4X7725_X4              As Integer = &H00087725 ' differential
Public Const TYP_M4X7735_X4              As Integer = &H00087735 ' differential

' ----- MX.90xx -----
Public Const TYP_MX9010                  As Integer = &H00029010



' ***********************************************************************
' software registers
' ***********************************************************************


' ***** PCI Features Bits (MI/MC/MX and prior cards) *********
Public Const PCIBIT_MULTI                As Integer = &H00000001
Public Const PCIBIT_DIGITAL              As Integer = &H00000002
Public Const PCIBIT_CH0DIGI              As Integer = &H00000004
Public Const PCIBIT_EXTSAM               As Integer = &H00000008
Public Const PCIBIT_3CHANNEL             As Integer = &H00000010
Public Const PCIBIT_GATE                 As Integer = &H00000020
Public Const PCIBIT_SLAVE                As Integer = &H00000040
Public Const PCIBIT_MASTER               As Integer = &H00000080
Public Const PCIBIT_DOUBLEMEM            As Integer = &H00000100
Public Const PCIBIT_SYNC                 As Integer = &H00000200
Public Const PCIBIT_TIMESTAMP            As Integer = &H00000400
Public Const PCIBIT_STARHUB              As Integer = &H00000800
Public Const PCIBIT_CA                   As Integer = &H00001000
Public Const PCIBIT_XIO                  As Integer = &H00002000
Public Const PCIBIT_AMPLIFIER            As Integer = &H00004000
Public Const PCIBIT_DIFFMODE             As Integer = &H00008000

Public Const PCIBIT_ELISA                As Integer = &H10000000


' ***** PCI features starting with M2i card series *****
Public Const SPCM_FEAT_MULTI             As Integer = &H00000001      ' multiple recording
Public Const SPCM_FEAT_GATE              As Integer = &H00000002      ' gated sampling
Public Const SPCM_FEAT_DIGITAL           As Integer = &H00000004      ' additional synchronous digital inputs or outputs
Public Const SPCM_FEAT_TIMESTAMP         As Integer = &H00000008      ' timestamp
Public Const SPCM_FEAT_STARHUB5          As Integer = &H00000020      ' starhub for  5 cards installed (M2i + M2i-Exp)
Public Const SPCM_FEAT_STARHUB4          As Integer = &H00000020      ' starhub for  4 cards installed (M3i + M3i-Exp)
Public Const SPCM_FEAT_STARHUB6_EXTM     As Integer = &H00000020      ' starhub for  6 cards installed as card extension or piggy back (M2p)
Public Const SPCM_FEAT_STARHUB8_EXTM     As Integer = &H00000020      ' starhub for  8 cards installed as card extension or piggy back (M4i-Exp)
Public Const SPCM_FEAT_STARHUB16         As Integer = &H00000040      ' starhub for 16 cards installed (M2i, M2i-exp)
Public Const SPCM_FEAT_STARHUB16_EXTM    As Integer = &H00000040      ' starhub for 16 cards installed as card extension or piggy back (M2p)
Public Const SPCM_FEAT_STARHUB8          As Integer = &H00000040      ' starhub for  8 cards installed (M3i + M3i-Exp)
Public Const SPCM_FEAT_STARHUBXX_MASK    As Integer = &H00000060      ' mask to detect one of the above installed starhub
Public Const SPCM_FEAT_ABA               As Integer = &H00000080      ' ABA mode installed
Public Const SPCM_FEAT_BASEXIO           As Integer = &H00000100      ' extra I/O on base card installed
Public Const SPCM_FEAT_AMPLIFIER_10V     As Integer = &H00000200      ' external amplifier for 60/61
Public Const SPCM_FEAT_STARHUBSYSMASTER  As Integer = &H00000400      ' system starhub master installed
Public Const SPCM_FEAT_DIFFMODE          As Integer = &H00000800      ' Differential mode installed
Public Const SPCM_FEAT_SEQUENCE          As Integer = &H00001000      ' Sequence programming mode for generator cards
Public Const SPCM_FEAT_AMPMODULE_10V     As Integer = &H00002000      ' amplifier module for 60/61
Public Const SPCM_FEAT_STARHUBSYSSLAVE   As Integer = &H00004000      ' system starhub slave installed
Public Const SPCM_FEAT_NETBOX            As Integer = &H00008000      ' card is part of netbox
Public Const SPCM_FEAT_REMOTESERVER      As Integer = &H00010000      ' remote server can be used with this card
Public Const SPCM_FEAT_SCAPP             As Integer = &H00020000      ' SCAPP option (CUDA RDMA)
Public Const SPCM_FEAT_DIG16_SMB         As Integer = &H00040000      ' M2p: 16 additional digital inputs or outputs (via SMB connectors) 
Public Const SPCM_FEAT_DIG8_SMA          As Integer = &H00040000      ' M4i:  8 additional digital inputs or 6 additional outputs (via SMA connectors) 
Public Const SPCM_FEAT_DIG16_FX2         As Integer = &H00080000      ' M2p: 16 additional digital inputs or outputs (via FX2 connector)
Public Const SPCM_FEAT_DIGITALBWFILTER   As Integer = &H00100000      ' Digital BW filter is available
Public Const SPCM_FEAT_CUSTOMMOD_MASK    As Integer = &HF0000000      ' mask for custom modification code, meaning of code depends on type and customer


' ***** Extended Features starting with M4i *****
Public Const SPCM_FEAT_EXTFW_SEGSTAT     As Integer = &H00000001        ' segment (Multiple Recording, ABA) statistics like average, min/max
Public Const SPCM_FEAT_EXTFW_SEGAVERAGE  As Integer = &H00000002        ' average of multiple segments (Multiple Recording, ABA) 
Public Const SPCM_FEAT_EXTFW_BOXCAR      As Integer = &H00000004      ' boxcar averaging (high-res mode)


' ***** Error Request *************
Public Const ERRORTEXTLEN                As Integer = 200
Public Const SPC_LASTERRORTEXT           As Integer = 999996
Public Const SPC_LASTERRORVALUE          As Integer = 999997
Public Const SPC_LASTERRORREG            As Integer = 999998
Public Const SPC_LASTERRORCODE           As Integer = 999999     ' Reading this reset the internal error-memory.

' ***** constants to use with the various _ACDC registers *****
Public Const COUPLING_DC As Integer = 0
Public Const COUPLING_AC As Integer = 1


' ***** Register and Command Structure
Public Const SPC_COMMAND                 As Integer = 0
Public Const     SPC_RESET               As Integer = 0
Public Const     SPC_SOFTRESET           As Integer = 1
Public Const     SPC_WRITESETUP          As Integer = 2
Public Const     SPC_START               As Integer = 10
Public Const     SPC_STARTANDWAIT        As Integer = 11
Public Const     SPC_FIFOSTART           As Integer = 12
Public Const     SPC_FIFOWAIT            As Integer = 13
Public Const     SPC_FIFOSTARTNOWAIT     As Integer = 14
Public Const     SPC_FORCETRIGGER        As Integer = 16
Public Const     SPC_STOP                As Integer = 20
Public Const     SPC_FLUSHFIFOBUFFER     As Integer = 21
Public Const     SPC_POWERDOWN           As Integer = 30
Public Const     SPC_SYNCMASTER          As Integer = 100
Public Const     SPC_SYNCTRIGGERMASTER   As Integer = 101
Public Const     SPC_SYNCMASTERFIFO      As Integer = 102
Public Const     SPC_SYNCSLAVE           As Integer = 110
Public Const     SPC_SYNCTRIGGERSLAVE    As Integer = 111
Public Const     SPC_SYNCSLAVEFIFO       As Integer = 112
Public Const     SPC_NOSYNC              As Integer = 120
Public Const     SPC_SYNCSTART           As Integer = 130
Public Const     SPC_SYNCCALCMASTER      As Integer = 140
Public Const     SPC_SYNCCALCMASTERFIFO  As Integer = 141
Public Const     SPC_PXIDIVIDERRESET     As Integer = 150
Public Const     SPC_RELAISON            As Integer = 200
Public Const     SPC_RELAISOFF           As Integer = 210
Public Const     SPC_ADJUSTSTART         As Integer = 300
Public Const     SPC_FIFO_BUFREADY0      As Integer = 400
Public Const     SPC_FIFO_BUFREADY1      As Integer = 401
Public Const     SPC_FIFO_BUFREADY2      As Integer = 402
Public Const     SPC_FIFO_BUFREADY3      As Integer = 403
Public Const     SPC_FIFO_BUFREADY4      As Integer = 404
Public Const     SPC_FIFO_BUFREADY5      As Integer = 405
Public Const     SPC_FIFO_BUFREADY6      As Integer = 406
Public Const     SPC_FIFO_BUFREADY7      As Integer = 407
Public Const     SPC_FIFO_BUFREADY8      As Integer = 408
Public Const     SPC_FIFO_BUFREADY9      As Integer = 409
Public Const     SPC_FIFO_BUFREADY10     As Integer = 410
Public Const     SPC_FIFO_BUFREADY11     As Integer = 411
Public Const     SPC_FIFO_BUFREADY12     As Integer = 412
Public Const     SPC_FIFO_BUFREADY13     As Integer = 413
Public Const     SPC_FIFO_BUFREADY14     As Integer = 414
Public Const     SPC_FIFO_BUFREADY15     As Integer = 415
Public Const     SPC_FIFO_AUTOBUFSTART   As Integer = 500
Public Const     SPC_FIFO_AUTOBUFEND     As Integer = 510

Public Const SPC_STATUS                  As Integer = 10
Public Const     SPC_RUN                 As Integer = 0
Public Const     SPC_TRIGGER             As Integer = 10
Public Const     SPC_READY               As Integer = 20



' commands for M2 cards
Public Const SPC_M2CMD                   As Integer = 100                ' write a command
Public Const     M2CMD_CARD_RESET            As Integer = &H00000001     ' hardware reset   
Public Const     M2CMD_CARD_WRITESETUP       As Integer = &H00000002     ' write setup only
Public Const     M2CMD_CARD_START            As Integer = &H00000004     ' start of card (including writesetup)
Public Const     M2CMD_CARD_ENABLETRIGGER    As Integer = &H00000008     ' enable trigger engine
Public Const     M2CMD_CARD_FORCETRIGGER     As Integer = &H00000010     ' force trigger
Public Const     M2CMD_CARD_DISABLETRIGGER   As Integer = &H00000020     ' disable trigger engine again (multi or gate)
Public Const     M2CMD_CARD_STOP             As Integer = &H00000040     ' stop run
Public Const     M2CMD_CARD_FLUSHFIFO        As Integer = &H00000080     ' flush fifos to memory
Public Const     M2CMD_CARD_INVALIDATEDATA   As Integer = &H00000100     ' current data in memory is invalidated, next data transfer start will wait until new data is available
Public Const     M2CMD_CARD_INTERNALRESET    As Integer = &H00000200     ' INTERNAL reset command

Public Const     M2CMD_ALL_STOP              As Integer = &H00440060     ' stops card and all running transfers

Public Const     M2CMD_CARD_WAITPREFULL      As Integer = &H00001000     ' wait until pretrigger is full
Public Const     M2CMD_CARD_WAITTRIGGER      As Integer = &H00002000     ' wait for trigger recognition
Public Const     M2CMD_CARD_WAITREADY        As Integer = &H00004000     ' wait for card ready

Public Const     M2CMD_DATA_STARTDMA         As Integer = &H00010000     ' start of DMA transfer for data
Public Const     M2CMD_DATA_WAITDMA          As Integer = &H00020000     ' wait for end of data transfer / next block ready
Public Const     M2CMD_DATA_STOPDMA          As Integer = &H00040000     ' abort the data transfer
Public Const     M2CMD_DATA_POLL             As Integer = &H00080000     ' transfer data using single access and polling

Public Const     M2CMD_EXTRA_STARTDMA        As Integer = &H00100000     ' start of DMA transfer for extra (ABA + timestamp) data
Public Const     M2CMD_EXTRA_WAITDMA         As Integer = &H00200000     ' wait for end of extra (ABA + timestamp) data transfer / next block ready
Public Const     M2CMD_EXTRA_STOPDMA         As Integer = &H00400000     ' abort the extra (ABA + timestamp) data transfer
Public Const     M2CMD_EXTRA_POLL            As Integer = &H00800000     ' transfer data using single access and polling

Public Const     M2CMD_DATA_SGFLUSH          As Integer = &H01000000     ' flush incomplete pages from sg list


' status for M2 cards (bitmask)
Public Const SPC_M2STATUS                As Integer = 110                ' read the current status
Public Const     M2STAT_NONE                 As Integer = &H00000000     ' status empty
Public Const     M2STAT_CARD_PRETRIGGER      As Integer = &H00000001     ' pretrigger area is full
Public Const     M2STAT_CARD_TRIGGER         As Integer = &H00000002     ' trigger recognized
Public Const     M2STAT_CARD_READY           As Integer = &H00000004     ' card is ready, run finished
Public Const     M2STAT_CARD_SEGMENT_PRETRG  As Integer = &H00000008     ' since M4i: at muliple-recording: pretrigger area of a segment is full

Public Const     M2STAT_DATA_BLOCKREADY      As Integer = &H00000100     ' next data block is available
Public Const     M2STAT_DATA_END             As Integer = &H00000200     ' data transfer has ended
Public Const     M2STAT_DATA_OVERRUN         As Integer = &H00000400     ' FIFO overrun (record) or underrun (replay)
Public Const     M2STAT_DATA_ERROR           As Integer = &H00000800     ' internal error

Public Const     M2STAT_EXTRA_BLOCKREADY     As Integer = &H00001000     ' next extra data (ABA and timestamp) block is available
Public Const     M2STAT_EXTRA_END            As Integer = &H00002000     ' extra data (ABA and timestamp) transfer has ended
Public Const     M2STAT_EXTRA_OVERRUN        As Integer = &H00004000     ' FIFO overrun
Public Const     M2STAT_EXTRA_ERROR          As Integer = &H00008000     ' internal error

Public Const     M2STAT_TSCNT_OVERRUN        As Integer = &H00010000     ' timestamp counter overrun

Public Const     M2STAT_INTERNALMASK         As Integer = &Hff000000     ' mask for internal status signals
Public Const     M2STAT_INTERNAL_SYSLOCK     As Integer = &H02000000



' buffer control registers for samples data
Public Const SPC_DATA_AVAIL_USER_LEN     As Integer = 200                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_DATA_AVAIL_USER_POS     As Integer = 201                ' the current byte position where the available user data starts
Public Const SPC_DATA_AVAIL_CARD_LEN     As Integer = 202                ' number of bytes available for card (free buffer if READ, filled data if WRITE)
Public Const SPC_DATA_OUTBUFSIZE         As Integer = 209                ' output buffer size in bytes

' buffer control registers for extra data (ABA slow data, timestamps)
Public Const SPC_ABA_AVAIL_USER_LEN      As Integer = 210                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_ABA_AVAIL_USER_POS      As Integer = 211                ' the current byte position where the available user data starts
Public Const SPC_ABA_AVAIL_CARD_LEN      As Integer = 212                ' number of bytes available for card (free buffer if READ, filled data if WRITE)

Public Const SPC_TS_AVAIL_USER_LEN       As Integer = 220                ' number of bytes available for user (valid data if READ, free buffer if WRITE)
Public Const SPC_TS_AVAIL_USER_POS       As Integer = 221                ' the current byte position where the available user data starts
Public Const SPC_TS_AVAIL_CARD_LEN       As Integer = 222                ' number of bytes available for card (free buffer if READ, filled data if WRITE)



' Installation
Public Const SPC_VERSION                 As Integer = 1000
Public Const SPC_ISAADR                  As Integer = 1010
Public Const SPC_INSTMEM                 As Integer = 1020
Public Const SPC_INSTSAMPLERATE          As Integer = 1030
Public Const SPC_BRDTYP                  As Integer = 1040

' MI/MC/MX type information (internal use)
Public Const SPC_MIINST_MODULES          As Integer = 1100
Public Const SPC_MIINST_CHPERMODULE      As Integer = 1110
Public Const SPC_MIINST_BYTESPERSAMPLE   As Integer = 1120
Public Const SPC_MIINST_BITSPERSAMPLE    As Integer = 1125
Public Const SPC_MIINST_MAXADCVALUE      As Integer = 1126
Public Const SPC_MIINST_MINADCLOCK       As Integer = 1130
Public Const SPC_MIINST_MAXADCLOCK       As Integer = 1140
Public Const SPC_MIINST_MINEXTCLOCK      As Integer = 1145
Public Const SPC_MIINST_MAXEXTCLOCK      As Integer = 1146
Public Const SPC_MIINST_MINSYNCCLOCK     As Integer = 1147
Public Const SPC_MIINST_MINEXTREFCLOCK   As Integer = 1148
Public Const SPC_MIINST_MAXEXTREFCLOCK   As Integer = 1149
Public Const SPC_MIINST_QUARZ            As Integer = 1150
Public Const SPC_MIINST_QUARZ2           As Integer = 1151
Public Const SPC_MIINST_MINEXTCLOCK1     As Integer = 1152
Public Const SPC_MIINST_FLAGS            As Integer = 1160
Public Const SPC_MIINST_FIFOSUPPORT      As Integer = 1170
Public Const SPC_MIINST_ISDEMOCARD       As Integer = 1175

' Driver information
Public Const SPC_GETDRVVERSION           As Integer = 1200
Public Const SPC_GETKERNELVERSION        As Integer = 1210
Public Const SPC_GETDRVTYPE              As Integer = 1220
Public Const     DRVTYP_DOS              As Integer = 0
Public Const     DRVTYP_LINUX32          As Integer = 1
Public Const     DRVTYP_VXD              As Integer = 2
Public Const     DRVTYP_NTLEGACY         As Integer = 3
Public Const     DRVTYP_WDM32            As Integer = 4
Public Const     DRVTYP_WDM64            As Integer = 5
Public Const     DRVTYP_WOW64            As Integer = 6
Public Const     DRVTYP_LINUX64          As Integer = 7
Public Const     DRVTYP_QNX32            As Integer = 8
Public Const     DRVTYP_QNX64            As Integer = 9
Public Const SPC_GETCOMPATIBILITYVERSION As Integer = 1230
Public Const SPC_GETMINDRVVERSION        As Integer = 1240

' PCI, CompactPCI and PXI Installation Information
Public Const SPC_PCITYP                  As Integer = 2000

' ***** available card function types *****
Public Const SPC_FNCTYPE                 As Integer = 2001
Public Const     SPCM_TYPE_AI            As Integer = &H01
Public Const     SPCM_TYPE_AO            As Integer = &H02
Public Const     SPCM_TYPE_DI            As Integer = &H04
Public Const     SPCM_TYPE_DO            As Integer = &H08
Public Const     SPCM_TYPE_DIO           As Integer = &H10

Public Const SPC_PCIVERSION              As Integer = 2010
Public Const SPC_PCIEXTVERSION           As Integer = 2011
Public Const SPC_PCIMODULEVERSION        As Integer = 2012
Public Const SPC_PCIMODULEBVERSION       As Integer = 2013
Public Const SPC_BASEPCBVERSION          As Integer = 2014
Public Const SPC_MODULEPCBVERSION        As Integer = 2015
Public Const SPC_MODULEAPCBVERSION       As Integer = 2015
Public Const SPC_MODULEBPCBVERSION       As Integer = 2016
Public Const SPC_EXTPCBVERSION           As Integer = 2017
Public Const SPC_PCIDIGVERSION           As Integer = 2018
Public Const SPC_DIGPCBVERSION           As Integer = 2019
Public Const SPC_PCIDATE                 As Integer = 2020
Public Const SPC_CALIBDATE               As Integer = 2025
Public Const SPC_CALIBDATEONBOARD        As Integer = 2026
Public Const SPC_PCISERIALNR             As Integer = 2030
Public Const SPC_PCISERIALNO             As Integer = 2030
Public Const SPC_PCIHWBUSNO              As Integer = 2040
Public Const SPC_PCIHWDEVNO              As Integer = 2041
Public Const SPC_PCIHWFNCNO              As Integer = 2042
Public Const SPC_PCIHWSLOTNO             As Integer = 2043
Public Const SPC_PCIEXPGENERATION        As Integer = 2050
Public Const SPC_PCIEXPLANES             As Integer = 2051
Public Const SPC_PCIEXPPAYLOAD           As Integer = 2052
Public Const SPC_PCIEXPREADREQUESTSIZE   As Integer = 2053
Public Const SPC_PCIEXPREADCOMPLBOUNDARY As Integer = 2054
Public Const SPC_PXIHWSLOTNO             As Integer = 2055
Public Const SPC_PCISAMPLERATE           As Integer = 2100
Public Const SPC_PCIMEMSIZE              As Integer = 2110
Public Const SPC_PCIFEATURES             As Integer = 2120
Public Const SPC_PCIEXTFEATURES          As Integer = 2121
Public Const SPC_PCIINFOADR              As Integer = 2200
Public Const SPC_PCIINTERRUPT            As Integer = 2300
Public Const SPC_PCIBASEADR0             As Integer = 2400
Public Const SPC_PCIBASEADR1             As Integer = 2401
Public Const SPC_PCIREGION0              As Integer = 2410
Public Const SPC_PCIREGION1              As Integer = 2411
Public Const SPC_READTRGLVLCOUNT         As Integer = 2500
Public Const SPC_READIRCOUNT             As Integer = 3000
Public Const SPC_READUNIPOLAR0           As Integer = 3010
Public Const SPC_READUNIPOLAR1           As Integer = 3020
Public Const SPC_READUNIPOLAR2           As Integer = 3030
Public Const SPC_READUNIPOLAR3           As Integer = 3040
Public Const SPC_READMAXOFFSET           As Integer = 3100

Public Const SPC_READAIFEATURES          As Integer = 3101
Public Const     SPCM_AI_TERM            As Integer = &H00000001  ' input termination available
Public Const     SPCM_AI_SE              As Integer = &H00000002  ' single-ended mode available
Public Const     SPCM_AI_DIFF            As Integer = &H00000004  ' differential mode available
Public Const     SPCM_AI_OFFSPERCENT     As Integer = &H00000008  ' offset programming is done in percent of input range
Public Const     SPCM_AI_OFFSMV          As Integer = &H00000010  ' offset programming is done in mV absolut
Public Const     SPCM_AI_OVERRANGEDETECT As Integer = &H00000020  ' overrange detection is programmable
Public Const     SPCM_AI_DCCOUPLING      As Integer = &H00000040  ' DC coupling available
Public Const     SPCM_AI_ACCOUPLING      As Integer = &H00000080  ' AC coupling available
Public Const     SPCM_AI_LOWPASS         As Integer = &H00000100  ' selectable low pass
Public Const     SPCM_AI_ACDC_OFFS_COMP  As Integer = &H00000200  ' AC/DC offset compensation
Public Const     SPCM_AI_DIFFMUX         As Integer = &H00000400  ' differential mode (two channels combined to one) available
Public Const     SPCM_AI_GLOBALLOWPASS   As Integer = &H00000800  ' globally selectable low pass (all channels same setting)
Public Const     SPCM_AI_AUTOCALOFFS     As Integer = &H00001000  ' automatic offset calibration in hardware
Public Const     SPCM_AI_AUTOCALGAIN     As Integer = &H00002000  ' automatic gain calibration in hardware
Public Const     SPCM_AI_AUTOCALOFFSNOIN As Integer = &H00004000  ' automatic offset calibration with open inputs
Public Const     SPCM_AI_HIGHIMP         As Integer = &H00008000  ' high impedance available
Public Const     SPCM_AI_LOWIMP          As Integer = &H00010000  ' low impedance available (50 ohm)
Public Const     SPCM_AI_DIGITALLOWPASS  As Integer = &H00020000  ' selectable digital low pass filter
Public Const     SPCM_AI_INDIVPULSEWIDTH As Integer = &H00100000  ' individual pulsewidth per channel available

Public Const SPC_READAOFEATURES          As Integer = 3102
Public Const     SPCM_AO_SE              As Integer = &H00000002  ' single-ended mode available
Public Const     SPCM_AO_DIFF            As Integer = &H00000004  ' differential mode available
Public Const     SPCM_AO_PROGFILTER      As Integer = &H00000008  ' programmable filters available
Public Const     SPCM_AO_PROGOFFSET      As Integer = &H00000010  ' programmable offset available
Public Const     SPCM_AO_PROGGAIN        As Integer = &H00000020  ' programmable gain available
Public Const     SPCM_AO_PROGSTOPLEVEL   As Integer = &H00000040  ' programmable stop level available
Public Const     SPCM_AO_DOUBLEOUT       As Integer = &H00000080  ' double out mode available
Public Const     SPCM_AO_ENABLEOUT       As Integer = &H00000100  ' outputs can be disabled/enabled

Public Const SPC_READDIFEATURES          As Integer = 3103
Public Const     SPCM_DI_TERM            As Integer = &H00000001  ' input termination available
Public Const     SPCM_DI_SE              As Integer = &H00000002  ' single-ended mode available
Public Const     SPCM_DI_DIFF            As Integer = &H00000004  ' differential mode available
Public Const     SPCM_DI_PROGTHRESHOLD   As Integer = &H00000008  ' programmable threshold available
Public Const     SPCM_DI_HIGHIMP         As Integer = &H00000010  ' high impedance available
Public Const     SPCM_DI_LOWIMP          As Integer = &H00000020  ' low impedance available
Public Const     SPCM_DI_INDIVPULSEWIDTH As Integer = &H00100000  ' individual pulsewidth per channel available
Public Const     SPCM_DI_IOCHANNEL       As Integer = &H00200000  ' connected with DO channel

Public Const SPC_READDOFEATURES          As Integer = 3104
Public Const     SPCM_DO_SE              As Integer = &H00000002  ' single-ended mode available
Public Const     SPCM_DO_DIFF            As Integer = &H00000004  ' differential mode available
Public Const     SPCM_DO_PROGSTOPLEVEL   As Integer = &H00000008  ' programmable stop level available
Public Const     SPCM_DO_PROGOUTLEVELS   As Integer = &H00000010  ' programmable output levels (low + high) available
Public Const     SPCM_DO_ENABLEMASK      As Integer = &H00000020  ' individual enable mask for each output channel
Public Const     SPCM_DO_IOCHANNEL       As Integer = &H00200000  ' connected with DI channel

Public Const SPC_READCHGROUPING          As Integer = 3110
Public Const SPC_READAIPATHCOUNT         As Integer = 3120       ' number of available analog input paths
Public Const SPC_READAIPATH              As Integer = 3121       ' the current path for which all the settings are read

Public Const SPCM_CUSTOMMOD              As Integer = 3130
Public Const     SPCM_CUSTOMMOD_BASE_MASK    As Integer = &H000000FF
Public Const     SPCM_CUSTOMMOD_MODULE_MASK  As Integer = &H0000FF00
Public Const     SPCM_CUSTOMMOD_STARHUB_MASK As Integer = &H00FF0000

Public Const SPC_READRANGECH0_0          As Integer = 3200
Public Const SPC_READRANGECH0_1          As Integer = 3201
Public Const SPC_READRANGECH0_2          As Integer = 3202
Public Const SPC_READRANGECH0_3          As Integer = 3203
Public Const SPC_READRANGECH0_4          As Integer = 3204
Public Const SPC_READRANGECH0_5          As Integer = 3205
Public Const SPC_READRANGECH0_6          As Integer = 3206
Public Const SPC_READRANGECH0_7          As Integer = 3207
Public Const SPC_READRANGECH0_8          As Integer = 3208
Public Const SPC_READRANGECH0_9          As Integer = 3209
Public Const SPC_READRANGECH1_0          As Integer = 3300
Public Const SPC_READRANGECH1_1          As Integer = 3301
Public Const SPC_READRANGECH1_2          As Integer = 3302
Public Const SPC_READRANGECH1_3          As Integer = 3303
Public Const SPC_READRANGECH1_4          As Integer = 3304
Public Const SPC_READRANGECH1_5          As Integer = 3305
Public Const SPC_READRANGECH1_6          As Integer = 3306
Public Const SPC_READRANGECH1_7          As Integer = 3307
Public Const SPC_READRANGECH1_8          As Integer = 3308
Public Const SPC_READRANGECH1_9          As Integer = 3309
Public Const SPC_READRANGECH2_0          As Integer = 3400
Public Const SPC_READRANGECH2_1          As Integer = 3401
Public Const SPC_READRANGECH2_2          As Integer = 3402
Public Const SPC_READRANGECH2_3          As Integer = 3403
Public Const SPC_READRANGECH3_0          As Integer = 3500
Public Const SPC_READRANGECH3_1          As Integer = 3501
Public Const SPC_READRANGECH3_2          As Integer = 3502
Public Const SPC_READRANGECH3_3          As Integer = 3503

Public Const SPC_READRANGEMIN0           As Integer = 4000
Public Const SPC_READRANGEMIN99          As Integer = 4099
Public Const SPC_READRANGEMAX0           As Integer = 4100
Public Const SPC_READRANGEMAX99          As Integer = 4199
Public Const SPC_READOFFSMIN0            As Integer = 4200
Public Const SPC_READOFFSMIN99           As Integer = 4299
Public Const SPC_READOFFSMAX0            As Integer = 4300
Public Const SPC_READOFFSMAX99           As Integer = 4399
Public Const SPC_PCICOUNTER              As Integer = 9000
Public Const SPC_BUFFERPOS               As Integer = 9010

Public Const SPC_READAOGAINMIN           As Integer = 9100
Public Const SPC_READAOGAINMAX           As Integer = 9110
Public Const SPC_READAOOFFSETMIN         As Integer = 9120
Public Const SPC_READAOOFFSETMAX         As Integer = 9130

Public Const SPC_CARDMODE                As Integer = 9500       ' card modes as listed below
Public Const SPC_AVAILCARDMODES          As Integer = 9501       ' list with available card modes

' card modes
Public Const     SPC_REC_STD_SINGLE          As Integer = &H00000001  ' singleshot recording to memory
Public Const     SPC_REC_STD_MULTI           As Integer = &H00000002  ' multiple records to memory on each trigger event
Public Const     SPC_REC_STD_GATE            As Integer = &H00000004  ' gated recording to memory on gate signal
Public Const     SPC_REC_STD_ABA             As Integer = &H00000008  ' ABA: A slowly to extra FIFO, B to memory on each trigger event 
Public Const     SPC_REC_STD_SEGSTATS        As Integer = &H00010000  ' segment information stored on each trigger segment -> stored in on-board memory
Public Const     SPC_REC_STD_AVERAGE         As Integer = &H00020000  ' multiple records summed to average memory on each trigger event -> stored in on-board memory
Public Const     SPC_REC_STD_AVERAGE_16BIT   As Integer = &H00080000  ' multiple records summed to average memory on each trigger event -> stored in on-board memory
Public Const     SPC_REC_STD_BOXCAR          As Integer = &H00800000  ' boxcar averaging

Public Const     SPC_REC_FIFO_SINGLE         As Integer = &H00000010  ' singleshot to FIFO on trigger event
Public Const     SPC_REC_FIFO_MULTI          As Integer = &H00000020  ' multiple records to FIFO on each trigger event
Public Const     SPC_REC_FIFO_GATE           As Integer = &H00000040  ' gated sampling to FIFO on gate signal
Public Const     SPC_REC_FIFO_ABA            As Integer = &H00000080  ' ABA: A slowly to extra FIFO, B to FIFO on each trigger event
Public Const     SPC_REC_FIFO_SEGSTATS       As Integer = &H00100000  ' segment information stored on each trigger segment -> streamed to host
Public Const     SPC_REC_FIFO_AVERAGE        As Integer = &H00200000  ' multiple records summed to average memory on each trigger event -> streamed to host
Public Const     SPC_REC_FIFO_AVERAGE_16BIT  As Integer = &H00400000  ' multiple records summed to average memory on each trigger event -> streamed to host
Public Const     SPC_REC_FIFO_BOXCAR         As Integer = &H01000000  ' boxcar averaging FIFO mode
Public Const     SPC_REC_FIFO_SINGLE_MONITOR As Integer = &H02000000  ' like SPC_REC_FIFO_SINGLE but with additional slow A data stream for monitoring

Public Const     SPC_REP_STD_SINGLE          As Integer = &H00000100  ' single replay from memory on trigger event 
Public Const     SPC_REP_STD_MULTI           As Integer = &H00000200  ' multiple replay from memory on each trigger event
Public Const     SPC_REP_STD_GATE            As Integer = &H00000400  ' gated replay from memory on gate signal

Public Const     SPC_REP_FIFO_SINGLE         As Integer = &H00000800  ' single replay from FIFO on trigger event
Public Const     SPC_REP_FIFO_MULTI          As Integer = &H00001000  ' multiple replay from FIFO on each trigger event
Public Const     SPC_REP_FIFO_GATE           As Integer = &H00002000  ' gated replay from FIFO on gate signal

Public Const     SPC_REP_STD_CONTINUOUS      As Integer = &H00004000  ' continuous replay started by one trigger event
Public Const     SPC_REP_STD_SINGLERESTART   As Integer = &H00008000  ' single replays on every detected trigger event
Public Const     SPC_REP_STD_SEQUENCE        As Integer = &H00040000  ' sequence mode replay

' Waveforms for demo cards
Public Const SPC_DEMOWAVEFORM            As Integer = 9600
Public Const SPC_AVAILDEMOWAVEFORMS      As Integer = 9601
Public Const     SPCM_DEMOWAVEFORM_SINE      As Integer = &H00000001
Public Const     SPCM_DEMOWAVEFORM_RECT      As Integer = &H00000002
Public Const     SPCM_DEMOWAVEFORM_TRIANGLE  As Integer = &H00000004


' Memory
Public Const SPC_MEMSIZE                 As Integer = 10000
Public Const SPC_SEGMENTSIZE             As Integer = 10010
Public Const SPC_LOOPS                   As Integer = 10020
Public Const SPC_PRETRIGGER              As Integer = 10030
Public Const SPC_ABADIVIDER              As Integer = 10040
Public Const SPC_AVERAGES                As Integer = 10050
Public Const SPC_BOX_AVERAGES            As Integer = 10060
Public Const SPC_SEGSPLIT_START          As Integer = 10070
Public Const SPC_SEGSPLIT_PAUSE          As Integer = 10071
Public Const SPC_POSTTRIGGER             As Integer = 10100
Public Const SPC_STARTOFFSET             As Integer = 10200

' Memory info (depends on mode and channelenable)
Public Const SPC_AVAILMEMSIZE_MIN        As Integer = 10201
Public Const SPC_AVAILMEMSIZE_MAX        As Integer = 10202
Public Const SPC_AVAILMEMSIZE_STEP       As Integer = 10203
Public Const SPC_AVAILPOSTTRIGGER_MIN    As Integer = 10204
Public Const SPC_AVAILPOSTTRIGGER_MAX    As Integer = 10205
Public Const SPC_AVAILPOSTTRIGGER_STEP   As Integer = 10206

Public Const SPC_AVAILABADIVIDER_MIN     As Integer = 10207
Public Const SPC_AVAILABADIVIDER_MAX     As Integer = 10208
Public Const SPC_AVAILABADIVIDER_STEP    As Integer = 10209

Public Const SPC_AVAILLOOPS_MIN          As Integer = 10210
Public Const SPC_AVAILLOOPS_MAX          As Integer = 10211
Public Const SPC_AVAILLOOPS_STEP         As Integer = 10212

Public Const SPC_AVAILAVERAGES_MIN       As Integer = 10220
Public Const SPC_AVAILAVERAGES_MAX       As Integer = 10221
Public Const SPC_AVAILAVERAGES_STEP      As Integer = 10222

Public Const SPC_AVAILAVRGSEGSIZE_MIN    As Integer = 10223
Public Const SPC_AVAILAVRGSEGSIZE_MAX    As Integer = 10224
Public Const SPC_AVAILAVRGSEGSIZE_STEP   As Integer = 10225

Public Const SPC_AVAILAVERAGES16BIT_MIN     As Integer = 10226
Public Const SPC_AVAILAVERAGES16BIT_MAX     As Integer = 10227
Public Const SPC_AVAILAVERAGES16BIT_STEP    As Integer = 10228

Public Const SPC_AVAILAVRG16BITSEGSIZE_MIN  As Integer = 10229
Public Const SPC_AVAILAVRG16BITSEGSIZE_MAX  As Integer = 10230
Public Const SPC_AVAILAVRG16BITSEGSIZE_STEP As Integer = 10231

Public Const SPC_AVAILBOXCARAVERAGES_MIN         As Integer = 10232
Public Const SPC_AVAILBOXCARAVERAGES_MAX         As Integer = 10233
Public Const SPC_AVAILBOXCARAVERAGES_STEPFACTOR  As Integer = 10234


' Channels
Public Const SPC_CHENABLE                As Integer = 11000
Public Const SPC_CHCOUNT                 As Integer = 11001
Public Const SPC_CHMODACOUNT             As Integer = 11100
Public Const SPC_CHMODBCOUNT             As Integer = 11101


' ----- channel enable flags for A/D and D/A boards (MI/MC/MX series) -----
'       and all cards on M2i series
Public Const     CHANNEL0                As Integer = &H00000001
Public Const     CHANNEL1                As Integer = &H00000002
Public Const     CHANNEL2                As Integer = &H00000004
Public Const     CHANNEL3                As Integer = &H00000008
Public Const     CHANNEL4                As Integer = &H00000010
Public Const     CHANNEL5                As Integer = &H00000020
Public Const     CHANNEL6                As Integer = &H00000040
Public Const     CHANNEL7                As Integer = &H00000080
Public Const     CHANNEL8                As Integer = &H00000100
Public Const     CHANNEL9                As Integer = &H00000200
Public Const     CHANNEL10               As Integer = &H00000400
Public Const     CHANNEL11               As Integer = &H00000800
Public Const     CHANNEL12               As Integer = &H00001000
Public Const     CHANNEL13               As Integer = &H00002000
Public Const     CHANNEL14               As Integer = &H00004000
Public Const     CHANNEL15               As Integer = &H00008000
Public Const     CHANNEL16               As Integer = &H00010000
Public Const     CHANNEL17               As Integer = &H00020000
Public Const     CHANNEL18               As Integer = &H00040000
Public Const     CHANNEL19               As Integer = &H00080000
Public Const     CHANNEL20               As Integer = &H00100000
Public Const     CHANNEL21               As Integer = &H00200000
Public Const     CHANNEL22               As Integer = &H00400000
Public Const     CHANNEL23               As Integer = &H00800000
Public Const     CHANNEL24               As Integer = &H01000000
Public Const     CHANNEL25               As Integer = &H02000000
Public Const     CHANNEL26               As Integer = &H04000000
Public Const     CHANNEL27               As Integer = &H08000000
Public Const     CHANNEL28               As Integer = &H10000000
Public Const     CHANNEL29               As Integer = &H20000000
Public Const     CHANNEL30               As Integer = &H40000000
Public Const     CHANNEL31               As Integer = &H80000000
' CHANNEL32 up to CHANNEL63 are placed in the upper 32 bit of a 64 bit word (M2i only)


' ----- old digital i/o settings for 16 bit implementation (MI/MC/MX series)  -----
Public Const     CH0_8BITMODE            As Integer = 65536  ' for MI.70xx only
Public Const     CH0_16BIT               As Integer = 1
Public Const     CH0_32BIT               As Integer = 3
Public Const     CH1_16BIT               As Integer = 4
Public Const     CH1_32BIT               As Integer = 12

' ----- new digital i/o settings for 8 bit implementation (MI/MC/MX series) -----
Public Const     MOD0_8BIT               As Integer = 1
Public Const     MOD0_16BIT              As Integer = 3
Public Const     MOD0_32BIT              As Integer = 15
Public Const     MOD1_8BIT               As Integer = 16
Public Const     MOD1_16BIT              As Integer = 48
Public Const     MOD1_32BIT              As Integer = 240

Public Const SPC_CHROUTE0                As Integer = 11010
Public Const SPC_CHROUTE1                As Integer = 11020

Public Const SPC_BITENABLE               As Integer = 11030



' ----- Clock Settings -----
Public Const SPC_SAMPLERATE              As Integer = 20000
Public Const SPC_SYNCCLOCK               As Integer = 20005
Public Const SPC_SAMPLERATE2             As Integer = 20010
Public Const SPC_SR2                     As Integer = 20020
Public Const SPC_PLL_ENABLE              As Integer = 20030
Public Const SPC_PLL_ISLOCKED            As Integer = 20031
Public Const SPC_CLOCKDIV                As Integer = 20040
Public Const SPC_INTCLOCKDIV             As Integer = 20041
Public Const SPC_PXICLOCKDIV             As Integer = 20042
Public Const SPC_PLL_R                   As Integer = 20060
Public Const SPC_PLL_F                   As Integer = 20061
Public Const SPC_PLL_S                   As Integer = 20062
Public Const SPC_PLL_DIV                 As Integer = 20063
Public Const SPC_PXI_CLK_OUT             As Integer = 20090
Public Const SPC_EXTERNALCLOCK           As Integer = 20100
Public Const SPC_EXTERNOUT               As Integer = 20110
Public Const SPC_CLOCKOUT                As Integer = 20110
Public Const SPC_CLOCKOUTFREQUENCY       As Integer = 20111
Public Const SPC_CLOCK50OHM              As Integer = 20120
Public Const SPC_CLOCK110OHM             As Integer = 20120
Public Const SPC_CLOCK75OHM              As Integer = 20120
Public Const SPC_STROBE75OHM             As Integer = 20121
Public Const SPC_EXTERNRANGE             As Integer = 20130
Public Const SPC_EXTRANGESHDIRECT        As Integer = 20131
Public Const     EXRANGE_NONE            As Integer = 0
Public Const     EXRANGE_NOPLL           As Integer = 1
Public Const     EXRANGE_SINGLE          As Integer = 2
Public Const     EXRANGE_BURST_S         As Integer = 4
Public Const     EXRANGE_BURST_M         As Integer = 8
Public Const     EXRANGE_BURST_L         As Integer = 16
Public Const     EXRANGE_BURST_XL        As Integer = 32
Public Const     EXRANGE_LOW             As Integer = 64
Public Const     EXRANGE_HIGH            As Integer = 128
Public Const     EXRANGE_LOW_DPS         As Integer = 256            ' digital phase synchronization
Public Const SPC_REFERENCECLOCK          As Integer = 20140
Public Const     REFCLOCK_PXI            As Integer = -1

' ----- new clock registers starting with M2i cards -----
Public Const SPC_CLOCKMODE               As Integer = 20200      ' clock mode as listed below
Public Const SPC_AVAILCLOCKMODES         As Integer = 20201      ' returns all available clock modes
Public Const     SPC_CM_INTPLL           As Integer = &H00000001      ' use internal PLL
Public Const     SPC_CM_QUARTZ1          As Integer = &H00000002      ' use plain quartz1 (with divider)
Public Const     SPC_CM_QUARTZ2          As Integer = &H00000004      ' use plain quartz2 (with divider)
Public Const     SPC_CM_EXTERNAL         As Integer = &H00000008      ' use external clock directly
Public Const     SPC_CM_EXTERNAL0        As Integer = &H00000008      ' use external clock0 directly (identical value to SPC_CM_EXTERNAL)
Public Const     SPC_CM_EXTDIVIDER       As Integer = &H00000010      ' use external clock with programmed divider
Public Const     SPC_CM_EXTREFCLOCK      As Integer = &H00000020      ' external reference clock fed in (defined with SPC_REFERENCECLOCK)
Public Const     SPC_CM_PXIREFCLOCK      As Integer = &H00000040      ' PXI reference clock
Public Const     SPC_CM_SHDIRECT         As Integer = &H00000080      ' Star-hub direct clock (not synchronised)
Public Const     SPC_CM_QUARTZ2_DIRSYNC  As Integer = &H00000100      ' use plain quartz2 (with divider) and put the Q2 clock on the star-hub module
Public Const     SPC_CM_QUARTZ1_DIRSYNC  As Integer = &H00000200      ' use plain quartz1 (with divider) and put the Q1 clock on the star-hub module
Public Const     SPC_CM_EXTERNAL1        As Integer = &H00000400      ' use external clock1 directly
' ----- internal use only! -----
Public Const     SPC_CM_SYNCINT          As Integer = &H01000000
Public Const     SPC_CM_SYNCEXT          As Integer = &H02000000

Public Const SPC_CLOCK_READFEATURES      As Integer = 20205
Public Const SPC_CLOCK_READFEATURES0     As Integer = 20205
Public Const SPC_CLOCK_READFEATURES1     As Integer = 20206
Public Const     SPCM_CKFEAT_TERM            As Integer = &H00000001
Public Const     SPCM_CKFEAT_HIGHIMP         As Integer = &H00000002
Public Const     SPCM_CKFEAT_DCCOUPLING      As Integer = &H00000004
Public Const     SPCM_CKFEAT_ACCOUPLING      As Integer = &H00000008
Public Const     SPCM_CKFEAT_SE              As Integer = &H00000010
Public Const     SPCM_CKFEAT_DIFF            As Integer = &H00000020
Public Const     SPCM_CKFEAT_PROGEDGE        As Integer = &H00000040
Public Const     SPCM_CKFEAT_LEVELPROG       As Integer = &H00000100
Public Const     SPCM_CKFEAT_PROGTHRESHOLD   As Integer = &H00000200
Public Const     SPCM_CKFEAT_PROGDELAY       As Integer = &H00000400

Public Const SPC_BURSTSYSCLOCKMODE       As Integer = 20210
Public Const SPC_SYNCMASTERSYSCLOCKMODE  As Integer = 20211
Public Const SPC_CLOCK_SETUP_CHANGED     As Integer = 20212

' clock delay if available
Public Const SPC_CLOCK_AVAILDELAY_MIN    As Integer = 20220
Public Const SPC_CLOCK_AVAILDELAY_MAX    As Integer = 20221
Public Const SPC_CLOCK_AVAILDELAY_STEP   As Integer = 20222
Public Const SPC_CLOCK_DELAY             As Integer = 20223

' clock edges
Public Const SPC_AVAILCLOCKEDGES         As Integer = 20224
Public Const     SPCM_EDGE_FALLING       As Integer = &H00000001 ' Originally SPCM_RISING_EDGE  : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details.
Public Const     SPCM_EDGE_RISING        As Integer = &H00000002 ' Originally SPCM_FALLING_EDGE : name and value of constant intentionally changed with driver versions greater than V5.24. See hardware manual for details.
Public Const     SPCM_BOTH_EDGES         As Integer = &H00000004
Public Const     SPCM_EDGES_BOTH         As Integer = &H00000004 'Just added for good measure to match naming scheme of above SPCM_EDGE_FALLING and SPCM_EDGE_RISING constants.
Public Const SPC_CLOCK_EDGE              As Integer = 20225

' mux definitions for channel routing
Public Const SPC_CHANNELMUXINFO          As Integer = 20300
Public Const     SPCM_MUX_NONE            As Integer = &H00000000  ' nothing is interlaced
Public Const     SPCM_MUX_MUXONMOD        As Integer = &H00000001  ' data on module is multiplexed, only one channel can have full speed
Public Const     SPCM_MUX_INVERTCLKONMOD  As Integer = &H00000002  ' two channels on one module run with inverted clock
Public Const     SPCM_MUX_DLY             As Integer = &H00000003  ' delay cable between modules, one channel can have full interlace speed
Public Const     SPCM_MUX_DLYANDMUXONMOD  As Integer = &H00000004  ' delay cable between modules and multplexing on module
Public Const     SPCM_MUX_MUXBETWEENMODS  As Integer = &H00000005  ' multiplexed between modules (fastest sampling rate only with one module)
Public Const     SPCM_MUX_MUXONMOD2CH     As Integer = &H00000006  ' data on module is multiplexed, only two channel can have full speed
Public Const     SPCM_MUX_MAX4CH          As Integer = &H00000007  ' only four channels can have full speed, independent of distribution on modules


' ----- In/Out Range -----
Public Const SPC_OFFS0                   As Integer = 30000
Public Const SPC_AMP0                    As Integer = 30010
Public Const SPC_ACDC0                   As Integer = 30020
Public Const SPC_ACDC_OFFS_COMPENSATION0 As Integer = 30021
Public Const SPC_50OHM0                  As Integer = 30030
Public Const SPC_DIFF0                   As Integer = 30040
Public Const SPC_DOUBLEOUT0              As Integer = 30041
Public Const SPC_DIGITAL0                As Integer = 30050
Public Const SPC_110OHM0                 As Integer = 30060
Public Const SPC_110OHM0L                As Integer = 30060
Public Const SPC_75OHM0                  As Integer = 30060
Public Const SPC_INOUT0                  As Integer = 30070
Public Const SPC_FILTER0                 As Integer = 30080
Public Const SPC_BANKSWITCH0             As Integer = 30081
Public Const SPC_PATH0                   As Integer = 30090
Public Const SPC_ENABLEOUT0              As Integer = 30091

Public Const SPC_OFFS1                   As Integer = 30100
Public Const SPC_AMP1                    As Integer = 30110
Public Const SPC_ACDC1                   As Integer = 30120
Public Const SPC_ACDC_OFFS_COMPENSATION1 As Integer = 30121
Public Const SPC_50OHM1                  As Integer = 30130
Public Const SPC_DIFF1                   As Integer = 30140
Public Const SPC_DOUBLEOUT1              As Integer = 30141
Public Const SPC_DIGITAL1                As Integer = 30150
Public Const SPC_110OHM1                 As Integer = 30160
Public Const SPC_110OHM0H                As Integer = 30160
Public Const SPC_75OHM1                  As Integer = 30160
Public Const SPC_INOUT1                  As Integer = 30170
Public Const SPC_FILTER1                 As Integer = 30180
Public Const SPC_BANKSWITCH1             As Integer = 30181
Public Const SPC_PATH1                   As Integer = 30190
Public Const SPC_ENABLEOUT1              As Integer = 30191

Public Const SPC_OFFS2                   As Integer = 30200
Public Const SPC_AMP2                    As Integer = 30210
Public Const SPC_ACDC2                   As Integer = 30220
Public Const SPC_ACDC_OFFS_COMPENSATION2 As Integer = 30221
Public Const SPC_50OHM2                  As Integer = 30230
Public Const SPC_DIFF2                   As Integer = 30240
Public Const SPC_DOUBLEOUT2              As Integer = 30241
Public Const SPC_110OHM2                 As Integer = 30260
Public Const SPC_110OHM1L                As Integer = 30260
Public Const SPC_75OHM2                  As Integer = 30260
Public Const SPC_INOUT2                  As Integer = 30270
Public Const SPC_FILTER2                 As Integer = 30280
Public Const SPC_BANKSWITCH2             As Integer = 30281
Public Const SPC_PATH2                   As Integer = 30290
Public Const SPC_ENABLEOUT2              As Integer = 30291

Public Const SPC_OFFS3                   As Integer = 30300
Public Const SPC_AMP3                    As Integer = 30310
Public Const SPC_ACDC3                   As Integer = 30320
Public Const SPC_ACDC_OFFS_COMPENSATION3 As Integer = 30321
Public Const SPC_50OHM3                  As Integer = 30330
Public Const SPC_DIFF3                   As Integer = 30340
Public Const SPC_DOUBLEOUT3              As Integer = 30341
Public Const SPC_110OHM3                 As Integer = 30360
Public Const SPC_110OHM1H                As Integer = 30360
Public Const SPC_75OHM3                  As Integer = 30360
Public Const SPC_INOUT3                  As Integer = 30370
Public Const SPC_FILTER3                 As Integer = 30380
Public Const SPC_BANKSWITCH3             As Integer = 30381
Public Const SPC_PATH3                   As Integer = 30390
Public Const SPC_ENABLEOUT3              As Integer = 30391

Public Const SPC_OFFS4                   As Integer = 30400
Public Const SPC_AMP4                    As Integer = 30410
Public Const SPC_ACDC4                   As Integer = 30420
Public Const SPC_50OHM4                  As Integer = 30430
Public Const SPC_DIFF4                   As Integer = 30440
Public Const SPC_DOUBLEOUT4              As Integer = 30441
Public Const SPC_FILTER4                 As Integer = 30480
Public Const SPC_ENABLEOUT4              As Integer = 30491
Public Const SPC_PATH4                   As Integer = 30490

Public Const SPC_OFFS5                   As Integer = 30500
Public Const SPC_AMP5                    As Integer = 30510
Public Const SPC_ACDC5                   As Integer = 30520
Public Const SPC_50OHM5                  As Integer = 30530
Public Const SPC_DIFF5                   As Integer = 30540
Public Const SPC_DOUBLEOUT5              As Integer = 30541
Public Const SPC_FILTER5                 As Integer = 30580
Public Const SPC_ENABLEOUT5              As Integer = 30591
Public Const SPC_PATH5                   As Integer = 30590

Public Const SPC_OFFS6                   As Integer = 30600
Public Const SPC_AMP6                    As Integer = 30610
Public Const SPC_ACDC6                   As Integer = 30620
Public Const SPC_50OHM6                  As Integer = 30630
Public Const SPC_DIFF6                   As Integer = 30640
Public Const SPC_DOUBLEOUT6              As Integer = 30641
Public Const SPC_FILTER6                 As Integer = 30680
Public Const SPC_ENABLEOUT6              As Integer = 30691
Public Const SPC_PATH6                   As Integer = 30690

Public Const SPC_OFFS7                   As Integer = 30700
Public Const SPC_AMP7                    As Integer = 30710
Public Const SPC_ACDC7                   As Integer = 30720
Public Const SPC_50OHM7                  As Integer = 30730
Public Const SPC_DIFF7                   As Integer = 30740
Public Const SPC_DOUBLEOUT7              As Integer = 30741
Public Const SPC_FILTER7                 As Integer = 30780
Public Const SPC_ENABLEOUT7              As Integer = 30791
Public Const SPC_PATH7                   As Integer = 30790

Public Const SPC_OFFS8                   As Integer = 30800
Public Const SPC_AMP8                    As Integer = 30810
Public Const SPC_ACDC8                   As Integer = 30820
Public Const SPC_50OHM8                  As Integer = 30830
Public Const SPC_DIFF8                   As Integer = 30840
Public Const SPC_PATH8                   As Integer = 30890

Public Const SPC_OFFS9                   As Integer = 30900
Public Const SPC_AMP9                    As Integer = 30910
Public Const SPC_ACDC9                   As Integer = 30920
Public Const SPC_50OHM9                  As Integer = 30930
Public Const SPC_DIFF9                   As Integer = 30940
Public Const SPC_PATH9                   As Integer = 30990

Public Const SPC_OFFS10                  As Integer = 31000
Public Const SPC_AMP10                   As Integer = 31010
Public Const SPC_ACDC10                  As Integer = 31020
Public Const SPC_50OHM10                 As Integer = 31030
Public Const SPC_DIFF10                  As Integer = 31040
Public Const SPC_PATH10                  As Integer = 31090

Public Const SPC_OFFS11                  As Integer = 31100
Public Const SPC_AMP11                   As Integer = 31110
Public Const SPC_ACDC11                  As Integer = 31120
Public Const SPC_50OHM11                 As Integer = 31130
Public Const SPC_DIFF11                  As Integer = 31140
Public Const SPC_PATH11                  As Integer = 31190

Public Const SPC_OFFS12                  As Integer = 31200
Public Const SPC_AMP12                   As Integer = 31210
Public Const SPC_ACDC12                  As Integer = 31220
Public Const SPC_50OHM12                 As Integer = 31230
Public Const SPC_DIFF12                  As Integer = 31240
Public Const SPC_PATH12                  As Integer = 31290

Public Const SPC_OFFS13                  As Integer = 31300
Public Const SPC_AMP13                   As Integer = 31310
Public Const SPC_ACDC13                  As Integer = 31320
Public Const SPC_50OHM13                 As Integer = 31330
Public Const SPC_DIFF13                  As Integer = 31340
Public Const SPC_PATH13                  As Integer = 31390

Public Const SPC_OFFS14                  As Integer = 31400
Public Const SPC_AMP14                   As Integer = 31410
Public Const SPC_ACDC14                  As Integer = 31420
Public Const SPC_50OHM14                 As Integer = 31430
Public Const SPC_DIFF14                  As Integer = 31440
Public Const SPC_PATH14                  As Integer = 31490

Public Const SPC_OFFS15                  As Integer = 31500
Public Const SPC_AMP15                   As Integer = 31510
Public Const SPC_ACDC15                  As Integer = 31520
Public Const SPC_50OHM15                 As Integer = 31530
Public Const SPC_DIFF15                  As Integer = 31540
Public Const SPC_PATH15                  As Integer = 31590

Public Const SPC_110OHMTRIGGER           As Integer = 30400
Public Const SPC_110OHMCLOCK             As Integer = 30410


Public Const   AMP_BI200                 As Integer = 200
Public Const   AMP_BI500                 As Integer = 500
Public Const   AMP_BI1000                As Integer = 1000
Public Const   AMP_BI2000                As Integer = 2000
Public Const   AMP_BI2500                As Integer = 2500
Public Const   AMP_BI4000                As Integer = 4000
Public Const   AMP_BI5000                As Integer = 5000
Public Const   AMP_BI10000               As Integer = 10000
Public Const   AMP_UNI400                As Integer = 100400
Public Const   AMP_UNI1000               As Integer = 101000
Public Const   AMP_UNI2000               As Integer = 102000


' ----- Trigger Settings -----
Public Const SPC_TRIGGERMODE             As Integer = 40000
Public Const SPC_TRIG_OUTPUT             As Integer = 40100
Public Const SPC_TRIGGEROUT              As Integer = 40100
Public Const SPC_TRIG_TERM               As Integer = 40110
Public Const SPC_TRIG_TERM0              As Integer = 40110
Public Const SPC_TRIGGER50OHM            As Integer = 40110
Public Const SPC_TRIGGER110OHM0          As Integer = 40110
Public Const SPC_TRIGGER75OHM0           As Integer = 40110
Public Const SPC_TRIG_TERM1              As Integer = 40111
Public Const SPC_TRIGGER110OHM1          As Integer = 40111
Public Const SPC_TRIG_EXT0_ACDC          As Integer = 40120
Public Const SPC_TRIG_EXT1_ACDC          As Integer = 40121
Public Const SPC_TRIG_EXT2_ACDC          As Integer = 40122

Public Const SPC_TRIGGERMODE0            As Integer = 40200
Public Const SPC_TRIGGERMODE1            As Integer = 40201
Public Const SPC_TRIGGERMODE2            As Integer = 40202
Public Const SPC_TRIGGERMODE3            As Integer = 40203
Public Const SPC_TRIGGERMODE4            As Integer = 40204
Public Const SPC_TRIGGERMODE5            As Integer = 40205
Public Const SPC_TRIGGERMODE6            As Integer = 40206
Public Const SPC_TRIGGERMODE7            As Integer = 40207
Public Const SPC_TRIGGERMODE8            As Integer = 40208
Public Const SPC_TRIGGERMODE9            As Integer = 40209
Public Const SPC_TRIGGERMODE10           As Integer = 40210
Public Const SPC_TRIGGERMODE11           As Integer = 40211
Public Const SPC_TRIGGERMODE12           As Integer = 40212
Public Const SPC_TRIGGERMODE13           As Integer = 40213
Public Const SPC_TRIGGERMODE14           As Integer = 40214
Public Const SPC_TRIGGERMODE15           As Integer = 40215

Public Const     TM_SOFTWARE             As Integer = 0
Public Const     TM_NOTRIGGER            As Integer = 10
Public Const     TM_CHXPOS               As Integer = 10000
Public Const     TM_CHXPOS_LP            As Integer = 10001
Public Const     TM_CHXPOS_SP            As Integer = 10002
Public Const     TM_CHXPOS_GS            As Integer = 10003
Public Const     TM_CHXPOS_SS            As Integer = 10004
Public Const     TM_CHXNEG               As Integer = 10010
Public Const     TM_CHXNEG_LP            As Integer = 10011
Public Const     TM_CHXNEG_SP            As Integer = 10012
Public Const     TM_CHXNEG_GS            As Integer = 10013
Public Const     TM_CHXNEG_SS            As Integer = 10014
Public Const     TM_CHXOFF               As Integer = 10020
Public Const     TM_CHXBOTH              As Integer = 10030
Public Const     TM_CHXWINENTER          As Integer = 10040
Public Const     TM_CHXWINENTER_LP       As Integer = 10041
Public Const     TM_CHXWINENTER_SP       As Integer = 10042
Public Const     TM_CHXWINLEAVE          As Integer = 10050
Public Const     TM_CHXWINLEAVE_LP       As Integer = 10051
Public Const     TM_CHXWINLEAVE_SP       As Integer = 10052
Public Const     TM_CHXLOW               As Integer = 10060
Public Const     TM_CHXHIGH              As Integer = 10061
Public Const     TM_CHXINWIN             As Integer = 10062
Public Const     TM_CHXOUTWIN            As Integer = 10063
Public Const     TM_CHXSPIKE             As Integer = 10064


Public Const     TM_CH0POS               As Integer = 10000
Public Const     TM_CH0NEG               As Integer = 10010
Public Const     TM_CH0OFF               As Integer = 10020
Public Const     TM_CH0BOTH              As Integer = 10030
Public Const     TM_CH1POS               As Integer = 10100
Public Const     TM_CH1NEG               As Integer = 10110
Public Const     TM_CH1OFF               As Integer = 10120
Public Const     TM_CH1BOTH              As Integer = 10130
Public Const     TM_CH2POS               As Integer = 10200
Public Const     TM_CH2NEG               As Integer = 10210
Public Const     TM_CH2OFF               As Integer = 10220
Public Const     TM_CH2BOTH              As Integer = 10230
Public Const     TM_CH3POS               As Integer = 10300
Public Const     TM_CH3NEG               As Integer = 10310
Public Const     TM_CH3OFF               As Integer = 10320
Public Const     TM_CH3BOTH              As Integer = 10330

Public Const     TM_TTLPOS               As Integer = 20000
Public Const     TM_TTLHIGH_LP           As Integer = 20001
Public Const     TM_TTLHIGH_SP           As Integer = 20002
Public Const     TM_TTLNEG               As Integer = 20010
Public Const     TM_TTLLOW_LP            As Integer = 20011
Public Const     TM_TTLLOW_SP            As Integer = 20012
Public Const     TM_TTL                  As Integer = 20020
Public Const     TM_TTLBOTH              As Integer = 20030
Public Const     TM_TTLBOTH_LP           As Integer = 20031
Public Const     TM_TTLBOTH_SP           As Integer = 20032
Public Const     TM_CHANNEL              As Integer = 20040
Public Const     TM_TTLHIGH              As Integer = 20050
Public Const     TM_TTLLOW               As Integer = 20051
Public Const     TM_PATTERN              As Integer = 21000
Public Const     TM_PATTERN_LP           As Integer = 21001
Public Const     TM_PATTERN_SP           As Integer = 21002
Public Const     TM_PATTERNANDEDGE       As Integer = 22000
Public Const     TM_PATTERNANDEDGE_LP    As Integer = 22001
Public Const     TM_PATTERNANDEDGE_SP    As Integer = 22002
Public Const     TM_GATELOW              As Integer = 30000
Public Const     TM_GATEHIGH             As Integer = 30010
Public Const     TM_GATEPATTERN          As Integer = 30020
Public Const     TM_CHOR                 As Integer = 35000
Public Const     TM_CHAND                As Integer = 35010
Public Const     TM_CHORTTLPOS           As Integer = 35020
Public Const     TM_CHORTTLNEG           As Integer = 35021

Public Const SPC_PXITRGOUT               As Integer = 40300
Public Const     PTO_OFF                  As Integer = 0
Public Const     PTO_LINE0                As Integer = 1
Public Const     PTO_LINE1                As Integer = 2
Public Const     PTO_LINE2                As Integer = 3
Public Const     PTO_LINE3                As Integer = 4
Public Const     PTO_LINE4                As Integer = 5
Public Const     PTO_LINE5                As Integer = 6
Public Const     PTO_LINE6                As Integer = 7
Public Const     PTO_LINE7                As Integer = 8
Public Const     PTO_LINESTAR             As Integer = 9
Public Const SPC_PXITRGOUT_AVAILABLE     As Integer = 40301  ' bitmap register

Public Const SPC_PXISTARTRG_DIVRST_OUT   As Integer = 40302  ' bitmap register
Public Const SPC_PXISTARTRG_DIVRST_OUT_AVAILABLE   As Integer = 40303
Public Const SPC_PXISTARTRG_OUT          As Integer = 40304  ' bitmap register
Public Const     PSTO_LINESTAR0           As Integer = &H00000001
Public Const     PSTO_LINESTAR1           As Integer = &H00000002
Public Const     PSTO_LINESTAR2           As Integer = &H00000004
Public Const     PSTO_LINESTAR3           As Integer = &H00000008
Public Const     PSTO_LINESTAR4           As Integer = &H00000010
Public Const     PSTO_LINESTAR5           As Integer = &H00000020
Public Const     PSTO_LINESTAR6           As Integer = &H00000040
Public Const     PSTO_LINESTAR7           As Integer = &H00000080
Public Const     PSTO_LINESTAR8           As Integer = &H00000100
Public Const     PSTO_LINESTAR9           As Integer = &H00000200
Public Const     PSTO_LINESTAR10          As Integer = &H00000400
Public Const     PSTO_LINESTAR11          As Integer = &H00000800
Public Const     PSTO_LINESTAR12          As Integer = &H00001000
Public Const     PSTO_LINE0               As Integer = &H00010000
Public Const     PSTO_LINE1               As Integer = &H00020000
Public Const     PSTO_LINE2               As Integer = &H00040000
Public Const     PSTO_LINE3               As Integer = &H00080000
Public Const     PSTO_LINE4               As Integer = &H00100000
Public Const     PSTO_LINE5               As Integer = &H00200000
Public Const     PSTO_LINE6               As Integer = &H00400000
Public Const     PSTO_LINE7               As Integer = &H00800000
Public Const SPC_PXISTARTRG_OUT_AVAILABLE          As Integer = 40305

Public Const SPC_PXITRGIN                As Integer = 40310  ' bitmap register
Public Const     PTI_OFF                  As Integer = 0
Public Const     PTI_LINE0                As Integer = 1
Public Const     PTI_LINE1                As Integer = 2
Public Const     PTI_LINE2                As Integer = 4
Public Const     PTI_LINE3                As Integer = 8
Public Const     PTI_LINE4                As Integer = 16
Public Const     PTI_LINE5                As Integer = 32
Public Const     PTI_LINE6                As Integer = 64
Public Const     PTI_LINE7                As Integer = 128
Public Const     PTI_LINESTAR             As Integer = 256
Public Const SPC_PXITRGIN_AVAILABLE      As Integer = 40311  ' bitmap register
Public Const SPC_PXI_DIVIDER_RESET_IN            As Integer = 40320
Public Const SPC_PXI_DIVIDER_RESET_IN_AVAILABLE  As Integer = 40321


' new registers of M2i driver
Public Const SPC_TRIG_AVAILORMASK        As Integer = 40400
Public Const SPC_TRIG_ORMASK             As Integer = 40410
Public Const SPC_TRIG_AVAILANDMASK       As Integer = 40420
Public Const SPC_TRIG_ANDMASK            As Integer = 40430
Public Const     SPC_TMASK_NONE          As Integer = &H00000000
Public Const     SPC_TMASK_SOFTWARE      As Integer = &H00000001
Public Const     SPC_TMASK_EXT0          As Integer = &H00000002
Public Const     SPC_TMASK_EXT1          As Integer = &H00000004
Public Const     SPC_TMASK_EXT2          As Integer = &H00000008
Public Const     SPC_TMASK_EXT3          As Integer = &H00000010
Public Const     SPC_TMASK_XIO0          As Integer = &H00000100
Public Const     SPC_TMASK_XIO1          As Integer = &H00000200
Public Const     SPC_TMASK_XIO2          As Integer = &H00000400
Public Const     SPC_TMASK_XIO3          As Integer = &H00000800
Public Const     SPC_TMASK_XIO4          As Integer = &H00001000
Public Const     SPC_TMASK_XIO5          As Integer = &H00002000
Public Const     SPC_TMASK_XIO6          As Integer = &H00004000
Public Const     SPC_TMASK_XIO7          As Integer = &H00008000
Public Const     SPC_TMASK_PXI0          As Integer = &H00100000
Public Const     SPC_TMASK_PXI1          As Integer = &H00200000
Public Const     SPC_TMASK_PXI2          As Integer = &H00400000
Public Const     SPC_TMASK_PXI3          As Integer = &H00800000
Public Const     SPC_TMASK_PXI4          As Integer = &H01000000
Public Const     SPC_TMASK_PXI5          As Integer = &H02000000
Public Const     SPC_TMASK_PXI6          As Integer = &H04000000
Public Const     SPC_TMASK_PXI7          As Integer = &H08000000
Public Const     SPC_TMASK_PXISTAR       As Integer = &H10000000
Public Const     SPC_TMASK_PXIDSTARB     As Integer = &H20000000

Public Const SPC_TRIG_CH_AVAILORMASK0    As Integer = 40450
Public Const SPC_TRIG_CH_AVAILORMASK1    As Integer = 40451
Public Const SPC_TRIG_CH_ORMASK0         As Integer = 40460
Public Const SPC_TRIG_CH_ORMASK1         As Integer = 40461
Public Const SPC_TRIG_CH_AVAILANDMASK0   As Integer = 40470
Public Const SPC_TRIG_CH_AVAILANDMASK1   As Integer = 40471
Public Const SPC_TRIG_CH_ANDMASK0        As Integer = 40480 
Public Const SPC_TRIG_CH_ANDMASK1        As Integer = 40481 
Public Const     SPC_TMASK0_NONE         As Integer = &H00000000
Public Const     SPC_TMASK0_CH0          As Integer = &H00000001
Public Const     SPC_TMASK0_CH1          As Integer = &H00000002
Public Const     SPC_TMASK0_CH2          As Integer = &H00000004
Public Const     SPC_TMASK0_CH3          As Integer = &H00000008
Public Const     SPC_TMASK0_CH4          As Integer = &H00000010
Public Const     SPC_TMASK0_CH5          As Integer = &H00000020
Public Const     SPC_TMASK0_CH6          As Integer = &H00000040
Public Const     SPC_TMASK0_CH7          As Integer = &H00000080
Public Const     SPC_TMASK0_CH8          As Integer = &H00000100
Public Const     SPC_TMASK0_CH9          As Integer = &H00000200
Public Const     SPC_TMASK0_CH10         As Integer = &H00000400
Public Const     SPC_TMASK0_CH11         As Integer = &H00000800
Public Const     SPC_TMASK0_CH12         As Integer = &H00001000
Public Const     SPC_TMASK0_CH13         As Integer = &H00002000
Public Const     SPC_TMASK0_CH14         As Integer = &H00004000
Public Const     SPC_TMASK0_CH15         As Integer = &H00008000
Public Const     SPC_TMASK0_CH16         As Integer = &H00010000
Public Const     SPC_TMASK0_CH17         As Integer = &H00020000
Public Const     SPC_TMASK0_CH18         As Integer = &H00040000
Public Const     SPC_TMASK0_CH19         As Integer = &H00080000
Public Const     SPC_TMASK0_CH20         As Integer = &H00100000
Public Const     SPC_TMASK0_CH21         As Integer = &H00200000
Public Const     SPC_TMASK0_CH22         As Integer = &H00400000
Public Const     SPC_TMASK0_CH23         As Integer = &H00800000
Public Const     SPC_TMASK0_CH24         As Integer = &H01000000
Public Const     SPC_TMASK0_CH25         As Integer = &H02000000
Public Const     SPC_TMASK0_CH26         As Integer = &H04000000
Public Const     SPC_TMASK0_CH27         As Integer = &H08000000
Public Const     SPC_TMASK0_CH28         As Integer = &H10000000
Public Const     SPC_TMASK0_CH29         As Integer = &H20000000
Public Const     SPC_TMASK0_CH30         As Integer = &H40000000
Public Const     SPC_TMASK0_CH31         As Integer = &H80000000

Public Const     SPC_TMASK1_NONE         As Integer = &H00000000
Public Const     SPC_TMASK1_CH32         As Integer = &H00000001
Public Const     SPC_TMASK1_CH33         As Integer = &H00000002
Public Const     SPC_TMASK1_CH34         As Integer = &H00000004
Public Const     SPC_TMASK1_CH35         As Integer = &H00000008
Public Const     SPC_TMASK1_CH36         As Integer = &H00000010
Public Const     SPC_TMASK1_CH37         As Integer = &H00000020
Public Const     SPC_TMASK1_CH38         As Integer = &H00000040
Public Const     SPC_TMASK1_CH39         As Integer = &H00000080
Public Const     SPC_TMASK1_CH40         As Integer = &H00000100
Public Const     SPC_TMASK1_CH41         As Integer = &H00000200
Public Const     SPC_TMASK1_CH42         As Integer = &H00000400
Public Const     SPC_TMASK1_CH43         As Integer = &H00000800
Public Const     SPC_TMASK1_CH44         As Integer = &H00001000
Public Const     SPC_TMASK1_CH45         As Integer = &H00002000
Public Const     SPC_TMASK1_CH46         As Integer = &H00004000
Public Const     SPC_TMASK1_CH47         As Integer = &H00008000
Public Const     SPC_TMASK1_CH48         As Integer = &H00010000
Public Const     SPC_TMASK1_CH49         As Integer = &H00020000
Public Const     SPC_TMASK1_CH50         As Integer = &H00040000
Public Const     SPC_TMASK1_CH51         As Integer = &H00080000
Public Const     SPC_TMASK1_CH52         As Integer = &H00100000
Public Const     SPC_TMASK1_CH53         As Integer = &H00200000
Public Const     SPC_TMASK1_CH54         As Integer = &H00400000
Public Const     SPC_TMASK1_CH55         As Integer = &H00800000
Public Const     SPC_TMASK1_CH56         As Integer = &H01000000
Public Const     SPC_TMASK1_CH57         As Integer = &H02000000
Public Const     SPC_TMASK1_CH58         As Integer = &H04000000
Public Const     SPC_TMASK1_CH59         As Integer = &H08000000
Public Const     SPC_TMASK1_CH60         As Integer = &H10000000
Public Const     SPC_TMASK1_CH61         As Integer = &H20000000
Public Const     SPC_TMASK1_CH62         As Integer = &H40000000
Public Const     SPC_TMASK1_CH63         As Integer = &H80000000

Public Const SPC_TRIG_EXT_AVAILMODES     As Integer = 40500
Public Const SPC_TRIG_EXT0_AVAILMODES    As Integer = 40500
Public Const SPC_TRIG_EXT1_AVAILMODES    As Integer = 40501
Public Const SPC_TRIG_EXT2_AVAILMODES    As Integer = 40502
Public Const SPC_TRIG_EXT0_AVAILMODESOR  As Integer = 40503
Public Const SPC_TRIG_EXT1_AVAILMODESOR  As Integer = 40504
Public Const SPC_TRIG_EXT2_AVAILMODESOR  As Integer = 40505
Public Const SPC_TRIG_EXT0_AVAILMODESAND As Integer = 40506
Public Const SPC_TRIG_EXT1_AVAILMODESAND As Integer = 40507
Public Const SPC_TRIG_EXT2_AVAILMODESAND As Integer = 40508
Public Const SPC_TRIG_EXT3_AVAILMODESAND As Integer = 40509
Public Const SPC_TRIG_EXT0_MODE          As Integer = 40510
Public Const SPC_TRIG_EXT1_MODE          As Integer = 40511
Public Const SPC_TRIG_EXT2_MODE          As Integer = 40512
Public Const SPC_TRIG_EXT3_MODE          As Integer = 40513
Public Const SPC_TRIG_EXT3_AVAILMODES    As Integer = 40514
Public Const SPC_TRIG_EXT3_AVAILMODESOR  As Integer = 40515

Public Const SPC_TRIG_EXT0_READFEATURES  As Integer = 40520
Public Const SPC_TRIG_EXT1_READFEATURES  As Integer = 40521
Public Const SPC_TRIG_EXT2_READFEATURES  As Integer = 40522
Public Const SPC_TRIG_EXT3_READFEATURES  As Integer = 40523
Public Const     SPCM_TRFEAT_TERM            As Integer = &H00000001
Public Const     SPCM_TRFEAT_HIGHIMP         As Integer = &H00000002
Public Const     SPCM_TRFEAT_DCCOUPLING      As Integer = &H00000004
Public Const     SPCM_TRFEAT_ACCOUPLING      As Integer = &H00000008
Public Const     SPCM_TRFEAT_SE              As Integer = &H00000010
Public Const     SPCM_TRFEAT_DIFF            As Integer = &H00000020
Public Const     SPCM_TRFEAT_LEVELPROG       As Integer = &H00000100
Public Const     SPCM_TRFEAT_PROGTHRESHOLD   As Integer = &H00000200

' legacy constants: not enough contiguous constants possible for X4..X19
Public Const SPC_LEGACY_X0_READFEATURES  As Integer = 40530
Public Const SPC_LEGACY_X1_READFEATURES  As Integer = 40531
Public Const SPC_LEGACY_X2_READFEATURES  As Integer = 40532
Public Const SPC_LEGACY_X3_READFEATURES  As Integer = 40533

' legacy constants: not enough contiguous constants possible for X4..X19
Public Const SPC_LEGACY_X0_TERM          As Integer = 40535
Public Const SPC_LEGACY_X1_TERM          As Integer = 40536
Public Const SPC_LEGACY_X2_TERM          As Integer = 40537
Public Const SPC_LEGACY_X3_TERM          As Integer = 40538

Public Const SPC_TRIG_XIO_AVAILMODES     As Integer = 40550
Public Const SPC_TRIG_XIO_AVAILMODESOR   As Integer = 40551
Public Const SPC_TRIG_XIO_AVAILMODESAND  As Integer = 40552
Public Const SPC_TRIG_XIO0_MODE          As Integer = 40560
Public Const SPC_TRIG_XIO1_MODE          As Integer = 40561
Public Const     SPC_TM_MODEMASK         As Integer = &H00FFFFFF
Public Const     SPC_TM_NONE             As Integer = &H00000000
Public Const     SPC_TM_POS              As Integer = &H00000001
Public Const     SPC_TM_NEG              As Integer = &H00000002
Public Const     SPC_TM_BOTH             As Integer = &H00000004
Public Const     SPC_TM_HIGH             As Integer = &H00000008
Public Const     SPC_TM_LOW              As Integer = &H00000010
Public Const     SPC_TM_WINENTER         As Integer = &H00000020
Public Const     SPC_TM_WINLEAVE         As Integer = &H00000040
Public Const     SPC_TM_INWIN            As Integer = &H00000080
Public Const     SPC_TM_OUTSIDEWIN       As Integer = &H00000100
Public Const     SPC_TM_SPIKE            As Integer = &H00000200
Public Const     SPC_TM_PATTERN          As Integer = &H00000400
Public Const     SPC_TM_STEEPPOS         As Integer = &H00000800
Public Const     SPC_TM_STEEPNEG         As Integer = &H00001000
Public Const     SPC_TM_EXTRAMASK        As Integer = &HFF000000
Public Const     SPC_TM_REARM            As Integer = &H01000000
Public Const     SPC_TM_PW_SMALLER       As Integer = &H02000000
Public Const     SPC_TM_PW_GREATER       As Integer = &H04000000
Public Const     SPC_TM_DOUBLEEDGE       As Integer = &H08000000
Public Const     SPC_TM_PULSESTRETCH     As Integer = &H10000000
Public Const     SPC_TM_HYSTERESIS       As Integer = &H20000000

Public Const SPC_TRIG_PATTERN_AVAILMODES As Integer = 40580
Public Const SPC_TRIG_PATTERN_MODE       As Integer = 40590

Public Const SPC_TRIG_CH_AVAILMODES      As Integer = 40600
Public Const SPC_TRIG_CH_AVAILMODESOR    As Integer = 40601
Public Const SPC_TRIG_CH_AVAILMODESAND   As Integer = 40602
Public Const SPC_TRIG_CH0_MODE           As Integer = 40610
Public Const SPC_TRIG_CH1_MODE           As Integer = 40611
Public Const SPC_TRIG_CH2_MODE           As Integer = 40612
Public Const SPC_TRIG_CH3_MODE           As Integer = 40613
Public Const SPC_TRIG_CH4_MODE           As Integer = 40614
Public Const SPC_TRIG_CH5_MODE           As Integer = 40615
Public Const SPC_TRIG_CH6_MODE           As Integer = 40616
Public Const SPC_TRIG_CH7_MODE           As Integer = 40617
Public Const SPC_TRIG_CH8_MODE           As Integer = 40618
Public Const SPC_TRIG_CH9_MODE           As Integer = 40619
Public Const SPC_TRIG_CH10_MODE          As Integer = 40620
Public Const SPC_TRIG_CH11_MODE          As Integer = 40621
Public Const SPC_TRIG_CH12_MODE          As Integer = 40622
Public Const SPC_TRIG_CH13_MODE          As Integer = 40623
Public Const SPC_TRIG_CH14_MODE          As Integer = 40624
Public Const SPC_TRIG_CH15_MODE          As Integer = 40625
Public Const SPC_TRIG_CH16_MODE          As Integer = 40626
Public Const SPC_TRIG_CH17_MODE          As Integer = 40627
Public Const SPC_TRIG_CH18_MODE          As Integer = 40628
Public Const SPC_TRIG_CH19_MODE          As Integer = 40629
Public Const SPC_TRIG_CH20_MODE          As Integer = 40630
Public Const SPC_TRIG_CH21_MODE          As Integer = 40631
Public Const SPC_TRIG_CH22_MODE          As Integer = 40632
Public Const SPC_TRIG_CH23_MODE          As Integer = 40633
Public Const SPC_TRIG_CH24_MODE          As Integer = 40634
Public Const SPC_TRIG_CH25_MODE          As Integer = 40635
Public Const SPC_TRIG_CH26_MODE          As Integer = 40636
Public Const SPC_TRIG_CH27_MODE          As Integer = 40637
Public Const SPC_TRIG_CH28_MODE          As Integer = 40638
Public Const SPC_TRIG_CH29_MODE          As Integer = 40639
Public Const SPC_TRIG_CH30_MODE          As Integer = 40640
Public Const SPC_TRIG_CH31_MODE          As Integer = 40641

Public Const SPC_TRIG_CH32_MODE          As Integer = 40642
Public Const SPC_TRIG_CH33_MODE          As Integer = 40643
Public Const SPC_TRIG_CH34_MODE          As Integer = 40644
Public Const SPC_TRIG_CH35_MODE          As Integer = 40645
Public Const SPC_TRIG_CH36_MODE          As Integer = 40646
Public Const SPC_TRIG_CH37_MODE          As Integer = 40647
Public Const SPC_TRIG_CH38_MODE          As Integer = 40648
Public Const SPC_TRIG_CH39_MODE          As Integer = 40649
Public Const SPC_TRIG_CH40_MODE          As Integer = 40650
Public Const SPC_TRIG_CH41_MODE          As Integer = 40651
Public Const SPC_TRIG_CH42_MODE          As Integer = 40652
Public Const SPC_TRIG_CH43_MODE          As Integer = 40653
Public Const SPC_TRIG_CH44_MODE          As Integer = 40654
Public Const SPC_TRIG_CH45_MODE          As Integer = 40655
Public Const SPC_TRIG_CH46_MODE          As Integer = 40656
Public Const SPC_TRIG_CH47_MODE          As Integer = 40657
Public Const SPC_TRIG_CH48_MODE          As Integer = 40658
Public Const SPC_TRIG_CH49_MODE          As Integer = 40659
Public Const SPC_TRIG_CH50_MODE          As Integer = 40660
Public Const SPC_TRIG_CH51_MODE          As Integer = 40661
Public Const SPC_TRIG_CH52_MODE          As Integer = 40662
Public Const SPC_TRIG_CH53_MODE          As Integer = 40663
Public Const SPC_TRIG_CH54_MODE          As Integer = 40664
Public Const SPC_TRIG_CH55_MODE          As Integer = 40665
Public Const SPC_TRIG_CH56_MODE          As Integer = 40666
Public Const SPC_TRIG_CH57_MODE          As Integer = 40667
Public Const SPC_TRIG_CH58_MODE          As Integer = 40668
Public Const SPC_TRIG_CH59_MODE          As Integer = 40669
Public Const SPC_TRIG_CH60_MODE          As Integer = 40670
Public Const SPC_TRIG_CH61_MODE          As Integer = 40671
Public Const SPC_TRIG_CH62_MODE          As Integer = 40672
Public Const SPC_TRIG_CH63_MODE          As Integer = 40673


Public Const SPC_TRIG_AVAILDELAY         As Integer = 40800
Public Const SPC_TRIG_AVAILDELAY_STEP    As Integer = 40801
Public Const SPC_TRIG_DELAY              As Integer = 40810

Public Const SPC_TRIG_AVAILHOLDOFF       As Integer = 40802
Public Const SPC_TRIG_AVAILHOLDOFF_STEP  As Integer = 40803
Public Const SPC_TRIG_HOLDOFF            As Integer = 40811

Public Const SPC_SINGLESHOT              As Integer = 41000
Public Const SPC_OUTONTRIGGER            As Integer = 41100
Public Const SPC_RESTARTCONT             As Integer = 41200
Public Const SPC_SINGLERESTART           As Integer = 41300

Public Const SPC_TRIGGERLEVEL            As Integer = 42000
Public Const SPC_TRIGGERLEVEL0           As Integer = 42000
Public Const SPC_TRIGGERLEVEL1           As Integer = 42001
Public Const SPC_TRIGGERLEVEL2           As Integer = 42002
Public Const SPC_TRIGGERLEVEL3           As Integer = 42003
Public Const SPC_TRIGGERLEVEL4           As Integer = 42004
Public Const SPC_TRIGGERLEVEL5           As Integer = 42005
Public Const SPC_TRIGGERLEVEL6           As Integer = 42006
Public Const SPC_TRIGGERLEVEL7           As Integer = 42007
Public Const SPC_TRIGGERLEVEL8           As Integer = 42008
Public Const SPC_TRIGGERLEVEL9           As Integer = 42009
Public Const SPC_TRIGGERLEVEL10          As Integer = 42010
Public Const SPC_TRIGGERLEVEL11          As Integer = 42011
Public Const SPC_TRIGGERLEVEL12          As Integer = 42012
Public Const SPC_TRIGGERLEVEL13          As Integer = 42013
Public Const SPC_TRIGGERLEVEL14          As Integer = 42014
Public Const SPC_TRIGGERLEVEL15          As Integer = 42015

Public Const SPC_AVAILHIGHLEVEL_MIN      As Integer = 41997
Public Const SPC_AVAILHIGHLEVEL_MAX      As Integer = 41998
Public Const SPC_AVAILHIGHLEVEL_STEP     As Integer = 41999

Public Const SPC_HIGHLEVEL0              As Integer = 42000
Public Const SPC_HIGHLEVEL1              As Integer = 42001
Public Const SPC_HIGHLEVEL2              As Integer = 42002
Public Const SPC_HIGHLEVEL3              As Integer = 42003
Public Const SPC_HIGHLEVEL4              As Integer = 42004
Public Const SPC_HIGHLEVEL5              As Integer = 42005
Public Const SPC_HIGHLEVEL6              As Integer = 42006
Public Const SPC_HIGHLEVEL7              As Integer = 42007
Public Const SPC_HIGHLEVEL8              As Integer = 42008
Public Const SPC_HIGHLEVEL9              As Integer = 42009
Public Const SPC_HIGHLEVEL10             As Integer = 42010
Public Const SPC_HIGHLEVEL11             As Integer = 42011
Public Const SPC_HIGHLEVEL12             As Integer = 42012
Public Const SPC_HIGHLEVEL13             As Integer = 42013
Public Const SPC_HIGHLEVEL14             As Integer = 42014
Public Const SPC_HIGHLEVEL15             As Integer = 42015

Public Const SPC_AVAILLOWLEVEL_MIN       As Integer = 42097
Public Const SPC_AVAILLOWLEVEL_MAX       As Integer = 42098
Public Const SPC_AVAILLOWLEVEL_STEP      As Integer = 42099

Public Const SPC_LOWLEVEL0               As Integer = 42100
Public Const SPC_LOWLEVEL1               As Integer = 42101
Public Const SPC_LOWLEVEL2               As Integer = 42102
Public Const SPC_LOWLEVEL3               As Integer = 42103
Public Const SPC_LOWLEVEL4               As Integer = 42104
Public Const SPC_LOWLEVEL5               As Integer = 42105
Public Const SPC_LOWLEVEL6               As Integer = 42106
Public Const SPC_LOWLEVEL7               As Integer = 42107
Public Const SPC_LOWLEVEL8               As Integer = 42108
Public Const SPC_LOWLEVEL9               As Integer = 42109
Public Const SPC_LOWLEVEL10              As Integer = 42110
Public Const SPC_LOWLEVEL11              As Integer = 42111
Public Const SPC_LOWLEVEL12              As Integer = 42112
Public Const SPC_LOWLEVEL13              As Integer = 42113
Public Const SPC_LOWLEVEL14              As Integer = 42114
Public Const SPC_LOWLEVEL15              As Integer = 42115

Public Const SPC_TRIG_CH0_LEVEL0         As Integer = 42200
Public Const SPC_TRIG_CH1_LEVEL0         As Integer = 42201
Public Const SPC_TRIG_CH2_LEVEL0         As Integer = 42202
Public Const SPC_TRIG_CH3_LEVEL0         As Integer = 42203
Public Const SPC_TRIG_CH4_LEVEL0         As Integer = 42204
Public Const SPC_TRIG_CH5_LEVEL0         As Integer = 42205
Public Const SPC_TRIG_CH6_LEVEL0         As Integer = 42206
Public Const SPC_TRIG_CH7_LEVEL0         As Integer = 42207
Public Const SPC_TRIG_CH8_LEVEL0         As Integer = 42208
Public Const SPC_TRIG_CH9_LEVEL0         As Integer = 42209
Public Const SPC_TRIG_CH10_LEVEL0        As Integer = 42210
Public Const SPC_TRIG_CH11_LEVEL0        As Integer = 42211
Public Const SPC_TRIG_CH12_LEVEL0        As Integer = 42212
Public Const SPC_TRIG_CH13_LEVEL0        As Integer = 42213
Public Const SPC_TRIG_CH14_LEVEL0        As Integer = 42214
Public Const SPC_TRIG_CH15_LEVEL0        As Integer = 42215

Public Const SPC_TRIG_CH0_LEVEL1         As Integer = 42300
Public Const SPC_TRIG_CH1_LEVEL1         As Integer = 42301
Public Const SPC_TRIG_CH2_LEVEL1         As Integer = 42302
Public Const SPC_TRIG_CH3_LEVEL1         As Integer = 42303
Public Const SPC_TRIG_CH4_LEVEL1         As Integer = 42304
Public Const SPC_TRIG_CH5_LEVEL1         As Integer = 42305
Public Const SPC_TRIG_CH6_LEVEL1         As Integer = 42306
Public Const SPC_TRIG_CH7_LEVEL1         As Integer = 42307
Public Const SPC_TRIG_CH8_LEVEL1         As Integer = 42308
Public Const SPC_TRIG_CH9_LEVEL1         As Integer = 42309
Public Const SPC_TRIG_CH10_LEVEL1        As Integer = 42310
Public Const SPC_TRIG_CH11_LEVEL1        As Integer = 42311
Public Const SPC_TRIG_CH12_LEVEL1        As Integer = 42312
Public Const SPC_TRIG_CH13_LEVEL1        As Integer = 42313
Public Const SPC_TRIG_CH14_LEVEL1        As Integer = 42314
Public Const SPC_TRIG_CH15_LEVEL1        As Integer = 42315

Public Const SPC_TRIG_EXT0_LEVEL0        As Integer = 42320
Public Const SPC_TRIG_EXT1_LEVEL0        As Integer = 42321
Public Const SPC_TRIG_EXT2_LEVEL0        As Integer = 42322

Public Const SPC_TRIG_EXT0_LEVEL1        As Integer = 42330
Public Const SPC_TRIG_EXT1_LEVEL1        As Integer = 42331
Public Const SPC_TRIG_EXT2_LEVEL1        As Integer = 42332

Public Const SPC_TRIG_EXT_AVAIL0_MIN     As Integer = 42340
Public Const SPC_TRIG_EXT_AVAIL0_MAX     As Integer = 42341
Public Const SPC_TRIG_EXT_AVAIL0_STEP    As Integer = 42342

Public Const SPC_TRIG_EXT_AVAIL1_MIN     As Integer = 42345
Public Const SPC_TRIG_EXT_AVAIL1_MAX     As Integer = 42346
Public Const SPC_TRIG_EXT_AVAIL1_STEP    As Integer = 42347

' threshold levels (for 77xx)
Public Const SPC_THRESHOLD0              As Integer = 42400  ' threshold level for channel group 0
Public Const SPC_THRESHOLD1              As Integer = 42401  ' threshold level for channel group 1
Public Const SPC_THRESHOLD2              As Integer = 42402  ' threshold level for channel group 2
Public Const SPC_THRESHOLD3              As Integer = 42403  ' threshold level for channel group 3
Public Const SPC_CLOCK_THRESHOLD         As Integer = 42410  ' threshold level for clock input
Public Const SPC_TRIG_THRESHOLD          As Integer = 42411  ' threshold level for trigger input
Public Const SPC_X0X1_THRESHOLD          As Integer = 42412  ' threshold level for X0/X1 input
Public Const SPC_STROBE_THRESHOLD        As Integer = 42413  ' threshold level for strobe input

Public Const SPC_AVAILTHRESHOLD_MIN      As Integer = 42420
Public Const SPC_AVAILTHRESHOLD_MAX      As Integer = 42421
Public Const SPC_AVAILTHRESHOLD_STEP     As Integer = 42422

Public Const SPC_CLOCK_AVAILTHRESHOLD_MIN  As Integer = 42423
Public Const SPC_CLOCK_AVAILTHRESHOLD_MAX  As Integer = 42424
Public Const SPC_CLOCK_AVAILTHRESHOLD_STEP As Integer = 42425

Public Const SPC_TRIG_AVAILTHRESHOLD_MIN  As Integer = 42426
Public Const SPC_TRIG_AVAILTHRESHOLD_MAX  As Integer = 42427
Public Const SPC_TRIG_AVAILTHRESHOLD_STEP As Integer = 42428

Public Const SPC_TRIGGERPATTERN          As Integer = 43000
Public Const SPC_TRIGGERPATTERN0         As Integer = 43000
Public Const SPC_TRIGGERPATTERN1         As Integer = 43001
Public Const SPC_TRIGGERMASK             As Integer = 43100
Public Const SPC_TRIGGERMASK0            As Integer = 43100
Public Const SPC_TRIGGERMASK1            As Integer = 43101

Public Const SPC_PULSEWIDTH              As Integer = 44000
Public Const SPC_PULSEWIDTH0             As Integer = 44000
Public Const SPC_PULSEWIDTH1             As Integer = 44001

Public Const SPC_TRIG_CH_AVAILPULSEWIDTH As Integer = 44100
Public Const SPC_TRIG_CH_PULSEWIDTH      As Integer = 44101
Public Const SPC_TRIG_CH0_PULSEWIDTH     As Integer = 44101
Public Const SPC_TRIG_CH1_PULSEWIDTH     As Integer = 44102
Public Const SPC_TRIG_CH2_PULSEWIDTH     As Integer = 44103
Public Const SPC_TRIG_CH3_PULSEWIDTH     As Integer = 44104
Public Const SPC_TRIG_CH4_PULSEWIDTH     As Integer = 44105
Public Const SPC_TRIG_CH5_PULSEWIDTH     As Integer = 44106
Public Const SPC_TRIG_CH6_PULSEWIDTH     As Integer = 44107
Public Const SPC_TRIG_CH7_PULSEWIDTH     As Integer = 44108
Public Const SPC_TRIG_CH8_PULSEWIDTH     As Integer = 44109
Public Const SPC_TRIG_CH9_PULSEWIDTH     As Integer = 44110
Public Const SPC_TRIG_CH10_PULSEWIDTH    As Integer = 44111
Public Const SPC_TRIG_CH11_PULSEWIDTH    As Integer = 44112
Public Const SPC_TRIG_CH12_PULSEWIDTH    As Integer = 44113
Public Const SPC_TRIG_CH13_PULSEWIDTH    As Integer = 44114
Public Const SPC_TRIG_CH14_PULSEWIDTH    As Integer = 44115
Public Const SPC_TRIG_CH15_PULSEWIDTH    As Integer = 44116

Public Const SPC_TRIG_EXT_AVAILPULSEWIDTH As Integer = 44200
Public Const SPC_TRIG_EXT0_PULSEWIDTH    As Integer = 44210
Public Const SPC_TRIG_EXT1_PULSEWIDTH    As Integer = 44211
Public Const SPC_TRIG_EXT2_PULSEWIDTH    As Integer = 44212
Public Const SPC_TRIG_EXT3_PULSEWIDTH    As Integer = 44213

' available dividers for MICX
Public Const SPC_READCLOCKDIVCOUNT       As Integer = 44300
Public Const SPC_CLOCKDIV0               As Integer = 44301
Public Const SPC_CLOCKDIV1               As Integer = 44302
Public Const SPC_CLOCKDIV2               As Integer = 44303
Public Const SPC_CLOCKDIV3               As Integer = 44304
Public Const SPC_CLOCKDIV4               As Integer = 44305
Public Const SPC_CLOCKDIV5               As Integer = 44306
Public Const SPC_CLOCKDIV6               As Integer = 44307
Public Const SPC_CLOCKDIV7               As Integer = 44308
Public Const SPC_CLOCKDIV8               As Integer = 44309
Public Const SPC_CLOCKDIV9               As Integer = 44310
Public Const SPC_CLOCKDIV10              As Integer = 44311
Public Const SPC_CLOCKDIV11              As Integer = 44312
Public Const SPC_CLOCKDIV12              As Integer = 44313
Public Const SPC_CLOCKDIV13              As Integer = 44314
Public Const SPC_CLOCKDIV14              As Integer = 44315
Public Const SPC_CLOCKDIV15              As Integer = 44316
Public Const SPC_CLOCKDIV16              As Integer = 44317

Public Const SPC_READTROFFSET            As Integer = 45000
Public Const SPC_TRIGGEREDGE             As Integer = 46000
Public Const SPC_TRIGGEREDGE0            As Integer = 46000
Public Const SPC_TRIGGEREDGE1            As Integer = 46001
Public Const     TE_POS                  As Integer = 10000
Public Const     TE_NEG                  As Integer = 10010
Public Const     TE_BOTH                 As Integer = 10020
Public Const     TE_NONE                 As Integer = 10030


' ----- Timestamp -----
Public Const CH_TIMESTAMP                As Integer = 9999

Public Const SPC_TIMESTAMP_CMD           As Integer = 47000
Public Const     TS_RESET                    As Integer = 0
Public Const     TS_MODE_DISABLE             As Integer = 10
Public Const     TS_MODE_STARTRESET          As Integer = 11
Public Const     TS_MODE_STANDARD            As Integer = 12
Public Const     TS_MODE_REFCLOCK            As Integer = 13
Public Const     TS_MODE_TEST5555            As Integer = 90
Public Const     TS_MODE_TESTAAAA            As Integer = 91
Public Const     TS_MODE_ZHTEST              As Integer = 92

' ----- modes for M2i, M3i, M4i, M4x, M2p hardware (bitmap) -----
Public Const SPC_TIMESTAMP_AVAILMODES    As Integer = 47001
Public Const     SPC_TSMODE_DISABLE      As Integer = &H00000000
Public Const     SPC_TS_RESET            As Integer = &H00000001
Public Const     SPC_TSMODE_STANDARD     As Integer = &H00000002
Public Const     SPC_TSMODE_STARTRESET   As Integer = &H00000004
Public Const     SPC_TS_RESET_WAITREFCLK As Integer = &H00000008
Public Const     SPC_TSCNT_INTERNAL      As Integer = &H00000100
Public Const     SPC_TSCNT_REFCLOCKPOS   As Integer = &H00000200
Public Const     SPC_TSCNT_REFCLOCKNEG   As Integer = &H00000400
Public Const     SPC_TSFEAT_NONE         As Integer = &H00000000
Public Const     SPC_TSFEAT_STORE1STABA  As Integer = &H00010000
Public Const     SPC_TSFEAT_INCRMODE     As Integer = &H00020000
Public Const     SPC_TSFEAT_INCRMODE12   As Integer = &H00040000
Public Const     SPC_TSFEAT_TRGSRC       As Integer = &H00080000

Public Const     SPC_TSXIOACQ_DISABLE    As Integer = &H00000000
Public Const     SPC_TSXIOACQ_ENABLE     As Integer = &H00001000
Public Const     SPC_TSXIOINC_ENABLE     As Integer = &H00002000
Public Const     SPC_TSXIOINC12_ENABLE   As Integer = &H00004000

Public Const     SPC_TSMODE_MASK         As Integer = &H000000FF
Public Const     SPC_TSCNT_MASK          As Integer = &H00000F00
Public Const     SPC_TSFEAT_MASK         As Integer = &H000F0000

Public Const     SPC_TRGSRC_MASK_CH0       As Integer = &H00000001
Public Const     SPC_TRGSRC_MASK_CH1       As Integer = &H00000002
Public Const     SPC_TRGSRC_MASK_CH2       As Integer = &H00000004
Public Const     SPC_TRGSRC_MASK_CH3       As Integer = &H00000008
Public Const     SPC_TRGSRC_MASK_CH4       As Integer = &H00000010
Public Const     SPC_TRGSRC_MASK_CH5       As Integer = &H00000020
Public Const     SPC_TRGSRC_MASK_CH6       As Integer = &H00000040
Public Const     SPC_TRGSRC_MASK_CH7       As Integer = &H00000080
Public Const     SPC_TRGSRC_MASK_EXT0      As Integer = &H00000100
Public Const     SPC_TRGSRC_MASK_EXT1      As Integer = &H00000200
Public Const     SPC_TRGSRC_MASK_FORCE     As Integer = &H00000400
' space for digital channels using TSXIOACQ_ENABLE of standard multi-purpose lines
Public Const     SPC_TRGSRC_MASK_PXI0      As Integer = &H00010000
Public Const     SPC_TRGSRC_MASK_PXI1      As Integer = &H00020000
Public Const     SPC_TRGSRC_MASK_PXI2      As Integer = &H00040000
Public Const     SPC_TRGSRC_MASK_PXI3      As Integer = &H00080000
Public Const     SPC_TRGSRC_MASK_PXI4      As Integer = &H00100000
Public Const     SPC_TRGSRC_MASK_PXI5      As Integer = &H00200000
Public Const     SPC_TRGSRC_MASK_PXI6      As Integer = &H00400000
Public Const     SPC_TRGSRC_MASK_PXI7      As Integer = &H00800000
Public Const     SPC_TRGSRC_MASK_PXISTAR   As Integer = &H01000000
Public Const     SPC_TRGSRC_MASK_PXIDSTARB As Integer = &H02000000
Public Const     SPC_TRGSRC_MASK_X1        As Integer = &H20000000
Public Const     SPC_TRGSRC_MASK_X2        As Integer = &H40000000
Public Const     SPC_TRGSRC_MASK_X3        As Integer = &H80000000
' space for more digital channels using TSXIOACQ_ENABLE of additional multi-purpose lines (optional)


Public Const SPC_TIMESTAMP_STATUS        As Integer = 47010
Public Const     TS_FIFO_EMPTY               As Integer = 0
Public Const     TS_FIFO_LESSHALF            As Integer = 1
Public Const     TS_FIFO_MOREHALF            As Integer = 2
Public Const     TS_FIFO_OVERFLOW            As Integer = 3

Public Const SPC_TIMESTAMP_COUNT         As Integer = 47020
Public Const SPC_TIMESTAMP_STARTTIME     As Integer = 47030
Public Const SPC_TIMESTAMP_STARTDATE     As Integer = 47031
Public Const SPC_TIMESTAMP_FIFO          As Integer = 47040
Public Const SPC_TIMESTAMP_TIMEOUT       As Integer = 47045

Public Const SPC_TIMESTAMP_RESETMODE     As Integer = 47050
Public Const     TS_RESET_POS               As Integer = 10
Public Const     TS_RESET_NEG               As Integer = 20



' ----- Extra I/O module -----
Public Const SPC_XIO_DIRECTION           As Integer = 47100
Public Const     XD_CH0_INPUT                As Integer = 0
Public Const     XD_CH0_OUTPUT               As Integer = 1
Public Const     XD_CH1_INPUT                As Integer = 0
Public Const     XD_CH1_OUTPUT               As Integer = 2
Public Const     XD_CH2_INPUT                As Integer = 0
Public Const     XD_CH2_OUTPUT               As Integer = 4
Public Const SPC_XIO_DIGITALIO           As Integer = 47110
Public Const SPC_XIO_ANALOGOUT0          As Integer = 47120
Public Const SPC_XIO_ANALOGOUT1          As Integer = 47121
Public Const SPC_XIO_ANALOGOUT2          As Integer = 47122
Public Const SPC_XIO_ANALOGOUT3          As Integer = 47123
Public Const SPC_XIO_WRITEDACS           As Integer = 47130



' ----- M3i        multi purpose lines (X0, X1        ) 
' ----- M4i + M4x  multi purpose lines (X0, X1, X2    ) 
' ----- M2p        multi purpose lines (X0, X1, X2, X3) and with installed option also (X4 .. X19)

' legacy constants: not enough contiguous constants possible for X4..X19,
' hence new constants for X-modes (SPCM_X0_MODE.. SPCM_X19_MODE) exist further below
Public Const SPCM_LEGACY_X0_MODE         As Integer = 47200
Public Const SPCM_LEGACY_X1_MODE         As Integer = 47201
Public Const SPCM_LEGACY_X2_MODE         As Integer = 47202
Public Const SPCM_LEGACY_X3_MODE         As Integer = 47203
Public Const SPCM_LEGACY_X0_AVAILMODES   As Integer = 47210
Public Const SPCM_LEGACY_X1_AVAILMODES   As Integer = 47211
Public Const SPCM_LEGACY_X2_AVAILMODES   As Integer = 47212
Public Const SPCM_LEGACY_X3_AVAILMODES   As Integer = 47213
Public Const     SPCM_XMODE_DISABLE           As Integer = &H00000000
Public Const     SPCM_XMODE_ASYNCIN           As Integer = &H00000001  ' used as asynchronous input
Public Const     SPCM_XMODE_ASYNCOUT          As Integer = &H00000002  ' used as asynchronous output
Public Const     SPCM_XMODE_DIGIN             As Integer = &H00000004  ' used as synchronous digital input
Public Const     SPCM_XMODE_DIGOUT            As Integer = &H00000008  ' used as synchronous digital output
Public Const     SPCM_XMODE_TRIGIN            As Integer = &H00000010  ' used as trigger input
Public Const     SPCM_XMODE_TRIGOUT           As Integer = &H00000020  ' used as trigger output
Public Const     SPCM_XMODE_OVROUT            As Integer = &H00000040  ' used as ADC overrange output
Public Const     SPCM_XMODE_DIGIN2BIT         As Integer = &H00000080  ' used as synchronous digital input, 2bits per channel
Public Const     SPCM_XMODE_RUNSTATE          As Integer = &H00000100  ' shows the run state of the card (high = run)
Public Const     SPCM_XMODE_ARMSTATE          As Integer = &H00000200  ' shows the arm state (high = armed for trigger of one single card)
Public Const     SPCM_XMODE_DIRECTTRIGOUT     As Integer = &H00000400  ' used as direct trigger output (safe mode) 
Public Const     SPCM_XMODE_DIRECTTRIGOUT_LR  As Integer = &H00000800  ' used as direct trigger output (low re-arm)
Public Const     SPCM_XMODE_REFCLKOUT         As Integer = &H00001000  ' outputs internal or fed in external refclock
Public Const     SPCM_XMODE_CONTOUTMARK       As Integer = &H00002000  ' outputs a half posttrigger long HIGH pulse on replay
Public Const     SPCM_XMODE_SYSCLKOUT         As Integer = &H00004000  ' outputs internal system clock
Public Const     SPCM_XMODE_CLKOUT            As Integer = &H00008000  ' clock output
Public Const     SPCM_XMODE_SYNCARMSTATE      As Integer = &H00010000  ' shows the arm state (high = armed for trigger when all cards connected to a Star-Hub are armed)
Public Const     SPCM_XMODE_OPTDIGIN2BIT      As Integer = &H00020000  ' used as synchronous digital input from digitaloption, 2bits per channel
Public Const     SPCM_XMODE_OPTDIGIN4BIT      As Integer = &H00040000  ' used as synchronous digital input from digitaloption, 4bits per channel
Public Const     SPCM_XMODE_MODEMASK          As Integer = &H000FFFFF

' additional constants to be combined together with SPCM_XMODE_DIGOUT to select analog channel containing digital data
Public Const     SPCM_XMODE_DIGOUTSRC_CH0     As Integer = &H01000000  ' Select Ch0 as source 
Public Const     SPCM_XMODE_DIGOUTSRC_CH1     As Integer = &H02000000  ' Select Ch1 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH2     As Integer = &H04000000  ' Select Ch2 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH3     As Integer = &H08000000  ' Select Ch3 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH4     As Integer = &H10000000  ' Select Ch4 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH5     As Integer = &H20000000  ' Select Ch5 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH6     As Integer = &H40000000  ' Select Ch6 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CH7     As Integer = &H80000000  ' Select Ch7 as source
Public Const     SPCM_XMODE_DIGOUTSRC_CHMASK  As Integer = &HFF000000

' additional constants to be combined together with SPCM_XMODE_DIGOUT to select digital signal source
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15              As Integer = &H00100000  ' Use Bit15 (MSB    ) of selected channel: channel resolution will be reduced to 15 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT14              As Integer = &H00200000  ' Use Bit14 (MSB - 1) of selected channel: channel resolution will be reduced to 14 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT13              As Integer = &H00400000  ' Use Bit13 (MSB - 2) of selected channel: channel resolution will be reduced to 13 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BIT12              As Integer = &H00800000  ' Use Bit12 (MSB - 3) of selected channel: channel resolution will be reduced to 12 bit
Public Const     SPCM_XMODE_DIGOUTSRC_BITMASK            As Integer = &H00F00000
' special combinations for M2p.65xx cards with options SPCM_FEAT_DIG16_SMB or SPCM_FEAT_DIG16_FX2
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_0     As Integer = &H00F00000  ' use all   16 bits of selected channel on  (X19..X4)              : channel will only contain digital data
Public Const     SPCM_XMODE_DIGOUTSRC_BIT15_downto_8     As Integer = &H00700000  ' use upper  8 bits of selected channel for (X19..X12) or (X11..X4): channel resolution will be reduced to 8 bit

Public Const SPCM_XX_ASYNCIO             As Integer = 47220           ' asynchronous in/out register

Public Const SPC_DIGMODE0 As Integer = 47250
Public Const SPC_DIGMODE1 As Integer = 47251
Public Const SPC_DIGMODE2 As Integer = 47252
Public Const SPC_DIGMODE3 As Integer = 47253
Public Const SPC_DIGMODE4 As Integer = 47254
Public Const SPC_DIGMODE5 As Integer = 47255
Public Const SPC_DIGMODE6 As Integer = 47256
Public Const SPC_DIGMODE7 As Integer = 47257
Public Const     SPCM_DIGMODE_OFF As Integer = &H00000000

Public Const     SPCM_DIGMODE_X1  As Integer = &H294A5000 ' (M2P_DIGMODE_X1 << (32 - 5)) | (M2P_DIGMODE_X1 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X2  As Integer = &H318C6000 ' (M2P_DIGMODE_X2 << (32 - 5)) | (M2P_DIGMODE_X2 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X3  As Integer = &H39CE7000 ' (M2P_DIGMODE_X3 << (32 - 5)) | (M2P_DIGMODE_X3 << (32 - 10))  ... etc
Public Const     SPCM_DIGMODE_X4  As Integer = &H84210001
Public Const     SPCM_DIGMODE_X5  As Integer = &H8c631002
Public Const     SPCM_DIGMODE_X6  As Integer = &H94a52004
Public Const     SPCM_DIGMODE_X7  As Integer = &H9ce73008
Public Const     SPCM_DIGMODE_X8  As Integer = &Ha5294010
Public Const     SPCM_DIGMODE_X9  As Integer = &Had6b5020
Public Const     SPCM_DIGMODE_X10 As Integer = &Hb5ad6040
Public Const     SPCM_DIGMODE_X11 As Integer = &Hbdef7080
Public Const     SPCM_DIGMODE_X12 As Integer = &Hc6318100
Public Const     SPCM_DIGMODE_X13 As Integer = &Hce739200
Public Const     SPCM_DIGMODE_X14 As Integer = &Hd6b5a400
Public Const     SPCM_DIGMODE_X15 As Integer = &Hdef7b800
Public Const     SPCM_DIGMODE_X16 As Integer = &He739c000
Public Const     SPCM_DIGMODE_X17 As Integer = &Hef7bd000
Public Const     SPCM_DIGMODE_X18 As Integer = &Hf7bde000
Public Const     SPCM_DIGMODE_X19 As Integer = &Hfffff000

Public Const     DIGMODEMASK_BIT15 As Integer = &HF8000000
Public Const     DIGMODEMASK_BIT14 As Integer = &H07C00000
Public Const     DIGMODEMASK_BIT13 As Integer = &H003E0000
Public Const     DIGMODEMASK_BIT12 As Integer = &H0001F000
Public Const     DIGMODEMASK_BIT11 As Integer = &H00000800 ' one bit only for bit 11 downto 0
Public Const     DIGMODEMASK_BIT10 As Integer = &H00000400
Public Const     DIGMODEMASK_BIT9  As Integer = &H00000200
Public Const     DIGMODEMASK_BIT8  As Integer = &H00000100
Public Const     DIGMODEMASK_BIT7  As Integer = &H00000080
Public Const     DIGMODEMASK_BIT6  As Integer = &H00000040
Public Const     DIGMODEMASK_BIT5  As Integer = &H00000020
Public Const     DIGMODEMASK_BIT4  As Integer = &H00000010
Public Const     DIGMODEMASK_BIT3  As Integer = &H00000008
Public Const     DIGMODEMASK_BIT2  As Integer = &H00000004
Public Const     DIGMODEMASK_BIT1  As Integer = &H00000002
Public Const     DIGMODEMASK_BIT0  As Integer = &H00000001

' provided for convenience
Public Const SPCM_DIGMODE_CHREPLACE     As Integer = &HFFBBCFFF
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
Public Const SPC_PXITRG0_MODE           As Integer = 47300
Public Const SPC_PXITRG1_MODE           As Integer = 47301
Public Const SPC_PXITRG2_MODE           As Integer = 47302
Public Const SPC_PXITRG3_MODE           As Integer = 47303
Public Const SPC_PXITRG4_MODE           As Integer = 47304
Public Const SPC_PXITRG5_MODE           As Integer = 47305
Public Const SPC_PXITRG6_MODE           As Integer = 47306
Public Const SPC_PXITRG7_MODE           As Integer = 47307
Public Const SPC_PXISTAR_MODE           As Integer = 47308
Public Const SPC_PXIDSTARC_MODE         As Integer = 47309
Public Const SPC_PXITRG0_AVAILMODES     As Integer = 47310
Public Const SPC_PXITRG1_AVAILMODES     As Integer = 47311
Public Const SPC_PXITRG2_AVAILMODES     As Integer = 47312
Public Const SPC_PXITRG3_AVAILMODES     As Integer = 47313
Public Const SPC_PXITRG4_AVAILMODES     As Integer = 47314
Public Const SPC_PXITRG5_AVAILMODES     As Integer = 47315
Public Const SPC_PXITRG6_AVAILMODES     As Integer = 47316
Public Const SPC_PXITRG7_AVAILMODES     As Integer = 47317
Public Const SPC_PXISTAR_AVAILMODES     As Integer = 47318
Public Const SPC_PXIDSTARC_AVAILMODES   As Integer = 47319
Public Const SPC_PXITRG_ASYNCIO         As Integer = 47320          ' asynchronous in/out register
Public Const     SPCM_PXITRGMODE_DISABLE     As Integer = &H00000000
Public Const     SPCM_PXITRGMODE_IN          As Integer = &H00000001  ' used as input
Public Const     SPCM_PXITRGMODE_ASYNCOUT    As Integer = &H00000002  ' used as asynchronous output
Public Const     SPCM_PXITRGMODE_RUNSTATE    As Integer = &H00000004  ' shows the run state of the card (high = run)
Public Const     SPCM_PXITRGMODE_ARMSTATE    As Integer = &H00000008  ' shows the arm state (high = armed for trigger)
Public Const     SPCM_PXITRGMODE_TRIGOUT     As Integer = &H00000010  ' used as trigger output
Public Const     SPCM_PXITRGMODE_REFCLKOUT   As Integer = &H00000020  ' outputs PXI refclock (10 MHz)
Public Const     SPCM_PXITRGMODE_CONTOUTMARK As Integer = &H00000040  ' outputs a half posttrigger long HIGH pulse on replay


' ----- Star-Hub -----
' 48000 not usable

Public Const SPC_STARHUB_STATUS          As Integer = 48010

Public Const SPC_STARHUB_ROUTE0          As Integer = 48100  ' Routing Information for Test
Public Const SPC_STARHUB_ROUTE99         As Integer = 48199  ' ...


' Spcm driver (M2i, M3i, M4i, M4x, M2p) sync setup registers
Public Const SPC_SYNC_READ_SYNCCOUNT     As Integer = 48990  ' number of sync'd cards
Public Const SPC_SYNC_READ_NUMCONNECTORS As Integer = 48991  ' number of connectors on starhub

Public Const SPC_SYNC_READ_CARDIDX0      As Integer = 49000  ' read index of card at location 0 of sync
Public Const SPC_SYNC_READ_CARDIDX1      As Integer = 49001  ' ...
Public Const SPC_SYNC_READ_CARDIDX2      As Integer = 49002  ' ...
Public Const SPC_SYNC_READ_CARDIDX3      As Integer = 49003  ' ...
Public Const SPC_SYNC_READ_CARDIDX4      As Integer = 49004  ' ...
Public Const SPC_SYNC_READ_CARDIDX5      As Integer = 49005  ' ...
Public Const SPC_SYNC_READ_CARDIDX6      As Integer = 49006  ' ...
Public Const SPC_SYNC_READ_CARDIDX7      As Integer = 49007  ' ...
Public Const SPC_SYNC_READ_CARDIDX8      As Integer = 49008  ' ...
Public Const SPC_SYNC_READ_CARDIDX9      As Integer = 49009  ' ...
Public Const SPC_SYNC_READ_CARDIDX10     As Integer = 49010  ' ...
Public Const SPC_SYNC_READ_CARDIDX11     As Integer = 49011  ' ...
Public Const SPC_SYNC_READ_CARDIDX12     As Integer = 49012  ' ...
Public Const SPC_SYNC_READ_CARDIDX13     As Integer = 49013  ' ...
Public Const SPC_SYNC_READ_CARDIDX14     As Integer = 49014  ' ...
Public Const SPC_SYNC_READ_CARDIDX15     As Integer = 49015  ' ...

Public Const SPC_SYNC_READ_CABLECON0     As Integer = 49100  ' read cable connection of card at location 0 of sync
Public Const SPC_SYNC_READ_CABLECON1     As Integer = 49101  ' ...
Public Const SPC_SYNC_READ_CABLECON2     As Integer = 49102  ' ...
Public Const SPC_SYNC_READ_CABLECON3     As Integer = 49103  ' ...
Public Const SPC_SYNC_READ_CABLECON4     As Integer = 49104  ' ...
Public Const SPC_SYNC_READ_CABLECON5     As Integer = 49105  ' ...
Public Const SPC_SYNC_READ_CABLECON6     As Integer = 49106  ' ...
Public Const SPC_SYNC_READ_CABLECON7     As Integer = 49107  ' ...
Public Const SPC_SYNC_READ_CABLECON8     As Integer = 49108  ' ...
Public Const SPC_SYNC_READ_CABLECON9     As Integer = 49109  ' ...
Public Const SPC_SYNC_READ_CABLECON10    As Integer = 49110  ' ...
Public Const SPC_SYNC_READ_CABLECON11    As Integer = 49111  ' ...
Public Const SPC_SYNC_READ_CABLECON12    As Integer = 49112  ' ...
Public Const SPC_SYNC_READ_CABLECON13    As Integer = 49113  ' ...
Public Const SPC_SYNC_READ_CABLECON14    As Integer = 49114  ' ...
Public Const SPC_SYNC_READ_CABLECON15    As Integer = 49115  ' ...

Public Const SPC_SYNC_ENABLEMASK         As Integer = 49200  ' synchronisation enable (mask)
Public Const SPC_SYNC_NOTRIGSYNCMASK     As Integer = 49210  ' trigger disabled for sync (mask)
Public Const SPC_SYNC_CLKMASK            As Integer = 49220  ' clock master (mask)
Public Const SPC_SYNC_MODE               As Integer = 49230  ' synchronization mode
Public Const SPC_AVAILSYNC_MODES         As Integer = 49231  ' available synchronization modes
Public Const     SPC_SYNC_STANDARD         As Integer = &H00000001  ' starhub uses its own clock and trigger sources
Public Const     SPC_SYNC_SYSTEMCLOCK      As Integer = &H00000002  ' starhub uses own trigger sources and takes clock from system starhub
Public Const     SPC_SYNC_SYSTEMCLOCKTRIG  As Integer = &H00000004  ' starhub takes clock and trigger from system starhub (trigger sampled on rising  clock edge)
Public Const     SPC_SYNC_SYSTEMCLOCKTRIGN As Integer = &H00000008  ' starhub takes clock and trigger from system starhub (trigger sampled on falling clock edge)
Public Const SPC_SYNC_SYSTEM_TRIGADJUST  As Integer = 49240  ' Delay value for adjusting trigger position using system starhub


' ----- Gain and Offset Adjust DAC's -----
Public Const SPC_ADJ_START               As Integer = 50000

Public Const SPC_ADJ_LOAD                As Integer = 50000
Public Const SPC_ADJ_SAVE                As Integer = 50010
Public Const     ADJ_DEFAULT                 As Integer = 0
Public Const     ADJ_USER0                   As Integer = 1
Public Const     ADJ_USER1                   As Integer = 2
Public Const     ADJ_USER2                   As Integer = 3
Public Const     ADJ_USER3                   As Integer = 4
Public Const     ADJ_USER4                   As Integer = 5
Public Const     ADJ_USER5                   As Integer = 6
Public Const     ADJ_USER6                   As Integer = 7
Public Const     ADJ_USER7                   As Integer = 8

Public Const SPC_ADJ_AUTOADJ             As Integer = 50020
Public Const     ADJ_ALL                     As Integer = 0
Public Const     ADJ_CURRENT                 As Integer = 1
Public Const     ADJ_EXTERNAL                As Integer = 2
Public Const     ADJ_1MOHM                   As Integer = 3

Public Const     ADJ_CURRENT_CLOCK           As Integer = 4
Public Const     ADJ_CURRENT_IR              As Integer = 8
Public Const     ADJ_OFFSET_ONLY            As Integer = 16
Public Const     ADJ_SPECIAL_CLOCK          As Integer = 32

Public Const SPC_ADJ_SOURCE_CALLBACK     As Integer = 50021
Public Const SPC_ADJ_PROGRESS_CALLBACK   As Integer = 50022

Public Const SPC_ADJ_SET                 As Integer = 50030
Public Const SPC_ADJ_FAILMASK            As Integer = 50040

Public Const SPC_ADJ_CALIBSOURCE            As Integer = 50050
Public Const        ADJ_CALSRC_GAIN             As Integer = 1
Public Const        ADJ_CALSRC_OFF              As Integer = 0
Public Const        ADJ_CALSRC_GND             As Integer = -1
Public Const        ADJ_CALSRC_GNDOFFS         As Integer = -2
Public Const        ADJ_CALSRC_AC              As Integer = 10

Public Const SPC_ADJ_CALIBVALUE0            As Integer = 50060
Public Const SPC_ADJ_CALIBVALUE1            As Integer = 50061
Public Const SPC_ADJ_CALIBVALUE2            As Integer = 50062
Public Const SPC_ADJ_CALIBVALUE3            As Integer = 50063
Public Const SPC_ADJ_CALIBVALUE4            As Integer = 50064
Public Const SPC_ADJ_CALIBVALUE5            As Integer = 50065
Public Const SPC_ADJ_CALIBVALUE6            As Integer = 50066
Public Const SPC_ADJ_CALIBVALUE7            As Integer = 50067

Public Const SPC_ADJ_OFFSET_CH0          As Integer = 50900
Public Const SPC_ADJ_OFFSET_CH1          As Integer = 50901
Public Const SPC_ADJ_OFFSET_CH2          As Integer = 50902
Public Const SPC_ADJ_OFFSET_CH3          As Integer = 50903
Public Const SPC_ADJ_OFFSET_CH4          As Integer = 50904
Public Const SPC_ADJ_OFFSET_CH5          As Integer = 50905
Public Const SPC_ADJ_OFFSET_CH6          As Integer = 50906
Public Const SPC_ADJ_OFFSET_CH7          As Integer = 50907
Public Const SPC_ADJ_OFFSET_CH8          As Integer = 50908
Public Const SPC_ADJ_OFFSET_CH9          As Integer = 50909
Public Const SPC_ADJ_OFFSET_CH10         As Integer = 50910
Public Const SPC_ADJ_OFFSET_CH11         As Integer = 50911
Public Const SPC_ADJ_OFFSET_CH12         As Integer = 50912
Public Const SPC_ADJ_OFFSET_CH13         As Integer = 50913
Public Const SPC_ADJ_OFFSET_CH14         As Integer = 50914
Public Const SPC_ADJ_OFFSET_CH15         As Integer = 50915

Public Const SPC_ADJ_GAIN_CH0            As Integer = 50916
Public Const SPC_ADJ_GAIN_CH1            As Integer = 50917
Public Const SPC_ADJ_GAIN_CH2            As Integer = 50918
Public Const SPC_ADJ_GAIN_CH3            As Integer = 50919
Public Const SPC_ADJ_GAIN_CH4            As Integer = 50920
Public Const SPC_ADJ_GAIN_CH5            As Integer = 50921
Public Const SPC_ADJ_GAIN_CH6            As Integer = 50922
Public Const SPC_ADJ_GAIN_CH7            As Integer = 50923
Public Const SPC_ADJ_GAIN_CH8            As Integer = 50924
Public Const SPC_ADJ_GAIN_CH9            As Integer = 50925
Public Const SPC_ADJ_GAIN_CH10           As Integer = 50926
Public Const SPC_ADJ_GAIN_CH11           As Integer = 50927
Public Const SPC_ADJ_GAIN_CH12           As Integer = 50928
Public Const SPC_ADJ_GAIN_CH13           As Integer = 50929
Public Const SPC_ADJ_GAIN_CH14           As Integer = 50930
Public Const SPC_ADJ_GAIN_CH15           As Integer = 50931

Public Const SPC_ADJ_OFFSET0             As Integer = 51000
Public Const SPC_ADJ_OFFSET999           As Integer = 51999

Public Const SPC_ADJ_GAIN0               As Integer = 52000
Public Const SPC_ADJ_GAIN999             As Integer = 52999

Public Const SPC_ADJ_CORRECT0            As Integer = 53000
Public Const SPC_ADJ_OFFS_CORRECT0       As Integer = 53000
Public Const SPC_ADJ_CORRECT999          As Integer = 53999
Public Const SPC_ADJ_OFFS_CORRECT999     As Integer = 53999

Public Const SPC_ADJ_XIOOFFS0            As Integer = 54000
Public Const SPC_ADJ_XIOOFFS1            As Integer = 54001
Public Const SPC_ADJ_XIOOFFS2            As Integer = 54002
Public Const SPC_ADJ_XIOOFFS3            As Integer = 54003

Public Const SPC_ADJ_XIOGAIN0            As Integer = 54010
Public Const SPC_ADJ_XIOGAIN1            As Integer = 54011
Public Const SPC_ADJ_XIOGAIN2            As Integer = 54012
Public Const SPC_ADJ_XIOGAIN3            As Integer = 54013

Public Const SPC_ADJ_GAIN_CORRECT0       As Integer = 55000
Public Const SPC_ADJ_GAIN_CORRECT999     As Integer = 55999

Public Const SPC_ADJ_OFFSCALIBCORRECT0   As Integer = 56000
Public Const SPC_ADJ_OFFSCALIBCORRECT999 As Integer = 56999

Public Const SPC_ADJ_GAINCALIBCORRECT0   As Integer = 57000
Public Const SPC_ADJ_GAINCALIBCORRECT999 As Integer = 57999

Public Const SPC_ADJ_ANALOGTRIGGER0      As Integer = 58000
Public Const SPC_ADJ_ANALOGTRIGGER99     As Integer = 58099

Public Const SPC_ADJ_CALIBSAMPLERATE0    As Integer = 58100
Public Const SPC_ADJ_CALIBSAMPLERATE99   As Integer = 58199

Public Const SPC_ADJ_CALIBSAMPLERATE_GAIN0    As Integer = 58200
Public Const SPC_ADJ_CALIBSAMPLERATE_GAIN99   As Integer = 58299

Public Const SPC_ADJ_REFCLOCK            As Integer = 58300
Public Const SPC_ADJ_STARHUB_REFCLOCK    As Integer = 58301

Public Const SPC_ADJ_END                 As Integer = 59999



' ----- FIFO Control -----
Public Const SPC_FIFO_BUFFERS            As Integer = 60000          ' number of FIFO buffers
Public Const SPC_FIFO_BUFLEN             As Integer = 60010          ' len of each FIFO buffer
Public Const SPC_FIFO_BUFCOUNT           As Integer = 60020          ' number of FIFO buffers tranfered until now
Public Const SPC_FIFO_BUFMAXCNT          As Integer = 60030          ' number of FIFO buffers to be transfered (0=continuous)
Public Const SPC_FIFO_BUFADRCNT          As Integer = 60040          ' number of FIFO buffers allowed
Public Const SPC_FIFO_BUFREADY           As Integer = 60050          ' fifo buffer ready register (same as SPC_COMMAND + SPC_FIFO_BUFREADY0...)
Public Const SPC_FIFO_BUFFILLCNT         As Integer = 60060          ' number of currently filled buffers
Public Const SPC_FIFO_BUFADR0            As Integer = 60100          ' adress of FIFO buffer no. 0
Public Const SPC_FIFO_BUFADR1            As Integer = 60101          ' ...
Public Const SPC_FIFO_BUFADR2            As Integer = 60102          ' ...
Public Const SPC_FIFO_BUFADR3            As Integer = 60103          ' ...
Public Const SPC_FIFO_BUFADR4            As Integer = 60104          ' ...
Public Const SPC_FIFO_BUFADR5            As Integer = 60105          ' ...
Public Const SPC_FIFO_BUFADR6            As Integer = 60106          ' ...
Public Const SPC_FIFO_BUFADR7            As Integer = 60107          ' ...
Public Const SPC_FIFO_BUFADR8            As Integer = 60108          ' ...
Public Const SPC_FIFO_BUFADR9            As Integer = 60109          ' ...
Public Const SPC_FIFO_BUFADR10           As Integer = 60110          ' ...
Public Const SPC_FIFO_BUFADR11           As Integer = 60111          ' ...
Public Const SPC_FIFO_BUFADR12           As Integer = 60112          ' ...
Public Const SPC_FIFO_BUFADR13           As Integer = 60113          ' ...
Public Const SPC_FIFO_BUFADR14           As Integer = 60114          ' ...
Public Const SPC_FIFO_BUFADR15           As Integer = 60115          ' ...
Public Const SPC_FIFO_BUFADR255          As Integer = 60355          ' last



' ----- Filter -----
Public Const SPC_FILTER                  As Integer = 100000
Public Const SPC_READNUMFILTERS          As Integer = 100001         ' number of programable filters
Public Const SPC_FILTERFREQUENCY0        As Integer = 100002         ' frequency of filter 0 (bypass)
Public Const SPC_FILTERFREQUENCY1        As Integer = 100003         ' frequency of filter 1
Public Const SPC_FILTERFREQUENCY2        As Integer = 100004         ' frequency of filter 2
Public Const SPC_FILTERFREQUENCY3        As Integer = 100005         ' frequency of filter 3
Public Const SPC_DIGITALBWFILTER         As Integer = 100100         ' enable/disable digital bandwith filter


' ----- Pattern -----
Public Const SPC_PATTERNENABLE           As Integer = 110000
Public Const SPC_READDIGITAL             As Integer = 110100

Public Const SPC_DIGITALMODE0            As Integer = 110200
Public Const SPC_DIGITALMODE1            As Integer = 110201
Public Const SPC_DIGITALMODE2            As Integer = 110202
Public Const SPC_DIGITALMODE3            As Integer = 110203
Public Const SPC_DIGITALMODE4            As Integer = 110204
Public Const SPC_DIGITALMODE5            As Integer = 110205
Public Const SPC_DIGITALMODE6            As Integer = 110206
Public Const SPC_DIGITALMODE7            As Integer = 110207
Public Const     SPC_DIGITALMODE_OFF         As Integer = 0
Public Const     SPC_DIGITALMODE_2BIT        As Integer = 1
Public Const     SPC_DIGITALMODE_4BIT        As Integer = 2
Public Const     SPC_DIGITALMODE_CHREPLACE   As Integer = 3


' ----- Miscellanous -----
Public Const SPC_MISCDAC0                As Integer = 200000
Public Const SPC_MISCDAC1                As Integer = 200010
Public Const SPC_FACTORYMODE             As Integer = 200020
Public Const SPC_DIRECTDAC               As Integer = 200030
Public Const SPC_NOTRIGSYNC              As Integer = 200040
Public Const SPC_DSPDIRECT               As Integer = 200100
Public Const SPC_DMAPHYSICALADR          As Integer = 200110
Public Const SPC_MICXCOMP_CLOSEBOARD     As Integer = 200119
Public Const SPC_MICXCOMPATIBILITYMODE   As Integer = 200120
Public Const SPC_TEST_FIFOSPEED          As Integer = 200121
Public Const SPC_RELOADDEMO              As Integer = 200122
Public Const SPC_OVERSAMPLINGFACTOR      As Integer = 200123
Public Const SPC_ISMAPPEDCARD            As Integer = 200124
Public Const     SPCM_NOT_MAPPED             As Integer = 0
Public Const     SPCM_LOCAL_MAPPED           As Integer = 1
Public Const     SPCM_REMOTE_MAPPED          As Integer = 2
Public Const SPC_GETTHREADHANDLE         As Integer = 200130
Public Const SPC_GETKERNELHANDLE         As Integer = 200131
Public Const SPC_XYZMODE                 As Integer = 200200
Public Const SPC_INVERTDATA              As Integer = 200300
Public Const SPC_GATEMARKENABLE          As Integer = 200400
Public Const SPC_GATE_LEN_ALIGNMENT      As Integer = 200401
Public Const SPC_CONTOUTMARK             As Integer = 200450
Public Const SPC_EXPANDINT32             As Integer = 200500
Public Const SPC_NOPRETRIGGER            As Integer = 200600
Public Const SPC_RELAISWAITTIME          As Integer = 200700
Public Const SPC_DACWAITTIME             As Integer = 200710
Public Const SPC_DELAY_US                As Integer = 200720
Public Const SPC_ILAMODE                 As Integer = 200800
Public Const SPC_NMDGMODE                As Integer = 200810
Public Const SPC_CKADHALF_OUTPUT         As Integer = 200820
Public Const SPC_LONGTRIG_OUTPUT         As Integer = 200830
Public Const SPC_STOREMODAENDOFSEGMENT   As Integer = 200840
Public Const SPC_COUNTERMODE             As Integer = 200850
Public Const     SPC_CNTMOD_MASK             As Integer = &H0000000F
Public Const     SPC_CNTMOD_PARALLELDATA     As Integer = &H00000000
Public Const     SPC_CNTMOD_8BITCNT          As Integer = &H00000001
Public Const     SPC_CNTMOD_2x8BITCNT        As Integer = &H00000002
Public Const     SPC_CNTMOD_16BITCNT         As Integer = &H00000003
Public Const     SPC_CNT0_MASK               As Integer = &H000000F0
Public Const     SPC_CNT0_CNTONPOSEDGE       As Integer = &H00000000
Public Const     SPC_CNT0_CNTONNEGEDGE       As Integer = &H00000010
Public Const     SPC_CNT0_RESETHIGHLVL       As Integer = &H00000000
Public Const     SPC_CNT0_RESETLOWLVL        As Integer = &H00000020
Public Const     SPC_CNT0_STOPATMAX          As Integer = &H00000000
Public Const     SPC_CNT0_ROLLOVER           As Integer = &H00000040
Public Const     SPC_CNT1_MASK               As Integer = &H00000F00
Public Const     SPC_CNT1_CNTONPOSEDGE       As Integer = &H00000000
Public Const     SPC_CNT1_CNTONNEGEDGE       As Integer = &H00000100
Public Const     SPC_CNT1_RESETHIGHLVL       As Integer = &H00000000
Public Const     SPC_CNT1_RESETLOWLVL        As Integer = &H00000200
Public Const     SPC_CNT1_STOPATMAX          As Integer = &H00000000
Public Const     SPC_CNT1_ROLLOVER           As Integer = &H00000400
Public Const     SPC_CNTCMD_MASK             As Integer = &H0000F000
Public Const     SPC_CNTCMD_RESETCNT0        As Integer = &H00001000
Public Const     SPC_CNTCMD_RESETCNT1        As Integer = &H00002000
Public Const SPC_ENHANCEDSTATUS          As Integer = 200900
Public Const     SPC_ENHSTAT_OVERRANGE0      As Integer = &H00000001
Public Const     SPC_ENHSTAT_OVERRANGE1      As Integer = &H00000002
Public Const     SPC_ENHSTAT_OVERRANGE2      As Integer = &H00000004
Public Const     SPC_ENHSTAT_OVERRANGE3      As Integer = &H00000008
Public Const     SPC_ENHSTAT_OVERRANGE4      As Integer = &H00000010
Public Const     SPC_ENHSTAT_OVERRANGE5      As Integer = &H00000020
Public Const     SPC_ENHSTAT_OVERRANGE6      As Integer = &H00000040
Public Const     SPC_ENHSTAT_OVERRANGE7      As Integer = &H00000080
Public Const     SPC_ENHSTAT_COMPARATOR0     As Integer = &H40000000
Public Const     SPC_ENHSTAT_COMPARATOR1     As Integer = &H80000000
Public Const     SPC_ENHSTAT_COMPARATOR2     As Integer = &H20000000
Public Const     SPC_ENHSTAT_TRGCOMPARATOR   As Integer = &H40000000
Public Const     SPC_ENHSTAT_CLKCOMPARATOR   As Integer = &H80000000
Public Const SPC_TRIGGERCOUNTER          As Integer = 200905
Public Const SPC_FILLSIZEPROMILLE        As Integer = 200910
Public Const SPC_OVERRANGEBIT            As Integer = 201000
Public Const SPC_2CH8BITMODE             As Integer = 201100
Public Const SPC_12BITMODE               As Integer = 201200
Public Const SPC_HOLDLASTSAMPLE          As Integer = 201300

Public Const SPC_DATACONVERSION          As Integer = 201400
Public Const SPC_AVAILDATACONVERSION     As Integer = 201401
Public Const     SPCM_DC_NONE            As Integer = &H00000000
Public Const     SPCM_DC_12BIT_TO_14BIT  As Integer = &H00000001
Public Const     SPCM_DC_16BIT_TO_14BIT  As Integer = &H00000002
Public Const     SPCM_DC_12BIT_TO_16BIT  As Integer = &H00000004
Public Const     SPCM_DC_14BIT_TO_16BIT  As Integer = &H00000008
Public Const     SPCM_DC_15BIT_TO_16BIT  As Integer = &H00000010
Public Const     SPCM_DC_13BIT_TO_16BIT  As Integer = &H00000020
Public Const     SPCM_DC_14BIT_TO_8BIT   As Integer = &H00000100
Public Const     SPCM_DC_16BIT_TO_8BIT   As Integer = &H00000200
Public Const     SPCM_DC_16BIT_TO_12BIT  As Integer = &H00000400
Public Const     SPCM_DC_TO_OFFSETBINARY As Integer = &H00000800

Public Const SPC_CARDIDENTIFICATION      As Integer = 201500

Public Const SPC_HANDSHAKE               As Integer = 201600

Public Const SPC_CKSYNC0                 As Integer = 202000
Public Const SPC_CKSYNC1                 As Integer = 202001
Public Const SPC_DISABLEMOD0             As Integer = 203000
Public Const SPC_DISABLEMOD1             As Integer = 203010
Public Const SPC_ENABLEOVERRANGECHECK    As Integer = 204000
Public Const SPC_OVERRANGESTATUS         As Integer = 204010
Public Const SPC_BITMODE                 As Integer = 205000

Public Const SPC_READBACK                As Integer = 206000
Public Const SPC_AVAILSTOPLEVEL          As Integer = 206009
Public Const SPC_STOPLEVEL1              As Integer = 206010
Public Const SPC_STOPLEVEL0              As Integer = 206020
Public Const SPC_CH0_STOPLEVEL           As Integer = 206020
Public Const SPC_CH1_STOPLEVEL           As Integer = 206021
Public Const SPC_CH2_STOPLEVEL           As Integer = 206022
Public Const SPC_CH3_STOPLEVEL           As Integer = 206023
Public Const SPC_CH4_STOPLEVEL           As Integer = 206024
Public Const SPC_CH5_STOPLEVEL           As Integer = 206025
Public Const SPC_CH6_STOPLEVEL           As Integer = 206026
Public Const SPC_CH7_STOPLEVEL           As Integer = 206027
Public Const     SPCM_STOPLVL_TRISTATE   As Integer = &H00000001
Public Const     SPCM_STOPLVL_LOW        As Integer = &H00000002
Public Const     SPCM_STOPLVL_HIGH       As Integer = &H00000004
Public Const     SPCM_STOPLVL_HOLDLAST   As Integer = &H00000008
Public Const     SPCM_STOPLVL_ZERO       As Integer = &H00000010
Public Const     SPCM_STOPLVL_CUSTOM     As Integer = &H00000020

Public Const SPC_DIFFMODE                As Integer = 206030
Public Const SPC_DACADJUST               As Integer = 206040

Public Const SPC_CH0_CUSTOM_STOP         As Integer = 206050
Public Const SPC_CH1_CUSTOM_STOP         As Integer = 206051
Public Const SPC_CH2_CUSTOM_STOP         As Integer = 206052
Public Const SPC_CH3_CUSTOM_STOP         As Integer = 206053
Public Const SPC_CH4_CUSTOM_STOP         As Integer = 206054
Public Const SPC_CH5_CUSTOM_STOP         As Integer = 206055
Public Const SPC_CH6_CUSTOM_STOP         As Integer = 206056
Public Const SPC_CH7_CUSTOM_STOP         As Integer = 206057

Public Const SPC_AMP_MODE                As Integer = 207000

Public Const SPCM_FW_CTRL                As Integer = 210000
Public Const SPCM_FW_CTRL_GOLDEN         As Integer = 210001
Public Const SPCM_FW_CTRL_ACTIVE         As Integer = 210002
Public Const SPCM_FW_CLOCK               As Integer = 210010
Public Const SPCM_FW_CONFIG              As Integer = 210020
Public Const SPCM_FW_MODULEA             As Integer = 210030
Public Const SPCM_FW_MODULEB             As Integer = 210031
Public Const SPCM_FW_MODULEA_ACTIVE      As Integer = 210032
Public Const SPCM_FW_MODULEB_ACTIVE      As Integer = 210033
Public Const SPCM_FW_MODEXTRA            As Integer = 210050
Public Const SPCM_FW_MODEXTRA_ACTIVE     As Integer = 210052
Public Const SPCM_FW_POWER               As Integer = 210060
Public Const SPCM_FW_POWER_ACTIVE        As Integer = 210062

Public Const SPC_MULTI                   As Integer = 220000
Public Const SPC_DOUBLEMEM               As Integer = 220100
Public Const SPC_MULTIMEMVALID           As Integer = 220200
Public Const SPC_BANK                    As Integer = 220300
Public Const SPC_GATE                    As Integer = 220400
Public Const SPC_RELOAD                  As Integer = 230000
Public Const SPC_USEROUT                 As Integer = 230010
Public Const SPC_WRITEUSER0              As Integer = 230100
Public Const SPC_WRITEUSER1              As Integer = 230110
Public Const SPC_READUSER0               As Integer = 230200
Public Const SPC_READUSER1               As Integer = 230210
Public Const SPC_MUX                     As Integer = 240000
Public Const SPC_ADJADC                  As Integer = 241000
Public Const SPC_ADJOFFS0                As Integer = 242000
Public Const SPC_ADJOFFS1                As Integer = 243000
Public Const SPC_ADJGAIN0                As Integer = 244000
Public Const SPC_ADJGAIN1                As Integer = 245000
Public Const SPC_READEPROM               As Integer = 250000
Public Const SPC_WRITEEPROM              As Integer = 250010
Public Const SPC_DIRECTIO                As Integer = 260000
Public Const SPC_DIRECT_MODA             As Integer = 260010
Public Const SPC_DIRECT_MODB             As Integer = 260020
Public Const SPC_DIRECT_EXT0             As Integer = 260030
Public Const SPC_DIRECT_EXT1             As Integer = 260031
Public Const SPC_DIRECT_EXT2             As Integer = 260032
Public Const SPC_DIRECT_EXT3             As Integer = 260033
Public Const SPC_DIRECT_EXT4             As Integer = 260034
Public Const SPC_DIRECT_EXT5             As Integer = 260035
Public Const SPC_DIRECT_EXT6             As Integer = 260036
Public Const SPC_DIRECT_EXT7             As Integer = 260037
Public Const SPC_MEMTEST                 As Integer = 270000
Public Const SPC_NODMA                   As Integer = 275000
Public Const SPC_NOCOUNTER               As Integer = 275010
Public Const SPC_NOSCATTERGATHER         As Integer = 275020
Public Const SPC_USER_RELAIS_OVERWRITE   As Integer = 275030
Public Const     SPCM_URO_ENABLE             As Integer = &H80000000
Public Const     SPCM_URO_INVERT_10TO1REL    As Integer = &H00000001
Public Const SPC_RUNINTENABLE            As Integer = 290000
Public Const SPC_XFERBUFSIZE             As Integer = 295000
Public Const SPC_CHLX                    As Integer = 295010
Public Const SPC_SPECIALCLOCK            As Integer = 295100
Public Const SPC_PLL0_ICP                As Integer = 295105
Public Const     SPCM_ICP0            As Integer = &H00000000
' ...
Public Const     SPCM_ICP7            As Integer = &H00000007
Public Const SPC_STARTDELAY              As Integer = 295110
Public Const SPC_BASISTTLTRIG            As Integer = 295120
Public Const SPC_TIMEOUT                 As Integer = 295130
Public Const SPC_SWL_INFO                As Integer = 295140
Public Const SPC_SWD_INFO                As Integer = 295141
Public Const SPC_SWD_DOWN                As Integer = 295142
Public Const SPC_SWL_EXTRAINFO           As Integer = 295143
Public Const SPC_SPECIALCLOCK_ADJUST0    As Integer = 295150
Public Const SPC_SPECIALCLOCK_ADJUST1    As Integer = 295151
Public Const SPC_SPECIALCLOCK_ADJUST2    As Integer = 295152
Public Const SPC_SPECIALCLOCK_ADJUST3    As Integer = 295153
Public Const    SPCM_SPECIALCLOCK_ADJUST_SHIFT As Integer = 1000000
Public Const SPC_REGACC_CONTMEM          As Integer = 299000
Public Const SPC_REGACC_MEMORYUSAGE      As Integer = 299001
Public Const SPC_REINITLOGSETTINGS       As Integer = 299998
Public Const SPC_LOGDLLCALLS             As Integer = 299999






' ----- PCK400 -----
Public Const SPC_FREQUENCE               As Integer = 300000
Public Const SPC_DELTAFREQUENCE          As Integer = 300010
Public Const SPC_PINHIGH                 As Integer = 300100
Public Const SPC_PINLOW                  As Integer = 300110
Public Const SPC_PINDELTA                As Integer = 300120
Public Const SPC_STOPLEVEL               As Integer = 300200
Public Const SPC_PINRELAIS               As Integer = 300210
Public Const SPC_EXTERNLEVEL             As Integer = 300300



' ----- PADCO -----
Public Const SPC_COUNTER0                As Integer = 310000
Public Const SPC_COUNTER1                As Integer = 310001
Public Const SPC_COUNTER2                As Integer = 310002
Public Const SPC_COUNTER3                As Integer = 310003
Public Const SPC_COUNTER4                As Integer = 310004
Public Const SPC_COUNTER5                As Integer = 310005
Public Const SPC_MODE0                   As Integer = 310100
Public Const SPC_MODE1                   As Integer = 310101
Public Const SPC_MODE2                   As Integer = 310102
Public Const SPC_MODE3                   As Integer = 310103
Public Const SPC_MODE4                   As Integer = 310104
Public Const SPC_MODE5                   As Integer = 310105
Public Const     CM_SINGLE                   As Integer = 1
Public Const     CM_MULTI                    As Integer = 2
Public Const     CM_POSEDGE                  As Integer = 4
Public Const     CM_NEGEDGE                  As Integer = 8
Public Const     CM_HIGHPULSE                As Integer = 16
Public Const     CM_LOWPULSE                 As Integer = 32



' ----- PAD1616 -----
Public Const SPC_SEQUENCERESET           As Integer = 320000
Public Const SPC_SEQUENCEADD             As Integer = 320010
Public Const     SEQ_IR_10000MV              As Integer = 0
Public Const     SEQ_IR_5000MV               As Integer = 1
Public Const     SEQ_IR_2000MV               As Integer = 2
Public Const     SEQ_IR_1000MV               As Integer = 3
Public Const     SEQ_IR_500MV                As Integer = 4
Public Const     SEQ_CH0                     As Integer = 0
Public Const     SEQ_CH1                     As Integer = 8
Public Const     SEQ_CH2                     As Integer = 16
Public Const     SEQ_CH3                     As Integer = 24
Public Const     SEQ_CH4                     As Integer = 32
Public Const     SEQ_CH5                     As Integer = 40
Public Const     SEQ_CH6                     As Integer = 48
Public Const     SEQ_CH7                     As Integer = 56
Public Const     SEQ_CH8                     As Integer = 64
Public Const     SEQ_CH9                     As Integer = 72
Public Const     SEQ_CH10                    As Integer = 80
Public Const     SEQ_CH11                    As Integer = 88
Public Const     SEQ_CH12                    As Integer = 96
Public Const     SEQ_CH13                    As Integer = 104
Public Const     SEQ_CH14                    As Integer = 112
Public Const     SEQ_CH15                    As Integer = 120
Public Const     SEQ_TRIGGER                 As Integer = 128
Public Const     SEQ_START                   As Integer = 256



' ----- Option CA -----
Public Const SPC_CA_MODE                 As Integer = 330000
Public Const     CAMODE_OFF                  As Integer = 0
Public Const     CAMODE_CDM                  As Integer = 1
Public Const     CAMODE_KW                   As Integer = 2
Public Const     CAMODE_OT                   As Integer = 3
Public Const     CAMODE_CDMMUL               As Integer = 4
Public Const SPC_CA_TRIGDELAY            As Integer = 330010
Public Const SPC_CA_CKDIV                As Integer = 330020
Public Const SPC_CA_PULS                 As Integer = 330030
Public Const SPC_CA_CKMUL                As Integer = 330040
Public Const SPC_CA_DREHZAHLFORMAT       As Integer = 330050
Public Const     CADREH_4X4                  As Integer = 0
Public Const     CADREH_1X16                 As Integer = 1
Public Const SPC_CA_KWINVERT             As Integer = 330060
Public Const SPC_CA_OUTA                 As Integer = 330100
Public Const SPC_CA_OUTB                 As Integer = 330110
Public Const     CAOUT_TRISTATE              As Integer = 0
Public Const     CAOUT_LOW                   As Integer = 1
Public Const     CAOUT_HIGH                  As Integer = 2
Public Const     CAOUT_CDM                   As Integer = 3
Public Const     CAOUT_OT                    As Integer = 4
Public Const     CAOUT_KW                    As Integer = 5
Public Const     CAOUT_TRIG                  As Integer = 6
Public Const     CAOUT_CLK                   As Integer = 7
Public Const     CAOUT_KW60                  As Integer = 8
Public Const     CAOUT_KWGAP                 As Integer = 9
Public Const     CAOUT_TRDLY                 As Integer = 10
Public Const     CAOUT_INVERT                As Integer = 16


' ----- Option Sequence Mode (output cards) -----
Public Const SPC_SEQMODE_STEPMEM0        As Integer = 340000
' ... 
Public Const SPC_SEQMODE_STEPMEM8191     As Integer = 348191

' low part of 64 bit entry
Public Const     SPCSEQ_SEGMENTMASK      As Integer = &H0000FFFF
Public Const     SPCSEQ_NEXTSTEPMASK     As Integer = &HFFFF0000

' high part of 64 bit entry
Public Const     SPCSEQ_LOOPMASK         As Integer = &H000FFFFF
Public Const     SPCSEQ_ENDLOOPALWAYS    As Integer = &H00000000
Public Const     SPCSEQ_ENDLOOPONTRIG    As Integer = &H40000000
Public Const     SPCSEQ_END              As Integer = &H80000000

Public Const SPC_SEQMODE_AVAILMAXSEGMENT As Integer = 349900
Public Const SPC_SEQMODE_AVAILMAXSTEPS   As Integer = 349901
Public Const SPC_SEQMODE_AVAILMAXLOOP    As Integer = 349902
Public Const SPC_SEQMODE_AVAILFEATURES   As Integer = 349903

Public Const SPC_SEQMODE_MAXSEGMENTS     As Integer = 349910
Public Const SPC_SEQMODE_WRITESEGMENT    As Integer = 349920
Public Const SPC_SEQMODE_STARTSTEP       As Integer = 349930
Public Const SPC_SEQMODE_SEGMENTSIZE     As Integer = 349940

Public Const SPC_SEQMODE_STATUS          As Integer = 349950
Public Const     SEQSTAT_STEPCHANGE          As Integer = &H80000000


' ----- netbox registers -----
Public Const SPC_NETBOX_TYPE             As Integer = 400000
Public Const     NETBOX_SERIES_MASK      As Integer = &HFF000000
Public Const     NETBOX_FAMILY_MASK      As Integer = &H00FF0000
Public Const     NETBOX_SPEED_MASK       As Integer = &H0000FF00
Public Const     NETBOX_CHANNEL_MASK     As Integer = &H000000FF

Public Const     NETBOX_SERIES_DN2       As Integer = &H02000000
Public Const     NETBOX_SERIES_DN6       As Integer = &H06000000

Public Const     NETBOX_FAMILY_20        As Integer = &H00200000
Public Const     NETBOX_FAMILY_22        As Integer = &H00220000
Public Const     NETBOX_FAMILY_44        As Integer = &H00440000
Public Const     NETBOX_FAMILY_46        As Integer = &H00460000
Public Const     NETBOX_FAMILY_47        As Integer = &H00470000
Public Const     NETBOX_FAMILY_48        As Integer = &H00480000
Public Const     NETBOX_FAMILY_49        As Integer = &H00490000
Public Const     NETBOX_FAMILY_59        As Integer = &H00590000
Public Const     NETBOX_FAMILY_60        As Integer = &H00600000
Public Const     NETBOX_FAMILY_65        As Integer = &H00650000
Public Const     NETBOX_FAMILY_66        As Integer = &H00660000
Public Const     NETBOX_FAMILY_8X        As Integer = &H00800000
Public Const     NETBOX_FAMILY_80        As Integer = &H00800000
Public Const     NETBOX_FAMILY_81        As Integer = &H00810000
Public Const     NETBOX_FAMILY_82        As Integer = &H00820000
Public Const     NETBOX_FAMILY_83        As Integer = &H00830000

Public Const     NETBOX_SPEED_1          As Integer = &H00000100
Public Const     NETBOX_SPEED_2          As Integer = &H00000200
Public Const     NETBOX_SPEED_3          As Integer = &H00000300
Public Const     NETBOX_SPEED_4          As Integer = &H00000400
Public Const     NETBOX_SPEED_5          As Integer = &H00000500
Public Const     NETBOX_SPEED_6          As Integer = &H00000600
Public Const     NETBOX_SPEED_7          As Integer = &H00000700
Public Const     NETBOX_SPEED_8          As Integer = &H00000800

Public Const     NETBOX_CHANNELS_2       As Integer = &H00000002
Public Const     NETBOX_CHANNELS_4       As Integer = &H00000004
Public Const     NETBOX_CHANNELS_6       As Integer = &H00000006
Public Const     NETBOX_CHANNELS_8       As Integer = &H00000008
Public Const     NETBOX_CHANNELS_10      As Integer = &H0000000A
Public Const     NETBOX_CHANNELS_12      As Integer = &H0000000C
Public Const     NETBOX_CHANNELS_16      As Integer = &H00000010
Public Const     NETBOX_CHANNELS_20      As Integer = &H00000014
Public Const     NETBOX_CHANNELS_24      As Integer = &H00000018
Public Const     NETBOX_CHANNELS_32      As Integer = &H00000020
Public Const     NETBOX_CHANNELS_40      As Integer = &H00000028
Public Const     NETBOX_CHANNELS_48      As Integer = &H00000030

Public Const SPC_NETBOX_SERIALNO         As Integer = 400001
Public Const SPC_NETBOX_PRODUCTIONDATE   As Integer = 400002
Public Const SPC_NETBOX_HWVERSION        As Integer = 400003
Public Const SPC_NETBOX_SWVERSION        As Integer = 400004

Public Const SPC_NETBOX_FEATURES         As Integer = 400005
Public Const     NETBOX_FEAT_DCPOWER         As Integer = &H1
Public Const     NETBOX_FEAT_BOOTATPOWERON   As Integer = &H2
Public Const     NETBOX_FEAT_EMBEDDEDSERVER  As Integer = &H4

Public Const SPC_NETBOX_CUSTOM           As Integer = 400006

Public Const SPC_NETBOX_WAKEONLAN        As Integer = 400007
Public Const SPC_NETBOX_MACADDRESS       As Integer = 400008
Public Const SPC_NETBOX_LANIDFLASH       As Integer = 400009
Public Const SPC_NETBOX_TEMPERATURE      As Integer = 400010
Public Const SPC_NETBOX_SHUTDOWN         As Integer = 400011
Public Const SPC_NETBOX_RESTART          As Integer = 400012
Public Const SPC_NETBOX_FANSPEED0        As Integer = 400013
Public Const SPC_NETBOX_FANSPEED1        As Integer = 400014
Public Const SPC_NETBOX_TEMPERATURE_K    As Integer = 400010 ' same SPC_NETBOX_TEMPERATURE
Public Const SPC_NETBOX_TEMPERATURE_C    As Integer = 400015
Public Const SPC_NETBOX_TEMPERATURE_F    As Integer = 400016

' ----- hardware monitor registers -----
Public Const SPC_MON_V_PCIE_BUS          As Integer = 500000
Public Const SPC_MON_V_CONNECTOR         As Integer = 500001
Public Const SPC_MON_CARD_PWRSOURCE      As Integer = 500002
Public Const     CARD_PWRSOURCE_BUS          As Integer = 0
Public Const     CARD_PWRSOURCE_CONNECTOR    As Integer = 1
Public Const SPC_MON_V_CARD_IN           As Integer = 500003
Public Const SPC_MON_I_CARD_IN           As Integer = 500004
Public Const SPC_MON_P_CARD_IN           As Integer = 500005
Public Const SPC_MON_V_3V3               As Integer = 500006
Public Const SPC_MON_V_2V5               As Integer = 500007
Public Const SPC_MON_V_CORE              As Integer = 500008
Public Const SPC_MON_V_AVTT              As Integer = 500009
Public Const SPC_MON_V_AVCC              As Integer = 500010
Public Const SPC_MON_V_MEMVCC            As Integer = 500011
Public Const SPC_MON_V_MEMVTT            As Integer = 500012
Public Const SPC_MON_V_CP_POS            As Integer = 500013
Public Const SPC_MON_V_CP_NEG            As Integer = 500014

Public Const SPC_MON_V_5VA               As Integer = 500015
Public Const SPC_MON_V_ADCA              As Integer = 500016
Public Const SPC_MON_V_ADCD              As Integer = 500017
Public Const SPC_MON_V_OP_POS            As Integer = 500018
Public Const SPC_MON_V_OP_NEG            As Integer = 500019
Public Const SPC_MON_V_COMP_NEG          As Integer = 500020
Public Const SPC_MON_V_COMP_POS          As Integer = 500021

' legacy temperature registers (Kelvin)
Public Const SPC_MON_T_BASE_CTRL         As Integer = 500022
Public Const SPC_MON_T_MODULE_0          As Integer = 500023
Public Const SPC_MON_T_MODULE_1          As Integer = 500024

' new temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF)
Public Const SPC_MON_TK_BASE_CTRL         As Integer = 500022
Public Const SPC_MON_TK_MODULE_0          As Integer = 500023
Public Const SPC_MON_TK_MODULE_1          As Integer = 500024

Public Const SPC_MON_TC_BASE_CTRL         As Integer = 500025
Public Const SPC_MON_TC_MODULE_0          As Integer = 500026
Public Const SPC_MON_TC_MODULE_1          As Integer = 500027

Public Const SPC_MON_TF_BASE_CTRL         As Integer = 500028
Public Const SPC_MON_TF_MODULE_0          As Integer = 500029
Public Const SPC_MON_TF_MODULE_1          As Integer = 500030

' some more voltages (used on M2p)
Public Const SPC_MON_V_1V8_BASE           As Integer = 500031
Public Const SPC_MON_V_1V8_MOD            As Integer = 500032
Public Const SPC_MON_V_MODA_0             As Integer = 500033
Public Const SPC_MON_V_MODA_1             As Integer = 500034
Public Const SPC_MON_V_MODB_0             As Integer = 500035
Public Const SPC_MON_V_MODB_1             As Integer = 500037

' some more voltages and temperatures (used on M2p.65xx-hv)
Public Const SPC_MON_TK_MODA_0           As Integer = 500023 ' same as SPC_MON_TK_MODULE_0
Public Const SPC_MON_TK_MODA_1           As Integer = 500038
Public Const SPC_MON_TK_MODA_2           As Integer = 500039
Public Const SPC_MON_TK_MODA_3           As Integer = 500040
Public Const SPC_MON_TK_MODA_4           As Integer = 500041
Public Const SPC_MON_TK_MODB_0           As Integer = 500024 ' same as SPC_MON_TK_MODULE_1
Public Const SPC_MON_TK_MODB_1           As Integer = 500042
Public Const SPC_MON_TK_MODB_2           As Integer = 500043
Public Const SPC_MON_TK_MODB_3           As Integer = 500044
Public Const SPC_MON_TK_MODB_4           As Integer = 500045

Public Const SPC_MON_TC_MODA_0           As Integer = 500026 ' same as SPC_MON_TC_MODULE_0
Public Const SPC_MON_TC_MODA_1           As Integer = 500046
Public Const SPC_MON_TC_MODA_2           As Integer = 500047
Public Const SPC_MON_TC_MODA_3           As Integer = 500048
Public Const SPC_MON_TC_MODA_4           As Integer = 500049
Public Const SPC_MON_TC_MODB_0           As Integer = 500027 ' same as SPC_MON_TC_MODULE_1
Public Const SPC_MON_TC_MODB_1           As Integer = 500050
Public Const SPC_MON_TC_MODB_2           As Integer = 500051
Public Const SPC_MON_TC_MODB_3           As Integer = 500052
Public Const SPC_MON_TC_MODB_4           As Integer = 500053

Public Const SPC_MON_TF_MODA_0           As Integer = 500029 ' same as SPC_MON_TF_MODULE_0
Public Const SPC_MON_TF_MODA_1           As Integer = 500054
Public Const SPC_MON_TF_MODA_2           As Integer = 500055
Public Const SPC_MON_TF_MODA_3           As Integer = 500056
Public Const SPC_MON_TF_MODA_4           As Integer = 500057
Public Const SPC_MON_TF_MODB_0           As Integer = 500030 ' same as SPC_MON_TF_MODULE_1
Public Const SPC_MON_TF_MODB_1           As Integer = 500058
Public Const SPC_MON_TF_MODB_2           As Integer = 500059
Public Const SPC_MON_TF_MODB_3           As Integer = 500060
Public Const SPC_MON_TF_MODB_4           As Integer = 500061

Public Const SPC_MON_I_MODA_0            As Integer = 500062
Public Const SPC_MON_I_MODA_1            As Integer = 500063
Public Const SPC_MON_I_MODA_2            As Integer = 500064
Public Const SPC_MON_I_MODA_3            As Integer = 500065
Public Const SPC_MON_I_MODB_0            As Integer = 500066
Public Const SPC_MON_I_MODB_1            As Integer = 500067
Public Const SPC_MON_I_MODB_2            As Integer = 500068
Public Const SPC_MON_I_MODB_3            As Integer = 500069

Public Const SPC_MON_MOD_FAULT           As Integer = 500070
Public Const SPC_CLR_MOD_FAULT           As Integer = 500071

' power section temperature registers for Kelvin (TK), Celsius (TC) or Fahrenheit (TF)
Public Const SPC_MON_TK_MODA_5           As Integer = 500072
Public Const SPC_MON_TK_MODB_5           As Integer = 500073

Public Const SPC_MON_TC_MODA_5           As Integer = 500074
Public Const SPC_MON_TC_MODB_5           As Integer = 500075

Public Const SPC_MON_TF_MODA_5           As Integer = 500076
Public Const SPC_MON_TF_MODB_5           As Integer = 500077

' mask with available monitor registers
Public Const SPC_AVAILMONITORS            As Integer = 510000
Public Const     SPCM_MON_T_BASE_CTRL        As Integer = &H0000000000000001UL
Public Const     SPCM_MON_T_MODULE_0         As Integer = &H0000000000000002UL
Public Const     SPCM_MON_T_MODULE_1         As Integer = &H0000000000000004UL

Public Const     SPCM_MON_V_PCIE_BUS         As Integer = &H0000000000000010UL
Public Const     SPCM_MON_V_CONNECTOR        As Integer = &H0000000000000020UL
Public Const     SPCM_MON_CARD_PWRSOURCE     As Integer = &H0000000000000040UL
Public Const     SPCM_MON_V_CARD_IN          As Integer = &H0000000000000080UL
Public Const     SPCM_MON_I_CARD_IN          As Integer = &H0000000000000100UL
Public Const     SPCM_MON_P_CARD_IN          As Integer = &H0000000000000200UL
Public Const     SPCM_MON_V_3V3              As Integer = &H0000000000000400UL
Public Const     SPCM_MON_V_2V5              As Integer = &H0000000000000800UL
Public Const     SPCM_MON_V_CORE             As Integer = &H0000000000001000UL
Public Const     SPCM_MON_V_AVTT             As Integer = &H0000000000002000UL
Public Const     SPCM_MON_V_AVCC             As Integer = &H0000000000004000UL
Public Const     SPCM_MON_V_MEMVCC           As Integer = &H0000000000008000UL
Public Const     SPCM_MON_V_MEMVTT           As Integer = &H0000000000010000UL
Public Const     SPCM_MON_V_CP_POS           As Integer = &H0000000000020000UL
Public Const     SPCM_MON_V_CP_NEG           As Integer = &H0000000000040000UL
Public Const     SPCM_MON_V_5VA              As Integer = &H0000000000080000UL
Public Const     SPCM_MON_V_ADCA             As Integer = &H0000000000100000UL
Public Const     SPCM_MON_V_ADCD             As Integer = &H0000000000200000UL
Public Const     SPCM_MON_V_OP_POS           As Integer = &H0000000000400000UL
Public Const     SPCM_MON_V_OP_NEG           As Integer = &H0000000000800000UL
Public Const     SPCM_MON_V_COMP_NEG         As Integer = &H0000000001000000UL
Public Const     SPCM_MON_V_COMP_POS         As Integer = &H0000000002000000UL
Public Const     SPCM_MON_V_1V8_BASE         As Integer = &H0000000004000000UL
Public Const     SPCM_MON_V_1V8_MOD          As Integer = &H0000000008000000UL

Public Const     SPCM_MON_V_MODA_0           As Integer = &H0000000010000000UL
Public Const     SPCM_MON_V_MODA_1           As Integer = &H0000000020000000UL
Public Const     SPCM_MON_V_MODB_0           As Integer = &H0000000040000000UL
Public Const     SPCM_MON_V_MODB_1           As Integer = &H0000000080000000UL

Public Const     SPCM_MON_T_MODA_0           As Integer = &H0000000000000002UL ' same as SPCM_MON_T_MODULE_0
Public Const     SPCM_MON_T_MODA_1           As Integer = &H0000000100000000UL
Public Const     SPCM_MON_T_MODA_2           As Integer = &H0000000200000000UL
Public Const     SPCM_MON_T_MODA_3           As Integer = &H0000000400000000UL
Public Const     SPCM_MON_T_MODA_4           As Integer = &H0000000800000000UL
Public Const     SPCM_MON_T_MODB_0           As Integer = &H0000000000000004UL ' same as SPCM_MON_T_MODULE_1
Public Const     SPCM_MON_T_MODB_1           As Integer = &H0000001000000000UL
Public Const     SPCM_MON_T_MODB_2           As Integer = &H0000002000000000UL
Public Const     SPCM_MON_T_MODB_3           As Integer = &H0000004000000000UL
Public Const     SPCM_MON_T_MODB_4           As Integer = &H0000008000000000UL

Public Const     SPCM_MON_I_MODA_0           As Integer = &H0000010000000000UL
Public Const     SPCM_MON_I_MODA_1           As Integer = &H0000020000000000UL
Public Const     SPCM_MON_I_MODA_2           As Integer = &H0000040000000000UL
Public Const     SPCM_MON_I_MODA_3           As Integer = &H0000080000000000UL
Public Const     SPCM_MON_I_MODB_0           As Integer = &H0000100000000000UL
Public Const     SPCM_MON_I_MODB_1           As Integer = &H0000200000000000UL
Public Const     SPCM_MON_I_MODB_2           As Integer = &H0000300000000000UL
Public Const     SPCM_MON_I_MODB_3           As Integer = &H0000400000000000UL

Public Const     SPCM_MON_T_MODA_5           As Integer = &H0000800000000000UL
Public Const     SPCM_MON_T_MODB_5           As Integer = &H0001000000000000UL


' ----- re-located multi-purpose i/o related registers -----
Public Const SPC_X0_READFEATURES         As Integer = 600000
Public Const SPC_X1_READFEATURES         As Integer = 600001
Public Const SPC_X2_READFEATURES         As Integer = 600002
Public Const SPC_X3_READFEATURES         As Integer = 600003
Public Const SPC_X4_READFEATURES         As Integer = 600004
Public Const SPC_X5_READFEATURES         As Integer = 600005
Public Const SPC_X6_READFEATURES         As Integer = 600006
Public Const SPC_X7_READFEATURES         As Integer = 600007
Public Const SPC_X8_READFEATURES         As Integer = 600008
Public Const SPC_X9_READFEATURES         As Integer = 600009
Public Const SPC_X10_READFEATURES        As Integer = 600010
Public Const SPC_X11_READFEATURES        As Integer = 600011
Public Const SPC_X12_READFEATURES        As Integer = 600012
Public Const SPC_X13_READFEATURES        As Integer = 600013
Public Const SPC_X14_READFEATURES        As Integer = 600014
Public Const SPC_X15_READFEATURES        As Integer = 600015
Public Const SPC_X16_READFEATURES        As Integer = 600016
Public Const SPC_X17_READFEATURES        As Integer = 600017
Public Const SPC_X18_READFEATURES        As Integer = 600018
Public Const SPC_X19_READFEATURES        As Integer = 600019
Public Const     SPCM_XFEAT_TERM             As Integer = &H00000001
Public Const     SPCM_XFEAT_HIGHIMP          As Integer = &H00000002
Public Const     SPCM_XFEAT_DCCOUPLING       As Integer = &H00000004
Public Const     SPCM_XFEAT_ACCOUPLING       As Integer = &H00000008
Public Const     SPCM_XFEAT_SE               As Integer = &H00000010
Public Const     SPCM_XFEAT_DIFF             As Integer = &H00000020
Public Const     SPCM_XFEAT_PROGTHRESHOLD    As Integer = &H00000040

Public Const SPC_X0_TERM                As Integer = 600100
Public Const SPC_X1_TERM                As Integer = 600101
Public Const SPC_X2_TERM                As Integer = 600102
Public Const SPC_X3_TERM                As Integer = 600103
Public Const SPC_X4_TERM                As Integer = 600104
Public Const SPC_X5_TERM                As Integer = 600105
Public Const SPC_X6_TERM                As Integer = 600106
Public Const SPC_X7_TERM                As Integer = 600107
Public Const SPC_X8_TERM                As Integer = 600108
Public Const SPC_X9_TERM                As Integer = 600109
Public Const SPC_X10_TERM               As Integer = 600110
Public Const SPC_X11_TERM               As Integer = 600111
Public Const SPC_X12_TERM               As Integer = 600112
Public Const SPC_X13_TERM               As Integer = 600113
Public Const SPC_X14_TERM               As Integer = 600114
Public Const SPC_X15_TERM               As Integer = 600115
Public Const SPC_X16_TERM               As Integer = 600116
Public Const SPC_X17_TERM               As Integer = 600117
Public Const SPC_X18_TERM               As Integer = 600118
Public Const SPC_X19_TERM               As Integer = 600119

Public Const SPCM_X0_MODE                As Integer = 600200
Public Const SPCM_X1_MODE                As Integer = 600201
Public Const SPCM_X2_MODE                As Integer = 600202
Public Const SPCM_X3_MODE                As Integer = 600203
Public Const SPCM_X4_MODE                As Integer = 600204
Public Const SPCM_X5_MODE                As Integer = 600205
Public Const SPCM_X6_MODE                As Integer = 600206
Public Const SPCM_X7_MODE                As Integer = 600207
Public Const SPCM_X8_MODE                As Integer = 600208
Public Const SPCM_X9_MODE                As Integer = 600209
Public Const SPCM_X10_MODE               As Integer = 600210
Public Const SPCM_X11_MODE               As Integer = 600211
Public Const SPCM_X12_MODE               As Integer = 600212
Public Const SPCM_X13_MODE               As Integer = 600213
Public Const SPCM_X14_MODE               As Integer = 600214
Public Const SPCM_X15_MODE               As Integer = 600215
Public Const SPCM_X16_MODE               As Integer = 600216
Public Const SPCM_X17_MODE               As Integer = 600217
Public Const SPCM_X18_MODE               As Integer = 600218
Public Const SPCM_X19_MODE               As Integer = 600219

Public Const SPCM_X0_AVAILMODES          As Integer = 600300
Public Const SPCM_X1_AVAILMODES          As Integer = 600301
Public Const SPCM_X2_AVAILMODES          As Integer = 600302
Public Const SPCM_X3_AVAILMODES          As Integer = 600303
Public Const SPCM_X4_AVAILMODES          As Integer = 600304
Public Const SPCM_X5_AVAILMODES          As Integer = 600305
Public Const SPCM_X6_AVAILMODES          As Integer = 600306
Public Const SPCM_X7_AVAILMODES          As Integer = 600307
Public Const SPCM_X8_AVAILMODES          As Integer = 600308
Public Const SPCM_X9_AVAILMODES          As Integer = 600309
Public Const SPCM_X10_AVAILMODES         As Integer = 600310
Public Const SPCM_X11_AVAILMODES         As Integer = 600311
Public Const SPCM_X12_AVAILMODES         As Integer = 600312
Public Const SPCM_X13_AVAILMODES         As Integer = 600313
Public Const SPCM_X14_AVAILMODES         As Integer = 600314
Public Const SPCM_X15_AVAILMODES         As Integer = 600315
Public Const SPCM_X16_AVAILMODES         As Integer = 600316
Public Const SPCM_X17_AVAILMODES         As Integer = 600317
Public Const SPCM_X18_AVAILMODES         As Integer = 600318
Public Const SPCM_X19_AVAILMODES         As Integer = 600319
' for definitions of the available modes see section at SPCM_LEGACY_X0_MODE above


' ----- Hardware registers (debug use only) -----
Public Const SPC_REG0x00                 As Integer = 900000
Public Const SPC_REG0x02                 As Integer = 900010
Public Const SPC_REG0x04                 As Integer = 900020
Public Const SPC_REG0x06                 As Integer = 900030
Public Const SPC_REG0x08                 As Integer = 900040
Public Const SPC_REG0x0A                 As Integer = 900050
Public Const SPC_REG0x0C                 As Integer = 900060
Public Const SPC_REG0x0E                 As Integer = 900070

Public Const SPC_DEBUGREG0               As Integer = 900100
Public Const SPC_DEBUGREG15              As Integer = 900115
Public Const SPC_DEBUGVALUE0             As Integer = 900200
Public Const SPC_DEBUGVALUE15            As Integer = 900215

Public Const SPC_MI_ISP                  As Integer = 901000
Public Const     ISP_TMS_0                   As Integer = 0
Public Const     ISP_TMS_1                   As Integer = 1
Public Const     ISP_TDO_0                   As Integer = 0
Public Const     ISP_TDO_1                   As Integer = 2


Public Const SPC_EE_RWAUTH               As Integer = 901100
Public Const SPC_EE_REG                  As Integer = 901110
Public Const SPC_EE_RESETCOUNTER         As Integer = 901120

' ----- Test Registers -----
Public Const SPC_TEST_BASE               As Integer = 902000
Public Const SPC_TEST_LOCAL_START        As Integer = 902100
Public Const SPC_TEST_LOCAL_END          As Integer = 902356
Public Const SPC_TEST_PLX_START          As Integer = 902400
Public Const SPC_TEST_PLX_END            As Integer = 902656

' 9012xx not usable
' 901900 not usable
' 903000 not usable
' 91xxxx not usable

' ----- used by GetErrorInfo to mark errors in other functions than SetParam/GetParam -----
Public Const SPC_FUNCTION_DEFTRANSFER As Integer = 100000000
End Module


' end of file