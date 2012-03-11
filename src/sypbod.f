      SUBROUTINE SYPBOD(I)
C
C***  COMPUTES SUPERSONIC BODY ALONE AERO
C
      COMMON /SUPBOD/ SBD(229)
      COMMON /OVERLY/ NLOG,NMACH,M,NALPHA
      COMMON /OPTION/ SR,CRBAR,RUFF,BLREF
      COMMON /IBODY/  PBODY,BODY(400)
      COMMON /BODYI/  NXX,XCOOR(20),S(20),PERIM(20),RADIUS(20),
     1                ZU(20),ZL(20),BNOSE,BTAIL,RLN,RLA,DS,
     2                ITYPE,METHOD,ELLIP
      COMMON /SYNTSS/ XCG,XW,ZW,ALIW,ZCG,XH,ZH,ALIH,XV,VERTUP,HINAX,
     1                XVF,SCALE,ZV,ZVF,YV,YF,PHIV,PHIF
      COMMON /WINGI/  WINGIN(100)
      COMMON /HTI/    HTIN(154)
      COMMON /WINGD/  A(195)
      COMMON /HTDATA/ AHT(195)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /FLGTCD/ FLC(73)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS
      COMMON /BDATA/  BD(762)
      LOGICAL         FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS
      LOGICAL NOSCYL,NOSTAL,TAIL,NOSCT,FLARE
      REAL NXX,MC(20)
      REAL MACH
      DIMENSION CN(20),CA(20)
      DIMENSION CD(20)
      DIMENSION VAR(4),LGH(4),ALSCHD(20),RX(20),ALSCHR(20),
     1          CDC(20),CFLOW(20),CL(20),CM(20)
      DIMENSION REQ(20),CNVIS(20),CNPOT(20),CMVIS(20),CMPOT(20)
      EQUIVALENCE (REQ(1),BD(536)),(CNPOT(1),BD(556)),
     1 (CNVIS(1),BD(576)),(CMPOT(1),BD(596)),(CMVIS(1),BD(616))
      EQUIVALENCE  (CMA,SBD(110)),
     1(CN(1),BODY(61)),(CA(1),BODY(81))
      EQUIVALENCE (CDN2P,SBD(107)),(CDN2,SBD(108)),
     1(CD(1),BODY(1)),(SS,SBD(111)),(RNB,SBD(112)),
     2(RLCOFF,SBD(113)),(CF,SBD(114)),(CDF,SBD(115)),(CDANF,SBD(116)),
     3(CDANC,SBD(117)),(CDAB,SBD(118)),(DMAX,SBD(120)),(CDA,SBD(119)),
     4(CDD,SBD(121)),(CPB,SBD(122)),(CDB,SBD(123)),(CDO,SBD(124))
      EQUIVALENCE (ALSCHD (1),FLC(23)),(THETAT,SBD(135))
      EQUIVALENCE (RLBP,SBD(1)),(RLB,SBD(2)),(RLBT,SBD(3)),(DN,SBD(4))
     1,(D1,SBD(5)),(D2,SBD(6)),(BETA,SBD(7)),(FA,SBD(8)),(FB,SBD(9)),
     2(FN,SBD(10)),(XCPLB,SBD(11)),(CMAOC,SBD(12)),(DELCMA,SBD(13)),
     3(THETAB,SBD(14)),(DELCNA,SBD(15)),(THETAF,SBD(16)),(CNAOC,SBD(17))
     4,(CNA,SBD(18)),(SB,SBD(19)),(SP,SBD(20)),(ALSCHR(1),SBD(21))
     5,(MC(1),SBD(41)),(CDC(1),SBD(61)),(CFLOW(1),SBD(81))
     6,(CM(1),BODY(41)),(XCPBLB,SBD(101)),(CMAP,SBD(103))
     7,(CL(1),BODY(21)),(XC,SBD(105)),(VB,SBD(106))
      DIMENSION ROUTID(2),XVSR(2),Q1121A(3),Q1121B(3),Q1122A(3),
     1 Q1122B(3),Q1217B(3),Q2118A(3),Q22119(3),Q2120A(3),Q23127(3),
     2 Q23128(3),Q15127(3),Q3144A(3),Q23160(3),Q23150(3),Q23155(3)
     3 ,Q2118B(3)
      DIMENSION T4227(22),D4227(120),T4228(20),D4228(100)
      DIMENSION DUMYC(165),DUMYD(110) ,D4355(275)
      DIMENSION T44A(9),D44A(18),T4360(13),D4360(13),T5055(27)
      DIMENSION D4350(275),DUMYA(165),DUMYB(110)
      DIMENSION T4222A(8),D4222A(8),T4222B(6),D4222B(6),T4217B(18),
     1          D4217B(18)
      DIMENSION T4218A(18),DL218A(54),DR218A(54),T4218B(14),DL218B(42),
     1          DR218B(42),T42119(18),D42119(77),T4221A(19),D4221A(88),
     2          T4221B(18),D4221B(80)
      DIMENSION DUMY1(90),DUMY2(108),D4220A(198),T4220A(29)
      DIMENSION X27M(4),X27I(4),C27(6)
      EQUIVALENCE (D4355(1),DUMYC(1)),(D4355(166),DUMYD(1))
      EQUIVALENCE (DUMYA(1),D4350(1)),(DUMYB(1),D4350(166))
      EQUIVALENCE (D4220A(1),DUMY1(1)),(D4220A(91),DUMY2(1))
      DATA ROUTID/4HSUPB,4HOD  /,XVSR/4HX VS,4H. R /,
     1 Q1121A/4H4.2.,4H1.1-,4H21A /,Q1217B/4H4.2.,4H1.2-,4H35B /,
     2 Q1121B/4H4.2.,4H1.1-,4H21B /,Q2118A/4H4.2.,4H2.1-,4H23A /,
     3 Q1122A/4H4.2.,4H1.1-,4H22A /,Q2118B/4H4.2.,4H2.1-,4H23B /,
     4 Q1122B/4H4.2.,4H1.1-,4H22B /,Q22119/4H4.2.,4H2.1-,4H24  /,
     5 Q2120A/4H4.2.,4H2.1-,4H25A /,Q23127/4H4.2.,4H3.1-,4H27  /,
     6 Q15127/4H4.1.,4H5.1-,4H27  /,Q23128/4H4.2.,4H3.1-,4H28  /,
     7 Q3144A/4H4.2.,4H3.1-,4H44A /,Q23160/4H4.2.,4H3.1-,4H60  /,
     8 Q23150/4H4.2.,4H3.1-,4H50  /,
     9 Q23155/4H4.2.,4H3.1-,4H55  /
