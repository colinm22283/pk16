#pragma once

#include <regex>

static std::regex rom_symbol_regex = std::regex("^const +([a-zA-Z_]\\w*) +([a-zA-Z_]\\w*) *= *(.*)$");
static std::regex ram_symbol_regex = std::regex("^static +([a-zA-Z_]\\w*) +([a-zA-Z_]\\w*)(?: *= *(.*))?$");