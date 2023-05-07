#include <iostream>
#include <fstream>

#include <tree.hpp>

enum component_type_t {
    ROOT,
    ASM,
    IF,
    FUNCTION,
};

struct component_t {
    component_type_t type;

    union {
        struct {
            bool is_inline;
            bool register_usage[6];
        } function;
    };
};

Tree<component_t> tree({ .type = ROOT, });

int main(int argc, char ** argv) {
    if (argc < 2) {
        std::cout << "Not enough arguments!\n";
        return 1;
    }

    std::ifstream file(argv[1]);

    while (!file.eof()) {
        std::string line = "";
        while (true) {
            char read;
            file.read(&read, sizeof(char));

            if (read == ';') {
                break;
            }
            else if (read != '\n') line += read;
        }


    }

    return 0;
}
