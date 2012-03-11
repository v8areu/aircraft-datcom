      SUBROUTINE CMALPO(A,B,WINGIN,DYN)
C
C***  COMPUTES LIFTING SURFACE CMA AT MACH=0
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /OPTION/ SREF,CBARR,RUFF,BLREF
      COMMON /FLGTCD/ FLC(95)
      DIMENSION ROUTID(2)
      DIMENSION Q41412(3),Q4222A(3),Q4222B(3)
      LOGICAL CONST
      DIMENSION C(51),A(195),B(49),WINGIN(101),DYN(213)
      DIMENSION X21412(22),X11412(5),X31412(3),Y41412(330)
      DIMENSION Y415A(110),Y415B(110),Y415C(110)
      DIMENSION XCMOM(15), YCMOM(15), CCMOM(6), QCMOM(3)
      DIMENSION X322A(6),X222A(6),X122A(6),Y22A(216)
      DIMENSION X322B(6),X222B(6),X122B(6),Y22B(216)
      DIMENSION WTYPE(4)
      DIMENSION X211B(7),Y11B(7)
      EQUIVALENCE (Y41412(1),Y415A(1)),(Y41412(111),Y415B(1))
      EQUIVALENCE (Y41412(221),Y415C(1))
      DATA ROUTID/4HCMAL,4HPO  /
      DATA Q41412/4H4.1.,4H4.1-,4H5   /,Q4222A/4H4.1.,4H4.2-,4H26A /,
     1     Q4222B/4H4.1.,4H4.2-,4H26B /,
     2     QCMOM  /4H4.1.,4H4.1-,4H6    /
C
C---------    FIGURE 4.1.4.1-6
C
      DATA ICMOM / 0 /
      DATA XCMOM / 0., .25, .30, .35, .40, .45, .50, .55, .60, .65,
     1            .70, .75, .80, .85, .90 /
      DATA YCMOM / 1.000, 1.000, 1.005, 1.017, 1.031, 1.050, 1.072,
     1             1.101, 1.132, 1.162, 1.197, 1.237, 1.287, 1.355,
     2             1.445 /
C
C---------    FIGURE 4.1.4.1-5
C     ----Y41412(16,5,3) , X31412=TAPER RATIO  X11416= ASPECT RATIO
C     ----X21412=QUARTER CHORD SWEEP ANGLE
C
      DATA X31412 /0.,.5,1./
      DATA X11412 /10.,8.,6.,3.5,1.5/
      DATA X21412 /-45.,-40.,-35.,-30.,-25.,-20.,-15.,-10.,-5.,
     1             0.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,
     2             55.,60./
      DATA Y415A /
     1  .0116,  .0100,  .0085,  .0072,  .0060,  .0048,  .0036,  .0024,
     2  .0012,  .0000, -.0012, -.0024, -.0037, -.0050, -.0063, -.0076,
     3 -.0090, -.0104, -.0118, -.0131, -.0145, -.0159,
     4  .0081,  .0070,  .0061,  .0051,  .0042,  .0034,  .0025,  .0017,
     5  .0008,  .0000, -.0009, -.0017, -.0026, -.0035, -.0045, -.0055,
     6 -.0065, -.0076, -.0086, -.0097, -.0108, -.0119,
     7  .0052,  .0045,  .0039,  .0033,  .0027,  .0022,  .0016,  .0011,
     8  .0005,  .0000, -.0005, -.0011, -.0017, -.0023, -.0029, -.0035,
     9 -.0042, -.0049, -.0057, -.0063, -.0070, -.0078,
     A  .0022,  .0019,  .0016,  .0014,  .0011,  .0009,  .0007,  .0004,
     B  .0002,  .0000, -.0002, -.0004, -.0007, -.0009, -.0012, -.0014,
     C -.0017, -.0021, -.0024, -.0027, -.0032, -.0036,
     D  .0005,  .0004,  .0004,  .0003,  .0002,  .0002,  .0001,  .0001,
     E  .0000,  .0000, -.0000, -.0001, -.0001, -.0002, -.0002, -.0003,
     F -.0004, -.0004, -.0005, -.0006, -.0007, -.0008/
      DATA Y415B /
     1  .0204,  .0177,  .0152,  .0128,  .0105,  .0083,  .0061,  .0041,
     2  .0020,  .0000, -.0020, -.0040, -.0060, -.0080, -.0100, -.0121,
     3 -.0141, -.0162, -.0182, -.0208, -.0232, -.0257,
     4  .0144,  .0125,  .0107,  .0090,  .0073,  .0058,  .0043,  .0028,
     5  .0014,  .0000, -.0014, -.0028, -.0042, -.0056, -.0071, -.0086,
     6 -.0102, -.0117, -.0133, -.0153, -.0172, -.0193,
     7  .0091,  .0078,  .0066,  .0055,  .0045,  .0035,  .0026,  .0017,
     8  .0009,  .0000, -.0009, -.0017, -.0026, -.0035, -.0044, -.0054,
     9 -.0064, -.0075, -.0087, -.0099, -.0113, -.0128,
     A  .0036,  .0030,  .0026,  .0021,  .0017,  .0013,  .0010,  .0007,
     B  .0003,  .0000, -.0003, -.0007, -.0010, -.0013, -.0017, -.0021,
     C -.0025, -.0030, -.0036, -.0043, -.0050, -.0058,
     D  .0007,  .0006,  .0005,  .0004,  .0003,  .0003,  .0002,  .0001,
     E  .0001,  .0000, -.0001, -.0001, -.0002, -.0003, -.0003, -.0004,
     F -.0005, -.0006, -.0007, -.0008, -.0009, -.0010/
      DATA Y415C /
     1  .0218,  .0189,  .0162,  .0135,  .0111,  .0087,  .0064,  .0042,
     2  .0021,  .0000, -.0020, -.0041, -.0061, -.0081, -.0101, -.0121,
     3 -.0141, -.0162, -.0182, -.0202, -.0222, -.0243,
     4  .0154,  .0133,  .0113,  .0095,  .0077,  .0060,  .0044,  .0029,
     5  .0014,  .0000, -.0014, -.0028, -.0043, -.0057, -.0072, -.0087,
     6 -.0102, -.0117, -.0133, -.0148, -.0163, -.0179,
     7  .0097,  .0083,  .0070,  .0058,  .0047,  .0037,  .0027,  .0018,
     8  .0009,  .0000, -.0009, -.0018, -.0027, -.0036, -.0045, -.0055,
     9 -.0065, -.0075, -.0086, -.0098, -.0108, -.0119,
     A  .0038,  .0032,  .0027,  .0022,  .0018,  .0014,  .0010,  .0007,
     B  .0003,  .0000, -.0003, -.0007, -.0010, -.0014, -.0018, -.0022,
     C -.0026, -.0031, -.0036, -.0043, -.0050, -.0057,
     D  .0008,  .0006,  .0005,  .0004,  .0003,  .0003,  .0002,  .0001,
     E  .0001,  .0000, -.0001, -.0001, -.0002, -.0003, -.0003, -.0004,
     F -.0005, -.0006, -.0007, -.0008, -.0009, -.0010/
