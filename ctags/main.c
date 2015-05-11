#include <assert.h>
#include <stdio.h>

#include "a.h"

/* Macros */

/* There is nothing that can be done for the processor: */
/* all defines must be taken into account as separate definitions! */
#ifdef ZERO
    int pre = 0;
#else
    int pre = 1;
#endif

/* Define macros are on by default. */
#define MACRO_VAL 0

#define MACRO_DEF(x) int x;
/* Wow, GNU ctags 5.9 is smart enough to put macro_def. */
MACRO_DEF(macro_def)

/* But it is not smart enough for this. */
#define MACRO_ID(x) x
int MACRO_ID(macro_id);
MACRO_ID(int) macro_id_2;

/* Statics are on by default. */
static int is;

/* Declarations are off by default, only definitions. */
extern int i;
struct s;
void f();
void f(int);

/* Global definitions are on by default. */

    int i = 0;

    struct s {
        /* struct, union and class members are on by default */
        int sa;
        int sb;
    } so;

    /*void f(){}*/

int main() {
    /* Locals are off by default. */
    int l;
    struct s s0;

    l = 1;
    assert(l);

    is = 1;
    assert(is);

    s0.sa = 1;
    s0.sb = 2;
    assert(s0.sa);
    assert(s0.sb);

    puts("ALL ASSERTS PASSED");
    return 0;
}
