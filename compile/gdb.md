gdb uses symbol information contained in executables to debug them

for this to work, executables must be compiled with that extra information,
making it slightly larger.

add debug information to executable on compilation:

    gcc -ggdb3 a.c

options

- g : generate debug info for gdb
- ggdb : adds more info
- ggdb3 : adds max info. default if 2 when ggdb is used.

to run executable and debug it:

    gdb a.out

it is possible to attach gdb to a running instance of a program
after it was run:

    gdb a.out $pid

when you quit gdb, the process will continue to run

# commands

commands you can run from inside gdb

run prog

    r

if already runnin, kill and rerun.
keeps breakpoints, etc

    r 1 2

start running with arguments
next r calls will use those args

removes previously set args:

    set args

kill program:

    k

keeps breakpoints, etc saved for next debug session

TODO format the rest of this section on md

    b

        #b 10
        #b func
        #b c.c:10
        #b c.c:func
        #b +2
            #two lines down from cur
        #b -2
            #two lines down from cur

    i b
        #view breakpoints

    dis 1
        #disable breakpoint 1.
        #1 is gotten from `i b`

    en 1
        #enable breakpoint 1.
        #1 is gotten from `i b`

    d
        #delete all breakpoints
    d 1
        #delete breakpoint 1

    cl 10
    cl func
    cl file:func
    cl file:10
        #delete breakpoint at line 10

    w
        #set watchpoint
        #stop prog when var or expr changes value

    c
        #set catchpoint
        #TODO ?

    s
        #step exec next line
        #if func call, step inside funv
    n
        #setp next. if func call
        #run entire func now
    whe
        #where, print line number

    ba
        #show backtrace of stack at current point

    f
        #show cur frame number
    f 1
        #go to frame 1

    l
        #list next 10 lines of code.
        #l again, lists next 10.
    l -
        #previous
    l 20
        #list 10 lines around line 20
    l 5,20
    l ,20
    l 5,
    l func
    l c.c
    l c.c:12
    l c.c:func
    set listsize 5

    p
        #p x
            #print value of variable x in current frame
            #vars in other frames cannot be seen
        #p x+1
        #p x*2
        #p func(1)
        #p array
        #p array[3]@5
            #print 3 vals or array, starting at elem 5
        #p myStruct
        #p myStruct.key
        #set print pretty

        #format
            #(gdb) p mychar    #default
            #$33 = 65 'A'
            #(gdb) p /o mychar #octal
            #$34 = 0101
            #(gdb) p /x mychar #hex
            #$35 = 0x41
            #(gdb) p /d mychar
            #$36 = 65
            #(gdb) p /u mychar #unsigned decimal
            #$37 = 65
            #(gdb) p /t mychar #binary
            #$38 = 1000001
            #(gdb) p /f mychar #float
            #$39 = 65
            #(gdb) p /a mychar
            #$40 = 0x41

        #p &mychar
            #addres of mychar
            #p *(&mychar)

        #pt x
            #print type of var x

    attach
        #links to a running process

    q
        #quit

    gdbinit
        #~/.gdbinit
        #somedir/.gdbinit
