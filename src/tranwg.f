      SUBROUTINE TRANWG(CNA, DCNA)
C
C*** COMPUTES THE LIFT CURVE SLOPE AT MACH=1.4 WHICH IS USED IN TRSONI
C
      REAL MACH,KSHARP
      LOGICAL SUPLE
      DIMENSION DUMY1(184),DUMY2(184),DUMY3(184),DUMY5(184),
     1          DUMY6(184),DUMY4(184)
      DIMENSION T13246(52),D13246(1104),VAA(4),LGA(4),VAB(4),LGB(4),
     1 A1350(17), B1350(19),DA50(72),DB50(88),G13246(9),DG3246(9)
      DIMENSION WTYPE(4)
      DIMENSION ROUTID(2),Q3250A(3),Q3250B(3),Q3246A(3),Q3246G(3)
      DIMENSION XM(3), CN(3), BB(3)
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /WINGD/  A(195)
      COMMON /WINGI/  WINGIN(77)
      COMMON /OPTION/ SW
C
      EQUIVALENCE (SRSTAR,A(3))
      EQUIVALENCE (TAPEXP,A(27)),(TANLE,A(62)),(SWEPLE,A(58)),
     1(AR,A(7)),(TRATIP,A(25)),(COSLE,A(61)),(DELTAY,WINGIN(17)),
     2(TANLEO,A(86)),(TANLEI,A(62)),(KSHARP,WINGIN(71))
      EQUIVALENCE (D13246(1),DUMY1(1)),(D13246(185),DUMY2(1)),(D13246(36
     19),DUMY3(1)),(D13246(553),DUMY4(1)),(D13246(737),DUMY5(1)) ,
     2(D13246(921),DUMY6(1))
C
      DATA Q3250A/4H4.1.,4H3.2-,4H60A /,Q3246A/4H4.1.,4H3.2-,4H56A /,
     1     Q3250B/4H4.1.,4H3.2-,4H60B /,Q3246G/4H4.1.,4H3.2-,4H56G /,
     2 ROUTID/4HTRAN,4HWG  /
      DATA XM / 1.3, 1.4, 1.5 /
C
C              FIGURE 4.1.3.2-60A (CNA/CNA)T FOR SUBSONIC L.E.
C
      DATA A1350/
     1 0.,     .3,     .4,     .5,     .6,     .7,     .8,     .9,
     2 1.0001 ,
     3 0.,     .41,    .82,    1.24,   2.12,   3.18,   6.95,   16.1 /
      DATA DA50/
     1 1.,     1.,     1.,     1.,     1.,     1.,     1.,     1.,
     2         1.,
     3 1.05,   1.05,   1.05,   1.05,   .985,   .945,   .915,   .9,
     4 .9,
     5 1.04,   1.04,   1.04,   1.04,   .965,   .908,   .87,    .85,
     6 .84,
     7 1.12,   1.12,   1.12,   1.015,  .94,    .88,    .838,   .81,
     8 .796,
     9 1.11,   1.11,   1.11,   1.,     .903,   .84,    .795,   .765,
     A .75,
     B 1.08,   1.08,   1.08,   .954,   .865,   .8,     .75,    .72,
     C .7,
     D 1.2,    1.2,    1.043,  .907,   .817,   .75,    .707,   .675,
     E .66,
     F 1.14,   1.14,   .975,    .857,  .772,   .717,   .675,   .65,
     G .632 /
C
C              FIGURE 4.1.3.2-60B (CNA/CNA)T FOR SUPERSONIC L.E.
C
      DATA B1350/
     1 0.,     .1,     .2,      .3,    .4,     .5,     .6,     .7,
     2 .8,     .9,     1.0001 ,
     3 0.,     4.,     8.,      12.,   20.,    30.,    50.,    70./
      DATA DB50/
     1 1.,     1.,     1.,      1.,    1.,     1.,     1.,     1.,
     2 1.,     1.,     1.,
     3 1.15,   1.15,   1.15,    1.15,  1.095,  1.04,   .99,    .96,
     4 .935,   .915,   .9,
     5 1.12,   1.12,   1.12,    1.12,  1.05,   .985,   .94,    .905,
     6 .88,    .857,   .84,
     7 1.15,   1.15,   1.15,    1.08,  1.005,  .945,   .902,   .87,
     8 .842,   .82,    .796,
     9 1.22,   1.14,   1.05,    .98,   .93,    .89,    .853,   .823,
     A .795,   .77,    .75,
     B 1.13,   1.05,   .98,    .925,   .88,    .845,   .81,    .782,
     C .752,   .73,    .7,
     D 1.02,   .942,   .895,   .855,   .82,    .79,    .76,    .735,
     E .71,    .685,   .66,
     F 1.,     .92,    .87,    .825,   .79,    .755,   .728,   .7,
     G .678,   .655,   .632 /
