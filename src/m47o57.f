      SUBROUTINE M47O57
C
C***  EXEC FOR OVERLAY 47, TRANSVERSE-JET AERO
C
      COMMON /OVERLY/  IJKDUM(8),NOVLY
      NOVLY=47
      CALL TRANJT
      CALL OUTTRJ
      RETURN
      END
