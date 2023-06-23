#include <string>
#include <fstream>

#include "compiler.hpp"

void Compiler::write(std::string path) {
    std::ofstream file(path);

    std::cout << "OUTPUT\n";
    for (std::size_t i = 0; i < symbol_table.symbols.size(); i++) {
        std::string temp = symbol_table.symbols[i].to_asm();
        std::cout << temp;
        file << temp;
    }
}