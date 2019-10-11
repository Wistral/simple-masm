## dosbox安装教程

## [下载地址](https://github.com/Wistral/simple-masm/releases/download/1.0/install.zip)

1. 安装dosbox

- ubuntu
    ```sh
    sudo apt install dosbox
    ```
- windows

    使用安装包`DOSBox0.74-win32-installer.exe`安装即可

- Android
  
    使用`DosBox.apk`安装

1. 配置dosbox

打开配置文件, 文件路径如下
- Ubuntu

    `/home/$USER/.dosbox/dosbox*.conf`
- Windows

    `C:\Users\$USER\AppData\Local\DOSBox\dosbox*.conf`
- Android

    `$sdcard0/dosbox.conf`
    
    手机上修改不了可以先把后缀.conf改成.txt, 修改完再改回去

修改其中几项(安卓可以跳过这步, 因为默认是直接挂载内部存储的根目录到c盘)

  - 修改`windowresolution=1024x768`调整分辨率（某些高分辨率显示下需要）
  - 设置`[autoexec]`以自动挂载

    这里运行dos程序需要将程序先挂载到dosbox里，假设`/home/wistral/.dosbox/c`是我们要挂载的本地目录(其他平台类似)

    ```sh
    mount c /home/wistral/.dosbox/c
    c:
    ```
    将以上命令写入`[autoexec]`后以避免每次都需要手动挂载

3. 添加`debug.exe`, `masm.exe`, `link.exe`等汇编必须的16位程序到挂载的目录
   
    这些必须的文件已经放入`install/masm`

    个人还整理了一些16位的可选程序, 放在`install/ex`中

    此外, 之后我们自建的一些常用脚本也会放在这里

    可以把这些目录添加到dos的环境变量里(同样可以加到`[autoexec]`)
    ```bat
    path %path%;c:\masm;c:\ex
    ```
    这样就可以在任意路径使用这些目录下的程序或脚本

4. 测试编译运行

    这里准备了一个[`hello.asm`](https://github.com/Wistral/simple-masm/blob/master/1-%E5%AE%89%E8%A3%85%E7%8E%AF%E5%A2%83%E4%B8%8E%E9%85%8D%E7%BD%AE/hello.asm)的masm文件以测试, 至于内容后面会详细讲解
    
    运行以下命令(中间要求输入的直接3次回车默认值就行)
    ```bat
    masm hello      ;汇编
    link hello      ;链接
    hello.exe       ;运行
    ```

    如果出现`Hello World!`的输出则安装正常

5. 编写编译批处理脚本

    将上述命令写成bat文件(假设叫[`ale.bat`](https://github.com/Wistral/simple-masm/blob/master/1-%E5%AE%89%E8%A3%85%E7%8E%AF%E5%A2%83%E4%B8%8E%E9%85%8D%E7%BD%AE/install/ex/ale.bat))
    ```bat
    echo assemble file %1.asm
    del %1.obj
    del %1.exe
    masm %1 
    link %1 
    %1.exe
    ```
    现在汇编, 链接, 运行只需要一句`ale hello`就可以了

参考
---
- [在Linux里使用dosbox运行debug.exe](https://blog.csdn.net/Kwansy/article/details/82939391)
- [A Guide to DEBUG](https://thestarman.pcministry.com/asm/debug/debug.htm)