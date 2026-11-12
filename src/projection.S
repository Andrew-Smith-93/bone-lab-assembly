#include "layout.inc"
.text
# project(point[3], camera[5], screen[3]): azimuth,elevation,scale,cx,cy
# Orthographic rotation. output[2] is camera depth, larger is nearer.
.global project
.type project,@function
project:
 push rbp
 mov rbp,rsp
 sub rsp,80
 mov [rbp-8],rdi
 mov [rbp-16],rsi
 mov [rbp-24],rdx
 movsd xmm0,[rsi]
 call cos@PLT
 movsd [rbp-32],xmm0
 mov rsi,[rbp-16]
 movsd xmm0,[rsi]
 call sin@PLT
 movsd [rbp-40],xmm0
 mov rsi,[rbp-16]
 movsd xmm0,[rsi+8]
 call cos@PLT
 movsd [rbp-48],xmm0
 mov rsi,[rbp-16]
 movsd xmm0,[rsi+8]
 call sin@PLT
 movsd [rbp-56],xmm0
 mov rdi,[rbp-8]
 mov rsi,[rbp-16]
 mov rdx,[rbp-24]
 # right = -sin(a)*x + cos(a)*y
 movsd xmm0,[rdi+8]
 mulsd xmm0,[rbp-32]
 movsd xmm1,[rdi]
 mulsd xmm1,[rbp-40]
 subsd xmm0,xmm1
 mulsd xmm0,[rsi+16]
 addsd xmm0,[rsi+24]
 movsd [rdx],xmm0
 # horizontal depth h=cos(a)*x+sin(a)*y
 movsd xmm0,[rdi]
 mulsd xmm0,[rbp-32]
 movsd xmm1,[rdi+8]
 mulsd xmm1,[rbp-40]
 addsd xmm0,xmm1
 # up=cos(e)*z-sin(e)*h
 movsd xmm1,[rdi+16]
 mulsd xmm1,[rbp-48]
 movapd xmm2,xmm0
 mulsd xmm2,[rbp-56]
 subsd xmm1,xmm2
 mulsd xmm1,[rsi+16]
 movsd xmm2,[rsi+32]
 subsd xmm2,xmm1
 movsd [rdx+8],xmm2
 mulsd xmm0,[rbp-48]
 movsd xmm1,[rdi+16]
 mulsd xmm1,[rbp-56]
 addsd xmm0,xmm1
 movsd [rdx+16],xmm0
 leave
 ret
.section .note.GNU-stack,"",@progbits
