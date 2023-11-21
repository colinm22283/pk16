#pragma once

#include "eval_regex.hpp"

std::string memory_read(std::string & src, std::string & dst, int size, bool incrementing, eval_info_t & eval_info) {
    eval_reg_t & dst_reg = eval_info.get_reg(dst);
    eval_reg_t & src_reg = eval_info.get_reg(src);

    if (!src_reg.in_use) throw std::runtime_error("Register \"" + src + "\" must be in use when reading from it");
    if (dst_reg.in_use) throw std::runtime_error("Register \"" + dst + "\" must not be in use when reading to it");

    dst_reg.in_use = true;

    switch (size) {
        case 1: {
            if (incrementing) {
                return "ldl " + dst_reg.name  + ", " + src_reg.name + "\nimu " + dst_reg.name + ", 0\nadi " + src_reg.name + ", 1\n";
            }
            else {
                return "ldl " + dst_reg.name  + ", " + src_reg.name + "\nimu " + dst_reg.name + ", 0\n";
            }
        } break;
        case 2: {
            if (incrementing) {
                return "ld  " + dst_reg.name  + ", " + src_reg.name + "\nadi " + src_reg.name + ", 1\n";
            }
            else {
                return "ld  " + dst_reg.name  + ", " + src_reg.name + "\nsbi " + src_reg.name + ", 1\n";
            }
        } break;
        default: throw std::runtime_error("Invalid read size '" + std::to_string(size) + "'");
    }
}