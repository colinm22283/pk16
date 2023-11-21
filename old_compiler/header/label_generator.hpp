#pragma once

#include <string>
#include <mutex>

class LabelGenerator {
protected:
    std::mutex mutex;
    unsigned long current_number = 0;

public:
    inline std::string get_label() {
        std::lock_guard<std::mutex> lock(mutex);

        return ".L" + std::to_string(current_number++);
    }
};

extern LabelGenerator label_generator;