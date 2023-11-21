#pragma once

#include <string>
#include <iostream>
#include <exception>

#include "queue.hpp"
#include "stack.hpp"
#include "tree.hpp"
#include "util.hpp"

template<typename T>
class ArithmaticExpression {
protected:
    class InvalidInfixExpressionException : public std::exception {
        const char * what() const noexcept override { return "Invalid infix string"; }
    };

    enum token_type_t { TOKEN_CONSTANT, TOKEN_VARIABLE, TOKEN_OPERATOR };
    enum operator_t { ADD, SUB, MULT, DIV, OPAREN, CPAREN };
    struct token_t {
        token_type_t type;
        
        T constant;
        std::string variable;
        operator_t op;
        
        inline token_t(): token_t(0) { }
        inline token_t(T _): type(TOKEN_CONSTANT), constant(_) { }
        inline token_t(std::string _): type(TOKEN_VARIABLE), variable(_) { }
        inline token_t(operator_t _): type(TOKEN_OPERATOR), op(_) { }

        inline token_t(token_t & x): type(x.type) {
            switch (x.type) {
                case TOKEN_CONSTANT: constant = x.constant; break;
                case TOKEN_VARIABLE: variable = x.variable; break;
                case TOKEN_OPERATOR: op = x.op; break;
            }
        }
        inline token_t(token_t && x): type(x.type) {
            switch (x.type) {
                case TOKEN_CONSTANT: constant = x.constant; break;
                case TOKEN_VARIABLE: variable = x.variable; break;
                case TOKEN_OPERATOR: op = x.op; break;
            }
        }

        inline token_t & operator=(token_t && x) {
            switch (x.type) {
                case TOKEN_CONSTANT: constant = x.constant; break;
                case TOKEN_VARIABLE: variable = x.variable; break;
                case TOKEN_OPERATOR: op = x.op; break;
            }
            type = x.type;
            return *this;
        }

        inline ~token_t() { }

        std::string to_string() {
            switch (type) {
                case TOKEN_CONSTANT: return std::to_string(constant);
                case TOKEN_VARIABLE: return variable;
                case TOKEN_OPERATOR: return operator_string(op);
                default: return "Unknown";
            }
        }
    };

    static inline int precedence(operator_t op) {
        switch (op) {
            case ADD: case SUB: return 1;
            case MULT: case DIV: return 2;
            case OPAREN: case CPAREN: return 0;
            default: throw InvalidInfixExpressionException();
        }
    }

    static inline T apply_operator(operator_t op, T v1, T v2) {
        switch (op) {
            case ADD: return v1 + v2;
            case SUB: return v1 - v2;
            case MULT: return v1 * v2;
            case DIV: return v1 / v2;
            default: return 0;
        }
    }

    static inline const char * operator_string(operator_t op) {
        switch (op) {
            case ADD: return "+";
            case SUB: return "-";
            case MULT: return "*";
            case DIV: return "/";
            case OPAREN: return "(";
            case CPAREN: return ")";
            default: return "#";
        }
    }

    void print_tree(Tree<token_t> & tree, int indent = 0) {
        for (int i = 0; i < indent; i++) std::cout << "  ";
        std::cout << tree.data().to_string() << "\n";
        for (int i = 0; i < indent; i++) std::cout << "  ";
        if (&tree.left() != nullptr) {
            print_tree(tree.left(), indent + 1);
            std::cout << '\n';
        }
        for (int i = 0; i < indent; i++) std::cout << "  ";
        if (&tree.right() != nullptr) {
            print_tree(tree.right(), indent + 1);
            std::cout << '\n';
        }
    }

