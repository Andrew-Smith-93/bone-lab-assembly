.intel_syntax noprefix
.equ X,0
.equ Y,8
.equ Z,16
.equ L1,24
.equ L2,32
.equ MIN,40
.equ MAX,48
.equ BRANCH,56
.equ RHO,0
.equ DIST,8
.equ RAW,16
.equ C,24
.equ PHI,32
.equ YAW,40
.equ ELEV,48
.equ DELTA,56
.equ PITCH,64
.equ EX,72
.equ EY,80
.equ EZ,88
.equ WX,96
.equ WY,104
.equ WZ,112
.equ ERROR,120
.equ DMIN,128
.equ DMAX,136
.equ SINPHI,144
.equ CP,152
.equ SY,160
.equ CY,168
.equ NUM,176
.equ DEN,184
.equ FLAGS,192
.equ OUTSIZE,200
.macro FN name
.global \name
.type \name,@function
\name:
 push rbp
 mov rbp,rsp
 sub rsp,64
.endm
.macro END
 leave
 ret
.endm
