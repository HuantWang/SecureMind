#include <stdio.h>
#include <stdlib.h>

int *create_and_return_pointer_fixed() {
    // Allocate memory on the heap to ensure validity beyond the function scope
    int *num = (int *)malloc(sizeof(int));
    if (num == NULL) {
        printf("Memory allocation failed!\n");
        return NULL;
    }

    *num = 42;  // Assign the value
    return num; // Returning a pointer to heap-allocated memory
}

int main() {
    int *ptr = create_and_return_pointer_fixed();

    // Ensure the pointer is valid before accessing
    if (ptr != NULL) {
        printf("Accessing valid memory: %d\n", *ptr);

        // Free the memory to avoid memory leaks
        free(ptr);
    } else {
        printf("Failed to allocate memory.\n");
    }

    return 0;
}