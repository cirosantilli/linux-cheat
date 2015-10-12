/**
@file

This file appears on the "File" section because of this comment.
*/

#include "main.h"

namespace MainNamespace {
    Main::Main() {}

    Main::Main(const Main& m) {}

    Main2 Main::method(Main2& m2) {
        m2.method();
        this->method2();
        this->privateMethod();
    }

    void Main::method2() {
    }

    void Main::privateMethod() {}
}

int main(int argc, char** argv) {}
