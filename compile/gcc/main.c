/*
Cheat on GNU C extensions both to gcc and libc (called glibc in its GNU version).

Non GNU specific  features (ex: ANSI C, POSIX) will not be put here.

You can disable all non gnu specific languages features with flags like `-ansi or -std=c99`.

This will not however stop defining certain GNU specific preprocessor macros such as `__GNUC__`

Obviously, it is always better if you avoid using those features,
but you may encounter them in Linux specific projects, such as the linux kernel itself for example.

GNU extensions have a large chance of being implemented
in future ansi c versions (but sometimes in a modified form)
because of the large influence of gcc.
*/

/*
#glibc

    name for the gnu implementation of the c standard library

    the standards only specifies the interface, not exact implementation of compiler and algorithms

    glibc is one of important implementation

    stdlib does not come with gcc: you could in theory choose between different implementations.

    - ubuntu

        - headers for glibc are on `/usr/include`. do `locate /stdio.h`

        - lib for glibc are on `/usr/lib/i386-linux-gnu`. do `locate /libc.a`

        - the ubuntu package is called `libc6-dev`. `dpkg -l | grep libc`

    - docs

        <http://www.gnu.org/software/libc/manual/html_mono/libc.html>
*/

#include <assert.h>
#include <complex.h>    //complex integer types
#include <math.h>
#include <stdarg.h>    //..., va_list, va_start, va_arg, va_end
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nested()
{
    return 0;
}

//attribute

    //#function attributes

        char not_aligned16 = 0;
        char aligned16 __attribute__ ((aligned (16))) = 0;

        int sprintf_wrapper(char *s, int useless, const char *fmt, int useless2, ...)
        {
            int ret;
            va_list args;

            va_start(args, useless2);
            ret = vsprintf(s, fmt, args);
            va_end(args);
            return ret;
        }

        //format

            /*
            3 says: the 3rd argument is the format string
            5 says: the va_list starts at the 5th argument

            Declaration and definition *must* be separated.
            */
            int sprintf_wrapper_attr(char *s, int useless, const char *fmt, int useless2, ...) __attribute__((format(printf, 3, 5)));

            int sprintf_wrapper_attr(char *s, int useless, const char *fmt, int useless2, ...)
            {
                int ret;
                va_list args;

                va_start(args, useless2);
                ret = vsprintf(s, fmt, args);
                va_end(args);
                return ret;
            }

        //deprecated

            void func_deprecated() __attribute__((deprecated));

            void func_deprecated(){}

        //used

            void func_used() __attribute__((used));

            void func_used(){}

            void func_not_used(){}

        //warn_unused_result

            int func_warn_unused_result() __attribute__((warn_unused_result));
            int func_warn_unused_result(){ return 0; }
            int func_not_warn_unused_result(){ return 0; }

        /*
        #noreturn

            It is possible that the function makes the program exit and therefore does not return.

            Makes compiler ommit "possible no return" warnings.

            Used on glibc exit and abort:

                extern void exit(int)   __attribute__((noreturn));
                extern void abort(void) __attribute__((noreturn));
        */

            void exitnow()
            {
                exit(EXIT_SUCCESS);
            }

            //warning: control reaches end of non void function
            /*
            int noreturn_possible(int n)
            {
                if (n > 0)
                    exitnow();
                else
                    return 0;
            }
            */

            void exitnow_attr() __attribute__((noreturn));

            void exitnow_attr()
            {
                exit(EXIT_SUCCESS);
            }

            int noreturn_possible_attr(int n)
            {
                if (n > 0)
                    exitnow_attr();
                else
                    return 0;
            }

            /*
            Does not emmit a warning because the libc exit has the `noreturn` attribute.
            */
            int noreturn_possible_exit(int n)
            {
                if (n > 0)
                    exit(EXIT_SUCCESS);
                else
                    return 0;
            }

        //const

            int next(int cur)
            {
                return cur + 1;
            }

            int next_const(int cur) __attribute__((const));

            int next_const(int cur)
            {
                return cur + 1;
            }

        //always inline

            /* function must also be `inline` */
            inline int incr_always_inline(int i) __attribute__((always_inline));

            inline int incr_always_inline(int i){ return i + 1; }

            inline int incr_inline(int i){ return i + 1; }

            int incr(int i){ return i + 1; }

    /*
    #variable attributes

        Attributes that apply to individual variables.
    */

        /*
        #section

            Put *initilized* data on an arbitrary new section.

            Cannot be used for uninitialized data.

            Arbitrary sections may not be supported on all output formats. ELF at least supports them.

            Applications:

            - linux kernel `__initdata` puts declarations on a special section which is removed at the end of initialization,
                reclaiming otherwise wasted text space.

            Result on GCC 4.7 i386:

            - generated gas contains `.section` directives:

                .section        newsection1,"aw",@progbits

            - `readelf -a | grep newsec` shows that those two sections exist on the ELF:

                [25] newsection1       PROGBITS        0804a034 001034 000004 00  WA  0   0  4
                [26] newsection2       PROGBITS        0804a038 001038 000004 00  WA  0   0  4
        */

            int __attribute__((section("newsection1"))) newsection1_var = 1;
            int __attribute__((section("newsection2"))) newsection2_var = 2;

