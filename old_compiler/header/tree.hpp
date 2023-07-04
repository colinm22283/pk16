#pragma once

#include <algorithm>

template<typename T>
class Tree {
protected:
    T _data;
    Tree * _left = nullptr;
    Tree * _right = nullptr;

public:
    inline Tree(): _data(), _left(nullptr), _right(nullptr) { }
    inline Tree(T & _data_): _data(_data_){ }
    inline Tree(T && _data_): _data(std::move(_data_)) { }
    inline ~Tree() {
        delete _left;
        delete _right;
    }

    inline Tree(Tree &) = delete;
    inline Tree(Tree && x): _data(std::move(x._data)), _left(x._left), _right(x._right) {
        x._left = nullptr;
        x._right = nullptr;
    }
    inline Tree & operator=(Tree &) = delete;
    inline Tree & operator=(Tree && x) {
        _data = std::move(x._data);
        _left = x._left;
        _right = x._right;
        x._left = nullptr;
        x._right = nullptr;
        return *this;
    }
    
    inline T & data() noexcept { return _data; }
    inline Tree & left() const noexcept { return *_left; }
    inline Tree & right() const noexcept { return *_right; }
    inline bool has_left() const noexcept { return _left != nullptr; }
    inline bool has_right() const noexcept { return _right != nullptr; }
    inline void destroy_left() { delete _left; _left = nullptr; }
    inline void destroy_right() { delete _right; _right = nullptr; }

    inline Tree & add(T & x) noexcept {
        if (!_left) return *(_left = new Tree(x));
        if (!_right) return *(_right = new Tree(x));
        return *this;
    }
    inline Tree & add(T && x) noexcept {
        if (!_left) return *(_left = new Tree(std::move(x)));
        if (!_right) return *(_right = new Tree(std::move(x)));
        return *this;
    }
    inline Tree & add(Tree<T> && x) noexcept {
        if (!_left) return *(_left = new Tree(std::move(x)));
        if (!_right) return *(_right = new Tree(std::move(x)));
        return *this;
    }
};