#include <stdio.h>
#include <string.h>

void copy_data(char *src) {
    char buffer[10];
    strcpy(buffer, src);
    printf("Buffer contains: %s\n", buffer);
}

int main() {
    char input[100];
    printf("Enter text: ");
    gets(input);
    copy_data(input);
    return 0;
}