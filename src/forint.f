      SUBROUTINE FORINT(IUNIT, NAME, COMBLK, II)
C
C***  FORCE AN INTEGER PRINT ONTO UNIT IUNIT
C
C  IUNIT - OUTPUT UNIT NUMBER
C   NAME - ARRAY WHICH DEFINES THE NAMELIST VARIABLE NAME
C COMBLK - DATA FOR NAMELIST NAME
C     II - NUMBER OF ELEMENTS TO PRINT
C
      INTEGER COMBLK
C
      DIMENSION NAME(8),COMBLK(II)
C
      WRITE(IUNIT,1000)(NAME(I),I=1,8),(COMBLK(I),I=1,II)
C
      RETURN
C
 1000 FORMAT(1H0,8A1,8(I14,1H,)/(9X,8(I14,1H,)))
C
      END