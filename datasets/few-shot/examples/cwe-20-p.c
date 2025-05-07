#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int is_valid_number(const char *str) {
    for (int i = 0; i < strlen(str); i++) {
        if (!isdigit(str[i])) {
            return 0;  // Invalid input: contains non-numeric characters
        }
    }
    return 1;  // Valid numeric input
}

void process_age(int age) {
    if (age < 0) {
        printf("Invalid age entered!\n");
        return;
    }
    printf("Your age is: %d\n", age);
}

int main() {
    char input[10];
    printf("Enter your age: ");
    scanf("%9s", input);  // Limit input size to prevent buffer overflow

    if (!is_valid_number(input)) {
        printf("Error: Invalid input! Please enter a valid number.\n");
        return 1;
    }

    int age = atoi(input);
    process_age(age);

    return 0;
}
