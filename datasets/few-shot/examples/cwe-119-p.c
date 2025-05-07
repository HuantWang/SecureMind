#include <stdio.h>
#include <string.h>

void copy_data_safe(char *src) {
    char buffer[10];

    // Limit the input copy to the size of the buffer with null-termination
    strncpy(buffer, src, sizeof(buffer) - 1);
    buffer[sizeof(buffer) - 1] = '\0';  // Ensure null-termination

    printf("Buffer contains: %s\n", buffer);
}

int main() {
    char input[100];
    printf("Enter text (up to 99 characters): ");

    // Use fgets to safely read input and avoid buffer overflow
    if (fgets(input, sizeof(input), stdin) != NULL) {
        // Remove any trailing newline character from fgets
        size_t len = strlen(input);
        if (len > 0 && input[len - 1] == '\n') {
            input[len - 1] = '\0';
        }
        copy_data_safe(input);
    }

    return 0;
}