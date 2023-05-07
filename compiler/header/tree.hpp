#pragma once

#include <vector>

template<typename T>
class Tree {
public:
    T value;

    std::vector<Tree *> branches;

    Tree(T _value):
      value(_value) { }

    ~Tree() {
        for (int i = 0; i < branches.size(); i++) delete branches[i];
    }

    Tree & add(T _value) {
        Tree * temp = new Tree(_value);
        branches.push_back(temp);
        return *temp;
    }
    Tree & add() {
        Tree * temp = new Tree();
        branches.push_back(temp);
        return *temp;
    }
};