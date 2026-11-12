#include "layout.inc"
.text
FN main
xor edi,edi
xor esi,esi
call gtk_init_check@PLT
test eax,eax
jz no_display
call apply_style
#ifdef UI_TEST
call gtk_offscreen_window_new@PLT
#else
xor edi,edi
call gtk_window_new@PLT
#endif
mov win[rip],rax
mov rdi,rax
lea rsi,str0[rip]
call gtk_window_set_title@PLT
mov rdi,win[rip]
mov esi,1320
mov edx,880
call gtk_window_set_default_size@PLT
mov rdi,win[rip]
mov esi,20
call gtk_container_set_border_width@PLT
mov edi,1
mov esi,12
call gtk_box_new@PLT
mov root[rip],rax
mov rsi,rax
mov rdi,win[rip]
call gtk_container_add@PLT
lea rdi,str1[rip]
call gtk_label_new@PLT
mov rsi,rax
mov rdi,root[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,str2[rip]
call gtk_label_new@PLT
mov rsi,rax
mov rdi,root[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
xor edi,edi
mov esi,16
call gtk_box_new@PLT
mov body[rip],rax
mov rsi,rax
mov rdi,root[rip]
mov edx,1
mov ecx,1
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,8
call gtk_box_new@PLT
mov controls[rip],rax
mov rsi,rax
mov rdi,body[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,str3[rip]
call gtk_check_button_new_with_label@PLT
mov mode[rip],rax
mov rsi,rax
mov rdi,controls[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,str4[rip]
call gtk_check_button_new_with_label@PLT
mov branch[rip],rax
mov rsi,rax
mov rdi,controls[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
call gtk_grid_new@PLT
mov grid[rip],rax
mov rsi,rax
mov rdi,controls[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
mov rdi,grid[rip]
mov esi,7
call gtk_grid_set_row_spacing@PLT
mov rdi,grid[rip]
mov esi,12
call gtk_grid_set_column_spacing@PLT
lea rdi,str5[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl6[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl7[rip]
movsd xmm1,dbl8[rip]
movsd xmm2,dbl9[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+0[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+0[rip]
movsd xmm0,dbl10[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+0[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+0[rip]
mov edx,1
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str11[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl12[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl13[rip]
movsd xmm1,dbl14[rip]
movsd xmm2,dbl15[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+8[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+8[rip]
movsd xmm0,dbl16[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+8[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+8[rip]
mov edx,1
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str17[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl18[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,2
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl19[rip]
movsd xmm1,dbl20[rip]
movsd xmm2,dbl21[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+16[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+16[rip]
movsd xmm0,dbl22[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+16[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+16[rip]
mov edx,1
mov ecx,2
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str23[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl24[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,3
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl25[rip]
movsd xmm1,dbl26[rip]
movsd xmm2,dbl27[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+24[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+24[rip]
movsd xmm0,dbl28[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+24[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+24[rip]
mov edx,1
mov ecx,3
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str29[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl30[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,4
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl31[rip]
movsd xmm1,dbl32[rip]
movsd xmm2,dbl33[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+32[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+32[rip]
movsd xmm0,dbl34[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+32[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+32[rip]
mov edx,1
mov ecx,4
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str35[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl36[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,5
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl37[rip]
movsd xmm1,dbl38[rip]
movsd xmm2,dbl39[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+40[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+40[rip]
movsd xmm0,dbl40[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+40[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+40[rip]
mov edx,1
mov ecx,5
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str41[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl42[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,6
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl43[rip]
movsd xmm1,dbl44[rip]
movsd xmm2,dbl45[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+48[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+48[rip]
movsd xmm0,dbl46[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+48[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+48[rip]
mov edx,1
mov ecx,6
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str47[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl48[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,7
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl49[rip]
movsd xmm1,dbl50[rip]
movsd xmm2,dbl51[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+56[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+56[rip]
movsd xmm0,dbl52[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+56[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+56[rip]
mov edx,1
mov ecx,7
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str53[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl54[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,8
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl55[rip]
movsd xmm1,dbl56[rip]
movsd xmm2,dbl57[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+64[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+64[rip]
movsd xmm0,dbl58[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+64[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+64[rip]
mov edx,1
mov ecx,8
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str59[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl60[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,9
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl61[rip]
movsd xmm1,dbl62[rip]
movsd xmm2,dbl63[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+72[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+72[rip]
movsd xmm0,dbl64[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+72[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+72[rip]
mov edx,1
mov ecx,9
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str65[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl66[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,10
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl67[rip]
movsd xmm1,dbl68[rip]
movsd xmm2,dbl69[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+80[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+80[rip]
movsd xmm0,dbl70[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+80[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+80[rip]
mov edx,1
mov ecx,10
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str71[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl72[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,11
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl73[rip]
movsd xmm1,dbl74[rip]
movsd xmm2,dbl75[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+88[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+88[rip]
movsd xmm0,dbl76[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+88[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+88[rip]
mov edx,1
mov ecx,11
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str77[rip]
call gtk_label_new_with_mnemonic@PLT
mov temp[rip],rax
mov rdi,rax
movsd xmm0,dbl78[rip]
call gtk_label_set_xalign@PLT
mov rdi,grid[rip]
mov rsi,temp[rip]
xor edx,edx
mov ecx,12
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,dbl79[rip]
movsd xmm1,dbl80[rip]
movsd xmm2,dbl81[rip]
call gtk_spin_button_new_with_range@PLT
mov spins+96[rip],rax
mov rdi,rax
mov esi,2
call gtk_spin_button_set_digits@PLT
mov rdi,spins+96[rip]
movsd xmm0,dbl82[rip]
call gtk_spin_button_set_value@PLT
mov rdi,temp[rip]
mov rsi,spins+96[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,grid[rip]
mov rsi,spins+96[rip]
mov edx,1
mov ecx,12
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
lea rdi,str83[rip]
call gtk_label_new@PLT
mov rsi,rax
mov rdi,controls[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
mov edi,1
mov esi,10
call gtk_box_new@PLT
mov right[rip],rax
mov rsi,rax
mov rdi,body[rip]
mov edx,1
mov ecx,1
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,ready_status[rip]
call gtk_label_new@PLT
mov status[rip],rax
mov rsi,rax
mov rdi,right[rip]
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
call gtk_drawing_area_new@PLT
mov canvas[rip],rax
mov rdi,rax
mov esi,500
mov edx,330
call gtk_widget_set_size_request@PLT
mov rsi,canvas[rip]
mov rdi,right[rip]
mov edx,1
mov ecx,1
xor r8d,r8d
call gtk_box_pack_start@PLT
lea rdi,str84[rip]
call gtk_label_new@PLT
mov rsi,rax
mov rdi,right[rip]
mov edx,0
mov ecx,0
xor r8d,r8d
call gtk_box_pack_start@PLT
call gtk_text_view_new@PLT
mov mathview[rip],rax
mov rdi,rax
xor esi,esi
call gtk_text_view_set_editable@PLT
mov rdi,mathview[rip]
mov esi,1
call gtk_text_view_set_monospace@PLT
mov rdi,mathview[rip]
mov esi,3
call gtk_text_view_set_wrap_mode@PLT
mov rdi,mathview[rip]
mov esi,12
call gtk_text_view_set_left_margin@PLT
mov rdi,mathview[rip]
mov esi,10
call gtk_text_view_set_top_margin@PLT
xor edi,edi
xor esi,esi
call gtk_scrolled_window_new@PLT
mov scroll[rip],rax
mov rdi,rax
mov esi,-1
mov edx,270
call gtk_widget_set_size_request@PLT
mov rdi,scroll[rip]
mov rsi,mathview[rip]
call gtk_container_add@PLT
mov rsi,scroll[rip]
mov rdi,right[rip]
mov edx,1
mov ecx,1
xor r8d,r8d
call gtk_box_pack_start@PLT
mov rdi,canvas[rip]
lea rsi,str85[rip]
lea rdx,draw[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,mode[rip]
lea rsi,str86[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,branch[rip]
lea rsi,str87[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+0[rip]
lea rsi,str88[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+8[rip]
lea rsi,str89[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+16[rip]
lea rsi,str90[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+24[rip]
lea rsi,str91[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+32[rip]
lea rsi,str92[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+40[rip]
lea rsi,str93[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+48[rip]
lea rsi,str94[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+56[rip]
lea rsi,str95[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+64[rip]
lea rsi,str96[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+72[rip]
lea rsi,str97[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+80[rip]
lea rsi,str98[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+88[rip]
lea rsi,str99[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,spins+96[rip]
lea rsi,str100[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,win[rip]
lea rsi,str101[rip]
lea rdx,quit[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
call update
mov rdi,win[rip]
call gtk_widget_show_all@PLT
#ifdef UI_TEST
 call ui_test
 END
#else
 call gtk_main@PLT
 xor eax,eax
 END
#endif
no_display:
 mov eax,77
 END

FN quit
call gtk_main_quit@PLT
END
FN update
mov rdi,spins+0[rip]
call gtk_spin_button_get_value@PLT
movsd values+0[rip],xmm0
mov rdi,spins+8[rip]
call gtk_spin_button_get_value@PLT
movsd values+8[rip],xmm0
mov rdi,spins+16[rip]
call gtk_spin_button_get_value@PLT
movsd values+16[rip],xmm0
mov rdi,spins+24[rip]
call gtk_spin_button_get_value@PLT
movsd values+24[rip],xmm0
mov rdi,spins+32[rip]
call gtk_spin_button_get_value@PLT
movsd values+32[rip],xmm0
mov rdi,spins+40[rip]
call gtk_spin_button_get_value@PLT
movsd values+40[rip],xmm0
mov rdi,spins+48[rip]
call gtk_spin_button_get_value@PLT
movsd values+48[rip],xmm0
mov rdi,spins+56[rip]
call gtk_spin_button_get_value@PLT
movsd values+56[rip],xmm0
mov rdi,spins+64[rip]
call gtk_spin_button_get_value@PLT
movsd values+64[rip],xmm0
mov rdi,spins+72[rip]
call gtk_spin_button_get_value@PLT
movsd values+72[rip],xmm0
mov rdi,spins+80[rip]
call gtk_spin_button_get_value@PLT
movsd values+80[rip],xmm0
mov rdi,spins+88[rip]
call gtk_spin_button_get_value@PLT
movsd values+88[rip],xmm0
mov rdi,spins+96[rip]
call gtk_spin_button_get_value@PLT
movsd values+96[rip],xmm0
movsd xmm0,values+0[rip]

movsd inputs+0[rip],xmm0
movsd xmm0,values+8[rip]

movsd inputs+8[rip],xmm0
movsd xmm0,values+16[rip]

movsd inputs+16[rip],xmm0
movsd xmm0,values+24[rip]

movsd inputs+24[rip],xmm0
movsd xmm0,values+32[rip]

movsd inputs+32[rip],xmm0
movsd xmm0,values+40[rip]
mulsd xmm0,radians[rip]
movsd inputs+40[rip],xmm0
movsd xmm0,values+48[rip]
mulsd xmm0,radians[rip]
movsd inputs+48[rip],xmm0
mov rdi,branch[rip]
call gtk_toggle_button_get_active@PLT
movsd xmm0,dbl102[rip]
test eax,eax
jz branch_done
movsd xmm0,dbl103[rip]
branch_done:
movsd inputs+56[rip],xmm0
mov rdi,mode[rip]
call gtk_toggle_button_get_active@PLT
mov is_fk[rip],eax
test eax,eax
jz solve_ik
movsd xmm0,values+56[rip]
mulsd xmm0,radians[rip]
movsd inputs+0[rip],xmm0
movsd xmm0,values+64[rip]
mulsd xmm0,radians[rip]
movsd inputs+8[rip],xmm0
movsd xmm0,values+72[rip]
mulsd xmm0,radians[rip]
movsd inputs+16[rip],xmm0
lea rdi,inputs[rip]
lea rsi,out[rip]
call fk_solve
jmp solved
solve_ik:
lea rdi,inputs[rip]
lea rsi,out[rip]
call ik_solve
solved:
mov valid[rip],eax
mov rdi,spins+0[rip]
mov esi,is_fk[rip]
xor esi,1
call gtk_widget_set_sensitive@PLT
mov rdi,spins+8[rip]
mov esi,is_fk[rip]
xor esi,1
call gtk_widget_set_sensitive@PLT
mov rdi,spins+16[rip]
mov esi,is_fk[rip]
xor esi,1
call gtk_widget_set_sensitive@PLT
mov rdi,spins+56[rip]
mov esi,is_fk[rip]
call gtk_widget_set_sensitive@PLT
mov rdi,spins+64[rip]
mov esi,is_fk[rip]
call gtk_widget_set_sensitive@PLT
mov rdi,spins+72[rip]
mov esi,is_fk[rip]
call gtk_widget_set_sensitive@PLT
xor edi,edi
call g_string_new@PLT
mov reportstr[rip],rax
cmp DWORD PTR valid[rip],0
je invalid_report
cmp DWORD PTR is_fk[rip],0
jne fk_report
mov rdi,reportstr[rip]
lea rsi,str104[rip]
mov eax,0
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str105[rip]
movsd xmm0,inputs[rip]
movsd xmm1,inputs+8[rip]
movsd xmm2,inputs+16[rip]
movsd xmm3,inputs+24[rip]
movsd xmm4,inputs+32[rip]
mov eax,5
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str106[rip]
movsd xmm0,out+0[rip]
movsd xmm1,out+8[rip]
mov eax,2
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str107[rip]
movsd xmm0,out+128[rip]
movsd xmm1,out+136[rip]
mov eax,2
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str108[rip]
movsd xmm0,out+176[rip]
movsd xmm1,out+184[rip]
movsd xmm2,out+16[rip]
mov eax,3
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str109[rip]
movsd xmm0,out+32[rip]
movsd xmm1,out+24[rip]
movsd xmm2,out+144[rip]
mov eax,3
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str110[rip]
movsd xmm0,out+40[rip]
movsd xmm1,out+48[rip]
movsd xmm2,out+56[rip]
movsd xmm3,out+64[rip]
mov eax,4
call g_string_append_printf@PLT
jmp common_report
fk_report:
mov rdi,reportstr[rip]
lea rsi,str111[rip]
mov eax,0
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str112[rip]
movsd xmm0,out+40[rip]
movsd xmm1,out+64[rip]
movsd xmm2,out+32[rip]
mov eax,3
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str113[rip]
movsd xmm0,inputs+24[rip]
movsd xmm1,inputs+32[rip]
movsd xmm2,inputs+40[rip]
movsd xmm3,inputs+48[rip]
mov eax,4
call g_string_append_printf@PLT
common_report:
movsd xmm0,out+PHI[rip]
mulsd xmm0,inputs+BRANCH[rip]
movsd xmm1,out+PITCH[rip]
subsd xmm1,xmm0
movsd intermediate[rip],xmm1
movapd xmm0,xmm1
call cos@PLT
movsd intermediate+8[rip],xmm0
movsd xmm0,intermediate[rip]
call sin@PLT
movsd intermediate+16[rip],xmm0
mov rdi,reportstr[rip]
lea rsi,trig_report[rip]
movsd xmm0,intermediate[rip]
movsd xmm1,intermediate+8[rip]
movsd xmm2,intermediate+16[rip]
movsd xmm3,out+CY[rip]
movsd xmm4,out+SY[rip]
mov eax,5
call g_string_append_printf@PLT
movsd xmm0,out+40[rip]
divsd xmm0,radians[rip]
movsd degrees[rip],xmm0
movsd xmm0,out+64[rip]
divsd xmm0,radians[rip]
movsd degrees+8[rip],xmm0
movsd xmm0,out+32[rip]
divsd xmm0,radians[rip]
movsd degrees+16[rip],xmm0
mov rdi,reportstr[rip]
lea rsi,str114[rip]
movsd xmm0,degrees[rip]
movsd xmm1,degrees+8[rip]
movsd xmm2,degrees+16[rip]
mov eax,3
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str115[rip]
movsd xmm0,inputs+56[rip]
movsd xmm1,out+72[rip]
movsd xmm2,out+80[rip]
movsd xmm3,out+88[rip]
mov eax,4
call g_string_append_printf@PLT
mov rdi,reportstr[rip]
lea rsi,str116[rip]
movsd xmm0,out+96[rip]
movsd xmm1,out+104[rip]
movsd xmm2,out+112[rip]
mov eax,3
call g_string_append_printf@PLT
cmp DWORD PTR is_fk[rip],0
jne flags_report
mov rdi,reportstr[rip]
lea rsi,str117[rip]
movsd xmm0,out+120[rip]
mov eax,1
call g_string_append_printf@PLT
test QWORD PTR out+FLAGS[rip],8
jnz precision_report
test QWORD PTR out+FLAGS[rip],1
jz reached_report
mov rdi,reportstr[rip]
lea rsi,str118[rip]
mov eax,0
call g_string_append_printf@PLT
jmp flags_report
precision_report:
mov rdi,reportstr[rip]
lea rsi,precision_detail[rip]
xor eax,eax
call g_string_append_printf@PLT
jmp flags_report
reached_report:
mov rdi,reportstr[rip]
lea rsi,str119[rip]
mov eax,0
call g_string_append_printf@PLT
flags_report:
test QWORD PTR out+FLAGS[rip],4
jz axis_report
mov rdi,reportstr[rip]
lea rsi,str120[rip]
mov eax,0
call g_string_append_printf@PLT
axis_report:
test QWORD PTR out+FLAGS[rip],2
jz report_ready
mov rdi,reportstr[rip]
lea rsi,str121[rip]
mov eax,0
call g_string_append_printf@PLT
jmp report_ready
invalid_report:
mov rdi,reportstr[rip]
lea rsi,str122[rip]
mov eax,0
call g_string_append_printf@PLT
report_ready:
lea rsi,reached_status[rip]
cmp DWORD PTR valid[rip],0
je status_invalid
cmp DWORD PTR is_fk[rip],0
jne status_fk
test QWORD PTR out+FLAGS[rip],8
jnz status_precision
test QWORD PTR out+FLAGS[rip],1
jnz status_unreachable
test QWORD PTR out+FLAGS[rip],6
jnz status_singular
jmp status_set
status_fk:
lea rsi,fk_status[rip]
test QWORD PTR out+FLAGS[rip],6
jnz status_singular
jmp status_set
status_precision:
lea rsi,precision_status[rip]
jmp status_set
status_invalid:
lea rsi,invalid_status[rip]
jmp status_set
status_unreachable:
lea rsi,unreachable_status[rip]
jmp status_set
status_singular:
lea rsi,singular_status[rip]
status_set:
mov rdi,status[rip]
call gtk_label_set_text@PLT
mov rdi,mathview[rip]
call gtk_text_view_get_buffer@PLT
mov rdi,rax
mov rax,reportstr[rip]
mov rsi,[rax]
mov edx,-1
call gtk_text_buffer_set_text@PLT
mov rdi,reportstr[rip]
mov esi,1
call g_string_free@PLT
movsd xmm0,values+80[rip]
mulsd xmm0,radians[rip]
movsd camera+0[rip],xmm0
movsd xmm0,values+88[rip]
mulsd xmm0,radians[rip]
movsd camera+8[rip],xmm0
mov rdi,canvas[rip]
call gtk_widget_queue_draw@PLT
END
FN line
mov [rbp-8],rsi
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
call cairo_move_to@PLT
mov rdi,[rbp-8]
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
call cairo_line_to@PLT
mov rdi,cr[rip]
call cairo_stroke@PLT
END
FN dot
movsd [rbp-8],xmm0
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
movsd xmm2,[rbp-8]
movsd xmm3,dbl123[rip]
movsd xmm4,dbl124[rip]
call cairo_arc@PLT
mov rdi,cr[rip]
call cairo_fill@PLT
END
FN draw
mov cr[rip],rsi
call gtk_widget_get_allocated_width@PLT
cvtsi2sd xmm0,eax
movsd xmm1,dbl125[rip]
mulsd xmm0,xmm1
movsd camera+24[rip],xmm0
mov rdi,canvas[rip]
call gtk_widget_get_allocated_height@PLT
cvtsi2sd xmm0,eax
movsd xmm1,dbl126[rip]
mulsd xmm0,xmm1
movsd camera+32[rip],xmm0
movsd xmm1,camera+24[rip]
minsd xmm0,xmm1
movsd xmm1,dbl127[rip]
mulsd xmm0,xmm1
movsd xmm1,inputs+L1[rip]
addsd xmm1,inputs+L2[rip]
divsd xmm0,xmm1
mulsd xmm0,values+96[rip]
movsd camera+16[rip],xmm0
mov rdi,cr[rip]
movsd xmm0,dbl128[rip]
movsd xmm1,dbl129[rip]
movsd xmm2,dbl130[rip]
call cairo_set_source_rgb@PLT
mov rdi,cr[rip]
call cairo_paint@PLT
mov rdi,cr[rip]
movsd xmm0,dbl131[rip]
call cairo_set_line_width@PLT
mov rdi,cr[rip]
movsd xmm0,dbl132[rip]
movsd xmm1,dbl133[rip]
movsd xmm2,dbl134[rip]
call cairo_set_source_rgb@PLT
lea rdi,pt135[rip]
lea rsi,pt136[rip]
call line
lea rdi,pt137[rip]
lea rsi,pt138[rip]
call line
lea rdi,pt139[rip]
lea rsi,pt140[rip]
call line
lea rdi,pt141[rip]
lea rsi,pt142[rip]
call line
lea rdi,pt143[rip]
lea rsi,pt144[rip]
call line
lea rdi,pt145[rip]
lea rsi,pt146[rip]
call line
lea rdi,pt147[rip]
lea rsi,pt148[rip]
call line
lea rdi,pt149[rip]
lea rsi,pt150[rip]
call line
lea rdi,pt151[rip]
lea rsi,pt152[rip]
call line
lea rdi,pt153[rip]
lea rsi,pt154[rip]
call line
lea rdi,pt155[rip]
lea rsi,pt156[rip]
call line
lea rdi,pt157[rip]
lea rsi,pt158[rip]
call line
lea rdi,pt159[rip]
lea rsi,pt160[rip]
call line
lea rdi,pt161[rip]
lea rsi,pt162[rip]
call line
lea rdi,pt163[rip]
lea rsi,pt164[rip]
call line
lea rdi,pt165[rip]
lea rsi,pt166[rip]
call line
lea rdi,pt167[rip]
lea rsi,pt168[rip]
call line
lea rdi,pt169[rip]
lea rsi,pt170[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl171[rip]
movsd xmm1,dbl172[rip]
movsd xmm2,dbl173[rip]
call cairo_set_source_rgb@PLT
mov rdi,cr[rip]
movsd xmm0,dbl174[rip]
call cairo_set_line_width@PLT
lea rdi,origin[rip]
lea rsi,axisx[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl175[rip]
movsd xmm1,dbl176[rip]
movsd xmm2,dbl177[rip]
call cairo_set_source_rgb@PLT
mov rdi,cr[rip]
movsd xmm0,dbl178[rip]
call cairo_set_line_width@PLT
lea rdi,origin[rip]
lea rsi,axisy[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl179[rip]
movsd xmm1,dbl180[rip]
movsd xmm2,dbl181[rip]
call cairo_set_source_rgb@PLT
mov rdi,cr[rip]
movsd xmm0,dbl182[rip]
call cairo_set_line_width@PLT
lea rdi,origin[rip]
lea rsi,axisz[rip]
call line
lea rdi,axisx[rip]
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
call cairo_move_to@PLT
mov rdi,cr[rip]
movsd xmm0,dbl183[rip]
call cairo_set_font_size@PLT
mov rdi,cr[rip]
lea rsi,str184[rip]
call cairo_show_text@PLT
lea rdi,axisy[rip]
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
call cairo_move_to@PLT
mov rdi,cr[rip]
movsd xmm0,dbl185[rip]
call cairo_set_font_size@PLT
mov rdi,cr[rip]
lea rsi,str186[rip]
call cairo_show_text@PLT
lea rdi,axisz[rip]
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
call cairo_move_to@PLT
mov rdi,cr[rip]
movsd xmm0,dbl187[rip]
call cairo_set_font_size@PLT
mov rdi,cr[rip]
lea rsi,str188[rip]
call cairo_show_text@PLT
cmp DWORD PTR valid[rip],0
je draw_done
mov rdi,cr[rip]
movsd xmm0,dbl189[rip]
call cairo_set_line_width@PLT
mov rdi,cr[rip]
movsd xmm0,dbl190[rip]
movsd xmm1,dbl191[rip]
movsd xmm2,dbl192[rip]
call cairo_set_source_rgb@PLT
lea rdi,origin[rip]
lea rsi,out+EX[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl193[rip]
movsd xmm1,dbl194[rip]
movsd xmm2,dbl195[rip]
call cairo_set_source_rgb@PLT
lea rdi,out+EX[rip]
lea rsi,out+WX[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl196[rip]
movsd xmm1,dbl197[rip]
movsd xmm2,dbl198[rip]
call cairo_set_source_rgb@PLT
lea rdi,origin[rip]
movsd xmm0,dbl199[rip]
call dot
lea rdi,out+EX[rip]
movsd xmm0,dbl200[rip]
call dot
lea rdi,out+WX[rip]
movsd xmm0,dbl201[rip]
call dot
cmp DWORD PTR is_fk[rip],0
jne draw_done
mov rdi,cr[rip]
movsd xmm0,dbl202[rip]
movsd xmm1,dbl203[rip]
movsd xmm2,dbl204[rip]
call cairo_set_source_rgb@PLT
mov rdi,cr[rip]
movsd xmm0,dbl205[rip]
call cairo_set_line_width@PLT
lea rdi,out+WX[rip]
lea rsi,inputs[rip]
call line
mov rdi,cr[rip]
movsd xmm0,dbl206[rip]
movsd xmm1,dbl207[rip]
movsd xmm2,dbl208[rip]
call cairo_set_source_rgb@PLT
lea rdi,inputs[rip]
lea rsi,camera[rip]
lea rdx,screen[rip]
call project
mov rdi,cr[rip]
movsd xmm0,screen[rip]
movsd xmm1,screen+8[rip]
movsd xmm2,dbl209[rip]
movsd xmm3,dbl210[rip]
movsd xmm4,dbl211[rip]
call cairo_arc@PLT
mov rdi,cr[rip]
call cairo_stroke@PLT
draw_done:
xor eax,eax
END
#ifdef UI_TEST
FN ui_test
 mov DWORD PTR [rbp-4],0
ui_drain:
 xor edi,edi
 call gtk_main_iteration_do@PLT
 inc DWORD PTR [rbp-4]
 cmp DWORD PTR [rbp-4],50
 jl ui_drain

cmp DWORD PTR valid[rip],1
jne ui_failed
mov rdi,win[rip]
call gtk_container_check_resize@PLT
mov rdi,win[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-8],eax
mov rdi,win[rip]
call gtk_widget_get_allocated_height@PLT
mov edx,eax
mov esi,[rbp-8]
xor edi,edi
call cairo_image_surface_create@PLT
mov [rbp-16],rax
mov rdi,rax
call cairo_create@PLT
mov [rbp-24],rax
mov rsi,rax
mov rdi,win[rip]
call gtk_widget_draw@PLT
mov rdi,[rbp-16]
lea rsi,str212[rip]
call cairo_surface_write_to_png@PLT
test eax,eax
jnz ui_failed
mov rdi,[rbp-24]
call cairo_destroy@PLT
mov rdi,[rbp-16]
call cairo_surface_destroy@PLT
mov rdi,spins+0[rip]
movsd xmm0,dbl213[rip]
call gtk_spin_button_set_value@PLT
cmp DWORD PTR valid[rip],1
jne ui_failed
mov rdi,win[rip]
call gtk_container_check_resize@PLT
mov rdi,win[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-8],eax
mov rdi,win[rip]
call gtk_widget_get_allocated_height@PLT
mov edx,eax
mov esi,[rbp-8]
xor edi,edi
call cairo_image_surface_create@PLT
mov [rbp-16],rax
mov rdi,rax
call cairo_create@PLT
mov [rbp-24],rax
mov rsi,rax
mov rdi,win[rip]
call gtk_widget_draw@PLT
test QWORD PTR out+FLAGS[rip],1
jz ui_failed
mov rdi,[rbp-16]
lea rsi,str214[rip]
call cairo_surface_write_to_png@PLT
test eax,eax
jnz ui_failed
mov rdi,[rbp-24]
call cairo_destroy@PLT
mov rdi,[rbp-16]
call cairo_surface_destroy@PLT
mov rdi,mode[rip]
mov esi,1
call gtk_toggle_button_set_active@PLT
mov rdi,spins+56[rip]
movsd xmm0,dbl215[rip]
call gtk_spin_button_set_value@PLT
mov rdi,spins+64[rip]
movsd xmm0,dbl216[rip]
call gtk_spin_button_set_value@PLT
mov rdi,spins+72[rip]
movsd xmm0,dbl217[rip]
call gtk_spin_button_set_value@PLT
cmp DWORD PTR valid[rip],1
jne ui_failed
mov rdi,win[rip]
call gtk_container_check_resize@PLT
mov rdi,win[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-8],eax
mov rdi,win[rip]
call gtk_widget_get_allocated_height@PLT
mov edx,eax
mov esi,[rbp-8]
xor edi,edi
call cairo_image_surface_create@PLT
mov [rbp-16],rax
mov rdi,rax
call cairo_create@PLT
mov [rbp-24],rax
mov rsi,rax
mov rdi,win[rip]
call gtk_widget_draw@PLT
cmp DWORD PTR is_fk[rip],1
jne ui_failed
mov rdi,spins[rip]
call gtk_widget_get_sensitive@PLT
test eax,eax
jnz ui_failed
mov rdi,spins+56[rip]
call gtk_widget_get_sensitive@PLT
test eax,eax
jz ui_failed
movsd xmm0,out+YAW[rip]
movsd xmm1,values+56[rip]
mulsd xmm1,radians[rip]
ucomisd xmm0,xmm1
jne ui_failed
mov rdi,[rbp-16]
lea rsi,str218[rip]
call cairo_surface_write_to_png@PLT
test eax,eax
jnz ui_failed
mov rdi,[rbp-24]
call cairo_destroy@PLT
mov rdi,[rbp-16]
call cairo_surface_destroy@PLT
mov rdi,branch[rip]
mov esi,1
call gtk_toggle_button_set_active@PLT
movsd xmm0,inputs+BRANCH[rip]
ucomisd xmm0,test_negative_one[rip]
jne ui_failed
mov rdi,spins+80[rip]
movsd xmm0,test_camera[rip]
call gtk_spin_button_set_value@PLT
movsd xmm0,test_camera[rip]
mulsd xmm0,radians[rip]
ucomisd xmm0,camera[rip]
jne ui_failed
mov rdi,spins+40[rip]
movsd xmm0,dbl219[rip]
call gtk_spin_button_set_value@PLT
mov rdi,spins+48[rip]
movsd xmm0,dbl220[rip]
call gtk_spin_button_set_value@PLT
cmp DWORD PTR valid[rip],0
jne ui_failed
mov rdi,win[rip]
call gtk_container_check_resize@PLT
mov rdi,win[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-8],eax
mov rdi,win[rip]
call gtk_widget_get_allocated_height@PLT
mov edx,eax
mov esi,[rbp-8]
xor edi,edi
call cairo_image_surface_create@PLT
mov [rbp-16],rax
mov rdi,rax
call cairo_create@PLT
mov [rbp-24],rax
mov rsi,rax
mov rdi,win[rip]
call gtk_widget_draw@PLT
mov rdi,[rbp-16]
lea rsi,str221[rip]
call cairo_surface_write_to_png@PLT
test eax,eax
jnz ui_failed
mov rdi,[rbp-24]
call cairo_destroy@PLT
mov rdi,[rbp-16]
call cairo_surface_destroy@PLT
lea rdi,str222[rip]
call puts@PLT
xor eax,eax
END
ui_failed:
mov eax,1
END
#endif
FN apply_style
call gtk_css_provider_new@PLT
mov [rbp-8],rax
mov rdi,rax
lea rsi,css[rip]
mov rdx,-1
xor ecx,ecx
call gtk_css_provider_load_from_data@PLT
call gdk_screen_get_default@PLT
mov rdi,rax
mov rsi,[rbp-8]
mov edx,600
call gtk_style_context_add_provider_for_screen@PLT
mov rdi,[rbp-8]
call g_object_unref@PLT
END
.section .rodata
radians: .double 0.017453292519943295
origin: .double 0,0,0
axisx: .double 3,0,0
axisy: .double 0,3,0
axisz: .double 0,0,3
str0: .asciz "Bone Lab • Assembly IK + FK"
str1: .asciz "BONE LAB     /     Assembly kinematics"
str2: .asciz "Two rigid bones • Z up • arbitrary length units • unrestricted shoulder • elbow limits • position only"
str3: .asciz "Forward kinematics (angles → bones)"
str4: .asciz "Reverse elbow branch"
str5: .asciz "Target _X"
dbl6: .double 0
dbl7: .double -20
dbl8: .double 20
dbl9: .double 0.05
dbl10: .double 2
str11: .asciz "Target _Y"
dbl12: .double 0
dbl13: .double -20
dbl14: .double 20
dbl15: .double 0.05
dbl16: .double 1
str17: .asciz "Target _Z"
dbl18: .double 0
dbl19: .double -20
dbl20: .double 20
dbl21: .double 0.05
dbl22: .double 1
str23: .asciz "Bone _1"
dbl24: .double 0
dbl25: .double 0.1
dbl26: .double 10
dbl27: .double 0.05
dbl28: .double 2
str29: .asciz "Bone _2"
dbl30: .double 0
dbl31: .double 0.1
dbl32: .double 10
dbl33: .double 0.05
dbl34: .double 1.5
str35: .asciz "Elbow _minimum °"
dbl36: .double 0
dbl37: .double 0
dbl38: .double 180
dbl39: .double 1
dbl40: .double 0
str41: .asciz "Elbow ma_ximum °"
dbl42: .double 0
dbl43: .double 0
dbl44: .double 180
dbl45: .double 1
dbl46: .double 180
str47: .asciz "Shoulder _yaw °"
dbl48: .double 0
dbl49: .double -180
dbl50: .double 180
dbl51: .double 1
dbl52: .double 30
str53: .asciz "Shoulder _pitch °"
dbl54: .double 0
dbl55: .double -180
dbl56: .double 180
dbl57: .double 1
dbl58: .double 55
str59: .asciz "Elbow _flexion °"
dbl60: .double 0
dbl61: .double 0
dbl62: .double 180
dbl63: .double 1
dbl64: .double 70
str65: .asciz "Camera a_zimuth °"
dbl66: .double 0
dbl67: .double -180
dbl68: .double 180
dbl69: .double 2
dbl70: .double -45
str71: .asciz "Camera _elevation °"
dbl72: .double 0
dbl73: .double -85
dbl74: .double 85
dbl75: .double 2
dbl76: .double 25
str77: .asciz "_Zoom ×"
dbl78: .double 0
dbl79: .double 0.3
dbl80: .double 3
dbl81: .double 0.05
dbl82: .double 1
str83: .asciz "IK uses target X/Y/Z. FK uses angles.\nAngles shown in degrees; math uses radians.\nOrbit with camera controls. No animation lag."
str84: .asciz "Blue: upper bone  •  Teal: lower bone  •  Red ring: IK target  •  Gray line: residual\nOrthographic 3D view — use camera azimuth and elevation to inspect depth."
str85: .asciz "draw"
str86: .asciz "toggled"
str87: .asciz "toggled"
str88: .asciz "value-changed"
str89: .asciz "value-changed"
str90: .asciz "value-changed"
str91: .asciz "value-changed"
str92: .asciz "value-changed"
str93: .asciz "value-changed"
str94: .asciz "value-changed"
str95: .asciz "value-changed"
str96: .asciz "value-changed"
str97: .asciz "value-changed"
str98: .asciz "value-changed"
str99: .asciz "value-changed"
str100: .asciz "value-changed"
str101: .asciz "destroy"
dbl102: .double 1
dbl103: .double -1
str104: .asciz "INVERSE KINEMATICS — exact analytic evaluation, no iterations\n"
str105: .asciz "1. Target t = (%.5f, %.5f, %.5f); L1 = %.5f; L2 = %.5f\n"
str106: .asciz "2. rho = sqrt(x²+y²) = %.8f; r = sqrt(rho²+z²) = %.8f\n"
str107: .asciz "3. Reach with limits: [%.8f, %.8f]\n   d(phi) = sqrt(L1²+L2²+2 L1 L2 cos(phi))\n"
str108: .asciz "4. c_raw = (r²-L1²-L2²)/(2 L1 L2) = %.8f / %.8f = %.8f\n"
str109: .asciz "5. phi = constrained stable half-angle solution = %.8f rad\n   d = clamp(r,abs(L1-L2),L1+L2)\n   phi0 = 2 atan2(sqrt((L1+L2-d)(L1+L2+d)), sqrt((d-abs(L1-L2))(d+abs(L1-L2))))\n   phi = clamp(phi0,min,max)\n   cos(phi) = %.8f; sin(phi) = %.8f\n"
str110: .asciz "6. yaw = atan2(y,x) = %.8f; beta = atan2(z,rho) = %.8f\n   delta = branch * atan2(L2 sin(phi),L1+L2 cos(phi)) = %.8f\n   pitch = beta + delta = %.8f rad\n"
str111: .asciz "FORWARD KINEMATICS — direct transform evaluation\n"
str112: .asciz "Inputs: yaw = %.8f; pitch = %.8f; flexion phi = %.8f radians\n"
str113: .asciz "L1 = %.5f; L2 = %.5f; elbow bounds = [%.8f, %.8f] rad\n"
str114: .asciz "Joint angles: yaw %.5f° | shoulder pitch %.5f° | elbow flexion %.5f°\n"
str115: .asciz "7. branch = %.0f; q2 = pitch - branch*phi\n   E = L1 * (cos(pitch)cos(yaw), cos(pitch)sin(yaw), sin(pitch))\n   E = (%.8f, %.8f, %.8f)\n"
str116: .asciz "8. W = E + L2 * (cos(q2)cos(yaw), cos(q2)sin(yaw), sin(q2))\n   W = (%.8f, %.8f, %.8f)\n"
str117: .asciz "9. Residual = sqrt((Wx-x)²+(Wy-y)²+(Wz-z)²) = %.10f units\n"
str118: .asciz "UNREACHABLE under these lengths/limits. Closest radial pose shown.\n"
str119: .asciz "REACHED within 1e-8 units.\n"
str120: .asciz "SINGULAR / NEAR-SINGULAR: high position-to-angle sensitivity; some singular poses are nonunique.\n"
str121: .asciz "AXIS / NEAR-AXIS: yaw is poorly determined by position. IK uses yaw=0 on exact Z axis; at origin beta=0.\n"
str122: .asciz "INVALID INPUT: require 0 <= elbow min <= max <= 180°, positive bones,\nand in FK mode elbow flexion inside the specified limits. Adjust controls.\n"
dbl123: .double 0
dbl124: .double 6.283185307179586
dbl125: .double 0.5
dbl126: .double 0.52
dbl127: .double 1.15
dbl128: .double 0.965
dbl129: .double 0.975
dbl130: .double 0.99
dbl131: .double 1
dbl132: .double 0.82
dbl133: .double 0.85
dbl134: .double 0.9
pt135: .double -4,-4,0
pt136: .double -4,4,0
pt137: .double -4,-4,0
pt138: .double 4,-4,0
pt139: .double -3,-4,0
pt140: .double -3,4,0
pt141: .double -4,-3,0
pt142: .double 4,-3,0
pt143: .double -2,-4,0
pt144: .double -2,4,0
pt145: .double -4,-2,0
pt146: .double 4,-2,0
pt147: .double -1,-4,0
pt148: .double -1,4,0
pt149: .double -4,-1,0
pt150: .double 4,-1,0
pt151: .double 0,-4,0
pt152: .double 0,4,0
pt153: .double -4,0,0
pt154: .double 4,0,0
pt155: .double 1,-4,0
pt156: .double 1,4,0
pt157: .double -4,1,0
pt158: .double 4,1,0
pt159: .double 2,-4,0
pt160: .double 2,4,0
pt161: .double -4,2,0
pt162: .double 4,2,0
pt163: .double 3,-4,0
pt164: .double 3,4,0
pt165: .double -4,3,0
pt166: .double 4,3,0
pt167: .double 4,-4,0
pt168: .double 4,4,0
pt169: .double -4,4,0
pt170: .double 4,4,0
dbl171: .double 0.7
dbl172: .double 0.22
dbl173: .double 0.25
dbl174: .double 2
dbl175: .double 0.15
dbl176: .double 0.5
dbl177: .double 0.3
dbl178: .double 2
dbl179: .double 0.25
dbl180: .double 0.35
dbl181: .double 0.8
dbl182: .double 2
dbl183: .double 14
str184: .asciz "X"
dbl185: .double 14
str186: .asciz "Y"
dbl187: .double 14
str188: .asciz "Z"
dbl189: .double 12
dbl190: .double 0.17
dbl191: .double 0.36
dbl192: .double 0.83
dbl193: .double 0.02
dbl194: .double 0.53
dbl195: .double 0.51
dbl196: .double 0.12
dbl197: .double 0.17
dbl198: .double 0.26
dbl199: .double 7
dbl200: .double 7
dbl201: .double 7
dbl202: .double 0.48
dbl203: .double 0.48
dbl204: .double 0.52
dbl205: .double 1.5
dbl206: .double 0.86
dbl207: .double 0.2
dbl208: .double 0.3
dbl209: .double 10
dbl210: .double 0
dbl211: .double 6.283185307179586
str212: .asciz "evidence/ik.png"
dbl213: .double 15
str214: .asciz "evidence/unreachable.png"
dbl215: .double 70
dbl216: .double -45
dbl217: .double 80
str218: .asciz "evidence/fk.png"
dbl219: .double 100
dbl220: .double 20
str221: .asciz "evidence/invalid.png"
str222: .asciz "PASS: offscreen GTK controls, IK/FK mode, unreachable and invalid states; four PNGs"
.bss
.align 8
win: .skip 8
root: .skip 8
body: .skip 8
controls: .skip 8
grid: .skip 8
temp: .skip 8
mode: .skip 8
branch: .skip 8
right: .skip 8
canvas: .skip 8
mathview: .skip 8
scroll: .skip 8
spins: .skip 104
values: .skip 104
inputs: .skip 64
out: .skip 200
camera: .skip 40
screen: .skip 24
cr: .skip 8
degrees: .skip 24
reportstr: .skip 8
valid: .skip 8
is_fk: .skip 8
.section .note.GNU-stack,"",@progbits

.section .rodata
css: .asciz "* { font-family: sans-serif; font-size: 14px; } window, box, grid, label { background-color: #f5f7fb; color: #192840; } textview text { background-color: #ffffff; color: #192840; } textview { font-family: monospace; font-size: 13px; } spinbutton, spinbutton entry { background: #ffffff; color: #192840; } spinbutton:disabled, spinbutton entry:disabled { color: #677385; background: #e8edf4; }"

.section .rodata
ready_status: .asciz "Ready"
reached_status: .asciz "IK • target reached • exact analytic solve"
fk_status: .asciz "FK • endpoint calculated from joint angles"
invalid_status: .asciz "INVALID • fix elbow limits or FK flexion; pose hidden"
unreachable_status: .asciz "UNREACHABLE • closest allowed pose; residual shown below"
singular_status: .asciz "SINGULAR / NEAR-SINGULAR • inspect the mathematical working"
.bss
.align 8
status: .skip 8
intermediate: .skip 32

.section .rodata
trig_report: .asciz "Forearm pitch q2 = pitch - branch*phi = %.8f rad\ncos(q2) = %.8f; sin(q2) = %.8f; cos(yaw) = %.8f; sin(yaw) = %.8f\n"

.section .rodata
precision_status: .asciz "NUMERICAL PRECISION LIMIT • reachable geometry; residual exceeds tolerance"
precision_detail: .asciz "NUMERICAL PRECISION LIMIT: radial geometry is feasible, but reconstruction residual exceeds 1e-8.\n"

.section .rodata
test_negative_one: .double -1
test_camera: .double 35