C
C---------FIGURE  4.1.4.2-26A
C---------Y22A(6,6,6)  X322A=TAPER RATIO  X122A=A*(L.E.S.A)
C---------X222A=LEADING EDGE SWEEP ANGLE(L.E.S.A)
C
      DATA X322A /0.,.2,.25,.333,.5,1./
      DATA X122A /6.,5.,4.,3.,2.,1./
      DATA X222A /0.,.20,.40,.60,.80,1.0/
      DATA Y22A  /.68,.7,.72,.74,.76,.78,.58,.6,.62,.64,.66,.68,.51,.52,
     1.53,.54,.55,.56,.42,.425,.435,.44,.445,.445,6*.335,.25,.245,.24,
     2.235,.230,.225,.87,.88,.89,.905,.915,.925,.75,.76,.775,.785,.8,
     3.81,.64,.65,.66,.675,.685,.695,.52,.525,.535,.54,.5425,.55,.4,
     45*.405,.28,.275,.265,.26,.255,.25,.93,.94,.95,.96,.97,.98,.8,.81,
     5.82,.83,.84,.85,.67,.68,.69,.70,.71,.72,.54,.55,.56,.57,.575,.58,
     62*.41,2*.42,.428,.43,.3,.29,2*.28,.275,.27,2*1.04,2*1.05,1.06,
     71.08,2*.89,.90,2*.91,.92,.73,.74,.75,.758,.76,.77,.59,3*.6,.61,
     8.618,4*.46,2*.45,.32,.318,.31,.308,.30,.29,3*1.2,1.21,1.22,1.23,
     92*1.04,2*1.05,2*1.06,3*.88,.882,.89,.90,5*.70,.705,2*.53,4*.52,
     A.36,.35,.34,.335,.33,.32 , 4*1.74,2*1.73,6*1.50,6*1.22,6*1.0,
     B4*.76,2*.74,.52,.50,.483,.480,.463,.460/
