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
#include "stdio.h"
#include "stdlib.h"
#include "math.h"

int nested()
{
	return 0;
}

int main( int argc, char** argv )
{

	//# nested function

        int nested()
        {
            return 1;
        }

        {

            // is a function defined inside another function (the outter function here is `main`)

            // this is not a redefinition because it is inside a parenthesis block
            // much like a variable definition inside a parenthesis block

            int nested()
            {
                return 2;
            }

            //this would cause a redefinition error:

                //int nested()
                //{
                //	return 2;
                //}

            // like variable redefinitions, the nested version overrides all external version
            // which have become completelly innacessible

            assert( nested() == 2 );
        }

	//# preprocessor defines

	    //only gnu extensions are considered here

	    //full list: <http://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros>

        //automatically defined on gcc even if `-std=cXX -pedantic-erors`:

#ifdef __GNUC__
        puts("__GUNC__");
#endif

        //automatically defined if the compiler is told to use strict ansi c features and no extensions
        //this is triggered by options such as `-std=c99` or `-ansi`
        //
        //don't be surprised if this does not appear when compiling this file
        //since strict ansi compliance would mean other features of this file would need
        //to be broken such as nested functions

#ifdef __STRICT_ANSI__
        puts("__STRICT_ANSI__");
#endif

    //#inline assembly

        //sources:
        //- <http://www.ibm.com/developerworks/library/l-ia/index.html>

        {
            int x = 0, y = 1;

            //x = y
            asm (
                "movl %1, %%eax;"
                "movl %%eax, %0;"
                :"=r"(y)	/* `=` means that y is an output. It will be referred to as %0 becuase it is the first arg. */
                :"r"(x)		/* x is input. It is referred to as `%1`. */
                :"%eax"     /* %eax is clobbered register. TODO understand */
            );

            assert( y == 0 );
        }

            /*float result = 0.0;*/
            /*float angle = 3.14;*/
            /*asm( "fsinx %1,%0" : "=f" (result) : "f" (angle) );*/
            /*assert( fabs( result - 0.0 ) < 0.1 );*/

    return EXIT_SUCCESS;
}
