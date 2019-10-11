## 操作数寻址方式

有些教程把操作数寻址方式讲得过于复杂, 这里简单讲述

首先8086CPU是16位的, 短地址最高可寻址64K(=$2^{16}$ B), 长地址最高可寻址1M(=$2^{20}$ B), 实际上长地址是利用了2 byte的段地址和 2 byte的偏移地址(又叫有效地址).

一个完整的物理地址是像`1200h:100h`, 表明在段地址1200h的基础上偏移100h, 实际地址是`12100h(=1200h x 10h + 100h)`.

### 立即寻址
```x86asm
mov al, 9
```
立即al <- 9

注意:
- 段寄存器不允许立即赋值
  
  如果需要对段寄存器赋值, 需要用其他寄存器"中转"
    ```x86asm
    mov bx, data
    mov ds, bx
    ```

### 寄存器寻址
```x86asm
mov ax, bx
```
ax <- bx

注意:
- 段寄存器之间无法直接寻址
### 直接和间接寻址
直接指定地址, 取出其中的值, 例如已知 (1000h) = 34
```x86asm
mov ax, [1000h] ; 执行后ax=34
```
方括号相当于到其中的地址把数据取出来

那么下面的间接寻址应该不难理解

```x86asm
mov bx, 1000h   ; 在bx存入偏移地址1000h
mov ax, [bx]    ; 将ds:1000h处的值放入ax
mov bp, 1200h   ; 在bp存入偏移地址1200h
mov ax, [bp]    ; 将ss:1200h处的值放入ax
```
## 注意:
- 间接寻址只允许使用bx, bp, si, di寄存器
- bx默认相对ds偏移
- bp默认相对ss偏移
- si, di相对es偏移


### 相对寻址

直接或间接寻址得到的是形如`1200h:800h`这样的长地址(可能会有省略, 即使用默认段基址, 但实际使用的还是长地址).

而相对寻址则是在长地址的基础上再加上一段偏移, 为什么要有这样的设计呢?

- 长地址表示的是准确的物理地址
- 在某些需要的场合下, 数据是线性存储的(如数组, 结构)
- 为了方便表示这种线性单元的地址, 需要使用偏移量表示

```x86asm
; 利用相对寻址将数组转成字符串输出
data segment
    array db 1,2,3,4,5,'$'
data ends

code segment
assume cs:code, ds:data
start:  mov ax, data
        mov es, ax  ; 设置es
        mov ds, ax
        mov di, offset array    ; 设置di
        mov cl, 5   ; 循环5次
        mov bx, 30h 

lo:     add [di], bx; 数字转字符
        dec cl
        jcxz exit
        inc di      ; 数组下标递增
        jmp lo
        
exit:   mov dx, 0
        mov ax, data
        mov ds, ax
        mov dx, offset array
        mov ah, 9   ; 打印字符串
        int 21h
        mov ah, 4ch
        int 21h

code ends
        end start
```

例题
---

```x86asm
; 判断不同寻址方式取值结果是否相同
data segment
    y db 'equal$'
    n db 'not equal$'
data ends

code segment
assume cs:code, ds:data
start:  mov ax, 1000h
        mov ds, ax
        mov [ax], 88
        mov di, 0
        mov cx, 34
        mov [di], cx 
        mov ax, [0]
        ; 如果ax == 34, 输出equal, 否则输出not equal
        cmp ax, 34
        
        ; 下面的部分暂时不用管, 只是输出字符串辅助判断用的
        mov ax, data
        mov ds, ax
        mov dx, offset y
        je exit
        mov dx, offset n
exit:   mov ah, 9
        int 21h
        mov ah, 4ch
        int 21h

code ends
        end start
```

请问是输出`equal`还是`not equal`, 如果是`not equal`为什么

答案
---
`not equal`

将`mov ax, [0]`改成`mov ax, [di]`即可输出`equal`
```x86asm
; 判断不同寻址方式取值结果是否相同
data segment
    y db 'equal$'
    n db 'not equal$'
data ends

code segment
assume cs:code, ds:data
start:  mov ax, 1000h
        mov ds, ax
        mov [ax], 88
        mov di, 0       ; 设置ds:di=1000h:0
        mov cx, 34
        mov [di], cx    ; 将34放到 1000h:0 (间接偏移寻址)
        ; 下面的语句和mov ax, [0]不一样
        ; 虽然di=0, 但是[di]默认偏移是ds
        ; 即这里 [di] == ds:[0]
        mov ax, [di]     ; 从ds:0取值到ax
        cmp ax, 34      ; 检查是否相等, 相等输出equal
        
        ; 下面的部分暂时不用管, 只是输出字符串辅助判断用的
        mov ax, data
        mov ds, ax
        mov dx, offset y
        je exit
        mov dx, offset n
exit:   mov ah, 9
        int 21h
        mov ah, 4ch
        int 21h

code ends
        end start
```