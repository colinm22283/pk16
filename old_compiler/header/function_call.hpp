#pragma once

#include "eval_regex.hpp"

std::string function_call(std::string & name, eval_info_t & eval_info) {
    eval_info.invalidate_all();
    eval_reg_t & unused_reg = eval_info.get_unused();

    return std::string("imm ") + unused_reg.name + ", " + name + "\ncal " + unused_reg.name + "\n";
}