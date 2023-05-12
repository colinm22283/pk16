#pragma once

#include <exception>

class UnknownPreProcKeyword : public std::exception {
    [[nodiscard]] const char * what() const _GLIBCXX_TXN_SAFE_DYN _GLIBCXX_NOTHROW override { return "Unknown preprocessor keyword"; }
};