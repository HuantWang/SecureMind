#include <stdio.h>
#include <stdlib.h>

void use_expired_pointer() {
    int *ptr = (int *)malloc(sizeof(int));  // Dynamically allocate memory
    if (ptr == NULL) {
        printf("Memory allocation failed.\n");
        return;
    }

    *ptr = 42;  // Assign a value
    printf("Value before free: %d\n", *ptr);

    free(ptr);  // Free the allocated memory

    // Dereferencing a pointer after the memory has been freed
    printf("Value after free (undefined behavior): %d\n", *ptr);
}

int main() {
    use_expired_pointer();

    return 0;
}