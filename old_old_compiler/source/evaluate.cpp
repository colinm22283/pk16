#include "compiler.hpp"
#include "trim.hpp"

#include "register_copy.hpp"
#include "register_move.hpp"
#include "function_call.hpp"
#include "move_add.hpp"
#include "copy_add.hpp"
#include "memory_read.hpp"
#include "memory_write.hpp"

std::string Compiler::evaluate(std::string & _line, eval_info_t & eval_info) {
    std::string line = _line;
    trim_string(line);

    std::smatch matches;

    if (line.substr(0, 1) == "{") return "";
    else if (std::regex_match(line, matches, var_set_regex)) { // variable set
        if (matches[1].length() != 0 && matches[2].length() != 0) {
            std::string dest = matches[1].str();
            std::string src = matches[2].str();
            
            return register_copy(src, dest, eval_info);
        }
    }
    else if (std::regex_match(line, matches, var_move_regex)) { // variable move
        if (matches[1].length() != 0 && matches[2].length() != 0) {
            std::string dest = matches[1].str();
            std::string src = matches[2].str();
            
            return register_move(src, dest, eval_info);
        }
    }
    else if (std::regex_match(line, matches, function_call_regex)) { // function call
        if (matches[1].length() != 0) {
            std::string name = matches[1].str();
            
            return function_call(name, eval_info);
        }
    }
    else if (std::regex_match(line, matches, alias_regex)) { // alias
        if (matches[1].length() != 0 && matches[2].length() != 0) {
            std::string name = matches[1].str();
            std::string _reg = matches[2].str();

            std::cout << "Alias:\n";
            std::cout << "\tName: " << name << "\n";
            std::cout << "\tRegister: " << _reg << "\n";
            
            eval_reg_t & reg = eval_info.get_reg(_reg);
            reg.aliases.push_back(name);

            return "";
        }
        else throw std::runtime_error("Invalid alias \"" + line + "\"");
    }
    else if (std::regex_match(line, matches, loop_regex)) { // loop
        std::string out;

        scope_t scope = {
            .start_label = eval_info.label_gen.generate(),
            .end_label = eval_info.label_gen.generate(),
            .type = ST_LOOP,
        };

        for (int i = 0; i < 8; i++) {
            scope.regs_used[i] = eval_info.regs[i].in_use;
        }
        
        out += scope.start_label + ":\n";

        eval_info.scopes.push(scope);

        return out;
    }
    else if (line.substr(0, 1) == "}") { // end scope loop
        std::string out;

        scope_t & scope = eval_info.scopes.top();

        for (int i = 0; i < 8; i++) {
            if (scope.regs_used[i] != eval_info.regs[i].in_use) {
                std::string temp = "\n\tname, before, after";

                for (int j = 0; j < 8; j++) {
                    temp += "\n\t" + eval_info.regs[j].name + ", " + (scope.regs_used[j] ? "Used" : "Unused") + ", " + (eval_info.regs[j].in_use ? "Used" : "Unused");
                }

                throw std::runtime_error("Register usage must be identical at start and end of loop:" + temp);
            }
        }
        
        switch (scope.type) {
            case ST_LOOP: {
                eval_reg_t & reg = eval_info.get_unused();
                out += "imm " + reg.name + ", " + scope.start_label + "\n";
                out += "jmp " + reg.name + "\n";
            } break;

            case ST_WHILE_LT: {
                eval_reg_t & reg = eval_info.get_unused();
                out += "imm " + reg.name + ", " + scope.start_label + "\n";
                out += "jlt " + reg.name + "\n";
            } break;
            case ST_WHILE_GT: {
                eval_reg_t & reg = eval_info.get_unused();
                out += "imm " + reg.name + ", " + scope.start_label + "\n";
                out += "jgt " + reg.name + "\n";
            } break;
            case ST_WHILE_EQ: {
                eval_reg_t & reg = eval_info.get_unused();
                out += "imm " + reg.name + ", " + scope.start_label + "\n";
                out += "je  " + reg.name + "\n";
            } break;
            case ST_WHILE_NE: {
                eval_reg_t & reg = eval_info.get_unused();
                out += "imm " + reg.name + ", " + scope.start_label + "\n";
                out += "jne " + reg.name + "\n";
            } break;
        }
        
        out += scope.end_label + ":\n";

        eval_info.scopes.pop();

        return out;
    }
    else if (std::regex_match(line, matches, use_regex)) {
        if (matches[1].length() != 0) {
            if (eval_info.get_reg(matches[1].str()).in_use) throw std::runtime_error("Register \"" + matches[1].str() + "\" is already in use");
            eval_info.get_reg(matches[1].str()).in_use = true;
        }
        else throw std::runtime_error("Invalid use statement");
    }
    else if (std::regex_match(line, matches, forget_regex)) {
        if (matches[1].length() != 0) {
            if (!eval_info.get_reg(matches[1].str()).in_use) throw std::runtime_error("Register \"" + matches[1].str() + "\" must be in use");
            eval_info.get_reg(matches[1].str()).in_use = false;
        }
        else throw std::runtime_error("Invalid forget statement");
    }
    else if (std::regex_match(line, matches, move_add_regex)) {
        if (matches[1].length() != 0 && matches[2].length() != 0) {
            std::string dest = matches[1].str();
            std::string src = matches[2].str();
            
            return move_add(src, dest, eval_info);
        }
        else throw std::runtime_error("Invalid move add statement");
    }
    else if (std::regex_match(line, matches, copy_add_regex)) {
        if (matches[1].length() != 0 && matches[2].length() != 0) {
            std::string dest = matches[1].str();
            std::string src = matches[2].str();
            
            return copy_add(src, dest, eval_info);
        }
        else throw std::runtime_error("Invalid move add statement");
    }
    else if (std::regex_match(line, matches, while_regex)) {
        if (matches[1].length() != 0 && matches[2].length() != 0 && matches[3].length() != 0) {
            std::string cma = matches[1].str();
            std::string op = matches[2].str();
            std::string cmb = matches[3].str();
            
            std::string out;

            scope_t scope = {
                .start_label = eval_info.label_gen.generate(),
                .end_label = eval_info.label_gen.generate(),
            };

            if (op == "<") scope.type = ST_WHILE_LT;
            else if (op == ">") scope.type = ST_WHILE_GT;
            else if (op == "==") scope.type = ST_WHILE_EQ;
            else if (op == "!=") scope.type = ST_WHILE_NE;

            for (int i = 0; i < 8; i++) {
                scope.regs_used[i] = eval_info.regs[i].in_use;
            }
            
            eval_reg_t & cma_reg = eval_info.get_reg(cma);

            if (!cma_reg.in_use) throw std::runtime_error("cma value must be in use when defining while loop");

            out += "cma " + cma_reg.name + "\n";
            out += "cmb " + eval_info.get_reg(cmb).name + "\n";
            out += scope.start_label + ":\n";

            eval_info.scopes.push(scope);

            return out;
        }
        else throw std::runtime_error("Invalid while statement");
    }
    else if (std::regex_match(line, matches, memory_read_regex)) {
        if (matches[1].length() != 0 && matches[3].length() != 0 && matches[4].length() != 0) {
            std::string dst = matches[1].str();
            bool incrementing = matches[2].length() > 0;
            int size = matches[3].length();
            std::string src = matches[4].str();

            return memory_read(src, dst, size, incrementing, eval_info);
        }
        else throw std::runtime_error("Invalid memory read statement");
    }
    else if (std::regex_match(line, matches, memory_write_regex)) {
        if (matches[1].length() != 0 && matches[2].length() != 0 && matches[5].length() != 0) {
            std::string src = matches[1].str();
            int size = matches[2].length();
            bool moving = matches[3].length() > 0;
            bool incrementing = matches[4].length() > 0;
            std::string dst = matches[5].str();

            return memory_write(src, dst, size, incrementing, moving, eval_info);
        }
        else throw std::runtime_error("Invalid memory read statement");
    }
    else if (std::regex_match(line, matches, break_regex)) {
        eval_reg_t & reg = eval_info.get_unused();
        return "imm " + reg.name + ", " + eval_info.scopes.top().end_label + "\njmp " + reg.name + "\n";
    }
    else throw std::runtime_error("Unknown expression \"" + line + "\"");

    return "";
}