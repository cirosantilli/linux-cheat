/**
@file

@brief A file.

# markdown

Markdown list:

- a
- b

# globals

\@file says that this entire file should be docummented.

Without it, global variables, functions, etc in this file would not get documented.

This documents the file.
*/

/**
@brief A global function

Long description.

@tparam T   a class
@tparam N   an int
@tparam TT  a template
@param[in]  arg1 whatever

Not Multiline.

@param[out] arg2 whatever
@param[in]  arg3,arg4 two on the same line
@return 0
@throw           nothing
@see C
*/
template<typedef T, int N, typedef TT<typedef U> typedef V>
int f(int arg1, float *arg2, int arg3, int arg4){
    return 0;
}

/**
@brief A test class.

Long description.
*/
class C
{
    public:

        /**
        @brief A public member

        Long description.
        */
        int publicMember;

        /**
        @brief Default constructor.

        Long description.
        */
        C(){}

        /**
        @brief Copy constructor.

        Long description.
        */
        C(const C& c){}

        /**
        @brief A method

        Long description.
        */
        void method(){}

        /**
        @brief A method

        Reference to another method in the same class: #method
        */
        void method2(){}

    private:

        /**
        @brief A private method.

        Long description.
        */
        void privateMethod(){}
}

int main(int argc, char** argv)
{
}
