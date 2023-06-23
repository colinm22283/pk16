#pragma once

#include <string>
#include <vector>
#include <regex>

inline std::vector<std::string> to_lines(std::string str) {
    std::vector<std::string> lines;
    std::string current = "";

    bool ignoring = false;

    for (std::size_t i = 0; i < str.size(); i++) {
        if (ignoring) { // in a comment
            if (str[i] == '\n') ignoring = false;
        }
        else {
            if (str[i] == '/' && str[i + 1] == '/') ignoring = true;
            else if (str[i] == ';') {
                if (current != "") {
                    lines.push_back(current);
                    current = "";
                }
            }
            else if (str[i] == '{' || str[i] == '}') {
                std::smatch matches;
                if (std::regex_match(current, matches, std::regex(".*[^ ].*"))) {
                    lines.push_back(current);
                }
                lines.push_back(std::string() + str[i]);
                current = "";
            }
            else if (str[i] == '\n' || str[i] == '\t') current += ' ';
            else current += str[i];
        }
    }

    return lines;
}