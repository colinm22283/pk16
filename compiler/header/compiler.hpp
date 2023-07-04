#pragma once

#include <thread>
#include <string>
#include <algorithm>
#include <fstream>

#include <config.hpp>
#include <preprocessor.hpp>

class Compiler {
protected:
    std::thread thread;

    static void thread_funct(config_t & config, std::string path) {
        std::ifstream file(path);

        if (!file.is_open()) throw std::runtime_error("Unable to open file \"" + path + "\"");

        std::string input;
        while (true) {
            char c;
            if (!file.read(&c, sizeof(char))) break;
            input += c;
        }

        std::string preprocessed = preprocessor(input);

        std::cout << preprocessed;
    }

public:
    inline Compiler() = default;
    inline Compiler(config_t & config, std::string path): thread(
        thread_funct,
        std::ref(config),
        path
    ) { }

    inline ~Compiler() {
        thread.join();
    }

    inline Compiler(Compiler &) = delete;
    inline Compiler(Compiler && x) noexcept: thread(std::move(x.thread)) { }
};