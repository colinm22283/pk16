#pragma once

class LabelGenerator {
protected:
    int count = 0;
public:
    inline std::string generate() {
        return std::string(".L") + std::to_string(count++);
    }
};