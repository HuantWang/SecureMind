#include <stdio.h>
#include <stdlib.h>

int *create_and_return_pointer() {
    int num = 42;  // num is a local variable
    return &num;   // Returning the address of a local variable
}

int main() {
    int *ptr = create_and_return_pointer();

    // Attempting to access memory that is no longer valid
    printf("Accessing invalid memory: %d\n", *ptr);

    return 0;
}