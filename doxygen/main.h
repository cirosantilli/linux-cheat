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

#include "main2.h"

namespace MainNamespace {

class Base0 {};
class Base1 : Base0 {};
class Base2 {};

/**
@brief A test class.

Long description.
*/
class Main : Base1, Base2
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
        Main();

        /**
        @brief Copy constructor.

        Long description.
        */
        Main(const Main& m);

        /**
        @brief A method

        Long description.
        */
        Main2 method(Main2& m2);

        /**
        @brief A method

        Reference to another method in the same class: #method
        */
        void method2();

        Main2 m_m2;
        Main2 *m_m2p;

    private:

        /**
        @brief A private method.

        Long description.
        */
        void privateMethod();
};

/**
@brief A global function

Long description.

@p arg2 is a parameter. http://stackoverflow.com/questions/15398711/whats-the-right-way-to-reference-a-parameter-in-doxygen

Main#method is a method in a class.

@tparam T   a class
@tparam N   an int
@tparam TT  a template
@param[in]  arg1 whatever

Not Multiline.

@param[out] arg2 whatever
@param[in]  arg3,arg4 two on the same line
@return 0
@throw           nothing
@see Main2
@see Main2::method
@see Main2#method
*/
template<typename T, template <typename U> class TT, int N >
int globalFunction(int arg1, float *arg2, int arg3, int arg4) {
    return 0;
}

}
