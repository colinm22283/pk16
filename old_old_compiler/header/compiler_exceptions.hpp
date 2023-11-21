#pragma once

#include <exception>

namespace Exceptions {
    class FileOpenException : public std::exception {
    protected: std::string error_str;
    public:
        FileOpenException(std::string && file_path): error_str(std::string("Unable to open file with path \"") + std::move(file_path) + "\".") { }
        const char * what() const noexcept override { return error_str.c_str(); }
    };

    class UnknownTypeException : public std::exception {
    protected: std::string error_str;
    public:
        UnknownTypeException(std::string && name): error_str(std::string("Unable to find type with name \"") + std::move(name) + "\".") { }
        const char * what() const noexcept override { return error_str.c_str(); }
    };
};