C
C---------FIGURE  4.1.4.2-26B
C---------Y22B(6,6,6)  X322B=TAPER RATIO  X122B=A*(L.E.S.A.)
C---------X222B=LEADING EDGE SWEEP ANGLE(L.E.S.A.)
C
      DATA X322B /0.,.2,.25,.333,.5,1./
      DATA X122B /6.,5.,4.,3.,2.,1./
      DATA X222B /1.0,.80,.60,.40,.20,0.0/
      DATA Y22B /.78,.79,.805,.83,.87,.99,.68,.695,.71,.725,.76,
     1.83,.56,.57,.58,.595,.62,.66,.455,3*.46,.47,.5,6*.335,.225,.22,
     2.21,.2,.185,.17,.925,.94,.96,1.,1.05,1.15,.81,.82,.84,.87,.91,.97,
     3.695,.7,.71,.73,.76,.8,.55,.555,.56,.57,.58,.6,.405,.402,4*.4,
     4.25,.245,.24,.23,.22,.2,.98,.99,1.01,1.05,1.1,1.25,.85,.86,.88,
     5.9,.95,1.03,.72,.73,.74,.76,.79,.82,.58,.59,.595,.6,.61,.63,4*.43,
     6.42,.418,.27,.26,.255,.25,.24,.23,1.08,1.09,1.1,1.12,1.16,1.26,
     7.92,.93,.94,.96,1.,1.07,.77,.78,.79,.8,.83,.88,.618,.62,.63,.64,
     8.65,.67,5*.45,.44,.29,.28,.27,.26,.24,.22,1.23,1.23,1.24,1.26,
     91.3,1.38,1.06,1.07,1.08,1.09,1.12,1.19,3*.9,.91,.94,.98,2*.71,
     A.715,.72,.73,.75,3*.52, .51,.505,.5,.32,.31,.305,.30,.28,.25,
     B4*1.72,1.7,1.66,4*1.48,1.46,1.42,4*1.24,1.22,1.2,4*1.,.98,
     C.94,.74,.723,.72,.72,.70,.66,.46,.44,.42,.40,.38,.32/
      DATA WTYPE /4HSTRA,4HDOUB,4HCRAN,4HCURV/
C
      C(1) = WINGIN(61)
      C(2)=WINGIN(67)
      BETA=1.0
      ZMACH=0.0
      A170=A(173)/A(10)
      C(48)=WINGIN(6)/CBARR
      CONST=.FALSE.
C
C-----IF WING IS CONSTANT SECTION,SET CONST EQUAL TO TRUE
C
      IF( ABS(C(1)).LT.1.E-10.OR.ABS(C(2)).LT.1.E-10) CONST=.TRUE.
      IF(.NOT.CONST) C(1)= 0.50*(C(1)+C(2))
      IF(.NOT.CONST) ATOVCA=0.50*(WINGIN(16)+WINGIN(65))
      IF(.NOT.CONST) GO TO 1000
      ATOVCA=WINGIN(16)
 1000 CONTINUE
      CALL TBFUNX(B(1), CALM, DYDX, 15, XCMOM, YCMOM, CCMOM,ICMOM,
     1            MI, NG, 0, 0, QCMOM, 3, ROUTID)
      CALM = A(3)*A(16)*CALM/(SREF*CBARR)
      C(5)=(A(7)*A(43)**2/(A(7)+2.0*A(43)))*C(1)*CALM
C
C     DETERMINE IF WING IS TWISTED
C
      IF(ABS(WINGIN(11)).LT.1.E-20) GO TO 1010
C
C     CALL TABLE LOOK-UP FOR CMO/THETA FROM MODIFIED FIG 4.1.4.1-5
C
      CALL TLIN3X(X11412,X21412,X31412,Y41412,5,22,3,A(7),A(40),
     1            A(27),C(4),2,2,0,2,2,0,Q41412,3,ROUTID)
C
C     COMPUTE CMOTH (FOR TWISTED WING)
C
      C(5)=C(5)+C(4)*WINGIN(11)*CALM
 1010 CONTINUE
      B47=C(5)
C
C*********     TEST FOR WING TYPE                 **********************
C
      C(9)=A(7)*A(38)
      TYPE=WINGIN(15)
      IF(WINGIN(15).NE.WTYPE(1)) GO TO 1040
C
C*********     PAGE NUMBER 2-2                    **********************
C+++++++++     STRAIGHT TAPERED OR CONVENTIONAL   ++++++++++++++++++++++
C
      C(10)=A(38)/BETA
      C(11)=BETA/A(38)
      IF(A(7) .GT. A(125)) GO TO 1030
C
C ***** IF WING HAS FORWARD SWEEP, GO TO SUBROUTINE FWDXAC
C
      IF (A(38) .LT. 0.0) GO TO 1110
C
C--------- IF C(10).GE.1.0 USE FIG. 4.1.4.2-26B
C
      IF(C(10).GE.1.0) GO TO 1020
