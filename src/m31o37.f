      SUBROUTINE M31O37
C
C***  EXEC FOR OVERLAY 31, SUBSONIC WING CM, BODY CA,CN
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /IWING/  PWING, WING(400)
      COMMON /WINGI/  WINGIN(100)
      COMMON /WINGD/  A(195),B(49)
      COMMON /WHAERO/ C(51)
      COMMON /FLGTCD/ FLC(95)
      COMMON /EXPER/  KK(105),KWING
      DIMENSION C1(6),C3(6),ROUTID(2)
      LOGICAL FLAG,KWING
      DATA ROUTID/ 4HM31O, 4H37  /
      DATA STRA/ 4HSTRA /
      NOVLY=31
      CALL CMALPH(A,B,C,WINGIN,WING)
      CALL CACALC(B,WING)
C
C     SET IOM CN, CA, CLA, AND CMA
C
      CALL EXSUBT
      IN = 0
      IM = 0
      CLA=WING(101)
      CMA=WING(121)
      DO 1000 J=1,NALPHA
         CA = COS(FLC(J+22)/RAD)
         SA = SIN(FLC(J+22)/RAD)
         WING(J+60) = WING(J+20)*CA + WING(J)*SA
         WING(J+80) = WING(J)*CA - WING(J+20)*SA
         CALL TBFUNX(FLC(J+22),X,WING(J+100),NALPHA,FLC(23),WING(21),
     1               C1,IN,MI,NG,0,0,4HCLAW,1,ROUTID)
         CALL TBFUNX(FLC(J+22),X,WING(J+120),NALPHA,FLC(23),WING(41),
     1               C3,IM,MI,NG,0,0,4HCMAW,1,ROUTID)
 1000 CONTINUE
      IN=0
      IM=0
      IF(KWING)CALL TBFUNX(0.,X,CLA,NALPHA,FLC(23),
     1              WING(21),C1,IN,MI,NG,0,0,4HCLAW,1,ROUTID)
      IF(KWING)CALL TBFUNX(0.,X,CMA,NALPHA,FLC(23),
     1              WING(41),C3,IM,MI,NG,0,0,4HCMAW,1,ROUTID)
C
C***  IF THE WING LIFT DEVIATES FROM THE LINEAR VALUE BY
C***  15 PERCENT OR MORE SET CM AND CMA TO NA (2*UNUSED)
C
      IF(A(7) .LE. (6./A(124)) .AND. WINGIN(15) .EQ. STRA) GO TO 1020
      IF(KWING) GO TO 1020
      FLAG=.FALSE.
      DO 1010 J=2,NALPHA
         DEL = 100.*ABS((WING(J+100)/CLA-1.0))
      IF(DEL.GT.90.0) FLAG=.TRUE.
         IF(FLAG) WING(J+40)  = 2.0*UNUSED
         IF(FLAG) WING(J+120) = 2.0*UNUSED
 1010 CONTINUE
 1020 CONTINUE
      WING(101)=CLA
      WING(121)=CMA
      RETURN
      END