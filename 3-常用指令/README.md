## 8086常用指令

指令可以参考
- ## 官方文档 [MASMReference.pdf](http://angom.myweb.cs.uwindsor.ca/teaching/cs266/MASMReference.pdf)
- ## [Wiki -8086/8088_instructions](https://en.wikipedia.org/wiki/X86_instruction_listings#Original_8086/8088_instructions)

后来的指令是在前面的基础上进行扩展, 之前的指令可以不加修改的运行在之后的平台上

### 数据传送
- mov 

  通用数据传送指令

  可以实现数据在①寄存器之间, ②存储器和寄存器之间, ③立即数->寄存器, ④立即数->存储器 的传递

  注意:

  - IP寄存器禁止操作
  - 禁止段寄存器之间直接传送

- push

  数据入栈

  注意:

  - 不支持立即数入栈
  - 默认以字的宽度入栈, push一次, $sp \leftarrow sp-2$
  - 栈的最大大小是64K, 即一个段

- pop

  将栈顶数据出栈

  - 除了cs均可以作为目的数
  - 每pop一次, $sp \leftarrow sp+2$

- xchg

  可以在 ①寄存器之间;②寄存器与存储器之间 进行数据**交换**(swap)

  - 不需要一个中转的寄存器, 在EU中有暂存器
  - 不支持操作段寄存器

- xlat

  从表中查找, TODO

- in

  从指定的地址读取数据(键盘, 鼠标的输入就是靠这个命令)

- lea

  地址传送, 从存储器取地址

- lds

    取地址, 段地址存入ds, 偏移地址存入目的数中

- les

    取地址, 同上, 不过段地址存入es

- lahf

    将psw低8位传送到ah

- sahf

    将ah送入psw低8位

- pushf

    psw入栈

- popf

    出栈到psw


### 算数运算

- add
- adc
- inc
- aaa
- daa
- sub
- sbb
- dec
- neg
- cmp
- aas, das
- mul
- imul
- aam
- div
- idiv
- cbw
- cwd
- aad
- not
- and
- or
- xor
- test
- sal, shl
- shr, sar
- rol, ror

