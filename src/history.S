#include "layout.inc"
# Fixed-capacity, process-local opaque pose history, System V AMD64 ABI.
# Single GTK main-thread use only; no allocation, persistence, or locking.
# reset/record take a valid nonnull readable 128-byte caller buffer.
# undo/redo take a valid nonnull writable 128-byte caller buffer. Buffers
# must be separate from this module's private storage; no alignment needed.
# reset establishes the sole current snapshot. record before reset also
# establishes the first snapshot. record compares all bytes to the current
# snapshot: duplicates preserve redo; differing snapshots truncate redo.
# At capacity (64 snapshots), recording evicts only the oldest snapshot.
# undo/redo return 1 on success, 0 without writing output when unavailable.
# can_undo/can_redo return exactly 0 or 1. reset/record have void returns.
.equ HISTORY_BYTES,128
.equ HISTORY_CAPACITY,64
.bss
.balign 16
history_snapshots:
 .zero HISTORY_BYTES*HISTORY_CAPACITY
history_count:
 .zero 8
history_cursor:
 .zero 8
.text
FN history_reset
 mov rsi,rdi
 lea rdi,[rip+history_snapshots]
 mov ecx,HISTORY_BYTES/8
 cld
 rep movsq
 mov qword ptr [rip+history_count],1
 mov qword ptr [rip+history_cursor],0
 END
.size history_reset,.-history_reset

FN history_record
 mov r8,rdi
 mov rax,[rip+history_count]
 test rax,rax
 jnz .Lrecord_compare
 mov rsi,r8
 lea rdi,[rip+history_snapshots]
 mov ecx,HISTORY_BYTES/8
 cld
 rep movsq
 mov qword ptr [rip+history_count],1
 mov qword ptr [rip+history_cursor],0
 jmp .Lrecord_done
.Lrecord_compare:
 mov rax,[rip+history_cursor]
 shl rax,7
 lea rdi,[rip+history_snapshots]
 add rdi,rax
 mov rsi,r8
 mov ecx,HISTORY_BYTES/8
 cld
 repe cmpsq
 je .Lrecord_done
 mov rax,[rip+history_cursor]
 inc rax
 cmp rax,HISTORY_CAPACITY
 jb .Lrecord_append
 # Current is slot 63. Forward copy safely shifts slots 1..63 down.
 lea rdi,[rip+history_snapshots]
 lea rsi,[rdi+HISTORY_BYTES]
 mov ecx,(HISTORY_CAPACITY-1)*HISTORY_BYTES/8
 rep movsq
 mov eax,HISTORY_CAPACITY-1
.Lrecord_append:
 mov [rip+history_cursor],rax
 lea rcx,[rax+1]
 mov [rip+history_count],rcx
 shl rax,7
 lea rdi,[rip+history_snapshots]
 add rdi,rax
 mov rsi,r8
 mov ecx,HISTORY_BYTES/8
 rep movsq
.Lrecord_done:
 END
.size history_record,.-history_record

FN history_undo
 xor eax,eax
 cmp qword ptr [rip+history_count],0
 je .Lundo_done
 mov rdx,[rip+history_cursor]
 test rdx,rdx
 jz .Lundo_done
 dec rdx
 mov [rip+history_cursor],rdx
 shl rdx,7
 lea rsi,[rip+history_snapshots]
 add rsi,rdx
 mov ecx,HISTORY_BYTES/8
 cld
 rep movsq
 mov eax,1
.Lundo_done:
 END
.size history_undo,.-history_undo

FN history_redo
 xor eax,eax
 mov rdx,[rip+history_cursor]
 inc rdx
 cmp rdx,[rip+history_count]
 jae .Lredo_done
 mov [rip+history_cursor],rdx
 shl rdx,7
 lea rsi,[rip+history_snapshots]
 add rsi,rdx
 mov ecx,HISTORY_BYTES/8
 cld
 rep movsq
 mov eax,1
.Lredo_done:
 END
.size history_redo,.-history_redo

FN history_can_undo
 xor eax,eax
 cmp qword ptr [rip+history_count],0
 je .Lcan_undo_done
 cmp qword ptr [rip+history_cursor],0
 setne al
.Lcan_undo_done:
 END
.size history_can_undo,.-history_can_undo

FN history_can_redo
 xor eax,eax
 mov rdx,[rip+history_cursor]
 inc rdx
 cmp rdx,[rip+history_count]
 setb al
 END
.size history_can_redo,.-history_can_redo
.section .note.GNU-stack,"",@progbits
