      SUBROUTINE M34O42
C
C***  EXEC FOR OVERLAY 34, DEFINE EXPERIMENTAL DATA INPUT
C
      COMMON /OVERLY/  IJKDUM(8),NOVLY
      COMMON /EXPER/ KLIST, NLIST(100), NNAMES, IMACH, MDATA,
     1               KBODY, KWING, KHT, KVT, KWB, KDWASH(3),
     2               ALPOW, ALPLW, ALPOH, ALPLH
C
      NOVLY=34
      IF(KLIST .GE. 1) CALL XPERNM
      RETURN
      END