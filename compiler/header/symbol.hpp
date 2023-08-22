#pragma once

#include <string>

struct callable_symbol_t {
    std::string name;
    std::string assembled;
    bool external;
    bool returns;
};

struct rom_symbol_t {
    std::string name;
    std::string value;
    int size;
};

struct ram_symbol_t {
    std::string name;
    std::string value;
    int size;
    bool has_value;
    bool is_string;
};

struct uninit_symbol_t {
    std::string name;
};
