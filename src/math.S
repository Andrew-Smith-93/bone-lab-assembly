#include "layout.inc"
.text
FN ml_new
mov [rbp-8],rdi
xor edi,edi
call gtk_label_new@PLT
mov [rbp-16],rax
mov rdi,rax
mov rsi,[rbp-8]
call gtk_label_set_markup@PLT
mov rdi,[rbp-16]
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,[rbp-16]
mov esi,1
call gtk_label_set_selectable@PLT
mov rdi,[rbp-16]
mov esi,1
call gtk_label_set_line_wrap@PLT
mov rdi,[rbp-16]
mov esi,48
call gtk_label_set_max_width_chars@PLT
mov rax,[rbp-16]
END
FN math_panel_new
mov [rbp-8],rdi
call gtk_notebook_new@PLT
mov m_book[rip],rax
call summary_new
xor edi,edi
xor esi,esi
call gtk_scrolled_window_new@PLT
mov m_scroll[rip],rax

mov edi,1
mov esi,8
call gtk_box_new@PLT
mov m_body[rip],rax
mov rdi,m_body[rip]
mov esi,12
call gtk_container_set_border_width@PLT
mov rdi,m_scroll[rip]
mov rsi,m_body[rip]
call gtk_container_add@PLT
lea rdi,mt0[rip]
call ml_new
mov rsi,rax
mov rdi,m_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt1[rip]
call ml_new
mov rsi,rax
mov rdi,m_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt2[rip]
call ml_new
mov rsi,rax
mov rdi,m_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,8
call gtk_box_new@PLT
mov m_invalid[rip],rax
mov rsi,rax
mov rdi,m_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt3[rip]
call ml_new
mov rsi,rax
mov rdi,m_invalid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,6
call gtk_box_new@PLT
mov m_valid[rip],rax
mov rsi,rax
mov rdi,m_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,6
call gtk_box_new@PLT
mov m_ik[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt4[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt5[rip]
call ml_new
mov m_target[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt6[rip]
call ml_new
mov m_lengths[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt7[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt8[rip]
call ml_new
mov m_radius[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt9[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt10[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,0
mov esi,6
call gtk_box_new@PLT
mov m_row[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt11[rip]
call ml_new
mov rsi,rax
mov rdi,m_row[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,3
call gtk_box_new@PLT
mov m_frac[rip],rax
mov rsi,rax
mov rdi,m_row[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt12[rip]
call ml_new
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
xor edi,edi
call gtk_separator_new@PLT
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt13[rip]
call ml_new
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,0
mov esi,6
call gtk_box_new@PLT
mov m_row[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt14[rip]
call ml_new
mov rsi,rax
mov rdi,m_row[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,3
call gtk_box_new@PLT
mov m_frac[rip],rax
mov rsi,rax
mov rdi,m_row[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt15[rip]
call ml_new
mov m_cosn[rip],rax
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
xor edi,edi
call gtk_separator_new@PLT
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt16[rip]
call ml_new
mov m_cosd[rip],rax
mov rsi,rax
mov rdi,m_frac[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt17[rip]
call ml_new
mov m_cosr[rip],rax
mov rsi,rax
mov rdi,m_row[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt18[rip]
call ml_new
mov m_coswork[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt19[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt20[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt21[rip]
call ml_new
mov m_ab[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt22[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt23[rip]
call ml_new
mov m_phi[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt24[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt25[rip]
call ml_new
mov m_bounds[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt26[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt27[rip]
call ml_new
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt28[rip]
call ml_new
mov m_shoulder[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt29[rip]
call ml_new
mov m_delta[rip],rax
mov rsi,rax
mov rdi,m_ik[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,6
call gtk_box_new@PLT
mov m_fk[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt30[rip]
call ml_new
mov rsi,rax
mov rdi,m_fk[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt31[rip]
call ml_new
mov m_fkangles[rip],rax
mov rsi,rax
mov rdi,m_fk[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt32[rip]
call ml_new
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt33[rip]
call ml_new
mov m_q[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt34[rip]
call ml_new
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt35[rip]
call ml_new
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt36[rip]
call ml_new
mov m_trig[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt37[rip]
call ml_new
mov m_ex[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt38[rip]
call ml_new
mov m_ey[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt39[rip]
call ml_new
mov m_ez[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt40[rip]
call ml_new
mov m_wx[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt41[rip]
call ml_new
mov m_wy[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt42[rip]
call ml_new
mov m_wz[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt43[rip]
call ml_new
mov m_end[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,8
call gtk_box_new@PLT
mov m_residual[rip],rax
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt44[rip]
call ml_new
mov rsi,rax
mov rdi,m_residual[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt45[rip]
call ml_new
mov rsi,rax
mov rdi,m_residual[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt46[rip]
call ml_new
mov m_error[rip],rax
mov rsi,rax
mov rdi,m_residual[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt47[rip]
call ml_new
mov rsi,rax
mov rdi,m_valid[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,mt48[rip]
call gtk_label_new@PLT
mov rdx,rax
mov rdi,m_book[rip]
mov rsi,m_scroll[rip]
call gtk_notebook_append_page@PLT
xor edi,edi
xor esi,esi
call gtk_scrolled_window_new@PLT
mov [rbp-16],rax
mov rdi,rax
mov rsi,[rbp-8]
call gtk_container_add@PLT
lea rdi,mt49[rip]
call gtk_label_new@PLT
mov rdx,rax
mov rdi,m_book[rip]
mov rsi,[rbp-16]
call gtk_notebook_append_page@PLT
mov rax,m_book[rip]
END
FN math_panel_update
mov [rbp-8],r12
mov [rbp-16],r13
mov [rbp-24],r14
mov [rbp-32],r15
mov r12,rdi
mov r13,rsi
mov r14d,edx
mov r15d,ecx
call summary_update
mov rdi,m_body[rip]
call gtk_widget_show_all@PLT
mov rdi,m_invalid[rip]
mov esi,r15d
xor esi,1
call gtk_widget_set_visible@PLT
mov rdi,m_valid[rip]
mov esi,r15d
call gtk_widget_set_visible@PLT
test r15d,r15d
jz .updated
mov rdi,m_ik[rip]
mov esi,r14d
xor esi,1
call gtk_widget_set_visible@PLT
mov rdi,m_residual[rip]
mov esi,r14d
xor esi,1
call gtk_widget_set_visible@PLT
mov rdi,m_fk[rip]
mov esi,r14d
call gtk_widget_set_visible@PLT
# stable half-angle intermediate work
movsd xmm0,[r12+L1]
addsd xmm0,[r12+L2]
movsd xmm1,[r12+L1]
subsd xmm1,[r12+L2]
andpd xmm1,m_abs[rip]
movsd xmm2,[r13+DIST]
maxsd xmm2,xmm1
minsd xmm2,xmm0
movsd md[rip],xmm2
movapd xmm3,xmm0
subsd xmm3,xmm2
addsd xmm0,xmm2
mulsd xmm0,xmm3
sqrtsd xmm0,xmm0
movsd md+8[rip],xmm0
movapd xmm3,xmm2
subsd xmm3,xmm1
addsd xmm1,xmm2
mulsd xmm1,xmm3
sqrtsd xmm1,xmm1
movsd md+16[rip],xmm1
call atan2@PLT
addsd xmm0,xmm0
movsd md+24[rip],xmm0
movsd xmm0,[r13+PITCH]
call cos@PLT
movsd md+32[rip],xmm0
movsd xmm0,[r13+PITCH]
call sin@PLT
movsd md+40[rip],xmm0
movsd xmm0,[r13+PHI]
mulsd xmm0,[r12+BRANCH]
movsd xmm1,[r13+PITCH]
subsd xmm1,xmm0
movsd md+48[rip],xmm1
movapd xmm0,xmm1
call cos@PLT
movsd md+56[rip],xmm0
movsd xmm0,md+48[rip]
call sin@PLT
movsd md+64[rip],xmm0
movsd xmm0,[r13+PHI]
call sin@PLT
mulsd xmm0,[r12+L2]
movsd md+72[rip],xmm0
movsd xmm0,[r13+PHI]
call cos@PLT
mulsd xmm0,[r12+L2]
addsd xmm0,[r12+L1]
movsd md+80[rip],xmm0

movsd xmm0,[r13+WX+0]
subsd xmm0,[r12+X+0]
movsd md+88[rip],xmm0
movsd xmm0,[r13+WX+8]
subsd xmm0,[r12+X+8]
movsd md+96[rip],xmm0
movsd xmm0,[r13+WX+16]
subsd xmm0,[r12+X+16]
movsd md+104[rip],xmm0
lea rdi,mt50[rip]
movsd xmm0,[r12+X]
movsd xmm1,[r12+Y]
movsd xmm2,[r12+Z]
mov eax,3
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_target[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt51[rip]
movsd xmm0,[r12+L1]
movsd xmm1,[r12+L2]
mov eax,2
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_lengths[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt52[rip]
movsd xmm0,[r12+X]
movsd xmm1,[r12+Y]
movsd xmm2,[r13+RHO]
movsd xmm3,[r13+RHO]
movsd xmm4,[r12+Z]
movsd xmm5,[r13+DIST]
mov eax,6
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_radius[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt53[rip]
movsd xmm0,[r13+DIST]
movsd xmm1,[r12+L1]
movsd xmm2,[r12+L2]
mov eax,3
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_cosn[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt54[rip]
movsd xmm0,[r12+L1]
movsd xmm1,[r12+L2]
mov eax,2
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_cosd[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt55[rip]
movsd xmm0,[r13+RAW]
mov eax,1
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_cosr[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt56[rip]
movsd xmm0,[r13+NUM]
movsd xmm1,[r13+DEN]
mov eax,2
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_coswork[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt57[rip]
movsd xmm0,md+0[rip]
movsd xmm1,md+8[rip]
movsd xmm2,md+16[rip]
mov eax,3
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_ab[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt58[rip]
movsd xmm0,md+8[rip]
movsd xmm1,md+16[rip]
movsd xmm2,md+24[rip]
movsd xmm3,md+24[rip]
movsd xmm4,[r12+MIN]
movsd xmm5,[r12+MAX]
movsd xmm6,[r13+PHI]
mov eax,7
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_phi[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt59[rip]
movsd xmm0,[r13+DMIN]
movsd xmm1,[r13+DMAX]
mov eax,2
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_bounds[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt60[rip]
movsd xmm0,[r12+Y]
movsd xmm1,[r12+X]
movsd xmm2,[r13+YAW]
movsd xmm3,[r12+Z]
movsd xmm4,[r13+RHO]
movsd xmm5,[r13+ELEV]
mov eax,6
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_shoulder[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt61[rip]
movsd xmm0,[r12+BRANCH]
movsd xmm1,md+72[rip]
movsd xmm2,md+80[rip]
movsd xmm3,[r13+DELTA]
movsd xmm4,[r13+ELEV]
movsd xmm5,[r13+DELTA]
movsd xmm6,[r13+PITCH]
mov eax,7
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_delta[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt62[rip]
movsd xmm0,[r13+YAW]
movsd xmm1,[r13+PITCH]
movsd xmm2,[r13+PHI]
movsd xmm3,[r12+MIN]
movsd xmm4,[r12+MAX]
mov eax,5
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_fkangles[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt63[rip]
movsd xmm0,[r13+PITCH]
movsd xmm1,[r12+BRANCH]
movsd xmm2,[r13+PHI]
movsd xmm3,md+48[rip]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_q[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt64[rip]
movsd xmm0,[r13+CY]
movsd xmm1,[r13+SY]
movsd xmm2,md+32[rip]
movsd xmm3,md+40[rip]
movsd xmm4,md+56[rip]
movsd xmm5,md+64[rip]
mov eax,6
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_trig[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt65[rip]
movsd xmm0,[r12+L1]
movsd xmm1,md+32[rip]
movsd xmm2,[r13+CY]
movsd xmm3,[r13+EX]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_ex[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt66[rip]
movsd xmm0,[r12+L1]
movsd xmm1,md+32[rip]
movsd xmm2,[r13+SY]
movsd xmm3,[r13+EY]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_ey[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt67[rip]
movsd xmm0,[r12+L1]
movsd xmm1,md+40[rip]
movsd xmm2,[r13+EZ]
mov eax,3
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_ez[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt68[rip]
movsd xmm0,[r13+EX]
movsd xmm1,[r12+L2]
movsd xmm2,md+56[rip]
movsd xmm3,[r13+CY]
movsd xmm4,[r13+WX]
mov eax,5
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_wx[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt69[rip]
movsd xmm0,[r13+EY]
movsd xmm1,[r12+L2]
movsd xmm2,md+56[rip]
movsd xmm3,[r13+SY]
movsd xmm4,[r13+WY]
mov eax,5
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_wy[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt70[rip]
movsd xmm0,[r13+EZ]
movsd xmm1,[r12+L2]
movsd xmm2,md+64[rip]
movsd xmm3,[r13+WZ]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_wz[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt71[rip]
movsd xmm0,[r13+EX]
movsd xmm1,[r13+EY]
movsd xmm2,[r13+EZ]
movsd xmm3,[r13+WX]
movsd xmm4,[r13+WY]
movsd xmm5,[r13+WZ]
mov eax,6
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_end[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
lea rdi,mt72[rip]
movsd xmm0,md+88[rip]
movsd xmm1,md+96[rip]
movsd xmm2,md+104[rip]
movsd xmm3,[r13+ERROR]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-40],rax
mov rsi,rax
mov rdi,m_error[rip]
call gtk_label_set_markup@PLT
mov rdi,[rbp-40]
call g_free@PLT
.updated:
mov r12,[rbp-8]
mov r13,[rbp-16]
mov r14,[rbp-24]
mov r15,[rbp-32]
END
.section .rodata
.balign 16
m_abs: .quad 0x7fffffffffffffff,0x7fffffffffffffff
mt0: .asciz "MATHEMATICAL WORKING"
mt1: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ψ: yaw    θ: shoulder pitch    φ: elbow flexion\nσ ∈ {−1, +1}: bend sign • angles in radians</span>"
mt2: .asciz "Displayed decimals are rounded; calculations use full precision. Select equations to copy. A linear transcript is available in Plain-text working."
mt3: .asciz "Invalid constraints or angles. Correct the inputs to calculate a pose."
mt4: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">1  ·  Target and geometry</span>"
mt5: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt6: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt7: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ρ = √(x² + y²),    r = √(ρ² + z²)</span>"
mt8: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt9: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">2  ·  Law of cosines</span>"
mt10: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">For an exact unconstrained target solution:\nr² = L<sub>1</sub>² + L<sub>2</sub>² + 2L<sub>1</sub>L<sub>2</sub> cos φ</span>"
mt11: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">c =</span>"
mt12: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">r² − L<sub>1</sub>² − L<sub>2</sub>²</span>"
mt13: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">2L<sub>1</sub>L<sub>2</sub></span>"
mt14: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">=</span>"
mt15: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt16: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt17: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt18: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt19: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">3  ·  Stable flexion and constraints</span>"
mt20: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">d = clamp(r, |L<sub>1</sub> − L<sub>2</sub>|, L<sub>1</sub> + L<sub>2</sub>)\nA = √((L<sub>1</sub> + L<sub>2</sub> − d)(L<sub>1</sub> + L<sub>2</sub> + d))\nB = √((d − |L<sub>1</sub> − L<sub>2</sub>|)(d + |L<sub>1</sub> − L<sub>2</sub>|))</span>"
mt21: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt22: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">φ<sub>0</sub> = 2 atan2(A, B)\nφ = clamp(φ<sub>0</sub>, φ<sub>min</sub>, φ<sub>max</sub>)</span>"
mt23: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt24: .asciz "This half-angle form is equivalent to arccos(c) on the geometric domain, and remains accurate near a folded chain."
mt25: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt26: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">4  ·  Shoulder angles</span>"
mt27: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ψ = atan2(y, x),    β = atan2(z, ρ)\nδ = σ atan2(L<sub>2</sub> sin φ, L<sub>1</sub> + L<sub>2</sub> cos φ)\nθ = β + δ</span>"
mt28: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt29: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt30: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">1  ·  Joint-angle inputs</span>"
mt31: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt32: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">Forward reconstruction · shared by IK and FK</span>"
mt33: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt34: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"><b>R</b><sub>z</sub>(ψ) =\n<span font_family=\"DejaVu Sans Mono\">⎡ cos ψ  −sin ψ  0 ⎤\n⎢ sin ψ   cos ψ  0 ⎥\n⎣   0       0    1 ⎦</span></span>"
mt35: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"><b>e</b> = <b>R</b><sub>z</sub>(ψ) [L<sub>1</sub> cos θ, 0, L<sub>1</sub> sin θ]<sup>T</sup>\n<b>w</b> = <b>e</b> + <b>R</b><sub>z</sub>(ψ) [L<sub>2</sub> cos q, 0, L<sub>2</sub> sin q]<sup>T</sup></span>"
mt36: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt37: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt38: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt39: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt40: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt41: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt42: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt43: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt44: .asciz "<span size=\"11000\" weight=\"bold\" foreground=\"#2454a4\">Endpoint verification</span>"
mt45: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ε = ‖<b>w</b> − <b>t</b>‖<sub>2</sub>\n= √((w<sub>x</sub> − x)² + (w<sub>y</sub> − y)² + (w<sub>z</sub> − z)²)</span>"
mt46: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"> </span>"
mt47: .asciz "The result banner and Plain-text working tab describe reachability, precision limits and singular configurations. No iterative convergence is claimed."
mt48: .asciz "Full derivation"
mt49: .asciz "Plain-text working"
mt50: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"><b>t</b> = [%.5f, %.5f, %.5f]<sup>T</sup></span>"
mt51: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">L<sub>1</sub> = %.5f,   L<sub>2</sub> = %.5f</span>"
mt52: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ρ = √((%.5f)² + (%.5f)²) = %.8f\nr = √((%.5f)² + (%.5f)²) = %.8f</span>"
mt53: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">(%.5f)² − (%.5f)² − (%.5f)²</span>"
mt54: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">2 × %.5f × %.5f</span>"
mt55: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">= %.8f</span>"
mt56: .asciz "Raw target cosine before limits.\nNumerator = %.8f; denominator = %.8f"
mt57: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">d = %.8f,   A = %.8f,   B = %.8f</span>"
mt58: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">φ<sub>0</sub> = 2 atan2(%.8f, %.8f) = %.8f\nφ = clamp(%.8f, %.8f, %.8f) = %.8f</span>"
mt59: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">d(φ) = √((L<sub>1</sub> − L<sub>2</sub>)² + 4L<sub>1</sub>L<sub>2</sub> cos²(φ/2))\nd<sub>min</sub> = %.8f,    d<sub>max</sub> = %.8f</span>"
mt60: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ψ = atan2(%.5f, %.5f) = %.8f\nβ = atan2(%.5f, %.8f) = %.8f</span>"
mt61: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">δ = %.0f atan2(%.8f, %.8f) = %.8f\nθ = %.8f + (%.8f) = %.8f</span>"
mt62: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ψ = %.8f,   θ = %.8f,   φ = %.8f\nφ<sub>min</sub> = %.8f ≤ φ ≤ %.8f = φ<sub>max</sub></span>"
mt63: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">q = θ − σφ = %.8f − (%.0f × %.8f) = %.8f</span>"
mt64: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">cos ψ = %.8f,   sin ψ = %.8f\ncos θ = %.8f,   sin θ = %.8f\ncos q = %.8f,   sin q = %.8f</span>"
mt65: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">e<sub>x</sub> = L<sub>1</sub> cos θ cos ψ\n= (%.8f) × (%.8f) × (%.8f) = %.8f</span>"
mt66: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">e<sub>y</sub> = L<sub>1</sub> cos θ sin ψ\n= (%.8f) × (%.8f) × (%.8f) = %.8f</span>"
mt67: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">e<sub>z</sub> = L<sub>1</sub> sin θ\n= (%.8f) × (%.8f) = %.8f</span>"
mt68: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">w<sub>x</sub> = e<sub>x</sub> + L<sub>2</sub> cos q cos ψ\n= %.8f + (%.8f) × (%.8f) × (%.8f) = %.8f</span>"
mt69: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">w<sub>y</sub> = e<sub>y</sub> + L<sub>2</sub> cos q sin ψ\n= %.8f + (%.8f) × (%.8f) × (%.8f) = %.8f</span>"
mt70: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">w<sub>z</sub> = e<sub>z</sub> + L<sub>2</sub> sin q\n= %.8f + (%.8f) × (%.8f) = %.8f</span>"
mt71: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\"><b>e</b> = [%.8f, %.8f, %.8f]<sup>T</sup>\n<b>w</b> = [%.8f, %.8f, %.8f]<sup>T</sup></span>"
mt72: .asciz "<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">ε = √((%.8f)² + (%.8f)² + (%.8f)²)\n= %.10f length units</span>"
.bss
.align 8
m_body: .skip 8
m_book: .skip 8
m_scroll: .skip 8
m_row: .skip 8
m_frac: .skip 8
m_invalid: .skip 8
m_valid: .skip 8
m_ik: .skip 8
m_fk: .skip 8
m_residual: .skip 8
m_target: .skip 8
m_lengths: .skip 8
m_radius: .skip 8
m_cosn: .skip 8
m_cosd: .skip 8
m_cosr: .skip 8
m_coswork: .skip 8
m_ab: .skip 8
m_phi: .skip 8
m_bounds: .skip 8
m_shoulder: .skip 8
m_delta: .skip 8
m_fkangles: .skip 8
m_q: .skip 8
m_trig: .skip 8
m_ex: .skip 8
m_ey: .skip 8
m_ez: .skip 8
m_wx: .skip 8
m_wy: .skip 8
m_wz: .skip 8
m_end: .skip 8
m_error: .skip 8
md: .skip 112
.section .note.GNU-stack,"",@progbits
#ifdef UI_TEST
.text
# Offscreen evidence only: render the full scrollable equation worksheet.
FN math_capture
mov [rbp-8],rdi
mov rdi,m_book[rip]
mov esi,1
call gtk_notebook_set_current_page@PLT
mov DWORD PTR [rbp-40],0
.capture_drain:
xor edi,edi
call gtk_main_iteration_do@PLT
inc DWORD PTR [rbp-40]
cmp DWORD PTR [rbp-40],50
jl .capture_drain
mov rdi,m_book[rip]
call gtk_widget_get_toplevel@PLT
mov rdi,rax
call gtk_container_check_resize@PLT
mov rdi,m_body[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-12],eax
mov rdi,m_body[rip]
call gtk_widget_get_allocated_height@PLT
mov edx,eax
mov esi,[rbp-12]
xor edi,edi
call cairo_image_surface_create@PLT
mov [rbp-24],rax
mov rdi,rax
call cairo_create@PLT
mov [rbp-32],rax
mov rsi,rax
mov rdi,m_body[rip]
call gtk_widget_draw@PLT
mov rdi,[rbp-24]
mov rsi,[rbp-8]
call cairo_surface_write_to_png@PLT
mov [rbp-36],eax
mov rdi,[rbp-32]
call cairo_destroy@PLT
mov rdi,[rbp-24]
call cairo_surface_destroy@PLT
mov rdi,m_book[rip]
xor esi,esi
call gtk_notebook_set_current_page@PLT
mov eax,[rbp-36]
END
#endif
#ifdef UI_TEST
.text
FN math_check
mov [rbp-4],edi
mov [rbp-8],esi
mov rdi,m_book[rip]
call gtk_notebook_get_n_pages@PLT
cmp eax,4
jne .math_bad
mov rdi,m_valid[rip]
call gtk_widget_get_visible@PLT
cmp eax,[rbp-8]
jne .math_bad
cmp DWORD PTR [rbp-8],0
je .math_good
mov rdi,m_ik[rip]
call gtk_widget_get_visible@PLT
xor eax,1
cmp eax,[rbp-4]
jne .math_bad
mov rdi,m_fk[rip]
call gtk_widget_get_visible@PLT
cmp eax,[rbp-4]
jne .math_bad
mov rdi,m_end[rip]
call gtk_label_get_use_markup@PLT
test eax,eax
jz .math_bad
mov rdi,m_end[rip]
call gtk_label_get_selectable@PLT
test eax,eax
jz .math_bad
mov rdi,m_end[rip]
call gtk_widget_get_accessible@PLT
mov rdi,rax
call atk_object_get_name@PLT
test rax,rax
jz .math_bad
cmp BYTE PTR [rax],0
je .math_bad
mov rdi,m_book[rip]
mov esi,2
call gtk_notebook_set_current_page@PLT
mov rdi,m_book[rip]
call gtk_notebook_get_current_page@PLT
cmp eax,2
jne .math_bad
mov rdi,m_book[rip]
xor esi,esi
call gtk_notebook_set_current_page@PLT
.math_good:
mov eax,1
END
.math_bad:
xor eax,eax
END
#endif

.text
FN summary_new
xor edi,edi
xor esi,esi
call gtk_scrolled_window_new@PLT
mov summary_scroll[rip],rax
mov edi,1
mov esi,10
call gtk_box_new@PLT
mov summary_body[rip],rax
mov rdi,rax
mov esi,14
call gtk_container_set_border_width@PLT
mov rdi,summary_scroll[rip]
mov rsi,summary_body[rip]
call gtk_container_add@PLT
lea rdi,summary_title[rip]
call ml_new
mov summary_result[rip],rax
mov rsi,rax
mov rdi,summary_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,summary_hint[rip]
call ml_new
mov rsi,rax
mov rdi,summary_body[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,summary_tab[rip]
call gtk_label_new@PLT
mov rdx,rax
mov rdi,m_book[rip]
mov rsi,summary_scroll[rip]
call gtk_notebook_append_page@PLT
END
# Called with the math updater's r12=input, r13=output, r14=mode, r15=valid.
FN summary_update
test r15d,r15d
jz .summary_invalid
lea rdi,summary_format[rip]
movsd xmm0,[r13+YAW]
divsd xmm0,summary_radians[rip]
movsd xmm1,[r13+PITCH]
divsd xmm1,summary_radians[rip]
movsd xmm2,[r13+PHI]
divsd xmm2,summary_radians[rip]
movsd xmm3,[r13+WX]
movsd xmm4,[r13+WY]
movsd xmm5,[r13+WZ]
mov eax,6
call g_strdup_printf@PLT
mov [rbp-8],rax
mov rdi,rax
call g_string_new@PLT
mov [rbp-16],rax
mov rdi,[rbp-8]
call g_free@PLT
test r14d,r14d
jnz .summary_fk
mov rdi,[rbp-16]
lea rsi,summary_ik_tail[rip]
movsd xmm0,[r13+ERROR]
movsd xmm1,[r13+DMIN]
movsd xmm2,[r13+DMAX]
mov eax,3
call g_string_append_printf@PLT
jmp .summary_set
.summary_fk:
mov rdi,[rbp-16]
lea rsi,summary_fk_tail[rip]
call g_string_append@PLT
.summary_set:
mov rdi,summary_result[rip]
mov rax,[rbp-16]
mov rsi,[rax]
call gtk_label_set_markup@PLT
mov rdi,[rbp-16]
mov esi,1
call g_string_free@PLT
END
.summary_invalid:
mov rdi,summary_result[rip]
lea rsi,summary_invalid[rip]
call gtk_label_set_markup@PLT
END
.section .rodata
summary_tab: .asciz "Results"
summary_title: .asciz "<b>Pose summary</b>"
summary_hint: .asciz "Open <b>Full derivation</b> for the equations and substitutions, or <b>Plain-text working</b> to copy the complete calculation."
summary_format: .asciz "<b>JOINT ANGLES</b>\nYaw  %.2f°    •    Pitch  %.2f°    •    Flexion  %.2f°\n\n<b>ENDPOINT  (x, y, z)</b>\n<span font_family=\"DejaVu Math TeX Gyre\" size=\"11000\">W = [%.5f, %.5f, %.5f]ᵀ</span>\n"
summary_ik_tail: .asciz "\n<b>TARGET ERROR</b>   %.3g units\nAllowed target distance: %.5f to %.5f units"
summary_fk_tail: .asciz "\nDirect forward calculation. There is no target residual in FK mode."
summary_invalid: .asciz "<b>No valid pose</b>\nUse 0° ≤ minimum ≤ maximum ≤ 180°.\nIn FK mode, flexion must be within those limits."
summary_radians: .double 0.017453292519943295
.bss
.align 8
summary_scroll: .skip 8
summary_body: .skip 8
summary_result: .skip 8
