/*
cheat on gnu c extensions.

non gnu specific  features (ex: ansi c, posix) will not be put here.
the latest stable version of those standards will be considered.

you can disable all non gnu specific languages features with flags like `-ansi or -std=c99`

this will not however stop defining certain GNU specific preprocessor macros such as `__GNUC__`

obviously, it is always better if you avoid using those features,
but you may encounter them in linux specific projects, such as the linux kernel itself for example.

gnu extensions have a large chance of being implemented
in future ansi c versions (but sometimes in a modified form)
because of the large influence of gcc.

*/

#include "assert.h"
#include "math.h"
#include "stdio.h"
#include "stdlib.h"

int nested()
{
    return 0;
}

int main( int argc, char** argv )
{

    /*
    #binary int literals

        start with `0b`:
    */

            assert( 16 == 0b10000 );

    /*
    #nested function

         is a function defined inside another function (the outter function here is `main`)

         this is not a redefinition because it is inside a parenthesis block
         much like a variable definition inside a parenthesis block
    */

        int nested()
        {
            return 1;
        }

        {

            int nested()
            {
                return 2;
            }

            //this would cause a redefinition error:

                //int nested()
                //{
                //    return 2;
                //}

            // like variable redefinitions, the nested version overrides all external version
            // which have become completelly innacessible

            assert( nested() == 2 );
        }

    /*
    # preprocessor defines

        only gnu extensions are considered here

        full list: <http://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros>

        view all macros that would be automatically defined:

            cpp -dM /dev/null

        TODO there are some missing! where is `__i386__` documented for example?
    */

    /*
        automatically defined on gcc even if `-std=cXX -pedantic-erors`:
    */

#ifdef __GNUC__
        puts("__GUNC__");
#endif

        /*
        automatically defined if the compiler is told to use strict ansi c features and no extensions
        this is triggered by options such as `-std=c99` or `-ansi`

        don't be surprised if this does not appear when compiling this file
        since strict ansi compliance would mean other features of this file would need
        to be broken such as nested functions
        */

#ifdef __STRICT_ANSI__
        puts("__STRICT_ANSI__");
#endif

        /*
        gcc defines architecture macros TODO where?

        you can find a list of those macros: <http://sourceforge.net/p/predef/wiki/Architectures/>
        */

#ifdef __i386__
        puts("__i386__");
#endif

    /*
    # inline assembly

        # sources

            - great intro: <http://www.ibm.com/developerworks/library/l-ia/index.html>

        can be used if you really, really want to optimize at the cost of:

        - architecture dependance
        - tying you to gcc

        if you use this, do it like the linux kernel and separate different architecture
        code in different dirs.

        general syntax:

            asm (
                "movl %1, %%eax;"   //commands string
                "movl %%eax, %0;"
                : "=X" (y),   //outputs
                  "=X" (z)
                : "X" (x)    //inputs
                : "X" (x)
                : "%eax"     //clobbered registers
            );

        where:

        - commands: actual gas code into a single c string. Remember: each command has to end in newline or `;`.
        - outputs: start with `=`. gcc has to enforce is that at the end of the `asm` block that those values are set.
        - inputs:
        - clobbered registers:

            registers that may be modified explicitly in the assembly code.

            normally, users have no direct access to registers,
            so gcc is free to optimize by leaving values in those registers for later use.

            this tells gcc not to leave values in the listed since those may be modified.

            ex:

                mov $0, %eax

            clearly clobbers eax, so you would need to list eax in the clobber list.

            Note that certain instructions clobber registers
            even if they are not explicitly written in the code.

        both inputs and outputs are constrats. `X` will indicate the constraint type
    */

        /*
            examples of inline assembly in i386

            this is the main place for contains more comments and explanations
            if other archs are also exemplified
        */

#ifdef __i386__

        /*
            #m constraint

            m = Memory

            instructs gcc to store keep value of given expressions into RAM

            this is the most basic way to get/set values of c variables in assembly code
        */
        {
            int in = 1;
            int out = 0;
            //out = in
            asm (
                "movl %1, %%eax;"
                "movl %%eax, %0"
                : "=m" (out)
                : "m" (in)
                : "%eax"      /* eax will be modified, so we have to list it in the clobber list */
            );
            assert( out == 1 );
        }

        /* simple exaple using floats */
        {
            float in = 1.0;
            float out = 0.0;
            //out = -in
            asm (
                "flds %1;"
                "fchs;"
                "fstps %0;"
                : "=m" (out)
                : "m" (in)
            );
            assert( out == -1.0 );
        }

        /* input and ouput can be the same memory location */
        {
            float x = 1.0;
            //x = -x
            asm (
                "flds %1;"
                "fchs;"
                "fstps %0;"
                : "=m" (x)
                : "m" (x)
            );
            assert( x == -1.0 );
        }

        /*
        #register constraints

            tell gcc to automatically read memory into registers or write registers into memory

            this is more precise and complicated than using `m`

            - r: gcc chooses any free register
            - a: %eax
            - b: %ebx
            - c: %ecx
            - d: %edx
            - S: %esi
            - D: %edi
            - 0: matching register
        */

        /*
        r example

        gcc will automatically put the value of `in` from ram into a register for us
        and `out` from a register into ram at the end

        note how we can do an `inc` operation directly on `%1` and `%0`
        so they must both already be inside a registers as expected

        gcc just makes sure they are written from/to memory before/after the operations
        */
        {
            int in = 0;
            int out = 0;
            //out = in + 2
            asm (
                "incl %1;"
                "movl %1, %0;"
                "incl %0;"
                : "=r" (out)
                : "r" (in)
            );
            assert( out == 2 );
        }

        /*
        #matching constraint

        are digits

        specifies that an input/output has the same constraint as another one

        often used when we want a single variable to be both input and output
        and minimize the use of new registers
        */
        {
            int x = 0;
            asm (
                    "incl %0"
                    : "=r" (x)
                    : "0" (x) /* x has the same constraint
                                 as constraint 0 (`r`)*/
            );
            assert( x == 1 );
        }

        /*
        #specific register constraints

        if you look at the generated assembly code,
        you will see that x was put into eax
        */
        {
            int x = 0;
            asm (
                    "incl %0"
                    : "=a" (x)
                    : "0" (x)
            );
            assert( x == 1 );
        }
#endif

    return EXIT_SUCCESS;
}
