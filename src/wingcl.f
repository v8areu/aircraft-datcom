      SUBROUTINE WINGCL(NALPHA,ASCHED,ALPHAO,ALPHAS,ACLMAX,CLA,CLMAX,CL,
     1   AMACH,TOC,OMEGA,TAPR,AR,CLBSB,CLBSS,CLA6,CLA14,CDLCL2,CD,CLBCL,
     2   CLB)
C
C *** CALCULATES TRANSONIC WING CL
C
      DIMENSION ASCHED(20),CL(20),CD(20),CLB(20)
      DIMENSION C(6),XA(2),YA(2),Q455A(3),Q455B(3),Q455AB(4),ROUT(2),
     1          PARM(21),DEP55A(164),DEP55B(164),VAR(4),LENG(4)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      LOGICAL FLAG
      DATA Q455A/4H4.1.,4H5.2-,4H55A /,Q455B/4H4.1.,4H5.2-,4H55B /
C
C****------ DATA FOR FIGURE 4.1.5.2-55A AT  AR*TAN(L.E. SWEEP)=0.0 -----
C
      DATA ROUT /4HWING,4HCL  /, Q455AB /4H4.1.,4H5.2-,4H55A,,4HB   /
      DATA PARM/-4.,-3.,-2.,-1.,0.,1.,2.,.5,.75,1.,1.5,1.75,2.,0.,0.,
     1 .2,.5,1.,3*0./
      DATA DEP55A/1.20,1.14,1.13,1.17,1.20,1.18,1.13,.94,2*.88,.9,.95,
     1.98,.97,.75,.7,.68,.71,.75,.78,.8,.4,.4,.4,.46,.54,.55,.53,.27,
     2.28,.3,.37,.49,.48,.46,.16,.17,.27,.43,.42,.40,1.05,1.04,1.04,
     31.05,1.06,1.05,1.02,.8,.77,.76,.78,.8,.82,.82,.6,.58,.58,.58,.59,
     4.62,.65,.36,.36,.37,.42,.47,.49,.50,.28,.27,.30,.36,.42,.44,.45,
     5.20,.24,.32,.39,.41,.42,1.02,1.03,1.02,1.,.97,.96,.97,.78,.76,.73,
     6.7,.68,.68,.7,.58,.55,.54,.52,.52,.53,.56,.33,.34,.36,.39,.43,.45,
     7.47,.28,.29,.31,.34,.39,.43,.45,.23,.27,.32,.38,.41,.43,.82,.84,
     8.88,.92,.98,1.02,1.02,.63,.63,.67,.75,.79,.82,.82,.51,.52,.56,.62,
     9.68,.70,.71,.4,.4,.41,.52,.55,.62,.63,.37,.37,.37,.45,.54,.60,.62,
     A.35,.35,.42,.50,.56,.58/
C
C****------ DATA FOR FIGURE 4.1.5.2-55B AT  AR*TAN(L.E. SWEEP)=3.0 -----
C
      DATA DEP55B/1.22,1.16,1.14,1.18,1.22,1.19,1.14,1.03,1.01,.98,.96,
     1.95,.96,.98,.87,.84,.81,.79,.77,.78,.8,.57,.51,.49,.52,.55,.56,
     2.54,.31,.31,.31,.37,.49,.49,.45,.17,.21,.29,.43,.43,.40,1.11,1.10,
     31.09,1.08,1.07,1.05,1.03,.92,.88,.86,.84,.84,.82,.83,.75,.73,.71,
     4.68,.66,.66,.67,.46,.42,.41,.45,.51,.52,.51,.28,.29,.3,.32,.44,
     5.46,.47,.2,.24,.32,.4,.43,.44,1.11,1.09,1.07,1.03,.99,.98,.99,.90,
     6.88,.86,.83,.79,.78,.81,.70,.70,.68,.64,.60,.62,.66,.46,.46,.47,
     7.49,.50,.52,.52,.40,.39,.40,.42,.45,.47,.48,.37,.35,.38,.41,.44,
     8.44,.83,.87,.90,.94,.99,.92,.93,.70,.72,.74,.77,.80,.84,.87,.60,
     9.61,.63,.67,.73,.76,.78,.46,.46,.48,.52,.60,.64,.66,.40,.39,.40,
     A.47,.56,.61,.63,.37,.37,.43,.53,.58,.60/
