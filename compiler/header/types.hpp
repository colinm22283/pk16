#pragma once

#include <cstdint>
#include <vector>
#include <string>
#include <regex>

#include "compiler_exceptions.hpp"

struct var_type_t {
    std::size_t size;
    std::vector<std::size_t> sub_sizes;
};

class TypeRegistry {
public:
    struct entry_t {
        std::string name;
        var_type_t type;
    };

    std::vector<entry_t> types = {
        {
            .name = "u8",
            .type = {
                .size = 1,
            }
        },
        {
            .name = "u16",
            .type = {
                .size = 2,
            }
        },
    };

    inline var_type_t & lookup(std::string _name) {
        std::smatch matches;
        std::regex_match(_name, matches, std::regex("^ *([a-zA-Z_][a-zA-Z_0-9]*)[ *]*$"));

        std::string name = matches[1].str();

        for (std::size_t i = 0; i < types.size(); i++) {
            if (types[i].name == name) return types[i].type;
        }
        throw Exceptions::UnknownTypeException(std::move(name));
    }

    inline void add(std::string name, std::size_t size, std::vector<std::size_t> sub_sizes = { }) {
        types.push_back({
            .name = name,
            .type = {
                .size = size,
                .sub_sizes = sub_sizes,
            },
        });
    };
};