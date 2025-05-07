#include <stdio.h>

void access_array(int index) {
    int array[5] = {10, 20, 30, 40, 50};
    if (index < 0 || index >= 5) {
        printf("Index out of bounds!\n");
        return;
    }
    printf("Value at index %d: %d\n", index, array[index]);
}

int main() {
    int index = 0;
    printf("Enter the index you want to access: ");
    scanf("%d", &index);
    access_array(index);
    return 0;
}