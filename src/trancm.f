      SUBROUTINE TRANCM
C
C*** COMPUTES TRANSONIC WING AND WING BODY PITCHING MOMENT SLOPES
C
      DIMENSION ROUTID(2)
      DIMENSION Q225AD(3),Q222AF(3),Q14228(3)
      REAL MACH,MFB
      DIMENSION T428(14),D428(28),XM(6)
      DIMENSION VAR(4),LGH(4),VBAR(4),XMV(6),XACV(6),ZMT(8),XACP(8)
      DIMENSION D425AD(756)
      DIMENSION T425AD(30),DUMY1(63),DUMY2(63),DUMY3(63),DUMY4(63),DUMY5
     1(63),DUMY6(63),DUMY7(63),DUMY8(63),DUMY9(63),DUMY10(63),DUMY11(63)
      DIMENSION DUMY12(63)
      DIMENSION DUMYA(72),DUMYB(72),DUMYC(72),DUMYD(72),DUMYE(72),DUMYF
     1(72),DUMYG(72),DUMYH(72),DUMYI(72),DUMYJ(72),DUMYK(72),DUMYL(72)
      DIMENSION T422AF(18),SUBAF1(216),SUBAF2(216),SUPAF1(216)
     1,SUPAF2(216)
      COMMON /OVERLY/ NLOG,NMACH,NZ
      COMMON /SYNTSS/ XCG,XW,ZW,ALIW,ZCG,XH,ZH,ALIH,XV,VERTUP,HINAX,
     1               XVF,SCALE,ZV,ZVF,YV,YF,PHIV,PHIF
      COMMON /OPTION/ SREF,CBARR,ROUGFC,BLREF
      COMMON /WINGI/  WINGIN(15),TOVC
      COMMON /SBETA/  STB(135),TRA(108)
      COMMON /SUPWBB/  SWB(61)
      COMMON /WHWB/   FACT(182),WB(39)
      COMMON /WINGD/  A(195),B(49)
      COMMON /BDATA/  BD(762)
      COMMON /IBODY/  PBODY, BODY(400)
      COMMON /IWING/  PWING, WING(400)
      COMMON /IBW/    PBW, BW(380)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS
      LOGICAL FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1        HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2        SUPERS,SUBSON,TRANSN,HYPERS
      EQUIVALENCE (XACBW4,SWB(8)),(XACBW6,WB(13)),(CLAWB,TRA(71)),
     1            (CLABW,TRA(72)),(CLAWBD,BW(101))
      EQUIVALENCE (SUBAF1(1),DUMYA(1)),(SUBAF1(73),DUMYB(1)),(SUBAF1(145
     1),DUMYC(1)),(SUBAF2(1),DUMYD(1)),(SUBAF2(73),DUMYE(1)),(SUBAF2(145
     2),DUMYF(1)),(SUPAF1(1),DUMYG(1)),(SUPAF1(73),DUMYH(1)),(SUPAF1(145
     3),DUMYI(1)),(SUPAF2(1),DUMYJ(1)),(SUPAF2(73),DUMYK(1)),(SUPAF2(145
     4),DUMYL(1))
      EQUIVALENCE (D425AD(1),DUMY1(1)),(D425AD(64),DUMY2(1)),(D425AD(127
     1),DUMY3(1)),(D425AD(190),DUMY4(1)),(D425AD(253),DUMY5(1)),(D425AD(
     2316),DUMY6(1)),(D425AD(379),DUMY7(1)),(D425AD(442),DUMY8(1)),(D425
     3AD(505),DUMY9(1)),(D425AD(568),DUMY10(1)),(D425AD(631),DUMY11(1)),
     4(D425AD(694),DUMY12(1))
      EQUIVALENCE (ARSTAR,A(7)),(TANLE,A(62)),(TAPR,A(27))
     1,(MACH,TRA(4)),(COSC2,A(73)),(MFB,TRA(6)),(CRSTAR,A(10))
     2,(DXCG,A(173)),(CLAW,WING(101)),(CMAB,BODY(121)),(CLAB,BODY(101))
      EQUIVALENCE(XMV(1),TRA(83)),(XACV(1),TRA(89)),
     1(DELXAC,TRA(96)),(XACP(1),TRA(97)),(XAC,TRA(105)),(CMAW,WING(121)
     2),(XACBW,TRA(106)),(XACWB,TRA(107)),(CMAWB,BW(121))
     3,(XACW,TRA(95))
      DATA ROUTID/4HTRAN,4HCM  /
      DATA Q225AD /4H4.1.,4H4.2-,4H30AD/,Q222AF /4H4.1.,4H4.2-,4H26AF/,
     1     Q14228 /4H4.1.,4H4.2-,4H33  /
      DATA XM/0.5,0.7,0.6,1.3,1.5,1.4/
