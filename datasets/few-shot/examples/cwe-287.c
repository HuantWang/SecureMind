#include <stdio.h>
#include <string.h>

#define PASSWORD "Secure123"

int authenticate(char *input) {
    if (input == NULL) {
        return 0;
    }

    if (strncmp(input, PASSWORD, strlen(PASSWORD)) == 0) {
        return 1;
    }
    return 0;
}

int main() {
    char input[20];
    printf("Enter password: ");
    scanf("%19s", input);

    if (authenticate(input)) {
        printf("Authentication successful! Access granted.\n");
    } else {
        printf("Authentication failed! Access denied.\n");
    }

    return 0;
}
