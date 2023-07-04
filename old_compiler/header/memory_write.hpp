#pragma once

#include "eval_regex.hpp"

std::string memory_write(std::string & src, std::string & dst, int size, bool incrementing, bool moving, eval_info_t & eval_info) {
    eval_reg_t & dst_reg = eval_info.get_reg(dst);
    eval_reg_t & src_reg = eval_info.get_reg(src);

    if (!src_reg.in_use) throw std::runtime_error("Register \"" + src + "\" must be in use when writing from it");
    if (!dst_reg.in_use) throw std::runtime_error("Register \"" + dst + "\" must be in use when writing to its address");

    dst_reg.in_use = true;
    if (moving) src_reg.in_use = false;

    switch (size) {
        case 1: {
            if (incrementing) {
                return "wrl " + dst_reg.name  + ", " + src_reg.name + "\nadi " + dst_reg.name + ", 1\n";
            }
            else {
                return "wrl " + dst_reg.name  + ", " + src_reg.name + "\n";
            }
        } break;
        case 2: {
            if (incrementing) {
                return "wr  " + dst_reg.name  + ", " + src_reg.name + "\nadi " + dst_reg.name + ", 1\n";
            }
            else {
                return "wr  " + dst_reg.name  + ", " + src_reg.name + "\nsbi " + dst_reg.name + ", 1\n";
            }
        } break;
        default: throw std::runtime_error("Invalid read size '" + std::to_string(size) + "'");
    }
}