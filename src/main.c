#include <stdint.h>

#define AWESOME ((volatile uint32_t *)0x8000'0000)

static uint32_t fib(const uint32_t n)
{
    uint32_t a = 0;
    uint32_t b = 1;

    for (uint32_t i = 0; i < n; ++i) {
        const uint32_t tmp = a + b;
        a = b;
        b = tmp;
    }

    return a;
}

void main(void)
{
    for (uint32_t i = 0; i < 10; ++i) {
        uint32_t f = fib(i);
        AWESOME[i] = f;
    }
}
