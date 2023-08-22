#pragma once

#include <vector>

#include <symbol.hpp>

struct SymbolTable {
    std::vector<callable_symbol_t> callable;
    std::vector<rom_symbol_t> rom;
    std::vector<ram_symbol_t> ram;
    std::vector<uninit_symbol_t> uninit;

    inline bool symbol_exists(const std::string & name) {
        for (auto & s : callable) if (s.name == name) return true;
        for (auto & s : rom) if (s.name == name) return true;
        for (auto & s : ram) if (s.name == name) return true;
        for (auto & s : uninit) if (s.name == name) return true;
        return false;
    }
};