//do some random operations to try and get the cache dirty
void get_cache_dirty()
{
    int i;
    int is[1024];
    for (i = 0; i < 1024; i++)
        is[i] = 1;
    assert(is[0] == 1);
}

int main(int argc, char** argv);

void builtin_return_address_test()
{
    printf("main                           = %p\n", main);
    //0 means for current function
    //1 for the parent of current function
    //etc.
    printf("__builtin_return_address(0)    = %p\n", __builtin_return_address(0));
    return;
}

int main(int argc, char** argv)
{

    /*
    #binary int literals

        start with `0b`:
    */
    {
        assert(0b10000 == 16);
    }

    /*
    #complex integer

        C99 has floating point complex numbers, but no integer complex numbers
    */
    {
        int complex z = 1 + 1*I;
        int complex z2 = 1 - 1*I;
        assert(z + z2 == 2  );
    }

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

            //like variable redefinitions, the nested version overrides all external version
            //which have become completelly innacessible

            assert(nested() == 2);
        }

    /*
    #preprocessor defines

        only gnu extensions are considered here

        full list: <http://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros>

        view all macros that would be automatically defined:

            cpp -dM /dev/null

        TODO there are some missing! where is `__i386__` documented for example?
    */

    /*
    automatically defined on gcc even if `-std=cXX -pedantic-erors`:

    contains major version number
    */

#ifdef __GNUC__
        printf("__GUNC__ = %d\n", __GNUC__);
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
        gcc defines OS macros TODO where?
        */

#ifdef __linux__
        puts("__linux__");
