      SUBROUTINE DRAGFP
C
C***  CALCULATES SUBSONIC FLAP INDUCED DRAG
C
      REAL KPRM,KB
      COMMON /OVERLY/ NLOG,NMACH,IZO,NALPHA
      COMMON /CONSNT/ PI,DR,UNUSED,RAD
      COMMON /OPTION/ SREF,CBARR,RUFF,BLREF
      COMMON /IDWASH/ PDWASH, DWASH(60)
      COMMON /IWING/  PWING, WING(400)
      COMMON /IBODY/  PBODY, BODY(400)
      COMMON /IHT/    PHT, HT(380)
      COMMON /SUPWH/  FCM(282)
      COMMON /SUPDW/  DWA(35),TCD(58)
      COMMON /FLAPIN/ F(69)
      COMMON /POWR/   PW(104),FLP(189)
      COMMON /WINGD/  A(195),B(49)
      COMMON /HTDATA/ AHT(195),BHT(49)
      DIMENSION CXX(6),DCDI(200),CDI(200)
      DIMENSION X11722(15),X21722(9),Y11722(135),F11722(2)
      DIMENSION X21724(10),X11724(3),Y61724(30),F61724(3)
      DIMENSION X11723(6),X21723(5),F11723(2),Y11723(30)
      DIMENSION ROUTID(2)
      DIMENSION DELCDM(10),DELCDF(10),DCL(10),ETA(5),RKB(4)
      DIMENSION GD1(12),GD2(12),GD3(12),ADAVE(10),DELTA(10),ALPHA(20)
      DIMENSION GPP(12),DG(12),GPPA(12),CD(20),CL(20),CDF(200),CLF(200)
      DIMENSION TEC(5),TOTC(10),SC1(5),SC2(6),SC3(5),SC4(6),SC5(5),
     1         SC6(6),SC7(5),SC8(6),SC9(5),SC10(6),Q(12),SPU(12),SUM(10)
      EQUIVALENCE (F(1),DELTA(1)),(Q(1),EN1),(Q(2),EN2),
     1           (Q(3),SM1),(Q(4),SM2),(Q(5),SM3),(Q(6),SM4),(Q(7),SM5),
     2        (Q(8),SM6),(Q(9),SM7),(Q(10),SM8),(Q(11),SM9),(Q(12),SM10)
      EQUIVALENCE (Q(3),SUM(1))
      EQUIVALENCE (FCM(63),ADAVE(1)),(TCD(29),GD1(1)),(TCD(1),GD2(1)),
     1            (TCD(15),GD3(1))
      EQUIVALENCE (KPRM,TCD(47)),(DELCDM(1),WING(231)),
     1            (DELCDF(1),TCD(49))
      EQUIVALENCE (CFOCA,FLP(61)),(DCL(1),WING(201))
      EQUIVALENCE (DCDI(1),BODY(201))
      EQUIVALENCE (ETA(1),FLP(1)),(RKB(1),FLP(20))
      DATA ROUTID/4HDRAG,4HFP  /
C
C        ---- FIGURE 6.1.7-22  TWO-DIMENSIONAL DRAG INCREMENT
C                              DUE TO PLAIN FLAPS
C
      DATA X11722/0.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,60.,65.,
     1 70.,75./,X21722/0.,.10,.16,.20,.249,.28,.32,.36,.42/,
     2 F11722/4H6.1.,4H7-22/,
     3 Y11722/9*0.,0.,.002,.003,.004,.007,.008,.012,
     4.016,.025 , 0.,.005,.008,.012,.016,.019,.025,.032,.045 , 0.,.009,
     5.015,.020,.027,.032,.039,.048,.070 , 0.,.014,.024,.030,.041,.048,
     6.060,.074,.105 , 0.,.019,.033,.043,.057,.069,.088,.11,.151 , 0.,
     7.026,.043,.057,.077,.092,.114,.14,.191 , 0.,.033,.054,.071,.097,
     8.117,.150,.187,.247 , 0.,.040,.067,.088,.119,.143,.184,.232,.305
     9 , 0.,.048,.080,.104,.140,.170,.218,.264,.337 , 0.,.057,.093,.122,
     A.165,.20,.254,.307,.388 , 0.,.065,.108,.14,.192,.238,.303,.366,
     B.462 , 0.,.075,.122,.16,.22,.273,.342,.414,.521 , 0.,.083,.138,
     C.179,.25,.305,.38,.451,.564 , 0.,.09,.15,.199,.28,.345,.433,.52,
     D .658/
