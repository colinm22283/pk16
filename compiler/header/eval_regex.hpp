#pragma once

#include <regex>

std::regex var_set_regex("^ *(\\w*) *= *([^=]*)$");
std::regex var_move_regex("^ *(\\w*) *<= *([^=]*)$");
std::regex register_regex("^[a-f]|(?:stp)|(?:pc)$");
std::regex number_regex("^[0-9]*$");

std::regex function_call_regex("^ *([a-zA-Z_][a-zA-Z_0-9]*)\\(\\)$");

std::regex alias_regex("^ *alias *([a-zA-Z_][a-zA-Z_0-9]*) *([a-zA-Z_][a-zA-Z_0-9]*)$");

std::regex loop_regex("^ *loop *$");
std::regex while_regex("^while *([a-zA-Z_]\\w*) *([<>]|(?:==)|(?:!=)) *([a-zA-Z_]\\w*) *$");
std::regex break_regex("^break *$");

std::regex use_regex("^ *use *([a-zA-Z_][a-zA-Z_0-9]*) *$");
std::regex forget_regex("^ *forget *([a-zA-Z_][a-zA-Z_0-9]*) *$");

std::regex move_add_regex("^ *(\\w*) *<\\+ *([^=]*)$");
std::regex copy_add_regex("^ *(\\w*) *\\+ *([^=]*)$");

std::regex memory_read_regex("^([a-zA-Z_]\\w*) *(\\^?)<?(_+) *([a-zA-Z_]\\w*) *$");
std::regex memory_write_regex("^([a-zA-Z_]\\w*) *(_+)(>?)(\\^?) *([a-zA-Z_]\\w*) *$");