C
C                FIGURE 4.1.5.1-27
C
      DATA X27M/0.0,1.0,2.0,3.0/
      DATA X27I/1.57780,1.67221,1.98509,2.28874/
      DATA I27/0/
C
C               FIGURE 4.2.2.1-23A (LEFT SIDE)
C
      DATA T4218A
     1  / 0., 0.2, 0.4, 0.6, 0.8, 1.0 , 3*0.0,
     2    0.0, 0.4, 0.8, 1.2, 1.6, 2.0, 3.0, 4.0, 5.0 /
      DATA DL218A
     1 /  0.543,  0.542,  0.541,  0.540,  0.534,  0.526,
     2    0.400,  0.409,  0.418,  0.430,  0.441,  0.450,
     3    0.305,  0.328,  0.350,  0.369,  0.387,  0.400,
     4    0.238,  0.265,  0.295,  0.318,  0.339,  0.356,
     5    0.198,  0.221,  0.246,  0.274,  0.298,  0.320,
     6    0.160,  0.185,  0.210,  0.239,  0.262,  0.288,
     7    0.065,  0.095,  0.122,  0.150,  0.177,  0.210,
     8    0.000,  0.005,  0.035,  0.062,  0.089,  0.130,
     9    0.000,  0.000,  0.000,  0.000,  0.002,  0.050  /
C
C               FIGURE 4.2.2.1-23A (RIGHT SIDE)
C
      DATA DR218A
     1  / 0.445,  0.464,  0.485,  0.500,  0.518,  0.526,
     2    0.448,  0.455,  0.460,  0.460,  0.459,  0.450,
     3    0.460,  0.449,  0.438,  0.424,  0.412,  0.400,
     4    0.450,  0.430,  0.412,  0.394,  0.375,  0.356,
     5    0.432,  0.410,  0.388,  0.365,  0.343,  0.320,
     6    0.420,  0.394,  0.369,  0.340,  0.314,  0.288 ,
     7    0.388,  0.354,  0.322,  0.278,  0.244,  0.210,
     8    0.357,  0.314,  0.273,  0.216,  0.171,  0.130,
     9    0.325,  0.274,  0.225,  0.154,  0.100,  0.050  /
C
C              FIGURE 4.2.2.1-23B (LEFT SIDE)
C
      DATA T4218B
     1  / 0., 0.2, 0.4, 0.6, 0.8, 1.0  , 0.,
     2    0.0, 0.5, 1.0, 2.0, 3.0, 4.0, 5.0 /
      DATA DL218B
     1 /  .665,  .665,  .665,  .665,  .665,  .665,
     2    .425,  .492,  .539,  .550,  .550,  .550,
     3    .330,  .370,  .405,  .438,  .459,  .470,
     4    .184,  .215,  .250,  .284,  .318,  .350,
     5    .060,  .097,  .133,  .170,  .206,  .240,
     6    .000,  .000,  .044,  .083,  .127,  .170,
     7    .000,  .000,  .000,  .020,  .063,  .105  /
C
C              FIGURE 4.2.2.1-23B (RIGHT SIDE)
C
      DATA DR218B
     1 /  .665,  .665,  .665,  .665,  .665,  .665,
     2    .480,  .500,  .519,  .536,  .546,  .550,
     3    .338,  .388,  .430,  .458,  .471,  .470,
     4    .338,  .372,  .394,  .394,  .375,  .350,
     5    .410,  .375,  .341,  .308,  .272,  .240,
     6    .377,  .338,  .294,  .251,  .211,  .170,
     7    .342,  .300,  .246,  .194,  .146,  .100   /
C
C              FIGURE 4.2.2.1-24
C
      DATA T42119
     1 /  0., .05, .1, .15, .2, .25, .3, .35, .4, .45, .5  ,
     2   0., .2, .4, .6, .8, .9, 1.  /
      DATA D42119
     1 /.320, .348, .365, .394, .439, .480, .504, .518, .529, .537,.541,
     2  .376, .400, .429, .468, .518, .543, .558, .567, .574, .579,.582,
     3  .417, .445, .486, .544, .573, .587, .596, .603, .607, .610,.611,
     4  .440, .486, .564, .600, .614, .621, .626, .630, .632, .633,.634,
     5  .476, .580, .627, .638, .643, .646, .649, .651, .652, .653,.653,
     6  .485, .632, .648, .653, .655, .657, .659, .660, .661, .661,.661,
     7  .667, .667, .667, .667, .667, .667, .667, .667, .667, .667,.667/