C
C              FIGURE 4.1.3.2-56G (CNA/A) FOR A*BETA LESS THAN 1.0
C
      DATA G13246/0.,.2,.4,.45,.5,.6,.8,.9,1.0/
      DATA DG3246/1.61,1.58,1.55,1.57,1.62,1.75,1.94,2.0,2.0/
C
C              FIGURE 4.1.3.2-56A-F (WING SUPERSONIC CNA)
C
      DATA T13246
     1  / 0.,.1,.2,.3,.33,.4,.5,.6,.7,.8,.9,1.0,1.111,1.25,1.429,1.667,
     2    2.0,2.5,2.941,4.167,7.143,14.286, 30. ,
     3    .25,.5,1.,2.,3.,4.,5.,6. , 15*0.,
     4    0.,.2,.25,.3333,.5,1.0/
C
C     FIG 4.1.3.2-56A
C
      DATA DUMY1
     1  /  .39, .39, .39, .39, .39, .39, .39, .39, .39, .39, .39, .41,
     2     .44, .5 , .58, .65, .80,1.0 ,1.15,1.55,2.40,3.92,4.0 ,
     3     .77, .77, .78, .78, .79, .79, .80, .80, .80, .81, .82, .84,
     4     .92,1.0 ,1.18,1.32,1.60,1.9 ,2.18,2.80,3.84,3.92,4.0 ,
     5    1.55,1.56,1.57,1.57,1.59,1.59,1.60,1.63,1.66,1.68,1.70,1.75,
     6    1.88,2.09,2.30,2.6 ,2.94,3.35,3.70,3.80,3.98,3.98,4.0 ,
     7    3.15,3.15,3.15,3.15,3.15,3.15,3.17,3.19,3.23,3.27,3.33,3.4 ,
     8    3.46,3.54,3.60,3.7 ,3.75,3.8 ,3.86,3.91,4.0 ,4.0 ,4.0 ,
     9    4.71,4.74,4.83,5.09,5.25,5.05,4.80,4.55,4.30,4.09,3.90,3.72,
     A    3.78,3.8 ,3.83,3.88,3.90,3.94,3.92,3.96,4.0 ,4.0 ,4.0 ,
     B    6.29,6.2 ,5.99,5.72,5.61,5.42,5.18,4.9 ,4.64,4.42,4.2 ,4.0 ,
     C    4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,4.0 ,
     D    6.3 ,6.34,6.39,6.08,5.97,5.78,5.5 ,5.2 ,4.95,4.7 ,4.48,4.25,
     E    4.2 ,4.18,4.14,4.11,4.07,4.05,4.04,4.02,4.  ,4.  ,4.  ,
     F    6.32,6.4 ,6.4 ,6.34,6.32,6.13,5.82,5.51,5.25,4.99,4.73,4.5 ,
     G    4.4 ,4.32,4.27,4.2 ,4.13,4.11,4.07,4.04,4.  ,4.  ,4.  /
C
C     FIG 4.1.3.2-56B
C
      DATA DUMY2
     1  /  .41, .41, .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .41,
     2     .41, .48, .56, .67, .84,1.08,1.29,1.83,2.80,3.8 ,4.0 ,
     3     .8 , .8 , .8 , .8 , .8 , .8 , .8 , .8 , .8 , .8 , .83, .85,
     4     .98,1.09,1.27,1.48,1.80,2.25,2.53,3.22,3.79,3.92,4.  ,
     5    1.57,1.59,1.6 ,1.6 ,1.6 ,1.61,1.63,1.65,1.69,1.73,1.77,1.8 ,
     6    2.  ,2.26,2.57,2.9 ,3.27,3.53,3.65,3.8 ,3.91,3.97,4.  ,
     7    3.17,3.17,3.22,3.4 ,3.5 ,3.6 ,3.7 ,3.67,3.58,3.49,3.37,3.23,
     8    3.38,3.52,3.62,3.71,3.80,3.88,3.9 ,3.95,3.97,3.99,4.0 ,
     9    4.72,5.  ,5.1 ,5.02,4.97,4.84,4.64,4.45,4.24,4.05,3.89,3.70,
     A    3.84,3.91,3.97,3.99,4.0 ,4.  ,4.  ,4.  ,3.99,4.  ,4.  ,
     B    5.57,5.6 ,5.62,5.61,5.6 ,5.42,5.15,4.91,4.7 ,4.48,4.25,4.08,
     C    4.13,4.18,4.16,4.11,4.09,4.05,4.02,4.01,4.  ,4.  ,4.  ,
     D    5.73,5.77,5.79,5.79,5.77,5.75,5.6 ,5.33,5.08,4.83,4.59,4.4 ,
     E    4.42,4.4 ,4.32,4.23,4.17,4.08,4.05,4.03,4.01,4.  ,4.  ,
     F    5.83,5.88,5.91,5.93,5.93,5.91,5.88,5.68,5.4 ,5.14,4.9 ,4.7 ,
     G    4.68,4.59,4.46,4.33,4.23,4.13,4.1 ,4.06,4.02,4.01,4.  /
