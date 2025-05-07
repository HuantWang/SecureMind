#include <iostream>

void release_invalid_pointer() {
    int *ptr = new int(42);   // Dynamically allocate memory
    delete ptr;               // Properly release memory
    delete ptr;               // Release the same memory again (double delete)
}

int main() {
    try {
        release_invalid_pointer();
    } catch (...) {
        std::cout << "Exception occurred!\n";
    }
    return 0;
}