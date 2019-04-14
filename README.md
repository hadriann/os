# os

A simple mock first-stage bootloader. It loads nothing, just illustrates the skeleton of a basic bootloader.

It can be compiled using *nasm*:  
`$ nasm bootloader.asm -o bootloader.bin -f bin`

And can be tried out using *qemu*:  
`$ qemu -fda bootloader.bin`
