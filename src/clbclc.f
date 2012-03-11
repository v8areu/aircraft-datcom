      SUBROUTINE CLBCLC(CLBCL,DATA)
C
C***  CALCULATES TRANSONIC WING AND WING BODY CLLB AND CLLB/CL
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA
      DIMENSION DATA(380)
      LOGICAL FLAG
C
      DO 1000 J=1,NALPHA
        FLAG = ABS(DATA(J+20))  .GT. UNUSED .AND.
     1         ABS(DATA(J+180)) .NE. UNUSED
        IF(FLAG) CLBCL = DATA(J+180)/DATA(J+20)
        IF(FLAG) GO TO 1010
 1000 CONTINUE
      CLBCL = UNUSED
 1010 CONTINUE
      RETURN
      END