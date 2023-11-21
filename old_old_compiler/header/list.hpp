#pragma once

#include <algorithm>
#include <exception>

template<typename T>
class List {
protected:
    class ValueError : public std::exception {
        const char * what() const noexcept override { return "Value Error"; }
    };

    struct NodeBase {
        NodeBase * next;
        NodeBase * prev;

        NodeBase(NodeBase * _next, NodeBase * _prev): next(_next), prev(_prev) { }
    };
    struct Node : public NodeBase {
        T data;

        template<typename... Args> Node(NodeBase * _next, NodeBase * _prev, Args&&... args): NodeBase(_next, _prev), data(std::forward<Args>(args)...) { }
        Node(NodeBase * _next, NodeBase * _prev, T & _data): NodeBase(_next, _prev), data(_data) { }
        Node(NodeBase * _next, NodeBase * _prev, T && _data): NodeBase(_next, _prev), data(std::move(_data)) { }
    };

    NodeBase head;
    NodeBase tail;

    class Iterator {
    protected:
        NodeBase * node;

    public:
        inline Iterator(NodeBase * _node): node(_node) { }

        inline T & next() {
            node = node->next;
            return ((Node *) node)->data;
        }

        inline bool operator==(Iterator other) { return node == other.node; }
        inline bool operator!=(Iterator other) { return node != other.node; }
    };

    class Deleter : public Iterator {
    public:
        inline Deleter(NodeBase * _node): Iterator(_node) { }
        inline ~Deleter() { delete this->node; }
        inline Deleter(Deleter &) = delete;
        inline Deleter(Deleter && x): Iterator(x.node) { x.node = nullptr; }

        inline T & next() = delete;
        inline operator T &() { return ((Node *) this->node)->data; }
        inline T * operator->() { return &((Node *) this->node)->data; }
        inline T & data() { return ((Node *) this->node)->data; }
    };

public:
    inline List(): head(&tail, nullptr), tail(nullptr, &head) { }
    inline ~List() {
        NodeBase * node = head.next;
        while (node != &tail) {
            Node * temp = (Node *) node;
            node = node->next;
            delete temp;
        }
    }
    inline List(List &) = delete;
    inline List(List && x): head(x.head.next, nullptr), tail(nullptr, x.tail.prev) {
        if (x.head.next == &x.tail) head.next = &tail;
        else {
            x.head.next->prev = &head;
            x.head.next = &x.tail;
        }
        if (x.tail.prev == &x.head) tail.prev = &head;
        else {
            x.tail.prev->next = &tail;
            x.tail.prev = &x.head;
        }
    }

    inline T & push_front(T & value) {
        Node * temp = new Node(head.next, &head, value);
        head.next->prev = temp;
        head.next = temp;
        return temp->data;
    }
    inline T & push_front(T && value) {
        Node * temp = new Node(head.next, &head, std::move(value));
        head.next->prev = temp;
        head.next = temp;
        return temp->data;
    }
    template<typename... Args>
    inline T & emplace_front(Args&&... args) {
        Node * temp = new Node(head.next, &head, std::forward<Args>(args)...);
        head.next->prev = temp;
        head.next = temp;
        return temp->data;
    }

    inline Deleter pop_front() {
        if (empty()) throw ValueError();
        Node * temp = (Node *) head.next;
        temp->next->prev = &head;
        head.next = temp->next;
        return Deleter(temp);
    }
    inline Deleter pop_back() {
        if (empty()) throw ValueError();
        Node * temp = (Node *) tail.prev;
        temp->prev->next = &tail;
        tail.prev = temp->prev;
        return Deleter(temp);
    }

    inline Iterator begin() { return Iterator(&head); }
    inline Iterator end() { return Iterator(tail.prev); }

    inline T & front() { return ((Node *) head.next)->data; }
    inline T & back() { return ((Node *) tail.prev)->data; }

    inline bool empty() const noexcept { return head.next == &tail; }
    inline std::size_t size() const noexcept {
        std::size_t i = 0;
        for (NodeBase * node = head.next; node != &tail; i++) {
            node = node->next;
        }
        return i;
    }
};