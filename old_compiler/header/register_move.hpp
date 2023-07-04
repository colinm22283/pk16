#pragma once

#include "eval_regex.hpp"

std::string register_move(std::string & src, std::string & dest, eval_info_t & eval_info) {
    if (std::regex_search(src, number_regex)) {
        std::cout << "Register Immediate:\n";
        std::cout << "\tValue: " << src << "\n";
        std::cout << "\tDestination: " << dest << "\n";
    
        eval_reg_t & dst_reg = eval_info.get_reg(dest);
        if (dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is already set when being moved to");

        dst_reg.in_use = true;

        return std::string("imm ") + dst_reg.name + ", " + src + "\n";
    }
    else {
        std::cout << "Register Move:\n";
        std::cout << "\tSource: " << src << "\n";
        std::cout << "\tDestination: " << dest << "\n";

        eval_reg_t & dst_reg = eval_info.get_reg(dest);

        try {
            eval_reg_t & src_reg = eval_info.get_reg(src);
            if (&src_reg == &dst_reg) return "";
            if (!src_reg.in_use) throw std::runtime_error("Register \"" + src + "\" is not set when being moved");
            if (dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is already set when being moved to");
            src_reg.in_use = false;
            dst_reg.in_use = true;

            return std::string("mov ") + dst_reg.name + ", " + src_reg.name + "\n";
        }
        catch (std::exception & e) {
            if (dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is already set when being moved to");
            dst_reg.in_use = true;
            return std::string("imm ") + dst_reg.name + ", " + src + "\n";
        }
    }
}