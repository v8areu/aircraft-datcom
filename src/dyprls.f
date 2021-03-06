      SUBROUTINE DYPRLS(CDOW,I2,CBAR,CLJW,AW,GAMMA,ALPHA,QOQI,NA,KEPSLN)
C
C     ----LOSS OF DYNAMIC PRESSURE DUE TO WING
C
      REAL   I2,I2OCB
      LOGICAL KEPSLN
      DIMENSION ALPHA(20),QOQI(20),CLJW(20)
      COMMON /WINGD/  A(195), B(48)
      COMMON /IDWASH/ PDWASH, DWASH(60)
      COMMON /CONSNT/ PI, CONST(2), RAD
      COMMON /OPTION/ SREF
C
      FACT=1.62/(PI*AW)
      DO 1000 J=1,NA
         EJ=FACT*CLJW(J)*SREF/A(3)
         IF(KEPSLN) EJ=DWASH(J+20)/RAD
         I2OCB=I2*COS(GAMMA-ALPHA(J)/RAD+EJ)/(COS(GAMMA)*A(16))
         ZWOCB=0.68*SQRT(CDOW*(I2OCB+0.15)*SREF/A(3))
         DQOQ0=2.42*SQRT(CDOW*SREF/A(3))/(I2OCB+0.3)
         ZOCB=I2OCB*TAN(EJ+GAMMA-ALPHA(J)/RAD)
         QOQI(J)=1.-DQOQ0*(COS(0.5*PI*ZOCB/ZWOCB)**2)
         IF(ABS(ZOCB/ZWOCB).GE.1.0) QOQI(J)=1.0
 1000 CONTINUE
      RETURN
      END
