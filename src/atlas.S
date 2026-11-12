#include "layout.inc"
// SysV AMD64: atlas_search(double input[12], void *output88).
// Return 1 nearest sampled pose, 0 no sample in limits, -1 invalid.
// Output doubles: yaw,pitch,flex,elbow XYZ,wrist XYZ,error; uint64 count.
// No allocations, transcendental calls, mutable globals or hidden state.
.macro ATLAS_CARTESIAN
 movsd xmm0,[r9+24]
 movsd xmm1,[r9+32]
 movsd xmm2,[r9+40]
 mulsd xmm0,[r8+24]
 mulsd xmm1,[r8+24]
 mulsd xmm2,[r8+24]
 mulsd xmm2,xmm14
 movsd xmm3,[r9+48]
 movsd xmm4,[r9+56]
 movsd xmm5,[r9+64]
 mulsd xmm3,[r8+32]
 mulsd xmm4,[r8+32]
 mulsd xmm5,[r8+32]
 mulsd xmm5,xmm14
 addsd xmm3,xmm0
 addsd xmm4,xmm1
 addsd xmm5,xmm2
.endm
.text
FN atlas_search
 test rsi,rsi
 jz .Latlas_invalid_null
 mov r8,rdi
 mov rdi,rsi
 xor eax,eax
 mov ecx,11
 rep stosq
 test r8,r8
 jz .Latlas_invalid
 // All inputs must be finite and magnitude <= 1e6, including angles.
 xor ecx,ecx
.Lvalidate:
 movsd xmm0,[r8+rcx*8]
 andpd xmm0,[rip+.Latlas_abs]
 ucomisd xmm0,[rip+.Latlas_million]
 ja .Latlas_invalid
 jp .Latlas_invalid
 inc ecx
 cmp ecx,12
 jne .Lvalidate
 movsd xmm0,[r8+24]
 ucomisd xmm0,[rip+.Latlas_min_length]
 jb .Latlas_invalid
 movsd xmm0,[r8+32]
 ucomisd xmm0,[rip+.Latlas_min_length]
 jb .Latlas_invalid
 movsd xmm0,[r8+40]
 pxor xmm1,xmm1
 ucomisd xmm0,xmm1
 jb .Latlas_invalid
 ucomisd xmm0,[r8+48]
 ja .Latlas_invalid
 movsd xmm0,[r8+48]
 ucomisd xmm0,[rip+.Latlas_180]
 ja .Latlas_invalid
 movsd xmm14,[r8+56]
 movapd xmm0,xmm14
 andpd xmm0,[rip+.Latlas_abs]
 ucomisd xmm0,[rip+.Latlas_one]
 jne .Latlas_invalid
 mov ecx,8
.Lvalidate_limits:
 movsd xmm0,[r8+rcx*8]
 ucomisd xmm0,[rip+.Latlas_neg180]
 jb .Latlas_invalid
 ucomisd xmm0,[r8+rcx*8+8]
 ja .Latlas_invalid
 movsd xmm0,[r8+rcx*8+8]
 ucomisd xmm0,[rip+.Latlas_180]
 ja .Latlas_invalid
 add ecx,2
 cmp ecx,12
 jne .Lvalidate_limits
 lea r9,[rip+pose_atlas_start]
 lea r10,[rip+pose_atlas_end]
 xor r11d,r11d
 xor edx,edx
 movsd xmm15,[rip+.Latlas_huge]
.Lscan:
 movsd xmm0,[r9]
 ucomisd xmm0,[r8+64]
 jb .Lnext
 ucomisd xmm0,[r8+72]
 ja .Lnext
 movsd xmm0,[r9+8]
 mulsd xmm0,xmm14
 ucomisd xmm0,[r8+80]
 jb .Lnext
 ucomisd xmm0,[r8+88]
 ja .Lnext
 movsd xmm0,[r9+16]
 ucomisd xmm0,[r8+40]
 jb .Lnext
 ucomisd xmm0,[r8+48]
 ja .Lnext
 inc r11
 ATLAS_CARTESIAN
 movapd xmm6,xmm3
 movapd xmm7,xmm4
 movapd xmm8,xmm5
 subsd xmm6,[r8]
 subsd xmm7,[r8+8]
 subsd xmm8,[r8+16]
 mulsd xmm6,xmm6
 mulsd xmm7,xmm7
 mulsd xmm8,xmm8
 addsd xmm6,xmm7
 addsd xmm6,xmm8
 ucomisd xmm6,xmm15
 jae .Lnext
 movapd xmm15,xmm6
 mov rdx,r9
.Lnext:
 add r9,72
 cmp r9,r10
 jb .Lscan
 test rdx,rdx
 jz .Latlas_empty
 mov r9,rdx
 ATLAS_CARTESIAN
 movsd [rsi+24],xmm0
 movsd [rsi+32],xmm1
 movsd [rsi+40],xmm2
 movsd [rsi+48],xmm3
 movsd [rsi+56],xmm4
 movsd [rsi+64],xmm5
 movsd xmm0,[r9]
 movsd [rsi],xmm0
 movsd xmm0,[r9+8]
 mulsd xmm0,xmm14
 movsd [rsi+8],xmm0
 movsd xmm0,[r9+16]
 movsd [rsi+16],xmm0
 sqrtsd xmm15,xmm15
 movsd [rsi+72],xmm15
 mov [rsi+80],r11
 mov eax,1
 END
.Latlas_empty:
 xor eax,eax
 END
.Latlas_invalid:
.Latlas_invalid_null:
 mov eax,-1
 END
.size atlas_search,.-atlas_search
.section .rodata
.balign 16
.Latlas_abs: .quad 0x7fffffffffffffff,0x7fffffffffffffff
.Latlas_one: .double 1
.Latlas_min_length: .double 0.001
.Latlas_million: .double 1000000
.Latlas_180: .double 180
.Latlas_neg180: .double -180
.Latlas_huge: .double 1.7976931348623157e308
.section .note.GNU-stack,"",@progbits
