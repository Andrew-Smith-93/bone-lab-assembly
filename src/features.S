#include "layout.inc"
.text
# Internal app integration uses hidden symbols; no new public user data or I/O.
.hidden spins, values, mode, branch, is_fk, valid, canvas, scroll, win
FN features_new
mov [rbp-8],rdi
mov [rbp-16],rsi
xor edi,edi
xor esi,esi
call gtk_scrolled_window_new@PLT
mov f_scroll[rip],rax
mov edi,1
mov esi,10
call gtk_box_new@PLT
mov f_tools[rip],rax
mov rdi,rax
mov esi,14
call gtk_container_set_border_width@PLT
mov rdi,f_scroll[rip]
mov rsi,f_tools[rip]
call gtk_container_add@PLT

lea rdi,tools_heading[rip]
mov rsi,f_tools[rip]
call f_label
mov rdi,f_tools[rip]
mov esi,0
call f_box
mov f_row[rip],rax
lea rdi,undo_text[rip]
mov rsi,f_row[rip]
lea rdx,f_undo[rip]
mov ecx,0
call f_button
mov f_undo_button[rip],rax
lea rdi,redo_text[rip]
mov rsi,f_row[rip]
lea rdx,f_redo[rip]
mov ecx,0
call f_button
mov f_redo_button[rip],rax
lea rdi,history_help[rip]
mov rsi,f_tools[rip]
call f_label
lea rdi,preset_heading[rip]
mov rsi,f_tools[rip]
call f_label
mov rdi,f_tools[rip]
mov esi,0
call f_box
mov f_row[rip],rax
call gtk_combo_box_text_new@PLT
mov f_examples[rip],rax
mov rdi,f_examples[rip]
lea rsi,example_name0[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name1[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name2[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name3[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name4[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name5[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
lea rsi,example_name6[rip]
call gtk_combo_box_text_append_text@PLT
mov rdi,f_examples[rip]
xor esi,esi
call gtk_combo_box_set_active@PLT
mov rdi,f_examples[rip]
mov rsi,f_row[rip]
call f_pack
lea rdi,load_text[rip]
mov rsi,f_row[rip]
lea rdx,f_load[rip]
mov ecx,0
call f_button
lea rdi,example_help[rip]
mov rsi,f_tools[rip]
call f_label
mov f_example_hint[rip],rax
lea rdi,atlas_heading[rip]
mov rsi,f_tools[rip]
call f_label
lea rdi,atlas_help[rip]
mov rsi,f_tools[rip]
call f_label
call gtk_grid_new@PLT
mov f_grid[rip],rax
mov rdi,rax
mov esi,10
call gtk_grid_set_column_spacing@PLT
mov rdi,f_grid[rip]
mov esi,6
call gtk_grid_set_row_spacing@PLT
mov rdi,f_grid[rip]
mov rsi,f_tools[rip]
call f_pack
lea rdi,bound_label0[rip]
call gtk_label_new@PLT
mov f_temp[rip],rax
mov rdi,rax
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,f_grid[rip]
mov rsi,f_temp[rip]
mov edx,0
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,f_min[rip]
movsd xmm1,f_max[rip]
movsd xmm2,f_step[rip]
call gtk_spin_button_new_with_range@PLT
mov f_bounds+0[rip],rax
mov rdi,rax
mov esi,1
call gtk_spin_button_set_digits@PLT
mov rdi,f_bounds+0[rip]
movsd xmm0,f_min[rip]
call gtk_spin_button_set_value@PLT
mov rdi,f_temp[rip]
mov rsi,f_bounds+0[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,f_grid[rip]
mov rsi,f_bounds+0[rip]
mov edx,1
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
mov rdi,f_bounds+0[rip]
lea rsi,f_value_signal[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
lea rdi,bound_label1[rip]
call gtk_label_new@PLT
mov f_temp[rip],rax
mov rdi,rax
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,f_grid[rip]
mov rsi,f_temp[rip]
mov edx,2
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,f_min[rip]
movsd xmm1,f_max[rip]
movsd xmm2,f_step[rip]
call gtk_spin_button_new_with_range@PLT
mov f_bounds+8[rip],rax
mov rdi,rax
mov esi,1
call gtk_spin_button_set_digits@PLT
mov rdi,f_bounds+8[rip]
movsd xmm0,f_max[rip]
call gtk_spin_button_set_value@PLT
mov rdi,f_temp[rip]
mov rsi,f_bounds+8[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,f_grid[rip]
mov rsi,f_bounds+8[rip]
mov edx,3
mov ecx,0
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
mov rdi,f_bounds+8[rip]
lea rsi,f_value_signal[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
lea rdi,bound_label2[rip]
call gtk_label_new@PLT
mov f_temp[rip],rax
mov rdi,rax
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,f_grid[rip]
mov rsi,f_temp[rip]
mov edx,0
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,f_min[rip]
movsd xmm1,f_max[rip]
movsd xmm2,f_step[rip]
call gtk_spin_button_new_with_range@PLT
mov f_bounds+16[rip],rax
mov rdi,rax
mov esi,1
call gtk_spin_button_set_digits@PLT
mov rdi,f_bounds+16[rip]
movsd xmm0,f_min[rip]
call gtk_spin_button_set_value@PLT
mov rdi,f_temp[rip]
mov rsi,f_bounds+16[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,f_grid[rip]
mov rsi,f_bounds+16[rip]
mov edx,1
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
mov rdi,f_bounds+16[rip]
lea rsi,f_value_signal[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
lea rdi,bound_label3[rip]
call gtk_label_new@PLT
mov f_temp[rip],rax
mov rdi,rax
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,f_grid[rip]
mov rsi,f_temp[rip]
mov edx,2
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
movsd xmm0,f_min[rip]
movsd xmm1,f_max[rip]
movsd xmm2,f_step[rip]
call gtk_spin_button_new_with_range@PLT
mov f_bounds+24[rip],rax
mov rdi,rax
mov esi,1
call gtk_spin_button_set_digits@PLT
mov rdi,f_bounds+24[rip]
movsd xmm0,f_max[rip]
call gtk_spin_button_set_value@PLT
mov rdi,f_temp[rip]
mov rsi,f_bounds+24[rip]
call gtk_label_set_mnemonic_widget@PLT
mov rdi,f_grid[rip]
mov rsi,f_bounds+24[rip]
mov edx,3
mov ecx,1
mov r8d,1
mov r9d,1
call gtk_grid_attach@PLT
mov rdi,f_bounds+24[rip]
lea rsi,f_value_signal[rip]
lea rdx,update[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,f_tools[rip]
mov esi,0
call f_box
mov f_row[rip],rax
lea rdi,find_text[rip]
mov rsi,f_row[rip]
lea rdx,f_find[rip]
mov ecx,0
call f_button
mov f_find_button[rip],rax
lea rdi,apply_text[rip]
mov rsi,f_row[rip]
lea rdx,f_apply[rip]
mov ecx,0
call f_button
mov f_apply_button[rip],rax
mov rdi,rax
xor esi,esi
call gtk_widget_set_sensitive@PLT
lea rdi,atlas_idle[rip]
mov rsi,f_tools[rip]
call f_label
mov f_atlas_status[rip],rax
lea rdi,atlas_accuracy[rip]
mov rsi,f_tools[rip]
call f_label
lea rdi,pose_tools_tab[rip]
call gtk_label_new@PLT
mov rdx,rax
mov rdi,[rbp-8]
mov rsi,f_scroll[rip]
call gtk_notebook_append_page@PLT
# Extend the existing camera expander without enlarging the default compact view.
mov edi,1
mov esi,6
call gtk_box_new@PLT
mov f_camera_tools[rip],rax
mov rsi,rax
mov rdi,[rbp-16]
xor edx,edx
mov ecx,3
mov r8d,2
mov r9d,1
call gtk_grid_attach@PLT
mov rdi,f_camera_tools[rip]
mov esi,0
call f_box
mov f_row[rip],rax
lea rdi,view_front[rip]
mov rsi,f_row[rip]
lea rdx,f_view[rip]
mov ecx,0
call f_button
lea rdi,view_side[rip]
mov rsi,f_row[rip]
lea rdx,f_view[rip]
mov ecx,1
call f_button
lea rdi,view_above[rip]
mov rsi,f_row[rip]
lea rdx,f_view[rip]
mov ecx,2
call f_button
lea rdi,overlay_text0[rip]
call gtk_check_button_new_with_label@PLT
mov f_temp[rip],rax
mov rdi,rax
mov esi,1
call gtk_toggle_button_set_active@PLT
mov rdi,f_temp[rip]
mov rsi,f_camera_tools[rip]
call f_pack
mov rdi,f_temp[rip]
lea rsi,f_toggle_signal[rip]
lea rdx,f_overlay[rip]
lea rcx,scene_flags+0[rip]
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
lea rdi,overlay_text1[rip]
call gtk_check_button_new_with_label@PLT
mov f_temp[rip],rax
mov rdi,rax
mov esi,1
call gtk_toggle_button_set_active@PLT
mov rdi,f_temp[rip]
mov rsi,f_camera_tools[rip]
call f_pack
mov rdi,f_temp[rip]
lea rsi,f_toggle_signal[rip]
lea rdx,f_overlay[rip]
lea rcx,scene_flags+4[rip]
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
lea rdi,overlay_text2[rip]
call gtk_check_button_new_with_label@PLT
mov f_temp[rip],rax
mov rdi,rax
mov esi,1
call gtk_toggle_button_set_active@PLT
mov rdi,f_temp[rip]
mov rsi,f_camera_tools[rip]
call f_pack
mov rdi,f_temp[rip]
lea rsi,f_toggle_signal[rip]
lea rdx,f_overlay[rip]
lea rcx,scene_flags+8[rip]
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rdi,canvas[rip]
mov esi,10485760
call gtk_widget_add_events@PLT
mov rdi,canvas[rip]
lea rsi,f_scroll_signal[rip]
lea rdx,f_zoom[rip]
xor ecx,ecx
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
END
# f_pack(widget, parent): consistent nonexpanding child.
FN f_pack
mov rax,rdi
mov rdi,rsi
mov rsi,rax
xor edx,edx
xor ecx,ecx
xor r8d,r8d
call gtk_box_pack_start@PLT
END
FN f_box
mov [rbp-8],rdi
mov edi,esi
mov esi,6
call gtk_box_new@PLT
mov [rbp-16],rax
mov rdi,rax
mov rsi,[rbp-8]
call f_pack
mov rax,[rbp-16]
END
FN f_label
mov [rbp-8],rsi
call gtk_label_new@PLT
mov [rbp-16],rax
mov rdi,rax
pxor xmm0,xmm0
call gtk_label_set_xalign@PLT
mov rdi,[rbp-16]
mov esi,1
call gtk_label_set_line_wrap@PLT
mov rdi,[rbp-16]
mov esi,72
call gtk_label_set_max_width_chars@PLT
mov rdi,[rbp-16]
mov rsi,[rbp-8]
call f_pack
mov rax,[rbp-16]
END
FN f_button
mov [rbp-8],rsi
mov [rbp-16],rdx
mov [rbp-24],rcx
call gtk_button_new_with_label@PLT
mov [rbp-32],rax
mov rdi,rax
mov rsi,[rbp-8]
call f_pack
mov rdi,[rbp-32]
lea rsi,f_click_signal[rip]
mov rdx,[rbp-16]
mov rcx,[rbp-24]
xor r8d,r8d
xor r9d,r9d
call g_signal_connect_data@PLT
mov rax,[rbp-32]
END
# A snapshot is ten pose spin doubles, mode/branch uint64, then four bounds.
FN f_snapshot
mov [rbp-8],rdi
lea rsi,values[rip]
mov ecx,10
rep movsq
mov eax,is_fk[rip]
mov [rdi],rax
mov rdi,branch[rip]
call gtk_toggle_button_get_active@PLT
mov rdi,[rbp-8]
mov [rdi+88],rax
mov DWORD PTR [rbp-16],0
.snapshot_bounds:
mov eax,[rbp-16]
lea rdx,f_bounds[rip]
mov rdi,[rdx+rax*8]
call gtk_spin_button_get_value@PLT
mov eax,[rbp-16]
mov rdi,[rbp-8]
movsd [rdi+rax*8+96],xmm0
inc DWORD PTR [rbp-16]
cmp DWORD PTR [rbp-16],4
jl .snapshot_bounds
END
FN features_update
lea rdi,f_current[rip]
call f_snapshot
cmp DWORD PTR f_history_ready[rip],0
jne .history_existing
lea rdi,f_current[rip]
call history_reset
mov DWORD PTR f_history_ready[rip],1
jmp .history_buttons
.history_existing:
cmp DWORD PTR f_restoring[rip],0
jne .history_buttons
lea rdi,f_current[rip]
call history_record
.history_buttons:
call history_can_undo
mov esi,eax
mov rdi,f_undo_button[rip]
call gtk_widget_set_sensitive@PLT
call history_can_redo
mov esi,eax
mov rdi,f_redo_button[rip]
call gtk_widget_set_sensitive@PLT
mov esi,is_fk[rip]
xor esi,1
and esi,valid[rip]
mov rdi,f_find_button[rip]
call gtk_widget_set_sensitive@PLT
cmp DWORD PTR f_found[rip],1
jne .feature_done
lea rdi,f_current[rip]
lea rsi,f_searched[rip]
mov edx,128
call memcmp@PLT
test eax,eax
jz .feature_done
mov DWORD PTR f_found[rip],0
mov rdi,f_apply_button[rip]
xor esi,esi
call gtk_widget_set_sensitive@PLT
mov rdi,f_atlas_status[rip]
lea rsi,f_changed[rip]
call gtk_label_set_text@PLT
.feature_done:
END
FN f_restore
mov [rbp-8],rdi
mov DWORD PTR features_busy[rip],1
mov DWORD PTR [rbp-16],0
.restore_spins:
mov eax,[rbp-16]
lea rdx,spins[rip]
mov rdi,[rdx+rax*8]
mov rdx,[rbp-8]
movsd xmm0,[rdx+rax*8]
call gtk_spin_button_set_value@PLT
inc DWORD PTR [rbp-16]
cmp DWORD PTR [rbp-16],10
jl .restore_spins
mov rdi,mode[rip]
mov rax,[rbp-8]
mov esi,[rax+80]
call gtk_combo_box_set_active@PLT
mov rdi,branch[rip]
mov rax,[rbp-8]
mov esi,[rax+88]
call gtk_toggle_button_set_active@PLT
mov DWORD PTR [rbp-16],0
.restore_bounds:
mov eax,[rbp-16]
lea rdx,f_bounds[rip]
mov rdi,[rdx+rax*8]
mov rdx,[rbp-8]
movsd xmm0,[rdx+rax*8+96]
call gtk_spin_button_set_value@PLT
inc DWORD PTR [rbp-16]
cmp DWORD PTR [rbp-16],4
jl .restore_bounds
mov DWORD PTR features_busy[rip],0
call update
END
FN f_undo
lea rdi,f_restore_buffer[rip]
call history_undo
test eax,eax
jz .undo_done
mov DWORD PTR f_restoring[rip],1
lea rdi,f_restore_buffer[rip]
call f_restore
mov DWORD PTR f_restoring[rip],0
.undo_done:
END
FN f_redo
lea rdi,f_restore_buffer[rip]
call history_redo
test eax,eax
jz .redo_done
mov DWORD PTR f_restoring[rip],1
lea rdi,f_restore_buffer[rip]
call f_restore
mov DWORD PTR f_restoring[rip],0
.redo_done:
END
FN f_load
mov rdi,f_examples[rip]
call gtk_combo_box_get_active@PLT
cmp eax,6
ja .load_done
mov [rbp-8],rax
shl rax,7
lea rdi,f_presets[rip]
add rdi,rax
call f_restore
mov rax,[rbp-8]
lea rdx,f_example_notes[rip]
movsxd rax,DWORD PTR [rdx+rax*4]
add rax,rdx
mov rdi,f_example_hint[rip]
mov rsi,rax
call gtk_label_set_text@PLT
.load_done:
END
FN f_find
# Current controls remain untouched until the separate Apply button is pressed.
cmp DWORD PTR is_fk[rip],0
jne .find_done
lea rsi,values[rip]
lea rdi,f_query[rip]
mov ecx,7
rep movsq
mov rdi,branch[rip]
call gtk_toggle_button_get_active@PLT
movsd xmm0,f_one[rip]
test eax,eax
jz .find_branch
movsd xmm0,f_negative_one[rip]
.find_branch:
movsd f_query+56[rip],xmm0
lea rdi,f_current[rip]
call f_snapshot
lea rdi,f_query+64[rip]
lea rsi,f_current+96[rip]
mov ecx,4
rep movsq
lea rdi,f_query[rip]
lea rsi,f_result[rip]
call atlas_search
cmp eax,1
je .find_success
mov DWORD PTR f_found[rip],0
mov rdi,f_apply_button[rip]
xor esi,esi
mov [rbp-8],eax
call gtk_widget_set_sensitive@PLT
mov rdi,f_atlas_status[rip]
lea rsi,f_no_sample[rip]
cmp DWORD PTR [rbp-8],-1
jne .find_error_set
lea rsi,f_invalid_bounds[rip]
.find_error_set:
call gtk_label_set_text@PLT
jmp .find_done
.find_success:
mov DWORD PTR f_found[rip],1
lea rdi,f_searched[rip]
lea rsi,f_current[rip]
mov ecx,16
rep movsq
mov rdi,f_apply_button[rip]
mov esi,1
call gtk_widget_set_sensitive@PLT
lea rdi,f_result_format[rip]
movsd xmm0,f_result[rip]
movsd xmm1,f_result+8[rip]
movsd xmm2,f_result+16[rip]
movsd xmm3,f_result+72[rip]
mov rsi,f_result+80[rip]
mov eax,4
call g_strdup_printf@PLT
mov [rbp-16],rax
mov rdi,f_atlas_status[rip]
mov rsi,rax
call gtk_label_set_text@PLT
mov rdi,[rbp-16]
call g_free@PLT
.find_done:
END
FN f_apply
cmp DWORD PTR f_found[rip],1
jne .apply_done
lea rdi,f_restore_buffer[rip]
lea rsi,f_current[rip]
mov ecx,16
rep movsq
movsd xmm0,f_result[rip]
movsd f_restore_buffer+56[rip],xmm0
movsd xmm0,f_result+8[rip]
movsd f_restore_buffer+64[rip],xmm0
movsd xmm0,f_result+16[rip]
movsd f_restore_buffer+72[rip],xmm0
mov QWORD PTR f_restore_buffer+80[rip],1
lea rdi,f_restore_buffer[rip]
call f_restore
.apply_done:
END
FN f_overlay
mov [rbp-8],rsi
call gtk_toggle_button_get_active@PLT
mov rdx,[rbp-8]
mov [rdx],eax
mov rdi,canvas[rip]
call gtk_widget_queue_draw@PLT
END
FN f_view
cmp esi,2
ja .view_done
imul eax,esi,16
lea rdx,f_views[rip]
add rdx,rax
mov [rbp-8],rdx
movsd xmm0,[rdx]
mov rdi,spins+80[rip]
call gtk_spin_button_set_value@PLT
mov rdx,[rbp-8]
movsd xmm0,[rdx+8]
mov rdi,spins+88[rip]
call gtk_spin_button_set_value@PLT
.view_done:
END
FN f_zoom
mov [rbp-8],rsi
mov rdi,rsi
lea rsi,[rbp-16]
call gdk_event_get_scroll_direction@PLT
test eax,eax
jz .zoom_smooth
cmp DWORD PTR [rbp-16],0
je .zoom_in
cmp DWORD PTR [rbp-16],1
je .zoom_out
cmp DWORD PTR [rbp-16],4
jne .zoom_unused
.zoom_smooth:
mov rdi,[rbp-8]
lea rsi,[rbp-24]
lea rdx,[rbp-32]
call gdk_event_get_scroll_deltas@PLT
test eax,eax
jz .zoom_unused
movsd xmm0,[rbp-32]
pxor xmm1,xmm1
ucomisd xmm0,xmm1
jp .zoom_unused
je .zoom_unused
subsd xmm1,xmm0
maxsd xmm1,f_scroll_min[rip]
minsd xmm1,f_scroll_max[rip]
movsd xmm0,f_zoom_factor[rip]
call pow@PLT
mulsd xmm0,values+96[rip]
jmp .zoom_set
.zoom_in:
movsd xmm0,values+96[rip]
mulsd xmm0,f_zoom_factor[rip]
jmp .zoom_set
.zoom_out:
movsd xmm0,values+96[rip]
divsd xmm0,f_zoom_factor[rip]
.zoom_set:
mov rdi,spins+96[rip]
call gtk_spin_button_set_value@PLT
mov eax,1
END
.zoom_unused:
xor eax,eax
END

.section .rodata
tools_heading: .asciz "Pose tools • all work stays on this computer"
undo_text: .asciz "Undo pose"
redo_text: .asciz "Redo pose"
history_help: .asciz "64-snapshot pose history includes targets, angles, lengths, joint limits and bend direction. Camera movement does not change pose history."
preset_heading: .asciz "GUIDED EXAMPLES"
example_name0: .asciz "Reachable target"
example_name1: .asciz "Out-of-reach target"
example_name2: .asciz "Straight singularity"
example_name3: .asciz "Folded singularity"
example_name4: .asciz "Opposite elbow bend"
example_name5: .asciz "Forward joint angles"
example_name6: .asciz "Limited shoulder search"
load_text: .asciz "Load example"
example_help: .asciz "Choose an example, then Load. It replaces pose inputs only; Undo restores your previous work. Singular examples explain cases with nonunique angles."
atlas_heading: .asciz "SHOULDER-CONSTRAINED POSE SEARCH"
atlas_help: .asciz "Search 138,043 sampled poses with the current IK target, bone lengths, elbow limits and bend direction. Shoulder bounds below apply only to this sampled search, not the exact analytic IK solver."
bound_label0: .asciz "Yaw minimum °"
bound_label1: .asciz "Yaw maximum °"
bound_label2: .asciz "Pitch minimum °"
bound_label3: .asciz "Pitch maximum °"
find_text: .asciz "Find sampled pose"
apply_text: .asciz "Use sampled pose in FK"
atlas_idle: .asciz "Choose IK mode, set the target and bounds, then Find sampled pose."
atlas_accuracy: .asciz "Grid resolution: yaw 5° • pitch 6° • flexion 6°. The nearest sampled pose is approximate, not a continuous constrained-IK proof. Narrow bounds can contain no samples. Applying a result switches to FK; Undo returns to your target."
pose_tools_tab: .asciz "Pose tools"
view_front: .asciz "Front"
view_side: .asciz "Side"
view_above: .asciz "Above"
overlay_text0: .asciz "Show grid"
overlay_text1: .asciz "Show axes"
overlay_text2: .asciz "Show IK target"
f_click_signal: .asciz "clicked"
f_value_signal: .asciz "value-changed"
f_toggle_signal: .asciz "toggled"
f_scroll_signal: .asciz "scroll-event"
f_changed: .asciz "Pose or bounds changed. Find again to update the sampled result."
f_no_sample: .asciz "No grid samples lie inside these limits. Widen the bounds; this does not prove the continuous pose is unreachable."
f_invalid_bounds: .asciz "Invalid bounds. Minimum must be ≤ maximum; shoulder limits must stay within −180° to 180°."
f_result_format: .asciz "Nearest sampled pose: yaw %.1f° • pitch %.1f° • flexion %.1f°\nTarget error: %.6g units • %lu eligible samples\nReview this approximate result, then use it in FK if useful."
f_note0: .asciz "The target is inside the reachable shell. Compare the exact IK result with the sampled search."
f_note1: .asciz "The requested endpoint is outside the maximum reach. The exact solver shows the closest radial pose and residual."
f_note2: .asciz "A straight chain is singular: the endpoint is at maximum reach and angles become sensitive to small changes."
f_note3: .asciz "Equal-length bones fold onto the origin. The endpoint has nonunique shoulder orientation; the solver selects a deterministic pose."
f_note4: .asciz "The alternate elbow branch reaches the same target with a different bend. Compare its joint angles and reconstruction."
f_note5: .asciz "Forward kinematics calculates the endpoint directly from the three joint angles. There is no IK target residual."
f_note6: .asciz "The exact IK view is unrestricted at the shoulder. Find sampled pose below to explore yaw ±30° and pitch 0–45°, then compare its target error."
f_min: .double -180
f_max: .double 180
f_step: .double 1
f_one: .double 1
f_negative_one: .double -1
f_zoom_factor: .double 1.1
f_scroll_min: .double -20
f_scroll_max: .double 20
f_views: .double -90,0, 0,0, -45,85
f_example_notes:
.long f_note0-f_example_notes
.long f_note1-f_example_notes
.long f_note2-f_example_notes
.long f_note3-f_example_notes
.long f_note4-f_example_notes
.long f_note5-f_example_notes
.long f_note6-f_example_notes
.align 8
f_presets:
.double 2,1,1,2,1.5,0,180,30,55,70
.quad 0,0
.double -180,180,-180,180
.double 15,0,0,2,1.5,0,180,30,55,70
.quad 0,0
.double -180,180,-180,180
.double 3.5,0,0,2,1.5,0,180,30,55,70
.quad 0,0
.double -180,180,-180,180
.double 0,0,0,2,2,0,180,30,55,70
.quad 0,0
.double -180,180,-180,180
.double 2,1,1,2,1.5,0,180,30,55,70
.quad 0,1
.double -180,180,-180,180
.double 2,1,1,2,1.5,0,180,45,25,100
.quad 1,0
.double -180,180,-180,180
.double 2,1,1,2,1.5,20,120,30,55,70
.quad 0,0
.double -30,30,0,45
.data
.global scene_flags
.hidden scene_flags
scene_flags: .long 1,1,1
.bss
.align 8
.global features_busy
.hidden features_busy
features_busy: .skip 8
f_scroll: .skip 8
f_tools: .skip 8
f_row: .skip 8
f_grid: .skip 8
f_temp: .skip 8
f_examples: .skip 8
f_undo_button: .skip 8
f_redo_button: .skip 8
f_find_button: .skip 8
f_apply_button: .skip 8
f_example_hint: .skip 8
f_atlas_status: .skip 8
f_camera_tools: .skip 8
f_history_ready: .skip 8
f_restoring: .skip 8
f_found: .skip 8
f_bounds: .skip 32
f_current: .skip 128
f_searched: .skip 128
f_restore_buffer: .skip 128
f_query: .skip 96
f_result: .skip 88
.section .note.GNU-stack,"",@progbits
#ifdef UI_TEST
.text
# Test-only capture of the full tool page, with synthetic fixture values.
FN features_capture
mov [rbp-8],rdi
mov rdi,f_tools[rip]
call gtk_widget_get_allocated_width@PLT
mov [rbp-12],eax
mov rdi,f_tools[rip]
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
mov rdi,f_tools[rip]
call gtk_widget_draw@PLT
mov rdi,[rbp-24]
mov rsi,[rbp-8]
call cairo_surface_write_to_png@PLT
mov [rbp-36],eax
mov rdi,[rbp-32]
call cairo_destroy@PLT
mov rdi,[rbp-24]
call cairo_surface_destroy@PLT
mov eax,[rbp-36]
END
#endif