C
C        ---- FIGURE 6.1.7-23  TWO-DIMENSIONAL DRAG INCREMENT
C                              DUE TO SLOTTED FLAPS
C
      DATA X11723/0.,10.,20.,30.,40.,50./,X21723/0.,.10,.23,.36,.40/,
     1     F11723/4H6.1.,4H7-23/,
     2     Y11723/5*0.,0.,.002,.004,.009,.012,0.,.004,.01,.018,.023,
     3     0.,.011,.029,.05,.058,0.,.02,.057,.101,.117,
     4     0.,.031,.088,.171,.205/
C
C     ----FIGURE 6.1.7-24 A-C
C
      DATA X21724/.2,.25,.3,.4,.5,.6,.7,.8,.9,1.0/,X11724/4.,6.,12./,
     1F61724/4H6.1.,4H7-24,4HA-C /,
     2 Y61724/2.34,1.74,1.41,.96,.62,.38,.22,.11,.03,.0 , 3.2,2.54,2.04,
     31.24,.79,.50,.30,.15,.07,.0 , 4.9,3.8,2.8,1.7,1.06,.65,.37,.18,.06
     4,0. /
      DATA TEC/4.444,.4794,.1602,.06946,.02782/,TOTC/38.65,19.52,13.24,
     1 10.17,8.398,7.278,6.538,6.046,5.732,5.557/
      DATA SPU/0.,.1423,.2817,.4153,.5407,.6549,.7557,.8412,.9097,.9595
     1,.9898,1.0/
      DATA SC1  /.09772,.1463,.3188,1.120,13.95/
      DATA SC2  /.0493,.1232,.2310,.7268,7.616,7.046/
      DATA SC3  /.1170,.1928,.5431,5.246,5.167/
      DATA SC4  /.06423,.1739,.4384,4.084,4.029,.2948/
      DATA SC5  /.1753,.3869,3.398,3.372,.3127/
      DATA SC6  /.1060,.3628,2.951,2.945,.2984,.06003/
      DATA SC7  /.3799,2.673,2.658,.2850,.07869/
      DATA SC8  /.2635,2.533,2.459,.2785,.08798,.02287/
      DATA SC9  /2.565,2.401,.2858,.09800,.03618/
      DATA SC10 /2.244,2.487,.2883,.1160,.04910,.01405/
      ASPECT=A(7)
      SCALE=A(3)/SREF
      IF(AHT(3).NE.UNUSED)SCALE=AHT(3)/SREF
      IF(AHT(7).NE.UNUSED)ASPECT=AHT(7)
      DO 1000 I=1,12
         GPP(I)=GD1(I)/RAD
 1000 DG(I)=GD3(I)-GD2(I)
      A31422=PI*ASPECT/22.
      NDP1=F(16)+1.5
      DO 1070 M=1,NDP1
         IF(M.GT.1)ADAVED=ADAVE(M-1)*DELTA(M-1)/RAD
         DO 1060 J=1,NALPHA
            ALPHA(J)=B(J+22)-B(49)
            IF(BHT(J+22).NE.UNUSED)ALPHA(J)=BHT(J+22)-B(49)-DWASH(J+20)
            DO 1010 L=1,12
 1010       Q(L)=0.
            K=1
            L=1
            DO 1030 I=1,11
               GPPA(I)=GPP(I)*ALPHA(J)
               IF(M.GT.1)GPPA(I)=GPPA(I)-DG(I)*ADAVED
               IF(2*(I/2).NE.I)GO TO 1020
