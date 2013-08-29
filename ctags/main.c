//there is nothing that can be done for the processor:
//all defines must be taken into account as separate definitions!
#ifdef ZERO
    int pre = 0;
#else
    int pre = 1;
#endif

//define macros are on by default
#define MACRO_VAL 0

#define MACRO_DEF(x) int x;
//wow, GNU ctags 5.9 is smart enough to put macro_def
MACRO_DEF(macro_def);

//but it is not smart enough for this:
#define MACRO_ID(x) x
int MACRO_ID(macro_id);
MACRO_ID(int) macro_id_2;

int i_global;

//statics are on by default
static int i_global_static;

struct s;

struct s
{
    //struct, union and class members are on by default
    int s_a;
    int s_b;
} so;

//externs are out by default
extern int i_global_extern;

//forward declaration are out by default
void func();

void func(){}

int main()
{
    //locals are off by default
    int main_local;
}
