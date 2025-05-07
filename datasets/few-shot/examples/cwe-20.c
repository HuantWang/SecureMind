#include <stdio.h>
#include <stdlib.h>

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
    scanf("%s", input);

    int age = atoi(input);
    process_age(age);

    return 0;
}