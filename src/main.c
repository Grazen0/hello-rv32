#include <stdint.h>

static uint32_t awesome[10] = {};

static uint32_t fib(const uint32_t n)
{
    if (n <= 1)
        return n;

    return fib(n - 1) + fib(n - 2);
}

int main(void)
{
    for (uint32_t i = 0; i < 10; ++i) {
        awesome[i] = fib(i);
    }

    return 0;
}