C
C---------     FIGURE 4.1.4.2-26A
C
      CALL TLIN3X(X122A,X222A,X322A,Y22A,6,6,6,C(9),C(10),A(27),C(6),
     1            2,0,0,2,0,0,Q4222A,3,ROUTID)
      GO TO 1120
C
C---------     FIGURE 4.1.4.2-26B
C
 1020 CALL TLIN3X(X122B,X222B,X322B,Y22B,6,6,6,C(9),C(11),A(27),C(6),
     1            2,0,0,2,0,0,Q4222B,3,ROUTID)
      GO TO 1120
C
C***  COMPUTE XAC/CR AT QUARTER CHORD OF MAC
C
 1030 CONTINUE
      C(6)=(A(161)-(WINGIN(4)-WINGIN(3))*A(62))/A(10)
      GO TO 1120
C
C*********     PAGE NUMBER 2-3                    **********************
C+++++++++     DOUBLE-DELTA,CRANKED,OR CURVED     ++++++++++++++++++++++
C
 1040 CONTINUE
      IF(A(62).EQ.0.0) A(62)=1.0E-15
      C(12)=A(5)*A(62)
      C(13)=A(62)/BETA
      C(14)=1.0/C(13)
      C(15)= A(168)*A(86)
      C(16)=A(86)/BETA
      C(17)= 1.0/C(16)
C
C ***** IF INBOARD PANEL HAS FORWARD SWEEP, GO TO SUBROUTINE FWDXAC
C
      IF (A(62) .LT. 0.0) GO TO 1060
C
C*********     IF C(13).GE.1.0, USE FIGURE 4.1.4.2-26B (INBOARD DATA)
C
      IF(C(13).GE.1.0) GO TO 1050
C
C---------     FIGURE 4.1.4.2-26A
C
      CALL TLIN3X(X122A,X222A,X322A,Y22A,6,6,6,C(12),C(13),A(26),C(18),
     1            2,0,0,2,0,0,Q4222A,3,ROUTID)
      GO TO 1070
C
C---------     FIGURE 4.1.4.2-26B       --------------------------------
C
 1050 CALL TLIN3X(X122B,X222B,X322B,Y22B,6,6,6,C(12),C(14),A(26),C(18),
     1            2,0,0,2,0,0,Q4222B,3,ROUTID)
      GO TO 1070
 1060 CALL FWDXAC (C(12),A(26),C(13),B(1),ROUTID,C(18))
C
C ***** IF OUTBOARD PANEL HAS FORWARD SWEEP, GO TO SUBROUTINE FWDXAC
C
      IF (A(86) .LT. 0.0) GO TO 1090
C
C*********     IF C(16).GE.1.0 USE FIGURE 4.1.4.2-26B (OUTBOARD DATA)
C
 1070 IF(C(16).GE.1.0) GO TO 1080
C
C---------     FIGURE 4.1.4.2-26A
C
      CALL TLIN3X(X122A,X222A,X322A,Y22A,6,6,6,C(15),C(16),A(169),C(19),
     1            2,0,0,2,0,0,Q4222A,3,ROUTID)
      GO TO 1100
C
C---------     FIGURE 4.1.4.2-26B
C
 1080 CALL TLIN3X(X122B,X222B,X322B,Y22B,6,6,6,C(15),C(17),A(169),C(19),
     1            2,0,0,2,0,0,Q4222B,3,ROUTID)
      GO TO 1100
 1090 CALL FWDXAC (C(15),A(169),C(16),B(1),ROUTID,C(19))
 1100 C(20)= C(19)*A(166)/A(10)-A(164)*A(86)/A(10)+A(23)*A(62)/A(10)
      TEMP1=2.*PI*A(168)*DEG
      TEMP2=ABS(1.-FLC(3)**2)*(TEMP1/WINGIN(21))**2
      TEMP3=A(98)**2
      A172=TEMP1/(2.+SQRT(TEMP2*(1.+TEMP3)+4.))
      TEMP1=2.*PI*A(5)*DEG
      TEMP2=ABS(1.-FLC(3)**2)*(TEMP1/WINGIN(21))**2
      TEMP3=A(74)**2
      A171=TEMP1/(2.+SQRT(TEMP2*(1.+TEMP3)+4.))
      ANUM=A171*A(1)*C(18)+A172*A(167)*C(20)
      ADEN=A171*A(1)+A172*A(167)
      C(6)=ANUM/ADEN
      GO TO 1120
 1110 CALL FWDXAC (C(9),A(27),C(10),B(1),ROUTID,C(6))
 1120 DCMDCL=(A170-C(6))*(A(10)/CBARR)
      DYN(21)=DCMDCL
      RETURN
      END