#pragma once

#include <string>
#include <vector>

inline std::vector<std::string> parse_lines(std::string & input) {
    std::vector<std::string> lines;
    std::string line;
    for (std::size_t i = 0; i < input.size(); i++) {
        if (input[i] == '\n') {
            lines.push_back(line);
            line = "";
        }
        else line += input[i];
    }
    lines.push_back(line);

    return lines;
}