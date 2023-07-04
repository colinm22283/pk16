#pragma once

inline void trim_string(std::string & str) {
    for (std::size_t i = 0; i < str.size(); i++) {
        if (str[i] != ' ') {
            str.erase(0, i);
            break;
        }
    }
}