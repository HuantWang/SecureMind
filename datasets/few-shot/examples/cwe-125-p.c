#include <stdio.h>

void access_array_safe(int index) {
    int array[5] = {10, 20, 30, 40, 50};

    // Ensure the index remains within valid bounds
    if (index < 0 || index >= 5) {
        printf("Index out of bounds! Valid range is 0 to 4.\n");
        return;
    }

    printf("Value at index %d: %d\n", index, array[index]);
}

int main() {
    int index = 0;

    printf("Enter the index you want to access: ");
    // Validate user input to ensure it's an integer and within bounds
    if (scanf("%d", &index) != 1) {
        printf("Invalid input! Please enter a valid integer.\n");
        return 1;
    }

    access_array_safe(index);
    return 0;
}