C
C              FIGURE 4.2.2.1-25A
C
      DATA T4220A
     1 /    5.0, 10., 15., 20., 25., 30., 35., 40., 45., 50., 55., 60.,
     2  65.,70., 75., 80., 85., 90.  ,
     3   0., .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.0  /
      DATA DUMY1
     1 / -4.03,-3.25,-2.48,-1.80,-1.40,-1.14,-0.95,-0.80,-0.67,-0.56,
     2   -0.47,-0.39,-0.32,-0.25,-0.20,-0.13,-0.07,0.0,
     3   -4.03,-3.02,-2.10,-1.60,-1.24,-1.01,-0.85,-0.72,-0.61,-0.52,
     4   -0.44,-0.37,-0.30,-0.24,-0.19,-0.12,-0.06,0.0,
     5   -4.03,-2.70,-1.80,-1.34,-1.08,-0.90,-0.77,-0.66,-0.57,-0.49,
     6   -0.42,-0.36,-0.29,-0.23,-0.18,-0.11,-0.06,0.0,
     7   -4.03,-2.10,-1.46,-1.10,-0.90,-0.76,-0.67,-0.59,-0.51,-0.46,
     8   -0.40,-0.34,-0.28,-0.22,-0.17,-0.10,-0.06,0.0,
     9   -4.03,-1.67,-1.15,-0.90,-0.73,-0.63,-0.57,-0.51,-0.46,-0.41,
     A   -0.36,-0.31,-0.26,-0.21,-0.16,-0.10,-0.05,0.0  /
      DATA DUMY2
     1 / -2.40,-1.24,-0.85,-0.68,-0.58,-0.52,-0.48,-0.43,-0.40,-0.36,
     2   -0.32,-0.29,-0.24,-0.20,-0.15,-0.10,-0.05,0.0,
     3   -1.60,-0.84,-0.61,-0.50,-0.44,-0.41,-0.38,-0.35,-0.33,-0.31,
     4   -0.28,-0.25,-0.22,-0.18,-0.14,-0.09,-0.04,0.0,
     5   -0.90,-0.52,-0.39,-0.33,-0.31,-0.30,-0.29,-0.28,-0.27,-0.25,
     6   -0.23,-0.20,-0.18,-0.14,-0.11,-0.08,-0.04,0.0,
     7   -0.40,-0.26,-0.22,-0.20,-0.20,-0.20,-0.19,-0.19,-0.18,-0.18,
     8   -0.17,-0.15,-0.13,-0.11,-0.08,-0.05,-0.03,0.0,
     9   -0.12,-0.09,-0.08,-0.09,-0.09,-0.10,-0.10,-0.10,-0.10,-0.10,
     A   -0.09,-0.08,-0.07,-0.06,-0.04,-0.03,-0.02,0.0,
     B   18*0.0 /
C
C             FIGURE 4.2.1.1-21A
C
      DATA T4221A/
     1    0.0, .4, .6, .8, 1.0, 1.1, 1.25, 1.43, 1.667, 2.0, 10.0 ,
     2    0.0, 0.4, 0.8, 1.2, 2.0, 3.0, 4.0, 5.0  /
      DATA D4221A/
     1 2.25,2.46,2.42,2.33,2.21,2.14,2.07,1.99,1.91,1.83,1.43,
     2 2.25,2.63,2.69,2.71,2.66,2.61,2.55,2.48,2.39,2.30,1.85,
     3 2.25,2.74,2.87,2.93,2.93,2.91,2.87,2.78,2.68,2.56,1.96,
     4 2.25,2.78,2.95,3.04,3.09,3.08,3.06,2.96,2.86,2.71,1.96,
     5 2.25,2.81,3.01,3.13,3.25,3.27,3.25,3.18,3.06,2.78,1.38,
     6 2.25,2.83,3.04,3.19,3.31,3.33,3.33,3.26,3.14,2.87,1.52,
     7 2.25,2.83,3.04,3.22,3.34,3.36,3.35,3.30,3.18,2.94,1.74,
     8 2.25,2.83,3.04,3.22,3.34,3.36,3.35,3.30,3.18,2.94,1.74 /
C
C            FIGURE 4.2.1.1-21B
C
      DATA T4221B/
     1    0.0, .4, .6, .678, .8, .9, 1.0, 1.25, 2.0, 10.0 ,
     2     .0, .4, .8, 1.2, 2.0, 3.0, 4.0, 5.0  /
      DATA D4221B/
     1    2.08, 1.96, 1.87, 1.84, 1.84, 1.85, 1.85, 1.85, 1.85, 1.85,
     2    2.64, 2.59, 2.55, 2.53, 2.47, 2.42, 2.37, 2.35, 2.35, 2.43,
     3    2.62, 2.77, 2.79, 2.80, 2.80, 2.80, 2.78, 2.76, 2.76, 2.77,
     4    2.51, 2.84, 2.95, 2.98, 3.04, 3.07, 3.08, 3.04, 3.00, 2.94,
     5    2.35, 2.86, 3.04, 3.10, 3.20, 3.24, 3.24, 3.28, 3.32, 3.43,
     6    2.36, 2.90, 3.10, 3.18, 3.28, 3.30, 3.31, 3.38, 3.47, 3.62,
     7    2.37, 2.92, 3.14, 3.25, 3.35, 3.36, 3.37, 3.47, 3.61, 3.80,
     8    2.38, 2.95, 3.19, 3.33, 3.40, 3.41, 3.42, 3.56, 3.75, 3.98  /
C
C                   FIGURE 4.2.1.1-22A
C
      DATA T4222A/0.0,.5,1.0,1.25,1.50,1.75,2.0,2.5/
      DATA D4222A/0.0,-.88,-1.44,-1.64,-1.80,-1.90,-1.97,-2.00/
C
C                   FIGURE 4.2.1.1-22B
C
      DATA T4222B/1.0,1.4,1.8,2.2,2.6,3.0/
      DATA D4222B/0.0,2.0,4.5,7.7,11.6,16.0/