C
C           ****** FIGURE 4.1.4.2-26(A),(B),(C),(D),(E),(F) ******
C
      DATA T422AF/
     10.,.2,.4,.6,.8,1.,
     21.,2.,3.,4.,5.,6.,
     30.,.2,.25,.33,.5,1./
      DATA DUMYA/
     1  .250,   .245,   .240,   .235,   .230,   .225,   .335,   .335,
     2  .335,   .335,   .335,   .335,   .420,   .430,   .435,   .445,
     3  .450,   .455,   .500,   .515,   .530,   .540,   .550,   .560,
     4  .580,   .600,   .630,   .645,   .660,   .680,   .680,   .695,
     5  .720,   .740,   .760,   .780,
     6  .285,   .275,   .270,   .265,   .260,   .255,   .400,   .410,
     7  .415,   .415,   .415,   .410,   .510,   .530,   .535,   .540,
     8  .545,   .550,   .640,   .650,   .660,   .675,   .685,   .690,
     9  .750,   .765,   .780,   .785,   .800,   .815,   .870,   .880,
     A  .895,   .905,   .920,   .930/
      DATA DUMYB/
     1  .300,   .295,   .285,   .280,   .275,   .265,   .420,   .420,
     2  .425,   .425,   .425,   .430,   .545,   .550,   .560,   .565,
     3  .575,   .580,   .670,   .680,   .690,   .700,   .710,   .720,
     4  .795,   .805,   .815,   .830,   .840,   .850,   .925,   .945,
     5  .960,   .965,   .975,   .980,
     6  .325,   .320,   .315,   .305,   .300,   .290,   .460,   .460,
     7  .460,   .460,   .455,   .455,   .595,   .600,   .600,   .600,
     8  .610,   .620,   .735,   .740,   .750,   .760,   .765,   .775,
     9  .885,   .890,   .895,   .900,   .910,   .925,   1.045,  1.050,
     A  1.050,  1.060,  1.065,  1.075/
      DATA DUMYC/
     1  .355,   .350,   .345,   .340,   .330,   .320,   .530,   .530,
     2  .525,   .525,   .520,   .520,   .700,   .700,   .700,   .705,
     3  .710,   .710,   .880,   .880,   .885,   .890,   .890,   .895,
     4  1.040,  1.045,  1.050,  1.055,  1.060,  1.065,  1.200,  1.205,
     5  1.210,  1.215,  1.225,  1.230,
     6  .510,   .490,   .480,   .470,   .460,   .450,   .750,   .750,
     7  .750,   .750,   .745,   .740,   1.000,  1.000,  1.000,  1.000,
     8  1.000,  1.000,  1.250,  1.250,  1.250,  1.250,  1.250,  1.250,
     9  1.500,  1.500,  1.500,  1.490,  1.490,  1.490,  1.740,  1.740,
     A  1.740,  1.730,  1.730,  1.730/
      DATA DUMYD/
     1  .165,   .180,   .200,   .210,   .220,   .225,   .335,   .335,
     2  .335,   .335,   .335,   .335,   .500,   .480,   .465,   .460,
     3  .460,   .455,   .670,   .625,   .595,   .580,   .575,   .560,
     4  .830,   .750,   .730,   .705,   .695,   .680,   .990,   .860,
     5  .835,   .810,   .795,   .780,
     6  .200,   .215,   .230,   .240,   .250,   .255,   .400,   .400,
     7  .400,   .405,   .410,   .410,   .600,   .580,   .565,   .560,
     8  .555,   .550,   .795,   .760,   .735,   .715,   .700,   .690,
     9  .970,   .910,   .870,   .840,   .825,   .815,   1.150,  1.050,
     A  1.000,  .965,   .940,   .930/
      DATA DUMYE/
     1  .230,   .240,   .245,   .250,   .260,   .265,   .415,   .420,
     2  .425,   .425,   .430,   .430,   .630,   .615,   .600,   .590,
     3  .585,   .580,   .830,   .785,   .760,   .740,   .730,   .720,
     4  1.030,  .950,   .905,   .880,   .865,   .850,   1.250,  1.090,
     5  1.050,  1.015,  .990,   .980,
     6  .220,   .240,   .250,   .265,   .280,   .290,   .440,   .445,
     7  .450,   .450,   .455,   .455,   .670,   .655,   .640,   .630,
     8  .625,   .620,   .880,   .830,   .805,   .790,   .780,   .775,
     9  1.070,  1.000,  .960,   .940,   .935,   .925,   1.270,  1.170,
     A  1.120,  1.100,  1.085,  1.075/
      DATA DUMYF/
     1  .250,   .270,   .295,   .310,   .315,   .320,   .500,   .505,
     2  .510,   .515,   .520,   .520,   .750,   .740,   .730,   .720,
     3  .715,   .710,   .980,   .940,   .915,   .900,   .900,   .895,
     4  1.190,  1.120,  1.090,  1.080,  1.070,  1.065,  1.380,  1.300,
     5  1.270,  1.250,  1.240,  1.230,
     6  .340,   .380,   .410,   .430,   .440,   .450,   .680,   .700,
     7  .720,   .730,   .730,   .740,   .950,   .980,   1.000,  1.000,
     8  1.000,  1.000,  1.200,  1.230,  1.250,  1.250,  1.250,  1.250,
     9  1.440,  1.470,  1.480,  1.480,  1.490,  1.490,  1.680,  1.710,
     A  1.710,  1.720,  1.720,  1.730/
      DATA DUMYG/
     1  .165,   .210,   .250,   .290,   .310,   .345,   .335,   .365,
     2  .390,   .415,   .445,   .470,   .500,   .540,   .560,   .560,
     3  .560,   .560,   .670,   .670,   .670,   .670,   .670,   .670,
     4  .830,   .775,   .775,   .775,   .775,   .775,   .990,   .930,
     5  .895,   .895,   .895,   .895,
     6  .200,   .230,   .280,   .305,   .335,   .360,   .400,   .445,
     7  .485,   .500,   .520,   .530,   .600,   .630,   .650,   .660,
     8  .665,   .665,   .795,   .800,   .800,   .805,   .810,   .815,
     9  .970,   .965,   .955,   .955,   .955,   .955,   1.150,  1.135,
     A  1.120,  1.100,  1.100,  1.105/
      DATA DUMYH/
     1  .230,   .275,   .300,   .330,   .350,   .370,   .415,   .470,
     2  .500,   .530,   .545,   .550,   .630,   .670,   .680,   .685,
     3  .690,   .690,   .830,   .835,   .835,   .840,   .845,   .850,
     4  1.030,  1.015,  1.005,  1.000,  1.005,  1.010,  1.250,  1.225,
     5  1.200,  1.170,  1.165,  1.160,
     6  .220,   .280,   .315,   .345,   .375,   .390,   .440,   .500,
     7  .535,   .560,   .570,   .580,   .670,   .700,   .720,   .725,
     8  .740,   .740,   .880,   .885,   .895,   .900,   .900,   .900,
     9  1.070,  1.070,  1.075,  1.075,  1.080,  1.080,  1.270,  1.260,
     A  1.260,  1.255,  1.255,  1.255/
      DATA DUMYI/
     1  .250,   .300,   .330,   .380,   .415,   .445,   .500,   .560,
     2  .600,   .620,   .635,   .640,   .750,   .780,   .800,   .820,
     3  .820,   .825,   .980,   .990,   1.000,  1.020,  1.020,  1.020,
     4  1.190,  1.200,  1.200,  1.210,  1.220,  1.225,  1.380,  1.390,
     5  1.400,  1.410,  1.420,  1.420,
     6  .340,   .380,   .410,   .460,   .500,   .540,   .680,   .700,
     7  .730,   .770,   .790,   .840,   .950,   .990,   1.010,  1.050,
     8  1.080,  1.120,  1.200,  1.240,  1.290,  1.330,  1.370,  1.420,
     9  1.440,  1.500,  1.550,  1.610,  1.670,  1.720,  1.680,  1.760,
     A  1.820,  1.890,  1.950,  2.020/
      DATA DUMYJ/
     1  .415,   .410,   .400,   .385,   .370,   .345,   .500,   .500,
     2  .495,   .485,   .480,   .470,   .585,   .580,   .580,   .575,
     3  .570,   .560,   .670,   .670,   .670,   .670,   .670,   .670,
     4  .750,   .750,   .755,   .760,   .765,   .775,   .830,   .840,
     5  .845,   .855,   .870,   .895,
     6  .460,   .455,   .445,   .420,   .390,   .360,   .575,   .575,
     7  .570,   .560,   .545,   .530,   .695,   .695,   .690,   .685,
     8  .680,   .665,   .800,   .805,   .805,   .810,   .815,   .815,
     9  .920,   .930,   .935,   .945,   .970,   .955,   1.040,  1.045,
     A  1.050,  1.075,  1.110,  1.105/
      DATA DUMYK/
     1  .475,   .465,   .450,   .430,   .400,   .370,   .600,   .600,
     2  .595,   .585,   .575,   .550,   .725,   .730,   .730,   .725,
     3  .715,   .690,   .850,   .850,   .855,   .865,   .870,   .850,
     4  .970,   .975,   .980,   1.000,  1.020,  1.010,  1.110,  1.110,
     5  1.110,  1.130,  1.180,  1.160,
     6  .500,   .490,   .470,   .450,   .425,   .390,   .640,   .635,
     7  .630,   .620,   .600,   .580,   .770,   .775,   .780,   .775,
     8  .765,   .740,   .920,   .915,   .920,   .930,   .935,   .900,
     9  1.050,  1.055,  1.060,  1.080,  1.105,  1.080,  1.195,  1.200,
     A  1.205,  1.225,  1.265,  1.255/
      DATA DUMYL/
     1  .550,   .535,   .525,   .500,   .475,   .445,   .720,   .715,
     2  .710,   .690,   .670,   .640,   .890,   .890,   .890,   .885,
     3  .870,   .825,   1.060,  1.050,  1.050,  1.060,  1.065,  1.020,
     4  1.215,  1.215,  1.220,  1.245,  1.270,  1.225,  1.380,  1.380,
     5  1.395,  1.420,  1.470,  1.420,
     6  .760,   .730,   .700,   .650,   .600,   .540,   1.000,  1.000,
     7  .970,   .930,   .890,   .840,   1.240,  1.230,  1.230,  1.220,
     8  1.190,  1.120,  1.500,  1.480,  1.480,  1.490,  1.470,  1.420,
     9  1.750,  1.720,  1.730,  1.760,  1.780,  1.720,  2.000,  1.970,
     A  1.980,  2.020,  2.070,  2.020/
