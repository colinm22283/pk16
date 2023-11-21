#include <fstream>
#include <iostream>
#include <regex>
#include <cstring>

#include "compiler.hpp"
#include "compiler_exceptions.hpp"
#include "lines.hpp"
#include "trim.hpp"

std::regex struct_regex("^ *struct *([a-zA-Z_][a-zA-Z_0-9]*) *$");
std::regex variable_regex("^ *([a-zA-Z_][a-zA-Z_0-9]* )? *([a-zA-Z_][a-zA-Z_0-9]*(?: *\\*)*) +([a-zA-Z_][a-zA-Z_0-9]*)(?: *= *(?:(?:\"(.*)\")|([0-9]*)|(?: *\\[ *(\\d*(?: *, *\\d*)*) *\\] *)))? *$");
std::regex function_regex("^ *def ([a-zA-Z_]\\w*) *\\( *((?:\\w*)?(?:, *\\w*)*) *\\) *$");

void Compiler::add_source_file(std::string path) {
    std::ifstream file(path);

    if (!file.is_open()) throw Exceptions::FileOpenException(std::move(path));

    std::string content;
    file.seekg(0, std::ios::end);
    content.resize(file.tellg());
    file.seekg(0, std::ios::beg);
    for (std::size_t i = 0; true; i++) {
        char buf;
        if (!file.read(&buf, sizeof(char))) break;
        content[i] = buf;
    }

    std::vector<std::string> lines = std::move(to_lines(content));

    for (std::size_t i = 0; i < lines.size(); i++) {
        std::string & line = lines[i];

        trim_string(line);
        std::cout << line << "\n";

        std::smatch matches;

        if (std::regex_search(line, matches, struct_regex)) { // is_struct
            std::cout << "Struct:\n";

            std::size_t size = 0;
            std::vector<std::size_t> sizes;

            std::cout << "\tName: " << matches[1].str() << "\n";
            
            std::cout << "\tMembers:\n";
            std::string & _line = lines[++i];

            if (_line.substr(0, 1) != "{") throw std::runtime_error(std::string("Struct requires opening bracket, instead got") + _line);

            _line = lines[++i];

            while (_line.substr(0, 1) != "}") {
                std::cout << "\t\tMember:\n";
                std::smatch _matches;
                if (std::regex_search(_line, _matches, variable_regex)) {
                    if (_matches[4].length() == 0 && _matches[5].length() == 0) {
                        std::cout << "\t\t\tType: " << _matches[2].str() << "\n";
                        std::cout << "\t\t\tName: " << _matches[3].str() << "\n";
                        size += type_reg.lookup(_matches[2].str()).size;
                        sizes.push_back(type_reg.lookup(_matches[2].str()).size);
                    }
                    else throw std::runtime_error(std::string("Invalid struct member: ") + _line);


                }
                else throw std::runtime_error(std::string("Invalid struct member: ") + _line);

                _line = lines[++i];
            }

            type_reg.add(matches[1].str(), size, sizes);
        }
        else if (std::regex_search(line, matches, variable_regex)) {// is variable
            std::cout << "Variable:\n";

            SymbolTable::symbol_t symbol;

            if (matches[1].str().find("const ") != std::string::npos) {
                std::cout << "\tLocation: ROM\n";
                symbol.is_rom = true;
            }
            else {
                std::cout << "\tLocation: RAM\n";
                symbol.is_rom = false;
            }

            symbol.type = type_reg.lookup(matches[2].str());
            symbol.name = matches[3].str();

            if (matches[4].length() == 0 && matches[5].length() == 0 && matches[6].length() == 0) { // no def
                std::cout << "\tNo value\n";

                if (symbol.is_rom) throw std::runtime_error("Constant variables must contain a value");

                
            } else {
                std::cout << "\tHas value\n";

                if (matches[4].length() != 0) { // is string
                    std::cout << "\tValue: " << matches[4].str() << "\n";

                    symbol.content = std::string("#d \"") + matches[4].str() + "\\0\"\n";

                    symbol_table.add(symbol);
                }
                else if (matches[5].length() != 0) { // is number
                    std::cout << "\tValue: " << matches[5].str() << "\n";

                    symbol.content = std::string("#d") + std::to_string(symbol.type.size * 8) + " " + matches[5].str() + "\n";

                    symbol_table.add(symbol);
                }
                else { // is init list
                    std::cout << "\tValue: [ " << matches[6].str() + " ]\n";

                    var_type_t & vtype = type_reg.lookup(matches[2].str());

                    std::string current = "";
                    int k = 0;
                    for (std::size_t j = 0; j < matches[6].length(); j++) {
                        if (matches[6].str()[j] == ',') {
                            uint16_t value = std::stoi(current);

                            symbol.content += std::string("#d") + std::to_string(vtype.sub_sizes[k] * 8) + " " + std::to_string(value) + "\n";

                            current = "";
                            k++;
                        }
                        else if (matches[6].str()[j] != ' ') {
                            current += matches[6].str()[j];
                        }
                    }
                    symbol.content += std::string("#d") + std::to_string(vtype.sub_sizes[k] * 8) + " " + std::to_string(std::stoi(current)) + "\n";

                    symbol_table.add(symbol);
                }
            }
        }
        else if (std::regex_search(line, matches, function_regex)) {
            std::cout << "Function:\n";

            SymbolTable::symbol_t symbol;
            symbol.is_rom = true;
            symbol.type = type_reg.lookup("u16");

            std::string name = matches[1].str();
            std::cout << "\tName: " << name << "\n";

            std::vector<std::string> args;

            if (matches[2].length() != 0) {
                std::string args_str = matches[2].str();
                while (true) {
                    std::size_t pos = args_str.find(',');
                    if (pos == std::string::npos) {
                        args.push_back(args_str);
                        break;
                    }

                    args.push_back(args_str.substr(0, pos));

                    args_str.erase(0, pos + 1);
                    trim_string(args_str);
                }
            }

            symbol.name = name;
            symbol.content = "";

            eval_info_t eval_info;
            
            for (int j = 0; j < args.size(); j++) {
                std::cout << "\t Arg: " << args[j] << "\n";
                eval_info.regs[j].aliases.push_back(args[j]);
                eval_info.regs[j].in_use = true;
            }

            i++;
            for (std::string & _line = lines[++i]; _line.substr(0, 1) != "}" || eval_info.scopes.size() != 0; _line = lines[++i]) {
                symbol.content += evaluate(_line, eval_info);
            }
            symbol.content += "pop f\njmp f\n";

            symbol_table.add(symbol);
        }
    }
}