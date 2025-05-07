#include <stdio.h>
#include <stdlib.h>

void free_memory_twice() {
    int *ptr = (int *)malloc(sizeof(int));
    if (ptr == NULL) {
        printf("Memory allocation failed!\n");
        return;
    }

    *ptr = 42;
    printf("Value: %d\n", *ptr);

    free(ptr);
    printf("Memory freed successfully.\n");

    free(ptr);
    printf("Attempting to free memory again (double free).\n");
}

int main() {
    free_memory_twice();
    return 0;
}