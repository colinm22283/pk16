#pragma once

#include <iostream>
#include <stack>

#include "symbol_table.hpp"
#include "types.hpp"
#include "label_gen.hpp"

struct eval_reg_t {
    std::string name;
    bool in_use = false;
    std::vector<std::string> aliases;
};

enum scope_type_t {
    ST_LOOP,
    ST_WHILE_LT,
    ST_WHILE_GT,
    ST_WHILE_EQ,
    ST_WHILE_NE,
};
struct scope_t {
    std::string start_label;
    std::string end_label;
    scope_type_t type;
    std::vector<bool> regs_used = { false, false, false, false, false, false, false, false };
};

struct eval_info_t {
    std::vector<eval_reg_t> regs = {
        {
            .name = "a",
            .aliases = { "return", },
        },
        {
            .name = "b",
        },
        {
            .name = "c",
        },
        {
            .name = "d",
        },
        {
            .name = "e",
        },
        {
            .name = "f",
        },
        {
            .name = "stp",
        },
        {
            .name = "pc",
        },
    };

    std::stack<scope_t> scopes;
    LabelGenerator label_gen;

    inline eval_reg_t & get_reg(std::string str) {
        if (str == "a") return regs[0];
        else if (str == "b") return regs[1];
        else if (str == "c") return regs[2];
        else if (str == "d") return regs[3];
        else if (str == "e") return regs[4];
        else if (str == "f") return regs[5];
        else if (str == "stp") return regs[6];
        else if (str == "pc") return regs[7];
        else {
            for (int i = 0; i < regs.size(); i++) {
                for (int j = 0; j < regs[i].aliases.size(); j++) {
                    if (str.substr(0, regs[i].aliases[j].size()) == regs[i].aliases[j]) return regs[i];
                }
            }

            throw std::runtime_error("Unknown register alias \"" + str + "\"");
        }
    }

    inline eval_reg_t & get_unused() {
        for (int i = regs.size() - 3; i >= 0; i--) {
            if (!regs[i].in_use) return regs[i];
        }

        throw std::runtime_error("Unable to find empty register");
    }

    inline void invalidate_all() {
        for (int i = 0; i < regs.size() - 2; i++) {
            regs[i].in_use = false;
            regs[i].aliases = { };
        }
        regs[0].aliases = { "return" };
    }
};

class Compiler {
protected:
public:
    SymbolTable symbol_table;
    TypeRegistry type_reg;

public:
    void add_source_file(std::string path);
    void write(std::string path);
    std::string evaluate(std::string & line, eval_info_t & eval_info);

    inline void print_symbols() {
        std::cout << "Symbols: " << symbol_table.symbols.size() << "\n";

        for (std::size_t i = 0; i < symbol_table.symbols.size(); i++) {
            std::cout << "\tSymbol: \n";
            
            std::cout << "\t\tContent: ";
            std::cout << symbol_table.symbols[i].content;
            std::cout << "\n";
        }
    }
};