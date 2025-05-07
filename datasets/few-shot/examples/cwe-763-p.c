#include <iostream>

void release_invalid_pointer_fixed() {
    int *ptr = new int(42);  // Dynamically allocate memory
    // Safe deletion logic: Prevent double-delete by setting the pointer to nullptr after deletion
    if (ptr) {
        delete ptr;          // Properly release memory
        ptr = nullptr;       // Set pointer to nullptr to prevent further deletions
    }

    // Safe: Deleting a nullptr is a no-op, so this will not cause any issue
    if (ptr) {
        delete ptr;
    }
}

int main() {
    release_invalid_pointer_fixed();
    return 0;
}