#endif

    /*
    #attribute

        Specifies special attributes of functions or data.

        There are three types of attributes:

        - functions: http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html
        - variables: http://gcc.gnu.org/onlinedocs/gcc/Variable-Attributes.html#Variable-Attributes
        - types: http://gcc.gnu.org/onlinedocs/gcc/Type-Attributes.html#Type-Attributes

        Can be used to:

        - do error checking at compile time that would not be possible otherwise:

            - format
            - noreturn

        - control certain aspects of low level assembly code output.

            For example, `aligned` controls data alignment on the text section.

        - help the compiler optimize by giving it extra information:

            - const
            - hot

        C++11 specifies a standard syntax for attributes:

            int [[attr1]] i [[attr2, attr3]];

            [[attr4(arg1, arg2)]] if (cond)
            {
                [[vendor::attr5]] return i;
            }

        and two attributes; noreturn and carries_dependency.

    #multiple attributes

        Two syntaxes:

            extern void die(const char *format, ...)
                __attribute__((noreturn))
                __attribute__((format(printf, 1, 2)));

        or:

            extern void die(const char *format, ...)
                __attribute__((noreturn, format(printf, 1, 2)));

    #reason for double parenthesis

        See next section.

    #eliminating __attribute__ on non gnu projects

        This is really easy:

            #ifndef __GNUC__
            #  define  __attribute__(x)
            #endif

        This only work because attributes can only take a single argument: `(...)`.

    #alternative syntax

        Add prefix and suffix `__` to keywords and dispense `__attribute__`. Ex:

            __noreturn__
    */
    {
        /*
        #format

            If this is used, gcc can check if printf format strings are correct because of the use of attributes,
            and emmit errors otherwise.
        */
        {
            char s[32];
            sprintf_wrapper(s, 0, "%c", 0, 'a');
            assert(s[0] == 'a');

            sprintf_wrapper_attr(s, 0, "%c", 0, 'b');
            assert(s[0] == 'b');

            /*
            With `__attribute__((format,X,Y))` the compile time error checking gets done.
            */
            {
                //compile error check not done
                //could segfault at runtime
                if (0)
                {
                    sprintf_wrapper(s, 0, "%s", 0);
                }

                //compile error check is done
                {
                    //sprintf_wrapper_attr(s, 0, "%s", 0);
                }
            }
        }

        /*
        #deprecated

            Using a function marked as deprecated will emmit warnings.
        */
        {
            //func_deprecated();
        }

        /*
        #used

            Useful when the function may be called from assembly code, in which case GCC
            may not be easily able to detect that it was called.

            TODO0 what is this for? If a func is not called, what does gcc do? Remove it from text?
        */
        {
        }

        /*
        #warn_unused_result

            Always emmit a warning if the return value is not used.

            Useful to enforce callers to do error checks when the return value signals the error.
        */
        {
            //no warning
            func_not_warn_unused_result();

            assert(func_warn_unused_result() == 0);

            //WARNING ignored return value

                //func_warn_unused_result();
        }

        /*
        #const

            A function marked const may be optimized in the sense that the compiler calculates its value at compile time,
            or chaches its result of each calculation.

            A function can only be marked const if:

            - its return value is only a function of its arguments, and not of any global or static function variable
            - the function has no desired side effect besides returning the value

            Marking a function which does one of the above const will lead to serious hard to find bugs.
        */
        {
            assert(next(0) == 1);
            assert(next(0) == 1);
            assert(next_const(0) == 1);
            assert(next_const(0) == 1);
        }

        /*
        #always_inline

            Always inline the function.

            ANSI C99 `inline` does not guarantee that, it only hints it to the compiler.

            Must see generated assembly code to notice this (except for the possible desired speedup effect).

            On `gcc -O0 4.7`, only the `incr_always_inline` was inlined.
        */
        {
             int i = 0;
             i = incr(i);
             i = incr_inline(i);
             i = incr_always_inline(i);
        }

        /*
        #variable attributes
        */
        {
            /*
            #aligned

                Aligns variables on X bit lines.

                This may be required for certain processor specific functions.

                The generated gas assembly code should mark this alignment with the `.align` directive.
            */
            {
                assert(aligned16 == 0);
                assert(not_aligned16 == 0);
            }

            /*
            #packed

                Chars in structs are normally put on 32 bit lines to speed up retrieval.

                This however makes the struct larger than necessary, since a struct with
                2 chars then takes 8 bytes instead of 2.

                Packed prevents this and puts the chars side by side.
            */
            {
                struct not_packed {
                    char c1;
                    char c2;
                };
                struct not_packed not_packed = { 0, 1 };
                assert(sizeof(not_packed) >= 2 * sizeof(char));

                struct packed {
                    char c1;
                    char c2;
                } __attribute__((packed));
                struct packed packed = { 0, 1 };
                assert(sizeof(packed) == 2 * sizeof(char));
            }
        }

        /*
        #type attributes

            Attribute that applies to all objects of a newly created user type.

            Syntax is as:

                struct S { int i } __attribute__((aligned (8)));
                typedef int more_aligned_int __attribute__((aligned (8)));
        */
        {
            /*
            #vector extensions

                GCC built-ins for vectorized SIMD operations.

                <http://gcc.gnu.org/onlinedocs/gcc/Vector-Extensions.html>

                Allowed operators: +, -, *, /, unary minus, ^, |, &, ~, %, ==, !=, <, <=, >, >=

            #vector_size
            */
            {
                typedef int v4si __attribute__ ((vector_size (16)));

                // Create
                {
                    v4si v = {0, 1, 2, 3};
                }

                // Access
                {
                    v4si v = {0, 1, 2, 3};
                    assert(v[0] == 0);
                    assert(v[1] == 1);
                }

                // Operations
                {
                    v4si v = {0, 1, 2, 3};
                    v4si v2 = {0, 1, 2, 3};
                    v4si res;

                    res = v + v2;
                    assert(res[0] == 0);
                    assert(res[1] == 2);
                    assert(res[2] == 4);

                    res = v * v2;
                    assert(res[0] == 0);
                    assert(res[1] == 1);
                    assert(res[2] == 4);
                }
            }
        }
    }

    /*
    #inline assembly #asm

        #sources

            - great intro: <http://www.ibm.com/developerworks/library/l-ia/index.html>

        Can be used if you really, really want to optimize at the cost of:

        - architecture dependance
        - tying you to gcc

        If you use this, do it like the linux kernel and separate different architecture
        code in different dirs.

        General syntax:

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

        TODO0 #__asm__ vs asm
        TODO0 #asmlinkage
        TODO0 #asm volatile
    */

        /*
        examples of inline assembly in i386

        this is the main place for contains more comments and explanations
        if other archs are also exemplified
        */

