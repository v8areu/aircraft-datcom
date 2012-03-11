      SUBROUTINE SECI(A,CAMBER,ATYPE,TYPEIN,L)
C
C  FOR EACH PLANFORM SET UP INPUT DATA
C
      COMMON /IBODY/  PB, NACA(80), BF(232), CBAR
      COMMON /IWING/  PW, X(60)
      COMMON / IHT /  PHT, XU(60),XL(60),YU(60),YL(60)
      COMMON / IVT /  PVT, YUN(60),YLN(60)
      COMMON / IBW /  PBW, LL
      COMMON / IBH /  PBH, THN(60),CAM(60)
      COMMON /IBWH/   PBWH,AI,ALO,CLI,ASEP,CMCO4,CLAO,CLA(20)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
C
      LOGICAL CAMBER
      REAL NACA
      DIMENSION A(380),TYPEIN(162)
      DATA STRA / 4HSTRA /
C
      ATYPE=A(1)
      L=60
      DO 1000 I=1,80
         NACA(I)=A(I+1)
 1000 CONTINUE
      IF(ATYPE.LE.UNUSED) GO TO 1060
      L=A(82) + 0.5
      DO 1010 M=1,L
          X(M)=A(M+82)
 1010 CONTINUE
      IF(ATYPE .EQ. 1.) GO TO 1020
      IF(ATYPE .EQ. 2.) GO TO 1040
      GO TO 1060
 1020 DO 1030 M=1,L
         YU(M)=A(M+132)
         YL(M)=A(M+182)
 1030 CONTINUE
      GO TO 1060
 1040 DO 1050 M=1,L
         CAM(M)=A(M+132)
         THN(M)=A(M+182)/2.
 1050 CONTINUE
 1060 CONTINUE
      LL=L
      IF(TYPEIN(15) .NE. STRA) ATYPE=-ATYPE
      DO 1070 M=1,20
         CLA(M)=TYPEIN(20+M)
 1070 CONTINUE
      CHRDTP=TYPEIN(1)
      SSPNOP=TYPEIN(2)
      SSPNE =TYPEIN(3)
      SSPN  =TYPEIN(4)
      CHRDBP=TYPEIN(5)
      CHRDR =TYPEIN(6)
      IF(SSPNOP.LE.10.*UNUSED)CHRDBP=CHRDTP
      IF(SSPNOP.LE.10.*UNUSED)SSPNOP=0.
      TAPRI=CHRDBP/CHRDR
      CREI =CHRDR*(TAPRI+(1.-TAPRI)*(SSPNE-SSPNOP)/(SSPN-SSPNOP))
      TAPRI=CHRDBP/CREI
      TAPRO=0.
      IF(CHRDBP.NE.0.)TAPRO=CHRDTP/CHRDBP
      CREO =CHRDBP
      CBARI=2.*CREI*(1.+TAPRI+TAPRI**2)/(3.*(1.+TAPRI))
      CBARO=2.*CREO*(1.+TAPRO+TAPRO**2)/(3.*(1.+TAPRO))
      AREAI=(SSPN-SSPNOP)*CREI*(1.+TAPRI)
      AREAO=SSPNOP*CREO*(1.+TAPRO)
      CBAR =(CBARI*AREAI+CBARO*AREAO)/(AREAI+AREAO)
      RETURN
      END