C
C                   FIGURE 4.2.1.2-35B
C
      DATA T4217B/0.0,.25,.30,.35,.4,.5,.6,.7,.75,.80,.85,1.0,1.111,
     11.25,1.666,2.5,3.33,10./
      DATA D4217B/1.2,1.2,1.215,1.235,1.265,1.36,1.5,1.67,1.735,1.77,
     11.79,1.785,1.74,1.65,1.47,1.355,1.315,1.255/
C
C                   FIGURE 4.2.3.1-27
C
      DATA T4227/
     10.0,.05,.15,.25,.35,.45,.55,.65,.70,.80,.90,1.0,
     21.,2.,3.,4.,5.,6.,8.,10.,16.,20./
      DATA D4227/
     14.68,3.55,2.41,1.63,1.05,0.63,0.38,0.20,0.14,0.05,.00,0.0,
     24.68,3.72,2.73,1.96,1.39,0.91,0.58,0.33,0.25,0.09,.01,0.0,
     34.68,3.81,2.90,2.17,1.56,1.06,0.68,0.40,0.30,0.13,.02,0.0,
     44.68,3.89,3.01,2.30,1.70,1.19,0.78,0.45,0.34,0.16,.03,0.0,
     54.68,3.93,3.15,2.42,1.80,1.28,0.85,0.50,0.38,0.18,.04,0.0,
     64.68,3.97,3.25,2.54,1.90,1.35,0.90,0.55,0.41,0.20,.05,0.0,
     74.68,4.06,3.36,2.69,2.04,1.47,1.00,0.60,0.45,0.22,.06,0.0,
     84.68,4.14,3.47,2.80,2.15,1.57,1.06,0.65,0.49,0.24,.07,0.0,
     94.68,4.22,3.65,3.00,2.32,1.71,1.17,0.73,0.55,0.28,.08,0.0,
     A4.68,4.34,3.80,3.16,2.48,1.82,1.25,0.80,0.60,0.30,.09,0.0/
C
C                   FIGURE 4.2.3.1-28
C
      DATA T4228/0.0,.05,.15,.30,.40,.50,.60,.75,.85,1.0,
     11.,2.,3.,4.,5.,6.,8.,10.,15.,20./
      DATA D4228/
     10.45,0.58,     0.55,0.41,0.30,0.18,0.11,.060,.030,0.0,
     21.75,1.50,      1.18,0.80,0.58,0.40,0.25,.065,.035,0.0,
     32.49,2.00,     1.52,1.00,0.70,0.48,0.30,.070,.040,0.0,
     43.00,2.35,     1.78,1.15,0.82,0.56,0.34,.075,.045,0.0,
     53.35,2.65,     1.95,1.25,0.90,0.61,0.39,.080,.055,0.0,
     63.72,2.93,     2.10,1.36,1.00,0.67,0.42,.085,.060,0.0,
     74.25,3.25,     2.39,1.50,1.08,0.73,0.48,.095,.065,0.0,
     84.90,3.55,     2.55,1.62,1.14,0.80,0.50,.100,.075,0.0,
     95.10,4.10,     2.90,1.88,1.35,0.90,0.58,.190,.085,0.0,
     A5.50,4.45,     3.12,2.01,1.43,0.98,0.62,.250,.100,0.0/
C
C                   FIGURE 4.2.3.1-44A
C
      DATA T44A/ 0.0,.05,.10,.20,.4,1.0,
     1.5,1.,2./
      DATA D44A/
     12.40,2.12,1.94,1.63,1.16,0.0,
     21.30,1.18,1.08,0.90,0.65,0.0,
     30.64,0.58,0.53,0.44,0.31,0.0/
C
C                   FIGURE 4.2.3.1-60
C
      DATA T4360/1.00,1.125,1.25,1.50,2.0,2.5,3.0,3.5,4.0,4.5,
     15.0,5.5,6.0/
      DATA D4360/.178,.215,.20,.178,.144,.118,.097,.080,.068,
     1.057,.049,.042,.037/
C
C                   FIGURE 4.2.3.1-50A-E
C
      DATA T5055/
     11.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,
     20.2,0.4,0.6,0.8,1.0,6*0.0,
     32.0,3.0,4.0,5.0,6.0/
      DATA DUMYA/
     1-.055,-.055,-.055,-.055,-.054,-.052,-.048,-.042,-.037,-.031,-.025,
     2-.055,-.055,-.055,-.055,-.054,-.052,-.048,-.042,-.037,-.031,-.025,
     3-.055,-.055,-.055,-.055,-.054,-.052,-.048,-.042,-.037,-.031,-.025,
     4-.118,-.118,-.118,-.103,-.088,-.075,-.064,-.054,-.046,-.038,-.032,
     5-.211,-.182,-.147,-.118,-.097,-.081,-.069,-.059,-.050,-.042,-.035,
     6-.005,-.005,-.005,-.005,-.005,-.005,-.005,-.005,-.005,-.006,-.006,
     7-.031,-.031,-.031,-.031,-.031,-.031,-.031,-.028,-.026,-.024,-.022,
     8-.069,-.069,-.069,-.069,-.067,-.058,-.050,-.043,-.037,-.032,-.026,
     9-.111,-.111,-.111,-.105,-.089,-.073,-.061,-.051,-.044,-.037,-.030,
     A-.210,-.180,-.145,-.118,-.096,-.080,-.068,-.058,-.050,-.042,-.036,
     B-.024,-.024,-.024,-.024,-.024,-.024,-.024,-.023,-.021,-.017,-.012,
     C-.044,-.044,-.044,-.044,-.044,-.043,-.040,-.036,-.032,-.028,-.024,
     D-.075,-.075,-.075,-.075,-.071,-.062,-.054,-.046,-.040,-.035,-.030,
     E-.112,-.112,-.111,-.101,-.087,-.074,-.062,-.052,-.045,-.038,-.032,
     F-.210,-.180,-.144,-.117,-.097,-.082,-.069,-.059,-.050,-.042,-.035/
      DATA DUMYB/
     1-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.031,-.029,-.026,-.023,
     2-.050,-.050,-.050,-.050,-.052,-.050,-.046,-.040,-.035,-.031,-.027,
     3-.080,-.080,-.080,-.081,-.074,-.065,-.056,-.048,-.041,-.035,-.030,
     4-.112,-.112,-.112,-.102,-.087,-.074,-.062,-.053,-.045,-.038,-.033,
     5-.210,-.140,-.146,-.118,-.098,-.082,-.069,-.058,-.050,-.043,-.036,
     6-.033,-.033,-.033,-.033,-.033,-.033,-.033,-.032,-.029,-.026,-.024,
     7-.058,-.058,-.058,-.058,-.058,-.054,-.048,-.042,-.037,-.033,-.029,
     8-.084,-.084,-.084,-.084,-.074,-.065,-.056,-.049,-.042,-.036,-.031,
     9-.116,-.116,-.116,-.104,-.088,-.074,-.062,-.052,-.045,-.039,-.033,
     A-.211,-.180,-.146,-.118,-.097,-.081,-.069,-.058,-.050,-.042,-.036/
