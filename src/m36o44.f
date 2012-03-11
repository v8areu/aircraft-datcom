      SUBROUTINE M36O44
C
C***  EXEC FOR OVERLAY 36, FLAP LIFT AND HINGE MOMENTS
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2                TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3                HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4                VFPL,VFSC,CTAB
      LOGICAL  FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1         HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2         TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3         HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4         VFPL,VFSC,CTAB
      COMMON /FLAPIN/ F(69)
      COMMON /IWING/  PWING, WING(400)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      NOVLY=36
      CALL LIFTFP
      IF(TRANSN)RETURN
      IF(F(17).EQ.1.0.OR.F(17).EQ.5.0)CALL HINGE
      DO 1010 J=2,10
 1010 WING(J+250) = -UNUSED
      IF(CTAB) CALL CTABS
      RETURN
      END