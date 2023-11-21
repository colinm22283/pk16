#pragma once

#include "eval_regex.hpp"

std::string move_add(std::string & src, std::string & dest, eval_info_t & eval_info) {
    if (std::regex_search(src, number_regex)) {
        std::cout << "Immediate Add:\n";
        std::cout << "\tValue: " << src << "\n";
        std::cout << "\tDestination: " << dest << "\n";
    
        eval_reg_t & dst_reg = eval_info.get_reg(dest);
        if (!dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is not set when being move added to");

        return std::string("adi ") + dst_reg.name + ", " + src + "\n";
    }
    else {
        std::cout << "Move Add:\n";
        std::cout << "\tSource: " << src << "\n";
        std::cout << "\tDestination: " << dest << "\n";

        eval_reg_t & dst_reg = eval_info.get_reg(dest);

        try {
            eval_reg_t & src_reg = eval_info.get_reg(src);
            if (!dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is not set when being move added to");
            if (!src_reg.in_use) throw std::runtime_error("Register \"" + src + "\" is not set when being move added from");
            
            src_reg.in_use = false;
            dst_reg.in_use = true;

            return std::string("add ") + dst_reg.name + ", " + src_reg.name + "\n";
        }
        catch (std::exception & e) {
            if (!dst_reg.in_use) throw std::runtime_error("Register \"" + dest + "\" is not set when being move added to");
            dst_reg.in_use = true;
            return std::string("adi ") + dst_reg.name + ", " + src + "\n";
        }
    }
}