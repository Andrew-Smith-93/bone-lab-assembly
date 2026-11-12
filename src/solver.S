#include "layout.inc"
.section .rodata
half: .double 0.5
one: .double 1
negone: .double -1
pi: .double 3.14159265358979323846
eps: .double 0.00000001
maxval: .double 1000000
minlen: .double 0.001
.balign 16
absbits: .quad 0x7fffffffffffffff,0x7fffffffffffffff
.section .text
# int ik_solve(const double input[8], double output[25]); 1 valid, 0 invalid.
# Output is zeroed on invalid input. No memory ownership, I/O or global mutation.
.global ik_solve
.type ik_solve,@function
ik_solve:
 push rbp
 mov rbp,rsp
 push r12
 push r13
 sub rsp,32
 mov r12,rdi
 mov r13,rsi
 mov rdi,rsi
 xor eax,eax
 mov ecx,25
 rep stosq
 xor ecx,ecx
.validate:
 movsd xmm0,[r12+rcx*8]
 andpd xmm0,absbits[rip]
 ucomisd xmm0,maxval[rip]
 ja .invalid
 jp .invalid
 inc ecx
 cmp ecx,8
 jne .validate
 movsd xmm0,[r12+L1]
 comisd xmm0,minlen[rip]
 jb .invalid
 movsd xmm0,[r12+L2]
 comisd xmm0,minlen[rip]
 jb .invalid
 pxor xmm0,xmm0
 comisd xmm0,[r12+MIN]
 ja .invalid
 movsd xmm0,[r12+MIN]
 comisd xmm0,[r12+MAX]
 ja .invalid
 movsd xmm0,[r12+MAX]
 comisd xmm0,pi[rip]
 ja .invalid
 movsd xmm0,[r12+BRANCH]
 comisd xmm0,one[rip]
 je .valid
 comisd xmm0,negone[rip]
 jne .invalid
.valid:
 movsd xmm0,[r12+X]
 movsd xmm1,[r12+Y]
 call hypot@PLT
 movsd [r13+RHO],xmm0
 movsd xmm1,[r12+Z]
 call hypot@PLT
 movsd [r13+DIST],xmm0
 movsd xmm0,[r12+Y]
 movsd xmm1,[r12+X]
 call atan2@PLT
 movsd [r13+YAW],xmm0
 movsd xmm0,[r13+RHO]
 comisd xmm0,eps[rip]
 ja .yaw_ready
 or QWORD PTR [r13+FLAGS],2
 # Only exact axis uses canonical yaw; small nonzero targets keep direction.
 pxor xmm1,xmm1
 comisd xmm0,xmm1
 jne .yaw_ready
 movsd [r13+YAW],xmm1
.yaw_ready:
 movsd xmm0,[r12+Z]
 movsd xmm1,[r13+RHO]
 call atan2@PLT
 movsd [r13+ELEV],xmm0
 movsd xmm0,[r13+DIST]
 pxor xmm1,xmm1
 comisd xmm0,xmm1
 jne .elev_ready
 movsd [r13+ELEV],xmm1
.elev_ready:
 movsd xmm0,[r12+L1]
 mulsd xmm0,xmm0
 movsd xmm1,[r12+L2]
 mulsd xmm1,xmm1
 addsd xmm0,xmm1
 movsd [rsp],xmm0
 movsd xmm0,[r12+L1]
 mulsd xmm0,[r12+L2]
 addsd xmm0,xmm0
 movsd [r13+DEN],xmm0
 movsd xmm0,[r13+DIST]
 mulsd xmm0,xmm0
 subsd xmm0,[rsp]
 movsd [r13+NUM],xmm0
 divsd xmm0,[r13+DEN]
 movsd [r13+RAW],xmm0
 # Stable equivalent of acos(c_raw), avoiding cancellation near full folding.
 movsd xmm0,[r12+L1]
 addsd xmm0,[r12+L2]
 movsd [rsp+8],xmm0
 movsd xmm1,[r12+L1]
 subsd xmm1,[r12+L2]
 andpd xmm1,absbits[rip]
 movsd [rsp+16],xmm1
 movsd xmm2,[r13+DIST]
 maxsd xmm2,xmm1
 minsd xmm2,xmm0
 movapd xmm3,xmm0
 subsd xmm3,xmm2
 addsd xmm0,xmm2
 mulsd xmm0,xmm3
 sqrtsd xmm0,xmm0
 movapd xmm3,xmm2
 subsd xmm3,xmm1
 addsd xmm1,xmm2
 mulsd xmm1,xmm3
 sqrtsd xmm1,xmm1
 call atan2@PLT
 addsd xmm0,xmm0
 maxsd xmm0,[r12+MIN]
 minsd xmm0,[r12+MAX]
 movsd [r13+PHI],xmm0
 call cos@PLT
 movsd [r13+C],xmm0
 movsd [r13+CP],xmm0
 movsd xmm0,[r13+PHI]
 call sin@PLT
 movsd [r13+SINPHI],xmm0
 andpd xmm0,absbits[rip]
 comisd xmm0,eps[rip]
 ja .regular
 or QWORD PTR [r13+FLAGS],4