C
C           ****** FIGURE 4.1.4.2-30(A),(B),(C),(D) ******
C
      DATA T425AD/
     10.,.75,1.,1.25,2.,3.,6.,2*0.,
     20.,1.,2.,3.,4.,5.,6.,10.,15.,
     3-2.0000001,-1.0,0.0,1.0000001,5*0.,
     40.,.2,.5/
      DATA DUMY1/
     1  0.,     .100,   .125,   .140,   .160,   .173,   .210,   .175,
     2  .230,   .260,   .264,   .280,   .300,   .370,   .340,   .375,
     3  .390,   .392,   .400,   .412,   .450,   .496,   .504,   .509,
     4  .510,   .518,   .530,   .565,   .655,   .625,   .623,   .623,
     5  .625,   .627,   .630,   .810,   .735,   .735,   .732,   .729,
     6  .725,   .705,   .970,   .855,   .845,   .835,   .835,   .825,
     7  .805,   1.610,  1.280,  1.260,  1.245,  1.215,  1.170,  1.035,
     8  2.405,  1.800,  1.725,  1.705,  1.635,  1.555,  1.280/
      DATA DUMY2/
     1  0.,     .090,   .115,   .140,   .168,   .200,   .290,   .173,
     2  .245,   .270,   .288,   .305,   .320,   .365,   .340,   .390,
     3  .405,   .425,   .435,   .445,   .490,   .500,   .525,   .530,
     4  .533,   .540,   .553,   .585,   .664,   .650,   .652,   .654,
     5  .660,   .667,   .685,   .815,   .780,   .776,   .776,   .778,
     6  .780,   .785,   .970,   .900,   .880,   .880,   .880,   .880,
     7  .880,   1.610,  1.400,  1.325,  1.270,  1.280,  1.290,  1.310,
     8  2.410,  1.980,  1.840,  1.720,  1.745,  1.765,  1.840/
      DATA DUMY3/
     1  0.,     .110,   .150,   .199,   .199,   .199,   .199,   .180,
     2  .260,   .285,   .310,   .321,   .321,   .321,   .350,   .405,
     3  .427,   .440,   .445,   .445,   .445,   .500,   .533,   .543,
     4  .550,   .550,   .550,   .550,   .665,   .663,   .662,   .661,
     5  .660,   .660,   .660,   .818,   .793,   .788,   .780,   .780,
     6  .780,   .780,   .975,   .923,   .905,   .890,   .890,   .890,
     7  .890,   1.615,  1.430,  1.380,  1.320,  1.320,  1.320,  1.320,
     8  2.415,  2.080,  1.960,  1.845,  1.845,  1.845,  1.845/
      DATA DUMY4/
     1  0.,     .120,   .165,   .200,   .200,   .200,   .200,   .175,
     2  .275,   .300,   .324,   .324,   .324,   .324,   .335,   .417,
     3  .445,   .445,   .445,   .445,   .445,   .500,   .548,   .548,
     4  .548,   .548,   .548,   .548,   .665,   .665,   .665,   .665,
     5  .665,   .665,   .665,   .815,   .775,   .775,   .775,   .775,
     6  .775,   .775,   .985,   .880,   .880,   .880,   .880,   .880,
     7  .880,   1.630,  1.280,  1.280,  1.280,  1.280,  1.280,  1.280,
     8  2.435,  1.730,  1.730,  1.730,  1.730,  1.730,  1.730/
      DATA DUMY5/
     1  0.,     .120,   .135,   .150,   .168,   .186,   .240,   .200,
     2  .270,   .280,   .284,   .296,   .315,   .375,   .400,   .425,
     3  .426,   .430,   .440,   .450,   .483,   .600,   .575,   .575,
     4  .575,   .576,   .577,   .589,   .795,   .730,   .718,   .719,
     5  .720,   .721,   .725,   .980,   .860,   .837,   .835,   .830,
     6  .825,   .805,   1.175,  1.020,  .980,   .975,   .965,   .955,
     7  .910,   1.955,  1.590,  1.470,  1.405,  1.400,  1.390,  1.370,
     8  2.930,  2.360,  2.160,  1.960,  1.940,  1.910,  1.830/
      DATA DUMY6/
     1  0.,     .085,   .120,   .145,   .186,   .215,   .295,   .205,
     2  .270,   .300,   .325,   .348,   .368,   .430,   .400,   .449,
     3  .470,   .485,   .495,   .510,   .530,   .600,   .610,   .614,
     4  .618,   .632,   .649,   .700,   .800,   .778,   .770,   .773,
     5  .780,   .794,   .830,   .978,   .935,   .915,   .916,   .919,
     6  .919,   .919,   1.165,  1.085,  1.060,  1.060,  1.055,  1.050,
     7  1.045,  1.940,  1.750,  1.695,  1.645,  1.620,  1.585,  1.480,
     8  2.905,  2.505,  2.485,  2.450,  2.380,  2.275,  1.965/
      DATA DUMY7/
     1  0.,     .125,   .175,   .210,   .215,   .215,   .215,   .200,
     2  .290,   .320,   .355,   .360,   .360,   .360,   .400,   .465,
     3  .485,   .505,   .510,   .510,   .510,   .600,   .630,   .640,
     4  .648,   .650,   .650,   .650,   .800,   .795,   .794,   .793,
     5  .793,   .793,   .793,   .980,   .940,   .925,   .910,   .910,
     6  .910,   .910,   1.175,  1.070,  1.040,  1.040,  1.040,  1.040,
     7  1.040,  1.960,  1.610,  1.490,  1.490,  1.490,  1.490,  1.490,
     8  2.940,  2.240,  2.000,  2.000,  2.000,  2.000,  2.000/
      DATA DUMY8/
     1  0.,     .150,   .200,   .237,   .237,   .237,   .237,   .200,
     2  .320,   .370,   .382,   .382,   .382,   .382,   .400,   .490,
     3  .523,   .523,   .523,   .523,   .523,   .600,   .640,   .650,
     4  .650,   .650,   .650,   .650,   .800,   .782,   .780,   .780,
     5  .780,   .780,   .780,   .980,   .895,   .888,   .888,   .888,
     6  .888,   .888,   1.175,  1.040,  1.000,  1.000,  1.000,  1.000,
     7  1.000,  1.960,  1.540,  1.420,  1.420,  1.420,  1.420,  1.420,
     8  2.940,  1.910,  1.910,  1.910,  1.910,  1.910,  1.910/
      DATA DUMY9/
     1  0.,     .120,   .150,   .163,   .178,   .195,   .255,   .260,
     2  .335,   .350,   .351,   .365,   .385,   .430,   .500,   .530,
     3  .535,   .540,   .550,   .565,   .610,   .753,   .738,   .738,
     4  .738,   .735,   .735,   .725,   .975,   .912,   .908,   .904,
     5  .894,   .884,   .845,   1.220,  1.140,  1.110,  1.080,  1.060,
     6  1.040,  .960,   1.460,  1.330,  1.280,  1.240,  1.210,  1.180,
     7  1.090,  2.420,  2.070,  1.960,  1.840,  1.785,  1.725,  1.520,
     8  3.600,  3.180,  3.040,  2.900,  2.480,  2.365,  2.000/
      DATA DUMY10/
     1  0.,     .095,   .140,   .173,   .230,   .278,   .420,   .260,
     2  .34,    .370,   .394,   .420,   .455,   .550,   .510,   .560,
     3  .585,   .593,   .610,   .634,   .705,   .750,   .775,   .780,
     4  .786,   .798,   .810,   .850,   .980,   .955,   .950,   .950,
     5  .948,   .945,   .935,   1.180,  1.105,  1.097,  1.094,  1.080,
     6  1.065,  1.015,  1.385,  1.270,  1.240,  1.230,  1.220,  1.205,
     7  1.170,  2.150,  1.860,  1.760,  1.650,  1.640,  1.620,  1.560,
     8  3.050,  2.500,  2.310,  2.140,  2.115,  2.085,  2.000/
      DATA DUMY11/
     1  0.,     .150,   .200,   .260,   .275,   .275,   .275,   .260,
     2  .370,   .405,   .445,   .455,   .455,   .455,   .510,   .583,
     3  .605,   .630,   .634,   .634,   .634,   .755,   .788,   .800,
     4  .800,   .800,   .800,   .800,   .980,   .960,   .950,   .943,
     5  .943,   .943,   .943,   1.175,  1.110,  1.093,  1.064,  1.064,
     6  1.064,  1.064,  1.360,  1.240,  1.210,  1.163,  1.163,  1.163,
     7  1.163,  2.070,  1.750,  1.645,  1.540,  1.540,  1.540,  1.540,
     8  2.910,  2.320,  2.125,  1.940,  1.940,  1.940,  1.940/
      DATA DUMY12/
     1  0.,     .165,   .245,   .280,   .280,   .280,   .280,   .260,
     2  .405,   .475,   .475,   .475,   .475,   .475,   .510,   .610,
     3  .650,   .650,   .650,   .650,   .650,   .755,   .800,   .820,
     4  .820,   .820,   .820,   .820,   .980,   .961,   .960,   .960,
     5  .960,   .960,   .960,   1.180,  6*1.08,
     6                  1.370,  1.250,  1.250,  1.250,  1.250,  1.250,
     7  1.250,  2.090,  1.780,  1.780,  1.780,  1.780,  1.780,  1.780,
     8  2.910,  2.400,  2.400,  2.400,  2.400,  2.400,  2.400/
