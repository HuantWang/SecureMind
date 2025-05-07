#include <stdio.h>
#include <stdlib.h>

void use_safe_pointer() {
    int *ptr = (int *)malloc(sizeof(int));  // Dynamically allocate memory
    if (ptr == NULL) {
        printf("Memory allocation failed.\n");
        return;
    }

    *ptr = 42;  // Assign a value
    printf("Value before free: %d\n", *ptr);

    free(ptr);  // Free the allocated memory
    ptr = NULL; // Set the pointer to NULL to prevent undefined behavior

    // Avoid dereferencing a freed pointer
    if (ptr != NULL) {
        printf("Value after free: %d\n", *ptr);
    } else {
        printf("Pointer is NULL. Avoiding dereference of freed memory.\n");
    }
}

int main() {
    use_safe_pointer();

    return 0;
}