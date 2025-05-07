#include <stdio.h>
#include <string.h>
#include <openssl/sha.h>

#define STORED_HASH "c56b731d2c8d07a6a2c45dcd1a4b6e91d5b850e761c8cb6e1eb6ef6c2e5a5385"  // SHA-256 of "Secure123"

// Function to compute SHA-256 hash of input
void compute_sha256(const char *input, char *output) {
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256((unsigned char *)input, strlen(input), hash);

    // Convert hash to hex string
    for (int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        sprintf(output + (i * 2), "%02x", hash[i]);
    }
}

// Secure authentication function
int authenticate(const char *input) {
    char input_hash[SHA256_DIGEST_LENGTH * 2 + 1] = {0};  // 64 characters + null terminator
    compute_sha256(input, input_hash);

    // Securely compare the hashed input with the stored hash
    return strcmp(input_hash, STORED_HASH) == 0;
}

int main() {
    char input[100];
    printf("Enter password: ");
    scanf("%99s", input);  // Limit input size to prevent buffer overflow

    if (authenticate(input)) {
        printf("Authentication successful! Access granted.\n");
    } else {
        printf("Authentication failed! Access denied.\n");
    }

    return 0;
}
