#include <iostream>
#include <vector>

struct Bob {
public:
    const std::vector<uint32_t> vec;

    Bob(int n):
      vec(n) { }

    const std::vector<uint32_t> & get_vec() {
        return vec;
    }
};

int main() {
    Bob bob(1000);

    std::cout << bob.get_vec()[4] << "\n";

    return 0;
}
