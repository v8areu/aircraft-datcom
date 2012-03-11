      SUBROUTINE M21O25
C
C***  EXEC FOR OVERLAY 21, SUPERSONIC WING FLOW FIELDS
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /EXPER/  KLIST, NLIST(100), NNAMES, IMACH, MDATA,
     1                KBODY, KWING, KHT, KVT, KWB, KDWASH(3),
     2                ALPOW, ALPLW, ALPOH, ALPLH
      EQUIVALENCE (KDWASH(2),KEPSLN)
      LOGICAL KEPSLN
      KEY = 0
      IF(KEPSLN) KEY = 1
      NOVLY=21
      IF(KEPSLN) CALL EXSUBT
      CALL SDWASH(I,KEY)
      CALL EXSUBT
      RETURN
      END