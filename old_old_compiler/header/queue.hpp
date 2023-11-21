#pragma once

#include "list.hpp"

template<typename T>
class Queue : protected List<T> {
public:
    template<typename... Args>
    inline T & emplace(Args&&... args) { return this->template emplace_front<Args...>(std::forward<Args>(args)...); }
    inline T & push(T && x) { return this->push_front(std::move(x)); }
    inline T & push(T & x) { return this->push_front(x); }
    inline typename List<T>::Deleter pop() { return this->pop_back(); }
    inline T & peek() { return this->back(); }

    inline bool empty() const noexcept { return List<T>::empty(); }
    inline std::size_t size() const noexcept { return List<T>::size(); }
};