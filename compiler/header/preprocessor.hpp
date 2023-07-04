#pragma once

#include <string>
#include <vector>
#include <regex>
#include <fstream>

#include <parse_lines.hpp>

static std::regex preproc_regex(R"(^\s*#.*$)");
static std::regex include_regex(R"(^\s*#include\s+<\s*([\w\-.]*(?:\/[\w\-.]*)*)\s*>\s*$)");
static std::regex define_regex(R"(^\s*#define\s+([a-zA-Z_]\w*)\s*(.*?)?\s*$)");
static std::regex ifdef_regex(R"(^\s*#ifdef\s+([a-zA-Z_]\w*)\s*$)");
static std::regex ifndef_regex(R"(^\s*#ifndef\s+([a-zA-Z_]\w*)\s*$)");
static std::regex endif_regex(R"(^\s*#endif\s*$)");

constexpr int PREPROCESSOR_MAX_DEPTH = 100;

struct preproc_def_t {
    std::string name;
    std::string value;
};

inline std::string preprocessor_recur(std::string & input, std::vector<preproc_def_t> & defs, int depth) {
    if (depth >= PREPROCESSOR_MAX_DEPTH) throw std::runtime_error("Maximum preprocessor depth reached");

    std::string output;

    auto lines = parse_lines(input);

    int if_level = 0;

    for (std::string & line : lines) {
        if (std::regex_match(line, preproc_regex)) {
            std::smatch matches;

            if (if_level > 0) {
                if (std::regex_match(line, matches, endif_regex)) if_level--;
            }
            else {
                if (std::regex_match(line, matches, include_regex)) {
                    std::string path = matches[1].str();

                    std::ifstream file(path);

                    if (!file.is_open()) throw std::runtime_error("Could not open included file \"" + path + "\"");

                    std::string data;

                    while (true) {
                        char c;
                        if (!file.read(&c, sizeof(char))) break;
                        data += c;
                    }
                    output += preprocessor_recur(data, defs, ++depth) + '\n';
                } else if (std::regex_match(line, matches, define_regex)) {
                    defs.push_back({
                        .name = matches[1].str(),
                        .value = matches[1].str()
                    });
                } else if (std::regex_match(line, matches, ifdef_regex)) {
                    bool defined = false;

                    for (auto & def: defs) {
                        if (def.name == matches[1].str()) {
                            defined = true;
                            break;
                        }
                    }

                    if (!defined) if_level++;
                } else if (std::regex_match(line, matches, ifndef_regex)) {
                    bool defined = false;

                    for (auto & def: defs) {
                        if (def.name == matches[1].str()) {
                            defined = true;
                            break;
                        }
                    }

                    if (defined) if_level++;
                }
                else if (!std::regex_match(line, matches, endif_regex)) throw std::runtime_error("Unknown preprocessor directive \"" + line + "\"");
            }
        }
        else if (if_level == 0) output += line + '\n';
    }

    if (if_level > 0) throw std::runtime_error("Missing #endif");

    return output;
}
inline std::string preprocessor(std::string & input) {
    std::vector<preproc_def_t> defs;
    return preprocessor_recur(input, defs, 0);
}