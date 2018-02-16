#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if(argc != 2) {
        printf("Please enter exactly two arguments.\n");
        return -1;
    }

    int max_number = atoi(argv[1]);

    for(int i = 1; i < max_number; i++) {
        if(i % 3 == 0) {
            printf("Fizz");
        }
        if(i % 5 == 0) {
            printf("Buzz");
        }
        printf("\n");
    }

    return 0;
}
