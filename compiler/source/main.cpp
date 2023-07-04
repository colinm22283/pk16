#include <iostream>

#include <cli_parser.hpp>
#include <compiler.hpp>

int main(int argc, const char ** argv) {
    auto cli_config = parse_cli_args(argc, argv);

    std::vector<Compiler> compilers;
    compilers.reserve(cli_config.in_files.size());
    for (auto & file : cli_config.in_files) {
        compilers.emplace_back(cli_config.config, file);
    }
}