C
C     FIG 4.1.3.2-56C
C
      DATA DUMY3
     1  /  .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .42,
     2     .43, .5 , .6 , .71, .9 ,1.12,1.35,1.97,2.95,3.80,4.  ,
     3     .8 , .8 , .8 , .8 , .8 , .8 , .8 , .81, .82, .83, .83, .88,
     4     .95,1.06,1.23,1.46,1.83,2.3 ,2.65,3.32,3.76,3.92,4.  ,
     5    1.59,1.59,1.59,1.59,1.59,1.6 ,1.62,1.65,1.68,1.72,1.78,1.82,
     6    2.  ,2.29,2.65,3.  ,3.27,3.5 ,3.6 ,3.78,3.90,3.98,4.  ,
     7    3.14,3.2 ,3.41,3.62,3.68,3.75,3.7 ,3.62,3.51,3.42,3.3 ,3.18,
     8    3.34,3.5 ,3.6 ,3.7 ,3.8 ,3.85,3.88,3.93,3.98,4.0 ,4.  ,
     9    4.7 ,4.85,5.02,4.98,4.91,4.8 ,4.6 ,4.4 ,4.2 ,4.  ,3.82,3.68,
     A    3.8 ,3.9 ,3.98,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,
     B    5.4 ,5.44,5.45,5.45,5.42,5.35,5.12,4.9 ,4.69,4.48,4.22,4.02,
     C    4.12,4.18,4.17,4.15,4.1 ,4.05,4.04,4.01,4.  ,4.  ,4.  ,
     D    5.61,5.63,5.64,5.62,5.61,5.6 ,5.54,5.3 ,5.02,4.8 ,4.6 ,4.39,
     E    4.42,4.44,4.38,4.26,4.16,4.1 ,4.07,4.03,4.01,4.  ,4.  ,
     F    5.72,5.75,5.76,5.78,5.77,5.76,5.72,5.69,5.4 ,5.15,4.9 ,4.68,
     G    4.68,4.6 ,4.49,4.33,4.22,4.15,4.10,4.06,4.02,4.01,4.  /
C
C      FIG 4.1.3.2-56D
C
      DATA DUMY4
     1  /  .41, .41, .41, .41, .41, .41, .41, .41, .41, .41, .41, .41,
     2     .43, .50, .6 , .71, .89,1.11,1.35,2.00,3.00,3.72,4.00,
     3     .82, .82, .81, .8 , .8 , .81, .82, .83, .84, .85, .87, .89,
     4     .98,1.1 ,1.3 ,1.5 ,1.82,2.23,2.68,3.3 ,3.7 ,3.91,4.  ,
     5    1.6 ,1.59,1.58,1.58,1.58,1.59,1.60,1.62,1.66,1.73,1.81,1.92,
     6    2.2 ,2.45,2.7 ,2.98,3.22,3.45,3.59,3.75,3.7 ,3.91,4.  ,
     7    3.13,3.18,3.32,3.6 ,3.64,3.72,3.70,3.64,3.54,3.45,3.3 ,3.14,
     8    3.32,3.48,3.6 ,3.7 ,3.79,3.87,3.9 ,3.95,3.99,4.  ,4.  ,
     9    4.71,4.76,4.8 ,4.83,4.84,4.7 ,4.53,4.34,4.18,4.  ,3.82,3.63,
     A    3.78,3.9 ,3.98,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,
     B    5.2 ,5.22,5.22,5.2 ,5.2 ,5.15,5.1 ,4.88,4.63,4.42,4.21,4.0 ,
     C    4.15,4.21,4.21,4.17,4.14,4.07,4.05,4.03,4.01,4.  ,4.  ,
     D    5.45,5.47,5.47,5.45,5.45,5.41,5.36,5.3 ,5.02,4.81,4.58,4.36,
     E    4.45,4.47,4.41,4.30,4.19,4.12,4.08,4.02,4.  ,4.  ,4.  ,
     F    5.58,5.59,5.59,5.59,5.59,5.58,5.57,5.53,5.41,5.14,4.91,4.65,
     G    4.7 ,4.65,4.53,4.4 ,4.27,4.16,4.12,4.05,4.02,4.01,4.  /
