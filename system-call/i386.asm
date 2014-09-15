; IA32 system call inteface.
;
; Conventions:
;
; - `%eax` holds the syscall number
; - `%ebx`, `%ecx`, `%edx`, `%esx`, `%edi` are the params

section .data

;strings

    bs5 db "a", "b", "c", 'd', 0
        ; "abcd\n"
    bs5l  equ $ - bs5
        ;strlen(s)
        ;MUST FOLLOW bs5 immediately
        ;$ is the cur adress

    filepath db 'out.tmp', 0

section .bss
    ;unitialized data

    bu resb 1           ;1 uninitialized byte
    ws10 resw 10        ;10 uninitialized words

    input resd 1

    fx    resd 1        ;float
    ix    resd 1        ;int

    ;for later use
    bytesRead resd 1

section .text

    global _start

_start:

    ;linux x86 system calls from nasm

    ;sys_write sys_read sys_open sys_close

        ;file descriptor is an int
        ;it represents a file that is open to read/write
        ;once you close a fd, the int is freed

        ;in linux, devices and pipes are treated as files and thus get fds

        ;you can only tell you have read all the bytes of a fd when it
        ;reads less than you asked

        ;the exception to this are regular files,
        ;where you can use the `sys_stat`
        ;that amongst other things returns the filesize info

        ;#write

            mov eax, 4         ;sys_write
            mov ebx, 1         ;file descriptor 1 = stdout
            mov ecx, bs5       ;pointer to string
            mov edx, bs5l      ;string len
            int 80h

            mov eax, 4
            mov ebx, 2         ;stderr
            mov ecx, bs5
            mov edx, bs5l
            int 80h

        ;#file

            ;#write

                ;open

                    mov eax, 5         ;sys_open
                    mov ebx, filepath  ;null terminated
                    mov ecx, 0101
                        ;acess
                        ;1: O_WRONLY
                        ;0100: O_CREAT. create if non-existent
                    mov edx, 0600
                        ;permissions
                            ;04000: set user id
                            ;02000: set group id
                            ;01000: set sticky bit
                            ;0400: read by user
                            ;0200: write by user
                            ;0100: exec by user
                                ;TODO not getting perms right... why??
                    int 80h
                    test eax, eax      ;-1 if error, else the file descriptor
                    ;js sys_open_error

                ;open

                    mov eax, 6              ;sys_close
                    ;mov ebx, fd            ;fd, ebx already contains it
                    int 80h

                ;close

                    mov eax, 6              ;sys_close
                    ;mov ebx, fd            ;fd, ebx already contains it
                    int 80h

            ;read

                ;open

                    ;mov eax, 5
                    ;mov ebx, filepath
                    ;mov ecx, 0         ;O_RDONLY
                    ;int 80h
                    ;test eax, eax

                ;;read

                    ;mov dword [bytesRead], 0    ;assign address of end of input

                    ;mov ebx, eax            ;fd
                    ;mov eax, 3              ;sys_read
                    ;mov ecx, bs5_2          ;buffer to read into
                    ;mov edx, 2              ;bytes to read. this is just a test: normally if you can allocate 5 bytes, you should just read 5 bytes!
                    ;int 80h
                    ;test eax, eax           ;nb of bytes read
                    ;;js sys_read_error      ;if eax is negative then error
                    ;;jz no_bytes_read
                    ;add [bytesRead], eax    ;assign address of end of input

                    ;mov eax, 3
                    ;mov ecx, bs5_2
                    ;add ecx, [bytesRead]    ;start from correct position
                    ;mov edx, 2
                    ;int 80h

                    ;mov eax, bs5_2
                    ;call print_string

                ;close

                    ;mov eax, 6              ;sys_close
                    ;int 80h

    ;sys_exit

        mov eax,1        ;sys_exit
        mov ebx,0        ;exit status
        int 80h