C
C                   FIGURE 4.2.3.1-55 A-E
C
      DATA DUMYC/
     1-.026,-.026,-.026,-.026,-.026,-.026,-.027,-.025,-.023,-.021,-.019,
     2-.042,-.042,-.042,-.042,-.042,-.042,-.038,-.033,-.027,-.021,-.016,
     3-.065,-.065,-.065,-.065,-.064,-.058,-.051,-.043,-.035,-.028,-.020,
     4-.118,-.118,-.118,-.100,-.083,-.070,-.060,-.051,-.043,-.036,-.030,
     5-.211,-.180,-.144,-.118,-.097,-.081,-.068,-.057,-.049,-.041,-.035,
     6-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.030,
     7-.046,-.046,-.046,-.046,-.046,-.045,-.042,-.038,-.035,-.033,-.030,
     8-.070,-.070,-.070,-.070,-.068,-.060,-.053,-.046,-.040,-.036,-.032,
     9-.117,-.117,-.117,-.101,-.085,-.072,-.061,-.052,-.044,-.040,-.034,
     A-.210,-.180,-.144,-.118,-.097,-.081,-.068,-.058,-.049,-.042,-.035,
     B-.032,-.032,-.032,-.032,-.032,-.032,-.032,-.032,-.030,-.023,-.017,
     C-.050,-.050,-.050,-.050,-.050,-.050,-.047,-.042,-.037,-.033,-.030,
     D-.074,-.074,-.074,-.074,-.071,-.063,-.055,-.048,-.041,-.036,-.032,
     E-.106,-.106,-.107,-.099,-.086,-.074,-.063,-.053,-.045,-.040,-.036,
     F-.210,-.180,-.144,-.118,-.098,-.082,-.069,-.059,-.050,-.043,-.037/
      DATA DUMYD/
     1-.038,-.038,-.038,-.038,-.038,-.038,-.037,-.034,-.032,-.030,-.028,
     2-.060,-.060,-.060,-.060,-.059,-.054,-.048,-.042,-.038,-.034,-.030,
     3-.079,-.079,-.079,-.078,-.073,-.064,-.055,-.048,-.041,-.036,-.031,
     4-.108,-.108,-.108,-.100,-.085,-.073,-.062,-.053,-.045,-.039,-.033,
     5-.210,-.180,-.145,-.118,-.097,-.082,-.068,-.059,-.050,-.043,-.036,
     6-.050,-.050,-.050,-.050,-.049,-.046,-.042,-.038,-.033,-.029,-.027,
     7-.068,-.068,-.068,-.068,-.064,-.057,-.050,-.044,-.038,-.033,-.030,
     8-.084,-.084,-.084,-.083,-.076,-.067,-.058,-.049,-.042,-.036,-.032,
     9-.106,-.106,-.106,-.101,-.087,-.074,-.063,-.053,-.045,-.038,-.034,
     A-.211,-.180,-.146,-.118,-.097,-.081,-.068,-.058,-.049,-.042,-.035/
C
      NX=NXX+.5
      RNFS=FLC(I+42)
      NOSCYL=.FALSE.
      NOSTAL=.FALSE.
      RLBP=RLN+RLA
      RLB=XCOOR(NX)
      RLBT=RLB-RLBP
      IF(BTAIL.NE.1.AND.BTAIL.NE.2.)GO TO 1000
      TAIL=.TRUE.
      GO TO 1010
 1000 TAIL=.FALSE.
      RLBT=0.0
 1010 LOOP=2
      IF(TAIL.AND.(RLA.EQ.0.0))NOSTAL=.TRUE.
      IF(TAIL.AND.(RLA.NE.0.0))LOOP=3
      IF(.NOT.TAIL.AND.(RLA.EQ.0.0))LOOP=1
      LGH(1)=NX
      DO 1110 K=1,LOOP
         GO TO(1020,1030,1040),K
 1020     VAR(1)=RLN
          GO TO 1050
 1030     VAR(1)=RLBP
          IF(NOSTAL)VAR(1)=RLB
          GO TO 1050
 1040     VAR(1)=RLB
 1050     CALL INTERX(1,XCOOR,VAR,LGH,RADIUS,DIA,NX,NX,
     1                0,0,0,0,0,0,0,0,XVSR,2,ROUTID)
         GO TO(1060,1070,1100),K
 1060     DN=DIA*2.
          D1 = DN
          D2=DN
          GO TO 1110
 1070     IF(NOSTAL)GO TO 1090
          IF(LOOP.EQ.2)GO TO 1080
          D1=DIA*2.
          GO TO 1110
 1080     NOSCYL=.TRUE.
          D1=DIA*2.
          D2=D1
          GO TO 1110
 1090     D1=DN
          D2=DIA*2.
          GO TO 1110
 1100     NOSCT=.TRUE.
         D2=DIA*2.
 1110 CONTINUE
      IF(TRANSN)GO TO 1120
      MACH=FLC(I+2)
      BETA=SQRT(MACH**2-1.)
      GO TO 1130
 1120 MACH = 1.4
      BETA = 0.98
