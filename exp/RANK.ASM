datarea segment
grade   dw      88,75,95,63,98,78,87,73,90,60
rank    dw      10 dup(?)
rank1   db      30 dup(20h),13,10,'$'
datarea ends

prognam segment
main    proc    far
        assume  cs:prognam,ds:datarea
start:
        push    ds
        sub     ax,ax
        push    ax
        mov     ax,datarea
        mov     ds,ax
        mov     di,10
        mov     bx,0

lop:
        mov     ax,grade[bx]
        mov     dx,0
        mov     cx,10
        lea     si,grade
next:
        cmp     ax,[si]
        jg      no_count
        inc     dx
no_count:
        add     si,2
        loop    next
        mov     rank[bx],dx
        add     bx,2
        dec     di
        jne     lop
do_fill:
        mov     cx,10
        mov     si,0    
loop_fill:
        mov     bx,rank[si]
        sub     bx,1
        mov     ax,bx
        shl     bx,1
        add     bx,ax
        mov     dx,grade[si]
        mov     rank1[bx],dl
        add     si,2
        loop    loop_fill
to_str:
        mov     cx,10
        mov     si,0
        mov     dh,48
        mov     bh,10
        mov     di,0
loop_s:
        mov     al,rank1[si]
        cbw
        div     bh
        add     ah,dh
        add     al,dh    
        mov     rank1[si],al
        add     si,1
        mov     rank1[si],ah
        add     si,2
        loop    loop_s
print:
        lea     dx,rank1
        mov     ah,09
        int     21h
exit:
        ret
main    endp
prognam ends
        end     start