C
C           ****** FIGURE 4.1.4.2-33
C
      DATA T428/
     10.,6.6,10.,14.,3*0.,
     20.,1.7,2.0,2.5,3.0,4.0,6.0/
      DATA D428/
     1  0.,     0.,     0.,     0.,     0.,     0.,     0.,     0.,
     2  0.,   0.,   -.100,  -.220,   0.,   0.,  -.210,   -.450,
     3  0.,   0.,   -.305,  -.665,   0.,   0.,  -.475,   -1.040,
     4  0.,   0.,   -.650,  -1.410/
C
C  *** WING ALONE ***
C  *** TOVC .LE.0.07 ***
C              FIGURE 4.1.4.2-30A-D (XAC/CR)
C
      VAR(1)=ARSTAR*(TOVC)**0.3333
      VAR(2)=ARSTAR*TANLE
      VAR(4)=TAPR
      LGH(1)=7
      LGH(2)=9
      LGH(3)=4
      LGH(4)=3
      VBAR(1)=-2.
      VBAR(2)=-1.
      VBAR(3)=0.
      VBAR(4)=1.
      DO 1000 I=2,5
         XMV(I)=SQRT(1.+VBAR(I-1)*TOVC**.6666)
         VAR(3)=VBAR(I-1)
 1000 CALL TLIN4X(T425AD(10 ),T425AD(1  ),T425AD(19 ),T425AD(28 ),D425AD
     1,LGH(2),LGH(1),LGH(3),LGH(4),VAR(2),VAR(1),VAR(3),VAR(4),XACV(I),
     20,0,0,0,2,1,0,1,Q225AD,3,ROUTID)
      IF(WGPL.AND.(.NOT.BO))DXCG=XCG-XW
      XMV(1)=0.60
      XMV(6)=1.40
