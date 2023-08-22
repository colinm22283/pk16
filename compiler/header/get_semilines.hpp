#pragma once

#include <vector>
#include <string>

inline std::vector<std::string> get_semilines(std::string input) {
    std::vector<std::string> lines;
    std::string line;
    for (std::size_t i = 0; i < input.size(); i++) {
        if (input[i] == ';' || input[i] == '{') {
            std::smatch matches;
            std::regex_match(line, matches, std::regex("^\\s*(.*)\\s*$"));
            lines.push_back(matches[1]);
            line = "";
        }
        else if (input[i] == '}') {
            std::smatch matches;
            std::regex_match(line, matches, std::regex("^\\s*(.*)\\s*$"));
            lines.push_back(matches[1]);
            lines.emplace_back("}");
            line = "";
        }
        else line += input[i];
    }
    std::smatch matches;
    std::regex_match(line, matches, std::regex("^\\s*(.*)\\s*$"));
    lines.push_back(matches[1]);

    return lines;
}