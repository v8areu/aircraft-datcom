      SUBROUTINE XNAM3(IOP)
C
C***  READ OR WRITE NAMELIST BODY
C
      COMMON /BODYI/  A4(129)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      EQUIVALENCE (TYPE,A4(127))
C
      INTEGER BODY
      LOGICAL EOF
C
      DIMENSION LEN4(15),LDM4(15),BODY(44),LOC4(15)
      DIMENSION NLNAME(4)
      DATA NLNAME / 4HB   ,4HO   ,4HD   ,4HY   /
      DATA LEN4 / 2,4*1,2,2,5,5,3,3,2,5,6,5 /
      DATA LDM4 / 1,6*20,8*1 /
      DATA LOC4 / 1,2,22,42,62,82,102,122,123,124,125,126,127,128,
     1            129 /
      DATA BODY /     4HN   ,4HX   ,4HX   ,4HS   ,4HP   ,4HR   ,
     1  4HZ   ,4HU   ,4HZ   ,4HL   ,4HB   ,4HN   ,4HO   ,4HS   ,
     2  4HE   ,4HB   ,4HT   ,4HA   ,4HI   ,4HL   ,4HB   ,4HL   ,
     3  4HN   ,4HB   ,4HL   ,4HA   ,4HD   ,4HS   ,4HI   ,4HT   ,
     4  4HY   ,4HP   ,4HE   ,4HM   ,4HE   ,4HT   ,4HH   ,4HO   ,
     5  4HD   ,4HE   ,4HL   ,4HL   ,4HI   ,4HP   /
C
C**   IF IOP EQUAL ZERO READ NAMELIST BODY
C**   IF IOP EQUAL ONE WRITE NAMELIST BODY
C
      IF(IOP .EQ. 0)
     1  CALL NAMER(KAND,9,NLNAME,4,BODY,44,LEN4,15,LDM4,A4,129,
     2              LOC4,EOF)
      IF(IOP .EQ. 1)
     1  CALL NAMEW (KAND,6,NLNAME,4,BODY,44,LEN4,15,LDM4,A4,129,LOC4)
C
C
C  BODY INPUTS ARE TO SET AFTER ALL BODY NAMELISTS HAVE
C  BEEN READ.  ONLY THREE TYPES OF INPUTS WILL BE
C  PERMITTED, AS FOLLOWS
C    (1) X AND R
C    (2) X AND S
C    (3) X, R, S AND P
C
C  THIS CHANGE IS MADE TO PREVENT USER PROBLEMS EVEN THOUGH
C  ONLY TWO OF R, S OR P ARE REQUIRED
C
      IF(TYPE .EQ. UNUSED) TYPE=2.0
      IF(TYPE .LT. 1.0) TYPE=1.0
      IF(TYPE .GT. 3.0) TYPE=3.0
      RETURN
      END