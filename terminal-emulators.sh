#!/usr/bin/env bash

#TODO check facts and actually understand what is hapenning

##control characters

#some input bytes have immediate effect on a terminal,
#even before you press <enter> to send characters.

#they are useful for doing things like:

#- stopping process
#- stop giving stdin
#- erase a character
#- go to the beginning of a line

#the position of those control chars is inherited from
#an influential terminal that existed, called the VT100
#( ex, c-c finishing a program )

#to test the process control jobs, use the helper script:

    #seqs 5

#- c-c:   send a kill signal to foreground process

    #seqs 5
    ##enter c-c

#- c-z:   send a stop signal to foreground process, and put it on background. `fg` to resume on foreground.

    #seqs 5
    ##enter c-z
    ##enter fg

#- c-s:   send stop   signal to foreground process. c-q to resume. TODO confirm
#- c-q:        resume

    #seqs 5
    ##enter c-s
    ##enter c-q

#- c-d:   eof

    #closes pipes

    #often stdin input ends at the first newline

    #but if you want to be able to give newlines,
    #you have to enter a c-d to end the input.

    #this closes the pipe from the bash side.

    #TODO add an example

#- c-?: clear line
#- c-h: destructive backspace
#- c-m: same as enter. try <c-v><enter>
#- c-[: same as esc. try <c-v><esc>

    #type asdf. type c-h. terminal removes the `f`.

#- c-v c-X:   input a literal control char c-x, bypassing any special meaning

        #to input some literal control charas that have special no meaning
        #you can just type them directly. Ex: c-a

        #to input any literal control chars including those do that have special meaning
        #like `c-c` use `<c-v>` before them, so for example: `<c-v><c-c>`

        #control chars c-x are represented as `^X` on the terminal

        #note however that while visually indistinguishable from a literal `^X`,
        #it is only a single char, since backspacing remove the `^X` at once.

        #to view the ascii value of a sequence:

        #echo -n <c-v>SEQ | hedump -C

    #when you press a key, x tells the terminal about the key press,
    #and the terminal decides what to do with it.

    #the typical thing that happens is that some program is reading
    #from the terminal (bash shell, sh shell, python shell, etc)

    #what the terminal does on keypresses is not officially standardized
    #but the VT100 behaviour became the de facto standard <http://en.wikipedia.org/wiki/VT100>
    #so this is what computer terminal programs emulate. VT100 uses ascii values only (0-127)
    #with contro+keys to reach the non alphanumerical values.

    #- what todo on certain key presses

        #the typical action for simple alhpanumeric chars is to print them on the screen

        #some control chars however do not get output to screen, and may affect
        #processes running on the terminal or the terminal display

    #- what to do when stuff gets output to stdout

        #for simple chars lika alphanumeric ones, terminals simply print them out.

        #^A is the beep char, and if configured to do so,
        #terminals may emmit a beep when they see this at stdout.
        #try (you must do <c-v><c-a>, not copy paste...):

            #echo ^A

        #other non-printable chars might simply print as nothing if they go to the stdout of you terminal
        #try (you must do <c-v><c-a>, not copy paste...):

            #echo ^C

    #- how to let you input literal control chars

        #using `<c-v>` + your char

    #- how to display literal control chars you input

        #as `^X`

    #some control chars are standardized by ascii: <http://en.wikipedia.org/wiki/ASCII> TODO confirm
    #however what they do is not so well specified

    #some control keys sequences of non alphanumeric signs
    #have no value such as c-# while others do like c-[.

##ansi codes

    #the VT100 can also stuff that have no ascii value like

    #- arrow keys
    #- fn keys
    #- setting colors and other text attributes
    #- setting cursor position

    #using standard ansi escape codes <http://en.wikipedia.org/wiki/ANSI_escape_code>
    #which are also based on ascii.

    ##exemple: text attributes

            #echo -e '\033[31ma'

        #- \033 : `\0` is for octal escapes intepreted with `-e`, `33` is esc in octal. You could also do:

                #echo -e '^[[31ma'

            #where ^[ is the literal esc entered via <c-v><c-[>

        #- `[` after esc means this is an escpe sequence! It is called a CSI (Control Sequence Introducer)

        #look at <http://en.wikipedia.org/wiki/ANSI_escape_code> to see what you can do on stdout.
        #just colon separate attributes and end with m:

        #example: a, bold (1), underline (4) and red (31). Afterwards, sets formatting off.

                echo -e '\033[1;4;31ma\033[0m'

        #to use those seriously in a more portable and clear way from bash, use ``tput``.

    #most commands are of type `CSI n A`, or `CSI n B`.

    ##exemple: cursor position

        #you can also set cursor position by outputting special control strings to stdout

        #move cursor to position 2,3 on terminal:

            echo -e '\033[2;3H'

        #H is the command to position the cursor called `CUP`, 2;3 is the position.

        #move the cursor back one position (same as left arrow):

            echo -e 'a\033[1Db'

        #which shows `b` on the terminal, since a was overwritten by b!

        #move cursor up four times:

            echo -e '000\033[4A111'

            #things will get reall ugly as you start to rewrite previous PS1, PS2 and stdout =)

    #note that this should rarelly be piped to other programs, only given to terminals
    #otherwise all those ugly chars will go to the pipe! programs that color stuff should
    #always test if output is going to a pipe or not.

##inner workings

    #when you press a key, x tells the terminal about the key press,
    #and the terminal decides what to do with it.

    #the typical thing that happens is that some program is reading
    #from the terminal (bash shell, sh shell, python shell, etc)

    #what the terminal does on keypresses is not officially standardized
    #but the VT100 behaviour became the de facto standard <http://en.wikipedia.org/wiki/VT100>
    #so this is what computer terminal programs emulate.

    #VT100 uses ascii values only (0-127)
    #with contro+keys to reach the non alphanumerical values.
    #and ansi escape codes <http://en.wikipedia.org/wiki/ANSI_escape_code>
    #for special things like keys that have no ascii representation (arrows, fn keys, etc)
    #or setting the cursor position.

    #some of the options may be configurable, so make sure your terminal emulator
    #is configured to do what you expect it to do. For example, all the following
    #are up to you terminal emulator to decide what to do:

    #- what todo on certain key presses

        #the typical action for simple alhpanumeric chars is to print them on the screen

        #some control chars however do not get output to screen, and may affect
        #processes running on the terminal or the terminal display

    #- what to do when stuff gets output to stdout

        #for simple chars lika alphanumeric ones, terminals simply print them out.

        #^A is the beep char, and if configured to do so,
        #terminals may emmit a beep when they see this at stdout.
        #try (you must do <c-v><c-a>, not copy paste...):

            #echo ^A

        #also see <color example>

        #other non-printable chars might simply print as nothing if they go to the stdout of you terminal
        #try (you must do <c-v><c-a>, not copy paste...):

            #echo ^C

    #- how to let you input literal control chars

        #using `<c-v>`

    #- how to display literal control chars you input

        #as `^X`

    #some control chars are standardized by ascii: <http://en.wikipedia.org/wiki/ASCII> TODO confirm
    #however what they do is not so well specified

    #some control keys sequences of non alphanumeric signs
    #have no value such as c-# while others do like c-[.

##cannonical vs non cannonical

#cannonical waits for newline to make data available to program,
#non cannonical does not

#<http://stackoverflow.com/questions/358342/canonical-vs-non-canonical-terminal-input>

##/dev/tty

#special file, reading and writting to it is the same as reading and writting to current terminal

#ex:

    #echo a > /dev/tty

#outputs:

    #a

#so `a` was written to the current terminal