.regular:
 movsd xmm0,[r13+SINPHI]
 mulsd xmm0,[r12+L2]
 movsd xmm1,[r13+CP]
 mulsd xmm1,[r12+L2]
 addsd xmm1,[r12+L1]
 call atan2@PLT
 mulsd xmm0,[r12+BRANCH]
 movsd [r13+DELTA],xmm0
 addsd xmm0,[r13+ELEV]
 movsd [r13+PITCH],xmm0
 call coordinates
 movsd xmm0,[r13+WX]
 subsd xmm0,[r12+X]
 movsd xmm1,[r13+WY]
 subsd xmm1,[r12+Y]
 call hypot@PLT
 movsd xmm1,[r13+WZ]
 subsd xmm1,[r12+Z]
 call hypot@PLT
 movsd [r13+ERROR],xmm0
 # Stable constrained radial bounds: hypot(L1-L2, 2sqrt(L1 L2)cos(phi/2)).
 movsd xmm0,[r12+MAX]
 call radius
 movsd [r13+DMIN],xmm0
 movsd xmm0,[r12+MIN]
 call radius
 movsd [r13+DMAX],xmm0
 movsd xmm0,[r13+DIST]
 addsd xmm0,eps[rip]
 comisd xmm0,[r13+DMIN]
 jb .outside
 movsd xmm0,[r13+DIST]
 subsd xmm0,eps[rip]
 comisd xmm0,[r13+DMAX]
 ja .outside
 movsd xmm0,[r13+ERROR]
 comisd xmm0,eps[rip]
 jbe .classified
 or QWORD PTR [r13+FLAGS],8
 jmp .classified
.outside:
 or QWORD PTR [r13+FLAGS],1
.classified:
 mov eax,1
 jmp .done
.invalid:
 xor eax,eax
.done:
 add rsp,32
 pop r13
 pop r12
 pop rbp
 ret
# Internal r12 input; xmm0 flexion -> stable reachable radius.
radius:
 push rbp
 mov rbp,rsp
 mulsd xmm0,half[rip]
 call cos@PLT
 movsd xmm1,[r12+L1]
 mulsd xmm1,[r12+L2]
 sqrtsd xmm1,xmm1
 addsd xmm1,xmm1
 mulsd xmm1,xmm0
 movsd xmm0,[r12+L1]
 subsd xmm0,[r12+L2]
 call hypot@PLT
 pop rbp
 ret

# Common FK reconstruction, internal ABI r12=input, r13=output.
coordinates:
 push rbp
 mov rbp,rsp
 sub rsp,32
 call cos@PLT
 mulsd xmm0,[r12+L1]
 movsd [rsp+8],xmm0
 movsd xmm0,[r13+PITCH]
 call sin@PLT
 mulsd xmm0,[r12+L1]
 movsd [r13+EZ],xmm0
 movsd xmm0,[r13+YAW]
 call sin@PLT
 movsd [r13+SY],xmm0
 mulsd xmm0,[rsp+8]
 movsd [r13+EY],xmm0
 movsd xmm0,[r13+YAW]
 call cos@PLT
 movsd [r13+CY],xmm0
 mulsd xmm0,[rsp+8]
 movsd [r13+EX],xmm0
 movsd xmm0,[r13+PHI]
 mulsd xmm0,[r12+BRANCH]
 movsd xmm1,[r13+PITCH]
 subsd xmm1,xmm0
 movsd [rsp+16],xmm1
 movapd xmm0,xmm1
 call cos@PLT
 mulsd xmm0,[r12+L2]
 movapd xmm1,xmm0
 mulsd xmm1,[r13+CY]
 addsd xmm1,[r13+EX]
 movsd [r13+WX],xmm1
 mulsd xmm0,[r13+SY]
 addsd xmm0,[r13+EY]
 movsd [r13+WY],xmm0
 movsd xmm0,[rsp+16]
 call sin@PLT
 mulsd xmm0,[r12+L2]
 addsd xmm0,[r13+EZ]
 movsd [r13+WZ],xmm0
 leave
 ret

# FK input x/y/z are yaw, shoulder pitch and unsigned elbow flexion (radians).
# Invalid inputs leave zero output. Bounds and lengths use the same contract as IK.
.global fk_solve
.type fk_solve,@function
fk_solve:
 push rbp
 mov rbp,rsp
 push r12
 push r13
 sub rsp,16
 mov r12,rdi
 mov r13,rsi
 call ik_solve
 test eax,eax
 jz .fk_done
 movsd xmm0,[r12+Z]
 comisd xmm0,[r12+MIN]
 jb .fk_bad
 comisd xmm0,[r12+MAX]
 ja .fk_bad
 movsd [r13+PHI],xmm0
 call sin@PLT
 movsd [r13+SINPHI],xmm0
 mov QWORD PTR [r13+FLAGS],0
 andpd xmm0,absbits[rip]
 comisd xmm0,eps[rip]
 ja .fk_angles
 or QWORD PTR [r13+FLAGS],4
.fk_angles:
 movsd xmm0,[r12+X]
 movsd [r13+YAW],xmm0
 movsd xmm0,[r12+Y]
 movsd [r13+PITCH],xmm0
 call coordinates
 movsd xmm0,[r13+WX]
 movsd xmm1,[r13+WY]
 call hypot@PLT
 movsd [r13+RHO],xmm0
 comisd xmm0,eps[rip]
 ja .fk_radius
 or QWORD PTR [r13+FLAGS],2
.fk_radius:
 movsd xmm1,[r13+WZ]
 call hypot@PLT
 movsd [r13+DIST],xmm0
 mov QWORD PTR [r13+ERROR],0
 mov eax,1
 jmp .fk_done
.fk_bad:
 mov rdi,r13
 xor eax,eax
 mov ecx,25
 rep stosq
.fk_done:
 add rsp,16
 pop r13
 pop r12
 pop rbp
 ret
.section .note.GNU-stack,"",@progbits
