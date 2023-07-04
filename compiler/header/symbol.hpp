#pragma once

#include <string>

struct callable_symbol_t {
    std::string name;
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
};

struct uninit_ram_symbol_t {
    std::string name;
    int size;
};
