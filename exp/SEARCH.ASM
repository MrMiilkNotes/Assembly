;-------------------------------------------------
;  test program
;                               -- MrMiilk
;                       1024109095@qq.com
;-------------------------------------------------

;               >>> DATA <<<
;*************************************************
datarea segment
        Mess0   db      13,10,'$'
        Mess1   db      'Enter Keyword:','$'
        Mess2   db      'Enter Sentence:','$'
        Mess3   db      'Match at location:','$'
        NoMatch db      'No Match.',13,10,'$'
        Match   db      'Match.',13,10,'$'
        stockM  label   byte
                max1    db      40
                len1    db      ?
                strM    db      40 dup(?)
        stockS  label   byte
                max2    db      10
                len2    db      ?
                strS    db      10 dup(?)
datarea ends
;*************************************************

;               >>> CODE <<<
;*************************************************
prognam segment para 'code'
        assume  cs:prognam,ds:datarea,es:datarea
main    proc    far
        push    ds
        sub     ax,ax
        push    ax
        mov     ax,datarea
        mov     ds,ax
        mov     es,ax
; MAIN PART OF PROGRAM GOES HERE
start:
        ; input
        lea     dx,Mess1
        call    output
        lea     dx,stockS
        call    input
        cmp     len2,0
        je      exit    ; exit if no input
        call    nxLn
newStr:
        lea     dx,Mess2
        call    output
        lea     dx,stockM
        call    input
        call    nxLn
        mov     al,len1
        cmp     al,len2
        jb      exit
        ; compare
        cbw
        mov     cx,ax
        mov     al,strS
        lea     di,strM
        cld
mch:
        repne   scasb
        jnz     nMatchf
        ;------------
        push    di
        push    cx
        dec     di
        lea     si,strS
        ;check length
        repe    cmpsb
        jz      matchf
        pop     cx
        pop     di
        ;------------
        loop    mch
nMatchf:
        lea     dx,NoMatch
        call    output
        jmp     newStr
matchf:
        lea     dx,Match
        call    output
        jmp     newStr
exit:
        ret
main    endp
; >>> functions <<<
input   proc    near
        push    ax
        mov     ah,0ah
        int     21h
        pop     ax
        ret
output  proc    near
        push    ax
        mov     ah,09
        int     21h
        pop     ax
        ret
nxLn    proc    near
        push    dx
        lea     dx,Mess0
        call    output
        pop     dx
        ret

prognam ends
;*************************************************

        end     main
