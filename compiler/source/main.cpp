#include <iostream>
#include <fstream>

#include <tree.hpp>
#include <preprocessor.hpp>

int main(int argc, char ** argv) {
    if (argc < 2) {
        std::cout << "Not enough arguments!\n";
        return 1;
    }

    std::ifstream file(argv[1]);

    std::string raw_input = "";
    while (!file.eof()) {
        char read;
        if (!file.read(&read, sizeof(char))) break;
        raw_input += read;
    }

    std::string preprocessed;

    try {
        preprocessed = preprocess(raw_input);
    } catch(std::exception & e) { std::cout << e.what() << "\n"; return 1; }

    std::cout << preprocessed << "\n";

    return 0;
}