C
C     FIG 4.1.3.2-56E
C
      DATA DUMY5
     1 /   .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 , .4 ,
     2     .44, .52, .63, .78, .98,1.21,1.4 ,2.07,3.07,3.6 ,4.  ,
     3     .8 , .8 , .79, .79, .79, .79, .8 , .81, .83, .85, .88, .9 ,
     4    1.01,1.17,1.38,1.62,2.00,2.50,2.74,3.22,3.66,3.87,4.  ,
     5    1.58,1.59,1.62,1.71,1.76,1.77,1.8 ,1.85,1.88,1.91,1.92,1.93,
     6    2.13,2.4 ,2.6 ,2.88,3.12,3.39,3.51,3.71,3.87,3.99,4.  ,
     7    3.15,3.21,3.38,3.61,3.7 ,3.67,3.59,3.5 ,3.4 ,3.29,3.17,3.03,
     8    3.18,3.37,3.51,3.67,3.78,3.85,3.88,3.93,3.98,4.  ,4.  ,
     9    4.42,4.42,4.41,4.40,4.39,4.38,4.35,4.25,4.08,3.9 ,3.72,3.57,
     A    3.70,3.86,3.93,3.99,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,4.  ,
     B    4.88,4.85,4.81,4.80,4.79,4.77,4.73,4.68,4.53,4.35,4.15,3.99,
     C    4.08,4.20,4.23,4.19,4.1 ,4.07,4.05,4.01,4.  ,4.  ,4.  ,
     D    5.08,5.09,5.08,5.08,5.07,5.06,5.03,4.99,4.92,4.74,4.53,4.3 ,
     E    4.43,4.48,4.43,4.32,4.20,4.12,4.08,4.03,4.01,4.  ,4.  ,
     F    5.19,5.21,5.22,5.23,5.23,5.23,5.23,5.21,5.19,5.09,4.88,4.6 ,
     G    4.72,4.69,4.58,4.41,4.28,4.18,4.12,4.07,4.02,4.01,4.  /
C
C     FIG 4.1.3.2-56F
C
      DATA DUMY6
     1 /   .4 , .4 , .4 , .4 , .4 , .41, .44, .49, .51, .54, .59, .61,
     2     .69, .75, .81, .9 ,1.01,1.26,1.53,2.1 ,2.9 ,3.42,4.  ,
     3     .81, .81, .81, .83, .84, .86, .88, .91, .99,1.02,1.1 ,1.19,
     4    1.3 ,1.42,1.58,1.75,2.  ,2.34,2.6 ,3.  ,3.46,3.71,4.   ,
     5    1.6 ,1.58,1.59,1.6 ,1.6 ,1.61,1.67,1.7 ,1.79,1.86,1.92,2.  ,
     6    2.13,2.32,2.51,2.75,2.97,3.2 ,3.35,3.58,3.8 ,3.9 ,4.  ,
     7    3.13,3.1 ,3.08,3.05,3.04,3.03,3.01,2.99,2.95,2.93,2.91,2.89,
     8    3.02,3.2 ,3.37,3.52,3.67,3.77,3.82,3.88,3.92,3.97,4.  ,
     9    3.79,3.84,3.86,3.8 ,3.79,3.72,3.63,3.58,3.5 ,3.47,3.43,3.41,
     A    3.57,3.75,3.89,3.98,4.  ,3.98,3.94,3.93,3.92,3.99,4.  ,
     B    4.12,4.2 ,4.19,4.09,4.06,4.03,3.99,3.95,3.92,3.9 ,3.88,3.87,
     C    4.01,4.1 ,4.21,4.21,4.12,4.05,4.  ,3.96,3.99,4.  ,4.  ,
     D    4.39,4.45,4.44,4.39,4.35,4.31,4.27,4.25,4.25,4.25,4.25,4.25,
     E    4.37,4.50,4.49,4.39,4.23,4.1 ,4.03,3.99,4.  ,4.  ,4.  ,
     F    4.6 ,4.68,4.65,4.59,4.57,4.54,4.5 ,4.45,4.48,4.53,4.59,4.61,
     G    4.71,4.75,4.69,4.5 ,4.31,4.18,4.08,4.01,4.  ,4.  ,4.  /
      DATA WTYPE/4HSTRA,4HDOUB,4HCRAN,4HCURV/
