#pragma once

#include "list.hpp"

template<typename T>
class Stack : protected List<T> {
public:
    template<typename... Args>
    inline T & emplace(Args&&... args) { return this->emplace_front(std::forward<Args>(args)...); }
    inline T & push(T & x) { return this->push_front(x); }
    inline T & push(T && x) { return this->push_front(std::move(x)); }
    inline typename List<T>::Deleter pop() { return this->pop_front(); }
    inline T & peek() { return this->front(); }
    
    inline bool empty() const noexcept { return List<T>::empty(); }
    inline std::size_t size() const noexcept { return List<T>::size(); }
};