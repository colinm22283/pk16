#pragma once

#include <string>
#include <vector>
#include <algorithm>
#include <cstdint>

#include "types.hpp"

class SymbolTable {
public:
    struct symbol_t {
        std::string name;
        std::string content;
        var_type_t type;
        bool is_rom;

        inline symbol_t() { }
        inline symbol_t(std::string && _name): name(std::move(_name)) { }

        inline std::string to_asm() {
            if (is_rom) {
                std::string out = "#bank rom\n";
                
                out += name + ":\n";
                out += content + "\n";

                return out;
            } else {
                std::string out = "#bank ram\n";
                out += name + ":\n";
                out += "#res \n" + type.size;
                return out;
            }
        }
    };

    std::vector<symbol_t> symbols;

    inline symbol_t & add(std::string sym_name) {
        return symbols.emplace_back(std::move(sym_name));
    }
    inline void add(symbol_t sym_name) {
        symbols.push_back(sym_name);
    }
};