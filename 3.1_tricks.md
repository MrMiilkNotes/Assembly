#### 结构体

```assembly
; label字段可以去掉
stockM  label   byte
        max1    db      40			; 最大存储长度，16进制
        len1    db      ?			; 实际输入长度
        strM    db      40 dup(?)	; 存储位置
; 注意实际输入长度为字节
; 存储位置的使用可以当作字符串首地址
```

### 函数

#### io

```assembly
; 输入输出在调用前都得设置dx
; 虽然可以通过传参的形式，但是同样需要用到寄存器(保存取出的参数)，而且花销更大
input	proc	near
		push    ax		;使用stack保存，调用前后保证不影响寄存器
        mov     ah,0ah
        int     21h
        pop     ax
        ret
; 调用output，dx应该存储结构体名称
output  proc    near
        push    ax
        mov     ah,09
        int     21h
        pop     ax
        ret
; 例子：输出换行回车，在输入后应当及时换行回车，否则可能会覆盖输入
Mess0   db      13,10,'$'
nxLn    proc    near
        push    dx
        lea     dx,Mess0
        call    output
        pop     dx
        ret
```

### tricks

#### 多重循环

```assembly
; 多重循环虽然能利用多个寄存器自己实现，但是
; 不但浪费寄存器，还不易于管理，可以利用stcak实现
	mov cx,<n1>
tag1:
	...
	push cx
	mov	 cx, <n1>
;------------
tag2:
	...
	loop tag2
;------------
	...
	pop  cx
	loop tag1
; 应当注意，串处理指令会影响cx
```

#### 将数字输出为十进制

#### 输出为十六进制