C
C  ***BODY SUPERSONIC LIFT CURVE SLOPE***
C
 1130 DCYL=(DN+D1)/2.0
      IF(D2.EQ.0.0)D2=0.3*DCYL
      FA=RLA/DCYL
      FN=RLN/DN
      VAR(1)=BETA/FN
      VAR(2)=FA/FN
      LGH(2)=8
      IF(BNOSE.EQ.1.) GO TO 1140
C
C                   FIGURE 4.2.1.1-21A (CNA FOR OGIVE CYLINDER)
C
      LGH(1)=11
      CALL INTERX(2,T4221A,VAR,LGH,D4221A,CNAOC,11,88,
     1            1,0,0,0,2,2,0,0,Q1121A,3,ROUTID)
      GO TO 1150
C
C                   FIGURE 4.2.1.1-21B (CNA FOR CONE CYLINDER)
C
 1140 LGH(1)=10
      CALL INTERX(2,T4221B,VAR,LGH,D4221B,CNAOC,10,80,
     1            1,0,0,0,1,2,0,0,Q1121B,3,ROUTID)
 1150 CONTINUE
      IF(.NOT.TAIL)GO TO 1170
      IF(D2/D1.GT.1.)GO TO 1160
C
C***  HERE FOR BOATTAIL
C
      THETAB=ATAN(.5*(D1-D2)/RLBT)
      THETAT=THETAB
      FB=RLBT/D1
      VAR(1)=FB/BETA
C
C                   FIGURE 4.2.1.1-22A(INCREMENT IN CNA DUE TO BOATTAIL)
C
      LGH(1)=8
      CALL INTERX(1,T4222A,VAR,LGH,D4222A,DCD1D2,8,8,
     1            0,0,0,0,0,0,0,0,Q1122A,3,ROUTID)
      DELCNA=DCD1D2*(1.-(D2/D1)**2)
      GO TO 1180
 1160 CONTINUE
C
C                   FIGURE 4.2.1.1-22B(INCREMENT IN CNA DUE TO FLARE)
C
      VAR(1)=D2/D1
      LGH(1)=6
      CALL INTERX(1,T4222B,VAR,LGH,D4222B,DCCOS,6,6,
     1            0,0,0,0,2,0,0,0,Q1122B,3,ROUTID)
      ARG=.5*(D2-D1)/RLBT
      THETAF=ATAN(ARG)
      SBD(102)=THETAF
      THETAT=THETAF
      DELCNA=DCCOS*COS(THETAF)**2
      GO TO 1180
 1170 DELCNA=0.0
 1180 CNA =(CNAOC+DELCNA)*PI*D1**2/(4.*RAD*SR)
      IF(TRANSN) GO TO 1200
      SB=PI*D2**2/4.
      A1 = SB
      IF(ELLIP .LE. UNUSED) ELLIP = 1.0
      IF(ELLIP .EQ. 1.0) A1 = CNA*SR*RAD/2.0
      CALL TRAPZ(RADIUS,NX,XCOOR,SP,1)
      SP=SP*2.
C
C  ***SUPERSONIC BODY LIFT VS ANGLE OF ATTACK***
C
      DO 1190 J=1,NALPHA
         ALSCHR(J)=ALSCHD (J)/RAD
         MC(J)=MACH*ABS(SIN(ALSCHR(J)))
C
C                   FIGURE 4.2.1.2-35B(CDC)
C
         VAR(1)=MC(J)
         LGH(1)=18
         CALL INTERX(1,T4217B,VAR,LGH,D4217B,CDC(J),18,18,
     1               0,0,0,0,0,0,0,0,Q1217B,3,ROUTID)
         CFLOW(J)=CDC(J)*SP*SIN(ALSCHR(J))**2/SR
         IF(ALSCHR(J) .LT. 0.0) CFLOW(J) = -CFLOW(J)
         IF(ELLIP.LT.1.)AOB=1./ELLIP
         IF(ELLIP.GE.1.)AOB=ELLIP
         IF(ELLIP.GE.1.)CNOCNS=1./AOB
         IF(ELLIP.LT.1.)CNOCNS=AOB
         CNOCNN=1.0
         IF(ELLIP.LT.1.)CNOCNN=1.5*SQRT(AOB)*(-1./AOB**2/(1.-1./AOB**2)
     1       **1.5*ALOG(AOB*(1.+SQRT(1.-1./AOB**2)))+1./(1.-1./AOB**2))
         IF(ELLIP.GT.1.)CNOCNN=1.5*SQRT(1./AOB)*(AOB**2/(AOB**2-1.)**1.5
     1                 *ATAN(SQRT(AOB**2-1.))-1./(AOB**2-1.))
         CNPOT(J)=SIN(2.*ALSCHR(J))*COS(ALSCHR(J)/2.)*A1*CNOCNS/SR
         CNVIS(J)=CFLOW(J)*CNOCNN
 1190 CN(J)=SIN(2.*ALSCHR(J))*COS(ALSCHR(J)/2.)*A1*CNOCNS/SR
     1  + CFLOW(J)*CNOCNN
 1200 CONTINUE
      LGH(1)=6