C
C              FIGURE 4.1.4.2-26A-F
C
      LGH(1)=6
      LGH(2)=6
      LGH(3)=6
      VAR(3)=TAPR
      DO 1030 I=1,3
         ARG1=TANLE/SQRT(1.0-XM(I)**2)
         IF(ARG1.GT.1.)GO TO 1010
         VAR(1)=ARG1
         CALL INTERX(3,T422AF,VAR,LGH,SUBAF1,XACV(1),6,216,
     1               0,2,0,0,0,2,0,0,Q222AF,3,ROUTID)
         GO TO 1020
 1010    VAR(1)=1./ARG1
         CALL INTERX(3,T422AF,VAR,LGH,SUBAF2,XACV(1),6,216,
     1               0,2,0,0,0,2,0,0,Q222AF,3,ROUTID)
 1020    CONTINUE
         IF(I.EQ.1)DXAC1=XACV(1)
         IF(I.EQ.2)DXAC1=(XACV(1)-DXAC1)/0.2
 1030 CONTINUE
C
      DO 1060 I=4,6
         ARG=SQRT(XM(I)**2-1.0)/TANLE
         IF(ARG.GT.1.)GO TO 1040
         VAR(1)=ARG
         CALL INTERX(3,T422AF,VAR,LGH,SUPAF1,XACV(6),6,216,
     1               0,2,0,0,0,2,0,0,Q222AF,3,ROUTID)
         GO TO 1050
 1040    VAR(1)=1./ARG
         CALL INTERX(3,T422AF,VAR,LGH,SUPAF2,XACV(6),6,216,
     1               0,2,0,0,0,2,0,0,Q222AF,3,ROUTID)
 1050    CONTINUE
         IF(I.EQ.4)DXAC2=XACV(6)
         IF(I.EQ.5)DXAC2=(XACV(6)-DXAC2)/0.2
 1060 CONTINUE
      CALL TRANAC(6,XMV,XACV,DXAC1,DXAC2,0.0,MACH,XAC)
      IF(TOVC.LE.0.07)GO TO 1080
