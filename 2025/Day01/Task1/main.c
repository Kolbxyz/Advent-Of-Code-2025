// main.c
#include <stddef.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/stat.h>

int res = 0;
int ptr = 50;

// vars
int main(void)
{
    char *path = "./2025/Day01/Task1/input";
    char *line = NULL;
    size_t read_size = 0;

    FILE *f = fopen(path, "r");
    while (getline(&line, &read_size, f) > 0) {
        int direction = line[0] == 'R' ? 1 : -1;
        int max_step = atoi(&line[1]);

        for (int i = 0; i < max_step; ++i) {
            ptr += direction;
            if (ptr > 99 || ptr < 0)
                ptr = ptr > 99 ? 0 : 99;
        }
        res += ptr == 0 ? 1 : 0;
    }
    printf("%d\n", res);
}
