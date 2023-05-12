#pragma once

#include <string>
#include <vector>

enum symbol_type_t {
    INLINE_FUNCTION,
    FUNCTION,
    STRUCT,
    ENUM
};

struct symbol_t {
    symbol_type_t type;
    std::string name;
    std::string content;
};

std::vector<std::string> symbolize(std::string input) {
    std::string line = "";

    for (int i = 0; i < input.size(); i++) {
        if (input[i] == ';') {
            if (line.starts_with("function")) {

            }
            else if (line.starts_with("inline")) {

            }
            // TODO: add struct and enum

            line = "";
        }
        else if (input[i] != '\n') line += input[i];
    }
}