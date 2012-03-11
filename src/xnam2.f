      SUBROUTINE XNAM2(IOP)
C
C***  READ OR WRITE NAMELIST OPTINS
C
      COMMON /OPTION/ A3(4)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
C
      INTEGER OPTINS
      LOGICAL EOF
C
      DIMENSION LEN3(4),LDM3(4),OPTINS(20),LOC3(4)
      DIMENSION NLNAME(6)
C
      DATA NLNAME / 4HO   ,4HP   ,4HT   ,4HI   ,4HN   ,4HS   /
      DATA LEN3 / 4,5,6,5 /
      DATA LDM3 / 4*1 /
      DATA LOC3 / 1,2,3,4 /
      DATA OPTINS /   4HS   ,4HR   ,4HE   ,4HF   ,4HC   ,4HB   ,
     1  4HA   ,4HR   ,4HR   ,4HR   ,4HO   ,4HU   ,4HG   ,4HF   ,
     2  4HC   ,4HB   ,4HL   ,4HR   ,4HE   ,4HF   /
C
C**   IF IOP EQUAL ZERO READ NAMELIST OPTINS
C**   IF IOP EQUAL ONE WRITE NAMELIST OPTINS
C
      IF(IOP .EQ. 0)
     1  CALL NAMER(KAND,9,NLNAME,6,OPTINS,20,LEN3,4,LDM3,A3,4,LOC3,EOF)
      IF(IOP .EQ. 1)
     1  CALL NAMEW(KAND,6,NLNAME,6,OPTINS,20,LEN3,4,LDM3,A3,4,LOC3)
C
      RETURN
      END