C
C  ***SUPERSONIC PITCHING MOMENT SLOPE***
C
      LGH(2)=9
      VAR(1)=BETA/FN
      VAR(2)=FA/FN
      IF(BNOSE.EQ.1.)GO TO 1220
      IF(VAR(1).GT.1.)GO TO 1210
C
C                   FIGURE 4.2.2.1-23A LEFT SIDE (XCP/RLBP)  OGIVE
C
      CALL INTERX(2,T4218A,VAR,LGH,DL218A,XCPLB,9,54,
     1            1,0,0,0,0,2,0,0,Q2118A,3,ROUTID)
      GO TO 1240
 1210 VAR(1)=1./VAR(1)
C
C                   FIGURE 4.2.2.1-23B RIGHT SIDE(XCP/RLBP) OGIVE
C
      CALL INTERX(2,T4218A,VAR,LGH,DR218A,XCPLB,9,54,
     1            1,0,0,0,0,2,0,0,Q2118A,3,ROUTID)
      GO TO 1240
 1220 CONTINUE
C
C                   FIGURE 4.2.2.1-23B LEFT SIDE (XCP/RLBP) CONE
C
      LGH(1)=6
      LGH(2)=7
      IF(VAR(1).GT.1.)GO TO 1230
      CALL INTERX(2,T4218B,VAR,LGH,DL218B,XCPLB,7,42,
     1            1,0,0,0,0,2,0,0,Q2118B,3,ROUTID)
      GO TO 1240
 1230 VAR(1)=1./VAR(1)
C
C                   FIGURE 4.2.2.1-23B RIGHT SIDE (XCP/RLBP) CONE
C
      CALL INTERX(2,T4218B,VAR,LGH,DR218B,XCPLB,7,42,
     1            1,0,0,0,0,2,0,0,Q2118B,3,ROUTID)
 1240 CONTINUE
      CMAOC=(XCG/RLBP-XCPLB)*CNAOC
      IF(.NOT.TAIL)GO TO 1250
      GO TO 1260
 1250 DELCMA=0.0
      GO TO 1280
 1260 CONTINUE
      IF(D2/D1.GE.1.0)GO TO 1270
      FLARE=.FALSE.
C
C                   FIGURE 4.2.2.1-24 (XCPB) BOATTAIL
C
      VAR(1)=BETA*TAN(THETAB)
      VAR(2)=D2/D1
      LGH(1)=11
      LGH(2)=7
      CALL INTERX(2,T42119,VAR,LGH,D42119,XCPBLB,11,77,
     1            0,0,0,0,2,0,0,0,Q22119,3,ROUTID)
      DELCMA=DELCNA*(2.*XCG/RLBP-1.0-XCPBLB*RLBT/RLBP)
      GO TO 1280
 1270 CONTINUE
      FLARE=.TRUE.
      VAR(1)=THETAF*RAD
      VAR(2)=D1/D2
      LGH(1)=18
      LGH(2)=11
C
C                   FIGURE 4.2.2.1-25A (CMAP) FLARE
C
      CALL INTERX(2,T4220A,VAR,LGH,D4220A,CMAP,18,198,
     1            0,0,0,0,0,0,0,0,Q2120A,3,ROUTID)
      DELCMA=CMAP*(D2**3/(D1**2*RLBP))+((XCG-RLBP)/RLBP)*DELCNA
 1280 CMA=(CMAOC +DELCMA)*PI*D1**2*RLBP/(4.*SR*CRBAR*RAD )
      IF(TRANSN)GO TO 1310
C
C                   COMPUTE CENTROID OF PLANFORM AREA
C
      DO 1290 K=1,NX
         REQ(K)=SQRT(S(K)/PI)
 1290 RX(K)=REQ(K)*XCOOR(K)
      CALL TRAPZ(RX,NX,XCOOR,XC,1)
      XC=2.*XC/SP
      CALL TRAPZ(REQ,NX,XCOOR,VB,-1)
C
C *** SUPERSONIC PITCHING MOMENT VS ANGLE OF ATTACK ***
C
      ARG1=VB/(SR*CRBAR)-(RLB-XCG)*SB/(SR*CRBAR)
      IF(ELLIP .EQ. 1.0) ARG1 = CMA*RAD/2.0
      DO 1300 J=1,NALPHA
         CMPOT(J)=SIN(2.*ALSCHR(J))*COS(ALSCHR(J)/2.)*ARG1*CNOCNS
         CMVIS(J)=CFLOW(J)/CRBAR*(XCG-XC)*CNOCNN
 1300 CM(J)=CFLOW(J)/CRBAR*(XCG-XC)*CNOCNN+SIN(2.*ALSCHR(J))*
     1 COS(ALSCHR(J)/2.)*ARG1*CNOCNS
C
C  ***SUPERSONIC BODY NOSE WAVE DRAG***
C
 1310 VAR(2)=2.*RLN/(BETA*DN)
      VAR(1)=0.0
      IF(BNOSE.EQ.1.)GO TO 1320
C
C                   FIGURE 4.2.3.1-27 (OGIVE)
C
      LGH(1)=12
      LGH(2)=10
      CALL INTERX(2,T4227,VAR,LGH,D4227,CDN2P,12,120,
     1            0,2,0,0,0,2,0,0,Q23127,3,ROUTID)
      GO TO 1330
 1320 LGH(1)=10
      LGH(2)=10
      CALL INTERX(2,T4228,VAR,LGH,D4228,CDN2P,10,100,
     1            0,0,0,0,0,2,0,0,Q23128,3,ROUTID)
 1330 CONTINUE
      CDN2=CDN2P*PI*DN**4/(16.*SR*RLN**2)
