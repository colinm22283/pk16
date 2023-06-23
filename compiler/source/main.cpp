#include <iostream>

#include "compiler.hpp"

int main(int argc, const char ** argv) {
    try {
        Compiler compiler;

        for (int i = 1; i < argc - 1; i++) compiler.add_source_file(argv[i]);

        compiler.print_symbols();

        compiler.write(argv[argc - 1]);
    }
    catch (std::exception & e) {
        std::cerr << "Error: " << e.what() << "\n";
    }
}