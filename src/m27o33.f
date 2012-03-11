      SUBROUTINE M27O33
C
C***  EXEC FOR OVERLAY 27, SUPERSONIC WING STABILITY
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /CONSNT/ CONST(4)
      COMMON /IWING/  PWING,WING(400)
      COMMON /FLGTCD/ FLC(93)
      COMMON /WINGI/  WGIN(100)
      EQUIVALENCE (CONST(3),UNUSED)
      LOGICAL FLAG
      DIMENSION CR(6),ROUTID(2)
      DATA ROUTID/ 4HM27O, 4H33  /
      DATA A4HSTR/4HSTRA/
      NOVLY=27
      CALL SUPLNG
C
C   GET WING CLA AND CMA FOR ANGLES-OF-ATTACK OTHER THAN THE FIRST
C
      FLAG = (WGIN(15) .EQ. A4HSTR)
      IN=0
      INN=0
      DO 1000 J=2,NALPHA
         CALL TBFUNX(FLC(J+22),X,WING(J+100),NALPHA,FLC(23),WING(21),
     1                CR,IN,MI,NG,0,0,4HCLAW,1,ROUTID)
         IF(J .EQ. 1) GO TO 1000
         WING(J+120) = -UNUSED
         IF(FLAG) GO TO 1000
         WING(J)    = -UNUSED
         WING(J+20) = -UNUSED
         WING(J+40) = -UNUSED
         WING(J+60) = -UNUSED
         WING(J+80) = -UNUSED
         WING(J+100)= -UNUSED
         WING(J+180)= -UNUSED
 1000 CONTINUE
      IF(.NOT. FLAG)WING(81)=WING(1)
      RETURN
      END