C
C     ----HERE FOR EVEN
C
               EN1=EN1+TEC(K)*GPPA(I)
               SM1=SM1+SC1(K)*GPPA(I)
               SM3=SM3+SC3(K)*GPPA(I)
               SM5=SM5+SC5(K)*GPPA(I)
               SM7=SM7+SC7(K)*GPPA(I)
               SM9=SM9+SC9(K)*GPPA(I)
               K=K+1
               GO TO 1030
C
C     ----HERE FOR ODD
C
 1020          SM2=SM2+SC2(L)*GPPA(I)
               SM4=SM4+SC4(L)*GPPA(I)
               SM6=SM6+SC6(L)*GPPA(I)
               SM8=SM8+SC8(L)*GPPA(I)
               SM10=SM10+SC10(L)*GPPA(I)
               L=L+1
 1030       CONTINUE
            EN1=GPPA(1)*(5.5*GPPA(1)-EN1)
            CLSM=0.
            TOTSM=0.
            DO 1040 I=2,11
               II=13-I
               TEMP=SPU(I)*GPPA(II)
               TOTSM=TEMP*(TOTC(I-1)*GPPA(II)-SUM(I-1))+TOTSM
               CLSM=CLSM+TEMP
 1040       CONTINUE
            EN2=2.*TOTSM
            TCB=A31422*(EN1+EN2)
            TCL=A31422*(GPPA(1)+2.*CLSM)
            IF(M.GT.1)GO TO 1050
            CD(J)=TCB  *SCALE
            CL(J)=TCL  *SCALE
            GO TO 1060
 1050       IDX=J+NALPHA*(M-2)
            CLF(IDX)=TCL *SCALE
            CDF(IDX)=TCB *SCALE
 1060    CONTINUE
 1070 CONTINUE
      NDELTA=F(16)+.5
      IF(F(17).GT.5.) GO TO 1090
C
C    -----CALCULATION OF DELTA CD(MIN) DUE TO FLAPS
C              FIGURE 6.1.7-24 A-C
C
      ARG1 = ETA(5)-ETA(1)
      CALL TLINEX(X11724,X21724,Y61724,3,10,ASPECT,ARG1,KPRM,
     1            2,0,0,0,F61724,3,ROUTID)
      KB=RKB(1)+RKB(2)+RKB(3)+RKB(4)
      ARG1=KPRM/(ASPECT*PI)
      DO 1080 J=1,NDELTA
         ARG2=ABS(DELTA(J))
C
C        FIGURE 6.1.7-22 OR 6.1.7-23, DELCDF
C
         IF(F(17).EQ.1..OR.F(17).EQ.5.) GO TO 1075
         CALL TLINEX(X11723,X21723,Y11723,6,5,ARG2,CFOCA,DELCDF(J),
     1               2,0,0,0,F11723,2,ROUTID)
         GO TO 1078
 1075    CALL TLINEX(X11722,X21722,Y11722,15,9,ARG2,CFOCA,DELCDF(J),
     1               2,0,0,0,F11722,2,ROUTID)
 1078    CONTINUE
 1080 DELCDM(J)= DELCDF(J)*KB*SCALE+ARG1*DCL(J)**2/SCALE
C
C    -----CALCULATE DELTA CDI AT SPECIFIC CL FROM SECTION 4 AND 5
C
 1090 IXX=0
      DO 1110 N=1,NDELTA
         L=1+NALPHA*(N-1)
         DO 1100 J=1,NALPHA
            IL=J+NALPHA*(N-1)
            DCDI(IL) = CDF(IL)-CD(J)
 1100    CONTINUE
 1110 CONTINUE
C
      RETURN
      END