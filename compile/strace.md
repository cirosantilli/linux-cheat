list system calls made by executable

includes calls that load program

    echo '#include <stdio.h>
    int main(void)
    { printf("hello"); return 0; }' > a.c

    gcc a.c
    strace ./a.out
