      SUBROUTINE ANGDET(MACH,DELEFF)
C
C  SUBROUTINE TO DETERMINE THE EFFECTIVE WEDGE TURN ANGLE
C  (ALPHA + DELTA) IN WHICH THE SHOCK WILL BECOME DETACHED
C
      REAL MACH
      DATA GAM / 1.4 /
C
C  COMPUTE THE SHOCK ANGLE AT DELTA-MAX, NACA TR 1135 EQN 168
C
      SIN2TM=((1.+GAM)*MACH**2-4.+SQRT((GAM+1.)*((GAM+1.)*MACH**4
     1       +8.*(GAM-1.)*MACH**2+16.)))/(4.*GAM*MACH**2)
      TDM=ARCSIN(SQRT(SIN2TM))
C
C  USE THIS ANGLE IN EQN 138
C
      COTD=TAN(TDM)*(((GAM+1.)*MACH**2)/(2.*(MACH**2*(SIN(TDM))**2
     1     -1.))-1.)
      DELEFF=ATAN(1./COTD)
      RETURN
      END