#ifdef __i386__
        /*
        #m constraint

            instructs gcc to store keep value of given expressions into RAM

            this is the most basic way to get/set values of c variables in assembly code
        */
        {
            int in = 1;
            int out = 0;
            //out = in
            asm volatile (
                "movl %1, %%eax;"
                "movl %%eax, %0"
                : "=m" (out)
                : "m" (in)
                : "%eax"      /* eax will be modified, so we have to list it in the clobber list */
            );
            assert(out == 1);
        }

        //no input
        {
            int out = 0;
            //out = 1
            asm volatile (
                "movl $1, %0"
                : "=m" (out)
            );
            assert(out == 1);
        }

        /* simple exaple using floats */
        {
            float in = 1.0;
            float out = 0.0;
            //out = -in
            asm volatile (
                "flds %1;"
                "fchs;"
                "fstps %0;"
                : "=m" (out)
                : "m" (in)
            );
            assert(out == -1.0);
        }

        /* Input and ouput can be the same memory location. */
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
            assert(x == -1.0);
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
        #r register constraint

            gcc will automatically put the value of `in` from ram into a register for us
            and `out` from a register into ram at the end

            note how we can do an `inc` operation directly on `%1` and `%0`
            so they must both already be inside a registers as expected

            gcc just makes sure they are writen from/to memory before/after the operations
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
            assert(out == 2);
        }

        /*
        #matching constraint

            Represented by digits.

            Specifies that an input/output has the same constraint as another one.

            Often used when we want a single variable to be both input and output
            and minimize the use of new registers.
        */
        {
            volatile int x = 0;
            asm (
                "incl %0"
                : "=r" (x)
                : "0" (x) /* x has the same constraint
                                as constraint 0 (`r`)*/
            );
            assert(x == 1);
        }

        /*
        #specific register constraints

            If you look at the generated assembly code,
            you will see that x was put into `eax`.
        */
        {
            volatile int x = 0;
            asm (
                "incl %0"
                : "=a" (x)
                : "0" (x)
            );
            assert(x == 1);
        }
#endif

    /*
    #typeof

        Like C++11 decltype.
    */
    {
        typeof(1 + 0.5) j = 0.5;
        assert(j == 0.5);
    }

    /*
    #range notation
    */
    {
        /* case */
        {
            int i = 1;
            switch (i) {
                case 0 ... 2:
                    assert(1);
                break;

                case 3 ... 5:
                    assert(0);
                break;

                default:
                    assert(0);
                break;
            }
        }

        /* intializations */
        {
            int is[] = { [0 ... 2] = 0, [3 ... 5 ] = 1  };
            assert(memcmp(is, &(int[6]){ 0, 0, 0, 1, 1, 1 }, sizeof(typeof(is))) == 0);
        }
    }

    /*
    #zero length arrays

        TODO0 application?
    */
    {
        int is[0];
        int i;
        printf("&is[0] = %p\n", &is[0]);
        printf("&i     = %p\n", &i);

    }

    /*
    #builtin

        Many gcc special functions and macros are prefixed `__builtin_`.
    */
    {
        /*
        #builtin_return_address

            Get address that function will return to after return.

            It seems that it is not possible to jump to a location without assemby:
            <http://stackoverflow.com/questions/8158007/how-to-jump-the-program-execution-to-a-specific-address-in-c>

            This is most useful for debugging.
        */
        {
            builtin_return_address_test();
        }

        /*
        #builtin_constant_p()

            Returns true iff gcc could determine that the given expression is constant,
            to decide if compile time optimizations may be done or not.

            Gcc is not smart enough to decide all cases correctly.

            TODO0 what is a compile time constant? How to use this?
        */
        {
            assert(__builtin_constant_p(1));
            assert(__builtin_constant_p(1 + 1));

            /*TODO0 why does thie fail?*/
            /*const int i = 0;*/
            /*assert(! __builtin_constant_p(i));*/
        }

        /*
        #builtin_expect

            Basis for the `likely` and `unlikely` macros used extensively on the Linux kernel to help with branch prediction:

                #define likely(x)	__builtin_expect(!!(x), 1)
                #define unlikely(x)	__builtin_expect(!!(x), 0)

            TODO0 why the double negation?

            Says that we expect the left side expression and the right side long value to be the same almost always.
        */
        {
            int x = 0;
            int y;
            if (__builtin_expect(x, 0))
                y = 1;
            if (x == 0)
                y = 1;
            assert(y == 1);
        }

        /*
        #builtin_prefetch

            Pulls data into cache shortly before it is needed.

            Signature:

                void __builtin_prefetch(const void *addr, ...);

            - addr: The address of the data
            - rw:

                Second optional argument.

                Indicates whether the data is being pulled in for Read or preparing for a Write operation

                - 0 = r (default)
                - 1 = w

            - locality:

                Degree of temporal locality of variable.

                Third optional argument.

                Integer in [0,3] range.

                - 0 means no temporal locality, so it can be removed from cache immediately after use.
                - 3 means very high temporal locality, should stay on the cache afterwards.

                3 is the default value.

            I could not manage to make GCC generate different assembly output in the two cases.
        */
        {
            int j = 1;

            get_cache_dirty();
            __builtin_prefetch(&j, 0, 0);
            assert(j == 1);

            get_cache_dirty();
            assert(j == 1);
        }
    }

    return EXIT_SUCCESS;
}
