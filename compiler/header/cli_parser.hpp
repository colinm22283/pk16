#pragma once

#include <vector>
#include <string>
#include <exception>
#include <stdexcept>

#include <config.hpp>

struct cli_args_results_t {
    config_t config;
    std::vector<std::string> in_files;
};

inline cli_args_results_t parse_cli_args(int argc, const char ** argv) {
    cli_args_results_t results;

    for (int i = 1; i < argc; i++) {
        if (argv[i][0] == '-') {
            char opt = argv[i][1];
            switch (opt) {
                case 'o': results.config.out_file = argv[++i]; break;
                default: throw std::runtime_error("Unknown option \"" + std::string(argv[i]) + "\"");
            }
        }
        else {
            results.in_files.emplace_back(argv[i]);
        }
    }

    return results;
}