C
C  ***SUPERSONIC BODY SKIN FRICTION DRAG***
C
      ISTOP=NX-1
      SS=0.0
      DO 1340 J=1,ISTOP
 1340 SS=SS+ (PERIM(J+1)+PERIM(J))*(XCOOR(J+1)-XCOOR(J))/2.
      RNB=RLB*RNFS
      IF(RUFF.EQ.0.0)GO TO 1350
      ARG=12.*RLB/RUFF
C
C                   FIGURE 4.1.5.1-27 (EQUATION FOR RLCOFF)
C
      RACH=MACH
      IF(RACH.GT.3.0)RACH=3.0
      CALL TBFUNX(RACH,CEPT,DYDX,4,X27M,X27I,C27,I27,MI,NG,
     1            0,0,4HSET ,1,ROUTID)
      RLCOFF=ARG**1.0482*10.0**CEPT
      IF(RLCOFF.LT.RNB)RNB=RLCOFF
C
C                   CALL FIG26 FOR COMPUTATION OF CF
C
 1350 CALL FIG26(RNB,RACH,CF)
      CDF=CF*SS/SR
C
C  ***SUPERSONIC AFTERBODY INTERFERENCE DRAG***
C
      IF(RLA.EQ.0.0)GO TO 1370
      DA=D1
      DB=DN
      ARG=RLA
 1360 VAR(1)=(DB/DA)**2
      VAR(2)=RLN/ARG
      LGH(1)=6
      LGH(2)=3
      CALL INTERX(2,T44A,VAR,LGH,D44A,CDANF,6,18,
     1            0,0,0,0,0,0,0,0,Q3144A,3,ROUTID)
      CDANC=CDANF*PI*DB**4/(16.*SR*ARG**2)
      GO TO 1390
 1370 IF(RLBT.EQ.0.0)GO TO 1380
      DA=D1
      DB=D2
      ARG=RLBT
      GO TO 1360
 1380 CDANC=0.0
 1390 CONTINUE
C
C  ***SUPERSONIC AFTER BODY WAVE DRAG***
C
      IF(RLA.EQ.0.0)GO TO 1430
      IF(.NOT.TAIL)GO TO 1430
      IF(D2/D1.GT.1.)GO TO 1400
      DD=D1
      AA=D2
      GO TO 1410
 1400 DD=D2
      AA=D1
 1410 VAR(2)=2.*RLBT/(BETA*DD)
      VAR(1)=(AA/DD)**2
      LGH(2)=10
      IF(BTAIL.EQ.1.)GO TO 1420
C
C                   FIGURE 4.2.3.1-27 (OGIVE)
C
      LGH(1)=12
      CALL INTERX(2,T4227,VAR,LGH,D4227,CDAB,12,120,
     1            0,2,0,0,0,2,0,0,Q23127,3,ROUTID)
      GO TO 1440
 1420 LGH(1)=10
C
C                   FIGURE 4.2.3.1-28 (CONE)
C
      CALL INTERX(2,T4228,VAR,LGH,D4228,CDAB,10,100,
     1            0,0,0,0,0,2,0,0,Q23128,3,ROUTID)
      GO TO 1440
 1430 CDAB=0.0
      GO TO 1450
 1440 CDA=CDAB*PI*DD**4/(16.*SR*RLBT**2)
 1450 CONTINUE
C
C  ***SUPERSONIC BODY BASE DRAG***
C
      DMAX=RADIUS(1)
      DO 1460 J=1,NX
 1460 IF(DMAX.LT.RADIUS(J))DMAX=RADIUS(J)
      DMAX=2.*DMAX
      IF(RLBT.NE.0.0.OR.(D2/D1.LT.1.0))GO TO 1470
C
C                   FIGURE 4.2.3.1-60 (CDB)
C
      VAR(1)=MACH
      LGH(1)=13
      CALL INTERX(1,T4360,VAR,LGH,D4360,CDD,13,13,
     1            0,0,0,0,0,0,0,0,Q23160,3,ROUTID)
      GO TO 1500
 1470 CONTINUE
      VAR(1)=MACH
      VAR(2)=D2/DMAX
      VAR(3)=RLBT/D1
      LGH(1)=11
      LGH(2)=5
      LGH(3)=5
      IF(BTAIL.EQ.1.)GO TO 1480
C
C                   FIGURE 4.2.3.1-50 (CPB FOR OGIVES)  A-E
C
      CALL INTERX(3,T5055,VAR,LGH,D4350,CPB,11,275,
     1            0,0,2,0,0,0,2,0,Q23150,3,ROUTID)
      GO TO 1490
C
C                   FIGURE 4.2.3.1-55 (CPB FOR CONES)  A-E
C
 1480 CALL INTERX(3,T5055,VAR,LGH,D4355,CPB,11,275,
     1            0,0,2,0,0,0,2,0,Q23155,3,ROUTID)
 1490 CDD=-CPB*(D2/DMAX)**2
 1500 CDB=CDD*PI*DMAX**2/(4.*SR)
C
C  ***SUPERSONIC BODY DRAG AT ANGLE OF ATTACK***
C
      CDO=CDF+CDN2+CDA+CDANC+CDB
      IF(TRANSN)RETURN
      DO 1510 J=1,NALPHA
         COSA=COS(FLC(J+22)/RAD)
         SINA=SIN(FLC(J+22)/RAD)
         CA(J) = CDO*COSA**2
         CL(J) = CN(J)*COSA-CA(J)*SINA
         CD(J) = CA(J)*COSA+CN(J)*SINA
 1510 CONTINUE
      RETURN
      END