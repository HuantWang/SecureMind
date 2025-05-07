#include <stdio.h>
#include <stdlib.h>

void free_memory_once() {
    int *ptr = (int *)malloc(sizeof(int));
    if (ptr == NULL) {
        printf("Memory allocation failed!\n");
        return;
    }

    *ptr = 42;
    printf("Value: %d\n", *ptr);

    free(ptr);
    printf("Memory freed successfully.\n");

    // Nullify the pointer after freeing to prevent double free
    ptr = NULL;

    // Avoid freeing memory twice by checking if the pointer is NULL
    if (ptr != NULL) {
        free(ptr);  // This block won't execute due to the NULL check
        printf("Attempting to free memory again (double free).\n");
    } else {
        printf("Skipping double free as pointer is already NULL.\n");
    }
}

int main() {
    free_memory_once();
    return 0;
}