    Tree<token_t> expression;

public:
    inline ArithmaticExpression(const char * str) {
        Queue<token_t> tokens;

        for (int i = 0; str[i] != '\0'; i++) {
            if (in_range(str[i], '0', '9')) {
                std::string num_str = "";
                for (; in_range(str[i], '0', '9'); i++) {
                    num_str += str[i];
                }
                tokens.emplace(std::stoi(num_str));
                i--;
            } else switch (str[i]) {
                case ' ': break;

                case '+': tokens.emplace(ADD); break;
                case '-': tokens.emplace(SUB); break;
                case '*': tokens.emplace(MULT); break;
                case '/': tokens.emplace(DIV); break;
                case '(': tokens.emplace(OPAREN); break;
                case ')': tokens.emplace(CPAREN); break;
                default: {
                    if (in_range(str[i], 'A', 'Z') || in_range(str[i], 'a', 'z')) {
                        std::string name = "";
                        for (; in_range(str[i], 'A', 'Z') || in_range(str[i], 'a', 'z') || in_range(str[i], '0', '9'); i++) name += str[i];
                        tokens.emplace(name);
                        i--;
                    } else throw InvalidInfixExpressionException();
                } break;
            }
        }

        Stack<Tree<token_t>> values;
        Stack<token_t> operators;

        while (!tokens.empty()) {
            auto token = tokens.pop();

            if (token->type == TOKEN_OPERATOR) {
                if (token->op == OPAREN) operators.emplace(OPAREN);
                else if (token->op == CPAREN) {
                    while (operators.peek().op != OPAREN) {
                        auto op = operators.pop();
                        auto v1 = values.pop();
                        auto v2 = values.pop();
                        // generate a tree
                        Tree<token_t> temp((token_t &) op);
                        temp.add(std::move((Tree<token_t> &) v1));
                        temp.add(std::move((Tree<token_t> &) v2));
                        values.push(std::move(temp));
                    }
                    operators.pop();
                }
                else {
                    operator_t this_op = token->op;

                    while (!operators.empty() && precedence(operators.peek().op) >= precedence(this_op)) {
                        auto op = operators.pop();
                        auto v1 = values.pop();
                        auto v2 = values.pop();
                        // generate a tree
                        Tree<token_t> temp((token_t &) op);
                        temp.add(std::move((Tree<token_t> &) v1));
                        temp.add(std::move((Tree<token_t> &) v2));
                        values.push(std::move(temp));
                    }

                    operators.emplace(this_op);
                }
            }
            else {
                values.emplace((token_t &) token);
            }
        }

        while (!operators.empty()) {
            auto op = operators.pop();
            auto v1 = values.pop();
            auto v2 = values.pop();
            // generate a tree
            Tree<token_t> temp((token_t &) op);
            temp.add(std::move((Tree<token_t> &) v1));
            temp.add(std::move((Tree<token_t> &) v2));
            values.push(std::move(temp));
        }

        expression = std::move(values.pop().data());
    }

protected:
    static inline void simplify_recur(Tree<token_t> & tree) {
        if (tree.has_left() && tree.has_right()) {
            simplify_recur(tree.left());
            simplify_recur(tree.right());

            if (tree.left().data().type == TOKEN_CONSTANT && tree.right().data().type == TOKEN_CONSTANT) {
                tree.data() = std::move(token_t(apply_operator(tree.data().op, tree.right().data().constant, tree.left().data().constant)));
                tree.destroy_left();
                tree.destroy_right();
            }
        }
    }

    static inline std::string to_asm_recur(Tree<token_t> & tree) {
        if (tree.has_left() && tree.has_right()) {
            std::string str;

            str += to_asm_recur(tree.left()) + "\n";
            str += to_asm_recur(tree.right()) + "\n";

            if (tree.left().data().type == TOKEN_VARIABLE && tree.right().data().type == TOKEN_VARIABLE) throw std::runtime_error("Unable to evaluate expression safely");

            if (tree.data().op == MULT || tree.data().op == DIV) throw std::runtime_error("Unable to evaluate '*' or '/' operators");

            switch (tree.data().op) {
                case ADD: {
                    if (tree.left().data().type == TOKEN_VARIABLE) str += std::string("adi ") + tree.left().data().variable + ", " + std::to_string(tree.right().data().constant) + "\n";
                    else str += std::string("adi ") + tree.right().data().variable + ", " + std::to_string(tree.left().data().constant) + "\n";
                } break;
                case SUB: {

                } break;
            }

            return str;
        }
        else return "";
    }

public:
    inline void simplify() {
        simplify_recur(expression);

        std::cout << "Output: \n";
        print_tree(expression); std::cout << '\n';
    }

    inline std::string to_asm() {
        return to_asm_recur(expression);
    }
};