C
C************ TRANSONIC WING CL - DATCOM SECTION 4.1.3.3 ***************
C
      IF(ALPHAO .EQ. UNUSED .OR. ALPHAS .EQ. UNUSED)GO TO 1040
      CLREF = (ALPHAS-ALPHAO)*CLA
      FLAG = ACLMAX .LT. ALPHAS .OR. CLMAX .LT. CLREF
      IF(FLAG) ACLMAX = ALPHAS
      IF(FLAG) CLMAX  = CLREF
      IF(ALPHAS.EQ.ACLMAX)GO TO 1000
C
C**** MODEL THE NON-LINEAR LIFT REGION WITH A POLYNOMIAL
C
      EXPN=CLA*(ALPHAS-ACLMAX)/(CLA*(ALPHAS-ALPHAO)-CLMAX)
      A2=CLA*(ALPHAS-ALPHAO)-CLMAX
      A1=0.0
      A0=CLMAX
C
C**** COMPUTE CL CURVE VERSUS ASCHED
C
 1000 DO 1030 I=1,NALPHA
         IF(ASCHED(I).GT.ACLMAX)GO TO 1040
         IF(ASCHED(I)-ALPHAS)1010,1010,1020
 1010    IF(CL(I).EQ.UNUSED)CL(I)=CLA*(ASCHED(I)-ALPHAO)
         GO TO 1030
 1020    IF(ABS(CL(I)).EQ.UNUSED)CL(I)=A0+A1*(ASCHED(I)-ACLMAX)
     1            +A2*((ASCHED(I)-ACLMAX)/(ALPHAS-ACLMAX))**(EXPN)
 1030 CONTINUE
C
C************ TRANSONIC WING CDL - DATCOM SECTION 4.1.5.2 **************
C**** COMPUTE THE TRANSONIC SIMILARITY PARAMETERS
C
 1040 TC13=TOC**(1./3.)
      TC23=TOC**(2./3.)
      VAR(1)=(AMACH**2-1.)/TC23
      VAR(2)=AR*TC13
      VAR(3)=TAPR
      LENG(1)=7
      LENG(2)=6
      LENG(3)=4
C
C**** LOOKUP FOR FIGURE 4.1.5.2-55A
C
      CALL INTERX(3,PARM,VAR,LENG,DEP55A,CDLR1,7,164,1,1,1,0,1,1,1,0,
     1            Q455A,3,ROUT)
C
C**** LOOKUP FOR FIGURE 4.1.5.2-55B
C
      CALL INTERX(3,PARM,VAR,LENG,DEP55B,CDLR2,7,164,1,1,1,0,1,1,1,0,
     1            Q455B,3,ROUT)
C
C**** CDL/CL**2 CALCULATED FOR EACH FIGURE, CALCULATE FOR THIS CASE
C
      X=AR*TAN(OMEGA)
      XA(2)=3.0
      XA(1)=0.0
      YA(2)=CDLR2
      YA(1)=CDLR1
      CALL TBFUNX(X,Y,DYDX,2,XA,YA,C,0,0,NG,1,1,Q455AB,4,ROUT)
      CDLCL2=Y*TC13
      IF(ABS(CD(2)) .NE. UNUSED) GO TO 1060
      CDO = CD(1)
      DO 1050 I=1,NALPHA
         IF(ABS(CL(I)).EQ.UNUSED)GO TO 1050
         CD(I)=CDLCL2*CL(I)**2+CDO
 1050 CONTINUE
 1060 CONTINUE
C
C************ TRANSONIC WING CLB - DATCOM EQUATION 5.1.2.1-C ***********
C
      CLBCL=((CLBSS/CLA14**2-CLBSB/CLA6**2)*(AMACH-.6)/.8+CLBSB/CLA6**2)
     1      *CLA**2
      DO 1070 I=1,NALPHA
         IF(ABS(CL(I)).EQ.UNUSED)GO TO 1070
         IF(ABS(CLB(I)).EQ.UNUSED)CLB(I)=CLBCL*CL(I)
 1070 CONTINUE
      RETURN
      END