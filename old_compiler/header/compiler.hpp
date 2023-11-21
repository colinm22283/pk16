#pragma once

#include <thread>
#include <string>
#include <algorithm>
#include <fstream>

#include <config.hpp>
#include <preprocessor.hpp>
#include <symbol_table.hpp>
#include <regex_patterns.hpp>
#include <get_semilines.hpp>

class Compiler {
protected:
    bool thread_active = true;
    std::thread thread;

    std::string output;
    std::string copy_data;
    SymbolTable symbol_table;

    static void thread_funct(config_t & config, std::string path, SymbolTable & symbol_table, std::string & output, std::string & copy_data) {
        std::ifstream file(path);

        if (!file.is_open()) throw std::runtime_error("Unable to open file \"" + path + "\"");

        std::string input;
        while (true) {
            char c;
            if (!file.read(&c, sizeof(char))) break;
            input += c;
        }

        std::string preprocessed = preprocessor(input);

        if (config.output_preprocessor) {
            std::ofstream out_file(path + ".pp");
            if (!out_file.is_open()) throw std::runtime_error("Unable to open output file \"" + path + ".pp\"");
            out_file << preprocessed;
        }

        std::vector<std::string> lines = get_semilines(preprocessed);

        for (std::size_t i = 0; i < lines.size(); i++) {
            std::string & line = lines[i];

            std::smatch matches;

            if (std::regex_match(line, matches, rom_symbol_regex)) {
                rom_symbol_t sym;

                std::string type_name = matches[1].str();

                if (type_name == "u8") sym.size = 1;
                else if (type_name == "u16") sym.size = 2;
                else if (type_name == "string") sym.size = 0;
                else throw std::runtime_error("Unknown typename \"" + type_name + "\"");

                sym.name = matches[2].str();
                sym.value = matches[3].str();

                symbol_table.rom.push_back(sym);
            }
            else if (std::regex_match(line, matches, ram_symbol_regex)) {
                ram_symbol_t sym;

                std::string type_name = matches[1].str();

                if (type_name == "u8") sym.size = 1;
                else if (type_name == "u16") sym.size = 2;
                else if (type_name == "string") {
                    sym.size = (int) matches[3].length() - 2;
                    sym.is_string = true;
                }
                else throw std::runtime_error("Unknown typename \"" + type_name + "\"");

                sym.name = matches[2].str();
                if (matches[3].length() > 0) sym.value = matches[3].str();
                else sym.has_value = false;

                symbol_table.ram.push_back(sym);
            }
        }

        for (auto & sym : symbol_table.callable) { }
        for (auto & sym : symbol_table.rom) {
            output += sym.name + ": ";
            if (sym.size == 0) output += "#d ";
            else output += "#d" + std::to_string(sym.size * 8) + " ";
            output += sym.value;
            output += "\n";
        }
        for (auto & sym : symbol_table.ram) {
            output += sym.name + ": #res " + std::to_string(sym.size * 8) + "\n";
        }
    }

public:
    inline Compiler() = default;
    inline Compiler(config_t & config, std::string path): thread(
        thread_funct,
        std::ref(config),
        path,
        std::ref(symbol_table),
        std::ref(output)
    ) { }

    inline ~Compiler() {
        if (thread_active) thread.join();
    }

    inline Compiler(Compiler &) = delete;
    inline Compiler(Compiler && x) noexcept: thread(std::move(x.thread)) { }

    inline std::string join() {
        thread.join();
        thread_active = false;
        return output;
    }
};