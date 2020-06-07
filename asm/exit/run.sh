nasm -felf64 exit.asm -o exit.o 
ld -o exit exit.o
chmod u+x exit
./exit
