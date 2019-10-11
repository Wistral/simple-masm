echo assemble file %1.asm
del %1.obj
del %1.exe
masm %1 
link %1 
%1.exe