C
C  *** TOVC .GT.0.07 ***
C              FIGURE 4.1.4.2-33  DELTA XAC
C
      VAR(1)=TOVC*100.
      VAR(2)=ARSTAR*COSC2**2
      LGH(1)=4
      LGH(2)=7
      CALL INTERX(2,T428,VAR,LGH,D428,DELXAC,7,28,
     1            0,-1,0,0,1,0,0,0,Q14228,3,ROUTID)
      ZMT(1)=0.60
      ZMT(2)=(MFB+.6)/2.
      ZMT(3)=MFB
      ZMT(4)=MFB+.03
      ZMT(5)=MFB+.07
      ZMT(6)=MFB+.14
      ZMT(7)=XMV(5)
      IF((ZMT(6)+0.01).GE.ZMT(7))ZMT(7)=(ZMT(6)+1.4)/2.0
      ZMT(8)=1.4
      DO 1070 I=1,8
         CALL TRANAC(6,XMV,XACV,DXAC1,DXAC2,0.0,ZMT(I),XACP(I))
 1070 CONTINUE
      CALL TRANAC(8,ZMT,XACP,DXAC1,DXAC2,DELXAC,MACH,XAC)
 1080 XACW=XAC*CRSTAR/CBARR
      CMAW=(DXCG/CBARR-XACW)*CLAW
      IF(.NOT.BO)RETURN
C
C  *** WING-BODY ***
C
      CALL WBTRAN(NZ)
      CALL WBCM1(A,WINGIN,BD,WB)
      ARG1= ABS(XACBW4-XACBW6)/0.80
      XACBW= XACBW6+ARG1*(MACH-0.60)
      CNOB=(-CMAB/CLAB*CBARR+DXCG)*CLAB/CBARR
      DNUM = CNOB+XACW*CLAWB+XACBW*CLABW
      DNOM= CLAB+CLAWB+CLABW
      XACWB=DNUM/DNOM
      CMAWB=(DXCG/CBARR-XACWB)*CLAWBD
      RETURN
      END