C
      IF(TANLEO.EQ.0.0)TANLEO=.00001
      IF(TANLEI.EQ.0.0)TANLEI=.00001
      DO 1100 I=1,3
         BETA = SQRT(XM(I)**2-1.0)
         BB(I) = BETA
C
C       **STRAIGHT TAPERED SUPERSONIC NORMAL FORCE SLOPE**
C
         BOVERT=BETA/TANLE
         CA=COSLE
         IF( BOVERT.GT.1.0)GO TO 1000
         SUPLE=.FALSE.
         GO TO 1010
 1000    SUPLE=.TRUE.
 1010    CONTINUE
C
C                   FIGURE 4.1.3.2-60A (CNA/CNA)T FOR SUBSONIC L.E.
C
         DELTYT=DELTAY/CA
 1020    IF(SUPLE)GO TO 1030
         VAB(1)=BOVERT
         VAB(2)=DELTYT
         LGB(1)=9
         LGB(2)=8
         CALL INTERX(2,A1350,VAB,LGB,DA50,CNCNT,9,72,
     1               2,2,0,0,0,2,0,0,Q3250A,3,ROUTID)
         GO TO 1040
C
C                   FIGURE 4.1.3.2-60B (CNA/CNA)T FOR SUPERSONIC L.E.
C
 1030    CONTINUE
         ARG=DELTAY/(5.85*CA)
         DELTDT=ATAN(ARG)*RAD
         VAB(1)=1./BOVERT
         VAB(2)=DELTDT
         LGB(1)=11
         LGB(2)=8
         CALL INTERX(2,B1350,VAB,LGB,DB50,CNCNT,11,88,
     1               2,2,0,0,0,2,0,0,Q3250B,3,ROUTID)
 1040    IF(TRATIP.EQ.1.0.AND.SWEPLE.EQ.0.0) GO TO 1060
C
C                   NON-RECTANGULAR WING ANALYSIS
C                   FIGURES 4.1.3.2-56A THROUGH F
C
 1050    VAA(1)=BOVERT
         VAA(2)=AR *TANLE
         VAA(3)=TAPEXP
         LGA(1)=23
         LGA(2)=8
         LGA(3)=6
         CALL INTERX(3,T13246,VAA,LGA,D13246,BCNA,23,1104,
     1               0,2,0,0,0,2,0,0,Q3246A,3,ROUTID)
         IF(SUPLE)GO TO 1080
         CNTHRY=BCNA/TANLE
         GO TO 1090
 1060    CONTINUE
C
C                        RECTANGULAR WING ANALYSIS
C
         IF(AR *BETA.GT.1.0)GO TO 1070
C
C                        FIGURE 4.1.3.2-56G(CNA/A)
C
         VAB(1)=AR *BETA
         LGB(1)=9
         CALL INTERX(1,G13246,VAB,LGB,DG3246,CNAA,9,9,
     1               0,0,0,0,0,0,0,0,Q3246G,3,ROUTID)
         CNTHRY=CNAA*AR
         GO TO 1090
 1070    BCNA= 4.-2.*(1./(AR *BETA))
 1080    CNTHRY=BCNA/BETA
 1090    CNA=CNTHRY*CNCNT     *SRSTAR     /(SW*RAD)
         CN(I) = CNA
 1100 CONTINUE
      F1 = (CN(2)*BB(2)**2-CN(1)*BB(1)**2)/(BB(2)-BB(1))
      F2 = (CN(3)*BB(3)**2-CN(1)*BB(1)**2)/(BB(3)-BB(1))
      AA  = (F2-F1)/(BB(3)-BB(2))
      B  = F1-AA*(BB(2)+BB(1))
      C  = CN(2)*BB(2)**2 - AA*BB(2)**2 - B*BB(2)
      DCNA = -B*XM(2)/BB(2)**3 - 2.0*C*XM(2)/BB(2)**4
      CNA  = CN(2)
      RETURN
      END