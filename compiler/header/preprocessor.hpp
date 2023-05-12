#pragma once

#include <string>
#include <fstream>

#include <exception.hpp>

std::string preprocess(std::string raw) {
    std::string output = "";

    for (int i = 0; i < raw.size(); i++) {
        if (raw[i] == '#' && (i == 0 || raw[i - 1] == '\n')) {
            if (raw.substr(i + 1, 7) == "include") {
                int end = raw.substr(i + 9).find('\n');
                std::string path = raw.substr(i + 9, end);
                std::ifstream file(path);
                while (!file.eof()) {
                    char c;
                    if (!file.read(&c, sizeof(char))) break;
                    output += c;
                }
                i = end + 8;
            }
            else {
                throw UnknownPreProcKeyword();
            }
        }
        else output += raw[i];
    }

    return output;
}