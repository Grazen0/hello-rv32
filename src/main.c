float mat1[] = {3.0, 4.0, 7.0, 2.0, 5.0, 9.0};

float mat2[] = {3.0, 1.0, 5.0, 6.0, 9.0, 7.0};

float dest[3 * 3];

extern void matmul(float *mat1, float *mat2, int m, int n, int p, float *dest);

void main(void)
{
    matmul(mat1, mat2, 3, 2, 3, dest);
}
